Return-Path: <linux-btrfs+bounces-5911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC029141D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 07:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88819B232CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBA17BBF;
	Mon, 24 Jun 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D8l868JZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69E4C6E;
	Mon, 24 Jun 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205841; cv=none; b=cMFK7VMZujQqYTminOdHxrmtfWvaDGwefBsXK8N6IvX1btjvT5WWnPzY6YzH7l+YmwRMaYZuvCDUmw4DhxAFpj1W9okC/WS97b4mDwDp0y7QqNn4UTckZqVDOJpxhCzBV3zio6BnV3bCQQCWubLwlsDqrVO44x9FRJ7M7l4XRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205841; c=relaxed/simple;
	bh=R/AQnucWPHVJoUzglXiRflaLiUYHD6oWehzrbAPuae8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpCSn4k+Aks7WER7s94Ue0EVhU9MmVZ5mJyfEWl0Lje0YQfK5wdTvn1E2XL8rTrfyCNzQO5GMBsOoftilEC/ahOFbeX0+Eb9HxKc5BeEiTxonyhMqHgxa7yUBY3iO8SL/XESIZz5ihkMS2D/FC7V6gNkNgG26b8UVe+fobjfWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D8l868JZ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719205830; x=1719810630; i=quwenruo.btrfs@gmx.com;
	bh=mvVbTrj0kb8GPXZ6M4qrCoPqT+12BO6Z1jDN0Z1CuqU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D8l868JZPpPEgEV9U5uQoHgxl3fuMy5lZ7EbbEjKxWp8+OAwfeGnN23ePhLnPm5m
	 W6Y8ONhkV0NuvkEmQKoU/gAId6AigYwC0zZEUu9MceKZlloHdrSmlFZGyyLswGpcl
	 9IB1jvHjz/9xXGNZBQLo7JbxhVMBhxKDkPJdLQaLwt1tXqtNRF2/V2HOdhHL8XscP
	 j9vyyWZiT8HtreRQOcfqf/o0tXg87SGUdKF3xocKIlpg19tP7MY076aqDEHRg4Sdv
	 gN4dd53bs+HAjMue+R3Ig/vxB8KibMG0JSLu88KmQjnkcVHo3djQOeBsri5I80q6A
	 NLLdcB7UGy/SRTAyrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQkE-1sYaQ93Fi4-012cBU; Mon, 24
 Jun 2024 07:10:30 +0200
Message-ID: <a0840520-929a-4973-8ce9-91db07d6a9ec@gmx.com>
Date: Mon, 24 Jun 2024 14:40:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: fix slab-out-of-bounds in
 btrfs_qgroup_inherit
To: Jeongjun Park <aha310510@gmail.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com
Cc: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com, fdmanana@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20240624030720.137753-1-aha310510@gmail.com>
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
In-Reply-To: <20240624030720.137753-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vk3cyUEzXclr5/+wgykx2/GwZSt/yFHRUZyiQ3N41DfZHI8Bmyp
 i/C96sA46vuL9GekAMiL0MgFJ3H1U6VuTfsxWRwfQPdEA/kAgmCSBMmT5274BIDqKAug59V
 MkjzZxqs8QMZlyhUI/rn9HYaua3UfhTPRxcINrEGWGoLnmj/v2tBfQibsa4nUgT4x3qfSm6
 GnbfOzfTtGWTjbxqCrWkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oQCF0QkMnD4=;Qyswfi7qKHPnSKiY5kDBxVi06U2
 M9EApZU5tiyffLw5RNjpZyRVR/Wp4ZnMIprOnsBh4RVIFqwoR8qArR1yh2iSaR+x0RLeXnG55
 l5gZ7GJl/V+g2mv+fn8B6XNOqXdwOcZDr0b0Gk9SEJnUc2Pf7LODy7ksWLSvZCO4FDKAVgEJU
 jZgUhM0h8U70sleXUIkMAVmSBfr87TjMUiuHNo/4990p9MGfZJVYlT3pxmYie0J25PQRESrEy
 NbOvD1WZslcRBq7kqjQYgW8P4T2MyauXLMn++8WllrAVG3y1JZQvFwVcPtDiJ0ylRobV4mdf5
 cgqUN1g45h0PHC9Tdoc4sruT27emnXnc0BE1gaS2WcsEnSt+Z0ASlRcj7RjEm0+lRTNMbTjBR
 7NxhcOpXACfkYGqRMFl44RjaGJ6+pKadO0wnwUkBUBTYV8D+RCnBZk5qdWdBt3dsQnvmrMYHc
 CJBuSexIsWt72FXQToYltyrlhx+AFhfTHGM3byEA1jLz6IJZVasa6JoI/8gRBa1gLbGOJ61dT
 ity7jjAwUlSV50mhgWICxXKT352S/9gW0g0nr8FFXnq/0yNiP0epkG8NKfKzTS3MpZGy64Gci
 V0poM0Hju5srj6CrYeuOgTmeOYMcEudyM15G76Zy1Xksf21un0ERvuSMxCR6Fxawn73SUXpnN
 w112naoVrbCVw5T6mQSwEjeo2Ecq3VdsIKLceiW5+jobXKAQDTpReyWJuYx0W9qVseGEcvE9d
 X89c5y1Ksqr5anOI2KOzIddO1UJ50I+AABZSzdQbEjHkwJYFF3kmjaeNNcxQoZ2DIrJiYtTUW
 qZpI2jx6M+k7fkqgBclNDMEpf4bsyXiQikrX0KoPPJCNk=



=E5=9C=A8 2024/6/24 12:37, Jeongjun Park =E5=86=99=E9=81=93:
> If a value exists in inherit->num_ref_copies or inherit->num_excl_copies=
,
> an out-of-bounds vulnerability occurs.
>

Thanks for the fix.

Although I'm still not 100% sure what's going wrong.

The original report
(https://lore.kernel.org/lkml/000000000000bc19ba061a67ca77@google.com/T/)
is showing a backtrace when creating snapshot.

In that case they should all go through __btrfs_ioctl_snap_create(), and
since it has qgroup_inherit, it can only come from
btrfs_ioctl_snap_create_v2().

But in that function, we have just called btrfs_qgroup_check_inherit()
function and it already has the check on num_ref_copies/num_excl_copies.

So in that case it should not even happen.

I think the root cause is why the existing btrfs_qgroup_check_inherit()
doesn't catch the problem in the first place.

Thanks,
Qu

> Therefore, you need to add code to check the presence or absence of
> that value.
>
> Regards.
> Jeongjun Park.
>
> Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
> Fixes: 3f5e2d3b3877 ("Btrfs: fix missing check in the btrfs_qgroup_inher=
it()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   fs/btrfs/qgroup.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b /fs/btrfs/qgroup.c
> index fc2a7ea26354..23beac746637 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3270,6 +3270,10 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handl=
e *trans, u64 srcid,
>   	}
>
>   	if (inherit) {
> +		if (inherit->num_ref_copies > 0 || inherit->num_excl_copies > 0) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
>   		i_qgroups =3D (u64 *)(inherit + 1);
>   		nums =3D inherit->num_qgroups + 2 * inherit->num_ref_copies +
>   		       2 * inherit->num_excl_copies;
> --
>

