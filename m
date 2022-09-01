Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75C5AA34F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiIAWuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiIAWui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:50:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D1C5A17A
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662072630;
        bh=/IcjadabVtMNTkBDUrWGd1tJysRoHchAUQ54sHDvFRI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=JEP8QfHFnNXgI1TibaT2p7Kd3CSha+xNsP4CNupOauJDkI0q+/wYCarjBsb0jLHH8
         Yic7v84ZqOwrc7qpmsRxhUGmU5tyKLvja7ZMz2G2IMUbBBVFYN4TRHoLdRAM4nEGOR
         fqp5eyHVqNVTtQ5ilKD37oWWNcjCUhuMX1vsj56Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1oVWuR0it4-001gCa; Fri, 02
 Sep 2022 00:50:29 +0200
Message-ID: <d01aa277-353a-0a5d-503b-07cd3bc27632@gmx.com>
Date:   Fri, 2 Sep 2022 06:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/10] btrfs: speedup checking for extent sharedness
 during fiemap
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <5e696c29b65f6558b8012596aa513101ed04a21a.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5e696c29b65f6558b8012596aa513101ed04a21a.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:26JmguGTCAIPl6pIC+8VS2x8PjBi/fzRIFdXqE4wcf1AzIcFYsz
 JYN0UgNfZ83AC68A8u0YZK+eaGADvdrw6Lal/Y1duhv/ywALy00CrPuIsUnc5hP4UTteUFQ
 ve9ypPkr6sxFf/NOfNUyjYXwXV7lY9v/Q/68a8tgwrx5H/jMSn3A/OTmys0KOTi/LKhgTNA
 6S0+HLMR3CuVlGOUqt7pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BIktgsEfEHA=:+0NHNWkk1DpnomZo2YcHtL
 wfCOjJmIArWqGq2HZCoJraBXOQiAgWvI4Qq4kzQOejweek5jhcomGIoSPx+7JB8JvFH2mB2CT
 W/E4g0SRJNkvQxgvZ3PfHA4e+aRQIE/NlzzB/8Wpwrgmi2lZx9K/NbPaWuPs9a70bwoADhvuk
 PGQW/W8+8tGVrIvLPShG94pN5GLX89NIJV4N8MRyB9qksfAxtvTtv4mmf5YC++3Iyjdd61M3/
 89DsYFIf0FBZEpfd4wbIdfhZneCpVKbrMV2Z49DgYOkiogYdcu4MiQF2SKBXxz1UKXujR6hbw
 zh5+idd1v0jwH1B7wAUx+/csUaKFsyruodjHNxOT6U28dMH3CG4TI44LMJShhgiuQI+He0Yhw
 H4t1aw4augP6qYEr0fY30uT8k7lpktfOGr9XbXd2YiKtBhV6poFToUcv96hs3mZADUyqtgYDJ
 iGfeCNTP67tofOE816fyIK4ZM1P9prB8euQecYUuLybNH+Yn8KGRvp5RG49eGtLMqNqjjqs7A
 QUyQdn5Fy/0QyHYvz+ukF2eqp/Me3fDYEzorLLdNe66q37KLaba2MhPAiFrmRX4Xq48Xx/BAa
 yWoKdhc2jI22YWLrAwLO3AqDzBq7xfWIgHJo7crNC13OSdeMLqoMy/UCIhfaSYhTtbYfrgBhB
 amL+YZfsNHxw/xZlcH75pjSx6JxLziG3mv2KokTTt4Qn4XUZWNDbMOd6xW0ieHp9cWUJUMHIv
 NJHlvkVMz2aUFFfoNGSz4c3ACAIksaUL/Cc4Qfef32fVw1iYIao0n7+vo/vG/KDHzPmUia51b
 1VAPqJFH7Z2kGDNfvI3El4EkuMNXaGbEJHf8yNZfAHRh+6TsDRA4MRz5wC4RdDka2+Rby2xOX
 IhhAMkC3HIaATyGMIv4SeyElSO7Lw7N8bIK0OkxwlOow1PQ3ofCoo9JNc2iEUFx3+XBtTR/+6
 rdSd8imZi5N9Zu2EwGJdJ/icHtVrbc3fL7KsimUr5eMfAlxezyV7X10NA24Wu6/bp87iX/5k7
 af2ZMkoQhtjFqKJssH0bxntb9dyJrCZsVbcBJ+T6cVkwG05+cjCcVm1VOLfdjAQ3ZFc4qV3rR
 kPofp7aKKS3g1Krg/I66OZAKjWur3FeYbqw0G4SRYgenJmjBG9ilbQenJUXfegUa0vIt1ORnt
 z7Wj3lPQmexdK1K9R31Lmjo8q9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> One of the most expensive tasks performed during fiemap is to check if
> an extent is shared. This task has two major steps:
>
> 1) Check if the data extent is shared. This implies checking the extent
>     item in the extent tree, checking delayed references, etc. If we
>     find the data extent is directly shared, we terminate immediately;
>
> 2) If the data extent is not directly shared (its extent item has a
>     refcount of 1), then it may be shared if we have snapshots that shar=
e
>     subtrees of the inode's subvolume b+tree. So we check if the leaf
>     containing the file extent item is shared, then its parent node, the=
n
>     the parent node of the parent node, etc, until we reach the root nod=
e
>     or we find one of them is shared - in which case we stop immediately=
.
>
> During fiemap we process the extents of a file from left to right, from
> file offset 0 to eof. This means that we iterate b+tree leaves from left
> to right, and has the implication that we keep repeating that second ste=
p
> above several times for the same b+tree path of the inode's subvolume
> b+tree.
>
> For example, if we have two file extent items in leaf X, and the path to
> leaf X is A -> B -> C -> X, then when we try to determine if the data
> extent referenced by the first extent item is shared, we check if the da=
ta
> extent is shared - if it's not, then we check if leaf X is shared, if no=
t,
> then we check if node C is shared, if not, then check if node B is share=
d,
> if not than check if node A is shared. When we move to the next file
> extent item, after determining the data extent is not shared, we repeat
> the checks for X, C, B and A - doing all the expensive searches in the
> extent tree, delayed refs, etc. If we have thousands of tile extents, th=
en
> we keep repeating the sharedness checks for the same paths over and over=
.
>
> On a file that has no shared extents or only a small portion, it's easy
> to see that this scales terribly with the number of extents in the file
> and the sizes of the extent and subvolume b+trees.
>
> This change eliminates the repeated sharedness check on extent buffers
> by caching the results of the last path used. The results can be used as
> long as no snapshots were created since they were cached (for not shared
> extent buffers) or no roots were dropped since they were cached (for
> shared extent buffers). This greatly reduces the time spent by fiemap fo=
r
> files with thousands of extents and/or large extent and subvolume b+tree=
s.

This sounds pretty much like the existing btrfs_backref_cache is doing.

It stores a map to speedup the backref lookup.

But a quick search didn't hit things like btrfs_backref_edge() or
btrfs_backref_cache().

Would it be possible to reuse the existing facility to do the same thing?

Thanks,
Qu
>
> Example performance test:
>
>      $ cat fiemap-perf-test.sh
>      #!/bin/bash
>
>      DEV=3D/dev/sdi
>      MNT=3D/mnt/sdi
>
>      mkfs.btrfs -f $DEV
>      mount -o compress=3Dlzo $DEV $MNT
>
>      # 40G gives 327680 128K file extents (due to compression).
>      xfs_io -f -c "pwrite -S 0xab -b 1M 0 40G" $MNT/foobar
>
>      umount $MNT
>      mount -o compress=3Dlzo $DEV $MNT
>
>      start=3D$(date +%s%N)
>      filefrag $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "fiemap took $dur milliseconds (metadata not cached)"
>
>      start=3D$(date +%s%N)
>      filefrag $MNT/foobar
>      end=3D$(date +%s%N)
>      dur=3D$(( (end - start) / 1000000 ))
>      echo "fiemap took $dur milliseconds (metadata cached)"
>
>      umount $MNT
>
> Before this patch:
>
>      $ ./fiemap-perf-test.sh
>      (...)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 3597 milliseconds (metadata not cached)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 2107 milliseconds (metadata cached)
>
> After this patch:
>
>      $ ./fiemap-perf-test.sh
>      (...)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 1646 milliseconds (metadata not cached)
>      /mnt/sdi/foobar: 327680 extents found
>      fiemap took 698 milliseconds (metadata cached)
>
> That's about 2.2x faster when no metadata is cached, and about 3x faster
> when all metadata is cached. On a real filesystem with many other files,
> data, directories, etc, the b+trees will be 2 or 3 levels higher,
> therefore this optimization will have a higher impact.
>
> Several reports of a slow fiemap show up often, the two Link tags below
> refer to two recent reports of such slowness. This patch, together with
> the next ones in the series, is meant to address that.
>
> Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc=
6788a7@virtuozzo.com/
> Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno=
.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/backref.c     | 122 ++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/backref.h     |  17 +++++-
>   fs/btrfs/ctree.h       |  18 ++++++
>   fs/btrfs/extent-tree.c |  10 +++-
>   fs/btrfs/extent_io.c   |  11 ++--
>   5 files changed, 170 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e2ac10a695b6..40b48abb6978 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1511,6 +1511,105 @@ int btrfs_find_all_roots(struct btrfs_trans_hand=
le *trans,
>   	return ret;
>   }
>
> +/*
> + * The caller has joined a transaction or is holding a read lock on the
> + * fs_info->commit_root_sem semaphore, so no need to worry about the ro=
ot's last
> + * snapshot field changing while updating or checking the cache.
> + */
> +static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cac=
he *cache,
> +					struct btrfs_root *root,
> +					u64 bytenr, int level, bool *is_shared)
> +{
> +	struct btrfs_backref_shared_cache_entry *entry;
> +
> +	if (WARN_ON_ONCE(level >=3D BTRFS_MAX_LEVEL))
> +		return false;
> +
> +	/*
> +	 * Level -1 is used for the data extent, which is not reliable to cach=
e
> +	 * because its reference count can increase or decrease without us
> +	 * realizing. We cache results only for extent buffers that lead from
> +	 * the root node down to the leaf with the file extent item.
> +	 */
> +	ASSERT(level >=3D 0);
> +
> +	entry =3D &cache->entries[level];
> +
> +	/* Unused cache entry or being used for some other extent buffer. */
> +	if (entry->bytenr !=3D bytenr)
> +		return false;
> +
> +	/*
> +	 * We cached a false result, but the last snapshot generation of the
> +	 * root changed, so we now have a snapshot. Don't trust the result.
> +	 */
> +	if (!entry->is_shared &&
> +	    entry->gen !=3D btrfs_root_last_snapshot(&root->root_item))
> +		return false;
> +
> +	/*
> +	 * If we cached a true result and the last generation used for droppin=
g
> +	 * a root changed, we can not trust the result, because the dropped ro=
ot
> +	 * could be a snapshot sharing this extent buffer.
> +	 */
> +	if (entry->is_shared &&
> +	    entry->gen !=3D btrfs_get_last_root_drop_gen(root->fs_info))
> +		return false;
> +
> +	*is_shared =3D entry->is_shared;
> +
> +	return true;
> +}
> +
> +/*
> + * The caller has joined a transaction or is holding a read lock on the
> + * fs_info->commit_root_sem semaphore, so no need to worry about the ro=
ot's last
> + * snapshot field changing while updating or checking the cache.
> + */
> +static void store_backref_shared_cache(struct btrfs_backref_shared_cach=
e *cache,
> +				       struct btrfs_root *root,
> +				       u64 bytenr, int level, bool is_shared)
> +{
> +	struct btrfs_backref_shared_cache_entry *entry;
> +	u64 gen;
> +
> +	if (WARN_ON_ONCE(level >=3D BTRFS_MAX_LEVEL))
> +		return;
> +
> +	/*
> +	 * Level -1 is used for the data extent, which is not reliable to cach=
e
> +	 * because its reference count can increase or decrease without us
> +	 * realizing. We cache results only for extent buffers that lead from
> +	 * the root node down to the leaf with the file extent item.
> +	 */
> +	ASSERT(level >=3D 0);
> +
> +	if (is_shared)
> +		gen =3D btrfs_get_last_root_drop_gen(root->fs_info);
> +	else
> +		gen =3D btrfs_root_last_snapshot(&root->root_item);
> +
> +	entry =3D &cache->entries[level];
> +	entry->bytenr =3D bytenr;
> +	entry->is_shared =3D is_shared;
> +	entry->gen =3D gen;
> +
> +	/*
> +	 * If we found an extent buffer is shared, set the cache result for al=
l
> +	 * extent buffers below it to true. As nodes in the path are COWed,
> +	 * their sharedness is moved to their children, and if a leaf is COWed=
,
> +	 * then the sharedness of a data extent becomes direct, the refcount o=
f
> +	 * data extent is increased in the extent item at the extent tree.
> +	 */
> +	if (is_shared) {
> +		for (int i =3D 0; i < level; i++) {
> +			entry =3D &cache->entries[i];
> +			entry->is_shared =3D is_shared;
> +			entry->gen =3D gen;
> +		}
> +	}
> +}
> +
>   /**
>    * Check if a data extent is shared or not.
>    *
> @@ -1519,6 +1618,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle=
 *trans,
>    * @bytenr: logical bytenr of the extent we are checking
>    * @roots:  list of roots this extent is shared among
>    * @tmp:    temporary list used for iteration
> + * @cache:  a backref lookup result cache
>    *
>    * btrfs_is_data_extent_shared uses the backref walking code but will =
short
>    * circuit as soon as it finds a root or inode that doesn't match the
> @@ -1532,7 +1632,8 @@ int btrfs_find_all_roots(struct btrfs_trans_handle=
 *trans,
>    * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
>    */
>   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64=
 bytenr,
> -				struct ulist *roots, struct ulist *tmp)
> +				struct ulist *roots, struct ulist *tmp,
> +				struct btrfs_backref_shared_cache *cache)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_trans_handle *trans;
> @@ -1545,6 +1646,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root =
*root, u64 inum, u64 bytenr,
>   		.inum =3D inum,
>   		.share_count =3D 0,
>   	};
> +	int level;
>
>   	ulist_init(roots);
>   	ulist_init(tmp);
> @@ -1561,22 +1663,40 @@ int btrfs_is_data_extent_shared(struct btrfs_roo=
t *root, u64 inum, u64 bytenr,
>   		btrfs_get_tree_mod_seq(fs_info, &elem);
>   	}
>
> +	/* -1 means we are in the bytenr of the data extent. */
> +	level =3D -1;
>   	ULIST_ITER_INIT(&uiter);
>   	while (1) {
> +		bool is_shared;
> +		bool cached;
> +
>   		ret =3D find_parent_nodes(trans, fs_info, bytenr, elem.seq, tmp,
>   					roots, NULL, &shared, false);
>   		if (ret =3D=3D BACKREF_FOUND_SHARED) {
>   			/* this is the only condition under which we return 1 */
>   			ret =3D 1;
> +			if (level >=3D 0)
> +				store_backref_shared_cache(cache, root, bytenr,
> +							   level, true);
>   			break;
>   		}
>   		if (ret < 0 && ret !=3D -ENOENT)
>   			break;
>   		ret =3D 0;
> +		if (level >=3D 0)
> +			store_backref_shared_cache(cache, root, bytenr,
> +						   level, false);
>   		node =3D ulist_next(tmp, &uiter);
>   		if (!node)
>   			break;
>   		bytenr =3D node->val;
> +		level++;
> +		cached =3D lookup_backref_shared_cache(cache, root, bytenr, level,
> +						     &is_shared);
> +		if (cached) {
> +			ret =3D is_shared ? 1 : 0;
> +			break;
> +		}
>   		shared.share_count =3D 0;
>   		cond_resched();
>   	}
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 08354394b1bb..797ba5371d55 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -17,6 +17,20 @@ struct inode_fs_paths {
>   	struct btrfs_data_container	*fspath;
>   };
>
> +struct btrfs_backref_shared_cache_entry {
> +	u64 bytenr;
> +	u64 gen;
> +	bool is_shared;
> +};
> +
> +struct btrfs_backref_shared_cache {
> +	/*
> +	 * A path from a root to a leaf that has a file extent item pointing t=
o
> +	 * a given data extent should never exceed the maximum b+tree heigth.
> +	 */
> +	struct btrfs_backref_shared_cache_entry entries[BTRFS_MAX_LEVEL];
> +};
> +
>   typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
>   		void *ctx);
>
> @@ -63,7 +77,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64=
 inode_objectid,
>   			  struct btrfs_inode_extref **ret_extref,
>   			  u64 *found_off);
>   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64=
 bytenr,
> -				struct ulist *roots, struct ulist *tmp);
> +				struct ulist *roots, struct ulist *tmp,
> +				struct btrfs_backref_shared_cache *cache);
>
>   int __init btrfs_prelim_ref_init(void);
>   void __cold btrfs_prelim_ref_exit(void);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 3dc30f5e6fd0..f7fe7f633eb5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1095,6 +1095,13 @@ struct btrfs_fs_info {
>   	/* Updates are not protected by any lock */
>   	struct btrfs_commit_stats commit_stats;
>
> +	/*
> +	 * Last generation where we dropped a non-relocation root.
> +	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen=
()
> +	 * to change it and to read it, respectively.
> +	 */
> +	u64 last_root_drop_gen;
> +
>   	/*
>   	 * Annotations for transaction events (structures are empty when
>   	 * compiled without lockdep).
> @@ -1119,6 +1126,17 @@ struct btrfs_fs_info {
>   #endif
>   };
>
> +static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *f=
s_info,
> +						u64 gen)
> +{
> +	WRITE_ONCE(fs_info->last_root_drop_gen, gen);
> +}
> +
> +static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_in=
fo *fs_info)
> +{
> +	return READ_ONCE(fs_info->last_root_drop_gen);
> +}
> +
>   static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
>   {
>   	return sb->s_fs_info;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index bcd0e72cded3..9818285dface 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5635,6 +5635,8 @@ static noinline int walk_up_tree(struct btrfs_tran=
s_handle *trans,
>    */
>   int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int f=
or_reloc)
>   {
> +	const bool is_reloc_root =3D (root->root_key.objectid =3D=3D
> +				    BTRFS_TREE_RELOC_OBJECTID);
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_path *path;
>   	struct btrfs_trans_handle *trans;
> @@ -5794,6 +5796,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>   				goto out_end_trans;
>   			}
>
> +			if (!is_reloc_root)
> +				btrfs_set_last_root_drop_gen(fs_info, trans->transid);
> +
>   			btrfs_end_transaction_throttle(trans);
>   			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
>   				btrfs_debug(fs_info,
> @@ -5828,7 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>   		goto out_end_trans;
>   	}
>
> -	if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
> +	if (!is_reloc_root) {
>   		ret =3D btrfs_find_root(tree_root, &root->root_key, path,
>   				      NULL, NULL);
>   		if (ret < 0) {
> @@ -5860,6 +5865,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>   		btrfs_put_root(root);
>   	root_dropped =3D true;
>   out_end_trans:
> +	if (!is_reloc_root)
> +		btrfs_set_last_root_drop_gen(fs_info, trans->transid);
> +
>   	btrfs_end_transaction_throttle(trans);
>   out_free:
>   	kfree(wc);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a47710516ecf..781436cc373c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5519,6 +5519,7 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   	struct btrfs_path *path;
>   	struct btrfs_root *root =3D inode->root;
>   	struct fiemap_cache cache =3D { 0 };
> +	struct btrfs_backref_shared_cache *backref_cache;
>   	struct ulist *roots;
>   	struct ulist *tmp_ulist;
>   	int end =3D 0;
> @@ -5526,13 +5527,11 @@ int extent_fiemap(struct btrfs_inode *inode, str=
uct fiemap_extent_info *fieinfo,
>   	u64 em_len =3D 0;
>   	u64 em_end =3D 0;
>
> +	backref_cache =3D kzalloc(sizeof(*backref_cache), GFP_KERNEL);
>   	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> -
>   	roots =3D ulist_alloc(GFP_KERNEL);
>   	tmp_ulist =3D ulist_alloc(GFP_KERNEL);
> -	if (!roots || !tmp_ulist) {
> +	if (!backref_cache || !path || !roots || !tmp_ulist) {
>   		ret =3D -ENOMEM;
>   		goto out_free_ulist;
>   	}
> @@ -5658,7 +5657,8 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   			 */
>   			ret =3D btrfs_is_data_extent_shared(root, btrfs_ino(inode),
>   							  bytenr, roots,
> -							  tmp_ulist);
> +							  tmp_ulist,
> +							  backref_cache);
>   			if (ret < 0)
>   				goto out_free;
>   			if (ret)
> @@ -5710,6 +5710,7 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   			     &cached_state);
>
>   out_free_ulist:
> +	kfree(backref_cache);
>   	btrfs_free_path(path);
>   	ulist_free(roots);
>   	ulist_free(tmp_ulist);
