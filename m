Return-Path: <linux-btrfs+bounces-14295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA46AC7B46
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 11:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B42B4A6419
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD11A26980B;
	Thu, 29 May 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GbJoedAV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FB274FCB
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511848; cv=none; b=seBWSV7hLy9+yB/wsxGfqKwyOknvKSJg47HeUBG6ADqMR6co2SMG26Nayl+170i1OoWYUsojmhuZr9b7j/7yWznrJ67xGI3TRLk5k87ScvDJxf0wQD+bmy++MYawJ9tETGMmIm/MbhrCxhVJFgbRIgJAArFKJuwc5kEjfXi0ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511848; c=relaxed/simple;
	bh=jTBvij+gvP/FKqL9PF8G0F/ZYaID0fdgn8eeOHxppWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sIwzT2XJQNZqiAIhDM2gDG8IG+7RO3LZcnr4fMuCtUicfs69dsege8sCEaCvBclDkFw6pTsu2kCWkYevWEaLqqQv8W6RFSrCMG8rQou/PbeFJfxsqTc+b0j5BRLly0K//EaEdqzwhpIZkhEkrXdRUd8AQF7K1SzZdMEnkrAtm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GbJoedAV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748511839; x=1749116639; i=quwenruo.btrfs@gmx.com;
	bh=+0OZ53MRP8pnBn+sDHukeAW17Lq4cln8n8pq9r+dlcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GbJoedAVY68w9OX5kWhKX+JOYvSJ8q/EEQac/twlt+7YjtXJQWgfsfuySB3sPdP4
	 3XDguZY8Uqtnu9HQYy7upEFyKiOzU0Mhz0LXVkIF8XODPYISDsJKrg1d+R2I21gFr
	 3ndOGNEcM9UATbclSyqm+dtjRZaV6vSXCBwBKzPCTqfJAl2AQZKThM/SXj50aITx9
	 UYG/JUDJGO0gNujM30WSxq7JNgrfGwWQ/z9d/o0nbrDb2b7MXxlgG1xyM7jaJjKjl
	 4Hj0uFQ/Y8ItusfL9mvPn1I/IYIgrDnevxcd2dNupGsu+vGLhJZjl66Q6nlYNt9O8
	 09g5QWk6msAfbn5Tdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw3N-1uluHN32iB-00kEPP; Thu, 29
 May 2025 11:43:59 +0200
Message-ID: <7e483f82-af39-4fdf-9e28-67cd09f243c7@gmx.com>
Date: Thu, 29 May 2025 19:13:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update superblock's device bytes_used when
 dropping chunk
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250529093821.2818081-1-maharmstone@fb.com>
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
In-Reply-To: <20250529093821.2818081-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ydce4pEv/5fvXlQJ7aZDC+YR3D8tB2c2zXNhoT3m5aUV+8wArGe
 LrqkIxoOzq34qB4/TDEGAsoJcNjCTcC+q5lUIXXwLD4vqVhRD8icZOW0Bdmx5MmhZMi2rCL
 q6qLAx8vJaDPIPPJOG3Vp0AeJm7xOnRKdr5C6K7rWkhxtLiuv0s3ibhJO4a9jytmqz69xY4
 dOGM/yoU/8B/NclyshnAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AVqzxY99/I0=;tgjIn/2tguW7DChQnDXHnmmZka4
 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
 uujXhoUcl3UjO+aM



=E5=9C=A8 2025/5/29 19:07, Mark Harmstone =E5=86=99=E9=81=93:
> Each superblock contains a copy of the device item for that device. In a
> transaction which drops a chunk but doesn't create any new ones, we were
> correctly updating the device item in the chunk tree but not copying
> over the new bytes_used value to the superblock.

Oh! This explains why the image in=20
fsck/020/keyed_data_ref_with_shared_leaf.img has the mismatched result.

It's not an older kernel (almost 4 years after another related kernel=20
fix), but really some bug in the kernel.

>=20
> This can be seen by doing the following:
>=20
>   # cd
>   # dd if=3D/dev/zero of=3Dtest bs=3D4096 count=3D2621440
>   # mkfs.btrfs test
>   # mount test /root/temp
>=20
>   # cd /root/temp
>   # for i in {00..10}; do dd if=3D/dev/zero of=3D$i bs=3D4096 count=3D32=
768; done
>   # sync
>   # rm *
>   # sync
>   # btrfs balance start -dusage=3D0 .
>   # sync
>=20
>   # cd
>   # umount /root/temp
>   # btrfs check test
>=20
> (For btrfs-check to detect this, you will also need my patch at
> https://github.com/kdave/btrfs-progs/pull/991.)
>=20
> Change btrfs_remove_dev_extents() so that it adds the devices to the
> post_commit_list if they're not there already. This causes
> btrfs_commit_device_sizes() to be called, which updates the bytes_used
> value in the superblock.
>=20
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> ---
>   fs/btrfs/volumes.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e59aa0b5c4f3..ee886dc08d15 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3272,6 +3272,12 @@ int btrfs_remove_dev_extents(struct btrfs_trans_h=
andle *trans,
>   					device->bytes_used - dev_extent_len);
>   			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
>   			btrfs_clear_space_info_full(fs_info);
> +
> +			if (list_empty(&device->post_commit_list)) {
> +				list_add_tail(&device->post_commit_list,
> +					      &trans->transaction->dev_update_list);
> +			}
> +
>   			mutex_unlock(&fs_info->chunk_mutex);
>   		}
>   	}


