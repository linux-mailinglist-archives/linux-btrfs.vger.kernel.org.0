Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED57C29DB26
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 00:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbgJ1Xna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 19:43:30 -0400
Received: from mail.itouring.de ([85.10.202.141]:37996 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbgJ1Wv3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:51:29 -0400
Received: from tux.applied-asynchrony.com (p5b07e9c2.dip0.t-ipconnect.de [91.7.233.194])
        by mail.itouring.de (Postfix) with ESMTPSA id 37E94CC304D;
        Wed, 28 Oct 2020 23:51:27 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 097C6F015C5;
        Wed, 28 Oct 2020 23:51:27 +0100 (CET)
Subject: Re: [PATCH 5/5] btrfs: restart snapshot delete if we have to end the
 transaction
To:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
 <20200320183436.16908-6-josef@toxicpanda.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <d39af029-3227-d435-4178-54ab56b07263@applied-asynchrony.com>
Date:   Wed, 28 Oct 2020 23:51:26 +0100
MIME-Version: 1.0
In-Reply-To: <20200320183436.16908-6-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-20 19:34, Josef Bacik wrote:
> This is to fully fix the deadlock described in
> 
> btrfs: do not resolve backrefs for roots that are being deleted
> 
> Holding write locks on our deleted snapshot across trans handles will
> just lead to sadness, and our backref lookup code is going to want to
> still process dropped snapshots for things like qgroup accounting.
> 
> Fix this by simply dropping our path before we restart our transaction,
> and picking back up from our drop_progress key.  This is less efficient
> obviously, but it also doesn't deadlock, so it feels like a reasonable
> trade off.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/extent-tree.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 2925b3ad77a1..bfb413747283 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5257,6 +5257,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   	 * already dropped.
>   	 */
>   	set_bit(BTRFS_ROOT_DELETING, &root->state);
> +again:
>   	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
>   		level = btrfs_header_level(root->node);
>   		path->nodes[level] = btrfs_lock_root_node(root);
> @@ -5269,7 +5270,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
>   		memcpy(&wc->update_progress, &key,
>   		       sizeof(wc->update_progress));
> +		memcpy(&wc->drop_progress, &key, sizeof(key));
>   
> +		wc->drop_level = root_item->drop_level;
>   		level = root_item->drop_level;
>   		BUG_ON(level == 0);
>   		path->lowest_level = level;
> @@ -5362,6 +5365,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   				goto out_end_trans;
>   			}
>   
> +			/*
> +			 * We used to keep the path open until we completed the
> +			 * snapshot delete.  However this can deadlock with
> +			 * things like backref walking that may want to resolve
> +			 * references that still point to this deleted root.  We
> +			 * already have the ability to restart snapshot
> +			 * deletions on mount, so just clear our walk_control,
> +			 * drop the path, and go to the beginning and re-lookup
> +			 * our drop_progress key and continue from there.
> +			 */
> +			memset(wc, 0, sizeof(*wc));
> +			btrfs_release_path(path);
>   			btrfs_end_transaction_throttle(trans);
>   			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
>   				btrfs_debug(fs_info,
> @@ -5377,6 +5392,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>   			}
>   			if (block_rsv)
>   				trans->block_rsv = block_rsv;
> +			goto again;
>   		}
>   	}
>   	btrfs_release_path(path);
> 

Josef,

the above fix still seems to be missing, apparently since Dave couldn't merge it
properly at the time (see [1]). Is this still needed? There were several long
discussions about balance loops and it would be great to get this fixed once and
for all. It applies and (seems to?) work fine in 5.9 (at least it hasn't eaten
anything here so far) but if it's not needed anymore then all the better.

thanks
Holger

[1] https://lore.kernel.org/linux-btrfs/20200320193927.GH12659@twin.jikos.cz/
