Return-Path: <linux-btrfs+bounces-3093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4298760F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3521E282F33
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144E452F89;
	Fri,  8 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U3yh3xm8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1685535A2
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890220; cv=none; b=u/TMNkzWr6gOKhbZBDx5++Aj8xiI88sFeieBUDgqqCGg16KDPQjsAfRvIt92NO/4rOCOdmg8Rd+9L/D7n8kbDrBpXd7LXtxZLuuTAtLGCPxpzK82l0Uany/QrnFoVw+D1JSL5+iDlzzJQXNrxeiXQmV2jjFfFKLV03ez8cpjpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890220; c=relaxed/simple;
	bh=gJ35yz8PrAKZOTNWsPfH4LPdU6b3h9SjCEz8JdDHGZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E39TjxGE4XYa/6Xb40dKv2bYOjjsOi9e5wckf4eZpAEX/9U1VkKxbacYHohwUar1uryGUAm1LrisQ1VVE67a55EPiXs6mFHkr4+GXf/0f102ndcgwhy/tPI4e3ZMmWDbuyXiPYWfA+rydt9m2pN6lE/NfzOCufsWWwDQjKP0vBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U3yh3xm8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709890208; x=1710495008; i=quwenruo.btrfs@gmx.com;
	bh=gJ35yz8PrAKZOTNWsPfH4LPdU6b3h9SjCEz8JdDHGZQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=U3yh3xm8Ork6Lb835SLYpvoNtPNyODafkIelvDBQiKKRgVe0yyP3C2FSYCl6cHP8
	 N3mY0PzxuzfwX7iDUo7FUctJZw6ckOKlhGxeuhtRix+qVRhPGt9I7uL41L1PV4XYw
	 kfpCt9hftXoRxWJd81mFEaw4wBzR5CchhpqN3CS/uu9uNJbJQRKCbzNExQTSh9pX5
	 USiOHLedznnAHx+WNm7xnG2r31Ij0Xe78QAXUZZbyXono3f9nGFpIQZwHC0aqbJT2
	 BHB/M4gHVO0d7WXJwbnYm4lpog/7YNijQ53QW3I4qEzrG2P6SW90a4LhAo7RrtV4v
	 VK9X+O3P5A+rru9ocA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1rAICB1bzo-00aZGZ; Fri, 08
 Mar 2024 10:30:07 +0100
Message-ID: <3d4c4e93-36b7-438d-b1b5-53b561852275@gmx.com>
Date: Fri, 8 Mar 2024 20:00:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: zoned: use zone aware sb location for scrub
Content-Language: en-US
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: WA AM <waautomata@gmail.com>, Qu Wenru <wqu@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
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
In-Reply-To: <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UMpU3QKvk2qzb4KBveFiy7KhKsmH2wRXvC+zgvNN+kzOGS6ZALD
 QwQBXhoi1Y+h7ECg/SDUeLsaVRSLnJCzeVe0limPAyM/9f0Md1sGnuwq5s8D4STfXqp2gDh
 ogJvhNme2qWAsfs6V27uKQ1bl1muDUYWq7YeYv6XVTzryGIi8HXpDlnijgLwKuOu2+Zg+bc
 PWnvbnyscZVcB0VWrGiDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SqZcsK6Rle8=;5neCkY72T40LcERte94G8V+z/zT
 49A4h1aEdQefQdV3uxw4ANcu4qtHm56c3WrrWZQPoDBsYIDh8jnocUCrGOeJzzAlWrjPuyVf1
 0KhQ++/SjkVYFpadScf6ylanBJ/ErGgRmtXV9cZUEmMGuBJkIDcFzKYfduhlP9lc9YZJPGj38
 yzhgBEJ3eiifxvXh3E8za5QRRky8bpMJH0xtltJ23uGmhPIpK3hOHboLLC5PEcmngYfxrOX38
 tfvMjYx4/prXFCnOjXukL1kGtvSnFz9/OcXMD21QMU/AGyVCBjhdt6vp1KHmCz4qcH+qtzf+K
 hlK1XFOf8n4zcOk+52EqC3TXi4XhrpOzP3cnWsl3MD5GidBPqucIPurVj34dvPGBJVbISrCJt
 mdvIK4hgZAv6Bhc3J8Z9z/GbF9UMfnh2b53y6wcMnE9W8lI9VH23+yU6+/5r8E3w5bgJTUYDQ
 n/jsIMtNYlL7Cta7c+cbFYZQC1PH8ETgxk2VsHTGnBMJhh/YMsnwhX8GKT/4DUPnddnXas0AU
 dR1uHOugzYK7f2rYH08UGYYoOsGNbryqFpSJI0d9XfOzIF1YTXVRejaH7N5aFYLaFTGHLvaAL
 LHCOfdc/PtMWY9ObCkeVrtHHY880khgM1nQJA1tDCqDLuLJM+0ZH9q082Hqem5HVNmOvHTgaD
 wQtGarUHDVxptF975RfV8MD/9Yljt4fxMsJw0b3019EuTnwSgJMDjD6bA/kM0Wcm9A7nE7w10
 BasBXgnd/BdLM6SvZEdSFlXvdGK8LVv/8UmS5X8RMriiAMMFd1IF/wNb96ZubAhSQ4M6k5unI
 4B0WIbEYwmPjbhNqunjndwu4y5c38cHITBCm+f2fe/cag=



=E5=9C=A8 2024/3/8 19:58, Johannes Thumshirn =E5=86=99=E9=81=93:
> At the moment scrub_supers() doesn't grab the super block's location via
> the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset()=
.
>
> This leads to checksum errors on 'scrub' as we're not accessing the
> correct location of the super block.
>
> So use btrfs_sb_log_location() for getting the super blocks location on
> scrub.
>
> Reported-by: WA AM <waautomata@gmail.com>
> Cc: Qu Wenru <wqu@suse.com>
> Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9Wd=
QnbaawV5Fv5gNXptPUKw@mail.gmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Changes to v2:
> - Handle -ENOENT return from btrfs_sb_log_location
> Link to v2:
> - https://lore.kernel.org/linux-btrfs/75f3da872a8c1094ef0f6ed93aac9bf774=
ef895b.1709554485.git.jth@kernel.org
> Changes to v1:
> - Increase super_errors
> - Don't break out after 1st error
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/933562c5bf37ad3e03f1a6b2ab5a9eb741=
ee0192.1709206779.git.johannes.thumshirn@wdc.com
> ---
>   fs/btrfs/scrub.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..fa25004ab04e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2812,7 +2812,17 @@ static noinline_for_stack int scrub_supers(struct=
 scrub_ctx *sctx,
>   		gen =3D btrfs_get_last_trans_committed(fs_info);
>
>   	for (i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr =3D btrfs_sb_offset(i);
> +		ret =3D btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +		if (ret =3D=3D -ENOENT)
> +			break;
> +
> +		if (ret) {
> +			spin_lock(&sctx->stat_lock);
> +			sctx->stat.super_errors++;
> +			spin_unlock(&sctx->stat_lock);
> +			continue;
> +		}
> +
>   		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>   		    scrub_dev->commit_total_bytes)
>   			break;

