Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0B775BC9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 13:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjHILVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjHILVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 07:21:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AB19A1
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 04:21:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B61241F38C;
        Wed,  9 Aug 2023 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691580059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfEIiwEzy+YNuKXNV/66TbEToKQOtvQwmiEC3osd9mA=;
        b=KJj0m7zmjXrJqeQH8ejm80EMo39SaOG/loBZeC9LY0G3kkZWF/4EUBvx5HXtWvVGxm7/iV
        OQMzgo1sqwZscQyuVV01DPC6qjzuCLnGy+E6i8fWoXdG/QFCv8KzKCXiw2v9nxSlSZGd2o
        tjM4+s5v+2hdrFUAVd3ZccleD89f7ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691580059;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfEIiwEzy+YNuKXNV/66TbEToKQOtvQwmiEC3osd9mA=;
        b=EU5+AMc5eeNhQPp59bj0Gs084AUaNI8iuldhDQUc/sHip6CPdRsDiRS7RJQ/UwlpjB4xJ4
        mFfHu3RQueykZSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A089113251;
        Wed,  9 Aug 2023 11:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H7xkJpt202TcSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 11:20:59 +0000
Date:   Wed, 9 Aug 2023 13:20:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Message-ID: <ZNN2muT7ONRWvn1c@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Inside function update_inline_extent_backref(), we have several
> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
> filesystem.
> 
> [ANAYLYSE]
> Most of those BUG_ON()s and ASSERT()s are just a way of handling
> unexpected on-disk data.
> 
> Although we have tree-checker to rule out obviously incorrect extent
> tree blocks, it's not enough for those ones.
> 
> Thus we need proper error handling for them.
> 
> [FIX]
> Thankfully all the callers of update_inline_extent_backref() would
> eventually handle the errror by aborting the current transaction.
> 
> So this patch would do the proper error handling by:
> 
> - Make update_inline_extent_backref() to return int
>   The return value would be either 0 or -EUCLEAN.
> 
> - Replace BUG_ON()s and ASSERT()s with proper error handling
>   This includes:
>   * Dump the bad extent tree leaf
>   * Output an error message for the cause
>     This would include the extent bytenr, num_bytes (if needed),
>     the bad values and expected good values.
>   * Return -EUCLEAN
> 
>   Note here we remove all the WARN_ON()s, as eventually the transaction
>   would be aborted, thus a backtrace would be triggered anyway.
> 
> - Better comments on why we expect refs == 1 and refs_to_mode == -1 for
>   tree blocks
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Is this fix for syzbot report
https://lore.kernel.org/linux-btrfs/000000000000287928060275b914@google.com/
?
