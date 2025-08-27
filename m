Return-Path: <linux-btrfs+bounces-16435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E3B38022
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FB97AA0FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DA34A301;
	Wed, 27 Aug 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MnDtr8Az"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7521ADA4
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291498; cv=none; b=WX7YSnxgMmT6aOAGRKRgDBIHR17lhyE47nIhXrc/iAldljRFpnp0jduMWYmYByajHu/KwmBJTWTj2UHS+NxNliSZrFPKYPiBBb+IAlBzmeKnBtnIJLaehEI7PpHGkdNwmnk3eQQrr5T5wMvT4y1BNP9JARWUuD51DrB69Juw6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291498; c=relaxed/simple;
	bh=rIETF/5TuXf2OGCxGhWb2Y0/OK/NdMniGS6oX6ZQHLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NAQM06S+Zj2KYnbvmLjfSeUmpcTJ/GsoL808GJ0R05fZQrFsm7uTb53qv2EvVPWccSk1nB6ILHmmCHA0MRREGCxOHVXJh3Ad7rLLZqOoCemRPYjeEbtvIUj5aPlmHb9C4+I9MnEtHtAQf/Yuv7MlaY8+uSn+CJyBIXl2NjJdlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MnDtr8Az; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756291493; x=1756896293; i=quwenruo.btrfs@gmx.com;
	bh=/tk5dnTWS/7VHH/jW2tCr8Oc/vkty/tMSEWuLmql77Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MnDtr8AzBtazIMX8SIN0EshKti2P8vVE5VbZBt7gxE1Y29m/VuzcueoUmaw9Y/Lp
	 JTM2RwIY4HhOjhFhx/08YYSlxTjq2+J1wmQJSA+kZZ3h6BKP+DJp1ukfw1msCz1se
	 xc43qxKbGtxjb6TsXxEsoHY7CDhERo3Y7erWleNxmsmIIFGoELCKtMSScS0+yIiv6
	 hdtkcn5QL0c6icDUfeCxZ7K/up4mIcOhg1GtCY8zIKPCQrMV+lrHdKxAExvopMcX7
	 AJ3NmBmRWneluilpuKjw97wiCY2qjTW20N1lgASFD5V5zWvjxLwuhzBs0fqWsnMpc
	 AKLcfJkSk1kbmhHvQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1uBH7U39dw-00eKTy; Wed, 27
 Aug 2025 12:44:53 +0200
Message-ID: <e37b9714-b079-4304-8067-9120d0f16637@gmx.com>
Date: Wed, 27 Aug 2025 20:14:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't allow adding block device with 0 bytes
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
References: <20250827103725.19637-1-mark@harmstone.com>
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
In-Reply-To: <20250827103725.19637-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fsNENb8PH2OQq6mrD+niykobUU89vpZxQk1D1iBuNwo59uz5pQ7
 V2eOLeE4+Sg8AuKdpHlLdWL5242Nxinvv/q61K50xZdi28YJOvd/ae22pyEoPnBd1LI0/DK
 nN+DtwivCtRcpKTSYkBekPQbg//Y3pnF+lPxnv7sDEN02scw8rZTGwwDXKvqtVDAvz7kiFc
 G29L7WJvfXuDoosTOXmYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hFac6f+e2dM=;eBFYAthoGZXov44BQg19cwviUY7
 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



=E5=9C=A8 2025/8/27 20:07, Mark Harmstone =E5=86=99=E9=81=93:
> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
> BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
> longer seen as an error condition.

My bad, that commit changed the handling of zero sized device,=20
previously the caller who checks the returned size now only checks if=20
the ioctl/stat works.

Feel free to send out a progs fix.
>=20
> Unfortunately this is how disconnected NBD devices behave, meaning that
> with btrfs-progs 6.16 it's now possible to add a device you can't
> remove:
>=20
> ~ # btrfs device add /dev/nbd0 /root/temp
> ~ # btrfs device remove /dev/nbd0 /root/temp
> ERROR: error removing device '/dev/nbd0': Invalid argument
>=20
> This check should always have been done kernel-side anyway, so add a
> check in btrfs_init_new_device() that the new device doesn't have a size
> of 0.
>=20
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

The extra kernel checks looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 63b65f70a2b3..0757a546ff5c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path
>   		goto error;
>   	}
>  =20
> +	if (bdev_nr_bytes(file_bdev(bdev_file)) =3D=3D 0) {
> +		ret =3D -EINVAL;
> +		goto error;
> +	}
> +
>   	if (fs_devices->seeding) {
>   		seeding_dev =3D true;
>   		down_write(&sb->s_umount);


