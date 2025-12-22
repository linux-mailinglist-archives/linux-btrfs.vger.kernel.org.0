Return-Path: <linux-btrfs+bounces-19956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86DCD700D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 20:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5EBE301C3D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA12673AA;
	Mon, 22 Dec 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lNjQRaFG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F272B2DA
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766433000; cv=none; b=QbGO3t6UVJM/DINacsTRAqrgy9nTd6EwHUze/U8A94mGTX2oTZgX9q8dcYjfkYEv3EQcoNR+8xpacijc4bofQK0xaAlxFbRJh50SWah8MazJ/6fnfcXlrgyM6Vq4RdBMrQa0DTJ0TiyJLQFGIrcXfH6RxPjBH2W5ZWv2DxX7V90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766433000; c=relaxed/simple;
	bh=aaSsGeg1y4h/XS1aeoFaopOz22YV9PisL2J1lVHh3GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sv9CPitW1eejBRGGcB91HG+uzEl/noPdCZpXuLL4DsOmxIjgckw53NSOQc22cRN96w5L7y0q9pFiAXvBkfw9nMwcFIiTiAsywjz1aVeyxrJ3CuSRjwjaN4V+/D2AQU4hJqKcprmlHsmmAHpf/8H9/mhtymISOFwJvDX8/XD/STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lNjQRaFG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766432995; x=1767037795; i=quwenruo.btrfs@gmx.com;
	bh=VNtDeKzhh9LZUJXWeaTiXf3yoxEjzJ+Z/OoFGgHbqo0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lNjQRaFGHrkZE5pSvkst0fraXKSWDGMqgGuzjvylD7Wm61llKwxyBWfM7OyJkkMH
	 +UaRL9rHauFh4qzeyaCkjyAvVnA09STe2EDBtMhLGYWfig6gwJ3ok2mxA+RkAwyBR
	 Gpv1HHMMfB708quZtduJKjlJQyqyw1ja0K3P1UrKTovbJ4lPI8Fn5BC2o/1TO7dVl
	 xHWRooC/V6g+8KMCNWP56vHleH+Bu+IxHYsgW+wMHkw8t1T2J9ao4Clj6lvLwayox
	 gCa4vkGLWGKnwS50gHMLBnxe+9kxbqVk5tJ8XDzjApj6ooL2TZJXb5UBi7CyLgEbM
	 Me9WtMa/wRHyP4Op6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU4y-1w7w501xEy-00eg8A; Mon, 22
 Dec 2025 20:49:55 +0100
Message-ID: <a85e28ee-6a66-461f-97d1-a65de6e4b800@gmx.com>
Date: Tue, 23 Dec 2025 06:19:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FOP_DONTCACHE when btrfs Direct IO fallback to buffered IO
To: Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20251221215913.E7B2.409509F4@e16-tech.com>
 <20251222230749.FFE2.409509F4@e16-tech.com>
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
In-Reply-To: <20251222230749.FFE2.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGIozbiNiaRTuZyUwbjBc69lOYTk2vaCEh+6nqG/qFxNCBitog1
 sJXprdm1fC7SxBBmEViqByvrXIJt1UZnQNLtHaS4zB6wf/GAgHJiF2rsYkJoUnFYtXRhGTM
 w3r+8UP5rbT6N+W2hweQu/YxIpfT7xEOcnM/yW7gsS0072L+QBUBXhtRnzYPj6g13b+01q8
 Xf0uqOEuBlEjczjCLm96w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V8aY5y7o2U4=;l+Rl8lkl0aJOb7s3FKZZiJudzea
 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



=E5=9C=A8 2025/12/23 01:37, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
>=20
>> Hi,
>>
>> Could we add FOP_DONTCACHE support when btrfs Direct IO fallback to buf=
fered IO?
>>
>> I noticed similar logic in zfs-2.4.0 too.
>>
>> https://github.com/openzfs/zfs/releases/tag/zfs-2.4.0
>> Uncached IO: Direct IO fallback to a light-weight uncached IO when unal=
igned
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2025/12/21
>=20
> The following dirty patch seems work here.
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/12/22
>=20
>=20
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 802d4dbe5b38..2642dceb6911 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -881,6 +881,7 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struc=
t iov_iter *from)
>   	 */
>   	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>   		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		iocb->ki_flags |=3D IOCB_DONTCACHE;
>   		goto buffered;
>   	}

Nope, run the full fstest and you will crash.

The problem is how btrfs handling compression, the writeback range for=20
compression will stay locked (thus async), and can be marked writeback=20
at almost any time.

That's why we have all the extra per-block handling for writeback other=20
than other fses' regular mark the full folio writeback.

>  =20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fa82def46e39..64eae7417242 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3843,7 +3843,7 @@ const struct file_operations btrfs_file_operations=
 =3D {
>   #endif
>   	.remap_file_range =3D btrfs_remap_file_range,
>   	.uring_cmd	=3D btrfs_uring_cmd,
> -	.fop_flags	=3D FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
> +	.fop_flags	=3D FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC | FOP_DONTCACHE,
>   };
>  =20
>   int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, lo=
ff_t end)
>=20
>=20
>=20
>=20


