Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCF529BD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiEQIKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiEQIKI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:10:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED83C72F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652775002;
        bh=HMJ6WNuEOtpdyR4GaC4kX9+sUyUMojx13iPUXF/4FYw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A46PJZBbRyXuhyWQ92y9TX0KAMjgOjMLWc7NLSR825N3c6gn9tj7CNV74az0e+aYO
         +pLljSPwP0sC/f0xNTQZRRXZUiyjm4w/3QIpy4dLwK73adshPmhJIFFj5zAYLULdAj
         lccYUfj4VjXWBVAT+H5JMl2UGty20NrSD33Jo4hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1oJQgr0s6S-00ScpN; Tue, 17
 May 2022 10:10:02 +0200
Message-ID: <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
Date:   Tue, 17 May 2022 16:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cg4r/M9E7O19rfqPazK2Lfq6a8gSWTZDWEbwpE/Zv4gUq4zpeO+
 s43S6XsqfZ2ctj1S/RlNIpYh8Iju2wGXh9EGzR5v8m/fDolY9uc3T+0FLB7MdkRwCkysCFs
 PtP1ivREitWvtNmjkknAKjhC602J9F0En9n2mIfIygvxYOXVhSKP2nf4mrY3/Ujy5ChLae8
 q1P/LhNpIU2TJj4iqsZMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IkmVauAozu8=:AVWWgkTkQIBQEP8VtZdfWN
 QfaFeLyFMTIlpTETh18vXNB/YCp6VxF5fLucb+k35VZhbC2u25AzB4sfXy13/nvkHpfxpQ7qn
 2L+Qql++d3PMBah/3ahuJRJd3bOPjOa3r2POZJdegOvSTYhGwlShoxMgoqOujyDWLWfQONuK8
 LbeZ8bOV4aYQD5oPJgHrChvaXo+qNMpQhT6Qmh0DBaehSB2DGFr8VldpMEgZLJPtlJGRwJRLe
 QGv7rvrv+Ttokia9cQJzY9LI6PE5Ps7PNaU4gjDbsWaBCfD0KidSQSKovQmfkEojFRT1BceFx
 dGUUbdEE8v9WCNhh64PzOxDEXI0Tdd6bY1E/hIGbUHM39kxyjsE0RpIXhEVg2SA8EZiK5nDZq
 SaHf2YbLKzYGhNAhILyXfD6XQ7Pu68MoieYbwmF7ruuq/BeoXrxRJ5T6MHqpQ4ii5KB7xLg/7
 4Ihgny3f3TvDo94F6zucIABh5t8n7plH/leeiypgxzOMz2Y2vSUqCjeundj/x4FGmXS06EO6P
 WLU+QBOIPYf9g88ERRBUT0dqvxE3XzB1BXNnMfvu53qgSyf3yEpo48eI3sw2kld5Sn7QiuD0m
 7FBjNSWOAlQhhn5hTSzPHdA+Ur9UZNSvZtwrBVwoNr5ibMHhEwXUDS7AvCg1ZRhkodpO+6fkG
 yQtIrESKwEPvxosDInVHASykv+5Lp9ZZ3+Edb72XJ0J0y0YnoaksQPMdUmtr2ze13hICwknuQ
 0l1d67JBc4UKawmMogQ3UL8z6KcMgBnDuoinuq6s7sKFbJFr9eKnwnoci7V7+9MDroTR7QYty
 3BPOaqLws9unjJSv1CVFL2oeVubD9czmq/YAXdjO+ilpA5VUSf5JV1c1YffOxVGjpnfq6b2vi
 adaeWbHO4w6La4xmGeA+ACZCMVyAcKRNSvCZ/EilIdqHHXET9yGPA6DYn5+/6YfMuDQkxAagv
 Wq33j7WJvU8T9AGOg+EpyqriTqT4YpHp7vvkIg/WsnDb8G3vmwr7YmAL+SwYnKyFaUHpaajog
 nmrdRknlbBsmX6aPomPifmh0lbdsQ1EEQTVdju9DgKucmYeS6lpGUjxhmRMuWpNJ2rdtevQrw
 vFKzhxXOgbUcss=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 22:31, Johannes Thumshirn wrote:
> If we're discovering a raid-stripe-tree on mount, read it from disk.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.h           |  1 +
>   fs/btrfs/disk-io.c         | 12 ++++++++++++
>   include/uapi/linux/btrfs.h |  1 +
>   3 files changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 20aa2ebac7cd..1db669662f61 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -667,6 +667,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *uuid_root;
>   	struct btrfs_root *data_reloc_root;
>   	struct btrfs_root *block_group_root;
> +	struct btrfs_root *stripe_root;
>
>   	/* the log root tree is a directory of all the other log roots */
>   	struct btrfs_root *log_root_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d456f426924c..c0f08917465a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1706,6 +1706,9 @@ static struct btrfs_root *btrfs_get_global_root(st=
ruct btrfs_fs_info *fs_info,
>
>   		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
>   	}
> +	if (objectid =3D=3D BTRFS_RAID_STRIPE_TREE_OBJECTID)
> +		return btrfs_grab_root(fs_info->stripe_root) ?
> +			fs_info->stripe_root : ERR_PTR(-ENOENT);
>   	return NULL;
>   }
>
> @@ -1784,6 +1787,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_i=
nfo)
>   	btrfs_put_root(fs_info->fs_root);
>   	btrfs_put_root(fs_info->data_reloc_root);
>   	btrfs_put_root(fs_info->block_group_root);
> +	btrfs_put_root(fs_info->stripe_root);
>   	btrfs_check_leaked_roots(fs_info);
>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>   	kfree(fs_info->super_copy);
> @@ -2337,6 +2341,7 @@ static void free_root_pointers(struct btrfs_fs_inf=
o *info, bool free_chunk_root)
>   	free_root_extent_buffers(info->fs_root);
>   	free_root_extent_buffers(info->data_reloc_root);
>   	free_root_extent_buffers(info->block_group_root);
> +	free_root_extent_buffers(info->stripe_root);
>   	if (free_chunk_root)
>   		free_root_extent_buffers(info->chunk_root);
>   }
> @@ -2773,6 +2778,13 @@ static int btrfs_read_roots(struct btrfs_fs_info =
*fs_info)
>   		fs_info->uuid_root =3D root;
>   	}
>

I guess in the real patch, we need to check the incompatble feature first.

Another problem is, how do we do bootstrap?

If our metadata (especially chunk tree) is also in some chunks which is
stripe-tree mapped, without stripe tree we're even unable to read the
chunk tree.

Or do you plan to not support metadata on stripe-tree mapped chunks?

Thanks,
Qu
> +	location.objectid =3D BTRFS_RAID_STRIPE_TREE_OBJECTID;
> +	root =3D btrfs_read_tree_root(tree_root, &location);
> +	if (!IS_ERR(root)) {
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +		fs_info->stripe_root =3D root;
> +	}
> +
>   	return 0;
>   out:
>   	btrfs_warn(fs_info, "failed to read root (objectid=3D%llu): %d",
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d956b2993970..4e0429fc4e87 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -310,6 +310,7 @@ struct btrfs_ioctl_fs_info_args {
>   #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
>   #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
>   #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
> +#define BTRFS_FEATURE_INCOMPAT_STRIPE_TREE	(1ULL << 14)
>
>   struct btrfs_ioctl_feature_flags {
>   	__u64 compat_flags;
