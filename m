Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A52661ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgIKPPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 11:15:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgIKPNt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 11:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1754AD33;
        Fri, 11 Sep 2020 14:51:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62E83DA87D; Fri, 11 Sep 2020 16:50:13 +0200 (CEST)
Date:   Fri, 11 Sep 2020 16:50:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: improve error message in
 setup_items_for_insert
Message-ID: <20200911145012.GS18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901144001.4265-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 01, 2020 at 05:40:01PM +0300, Nikolay Borisov wrote:
> While at it also print the leaf content after the error.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bb89c0954ca1..2c3f78cc6aa2 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4799,9 +4799,9 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
>  		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
>  
>  		if (old_data < data_end) {
> -			btrfs_print_leaf(leaf);
> -			btrfs_crit(fs_info, "slot %d old_data %d data_end %d",
> +			btrfs_crit(fs_info, "item's (slot %d) data offset (%d) beyond data end of leaf (%d)",
>  				   slot, old_data, data_end);

I've changed it to

"item at slot %d with data offset %u beyond data end of leaf %u"

as we don't use the ( ) elsewhere. The formats were mismatching old_data
and data_end, so they're now %u.

> +			btrfs_print_leaf(leaf);

The leaf is dumped as before, so the changelog got updated too.
