Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05542403D9F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbhIHQf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:35:58 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:53825 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231666AbhIHQf5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 12:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1631118887;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=XdeS5EJu8rOP8KXydojC42LY4AkspbbuHCqdYLnqNmM=;
        b=EF86cySctTqrhQNSTDeuVpHp572t2e68dssJPAm8GpR/LjGgNmO0D0OBHvVYEM7T
        JgU1MjV4W67/g3elHJw9vwYgff04+OcwQa+fB47qWLK9PYBN9aclf3arxxP1lXPrPgd
        tM8CeNtRxPLC0YfGzyWjtP6qrerBAeraaQH+AGK8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1631118887;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=XdeS5EJu8rOP8KXydojC42LY4AkspbbuHCqdYLnqNmM=;
        b=Q+oc73jRg2VVO3vu41gRmCA1ofVcgsrWLsxBa/ty7HAGFuF2+frJmlm3XCPBBdsE
        +1/0Nwl4ievXHSR4gfeWniGC9BOlJlpMFb8P7OYJBss6oiny54mAzAAPXKiw4scfOmN
        s6dFu1bWuzJetcqoeXJBk67WxKE9X+npMhC82OnI=
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
Date:   Wed, 8 Sep 2021 16:34:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908135135.1474055-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.09.08-54.240.4.3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08.09.2021 15:51 Nikolay Borisov wrote:
> Currently when a read-only snapshot is received and subsequently its
> ro property is set to false i.e. switched to rw-mode the
> received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> intact. However, once the received volume is switched to RW mode we
> cannot guaranteee that it contains the same data, so it makes sense
> to remove those fields which indicate this volume was ever
> send/received. Additionally, sending such volume can cause conflicts
> due to the presence of received_uuid.
>
> Preserving the received_uuid (and related fields) after transitioning the
> snapshot from RO to RW and then changing the snapshot has a potential for
> causing send to fail in many unexpected ways if we later turn it back to
> RO and use it for an incremental send operation.
>
> A recent example, in the thread to which the Link tag below points to, we
> had a user with a filesystem that had multiple snapshots with the same
> received_uuid but with different content due to a transition from RO to RW
> and then back to RO. When an incremental send was attempted using two of
> those snapshots, it resulted in send emitting a clone operation that was
> intended to clone from the parent root to the send root - however because
> both roots had the same received_uuid, the receiver ended up picking the
> send root as the source root for the clone operation, which happened to
> result in the clone operation to fail with -EINVAL, due to the source and
> destination offsets being the same (and on the same root and file). In this
> particular case there was no harm, but we could end up in a case where the
> clone operation succeeds but clones wrong data due to picking up an
> incorrect root - as in the case of multiple snapshots with the same
> received_uuid, it has no way to know which one is the correct one if they
> have different content.
Not to overly discourage this change but I think this will cause some issues in user space.

For example I had the problem of partial subvols after a sudden restart during receive. No problem, just receive to a directory that gets deleted on startup then move the subvol to the final location after completion. To move the subvol it needs to be temporarily set rw for some reason. I'm sure there is some better solution but patterns like this might be out there.

>
> Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com/
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> ---
>  fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9eb0c1eb568e..67709d274489 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1927,9 +1927,11 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	struct btrfs_root_item *root_item = &root->root_item;
>  	struct btrfs_trans_handle *trans;
>  	u64 root_flags;
>  	u64 flags;
> +	bool clear_received_state = false;
>  	int ret = 0;
>  
>  	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
> @@ -1960,9 +1962,9 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>  	if (!!(flags & BTRFS_SUBVOL_RDONLY) == btrfs_root_readonly(root))
>  		goto out_drop_sem;
>  
> -	root_flags = btrfs_root_flags(&root->root_item);
> +	root_flags = btrfs_root_flags(root_item);
>  	if (flags & BTRFS_SUBVOL_RDONLY) {
> -		btrfs_set_root_flags(&root->root_item,
> +		btrfs_set_root_flags(root_item,
>  				     root_flags | BTRFS_ROOT_SUBVOL_RDONLY);
>  	} else {
>  		/*
> @@ -1971,9 +1973,10 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>  		 */
>  		spin_lock(&root->root_item_lock);
>  		if (root->send_in_progress == 0) {
> -			btrfs_set_root_flags(&root->root_item,
> +			btrfs_set_root_flags(root_item,
>  				     root_flags & ~BTRFS_ROOT_SUBVOL_RDONLY);
>  			spin_unlock(&root->root_item_lock);
> +			clear_received_state = true;
>  		} else {
>  			spin_unlock(&root->root_item_lock);
>  			btrfs_warn(fs_info,
> @@ -1984,14 +1987,40 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>  		}
>  	}
>  
> -	trans = btrfs_start_transaction(root, 1);
> +	/*
> +	 * 1 item for updating the uuid root in the root tree
> +	 * 1 item for actually removing the uuid record in the uuid tree
> +	 */
> +	trans = btrfs_start_transaction(root, 2);
>  	if (IS_ERR(trans)) {
>  		ret = PTR_ERR(trans);
>  		goto out_reset;
>  	}
>  
> -	ret = btrfs_update_root(trans, fs_info->tree_root,
> -				&root->root_key, &root->root_item);
> +	if (clear_received_state &&
> +	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
> +
> +		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
> +					     BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> +					     root->root_key.objectid);
> +
> +		if (ret && ret != -ENOENT) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +			goto out_reset;
> +		}
> +
> +		memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
> +		btrfs_set_root_stransid(root_item, 0);
> +		btrfs_set_root_rtransid(root_item, 0);
> +		btrfs_set_stack_timespec_sec(&root_item->stime, 0);
> +		btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
> +		btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
> +		btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
> +	}
> +
> +	ret = btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
> +				root_item);
>  	if (ret < 0) {
>  		btrfs_end_transaction(trans);
>  		goto out_reset;


