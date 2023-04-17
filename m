Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0516E5496
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDQWLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDQWLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 18:11:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4241035A0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 15:11:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45F9E219FB;
        Mon, 17 Apr 2023 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681769502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEjF5YsNzE01CgZeWwruAzCgYn068dzPCk0dj3IyziU=;
        b=gWYBDQR8kG0CBOTRwxg6O63iWq2cpq8S236+MSvJhTTYwLU6YHp4ut+k1PZ0mNYSo7T895
        MCqOWCBkIOYucMP8fUZ27nWIEie+993LEzrcVRVCj+Rd6urZNu4WFu9CC7Eb0P6JsnsGsm
        1GqAYjf0//xI82P3AN9PznzTfkq3W4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681769502;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEjF5YsNzE01CgZeWwruAzCgYn068dzPCk0dj3IyziU=;
        b=L9dINf3LY1Ii6tmtFzglrIdHFxpC56ZEF7jdxB1NaEybSfg0dbxFmKO1mNAPzamogS1V66
        ppwQJwVjG86YpjDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 246B41390E;
        Mon, 17 Apr 2023 22:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XWseCB7EPWSedQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Apr 2023 22:11:42 +0000
Date:   Tue, 18 Apr 2023 00:11:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: dev-replace: error out if we have unrepaired
 metadata error during
Message-ID: <20230417221133.GN19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
> [FIX]
> Instead of continue the replace, just error out if we hit an unrepaired
> metadata sector.
> 
> Now the dev-replace would be rejected with -EIO, to inform the user.
> Although it also means, the fs has some metadata error which can not be
> repaired, the user would be super upset anyway.
> 
> The new dmesg would look like this:
> 
>  BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
>  BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>  BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>  BTRFS error (device dm-4): unable to fixup (regular) error at logical 5570560 on dev /dev/mapper/test-scratch1 physical 5570560
>  BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
>  BTRFS warning (device dm-4): header error at logical 5570560 on dev /dev/mapper/test-scratch1, physical 5570560: metadata leaf (level 0) in tree 5
>  BTRFS error (device dm-4): stripe 5570560 has unrepaired metadata sector at 5578752
>  BTRFS error (device dm-4): btrfs_scrub_dev(/dev/mapper/test-scratch1, 1, /dev/mapper/test-scratch2) failed -5
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Where is this patch supposed to be applied? I tried the 6.3 base and
misc-next but both have several conflicts. The other scrub patches
https://lore.kernel.org/linux-btrfs/cover.1681364951.git.wqu@suse.com/
also don't apply either separately or on top of this patch.
