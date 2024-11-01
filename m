Return-Path: <linux-btrfs+bounces-9279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DC9B8A5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB18DB2209E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C1148FE8;
	Fri,  1 Nov 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PZ98ZpkO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820A29CA;
	Fri,  1 Nov 2024 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730438188; cv=none; b=Xdxc7yWBS6bJJBX9xu6bmy9UQbR0LHCTVRP8Zm+F1tI2RrcrPhTXL1PjzT6Ss42kHY9AbhaHjKCFbfVB/0LSWslyfmIMKNznjja1mYHmJu3eH27KKG4Hv4HkpVZtrzQ7WCkwDoRZf77vpQ7G5IdjPens2qgVm2maxNRplByW3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730438188; c=relaxed/simple;
	bh=5sho6W5rRbcXLF2klckjN7JjUENBGCrzBiUMXKwz/Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiav08XwUH58X8kCgC+4mB1/3SGvn5dW6ai5VprwCembgTCuOakRsXweo+8qZj4CAZxSnTaZW0N1HPmLWgxVQtbh2sFDFoV8O6gRKkFQTZWZtv6cL38ZcVtBcO6Z844wxQGmMbe/NRvc0CHKIN6D0FvXnlydvrEbppnRJCM9m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PZ98ZpkO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730438170; x=1731042970; i=quwenruo.btrfs@gmx.com;
	bh=c1FUVwX2+XzumB2CB/scVMpMsmPonjkmEYzn9ESJtWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PZ98ZpkO+3RaxkhTlf/cvBZZ7OsISlkI9qKSDhszzUS3z1NqFxMArPypKo0P9oGh
	 K90qWllxGTh3l1kRQyJo9+ybvwQSdRgw3nAfyCe8RaUOF3gfJPNk0V8kKifAux9XY
	 iloJOxD2tk7D2/OOfsT9VLeDg3WHjySF6/eCUbXG0L9ukNSEMQNxFCyruUujbFHLS
	 KGqNfJnqlKwQ6TGNOPUK3V2q1NA+A6FttqJXFBokxOGqcCtzWd1MRQq7h5Glqk4AC
	 JnMdXqVKLCIRqU7j9jHB4OoQAn+f8xMFw8rmUmQGYXZ0CLnPiyNZ+ozGPhQEnSkra
	 ZcztMXm80azadG2THg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f9b-1t8fp82Eal-00C9te; Fri, 01
 Nov 2024 06:16:10 +0100
Message-ID: <4ae5d9ef-a49c-43d2-be71-d178d525edb1@gmx.com>
Date: Fri, 1 Nov 2024 15:46:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix data race in log_conflicting_inodes
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com, 21371365@buaa.edu.cn
References: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
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
In-Reply-To: <20241101035133.925251-1-zhenghaoran@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8I3pxZRGycn5LptA3XbOJo/TtBxUh0fm+R2cqmZLDPPizNGSgz
 wCZIIFMyf4XiLw/qMvCJeIp/aMC4L0kXUOqmzCoKk363PvctzFOWh5Ap0u/Ydfv479h1nxZ
 MzqLsPLkRxUzdvFryVRPxon0DkoG1LrEslngA3/MCRaJTsN8NctxT2L2BYLsF7K9+uZjCQs
 lKW+9US21l6pjMgK6X8Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AIh33FUjXCM=;/gaEXSzWIKl8Q3PD8zRmxp4UNlH
 +tiVWW+0bck5nycu4dNznHtJT6FabJZVmpclRt+jhQ+ALbBP9i4jnPwQnzyiu35MsHnKZFAnd
 UKL3gSpdD+s4PdUWeOZkAGk2NUM50+2lWyLGCuq0QoWAwCEGsPUbCn1zQ7leWnhKTNfDowXnQ
 Jm8iejOXE2k9p2RMA8iOrZ2nbZ0DSdsoa2sxNxuLOL5vzdh8wL/5hhXINxIWBtfxaC0CuCRur
 mgEbnzNM+pZHfGrbRmL2MVIydFgJVOq5S930qFn81HmTKjwpt2UGNQO+8PBNvLonBXHvex4UH
 sv8cSzaNC1x7tqin0zvozwxYD3WWBe41VyapYkFuxW17MiYPKibxfsg4XVpau4GhlL+aLYayC
 EIBcFYLfRx+ZYktYBlAvRSz8GpSOOe3FjKaxV0/smy3FiIf54wAMeobdaP/bYJP+Qh46PwAxY
 DHkaGBx/ri5ds18QuAArWUCb9V0hwxofJCe09x0chEac4bh88bxe8EEAV0f4TrcX207QqpPKr
 I3AKW7+UBqxZ/OF2fZRwtANJip729oCObb7GD44K0Dzk/0BYuC/CQ7SuYDrnn98utDFSVvgpI
 n6W2eNtmkoV84sAFz9J7+MX535fBrxKRIhjvpvNEm6xwd71v2GBf6oBvBjyxn62bmdYX4HtMU
 8KKz1Ejvliz/khPPB0Ig7GASviBomqHSMzQ4D1+uSOmhFL8BdmfhV0XjXbtNspHTXuCQgljv9
 7J07yhLMZC3OnelOLUxuFwnq+kvU4WFCunMhxtpCRXWkHL6/A+uQmzIPbRCn03UBHouzLCeuk
 vbCqrLxA+NcSv9QwFFCHnMvg==



=E5=9C=A8 2024/11/1 14:21, Hao-ran Zheng =E5=86=99=E9=81=93:
> The Data Race occurs when the `log_conflicting_inodes()` function is
> executed in different threads at the same time. When one thread assigns
> a value to `ctx->logging_conflict_inodes` while another thread performs
> an `if(ctx->logging_conflict_inodes)` judgment or modifies it at the
> same time, a data contention problem may arise.
>
> Further, an atomicity violation may also occur here. Consider the
> following case, when a thread A `if(ctx->logging_conflict_inodes)`
> passes the judgment, the execution switches to another thread B, at
> which time the value of `ctx->logging_conflict_inodes` has not yet
> been assigned true, which would result in multiple threads executing
> `log_conflicting_inodes()`.
>
> To address this issue, it is recommended to add locks to protect
> `logging_conflict_inodes` in the `btrfs_log_ctx` structure, and lock
> protection during assignment and judgment. This modification ensures
> that the value of `ctx->logging_conflict_inodes` does not change during
> the validation process, thereby maintaining its integrity.
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
> ---
>   fs/btrfs/tree-log.c | 7 +++++++
>   fs/btrfs/tree-log.h | 1 +
>   2 files changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9637c7cdc0cf..9cdbf280ca9a 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2854,6 +2854,7 @@ void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,=
 struct btrfs_inode *inode)
>   	INIT_LIST_HEAD(&ctx->conflict_inodes);
>   	ctx->num_conflict_inodes =3D 0;
>   	ctx->logging_conflict_inodes =3D false;
> +	spin_lock_init(&ctx->logging_conflict_inodes_lock);
>   	ctx->scratch_eb =3D NULL;
>   }
>
> @@ -5779,16 +5780,20 @@ static int log_conflicting_inodes(struct btrfs_t=
rans_handle *trans,
>   				  struct btrfs_log_ctx *ctx)
>   {
>   	int ret =3D 0;
> +	unsigned long logging_conflict_inodes_flags;
>
>   	/*
>   	 * Conflicting inodes are logged by the first call to btrfs_log_inode=
(),
>   	 * otherwise we could have unbounded recursion of btrfs_log_inode()
>   	 * calls. This check guarantees we can have only 1 level of recursion=
.
>   	 */
> +	spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_=
flags);
>   	if (ctx->logging_conflict_inodes)
> +		spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_i=
nodes_flags);

Not an expert on the log tree, but in the above case, the only thing the
spinlock is protecting is a bool.

This looks overkilled to me.

Yes, several booleans can be stored in to a single byte, which can cause
problems.

But in that case, why not changing those booleans into a unsigned long
and use test_bit()/set_bit()/clear_bit() so that the bit operation will
be atomic and no need for the extra spinlock.

Although I haven't check the other boolean usage, but at least for this
@logging_conflict_inodes variable, it looks like atomic bit operation is
safe.

Thanks,
Qu


>   		return 0;
>
>   	ctx->logging_conflict_inodes =3D true;
> +	spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_in=
odes_flags);
>
>   	/*
>   	 * New conflicting inodes may be found and added to the list while we
> @@ -5869,7 +5874,9 @@ static int log_conflicting_inodes(struct btrfs_tra=
ns_handle *trans,
>   			break;
>   	}
>
> +	spin_lock_irqsave(&ctx->conflict_inodes_lock, logging_conflict_inodes_=
flags);
>   	ctx->logging_conflict_inodes =3D false;
> +	spin_unlock_irqrestore(&ctx->conflict_inodes_lock, logging_conflict_in=
odes_flags);
>   	if (ret)
>   		free_conflicting_inodes(ctx);
>
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index dc313e6bb2fa..0f862d0c80f2 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -44,6 +44,7 @@ struct btrfs_log_ctx {
>   	struct list_head conflict_inodes;
>   	int num_conflict_inodes;
>   	bool logging_conflict_inodes;
> +	spinlock_t logging_conflict_inodes_lock;
>   	/*
>   	 * Used for fsyncs that need to copy items from the subvolume tree to
>   	 * the log tree (full sync flag set or copy everything flag set) to


