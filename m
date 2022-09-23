Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD45E75C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiIWI2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiIWI1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 04:27:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDA1DF1B
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663921651;
        bh=DQMCk0/J5d0aXvW+szsszAMbrJ1h2zYUv4VHuqYldfA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PFhD0kgMN7un6i43G4X4GQkqxMYYhwaPFwKVeuTXhod25VG+JTMW2dEe0qeVKYDMt
         03qKTSKQ+mKfBBMCVxceWucXDMgJenXpnQCoE7glS2A8QcL3j1LIsIvuaSc8bSD6u8
         zUQLhhxf1LNZrJt5LZlSb/M9IFXYSnQx0F1dQeZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1pJ7hM2UMg-011U9Y; Fri, 23
 Sep 2022 10:27:31 +0200
Message-ID: <54e2d621-4e74-cd8f-fa41-0ead58898a0c@gmx.com>
Date:   Fri, 23 Sep 2022 16:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs: loosen the block-group-tree feature dependency
 check
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
 <20220923113120.DC30.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220923113120.DC30.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+N/euI/akCEXTNDD++11l8Jsb9n6hB0906e9C+xIJobq0Yt0fN
 R9c/kyo5UMUcauheJi0D83NrX64MtObV2Mr7ukbrYD/4slmDBZPADpItMl0OsgyvmlSE6SO
 dufeunFj4UF//2Qh0P1Nz0xR0XxOIFbX3tNo2jm9CXcfnpF1yGyfbrfm85kfIsY962KloqS
 tNJTCnxHlQS/1OKrHeFSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8m0ab/VEhs=:/KB/R+MW4mXLDebdzZQ+u5
 2LwKH51QnTkxLCB7fEgpPiToVs4q4q5qoytJdb8uAg+K2lD8FVP6JHff4f8g1IaJRyukLjRk5
 mY9k+raNsO0JIvxM3qHVBV6OsxuAOQfG+B08+Io/UFWN5CSu4bm5z9zssNkdf6snS0MTnzli2
 DncSAopPb7PFHqRo1UfpKb0BTnBQE9H3jWQc7UJl7l8HsbQi77OFqwBvh7Qicfq8M0bRzxbAe
 7NkMOgPIOP9ojSmWLoRpm9dytPUeqmQ4yvV1B5H874V0sq2PDAer56kbKbvBzaC4ERzLje5cX
 z+K4OQopgwYn7dxuC3dW7i+KAdXZD1ug3xGzd4Lh0EtqwU6uD3DYHMWvwFsCtmFtjaKr7Q/ly
 04+V6LyQCU6IA/EGa5aKY/CAbNuAKF4NM9xih227h/J41Q/nBXGWutCMITGiyvgolKuexl8YM
 MqHVpzMnfJLz4XXVyfyRCovmWKg1ZEq9djS4j2ZVSLiqJ4oblpjlCv6mWKBjLIrKhnK+PgBZd
 it91ePAtj1fABJcznO3BPfyTpdH82oA0rs2vKaZba/avnWoi5LNPV5QRrFeZqxIiS8GovUGVM
 W6qgOgMCX1rx+85NgR6+I+n4DlbKxYR7nZwErd5y5zBPELWZ1o8bvaR04bXtYhcjWb+JG6HAK
 UZ+b+4nONFNXEAcv734dtQJPSOA2Lcn9J4SC9tXuj0Fs7Q3C7+qYiRGQwWtchvfq0zSrVdgMg
 c+N7TaLwOm0OLMbzu6nqSnClYPDtqVxwttbLUEkK0QWLHh0xT4wj/oAwmplWZNJ9Y898z0pPr
 Cx+Q6AtLS45RE6ZwadToOw82fqAUW0OauubUmWR7gjKebL2MvT/lO09jjMGwcnzVsJKJiJt6G
 wnntQ8I4AI4i+9dafvaHWWMGmMj1yfd0zGCOd7iP2MA/zasJbANjDF194F+VxpLuh4WLyI3YR
 MdIhQ1rOGBjrCSllFCwt1P49W8nNxJ1xS5wQSzIGiERHO+Ra41OHexm1XM7ZTiQ1orXeXmrux
 xZ4Hs7qvroLvMk2FmR9MCbsSRu4L4LPX1pBee951x5bz8m12M06bj3EzRK2rZV+UuP2GATSVX
 DqNLnj2V9UG24ybzy3+GhJpjzOVf462KiGNg9/E1n9oJbmlr6xKcXY52JeBrna6yc6onCuNyA
 KxdxVrRv1EF1UARtfSRDZkVfx1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/23 11:31, Wang Yugui wrote:
> Hi,
>
>> [BUG]
>> When one user did a wrong try to clear block group tree, which can not
>> be done through mount option, by using "-o clear_cache,space_cache=3Dv2=
",
>> it will cause the following error on a fs with block-group-tree feature=
:
>>
>>   BTRFS info (device dm-1): force clearing of disk cache
>>   BTRFS info (device dm-1): using free space tree
>>   BTRFS info (device dm-1): clearing free space tree
>>   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SP=
ACE_TREE (0x1)
>>   BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SP=
ACE_TREE_VALID (0x2)
>>   BTRFS error (device dm-1): block-group-tree feature requires fres-spa=
ce-tree and no-holes
>>   BTRFS error (device dm-1): super block corruption detected before wri=
ting it to disk
>>   BTRFS: error (device dm-1) in write_all_supers:4318: errno=3D-117 Fil=
esystem corrupted (unexpected superblock corruption detected)
>>   BTRFS warning (device dm-1: state E): Skipping commit of aborted tran=
saction.
>>
>> [CAUSE]
>> Although the dependency for block-group-tree feature is just an
>> artificial one (to reduce test matrix), we put the dependency check int=
o
>> btrfs_validate_super().
>>
>> This is too strict, and during space cache clearing, we will have a
>> window where free space tree is cleared, and we need to commit the supe=
r
>> block.
>>
>> In that window, we had block group tree without v2 cache, and triggered
>> the artificial dependency check.
>>
>> This is not necessary at all, especially for such a soft dependency.
>>
>> [FIX]
>> Introduce a new helper, btrfs_check_features(), to do all the runtime
>> limitation checks, including:
>>
>> - Unsupported incompat flags check
>>
>> - Unsupported compat RO flags check
>>
>> - Setting missing incompat flags
>>
>> - Aritifical feature dependency checks
>>    Currently only block group tree will rely on this.
>>
>> - Subpage runtime check for v1 cache
>>
>> With this helper, we can move quite some checks from
>> open_ctree()/btrfs_remount() into it, and just call it after
>> btrfs_parse_options().
>>
>> Now "-o clear_cache,space_cache=3Dv2" will not trigger above error
>> anymore.
>
> btrfs misc-next broken fstests btrfs/056 and more tests.
>
> dmesg output of fstests btrfs/056 failure.
> [  658.119910] BTRFS error (device dm-0): cannot replay dirty log with u=
nsupported compat_ro features (0x3), try rescue=3Dnologreplay
>
> It seems that the root reason is this patch.
>
> this patch or xfstests need to be fixed?

You have already submitted a fix for it, so that's all fine.

But I only found this mail after checking the mailing list some time later=
.

It looks like you never replay with all people involved, thus the mail
only reached my filter for mailling list, not giving a priority for me
to check.

Would you please use "replay-all" features of your mailling client in
the future?
That would greatly improve the reponsiness at least from me.

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/23
>
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 174 +++++++++++++++++++++++++++++---------------=
-
>>   fs/btrfs/disk-io.h |   1 +
>>   fs/btrfs/super.c   |  19 +----
>>   3 files changed, 115 insertions(+), 79 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 54b5784a59e5..d50df66d6ce9 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3292,6 +3292,114 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_in=
fo *fs_info)
>>   	return ret;
>>   }
>>
>> +/*
>> + * Do various sanity and dependency checks on different features.
>> + *
>> + * This is the place for less strict checks (like for subpage or artif=
icial
>> + * feature dependency).
>> + *
>> + * For strict checks or possible corruption detection, they should go
>> + * btrfs_validate_super().
>> + *
>> + * This function also should be called after btrfs_parse_option(), as =
some
>> + * mount option (space_cache related) can modify on-disk format like f=
ree
>> + * space tree and screw up certain feature dependency.
>> + */
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_b=
lock *sb)
>> +{
>> +	struct btrfs_super_block *disk_super =3D fs_info->super_copy;
>> +	u64 incompat =3D btrfs_super_incompat_flags(disk_super);
>> +	u64 compat_ro =3D btrfs_super_compat_ro_flags(disk_super);
>> +
>> +	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>> +		btrfs_err(fs_info,
>> +		    "cannot mount because of unsupported optional features (0x%llx)"=
,
>> +		    incompat);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Runtime limitation for mixed block groups. */
>> +	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
>> +	    (fs_info->sectorsize !=3D fs_info->nodesize)) {
>> +		btrfs_err(fs_info,
>> +"unequal nodesize/sectorsize (%u !=3D %u) are not allowed for mixed bl=
ock groups",
>> +			fs_info->nodesize, fs_info->sectorsize);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Mixed backref is an always-enabled feature. */
>> +	incompat |=3D BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
>> +
>> +	/* Set compression related flags just in case. */
>> +	if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_LZO)
>> +		incompat |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
>> +	else if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_ZSTD)
>> +		incompat |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>> +
>> +	/*
>> +	 * An ancient flag, which should really be marked deprecated.
>> +	 * Such runtime limitation doesn't really need a incompat flag.
>> +	 */
>> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>> +		incompat |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>> +
>> +	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
>> +		btrfs_err(fs_info,
>> +	"cannot mount read-write because of unsupported optional features (0x=
%llx)",
>> +		       compat_ro);
>> +		return -EINVAL;
>> +	}
>> +	/*
>> +	 * We have unsupported RO compat features, although RO mounted, we
>> +	 * should not cause any metadata write, including log replay.
>> +	 * Or we could screw up whatever the new feature requires.
>> +	 */
>> +	if (unlikely(compat_ro && btrfs_super_log_root(disk_super) &&
>> +		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
>> +		btrfs_err(fs_info,
>> +"cannot replay dirty log with unsupported compat_ro features (0x%llx),=
 try rescue=3Dnologreplay",
>> +			  compat_ro);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Artificial limitations for block group tree, to force
>> +	 * block-group-tree to rely on no-holes and free-space-tree.
>> +	 * Mostly to reduce test matrix.
>> +	 */
>> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
>> +	    (!btrfs_fs_incompat(fs_info, NO_HOLES) ||
>> +	     !btrfs_test_opt(fs_info, FREE_SPACE_TREE))) {
>> +		btrfs_err(fs_info,
>> +"block-group-tree feature requires no-holes and free-space-tree featur=
es");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Subpage runtime limitation on v1 cache.
>> +	 *
>> +	 * V1 space cache still has some hard code PAGE_SIZE usage, while
>> +	 * we're already defaulting to v2 cache, no need to bother
>> +	 * v1 as it's going to be deprecated anyway.
>> +	 */
>> +	if (fs_info->sectorsize < PAGE_SIZE &&
>> +	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
>> +		btrfs_warn(fs_info,
>> +	"v1 space cache is not supported for page size %lu with sectorsize %u=
",
>> +			   PAGE_SIZE, fs_info->sectorsize);
>> +		return -EINVAL;
>> +	}
>> +	/*
>> +	 * This function can be called by remount, thus we need spinlock to
>> +	 * protect the super block.
>> +	 */
>> +	spin_lock(&fs_info->super_lock);
>> +	btrfs_set_super_incompat_flags(disk_super, incompat);
>> +	spin_unlock(&fs_info->super_lock);
>> +
>> +	return 0;
>> +}
>> +
>>   int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices=
 *fs_devices,
>>   		      char *options)
>>   {
>> @@ -3441,72 +3549,12 @@ int __cold open_ctree(struct super_block *sb, s=
truct btrfs_fs_devices *fs_device
>>   		goto fail_alloc;
>>   	}
>>
>> -	features =3D btrfs_super_incompat_flags(disk_super) &
>> -		~BTRFS_FEATURE_INCOMPAT_SUPP;
>> -	if (features) {
>> -		btrfs_err(fs_info,
>> -		    "cannot mount because of unsupported optional features (0x%llx)"=
,
>> -		    features);
>> -		err =3D -EINVAL;
>> -		goto fail_alloc;
>> -	}
>> -
>> -	features =3D btrfs_super_incompat_flags(disk_super);
>> -	features |=3D BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
>> -	if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_LZO)
>> -		features |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
>> -	else if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_ZSTD)
>> -		features |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>> -
>> -	/*
>> -	 * Flag our filesystem as having big metadata blocks if they are bigg=
er
>> -	 * than the page size.
>> -	 */
>> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>> -		features |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>> -
>> -	/*
>> -	 * mixed block groups end up with duplicate but slightly offset
>> -	 * extent buffers for the same range.  It leads to corruptions
>> -	 */
>> -	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
>> -	    (sectorsize !=3D nodesize)) {
>> -		btrfs_err(fs_info,
>> -"unequal nodesize/sectorsize (%u !=3D %u) are not allowed for mixed bl=
ock groups",
>> -			nodesize, sectorsize);
>> -		goto fail_alloc;
>> -	}
>> -
>> -	/*
>> -	 * Needn't use the lock because there is no other task which will
>> -	 * update the flag.
>> -	 */
>> -	btrfs_set_super_incompat_flags(disk_super, features);
>> -
>> -	features =3D btrfs_super_compat_ro_flags(disk_super) &
>> -		~BTRFS_FEATURE_COMPAT_RO_SUPP;
>> -	if (!sb_rdonly(sb) && features) {
>> -		btrfs_err(fs_info,
>> -	"cannot mount read-write because of unsupported optional features (0x=
%llx)",
>> -		       features);
>> -		err =3D -EINVAL;
>> -		goto fail_alloc;
>> -	}
>> -	/*
>> -	 * We have unsupported RO compat features, although RO mounted, we
>> -	 * should not cause any metadata write, including log replay.
>> -	 * Or we could screw up whatever the new feature requires.
>> -	 */
>> -	if (unlikely(features && btrfs_super_log_root(disk_super) &&
>> -		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
>> -		btrfs_err(fs_info,
>> -"cannot replay dirty log with unsupported compat_ro features (0x%llx),=
 try rescue=3Dnologreplay",
>> -			  features);
>> -		err =3D -EINVAL;
>> +	ret =3D btrfs_check_features(fs_info, sb);
>> +	if (ret < 0) {
>> +		err =3D ret;
>>   		goto fail_alloc;
>>   	}
>>
>> -
>>   	if (sectorsize < PAGE_SIZE) {
>>   		struct btrfs_subpage_info *subpage_info;
>>
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 7e545ec09a10..c67c15d4d20b 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -48,6 +48,7 @@ int __cold open_ctree(struct super_block *sb,
>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>   			 struct btrfs_super_block *sb, int mirror_num);
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_b=
lock *sb);
>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *b=
dev);
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_devic=
e *bdev,
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index eb0ae7e396ef..b0aeecc932b2 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2014,14 +2014,10 @@ static int btrfs_remount(struct super_block *sb=
, int *flags, char *data)
>>   	if (ret)
>>   		goto restore;
>>
>> -	/* V1 cache is not supported for subpage mount. */
>> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_=
CACHE)) {
>> -		btrfs_warn(fs_info,
>> -	"v1 space cache is not supported for page size %lu with sectorsize %u=
",
>> -			   PAGE_SIZE, fs_info->sectorsize);
>> -		ret =3D -EINVAL;
>> +	ret =3D btrfs_check_features(fs_info, sb);
>> +	if (ret < 0)
>>   		goto restore;
>> -	}
>> +
>>   	btrfs_remount_begin(fs_info, old_opts, *flags);
>>   	btrfs_resize_thread_pool(fs_info,
>>   		fs_info->thread_pool_size, old_thread_pool_size);
>> @@ -2117,15 +2113,6 @@ static int btrfs_remount(struct super_block *sb,=
 int *flags, char *data)
>>   			ret =3D -EINVAL;
>>   			goto restore;
>>   		}
>> -		if (btrfs_super_compat_ro_flags(fs_info->super_copy) &
>> -		    ~BTRFS_FEATURE_COMPAT_RO_SUPP) {
>> -			btrfs_err(fs_info,
>> -		"can not remount read-write due to unsupported optional flags 0x%llx=
",
>> -				btrfs_super_compat_ro_flags(fs_info->super_copy) &
>> -				~BTRFS_FEATURE_COMPAT_RO_SUPP);
>> -			ret =3D -EINVAL;
>> -			goto restore;
>> -		}
>>   		if (fs_info->fs_devices->rw_devices =3D=3D 0) {
>>   			ret =3D -EACCES;
>>   			goto restore;
>> --
>> 2.37.3
>
>
