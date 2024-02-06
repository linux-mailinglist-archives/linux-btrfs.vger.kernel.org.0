Return-Path: <linux-btrfs+bounces-2179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FF84BFA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFE21F22CEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777841BDE1;
	Tue,  6 Feb 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h1b4PhiJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DA1BC46
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256898; cv=none; b=b3iRl8RFaJ14LWCCMnAUEdnwF2oXV2/7aL2trAmSpvE75L8bvnu+jub4FZYXzoW8BrMCYjeb5m3iUxQD99kSpOmVoE8F5iCL7+kuv3EeaE9lisXzopDcfsUBiJCN/fnkRwzre/hcBw9XDA72ZItd/947yHxVmEZAni6SRhLsPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256898; c=relaxed/simple;
	bh=MqCEvIBFERdSGGzkHqi7LxXGP8UqNAEPMCMfSfAa5ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxGHg6GpbNYZApEKJjoO7UvWBBKIywlUdyVtMf5VUjpNhPXjFOcw80uFvkltybkOU9a5MnBL+HYyH8cHhJgTKIU7IFIBP2IjEd8pre0HCiEtST5BnnLh2nSirs/GYGAwbp27IlGQK0fS+dR1VkoM0SsWLAekmOqpOSQXLa4tz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h1b4PhiJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707256890; x=1707861690; i=quwenruo.btrfs@gmx.com;
	bh=MqCEvIBFERdSGGzkHqi7LxXGP8UqNAEPMCMfSfAa5ZQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=h1b4PhiJgoSgw2gqacZ6UPzYiSyZje54AwsVHWnpOm0jayMdXppPLJxxjSN64ZbQ
	 bDa1FnByQz3+EfHS0ASPL0hBrZqSKdmMfxB5gwkT5W6T0EZtBPksc8Nf5Js9aJ7AP
	 j5Fi71/GgrMJRIeblLB+koj4g0WOuHjr+ujWD8K65fkKjx30FjMZV/KWF6O0Zxaa4
	 U9tlA2cZtCpMAnor/GebsPMKaj+PMlEEEAHjFd1h2rlhwBfixXO9opuFm4QQRyso3
	 Ma59iE/DRiq5Ew0/OBsC89D/XcsQ0O8nrV9EEag8LOinm3TX9ZNoXaf4YAPu0KfiK
	 w/XXKgMYNWPkrqANuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1rAm3k0A2E-00n5Nd; Tue, 06
 Feb 2024 23:01:30 +0100
Message-ID: <8af03e5d-3756-416e-8137-fe64b2c19000@gmx.com>
Date: Wed, 7 Feb 2024 08:31:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
 <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com>
 <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
 <CABg4E-=G4sL9KGjyNgFozUx2=jbe4+q_U+=eHv-cX_897HP8Ug@mail.gmail.com>
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
In-Reply-To: <CABg4E-=G4sL9KGjyNgFozUx2=jbe4+q_U+=eHv-cX_897HP8Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uCxfKuruRSh9bFd7V5nJ2Prmqe4MFT+SKYPgu0WSR0ftifsXEaD
 MAyKmcR+2k4SKZlh8S4ILvWTaH9/mHjemW94KyO8AsLWcoHzO2eRwjADBrC6Om5DScCT/lo
 ekJXclEeMZXCsyHiIC98fw51jEKHK69VltYMJ9ArvccTdBeprlY1kb/oIrlSkuKeM3rGnG5
 lriiPfn4UXcE7HamXrWUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ynUuUZvTkNI=;cItTBV/y6Mg5G1L6UKlxOVsWVwa
 3tk+EjlpzmxVwObQCWMItiWdYrPYNZGqua1997bSjzf2ebEDbnCpBjvdHcWlE3rZMOMUOj7CI
 jxEMOM9s9qw6iG0+VSsdWQ6Uia7Rd4Epi5zCL29dI9vrUICTkm6HQ4QB4KfMR/sX5t6OAmdVV
 y/SDX+u99uKlY8MOIhjL5zoUOi/4FRXaVzOT7HqIeBJe7RT2Jo/UnIyff2LBh52sRQ12p6OHR
 5ozlASIvWNr160CKVNiPjtLCl+OqUca99/nARny0aaYbUfcxumMZV5c7s6q6/BHrI7VGQrBNX
 f8Y4hNjFeSsU8LStATbSaGhgj0mQDk48V+AGeYJgEBtIToDMp+nDy7tFWegFr+a7r5IHh4LDr
 u4IHwiGiqFdgVnfR9IBlKRbT7ldKvmXIc41+B/0R7TJENjV5oGk3l6DBb/toJkKHuuk6/KZMe
 zAO8QFR7ekcbEJR4JT3dxjQiRJtNBSA125E1NyL6tw2rUwh+FMb8XSRh9rs99itYY1qZz0Tx0
 Q/PX1pf4eCUBl95MMBDNUL10YPcDRAMgG8iU4Npv/OiXPdx49YJGJrdYYkHvHiICpMSi4O5lZ
 /pSFQsfmnzHvyNfk7KQfjvFi2IET7RWBPUzx7u146/qiESLWlF4ZcGY1VcdgmrT/vXTf2640l
 NIsWcw08UFUPGgRgYZa7/gO8TXyFxH/5sYKThaafiiOX195gtViXn7YruBEd+M9nw4d8VAEDd
 DjGhJSTxIiZX+KZOexCEhgBDpgYX85Lt2OUjZ4xagubVU07MxEz6WzGJnxSMK2FteQujgGHN5
 JdA84kNLwkSLCyOY7ROsKEmTVoHe0OJGuC/OEeD9FX+nA=



On 2024/2/7 08:23, Tavian Barnes wrote:
> On Tue, Feb 6, 2024 at 4:48=E2=80=AFPM Tavian Barnes <tavianator@taviana=
tor.com> wrote:
>> I just tried the tip of btrfs/for-next (6a1dc34172e0, "btrfs: move
>> transaction abort to the error site btrfs_rebuild_free_space_tree()"),
>> plus the dump_page() patch
>
> By the way Qu, you should fold

Oh thanks, indeed I missed some callsites, and only relies on the
*_err() helpers, thus the eb owner check didn't trigger the page dump.

Thanks for the fix!
Qu

>
> @@ -2036,6 +2042,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>          if (!is_subvol) {
>                  /* For non-subvolume trees, the eb owner should match
> root owner */
>                  if (unlikely(root_owner !=3D eb_owner)) {
> +                       dump_page(folio_page(eb->folios[0], 0), "eb page=
 dump");
>                          btrfs_crit(eb->fs_info,
>   "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct %llu",
>                                  btrfs_header_level(eb) =3D=3D 0 ? "leaf=
" : "node",
> @@ -2051,6 +2058,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>           * to subvolume trees.
>           */
>          if (unlikely(is_subvol !=3D is_fstree(eb_owner))) {
> +               dump_page(folio_page(eb->folios[0], 0), "eb page dump");
>                  btrfs_crit(eb->fs_info,
>   "corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expe=
ct
> [%llu, %llu]",
>                          btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "nod=
e",
>
> into the patch.  Right now it's missing the dump_page() for the
> relevant error message.
>

