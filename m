Return-Path: <linux-btrfs+bounces-5861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A969115AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507F61C212F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C0143746;
	Thu, 20 Jun 2024 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RarrqDAl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946479949
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922179; cv=none; b=P151XuBj1bTvfblbb6WiAvmwUfXK6Eg5An2d6WuoqkQphYG+/PeK/rovdzE7QF9J2vEJ2aLzkJQ5EH3OoesDEyw8AmSHJhglm6SLQ6FDmqMhP82Nj27TFwp0k6WnvZl10zLN4oS/aXUAne4Iw7Yuyqq3BeB9xh7q0kVCYVFaA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922179; c=relaxed/simple;
	bh=1w6820zTJrUWarvnWLZzEERyzPjGdRGApJuOTqggVsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gwJfwve/0FIE/2j6Cqi/2aOqsJdV61DRj+/y38pCEmodmIZfcDsdZbQE4iipxXGhW/VkIRNWCM7UpzIt5mDWPPmpJQp1jNOFPHfgeJzIPKG832qGrY2CsZ7ILUC0HrpVdGWSgscEAd28s5bMSpd9zS0zUcYRDnRUTSJnDRXVFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RarrqDAl; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718922174; x=1719526974; i=quwenruo.btrfs@gmx.com;
	bh=3kmL7Qmd9yf5x1C9pVFW2+WwrxJpmkg2Qb2PwGEJ+qw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RarrqDAlzYixAkxa5UtdC7D1eWvAJixQROAVNwTs+lTNuTdytyiQzcVWtCkptxEH
	 zKm6cs7dKbw4sufJ5Fbesh6yFe/aNlNchoDE2teqanPILDjE99mVj0WRQUebkjlgH
	 g4TAuX2lRmsbEs8QhMg3oayWrdSQT1lTxC5jG6FuMSNBQlKKyK9pPDgxZrJ1GRg/O
	 dLgUrEhZvpj2NRzGxy/uPuQopMg6Lvlo4pHYi8hEAOKaiLPpgw24rQsE6JDK5q2eU
	 v3H7qi6KnK46bBSohHAf/8wtf9BT/XyeH4XrR+X53m52K3cOOvhZ68ufajPpz8HEp
	 70uImhxD2tcQZu5tcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXUD-1s2cLS3UG7-00I39c; Fri, 21
 Jun 2024 00:22:54 +0200
Message-ID: <f2d4251f-4389-4fd2-bd7c-cf228fbe76f7@gmx.com>
Date: Fri, 21 Jun 2024 07:52:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: preallocate memory before adding a
 relation
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <5e580529-ca09-4ede-930e-d8ae5622c0cf@gmx.com>
 <20240620174618.4704-1-dsterba@suse.com>
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
In-Reply-To: <20240620174618.4704-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:354dWGBPQngDol2kTDSUIKjQz9s3qtPsIgDjjRrSyXaTwLEyT3s
 WbF1mD455bLGpN8pu9oWb4eBdPspT3iNHai29yzz/NN9spg/j/kCwGpM9oB8dbvWZCoaARM
 LP5Tq5lZ1TViy6rEC3zy4xoaZV94/6JTZx41bAWiDympF6gcPZR3HPhWBlCssqlapqVPVgE
 /PoNn+bL6pxL0Bbm/nk+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TcXD0eTa9IE=;52M6zGxnHqoDZtFuCmqPJStC4FU
 2mqSuyEqzJiXtHDSkpu0zLrMGWyqI4BrvlcfrziFIyGD8wvUs1d6q9T0WlGdMsjmmqRbiahhI
 PI/Na6GezbGa8taH6PISTaYG9KLwRKJbhkmMAjyi/FHK7ULkHc9rJXIXJ8m61Ytb3u9HFQK92
 c0YqhIjWmzas3kMRVM9Pl1ehqOrqAVMgJhowVw0GaI8QLNmm7+9GPiyVctT8PcLgKgVt4q1bS
 5qrQHGQTMRnuCDtN+N0mGoFY54qX3Ke8+Vvo1nyfQ/3LKU6SqZboqFwMJTThwxeN/jWEUBxQX
 0AQvPx68CA9kxrSwNxSsA6e5i1kug0IgH9lQhjwlfs3q8vUY8CNp/xLF5trw2A+wX4tEgkHqZ
 tzCImLHeWEsn7Q0WIXDV518h6FB09FBg8AmTm99ymyQVMfbcNRs7Xhe7IoiYdwLCjhO3gr8la
 f1kQclvFryI5Y7AVcAklDkS7poTU6fSaVNcX45oHIAB09wS73PrTQCIC1jWBCQSAfqfGBfQX1
 4NGBOsc7VBY+OoL1ahowgcbQQigGyuKYufU3ZpEdttuhKub6UpxHZWN2R1ZCTP48n/jQfD+s6
 FJNSajdU0rPdC0Mb0EZ+Nhzkv/iFj/mntKoDwKy3RVfsJ63dolkqL7v2YDNuProEdj0d7e2sH
 sQfdrax1tgHh0y0qXmqHVCd4PNGdVydJNHeU0vdLFwEhrq2EFGkhRDyT1jJzTutWIP0zkGmOk
 /mGRR8zsrWHxffcN07dR1n35jySqz+gq/iojHnlrxGVkNjvGkKdxGv/QGlJMBFfh0JjSAB2h4
 c4Nk8Dcvd3bqHb0TlMhVO7HjoWOt1Kh3U0Yl8FHpGDF0M=



=E5=9C=A8 2024/6/21 03:16, David Sterba =E5=86=99=E9=81=93:
> There's a transaction joined in the qgroup relation add/remove ioctl and
> any error will lead to abort/error. We could lift the allocation from
> btrfs_add_qgroup_relation() and move it outside of the transaction
> context. The relation deletion does not need that.
>
> The ownership of the structure is moved to the add relation handler.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> v2:
> - preallocate only when adding the relation
>
>   fs/btrfs/ioctl.c  | 17 ++++++++++++++++-
>   fs/btrfs/qgroup.c | 25 ++++++++-----------------
>   fs/btrfs/qgroup.h | 11 ++++++++++-
>   3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d28ebabe3720..dc7300f2815f 100644
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
> @@ -3849,14 +3850,27 @@ static long btrfs_ioctl_qgroup_assign(struct fil=
e *file, void __user *arg)
>   		goto drop_write;
>   	}
>
> +	if (sa->assign) {
> +		prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNEL);
> +		if (!prealloc) {
> +			ret =3D -ENOMEM;
> +			goto drop_write;
> +		}
> +	}
> +
>   	trans =3D btrfs_join_transaction(root);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
>   		goto out;
>   	}
>
> +	/*
> +	 * Prealloc ownership is moved to the relation handler, there it's use=
d
> +	 * or freed on error.
> +	 */
>   	if (sa->assign) {
> -		ret =3D btrfs_add_qgroup_relation(trans, sa->src, sa->dst);
> +		ret =3D btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
> +		prealloc =3D NULL;
>   	} else {
>   		ret =3D btrfs_del_qgroup_relation(trans, sa->src, sa->dst);
>   	}
> @@ -3873,6 +3887,7 @@ static long btrfs_ioctl_qgroup_assign(struct file =
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

