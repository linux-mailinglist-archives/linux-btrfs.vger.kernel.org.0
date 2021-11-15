Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FAE45238C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 02:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbhKPB1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 20:27:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51886 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbhKOS5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 13:57:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DBA11FD33;
        Mon, 15 Nov 2021 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637002469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22OHV/yWHHXraZ4TYh+FFGYlSVNPZ9xR27/6rG7oaGs=;
        b=XucogZXHfbr3t6idATLchWXuI3OnzbmnDJd4MAt+BsyCWlSmetkafQQmHrqAU7qIUKzBsa
        9rIwEHNnJcfmxxo+kWuhKrTaH/QOiPBcg3puie2GqGgWTtMJzNRMe+OasPetxB2BoYpLAU
        31xvKPRzhaqQiAcKrY2ZHE4YeIpFpso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637002469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22OHV/yWHHXraZ4TYh+FFGYlSVNPZ9xR27/6rG7oaGs=;
        b=R5ZZYa0tXBz1yFJCGgjSJLHxjnvM7uJrEvcEh1RGkp1/xSxYCVPr/oZ1UcVtaytrkIG/ef
        rMkCEg58k7m66LAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 52A15A3B83;
        Mon, 15 Nov 2021 18:54:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DC462DA781; Mon, 15 Nov 2021 19:54:25 +0100 (CET)
Date:   Mon, 15 Nov 2021 19:54:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 06/13] btrfs-progs: btrfs-shared: stop passing root to
 csum related functions
Message-ID: <20211115185425.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
 <86c147156b8146901f032d2862bf5dab3c32eaa0.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c147156b8146901f032d2862bf5dab3c32eaa0.1636574767.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 03:07:57PM -0500, Josef Bacik wrote:
> We are going to need to start looking up the csum root based on the
> bytenr with extent tree v2.  To that end stop passing the root to the
> csum related functions so that can be done in the helper functions
> themselves.
> 
> There's an unrelated deletion of a function prototype that no longer
> exists, if desired I can break that out from this patch.

I'd care namely about things that could break bisectability or are
completely unrelated.

> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2847,12 +2847,8 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
>  int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
>  				struct btrfs_root *root, u64 objectid,
>  				u64 offset, const char *buffer, size_t size);
> -int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
> -			  struct btrfs_root *root, u64 alloc_end,
> +int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 alloc_end,
>  			  u64 bytenr, char *data, size_t len);
> -int btrfs_csum_truncate(struct btrfs_trans_handle *trans,
> -			struct btrfs_root *root, struct btrfs_path *path,
> -			u64 isize);

Here it's touching the code near and is trivial, so mentioning it in the
changelog is fine.
