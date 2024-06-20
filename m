Return-Path: <linux-btrfs+bounces-5831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F038B90FB1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 03:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA031F21794
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 01:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24317545;
	Thu, 20 Jun 2024 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KRg4e8Ap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37A13ACC
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848771; cv=none; b=gDCCEffmOLwwlgOMN0y1QxbUNccV/jxgT7yut3MSwImGIUDFcgOIuR8txEYTOEAxAjyP8b4zx9oJ//FgDh/fy8KFzF5pVj801cA52WaHJwwOVjBPEUzO0kce0yM36G/iyqfF8DXF919EGzU/3gf6V/vG7LUuFJVwZEdAP8whF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848771; c=relaxed/simple;
	bh=mHsPfpJ+TifELK7IsuPgLtnS68BakWWR5FwLJtxwnOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ikUUSzcWUddRpSiwy7HWYATCabHfUYApgYG3ZJKqzyR4DY+UkXpXHPzwpwqrlhTUPO9HBiz/jS1nPFfU+m/UBWDrH4F8Dq1FtOf2WUVIPRJThspCQjB2/fy7Ir48WIl35DhLtTRVWM84/DjKjVx3peYahF8eCtu6aaiCFW7p49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KRg4e8Ap; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718848766; x=1719453566; i=quwenruo.btrfs@gmx.com;
	bh=1KblCrE5P6O8qgRO18zSu3lWlkAFtKRXnZUun+HlbxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KRg4e8Apw02rLY0Y2AjyqFFGWDDjKSKSgGjoRzJ1PbEBGlw8fjeCURwYmQBKxbF7
	 P//0rZGiogUarrDwsvGGtLrxchBhJFcF5UUGSazUc549QGe/nRPZgdQWUIl3ApGNU
	 naqtX98dReyR1R/0oE3jlXiPd2PZ8SY7jRW+mI2IO7BQFS3uejzK5RIe7jFz8iGmq
	 Jgm9vYN5vbfqIDjn2BZ17s0hcTxO3lRqiXcmRZT2f7eWR+v2H74vsnsTWAz6ab1z2
	 Q1JZzP27r9aCZLbWEnjk+DT1n5UwClJijzupXCXWstTw7lDIpVIJZHJ3ivenhrseo
	 00wHxj+FAKR83J6oCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1rrLuO1avZ-00VXrB; Thu, 20
 Jun 2024 03:59:26 +0200
Message-ID: <5e580529-ca09-4ede-930e-d8ae5622c0cf@gmx.com>
Date: Thu, 20 Jun 2024 11:29:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] btrfs: qgroup: preallocate memory before adding a
 relation
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1718816796.git.dsterba@suse.com>
 <950a5c2128b1ea79be6c7c438649b71201db00dc.1718816796.git.dsterba@suse.com>
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
In-Reply-To: <950a5c2128b1ea79be6c7c438649b71201db00dc.1718816796.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aFZmsTvT31+gu9Jzyx0kW8CvwPIxmjEyA98behT3udPxwbn92eO
 zjwfz7ZkPi/qh+TuyIYaH+IB9KvHCjtGv0rpO8srz4QBfmBYkBgRRVQjAsQjNuCpMvC7zjj
 InifsUDEXYesJr9ejnIqgMpMTpestmEEGaiOpPEy5mif8UKMFRRlIRvaGtXxXx2X/RAJbWq
 M4mDNwJ1Djsf2Hcl+u2tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pKADIc3jd+c=;g+xgG/IfOgpTJ9at6/PqxLg0tvH
 mP6LO78Dw1ps+NMHlIc9SR5QX+zJ8dcHmXGl9mMfGz0R81omLvgldXQzxsGQTl0GpbYxJd1vB
 wn/ni+dDYz+VREjwsvKIr5TT5AfruVAg20XZEF74qKemX1f0jiNicMqvIu+RQX4iU80VqRQp3
 wBBEmMzX8t+86wzhAJu0m58HjdJVB/yJzHy/n46ba56XYPqRCuhY+JiBKG8jDFpe6LYZ0zE+q
 cIciBBvPdACYQHM1/4Kjge9ntn+d8a9lOrn0V9PSaRNohsUs+kA/URjQurGZ5HwMRKSGPYXsS
 qnotbXw9YQBQ5pT5xrX6+B0j3ORQNxFFMqZaxumGTFLoAmPK+YXlpdCvU5gKmoX5ATCfZfKhh
 a/lnRnImXtFoA5sCIeN1KbduU/EXlLNo+ggWrkFLB4Qy24+13vCE+cICwOtd5IWo+bx0+aqrx
 pPzmlfb+YEg33M7QwxiRD8vWvRrsp/1OxXS6iOkMymurtsNluMHzhPQN+B1JqtiOMlUHAtlRP
 yeXRSqaxvBMWDV0EJue4IEvYlgHBGQ/qdN7bWdwEtpVgQe9ZpVRKCZZSTqFUx/JQhTeGfrmlv
 QiHM2lhsiaZ1iSLjjyEbyEGHcLkkqsQzSOB+WLFp3rhE89E0luV+kVoCMENOuRkPg3yU77szT
 nw7FO0rT8eNuWu04K4OG0QLF7osjyUwvKzi8iDEg3V4XzxDlbkZ+ufUH/31++U9ljn9enk+9L
 aJ6a39YfBtjoudTC8vKu0D19DYqJSEFli3GZ1tVNJVFhUd//1dRaeC/bjvAxoVh4RDrVPcS9j
 LxOHfjr3QtpTbHYpqVKqJBo6rFHrW2Vp8YJaHObHiJXZM=



=E5=9C=A8 2024/6/20 02:39, David Sterba =E5=86=99=E9=81=93:
> There's a transaction joined in the qgroup relation add/remove ioctl and
> any error will lead to abort/error. We could lift the allocation from
> btrfs_add_qgroup_relation() and move it outside of the transaction
> context. The relation deletion does not need that.
>
> The ownership of the structure is moved to the add relation handler.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/ioctl.c  | 20 ++++++++++++++++----
>   fs/btrfs/qgroup.c | 25 ++++++++-----------------
>   fs/btrfs/qgroup.h | 11 ++++++++++-
>   3 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d28ebabe3720..31c4aea8b93a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3829,6 +3829,7 @@ static long btrfs_ioctl_qgroup_assign(struct file =
*file, void __user *arg)
>   	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	struct btrfs_ioctl_qgroup_assign_args *sa;
> +	struct btrfs_qgroup_list *prealloc =3D NULL;
>   	struct btrfs_trans_handle *trans;
>   	int ret;
>   	int err;
> @@ -3849,17 +3850,27 @@ static long btrfs_ioctl_qgroup_assign(struct fil=
e *file, void __user *arg)
>   		goto drop_write;
>   	}
>
> +	prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
> +	if (!prealloc) {
> +		ret =3D -ENOMEM;
> +		goto drop_write;
> +	}
> +
>   	trans =3D btrfs_join_transaction(root);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;
>   	}
>
> -	if (sa->assign) {
> -		ret =3D btrfs_add_qgroup_relation(trans, sa->src, sa->dst);
> -	} else {
> +	/*
> +	 * Prealloc ownership is moved to the relation handler, there it's use=
d
> +	 * or freed on error.
> +	 */
> +	if (sa->assign)
> +		ret =3D btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
> +	else
>   		ret =3D btrfs_del_qgroup_relation(trans, sa->src, sa->dst);
> -	}
> +	prealloc =3D NULL;

This leads to memory leak, as if we're doing relation deletion, we just
do the preallocation, then reset prealloc to NULL, no way to release the
preallocated memory.

Thanks,
Qu

>
>   	/* update qgroup status and info */
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
> @@ -3873,6 +3884,7 @@ static long btrfs_ioctl_qgroup_assign(struct file =
*file, void __user *arg)
>   		ret =3D err;
>
>   out:
> +	kfree(prealloc);
>   	kfree(sa);
>   drop_write:
>   	mnt_drop_write_file(file);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 3edbe5bb19c6..4ae01c87e418 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -155,16 +155,6 @@ static inline u64 btrfs_qgroup_get_new_refcnt(const=
 struct btrfs_qgroup *qg, u64
>   	return qg->new_refcnt - seq;
>   }
>
> -/*
> - * glue structure to represent the relations between qgroups.
> - */
> -struct btrfs_qgroup_list {
> -	struct list_head next_group;
> -	struct list_head next_member;
> -	struct btrfs_qgroup *group;
> -	struct btrfs_qgroup *member;
> -};
> -
>   static int
>   qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objecti=
d,
>   		   int init_flags);
> @@ -1568,15 +1558,21 @@ static int quick_update_accounting(struct btrfs_=
fs_info *fs_info,
>   	return ret;
>   }
>
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src=
, u64 dst)
> +/*
> + * Add relation between @src and @dst qgroup. The @prealloc is allocate=
d by the
> + * callers and transferred here (either used or freed on error).
> + */
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src=
, u64 dst,
> +			      struct btrfs_qgroup_list *prealloc)
>   {
>   	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>   	struct btrfs_qgroup *parent;
>   	struct btrfs_qgroup *member;
>   	struct btrfs_qgroup_list *list;
> -	struct btrfs_qgroup_list *prealloc =3D NULL;
>   	int ret =3D 0;
>
> +	ASSERT(prealloc);
> +
>   	/* Check the level of src and dst first */
>   	if (btrfs_qgroup_level(src) >=3D btrfs_qgroup_level(dst))
>   		return -EINVAL;
> @@ -1601,11 +1597,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_=
handle *trans, u64 src, u64 dst
>   		}
>   	}
>
> -	prealloc =3D kzalloc(sizeof(*list), GFP_NOFS);
> -	if (!prealloc) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
>   	ret =3D add_qgroup_relation_item(trans, src, dst);
>   	if (ret)
>   		goto out;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 95881dcab684..deb479d176a9 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -278,6 +278,14 @@ struct btrfs_qgroup {
>   	struct kobject kobj;
>   };
>
> +/* Glue structure to represent the relations between qgroups. */
> +struct btrfs_qgroup_list {
> +	struct list_head next_group;
> +	struct list_head next_member;
> +	struct btrfs_qgroup *group;
> +	struct btrfs_qgroup *member;
> +};
> +
>   struct btrfs_squota_delta {
>   	/* The fstree root this delta counts against. */
>   	u64 root;
> @@ -321,7 +329,8 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_inf=
o);
>   void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
>   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
>   				     bool interruptible);
> -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src=
, u64 dst);
> +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src=
, u64 dst,
> +			      struct btrfs_qgroup_list *prealloc);
>   int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 sr=
c,
>   			      u64 dst);
>   int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid=
);

