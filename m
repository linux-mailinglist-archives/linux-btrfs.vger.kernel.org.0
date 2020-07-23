Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4722B128
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgGWOVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 10:21:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgGWOVJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 10:21:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74FABAB76;
        Thu, 23 Jul 2020 14:21:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16555DA794; Thu, 23 Jul 2020 16:20:41 +0200 (CEST)
Date:   Thu, 23 Jul 2020 16:20:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of
 %llu
Message-ID: <20200723142041.GD3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200722160722.8641-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722160722.8641-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 12:07:22PM -0400, Josef Bacik wrote:
> I'm a actual human being so am incapable of converting u64 to s64 in my
> head, use %lld so we can see the negative number in order to identify
> which of our special roots we leaked.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f1fdbdd44c02..cc4081a1c7f9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1508,7 +1508,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
>  	while (!list_empty(&fs_info->allocated_roots)) {
>  		root = list_first_entry(&fs_info->allocated_roots,
>  					struct btrfs_root, leak_list);
> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
> +		btrfs_err(fs_info, "leaked root %lld-%llu refcount %d",

But this is wrong in another way, roots with high numbers will appear as
negative numbers.
