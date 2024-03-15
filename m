Return-Path: <linux-btrfs+bounces-3318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209387C858
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 05:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F93B22D57
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 04:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC9DF4D;
	Fri, 15 Mar 2024 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C/TUESih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C930DDB1
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478015; cv=none; b=GiPHiZ4l96u2Y0fnHI9tI0MTw94JvVrO02ngswLYSHSZLk/VcUOM+lfdq3RG8TEfHFc26VFKZyTsYdrcW4yRIO8hwlRBbpsyjtpSy2zY3lXjt0MfVZi7j1m5Nxd8DOuWPsOBoZs9vpVc5JJkuqWzrCf/Ijdg2+upAUUWEmaEMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478015; c=relaxed/simple;
	bh=i8i/xdvwvbAdRTEtQLIqqPMAPq5BkhA8viCbQE/+CgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pB4y8FDAwrwyPXoZR0lFTbFJB19en+yUH8+M6FShenGzov0Pr+PzzNHW4vihbVXZ29UFiecZbYbKu1Mf4IGGmqqq03JC6C0t7cvOL9IAELgrYeV9+iUOAfOZNjigNNxAfBJsuZtgAeCOVo0OM4NvZ8rPKISqPaBiAg4f/K0EKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C/TUESih; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710478003; x=1711082803; i=quwenruo.btrfs@gmx.com;
	bh=UdwPD8Cnn0RXeeLgvp0CPOtWRVxz53p9L17hqHd8cAo=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=C/TUESih6leAbdsxSYImOTwd3PhKMR8FNKeDYW1w/1J7beseLLPz/SbTHY7Xoz6S
	 7tZaVNOeLK28ZMifkLu6hmjFdeK71L7+x/dcRH6EGWE5pBpgNqw3tifJv7l0UeqyC
	 aFj2nxbxXkzdwsOIEUySjbC75/4R4/6FbIIC6J5SOJuYo8xuXN9/nIMcP4FClioFR
	 rZ6Mk68wyM1VRWkcbiECrNxJoTxWRu6a7f1KMJwpb/yirNFH07TnWkDweTqK3matl
	 hGlU9UkkGJS5mVvSGNF7XrPfaIOfMBHJiuC4EQLuPzvrI3KECF5p5DNuKj08JD9OW
	 UPiA20Q6g43+kH3R7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1qzr440NxL-00pamU; Fri, 15
 Mar 2024 05:46:43 +0100
Message-ID: <565ad4b0-94c2-4c69-8839-3d9a63b8238c@gmx.com>
Date: Fri, 15 Mar 2024 15:16:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: use EXPERIMENTAL instead of
 CONFIG_BTRFS_DEBUG
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
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
In-Reply-To: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uLEqY6OMRjJ+FqEBaRKm528ZoPRj6rO+2LCHDGClctWNwsXCr7n
 jK6cXz+OKhFTZjW2544jZksUoJsSF/ff+7nbP6WOmMwID2ObVobA9qRCjndEU7rGqRdaGg5
 99BzG9BQoVOM3wFLWFDph4JX5hcTPmbdZYkM/xjBktY2DJkpBzq3QtALcxkch7yoPoJ3FnL
 xrzWWcnF5BsaZ77fyDpVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jY2tie8My6A=;XHqOzJgVlZCKnVLRD+8WkIEbLSu
 v+XrGnCIGRi86HS1nNALeKe5iaJGU2PDe2NpnJvGcYHTKMCVvkoOrdff2wqY/O3WUsRb/fjeZ
 ds4tvOI1Ge3Rh0Y0JVTdDIyQq7K8akshPaqU6406SOfXagUa8lkPnt0goxBIpzVWFMX6CrtcT
 RVjYZhXyt6RnEQx7xEbSlRCWiKnUCdXk+QMbVeD/s6/AsE1dwW+BZ9fR9Bmvbm1xyCebLs7GO
 ETdZGhh5MW6cvJ+dUuyvaY86YqK1OUQ5ZR+9wB0v628c8a6e4vGPsXZdK4v28ab63bj4OTurH
 1v4BcnaVaJCF11rJrtjhFp/i07c/1S/6mRuaGorpItDT3REyx0hZfMbDlmm8/O74KXR8OS43U
 wfEt+xVnf+n32Ua/ZNvLtSqGmD8L1dmmOSj8MzmzRxhj/yg4TlPL1ah6xAkWRtsUuZNgnG+79
 /q+PE/V69BSVJPjNgdOuvBbwkaXLQ9oNVVcRBH6QlGU+d5T3/8O6kABa6HyT1vZEf2cmGP3kL
 gtGO0tNw9y1H2/c3s7SIehmwfR0i5wcITbPMxnrajNNyD5KlNL20uTyLJx0WCvhNc2UuO5hKl
 6Jif/BLYpBpdXSJBhBj7+S3zLrm1682sR1vm8bQh90aS93Yq2QRLESVBxycTwsHJn7AXuOAnB
 J9Sq4Vqhrjv3jZjgFcsb/I9SG2Zfaagpjs9OmXY0yDc+Vix0kHwcbGDuMnX4PhtSoSaE+FDkB
 vS7CurU+dLEDQoae31TuJZ5DDX77LzgUqDyshSJNSCW/Wqr9+nd/ym9y5pJMWJW/B2zQflNEx
 DqrC8tBhxVVBk4OVZAR7fP19kyLpdwrpyd7tsPEceYaVg=



=E5=9C=A8 2024/3/15 09:49, Boris Burkov =E5=86=99=E9=81=93:
> not sure exactly how this ifdef was supposed to work originally, but it
> currently doesn't and I don't see other use cases of this pattern.
>
> Use EXPERIMENTAL which does work after:
>
>          ./configure --enable-experimental
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

This seems to be a direct sync between kernel and btrfs-progs, thus we
got the kernel macro not properly translated.

Thanks,
Qu

> ---
>   kernel-shared/send.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel-shared/send.h b/kernel-shared/send.h
> index 34de60ff0..ce4a99e31 100644
> --- a/kernel-shared/send.h
> +++ b/kernel-shared/send.h
> @@ -25,7 +25,7 @@
>
>   #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>   /* Conditional support for the upcoming protocol version. */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#if EXPERIMENTAL
>   #define BTRFS_SEND_STREAM_VERSION 3
>   #else
>   #define BTRFS_SEND_STREAM_VERSION 2

