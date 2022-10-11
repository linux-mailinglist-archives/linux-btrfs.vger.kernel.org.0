Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777B5FB1EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKMCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKMCD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:02:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C1895CC
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 05:02:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EBA71FA41;
        Tue, 11 Oct 2022 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665489721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pslrI2AHBT/sT4riEIWqzL/Qr7z20mVpSdKBix4yM1I=;
        b=VU9oU3o59VuDr4e8aUOUNM1+teoDLUXHf+2qoL5E30LZJZTTiHexUj+hgJzP5SDz3ZCAJ3
        3gfrCvVYtsHhLv36tBoOv62hyaiN4dXbCsCKXrLsuOkm/MJLkB5ifiyWymCabYbPa3mJfE
        bDOnnj9j4r3o3OExcQfyWA6ffoTNSDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665489721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pslrI2AHBT/sT4riEIWqzL/Qr7z20mVpSdKBix4yM1I=;
        b=FjVygYdOCgHV6vn8ikYIfbj+ksDPFaRszf1DnVW0pamWJq6hmFaWkEopR4xlc7JmRnYPE1
        4Qd+KDV+dP0oI5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC305139ED;
        Tue, 11 Oct 2022 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RHZUNDhbRWMTRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 12:02:00 +0000
Date:   Tue, 11 Oct 2022 14:01:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/16] btrfs: move incompat and compat flag helpers to
 fs.c
Message-ID: <20221011120150.GQ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <3aeef7d866611a84296b74ff0ee7938351c58d88.1663175597.git.josef@toxicpanda.com>
 <20221011103327.GM13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011103327.GM13389@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 12:33:27PM +0200, David Sterba wrote:
> On Wed, Sep 14, 2022 at 01:18:13PM -0400, Josef Bacik wrote:
> > These helpers use functions not defined in fs.h, move them to fs.c to
> > keep the header clean.
> 
> This is one of the examples where functions are switched from inline to
> out-of-line, so I'll reply for all of them.
> 
> > +bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
> > +{
> > +	struct btrfs_super_block *disk_super;
> > +	disk_super = fs_info->super_copy;
> > +	return !!(btrfs_super_incompat_flags(disk_super) & flag);
> > +}
> 
> This needs a separate function and unlike for the inline it needs a
> call which has some impact on the instruction flow. This should be
> evaluated if the un-inlined function is on a hot path or not.
> 
> In this case I think the incompat bits should be inline as it's in many
> places part of switching access to some structures or lookup.
> 
> At minimum some numbers and assembly examination should be done before
> ding that. The header cleanup part is nice but if the changes have
> performance implications it's suddenly not so easy.
> 
> I'll do some analysis to get an idea how bad/good it is.

Not that good. When inlined it's basically

	mov memory, rax
	mov memory(rax), rax
	test 0x1, rax

while uninlined it's

	mov memory, rdi
	mov memory, rsi
	call
	test rax, rax

the function itself is 4 instructions but with some additional ones
compared to the inlined version (2).
