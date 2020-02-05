Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AE153364
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgBEOwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:52:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:37790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBEOwt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 09:52:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64458B034;
        Wed,  5 Feb 2020 14:52:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D11AEDA7E6; Wed,  5 Feb 2020 15:52:35 +0100 (CET)
Date:   Wed, 5 Feb 2020 15:52:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 22/44] btrfs: hold a ref on the root in prepare_to_merge
Message-ID: <20200205145235.GO2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-23-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-23-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:39AM -0500, Josef Bacik wrote:
> We look up the reloc roots corresponding root, we need to hold a ref on
> that root.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 990595a27a15..53df57b59bc3 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2474,6 +2474,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
>  		list_del_init(&reloc_root->root_list);
>  
>  		root = read_fs_root(fs_info, reloc_root->root_key.offset);
> +		if (!btrfs_grab_fs_root(root))
> +			BUG();
>  		BUG_ON(IS_ERR(root));

These two should be swapped, first the root is "checked" if it's
valid, then the reference can be grabbed. The code is later pushed into
the other helper and there it's in the right order so it's only
temporary.

>  		BUG_ON(root->reloc_root != reloc_root);
>  
