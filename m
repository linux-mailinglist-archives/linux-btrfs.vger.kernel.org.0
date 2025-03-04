Return-Path: <linux-btrfs+bounces-12005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DAA4EF61
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 22:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA263A995D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31824DFE1;
	Tue,  4 Mar 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kATGz2d5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033557DA93;
	Tue,  4 Mar 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123895; cv=none; b=rSdMZDS9T8cpalmSv9mQik9+Xg3ZF9QsjfjvyiUYERWRkZCQsovrneH0V41akEyi+WJTAHQwXsU2QIYXiqpon/N0DS4+yDaWRp0nUraRUxzFq7H3le2A2HXAxRxz98Khs2UD0gPrsDeocBG8kYCCKCmq1RBKJdcDpTEJ2r+K6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123895; c=relaxed/simple;
	bh=CG0J/9mGLc+Vzz4CXR8/yLus3sQ64FZ/CFnf54+Tq8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX1a5TnOVJIFTYKDj++V7bTRLqe7yY8v7id5mm6WjZIjTEmb2COW92OxumPg+4k8Mrv4ahwp/xucVEhg7tN9FvtFzs6l1ui+Ne5wankKOmNV0VSvbrStkYAyMmq8Z9VP0ReOmspQP7T9ORAlwqLGHgDU/incQzaUEtamfcvYr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kATGz2d5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741123889; x=1741728689; i=quwenruo.btrfs@gmx.com;
	bh=n7iUomUeAHSzQtCSsuvZl+AvvhUdscvITeBP/MDjCqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kATGz2d5Kmm7ASZlI9KM4uMJy0dcuKSSEt/4i5n7DV5Ie9rAazUR7T7IVCHQxhOt
	 csV5V53lFB9SIn0VHqaQDUTRAeEIs2GZxBBmE6mmnokaKLGwhu/rcpZr7TzDTNg6l
	 DlZNn3m/MPRVVpQ+zquPnM6bN6ys4vqFDYM6oXmaCSY3V4vGN/zdgGhpD00acitiD
	 jWW2/imTeqLUf7E5nKt8/pkmMV6eKh6HMbBoIF65EggV9+eI5C5dfPD0EQgQ85qP2
	 m78rfIqAcOfUH/0J7pSVdVnTQnYD3pyPdFMbYYaI1WZyar1M37C1bq6S2Eu1xcMX8
	 SG4CvLsycGg9QVQIgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1thmuL0tR6-00SAxv; Tue, 04
 Mar 2025 22:31:29 +0100
Message-ID: <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
Date: Wed, 5 Mar 2025 08:01:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304171403.571335-1-neelx@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250304171403.571335-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wBZt9zvV5PPnhiSVrUyVJCXovsXYdsfUoj8B+cc/wzQnJ3hEf7W
 WbVsyo9Ga85JvIGASyNe+K4k1QDjMOESLppExwcJVSjQ94YSq0mxRvV8HrFiUGRZ7pKYqNJ
 BteW8QZ9/BBoabXQLy6CRUAbszy8iGJ1L4/3LZfu055w4RgvdICCKoocpUZ4PZbBOnKwFHT
 eQnFR0ztP4hr6G4t3INFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OU9vcLfOa2g=;MzysRWWGRZIjET2y0Mmb4R+PJma
 Q5oTHAtXJ60P0V0X5ipucgyQzHXfURfZTspz8riOTx7C4+77KZinCTOPXeUb3y4D3/cXtpHT5
 3ZqAvSovV6eefNzYjQn4G3URgazJM4I6lrLp31qhpIv0qIVW+U3H91dj7f4m7eqwZL4NrrM3X
 nQbLyWWjKLUX8CZC67J2zAbfc1NlZFuH8GhqvkYDwsiH7uOGpVlsSUDa7YW054oAH+9MfL98X
 yCMXszp6TuILHF8Zo2K2yBHnCyyVR8Eiv+QI3BUUHDncy3biOWWGAR6OF/JnoEkQcWSiKoOZa
 SGJFI43iXeHSmydDO5/Hmw4h4jBz4lzFAYKVycwkNG8TNKQOzIgiySRX50k5PaLhdR4DQMInL
 h67v0ljwQh8SmFSgEOsPepFMURJYhjYBMPs4cXSm4BiGON7w9+Ry6VYnVvJLNw8SD047vxrfO
 HadTjX48Fo5tLT8ei6wMl6fjoHPGMo/z8ZU2wsuVNjlDj96v0B53o4+ZhKDAizXnicq1TJLTP
 jpWXF2NWZtjDRrLZAiIbIKSK0W5sOP/Xzaolgd4FNPZkAW9sML7HBixXYjLsHTZzjiahWguEi
 BD0sB0p/wSVpBxz1LVcvj2a+UU+0sjdtCIILZ92hE8aqcxj1oM/NhslQ9fP7zQgg+1vawN7wN
 Y9aay5TPpMxHGqxcckiYrhsKfg3YEzle5EkSsyLAK8IbeC9aduZK6hlSztW6qbS5onU6PztFj
 o75XRg4rO1PXsuU5hTHPOoCOBsDUvikjeISXAbQVYgXMmsL6aAww7LTLBkZqip4CdEhCqS77V
 Gi8EmTiUOLhSLQLkIGbCMA4Ej9Pvv4jPCnkrnuTvtDTMSNZHVJc6Bf/vT10UMmwOGs6EX7wga
 fACYfWUuznv8DufTj+mJ1ou9Y8se3cziKkxGF6JlyP25LJLkby+ufQYCQPEbTVzcnXxEoOJc9
 MnUoHuWFJm6J5dALD12SUOE7QWNv3oVmhWNp9j1H917q8wEcWtUMSyXnT5DBIcVOVZseIM/EL
 +xLTK1DweP901Y5GZLuYmpKffFvHSD8VkJjYz6tCljpoZVUyQPf1zMfy/vfQ+YQSTg4DsECgK
 mjAtbZ4VSBliZlSxF2jRZWYsaJ61rTcGfV40cXQhHGVVnrlOh1FQ+2R4TniTI72yWXGZjrsqQ
 LgD8l6tlgyY6Tgx/1ri5sLvrpAl/NW/ZMf2srv7XmNgwiSPEqR9ffOZNsrJLm8FLA4uz+RjE4
 GLv6M+c4unNEf6IHrizH3be6U1kkc5mt5DwFsmzHKCcpOf8pDvDmhkUrFd76DMybcdALbQwTk
 jOVRDQgnygnUBKgRgRVHN0noxK1A09LMeyQE/5UXxP/cwOLffpa2SQafWt4CQYGtiz+ODLE+9
 HuW/Cty49H6RYDdOBKaarmJBo309QIU8kifRJvZQajVEZhWTBDJJbRMfQv

The feature itself looks good to me.

Although not sure if a blank commit message is fine for this case.

=E5=9C=A8 2025/3/5 03:44, Daniel Vacek =E5=86=99=E9=81=93:
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>   fs/btrfs/btrfs_inode.h     |  2 ++
>   fs/btrfs/defrag.c          | 22 +++++++++++++++++-----
>   fs/btrfs/fs.h              |  2 +-
>   fs/btrfs/inode.c           | 10 +++++++---
>   include/uapi/linux/btrfs.h | 10 +++++++++-
>   5 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index aa1f55cd81b79..5ee9da0054a74 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -145,6 +145,7 @@ struct btrfs_inode {
>   	 * different from prop_compress and takes precedence if set.
>   	 */
>   	u8 defrag_compress;
> +	s8 defrag_compress_level;
>
>   	/*
>   	 * Lock for counters and all fields used to determine if the inode is=
 in
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 968dae9539482..03a0287a78ea0 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, struct =
file_ra_state *ra,
>   	u64 last_byte;
>   	bool do_compress =3D (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
>   	int compress_type =3D BTRFS_COMPRESS_ZLIB;
> +	int compress_level =3D 0;
>   	int ret =3D 0;
>   	u32 extent_thresh =3D range->extent_thresh;
>   	pgoff_t start_index;
> @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struc=
t file_ra_state *ra,
>   		return -EINVAL;
>
>   	if (do_compress) {
> -		if (range->compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
> -			return -EINVAL;
> -		if (range->compress_type)
> -			compress_type =3D range->compress_type;
> +		if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> +			if (range->compress.type >=3D BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress.type) {
> +				compress_type =3D range->compress.type;
> +				compress_level=3D range->compress.level;
> +			}

I am not familiar with the compress level, but
btrfs_compress_set_level() does extra clamping, maybe we also want to do
that too?

> +		} else {
> +			if (range->compress_type >=3D BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress_type)
> +				compress_type =3D range->compress_type;
> +		}
>   	}
>
>   	if (extent_thresh =3D=3D 0)
> @@ -1430,8 +1440,10 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   			btrfs_inode_unlock(BTRFS_I(inode), 0);
>   			break;
>   		}
> -		if (do_compress)
> +		if (do_compress) {
>   			BTRFS_I(inode)->defrag_compress =3D compress_type;
> +			BTRFS_I(inode)->defrag_compress_level =3D compress_level;
> +		}
>   		ret =3D defrag_one_cluster(BTRFS_I(inode), ra, cur,
>   				cluster_end + 1 - cur, extent_thresh,
>   				newer_than, do_compress, &sectors_defragged,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index be6d5a24bd4e6..2dae7ffd37133 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -485,7 +485,7 @@ struct btrfs_fs_info {
>   	u64 last_trans_log_full_commit;
>   	unsigned long long mount_opt;
>
> -	unsigned long compress_type:4;
> +	int compress_type;
>   	int compress_level;
>   	u32 commit_interval;
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fa04b027d53ac..156a9d4603391 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -925,6 +925,7 @@ static void compress_file_range(struct btrfs_work *w=
ork)
>   	unsigned int poff;
>   	int i;
>   	int compress_type =3D fs_info->compress_type;
> +	int compress_level=3D fs_info->compress_level;
>
>   	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
>
> @@ -1007,13 +1008,15 @@ static void compress_file_range(struct btrfs_wor=
k *work)
>   		goto cleanup_and_bail_uncompressed;
>   	}
>
> -	if (inode->defrag_compress)
> +	if (inode->defrag_compress) {
>   		compress_type =3D inode->defrag_compress;
> -	else if (inode->prop_compress)
> +		compress_level=3D inode->defrag_compress_level;
> +	} else if (inode->prop_compress) {
>   		compress_type =3D inode->prop_compress;
> +	}
>
>   	/* Compression level is applied here. */
> -	ret =3D btrfs_compress_folios(compress_type, fs_info->compress_level,
> +	ret =3D btrfs_compress_folios(compress_type, compress_level,
>   				    mapping, start, folios, &nr_folios, &total_in,
>   				    &total_compressed);
>   	if (ret)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d3b222d7af240..3540d33d6f50c 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
>    */
>   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>   #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>   #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		=
\
> +					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
>   					 BTRFS_DEFRAG_RANGE_START_IO)
>
>   struct btrfs_ioctl_defrag_range_args {
> @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
>   	 * for this defrag operation.  If unspecified, zlib will
>   	 * be used
>   	 */
> -	__u32 compress_type;
> +	union {
> +		__u32 compress_type;
> +		struct {
> +			__u8 type;
> +			__s8 level;
> +		} compress;
> +	};
>
>   	/* spare for later */
>   	__u32 unused[4];

We have enough space left here, although u32 is overkilled for
compress_type, using the unused space for a new s8/s16/s32 member should
be fine.


Thanks,
Qu

