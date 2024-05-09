Return-Path: <linux-btrfs+bounces-4848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225F8C085B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81302848FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67891113;
	Thu,  9 May 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="exDR++uO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCA36C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213933; cv=none; b=L1har6vlYCA5W0d18jKl0kddFSpp5c45rYFKexIGgQZIa5qMCR2JstPa3jlpOibZf12QG10sOGMSlb4xyTkxp94B+FnRxTXJ3nyY42LEOpbGfaxiT/y953LYeja/Q8K2rlgEhyiXo+b8dghnTabMZzP8xKO9Tcox2PdjG1By8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213933; c=relaxed/simple;
	bh=mlFoIGrKCwdHnCu9gFUOMhNzRNRFasFmimTl9t0ybnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=upZYWNKAPiX1FxROoUxVgFZB0gU6+NQdEGMf3Xf4IjM1aNOuETNPWGIQBtmkpV9JDvkcrX8f4+aTHmDoT4My5CgO8AD3jbC3V05HR21/Uw+2CvRirZczF3M7AXb6FsyybhAKz20MK3eqhO8uebn9WW/bE3WUXRNJ7V8OGSDpLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=exDR++uO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715213924; x=1715818724; i=quwenruo.btrfs@gmx.com;
	bh=DS7R++wXHwsWnm8BmGvPafZvD8uwsSRoERmHBNriih8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=exDR++uOca8fOvVHCcG5VKvtJ29HuHJjlJlYSq1Oa95Zft1aWWC2Xsx8dFOt5EDm
	 oVtLgz1eUmKjuukyrzfEriMUaLIuPu81KC9yXu2H2o085cgTPUu77tmbUwu/QCBsM
	 ++MFJHSC9cvkpmXS+jARwaMPhhmfMuECYNdzb3PHUjLJg/qL6l/UTPaCayHp+FNLZ
	 GUNMJsSz4Ss9n2X2dhDvk5NnO+O1k8/oHWY0YX9OZb2uvsTaEI2iPyG98d7y7dr0k
	 PKX5HVxaFrhxWJOWucYyLMN2BOrpWw0l7cnFGdHdXvyDm7W0w1SFhFO65RK0YCEPl
	 23Pm4L2/nqgRlLGYIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1sBZZT0SjI-00SgDS; Thu, 09
 May 2024 02:18:44 +0200
Message-ID: <31c23133-72fd-4844-8b64-583d36d5e61c@gmx.com>
Date: Thu, 9 May 2024 09:48:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] btrfs: use an xarray to track open inodes in a root
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <b0f3124d15d38e7ab8283821a123fcdd36900e29.1715169723.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <b0f3124d15d38e7ab8283821a123fcdd36900e29.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8UMh/raQPmRbSVijobXr1JlFt+Tq7vmEjdilwV6DNS9L0Mlhq7Q
 Pcxj8//wwAvbqY3D6/FGe/PhNoEdo/yFQaPIgT1WG6zcy6JZKmPcrbX5sSiWqpKhFWCJeXK
 BvNDxb7QxHc3Tg40ZJrJYrVbgGLruvetE5bNw6u6pcX4kkKsqwtAGfZcwErFCq0IWtumxbK
 iVflRsICxCjpq5gr2RS7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ekT0d1l3Umo=;SKUV9GYADuh1c3Y8l+0OpQzA5Fa
 cvq9lICbm92PfAPUn1dyKVOO35LfwOn6iRG8tgfqGdnsaTNh0u/cC7Oa/QMjON+ipGkFdVJoZ
 I+oqk7Bc5r0Sp1VMwsC//3rvJD+7UWxMbmhzrJkvhbKpHuimpnm0hAE4FpCmiEhMr+SV9OZ77
 GyuvMCfn3pbe+jFuFCO1HHPmeWrEVf+V2c4ZFqWV3HbnHqihVprN/6ddUviARIbztUuOWR+lI
 9q380NOTz6QTyJxo4h+RqksVLZDz1pkox7UFaYLUPALaL9JX8nvfd+EflMv9GmE00Hbn9fWj3
 /cf3sQsXHihjiK8/sz8feipe6NcFyTdslJZtk+V1UOzeCJGOwS0Ew/r8blKOjLlNl3ktOs0iL
 5RptTDMffR3L0E45gl3qemElRvYCRmgJ4tfdAJtRZ/jLMakFJ6MFOH1w0lWiCJCGqiJN+dBgH
 jrnW7QMkph6LN/DEJyI6D3vMq31a6S5edGr6WMkTHfdMg9v4IfMoGwvy9acfNDOAhD5PBF9qh
 bHfYrxI68Tiz+5L9QY5w0GtnqGHb/pIvvewsNc7vbSvyBF4eTYn08XB7YKjFYas17wYtzjHTj
 +p2XfOD96yzrKZ25+NB6VbZWbylqlQyQXczFXHScGCDaeiAjvQkMNsmOMBRj4KaRLoHCpPQWC
 Cs/QsT080upOL1oUtZhtgt8JnyQSWtGlv8cOhI4Ym1PxDv29KLJlE0tTuCXNUacPvivZZgkuL
 5CaO/MXyLtgtyo2LA4XllxYwz52FfH23u/HXqEb3aOobOfz11I1u350saEvOivptv6X4fAuzw
 gzgIfSTmf3oCp6mEafgrUUh0Z03FnmSqr288SH1gCVYi4=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently we use a red black tree (rb-tree) to track the currently open
> inodes of a root (in struct btrfs_root::inode_tree). This however is not
> very efficient when the number of inodes is large since rb-trees are
> binary trees. For example for 100K open inodes, the tree has a depth of
> 17. Besides that, inserting into the tree requires navigating through it
> and pulling useless cache lines in the process since the red black tree
> nodes are embedded within the btrfs inode - on the other hand, by being
> embedded, it requires no extra memory allocations.
>
> We can improve this by using an xarray instead, which is efficient when
> indices are densely clustered (such as inode numbers), is more cache
> friendly and behaves like a resizable array, with a much better search
> and insertion complexity than a red black tree. This only has one small
> disadvantage which is that insertion will sometimes require allocating
> memory for the xarray - which may fail (not that often since it uses a
> kmem_cache) - but on the other hand we can reduce the btrfs inode
> structure size by 24 bytes (from 1064 down to 1040 bytes) after removing
> the embedded red black tree node, which after the next patches will allo=
w
> to reduce the size of the structure to 1024 bytes, meaning we will be ab=
le
> to store 4 inodes per 4K page instead of 3 inodes.
>
> This change does a straighforward change to use an xarray, and results
> in a transaction abort if we can't allocate memory for the xarray when
> creating an inode - but the next patch changes things so that we don't
> need to abort.
>
> Running the following fs_mark test showed some improvements:
>
>      $ cat test.sh
>      #!/bin/bash
>
>      DEV=3D/dev/nullb0
>      MNT=3D/mnt/nullb0
>      MOUNT_OPTIONS=3D"-o ssd"
>      FILES=3D100000
>      THREADS=3D$(nproc --all)
>
>      echo "performance" | \
>          tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>
>      mkfs.btrfs -f $DEV
>      mount $MOUNT_OPTIONS $DEV $MNT
>
>      OPTS=3D"-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
>      for ((i =3D 1; i <=3D $THREADS; i++)); do
>          OPTS=3D"$OPTS -d $MNT/d$i"
>      done
>
>      fs_mark $OPTS
>
>      umount $MNT
>
> Before this patch:
>
>      FSUse%        Count         Size    Files/sec     App Overhead
>          10      1200000            0      92081.6         12505547
>          16      2400000            0     138222.6         13067072
>          23      3600000            0     148833.1         13290336
>          43      4800000            0      97864.7         13931248
>          53      6000000            0      85597.3         14384313
>
> After this patch:
>
>      FSUse%        Count         Size    Files/sec     App Overhead
>          10      1200000            0      93225.1         12571078
>          16      2400000            0     146720.3         12805007
>          23      3600000            0     160626.4         13073835
>          46      4800000            0     116286.2         13802927
>          53      6000000            0      90087.9         14754892
>
> The test was run with a release kernel config (Debian's default config).
>
> Also capturing the insertion times into the rb tree and into the xarray,
> that is measuring the duration of the old function inode_tree_add() and
> the duration of the new btrfs_add_inode_to_root() function, gave the
> following results (in nanoseconds):
>
> Before this patch, inode_tree_add() execution times:
>
>     Count: 5000000
>     Range:  0.000 - 5536887.000; Mean: 775.674; Median: 729.000; Stddev:=
 4820.961
>     Percentiles:  90th: 1015.000; 95th: 1139.000; 99th: 1397.000
>        0.000 -    7.816:    40 |
>        7.816 -   37.858:   209 |
>       37.858 -  170.278:  6059 |
>      170.278 -  753.961: 2754890 #######################################=
##############
>      753.961 - 3326.728: 2232312 #######################################=
####
>     3326.728 - 14667.018:  4366 |
>     14667.018 - 64652.943:   852 |
>     64652.943 - 284981.761:   550 |
>     284981.761 - 1256150.914:   221 |
>     1256150.914 - 5536887.000:     7 |
>
> After this patch, btrfs_add_inode_to_root() execution times:
>
>     Count: 5000000
>     Range:  0.000 - 2900652.000; Mean: 272.148; Median: 241.000; Stddev:=
 2873.369
>     Percentiles:  90th: 342.000; 95th: 432.000; 99th: 572.000
>        0.000 -    7.264:   104 |
>        7.264 -   33.145:   352 |
>       33.145 -  140.081: 109606 #
>      140.081 -  581.930: 4840090 #######################################=
##############
>      581.930 - 2407.590: 43532 |
>     2407.590 - 9950.979:  2245 |
>     9950.979 - 41119.278:   514 |
>     41119.278 - 169902.616:   155 |
>     169902.616 - 702018.539:    47 |
>     702018.539 - 2900652.000:     9 |
>
> Average, percentiles, standard deviation, etc, are all much better.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Not familiar with XArray, but reviewing this with the XArray doc indeed
helps me get more used to it.

Thanks,
Qu
> ---
>   fs/btrfs/btrfs_inode.h |   3 -
>   fs/btrfs/ctree.h       |   7 ++-
>   fs/btrfs/disk-io.c     |   6 +-
>   fs/btrfs/inode.c       | 128 ++++++++++++++++-------------------------
>   4 files changed, 58 insertions(+), 86 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 91c994b569f3..e577b9745884 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -155,9 +155,6 @@ struct btrfs_inode {
>   	 */
>   	struct list_head delalloc_inodes;
>
> -	/* node for the red-black tree that links inodes in subvolume root */
> -	struct rb_node rb_node;
> -
>   	unsigned long runtime_flags;
>
>   	/* full 64 bit generation number, struct vfs_inode doesn't have a big
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c03c58246033..aa2568f86dc9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -222,8 +222,11 @@ struct btrfs_root {
>   	struct list_head root_list;
>
>   	spinlock_t inode_lock;
> -	/* red-black tree that keeps track of in-memory inodes */
> -	struct rb_root inode_tree;
> +	/*
> +	 * Xarray that keeps track of in-memory inodes, protected by the lock
> +	 * @inode_lock.
> +	 */
> +	struct xarray inodes;
>
>   	/*
>   	 * Xarray that keeps track of delayed nodes of every inode, protected
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a91a8056758a..ed40fe1db53e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -662,7 +662,7 @@ static void __setup_root(struct btrfs_root *root, st=
ruct btrfs_fs_info *fs_info,
>   	root->free_objectid =3D 0;
>   	root->nr_delalloc_inodes =3D 0;
>   	root->nr_ordered_extents =3D 0;
> -	root->inode_tree =3D RB_ROOT;
> +	xa_init(&root->inodes);
>   	xa_init(&root->delayed_nodes);
>
>   	btrfs_init_root_block_rsv(root);
> @@ -1854,7 +1854,8 @@ void btrfs_put_root(struct btrfs_root *root)
>   		return;
>
>   	if (refcount_dec_and_test(&root->refs)) {
> -		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
> +		if (WARN_ON(!xa_empty(&root->inodes)))
> +			xa_destroy(&root->inodes);
>   		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
>   		if (root->anon_dev)
>   			free_anon_bdev(root->anon_dev);
> @@ -1939,7 +1940,6 @@ static int btrfs_init_btree_inode(struct super_blo=
ck *sb)
>   	inode->i_mapping->a_ops =3D &btree_aops;
>   	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>
> -	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>   	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
>   			    IO_TREE_BTREE_INODE_IO);
>   	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d0274324c75a..450fe1582f1d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5493,58 +5493,51 @@ static int fixup_tree_root_location(struct btrfs=
_fs_info *fs_info,
>   	return err;
>   }
>
> -static void inode_tree_add(struct btrfs_inode *inode)
> +static int btrfs_add_inode_to_root(struct btrfs_inode *inode)
>   {
>   	struct btrfs_root *root =3D inode->root;
> -	struct btrfs_inode *entry;
> -	struct rb_node **p;
> -	struct rb_node *parent;
> -	struct rb_node *new =3D &inode->rb_node;
> -	u64 ino =3D btrfs_ino(inode);
> +	struct btrfs_inode *existing;
> +	const u64 ino =3D btrfs_ino(inode);
> +	int ret;
>
>   	if (inode_unhashed(&inode->vfs_inode))
> -		return;
> -	parent =3D NULL;
> +		return 0;
> +
> +	ret =3D xa_reserve(&root->inodes, ino, GFP_NOFS);
> +	if (ret)
> +		return ret;
> +
>   	spin_lock(&root->inode_lock);
> -	p =3D &root->inode_tree.rb_node;
> -	while (*p) {
> -		parent =3D *p;
> -		entry =3D rb_entry(parent, struct btrfs_inode, rb_node);
> +	existing =3D xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
> +	spin_unlock(&root->inode_lock);
>
> -		if (ino < btrfs_ino(entry))
> -			p =3D &parent->rb_left;
> -		else if (ino > btrfs_ino(entry))
> -			p =3D &parent->rb_right;
> -		else {
> -			WARN_ON(!(entry->vfs_inode.i_state &
> -				  (I_WILL_FREE | I_FREEING)));
> -			rb_replace_node(parent, new, &root->inode_tree);
> -			RB_CLEAR_NODE(parent);
> -			spin_unlock(&root->inode_lock);
> -			return;
> -		}
> +	if (xa_is_err(existing)) {
> +		ret =3D xa_err(existing);
> +		ASSERT(ret !=3D -EINVAL);
> +		ASSERT(ret !=3D -ENOMEM);
> +		return ret;
> +	} else if (existing) {
> +		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
>   	}
> -	rb_link_node(new, parent, p);
> -	rb_insert_color(new, &root->inode_tree);
> -	spin_unlock(&root->inode_lock);
> +
> +	return 0;
>   }
>
> -static void inode_tree_del(struct btrfs_inode *inode)
> +static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
>   {
>   	struct btrfs_root *root =3D inode->root;
> -	int empty =3D 0;
> +	struct btrfs_inode *entry;
> +	bool empty =3D false;
>
>   	spin_lock(&root->inode_lock);
> -	if (!RB_EMPTY_NODE(&inode->rb_node)) {
> -		rb_erase(&inode->rb_node, &root->inode_tree);
> -		RB_CLEAR_NODE(&inode->rb_node);
> -		empty =3D RB_EMPTY_ROOT(&root->inode_tree);
> -	}
> +	entry =3D xa_erase(&root->inodes, btrfs_ino(inode));
> +	if (entry =3D=3D inode)
> +		empty =3D xa_empty(&root->inodes);
>   	spin_unlock(&root->inode_lock);
>
>   	if (empty && btrfs_root_refs(&root->root_item) =3D=3D 0) {
>   		spin_lock(&root->inode_lock);
> -		empty =3D RB_EMPTY_ROOT(&root->inode_tree);
> +		empty =3D xa_empty(&root->inodes);
>   		spin_unlock(&root->inode_lock);
>   		if (empty)
>   			btrfs_add_dead_root(root);
> @@ -5613,8 +5606,13 @@ struct inode *btrfs_iget_path(struct super_block =
*s, u64 ino,
>
>   		ret =3D btrfs_read_locked_inode(inode, path);
>   		if (!ret) {
> -			inode_tree_add(BTRFS_I(inode));
> -			unlock_new_inode(inode);
> +			ret =3D btrfs_add_inode_to_root(BTRFS_I(inode));
> +			if (ret) {
> +				iget_failed(inode);
> +				inode =3D ERR_PTR(ret);
> +			} else {
> +				unlock_new_inode(inode);
> +			}
>   		} else {
>   			iget_failed(inode);
>   			/*
> @@ -6426,7 +6424,11 @@ int btrfs_create_new_inode(struct btrfs_trans_han=
dle *trans,
>   		}
>   	}
>
> -	inode_tree_add(BTRFS_I(inode));
> +	ret =3D btrfs_add_inode_to_root(BTRFS_I(inode));
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto discard;
> +	}
>
>   	trace_btrfs_inode_new(inode);
>   	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
> @@ -8466,7 +8468,6 @@ struct inode *btrfs_alloc_inode(struct super_block=
 *sb)
>   	ei->ordered_tree_last =3D NULL;
>   	INIT_LIST_HEAD(&ei->delalloc_inodes);
>   	INIT_LIST_HEAD(&ei->delayed_iput);
> -	RB_CLEAR_NODE(&ei->rb_node);
>   	init_rwsem(&ei->i_mmap_lock);
>
>   	return inode;
> @@ -8538,7 +8539,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
>   		}
>   	}
>   	btrfs_qgroup_check_reserved_leak(inode);
> -	inode_tree_del(inode);
> +	btrfs_del_inode_from_root(inode);
>   	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
>   	btrfs_inode_clear_file_extent_range(inode, 0, (u64)-1);
>   	btrfs_put_root(inode->root);
> @@ -10857,52 +10858,23 @@ void btrfs_assert_inode_range_clean(struct btr=
fs_inode *inode, u64 start, u64 en
>    */
>   struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u6=
4 min_ino)
>   {
> -	struct rb_node *node;
> -	struct rb_node *prev;
>   	struct btrfs_inode *inode;
> +	unsigned long from =3D min_ino;
>
>   	spin_lock(&root->inode_lock);
> -again:
> -	node =3D root->inode_tree.rb_node;
> -	prev =3D NULL;
> -	while (node) {
> -		prev =3D node;
> -		inode =3D rb_entry(node, struct btrfs_inode, rb_node);
> -		if (min_ino < btrfs_ino(inode))
> -			node =3D node->rb_left;
> -		else if (min_ino > btrfs_ino(inode))
> -			node =3D node->rb_right;
> -		else
> +	while (true) {
> +		inode =3D xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
> +		if (!inode)
> +			break;
> +		if (igrab(&inode->vfs_inode))
>   			break;
> -	}
> -
> -	if (!node) {
> -		while (prev) {
> -			inode =3D rb_entry(prev, struct btrfs_inode, rb_node);
> -			if (min_ino <=3D btrfs_ino(inode)) {
> -				node =3D prev;
> -				break;
> -			}
> -			prev =3D rb_next(prev);
> -		}
> -	}
> -
> -	while (node) {
> -		inode =3D rb_entry(prev, struct btrfs_inode, rb_node);
> -		if (igrab(&inode->vfs_inode)) {
> -			spin_unlock(&root->inode_lock);
> -			return inode;
> -		}
> -
> -		min_ino =3D btrfs_ino(inode) + 1;
> -		if (cond_resched_lock(&root->inode_lock))
> -			goto again;
>
> -		node =3D rb_next(node);
> +		from =3D btrfs_ino(inode) + 1;
> +		cond_resched_lock(&root->inode_lock);
>   	}
>   	spin_unlock(&root->inode_lock);
>
> -	return NULL;
> +	return inode;
>   }
>
>   static const struct inode_operations btrfs_dir_inode_operations =3D {

