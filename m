Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFF679FFFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjINJ2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbjINJ2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:28:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409ECC7;
        Thu, 14 Sep 2023 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1694683668; x=1695288468; i=quwenruo.btrfs@gmx.com;
 bh=oCugkm3dfVBn11fxI50iTXGZ1c8HaSx0hpYQcCfSwAc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=W+CFqAlkeb8JMOdLLel8j3YOe0YvQKC12QDSX+nfkJlCffGH9iEMfFlruty8rDY9ToQ5qNMhyID
 aiyzVi1ko8IE2tJgKsrmqamyZ+H494XhWKOU3o9yT22gMh971iS5/i7FdZnQ8ZDQqlI0N2bcdICEC
 9MnVehVtCf5BoYW8gWJ8/Jx2mujfVK0kDSM/Qm2u0UnPhKEK3MaoOLV651sv7y7qxhFxIt0yiqtsr
 a/HV/tDtO5mDCCs+OTMLtSP6MJ3cahj1FBr2hJ5OYX2a9knPblVXTOoyZNbIvNz4XUoswFDQY77VF
 FaXH38WLPlPs2RtnKLLu8Ld88K0fLQACKTeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1rC1Ab0fO2-00WVRB; Thu, 14
 Sep 2023 11:27:47 +0200
Message-ID: <0e081f23-5c0c-4a79-8d41-a1bca8a85e28@gmx.com>
Date:   Thu, 14 Sep 2023 18:57:40 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/11] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-2-647676fa852c@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20230911-raid-stripe-tree-v8-2-647676fa852c@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xvtf/YxTL/N3cVm2OAsg2b9A+61WaS5tX85csrqktPKLY9Alj3g
 +grDfe9LkOpN5sgZKQQq6TOG7+s7rXfk/vGC5tz2qYWmSSLx99qFoFiCOGGVCvQIjWomrhL
 ebws04TUMJ8hdfRsb10WGXKs2oAwm5S/XRzRPgkFILtPmx3HcMNs02N4fpwI/IuVGlEyOhN
 IUu4LfTNJ1YIUewRlYHyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sGuGlGc/+ic=;FlZfbLSkx6VS4wSz9vFtvN+s813
 w4Tt+pxu2greZQoJJ3PsGmLAdSsOabPgX7CxFTEqlfBZ1ck3KhmxBD/sZoKz+xBzuzfc0dG/7
 JNb5e9HUcGk0IsZJaHYe63lfZicbYWZBluzvgntoXTKwi/UbPUGo5vosYGyWO7o6kfn4JPIcR
 z9R8cR3/YDuMFLP8sC3UxCbBCk6mGj9REpWr6Tj3UGCSwZphS8Ju5ipMBNcNOxNiFBP/gxMGw
 fyIBUn4YUwmFEq2/BpkXRfVOKWnzgEEPfZ/dc2bB2ynhsmyjWWnJB9NCLuDmJdekbsB+JiaGd
 2BNZEoxStks9nlPFy/tGvKt2/Fa490sYsDjjaYZSOXMP+uw8b4PVQA4z55/w9Saljv3HeOShV
 IrFoteXf1MTz3tgpn8pCegmbeQUKLnt346aCakLNsBhmkHEtLhWMzBMKZAa3ht/PIarlX1gAv
 p4ZTOQ9Xex/Nlx6ONQ7ed2T0MaTFdj18uPDq4EAawRkodfFGx0CTQjqLkn7khKmZa30b7NiAg
 TBam6OwU/erphzqpfoPfT3drQVDo3fqnLrqOfJv22Zm0fQQZj3CHC/1gAsVwZ4rLkur5RAGat
 FwRNUvSg1Hz7sPi8Hg6lmC82qoVGE/oLPaydixivJmwxcXG8TTBXUWFJrtqeS+DKbdwgNCRTI
 4EgYgVSPGfHxUDq2fuHWOVTCmT0oNSOLcmcxlcqAQVJpKIVvL+Iv0zn0BFdSK9weyUmxG07+G
 nNUrKcj4SPRkhYUB6T/PCG4epOIHxf/0RbF8vs+NRJ4mm9SfNPwvbHasJfW9eZtq0nE5xIw0r
 lpUqGjXnNE0X53CzkIbDrQurqXpHYVWf1LUVojt+Y7kW96Tx90GsvHbUQW7t+wq7O8/zZNDZ8
 KJzCAho4OKlREVLuuUm/m50woN5Tx5X3HyPe5Ggu4oP7gGMdfH8IuTio7/dUaCfHw3fEwYrqC
 +xQRUheBoOE8WZV8xkQaeEQexZM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/11 22:22, Johannes Thumshirn wrote:
> If we find a raid-stripe-tree on mount, read it from disk.
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/block-rsv.c       |  6 ++++++
>   fs/btrfs/disk-io.c         | 18 ++++++++++++++++++
>   fs/btrfs/disk-io.h         |  5 +++++
>   fs/btrfs/fs.h              |  1 +
>   include/uapi/linux/btrfs.h |  1 +
>   5 files changed, 31 insertions(+)
>
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 77684c5e0c8b..4e55e5f30f7f 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -354,6 +354,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_=
info *fs_info)
>   		min_items++;
>   	}
>
> +	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
> +		num_bytes +=3D btrfs_root_used(&fs_info->stripe_root->root_item);
> +		min_items++;
> +	}
> +
>   	/*
>   	 * But we also want to reserve enough space so we can do the fallback
>   	 * global reserve for an unlink, which is an additional
> @@ -405,6 +410,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *ro=
ot)
>   	case BTRFS_EXTENT_TREE_OBJECTID:
>   	case BTRFS_FREE_SPACE_TREE_OBJECTID:
>   	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
> +	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
>   		root->block_rsv =3D &fs_info->delayed_refs_rsv;
>   		break;
>   	case BTRFS_ROOT_TREE_OBJECTID:
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 4c5d71065ea8..1ecebcfc1c17 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1179,6 +1179,8 @@ static struct btrfs_root *btrfs_get_global_root(st=
ruct btrfs_fs_info *fs_info,
>   		return btrfs_grab_root(fs_info->block_group_root);
>   	case BTRFS_FREE_SPACE_TREE_OBJECTID:
>   		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
> +	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
> +		return btrfs_grab_root(fs_info->stripe_root);
>   	default:
>   		return NULL;
>   	}
> @@ -1259,6 +1261,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_i=
nfo)
>   	btrfs_put_root(fs_info->fs_root);
>   	btrfs_put_root(fs_info->data_reloc_root);
>   	btrfs_put_root(fs_info->block_group_root);
> +	btrfs_put_root(fs_info->stripe_root);
>   	btrfs_check_leaked_roots(fs_info);
>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>   	kfree(fs_info->super_copy);
> @@ -1804,6 +1807,7 @@ static void free_root_pointers(struct btrfs_fs_inf=
o *info, bool free_chunk_root)
>   	free_root_extent_buffers(info->fs_root);
>   	free_root_extent_buffers(info->data_reloc_root);
>   	free_root_extent_buffers(info->block_group_root);
> +	free_root_extent_buffers(info->stripe_root);
>   	if (free_chunk_root)
>   		free_root_extent_buffers(info->chunk_root);
>   }
> @@ -2280,6 +2284,20 @@ static int btrfs_read_roots(struct btrfs_fs_info =
*fs_info)
>   		fs_info->uuid_root =3D root;
>   	}
>
> +	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
> +		location.objectid =3D BTRFS_RAID_STRIPE_TREE_OBJECTID;
> +		root =3D btrfs_read_tree_root(tree_root, &location);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret =3D PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->stripe_root =3D root;
> +		}
> +	}
> +
>   	return 0;
>   out:
>   	btrfs_warn(fs_info, "failed to read root (objectid=3D%llu): %d",
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 02b645744a82..8b7f01a01c44 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -103,6 +103,11 @@ static inline struct btrfs_root *btrfs_grab_root(st=
ruct btrfs_root *root)
>   	return NULL;
>   }
>
> +static inline struct btrfs_root *btrfs_stripe_tree_root(struct btrfs_fs=
_info *fs_info)
> +{
> +	return fs_info->stripe_root;
> +}
> +

Do we really need this? IIRC we never have a wrapper or fs_info->fs_root.

Thanks,
Qu
>   void btrfs_put_root(struct btrfs_root *root);
>   void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
>   int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transi=
d,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index d84a390336fc..5c7778e8b5ed 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -367,6 +367,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *uuid_root;
>   	struct btrfs_root *data_reloc_root;
>   	struct btrfs_root *block_group_root;
> +	struct btrfs_root *stripe_root;
>
>   	/* The log root tree is a directory of all the other log roots */
>   	struct btrfs_root *log_root_tree;
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..b9a1d9af8ae8 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
>   #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
>   #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
>   #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
> +#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
>
>   struct btrfs_ioctl_feature_flags {
>   	__u64 compat_flags;
>
