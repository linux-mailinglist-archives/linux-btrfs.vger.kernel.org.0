Return-Path: <linux-btrfs+bounces-4742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62188BBEC0
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 00:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874111C20B6A
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269284FBC;
	Sat,  4 May 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h0yojFYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194445234;
	Sat,  4 May 2024 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714862526; cv=none; b=Rm71H7ElIsAxOuoMbWX1uUhQlfoAQ8xCgQJdnJJNMHxvNQwHm+VvrI7kNx9mrYhfJcUi8/bUFE3vv+WmTQDviuGRpzyhbP0P3RrZUYe5dbO0tA2U/WslTCPo/6W36WbJ1ygova3ibTBtj03uzvXd1svybN2OQNh+00nimvXSQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714862526; c=relaxed/simple;
	bh=+2b8KtUunlVVnpLtil2bfSxYjWPeMy9vC1HMR5rYJww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNWH4VZvcgUQ+H7vAEStDyYcwbAFt3pEdHEo8effyY0fyNmxGFhDCMjntOozXzmIOBRBxRsSKW2nJniv6BmAT1GiQZsvUKCwT0tyCHNLw9+oB/wKs8Et6Ql5cL5DmGEBtKa3YhngfrNz1HkXw3YbZg+eAkEQx/z79KVTWxEsww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h0yojFYm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714862515; x=1715467315; i=quwenruo.btrfs@gmx.com;
	bh=J/PJ67IFRCBk0cgQQABc1SlMK1d/jCGLK+A3Xfsj8jI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h0yojFYmk2ancVIO9RbSU1LMPiJaDTf/hMwTihzgfy1NBT/p5a9eKqibPTtMQjem
	 1/CiupFbxO2nDoT0F/tF24TqQ3KXmrvukQZaK4JgfftOKgBBeOpiysZ6LhSdcDyHK
	 ryzAIZDz7G/xxRO0qJo6e1P3RH7JMoR2+coYc6z6ABilK3/TsBHQbb/2PiaOnYsEm
	 J1Jjd85UxHjEUQjESjaOFIe0lPL+d8+4ynFqgqyygDYKSsT7skmm5Hxk194mQuKnK
	 zDa4Ad4USLywPtBpKqJhJm1PbC49HRMV88YrmbOX+iRfKVl3tfrYgJVj2F/HtD+xW
	 O2TAPHUjrKe8bv0RTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7Jza-1s049m0Zps-007eut; Sun, 05
 May 2024 00:41:54 +0200
Message-ID: <e03c1ea5-2493-4153-98a7-ad1323eba9e8@gmx.com>
Date: Sun, 5 May 2024 08:11:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix array index in qgroup_auto_inherit()
To: Dan Carpenter <dan.carpenter@linaro.org>, Boris Burkov <boris@bur.io>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
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
In-Reply-To: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7RjPraNzgFtbQwlmMgYdwzt45/B8ELeAQz+CC5prSdG4EpECMF
 Bzx2MRS/8O0DOp3Pz8QvwaqvChIvm2fQasCOQcQjmTKTruHQC9pjK0BUefv6REgeNWePjug
 GpdyYGff4/6Rg9BktAVJni2qvrzj9tF9JRacLDQYGR4ilX3YfHAJV2u3zNGC4fAsHzbih2I
 Puv8CigwTcA1I0BQUE4AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6HUT57vVNQ8=;oe1juKIc6FeaHbCcIf3oj1VZX3a
 G/dtJWQGB7LUYuu9ylEinIR0vS3MczXEfBJ7Nfz4Zg0TdNOMBdkOQ+jd0jTyqliVQKHDdtz9R
 RHWMLju+BjiYz0pkMLuP3hnPIFS3ytu9mF1doNBo2NlKdX3R4ExsFZcQjLauOkA2K3TLja585
 h45pFF6jrO5wqroZ0ZzBvAVK5VVjVXTRLwBp4s0oZI6tv4m8MS+CLG6P279r6tO6vT+Gvg6i4
 WYBTcYQAuijBbsr4A1TnlW8C6fV2z++AwvWTGrbEtV6CfPLe5/UbU8mzLCudqJjFzXcXezpPK
 6ZK5cAf30D+TUuvu5WcXGbt53DT3tQ8O68o9OV/P3kQdD/uLTzL7AtmxsLRrkg6PM5/+zzNgr
 iXboAsLJrncbGwXFhojbff5l+vNg7A1onlVPQHIT2Bkupzw9RopkyA6iZb+nzwJszHXSJyOFK
 2IaOYZOQHprGb5OcDte1VnPe74hXVreXRJUorFT2thhpAIK3j7p5+IvEC801A8m2R9aqyi5SI
 cDE90Ef04SeYyZU/SrwhYbRK/pGZ/n+lF1uKTYpzSnouU838y3EMy0Aa/StxTXl2Jk/wHdNM9
 b8BwsptuGLNSnnKG/TJkAhky+EoTFWrRU6vbC9H0+wSc0XfP3YI7Fyh23czymOhLci+1uZUzF
 Alt1kWhwapAsFEalBvYRuMNuIBCW4QPKBuc2dDjsyjxlvuFRJ55jXp6EuICbEdCe7co/z1CTw
 eszditKhW2G3yMoF8drIjpJ9Dd7QMRMt/WMi1ssOXnuBWLSz5JFaczULw/fi1kLA+ykYCq5dy
 1pY4Lqq1dsgbjuPK5eliIBrY53DjinyPPkFeIJAzeZjpg=



=E5=9C=A8 2024/5/4 21:08, Dan Carpenter =E5=86=99=E9=81=93:
> The "i++" was accidentally left out so it just sets qgids[0] over and
> over.
>
> Fixes: 5343cd9364ea ("btrfs: qgroup: simple quota auto hierarchy for nes=
ted subvolumes")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

It is indeed the case, btrfs_qgroup_inherit::groups[] should be the
parent qgroupis the subvolume would be added to.

In fact this can lead to unexpected problems, as the groups[1:] would be
all 0, leading to later find_qgroup_rb() unable to find a qgroup and
cause snapshot creation failure.

IMHO you can also craft a fstest case, where the parent subvolume is
assgined to multiple qgroups, and creating a new subvolume inside that
one, which should lead to subvolume creation failure.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  From static analysis.  Untested.
>
>   fs/btrfs/qgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2ca6bbc1bcc9..1284e78fffce 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3121,7 +3121,7 @@ static int qgroup_auto_inherit(struct btrfs_fs_inf=
o *fs_info,
>   	qgids =3D res->qgroups;
>
>   	list_for_each_entry(qg_list, &inode_qg->groups, next_group)
> -		qgids[i] =3D qg_list->group->qgroupid;
> +		qgids[i++] =3D qg_list->group->qgroupid;
>
>   	*inherit =3D res;
>   	return 0;

