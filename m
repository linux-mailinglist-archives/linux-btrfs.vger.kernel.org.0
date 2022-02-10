Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2917D4B02A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 03:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiBJB6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 20:58:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiBJB54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 20:57:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752362AAA3
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 17:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644457127;
        bh=DMn5efwizCgQQpoyKNbwEhEanYOpTK7T8Uroo9jXy4c=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=UyyPB6lXy/PM9UUp1unWd3okjvJvnuAYpKSisyIOjIA4xbDW+HN54cGJLLrh+yimj
         QAGnNRw7D0s02O+bYMriDCJ/IFPQ63r/MwvXrJ5CyNgyKVa9NogV3jHIPuE5Ioo4mZ
         82w2TSFiNDmpBH3qx0hNretLJJPzbbqpUwJDnRH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzfv-1npAcA1thx-00XMP2; Thu, 10
 Feb 2022 01:31:04 +0100
Message-ID: <32c44e26-9bd1-f75f-92df-3f7fbf44f8a0@gmx.com>
Date:   Thu, 10 Feb 2022 08:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1644398069.git.wqu@suse.com>
 <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
 <YgP8UocVo/yMT2Pj@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes
 without rescanning the whole file
In-Reply-To: <YgP8UocVo/yMT2Pj@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XgGdNHC42d6bSXPTj+pXA6Fpq2XtkIUG2KG3TN865qnCbX3cK1B
 9Nx1JnaCMe4RKWa+zq/1KbEBzYJg8DXKM4xwfwf8ua/SoFXCRjVtnerYfspjpf8YtXGf4k1
 TjkLPX83oeI5qie9KnWnkvzAM+7K16y8OyX4Fhy2KE8/40YSZw3BmMEdvTA3xTu7ry/0fJL
 i56e+YOA1sXyFDyncrNlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T/ateTjqyA0=:vEAZswgTU4ICzGZ24JSzVp
 4m+TT0gOeEzdlXqSKoQ97mrznF+5Ulw2J92BOq6sHgEBFjM3upUxoyn84kYYT1o8y8q45CtlV
 whufkoMG5pZwSFP1MR9Docwc2+kX/VzPaOE8m51x0axABezUXsBfCRw8j8ybLN+LQS+c4XzTR
 NNk1gLuD6PoH/Moa+u+rIurJ4AwQNbWHoEzah7X1q0Mljggxg6OcSn3rgr9rZx8rPPjaPhfQB
 oJENe5Ysi6WdcyiQ1qwi1JXgUMKtZWrln2RZwMSw1KqVDkrQ9aT3rXpNMU3gUGqefd81wS1ku
 qTQXDyzzcjo5RmDD7FZcHpsWj5n1n8GACqSXVDDCU3g64zedbetp4qfH+WrXvQIvAGcAT37Lx
 FcYDR7xJVMhxo0o8Vu1VBeuFJrlb8lqXqgw3o/vVbfzM53pEAlq3yecnymA6OinMg4M35C3k/
 7KpPDgvL5VpftdMWZqlM6E1pbOG7+yZsHfcL5fGc2lcnsbwqgD4y6dFHIgziMiwhltku5vg/P
 gmQDXP65+SAQKFrom/krgljtWkw6T66T9rVP5oQftI4kKc98lZgV05MpaVB3QNrdX+/PKoYw1
 kklg96FW6/21mDTz2m9LyUQIxjK589j2QZdyMwIv3iZNwuFt1etQ1gI8SNTOruzDFPYzzI8vN
 H0CG/cMPwendXDw8Amzil+R2L0twjsxTRDwJfjqrj5VVMc+02kqCpH0MAtm3YG5XLhY517QbC
 adj+bzVtGZP33FDiT1qDsXkFrp7if0cGWaNAcO5g9wdMWnYjLrFVXPt7G1mUNzl0tw8L2xEC9
 gY72H/k9Y8TTw3faRrLjpZ6l0XvF5SJRkKPx9NM1AGZW+UCmqi/X9LyUb14I6cSKgDY4nMzxl
 tM30p6IM5fx3C6IhSKP+TpofKkINeeJKFW8nJch0dapCJAU6uGyrq7/ebhkvrEeHkpL4+bPe6
 5PDR3K8UfUOPIURlfOD+5ytp1KaSIRf7m7DeANULP8XCiyMaXdukJ4tBaJe5IseQ3fR/WTu64
 Gtp3+XAd5HAu8578qnDjOkP6dDmVjzy8gYEWrtYYAog8n/e5pm1gNFwwPlV0KGnxP26OjaZxm
 PBfFOkcEUl3EkA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/10 01:39, Filipe Manana wrote:
> On Wed, Feb 09, 2022 at 05:23:14PM +0800, Qu Wenruo wrote:
>> Previously autodefrag works by scanning the whole file with a minimal
>> generation threshold.
>>
>> Although we have various optimization to skip ranges which don't meet
>> the generation requirement, it can still waste some time on scanning th=
e
>> whole file, especially if the inode got an almost full overwrite.
>>
>> To optimize the autodefrag even further, here we use
>> inode_defrag::targets extent io tree to do accurate defrag targets
>> search.
>>
>> Now we re-use EXTENT_DIRTY flag to mark the small writes, and only
>> defrag those ranges.
>>
>> This rework brings the following behavior change:
>>
>> - Only small write ranges will be defragged
>>    Previously if there are new writes after the small writes, but it's
>>    not reaching the extent size threshold, it will be defragged.
>>
>>    This is because we have a gap between autodefrag extent size thresho=
ld
>>    and inode_should_defrag() extent size threshold.
>>    (uncompressed 64K / compressed 16K vs 256K)
>>
>>    Now we won't need to bother the gap, and can only defrag the small
>>    writes.
>>
>> - Enlarged critical section for fs_info::defrag_inodes_lock
>>    The critical section will include extent io tree update, thus
>>    it will be larger, and fs_info::defrag_inodes_lock will be upgraded
>>    to mutex to handle the possible sleep.
>>
>>    This would slightly increase the overhead for autodefrag, but I don'=
t
>>    have a benchmark for it.
>>
>> - Extra memory usage for autodefrag
>>    Now we need to keep an extent io tree for each target inode.
>>
>> - No inode re-queue if there are large sectors to defrag
>>    Previously if we have defragged 1024 sectors, we will re-queue the
>>    inode, and mostly pick another inode to defrag in next run.
>>
>>    Now we will defrag the inode until we finished it.
>>    The context switch will be triggered by the cond_resche() in
>>    btrfs_defrag_file() thus it won't hold CPU for too long.
>
> So there's a huge difference in this last aspect.
>
> Before, if we defrag one range, we requeue the inode for autodefrag - bu=
t
> we only run the defrag on the next time the cleaner kthread runs. Instea=
d
> of defragging multiple ranges of the file in the same run, we move to th=
e
> next inode at btrfs_run_defrag_inodes().

Unfortunately, that's not the case, the restart-from-0 behavior is same
for btrfs_run_defrag_inodes().

In btrfs_pick_defrag_inode() it doesn't really strictly follows the
root/ino requirement, it can choose to use the next inode_defrag.

Furthermore, btrfs_run_defrag_inodes() will reset the search root/ino if
it doesn't find anything, thus search from the start again.

This makes btrfs_run_defrag_inodes() to exhaust all the inode_defrag, no
difference than the solution I'm doing.

In fact, I even considered to refactor btrfs_run_defrag_inodes() to be
more explicit on it's just exhausting the rb tree.

The tricks is just hiding the true nature.

>
> With this change, it will defrag all ranges in the same cleaner run. If =
there
> are writes being done to the file all the time, the cleaner will spend a=
 lot of
> time defragging ranges for the same file in the same run. That delays ot=
her
> important work the cleaner does - running delayed iputs, removing empty
> block groups, deleting snapshots/subvolumes, etc.

That is the same behavior, before or after my patchset.

The only way to break the loop in btrfs_run_defrag_inodes() are:

- Remount

- Disable autodefrag

- Exhaust all inode defrags

That root/ino is just tricking readers to believe it's making a
difference, while it's not.

>
> That can have a huge impact system wide.
>
> How have you tested this?
>
> Some user workload like the one reported here:
>
> https://lore.kernel.org/linux-btrfs/KTVQ6R.R75CGDI04ULO2@gmail.com/
>
> Would be a good test. Downloading from Steam is probably not something
> we can do, as it probably requires some paid scrubscription.

Nope, it's the same behavior without my patches.
So that's why I'm suspecting this is the cause of the extra CPU usage.

>
> But something that may be close enough is downloading several large
> torrent files and see how it behaves. Things like downloading several
> DVD iso images of Linux distros from torrents, in a way that the sum of
> the file sizes is much larger then the total RAM of the system. That sho=
uld
> cause a good amount of work that is "real world", and then try later mix=
ing
> that with snapshot/subvolume deletions as well and see if it breaks badl=
y
> or causes a huge performance problem.
>
> Some more comments inline below.
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ctree.h   |   4 +-
>>   fs/btrfs/disk-io.c |   2 +-
>>   fs/btrfs/file.c    | 209 ++++++++++++++++++++++++--------------------=
-
>>   fs/btrfs/inode.c   |   2 +-
>>   4 files changed, 116 insertions(+), 101 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index a5cf845cbe88..9228e8d39516 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -897,7 +897,7 @@ struct btrfs_fs_info {
>>   	struct btrfs_free_cluster meta_alloc_cluster;
>>
>>   	/* auto defrag inodes go here */
>> -	spinlock_t defrag_inodes_lock;
>> +	struct mutex defrag_inodes_lock;
>>   	struct rb_root defrag_inodes;
>>   	atomic_t defrag_running;
>>
>> @@ -3356,7 +3356,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *f=
s_info,
>>   /* file.c */
>>   int __init btrfs_auto_defrag_init(void);
>>   void __cold btrfs_auto_defrag_exit(void);
>> -int btrfs_add_inode_defrag(struct btrfs_inode *inode);
>> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 l=
en);
>>   int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
>>   void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
>>   int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int =
datasync);
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b6a81c39d5f4..87782d1120e7 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3126,7 +3126,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
>>   	spin_lock_init(&fs_info->trans_lock);
>>   	spin_lock_init(&fs_info->fs_roots_radix_lock);
>>   	spin_lock_init(&fs_info->delayed_iput_lock);
>> -	spin_lock_init(&fs_info->defrag_inodes_lock);
>>   	spin_lock_init(&fs_info->super_lock);
>>   	spin_lock_init(&fs_info->buffer_lock);
>>   	spin_lock_init(&fs_info->unused_bgs_lock);
>> @@ -3140,6 +3139,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
>>   	mutex_init(&fs_info->reloc_mutex);
>>   	mutex_init(&fs_info->delalloc_root_mutex);
>>   	mutex_init(&fs_info->zoned_meta_io_lock);
>> +	mutex_init(&fs_info->defrag_inodes_lock);
>>   	seqlock_init(&fs_info->profiles_lock);
>>
>>   	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 2d49336b0321..da6e29a6f387 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -34,7 +34,7 @@
>>   static struct kmem_cache *btrfs_inode_defrag_cachep;
>>
>>   /* Reuse DIRTY flag for autodefrag */
>> -#define EXTENT_FLAG_AUTODEFRAG	EXTENT_FLAG_DIRTY
>> +#define EXTENT_FLAG_AUTODEFRAG	EXTENT_DIRTY
>>
>>   /*
>>    * when auto defrag is enabled we
>> @@ -119,7 +119,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_in=
ode *inode,
>>   			return -EEXIST;
>>   		}
>>   	}
>> -	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
>>   	rb_link_node(&defrag->rb_node, parent, p);
>>   	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
>>   	return 0;
>> @@ -136,81 +135,80 @@ static inline int __need_auto_defrag(struct btrfs=
_fs_info *fs_info)
>>   	return 1;
>>   }
>>
>> +static struct inode_defrag *find_inode_defrag(struct btrfs_fs_info *fs=
_info,
>> +					      u64 root, u64 ino)
>> +{
>> +
>> +	struct inode_defrag *entry =3D NULL;
>> +	struct inode_defrag tmp;
>> +	struct rb_node *p;
>> +	struct rb_node *parent =3D NULL;
>
> Neither entry nor parent need to be initialized.
>
>> +	int ret;
>> +
>> +	tmp.ino =3D ino;
>> +	tmp.root =3D root;
>> +
>> +	p =3D fs_info->defrag_inodes.rb_node;
>> +	while (p) {
>> +		parent =3D p;
>> +		entry =3D rb_entry(parent, struct inode_defrag, rb_node);
>> +
>> +		ret =3D __compare_inode_defrag(&tmp, entry);
>> +		if (ret < 0)
>> +			p =3D parent->rb_left;
>> +		else if (ret > 0)
>> +			p =3D parent->rb_right;
>> +		else
>> +			return entry;
>> +	}
>
> It's pointless to have "parent" and "p", one of them is enough.
>
>> +	return NULL;
>> +}
>> +
>>   /*
>>    * insert a defrag record for this inode if auto defrag is
>>    * enabled
>>    */
>> -int btrfs_add_inode_defrag(struct btrfs_inode *inode)
>> +int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 l=
en)
>>   {
>>   	struct btrfs_root *root =3D inode->root;
>>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>> -	struct inode_defrag *defrag;
>> +	struct inode_defrag *prealloc;
>> +	struct inode_defrag *found;
>> +	bool release =3D true;
>>   	int ret;
>>
>>   	if (!__need_auto_defrag(fs_info))
>>   		return 0;
>>
>> -	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
>> -		return 0;
>> -
>> -	defrag =3D kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
>> -	if (!defrag)
>> +	prealloc =3D kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
>> +	if (!prealloc)
>>   		return -ENOMEM;
>
> So now everytime this is called, it will allocate memory, even if the th=
e
> inode is already marked for defrag.

Well, since now the defrag_inodes_lock is upgraded to mutex, we can
afford to allocate memory only when needed.

I can change the behavior.

>
> Given that this function is called when running delalloc, this can cause
> a lot of extra memory allocations. They come from a dedicated slab, but =
it
> still might have a non-negligible impact.

But please be aware that, the original code is going to allocate memory
if the inode has being evicted, thus its runtime flags is not reliable.

The runtime flags check is an optimization, but not a reliable one.

>
>>
>> -	defrag->ino =3D btrfs_ino(inode);
>> -	defrag->transid =3D inode->root->last_trans;
>> -	defrag->root =3D root->root_key.objectid;
>> -	extent_io_tree_init(fs_info, &defrag->targets, IO_TREE_AUTODEFRAG, NU=
LL);
>> -
>> -	spin_lock(&fs_info->defrag_inodes_lock);
>> -	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
>> -		/*
>> -		 * If we set IN_DEFRAG flag and evict the inode from memory,
>> -		 * and then re-read this inode, this new inode doesn't have
>> -		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
>> -		 */
>> -		ret =3D __btrfs_add_inode_defrag(inode, defrag);
>> -		if (ret) {
>> -			extent_io_tree_release(&defrag->targets);
>> -			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>> -		}
>> -	} else {
>> -		extent_io_tree_release(&defrag->targets);
>> -		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>> +	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
>> +	prealloc->ino =3D btrfs_ino(inode);
>> +	prealloc->transid =3D inode->root->last_trans;
>> +	prealloc->root =3D root->root_key.objectid;
>> +	extent_io_tree_init(fs_info, &prealloc->targets, IO_TREE_AUTODEFRAG, =
NULL);
>> +
>> +	mutex_lock(&fs_info->defrag_inodes_lock);
>> +	found =3D find_inode_defrag(fs_info, prealloc->root, prealloc->ino);
>> +	if (!found) {
>> +		ret =3D __btrfs_add_inode_defrag(inode, prealloc);
>> +		/* Since we didn't find one previously, the insert must success */
>> +		ASSERT(!ret);
>> +		found =3D prealloc;
>> +		release =3D false;
>> +	}
>> +	set_extent_bits(&found->targets, start, start + len - 1,
>> +			EXTENT_FLAG_AUTODEFRAG);
>
> So this can end using a lot of memory and resulting in a deep rbtree.
> It's not uncommon to have very large files with random IO happening very
> frequently, each one would result in allocating one extent state record
> for the tree.

This is one of my concern, and I totally understand this.

However there are some factors to possibly reduce the memory overhead:

- If the random writes are mergable
   Then the extent states will be merged into a larger one.

- If the randome writes are happening on the same range
   No change in the number of extent states.

- Much smaller extent threshold
   Now the real extent threshold is from inode_should_defrag(), which
   exposes 64K for uncompressed write while 16K for compressed writes.

In fact, for the mentioned case of steam download, I doubt if it would
even trigger autodefrag, as it's mostly sequential write.

Maybe for the decompression part it can cause some random writes, but
according to my daily usage, the IO is pretty high, indicating it's
mostly sequential write, thus should not really trigger autodefrag.

In fact, I believe a lot of autodefrag for Steam is false triggering,
thus my purposed patchset is exactly to address it.

>
> Multiply this by N active files in a system, and it can quickly have a
> huge impact on used memory.
>
> Also, if a memory allocation triggers reclaim, it will slow down and
> increase the amount of time other tasks wait for the mutex. As the rbtre=
e
> that the io tree uses gets larger and larger, it also increases more and
> more the critical section's duration.
>
> This means writeback for other inodes is now waiting for a longer period=
,
> as well as the cleaner kthread, which runs autodefrag. Blocking the clea=
ner
> for longer means we are delaying other important work - running delayed
> iputs, deleting snapshots/subvolumes, removing empty block groups, and
> whatever else the cleaner kthread does besides running autodefrag.
>
> So it can have a very high impact on the system overall.
>
>> +	mutex_unlock(&fs_info->defrag_inodes_lock);
>> +	if (release) {
>> +		extent_io_tree_release(&prealloc->targets);
>> +		kmem_cache_free(btrfs_inode_defrag_cachep, prealloc);
>>   	}
>> -	spin_unlock(&fs_info->defrag_inodes_lock);
>>   	return 0;
>>   }
>>
>> -/*
>> - * Requeue the defrag object. If there is a defrag object that points =
to
>> - * the same inode in the tree, we will merge them together (by
>> - * __btrfs_add_inode_defrag()) and free the one that we want to requeu=
e.
>> - */
>> -static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
>> -				       struct inode_defrag *defrag)
>> -{
>> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> -	int ret;
>> -
>> -	if (!__need_auto_defrag(fs_info))
>> -		goto out;
>> -
>> -	/*
>> -	 * Here we don't check the IN_DEFRAG flag, because we need merge
>> -	 * them together.
>> -	 */
>> -	spin_lock(&fs_info->defrag_inodes_lock);
>> -	ret =3D __btrfs_add_inode_defrag(inode, defrag);
>> -	spin_unlock(&fs_info->defrag_inodes_lock);
>> -	if (ret)
>> -		goto out;
>> -	return;
>> -out:
>> -	extent_io_tree_release(&defrag->targets);
>> -	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>> -}
>> -
>>   /*
>>    * pick the defragable inode that we want, if it doesn't exist, we wi=
ll get
>>    * the next one.
>> @@ -227,7 +225,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_in=
fo, u64 root, u64 ino)
>>   	tmp.ino =3D ino;
>>   	tmp.root =3D root;
>>
>> -	spin_lock(&fs_info->defrag_inodes_lock);
>> +	mutex_lock(&fs_info->defrag_inodes_lock);
>>   	p =3D fs_info->defrag_inodes.rb_node;
>>   	while (p) {
>>   		parent =3D p;
>> @@ -252,7 +250,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_in=
fo, u64 root, u64 ino)
>>   out:
>>   	if (entry)
>>   		rb_erase(parent, &fs_info->defrag_inodes);
>> -	spin_unlock(&fs_info->defrag_inodes_lock);
>> +	mutex_unlock(&fs_info->defrag_inodes_lock);
>>   	return entry;
>>   }
>>
>> @@ -261,7 +259,7 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_in=
fo *fs_info)
>>   	struct inode_defrag *defrag;
>>   	struct rb_node *node;
>>
>> -	spin_lock(&fs_info->defrag_inodes_lock);
>> +	mutex_lock(&fs_info->defrag_inodes_lock);
>>   	node =3D rb_first(&fs_info->defrag_inodes);
>>   	while (node) {
>>   		rb_erase(node, &fs_info->defrag_inodes);
>> @@ -269,21 +267,59 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_=
info *fs_info)
>>   		extent_io_tree_release(&defrag->targets);
>>   		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>>
>> -		cond_resched_lock(&fs_info->defrag_inodes_lock);
>> -
>>   		node =3D rb_first(&fs_info->defrag_inodes);
>>   	}
>> -	spin_unlock(&fs_info->defrag_inodes_lock);
>> +	mutex_unlock(&fs_info->defrag_inodes_lock);
>>   }
>>
>>   #define BTRFS_DEFRAG_BATCH	1024
>> +static int defrag_one_range(struct btrfs_inode *inode, u64 start, u64 =
len,
>> +			    u64 newer_than)
>> +{
>> +	const struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +	u64 cur =3D start;
>> +	int ret =3D 0;
>> +
>> +	while (cur < start + len) {
>> +		struct btrfs_defrag_ctrl ctrl =3D { 0 };
>> +
>> +		ctrl.start =3D cur;
>> +		ctrl.len =3D start + len - cur;
>> +		ctrl.newer_than =3D newer_than;
>> +		ctrl.extent_thresh =3D SZ_256K;
>> +		ctrl.max_sectors_to_defrag =3D BTRFS_DEFRAG_BATCH;
>> +
>> +		sb_start_write(fs_info->sb);
>> +		ret =3D btrfs_defrag_file(&inode->vfs_inode, NULL, &ctrl);
>> +		sb_end_write(fs_info->sb);
>> +
>> +		/* The range is beyond isize, we can safely exit */
>> +		if (ret =3D=3D -EINVAL) {
>
> This is a bit odd. I understand this is because the io tree requires ran=
ges
> to be sector aligned, so this should trigger only for inodes with an i_s=
ize that
> is not sector size aligned.
>
> Assuming every -EINVAL is because of that, makes it a bit fragile.
>
> setting ctrl.len to min(i_size_read(inode) - start, start + len - cur) a=
nd
> then treating all errors the same way, makes it more bullet proof. >
>> +			ret =3D 0;
>> +			break;
>> +		}
>> +		if (ret < 0)
>> +			break;
>> +
>> +		/*
>> +		 * Even we didn't defrag anything, the last_scanned should have
>> +		 * been increased.
>> +		 */
>> +		ASSERT(ctrl.last_scanned > cur);
>> +		cur =3D ctrl.last_scanned;
>> +	}
>> +	return ret;
>> +}
>>
>>   static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>>   				    struct inode_defrag *defrag)
>>   {
>>   	struct btrfs_root *inode_root;
>>   	struct inode *inode;
>> -	struct btrfs_defrag_ctrl ctrl =3D {};
>> +	struct extent_state *cached =3D NULL;
>> +	u64 cur =3D 0;
>> +	u64 found_start;
>> +	u64 found_end;
>>   	int ret;
>>
>>   	/* get the inode */
>> @@ -300,40 +336,19 @@ static int __btrfs_run_defrag_inode(struct btrfs_=
fs_info *fs_info,
>>   		goto cleanup;
>>   	}
>>
>> -	/* do a chunk of defrag */
>> -	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
>> -	ctrl.len =3D (u64)-1;
>> -	ctrl.start =3D defrag->last_offset;
>> -	ctrl.newer_than =3D defrag->transid;
>> -	ctrl.max_sectors_to_defrag =3D BTRFS_DEFRAG_BATCH;
>> -
>> -	sb_start_write(fs_info->sb);
>> -	ret =3D btrfs_defrag_file(inode, NULL, &ctrl);
>> -	sb_end_write(fs_info->sb);
>> -	/*
>> -	 * if we filled the whole defrag batch, there
>> -	 * must be more work to do.  Queue this defrag
>> -	 * again
>> -	 */
>> -	if (ctrl.sectors_defragged =3D=3D BTRFS_DEFRAG_BATCH) {
>> -		defrag->last_offset =3D ctrl.last_scanned;
>> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
>> -	} else if (defrag->last_offset && !defrag->cycled) {
>> -		/*
>> -		 * we didn't fill our defrag batch, but
>> -		 * we didn't start at zero.  Make sure we loop
>> -		 * around to the start of the file.
>> -		 */
>> -		defrag->last_offset =3D 0;
>> -		defrag->cycled =3D 1;
>> -		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
>> -	} else {
>> -		extent_io_tree_release(&defrag->targets);
>> -		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>> +	while (!find_first_extent_bit(&defrag->targets,
>> +				cur, &found_start, &found_end,
>> +				EXTENT_FLAG_AUTODEFRAG, &cached)) {
>> +		clear_extent_bit(&defrag->targets, found_start,
>> +				 found_end, EXTENT_FLAG_AUTODEFRAG, 0, 0, &cached);
>> +		ret =3D defrag_one_range(BTRFS_I(inode), found_start,
>> +				found_end + 1 - found_start, defrag->transid);
>> +		if (ret < 0)
>> +			break;
>
> Not sure why it makes more sense to break instead of continuing.
> Just because there was a failure for one range, it does not mean
> the next ranges will fail as well.

IMHO if we failed to defrag one range, there are two possible reasons:

- We reached isize, and any later defrag is not needed

- We got a fatal error like -ENOMEM
   I doubt if we can even continue.

I can make the first case more correct and explicit, but you're right,
it's better to continue defragging.

Thanks,
Qu

>
> Thanks.
>
>> +		cur =3D found_end + 1;
>>   	}
>>
>>   	iput(inode);
>> -	return 0;
>>   cleanup:
>>   	extent_io_tree_release(&defrag->targets);
>>   	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 2049f3ea992d..622e017500bc 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -570,7 +570,7 @@ static inline void inode_should_defrag(struct btrfs=
_inode *inode,
>>   	/* If this is a small write inside eof, kick off a defrag */
>>   	if (num_bytes < small_write &&
>>   	    (start > 0 || end + 1 < inode->disk_i_size))
>> -		btrfs_add_inode_defrag(inode);
>> +		btrfs_add_inode_defrag(inode, start, num_bytes);
>>   }
>>
>>   /*
>> --
>> 2.35.0
>>
