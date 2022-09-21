Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD255BFC02
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIUKIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUKIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 06:08:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6C786F0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 03:08:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FFD221B3E;
        Wed, 21 Sep 2022 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663754900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtIZoNt/wwQzZOJB+l3kdLY2i4SwSi0hqQb3Kim4P74=;
        b=SMYO01R14PPjFsrBYNvyrMpgVQt2ikSXibiiMvQF3F+pZG6aODYOVtG+pimKiLgV71l2x7
        qyBErOw72Bp5c92TGTBLYLSe1ITXvP3q81oV0KvNO7RSOVHKHZpPjF0cYPI6ey93tfxvvE
        moJYlbFmh1Or0+JzTnlxB5d/uzXFAs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663754900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtIZoNt/wwQzZOJB+l3kdLY2i4SwSi0hqQb3Kim4P74=;
        b=F/9QXeqVmhe002+H+/KkC+ZIbvXUbe7pW+1GpcA6ztaEOQ6v/+7ELRNdS3FREJD0S6NAYx
        zSMxjePw1CIuqUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07D7613A00;
        Wed, 21 Sep 2022 10:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OXYAJTiKmMIWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 10:08:20 +0000
Date:   Wed, 21 Sep 2022 12:02:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: loosen the block-group-tree feature dependency
 check
Message-ID: <20220921100248.GD32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 01:44:37PM +0800, Qu Wenruo wrote:
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> +{
> +	struct btrfs_super_block *disk_super = fs_info->super_copy;
> +	u64 incompat = btrfs_super_incompat_flags(disk_super);
> +	u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
> +
> +	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
> +		btrfs_err(fs_info,
> +		    "cannot mount because of unsupported optional features (0x%llx)",

I've reworded this as "cannot mount because of unknown incompat features
(0x%llx)"

> +		    incompat);
> +		return -EINVAL;
> +	}
> +
> +	/* Runtime limitation for mixed block groups. */
> +	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> +	    (fs_info->sectorsize != fs_info->nodesize)) {
> +		btrfs_err(fs_info,
> +"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
> +			fs_info->nodesize, fs_info->sectorsize);
> +		return -EINVAL;
> +	}
> +
> +	/* Mixed backref is an always-enabled feature. */
> +	incompat |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> +
> +	/* Set compression related flags just in case. */
> +	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> +	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> +
> +	/*
> +	 * An ancient flag, which should really be marked deprecated.
> +	 * Such runtime limitation doesn't really need a incompat flag.
> +	 */
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +
> +	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +	"cannot mount read-write because of unsupported optional features (0x%llx)",

and "cannot mount read-write because of unknown compat_ro features
(0x%llx)"

so it can be matched agains the incompat and compat_ro fields eg. in the
super block dump.
