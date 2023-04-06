Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BE6D9E2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjDFRJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjDFRJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 13:09:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BA86B9
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 10:09:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1A5D1F7AB;
        Thu,  6 Apr 2023 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680800952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A758HP5vbxAS1REnc2kRo4uNtZ5iaejgRURllXJe9zs=;
        b=esdE1skmVurTispz9cgovjvMcSvjgHIi0kStlNYBd0D3vTl3rGk6ij+mpa2Pm9diSPM87v
        j4LmDLUYx3V8JDaFb0PXWq3sxHtRYD/ZaXE6mBwstNjg2PNfR42d1ZwS1K2f+TlAkgMr9S
        l8U0nFvxf9CooTvr3PjIN1sx83k/dPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680800952;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A758HP5vbxAS1REnc2kRo4uNtZ5iaejgRURllXJe9zs=;
        b=1XwNJLd3OJCuRi8k+tTE1QTrB3GT7To5tmVZbhDfVKB1gAxSRx8VcmIMF0RNlZzLj2YaOm
        dFA6jRN1+0fxPcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C37AE1351F;
        Thu,  6 Apr 2023 17:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bBoCL7j8LmQ2DAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 17:09:12 +0000
Date:   Thu, 6 Apr 2023 19:09:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: dev-replace: error out if we have unrepaired
 metadata error during
Message-ID: <20230406170909.GX19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 06, 2023 at 03:26:29PM +0800, Qu Wenruo wrote:
> [BUG]
> Even before the scrub rework, if we have some corrupted metadata failed
> to be repaired during replace, we still continue replace and let it
> finish just as there is nothing wrong:
> 
>  BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
>  BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>  BTRFS warning (device dm-4): tree block 5578752 mirror 0 has bad csum, has 0x00000000 want 0xade80ca1
>  BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>  BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>  BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>  BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad bytenr, has 0 want 5578752
>  BTRFS error (device dm-4): unable to fixup (regular) error at logical 5578752 on dev /dev/mapper/test-scratch1
>  BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 finished
> 
> This can lead to unexpected problems for the result fs.
> 
> [CAUSE]
> Btrfs reuses scrub code path for dev-replace to iterate all dev extents.
> 
> But unlike scrub, dev-replace doesn't really bother to check the scrub
> progress, which records all the errors found during replace.
> 
> And even if we checks the progress, we can not really determine which
> errors are minor, which are critical just by the plain numbers.
> (remember we don't treat metadata/data checksum error differently).
> 
> This behavior is there from the very beginning.

The code depends on the scrub rewrite, should we do a backport for <=6.3
kernels?
