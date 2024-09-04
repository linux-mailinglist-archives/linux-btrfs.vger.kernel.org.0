Return-Path: <linux-btrfs+bounces-7809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BE96B0AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB563285690
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 05:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26EF84A4D;
	Wed,  4 Sep 2024 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tIagIxSM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5A58ABC;
	Wed,  4 Sep 2024 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429109; cv=none; b=PAzhpLuK5VGay8BDFnXetLa72AZXBX8YIf7h9whFYrt2n8q7wi8BepUiw/sD5ew3Jl24kmhLgq5ZuBC/By66MAYac09oaKdSoGmMRosaGc4IKd+3JMeSWXLYlNB/Woy4mK0UUgp1NlYF28Ss8pJK+z2fH5PVpUB7aiOuouI7Xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429109; c=relaxed/simple;
	bh=B6vUTJlBWUgdrkS3GVZtEq/UvdzcZ0+0UBAI73i9AcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf+M+v2y7MEe7EvnvgNa7GCLkpGY8wqniof6ni+ZcleK1kKWvAvXE773+NF3K4p8e//CmJoMK0Q4O0DAgL2YHqb1rDi1u5PcgpnnvwX+sJeX3H36NZMCmh6FHxG6FpGaNDp8ZDml1/IYJwsTnj9DL0m/W4pqN5SCLz+xCWZgigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tIagIxSM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725429098; x=1726033898; i=quwenruo.btrfs@gmx.com;
	bh=KQOUVXBgj26dw6UvtJFYt+fSxbDXafd4iAgGkdPwyd0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tIagIxSMGygNsE9BvxAQBgfL3BPjgCx6Z0WtlwBKUPfmgAKlyWYJbs6E+0n3ltO8
	 C0XdskVZyqW+7PPmqVQN+fjJ9BXabahh2jEtQIzfoFr9rk5MQzN84BEiKHlRe9BYc
	 bqczRWv0v8op6pyA+Pba0iqtPTDcBDVGbzbdIwgNfWXcQHVY4TarZc52OgMI8VgCV
	 1WGY6/F5Yyos1ipVKRAdakcD4J/T7UcXTAhWW/6R05up2U0nUGJ+5lkmouIYJ2kmJ
	 laZ/PZOP5rHvFBgLh3yDVtEd5cDpsMNPo3mOUwciYbUJoETFg5T9FKwhCKcVjQuRI
	 6CPE6gzV9xU+ZBOzQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1rvpED3uGa-00uElJ; Wed, 04
 Sep 2024 07:51:38 +0200
Message-ID: <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
Date: Wed, 4 Sep 2024 15:21:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Added null check to extent_root variable
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
References: <20240904023721.8534-1-ghanshyam1898@gmail.com>
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
In-Reply-To: <20240904023721.8534-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6U4dPh0NtRC48oKhM8fS5ZlpzDgimM9d8vM3vT4sDSLnAPcExH4
 LNwHjbUYgsTYEQCMeZ61QpK3DphzA6a13roRk/MZzjgIILpA5zoGwp8A6axNUbeaLPjtjL3
 7cqt6cVRG1vCF7dlJZ7kHNj13y2TNdZGZU1VrpR1hjC8Umf+g5eby5FQ3chCngy12x+CgQy
 fxFZ2cBdl/GFnG6bQAJ0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oUR49U5JCY4=;DXLTjo2lN2vutEwmjPycfFthzF9
 rWRWsVWfUET7jPVTmXwbDw+udvRO6dh2oqSxwVvsLfH4WfSljCdcWQYoFivf5kobhVFM/LFXc
 K+a4jRkinfTt7ddbKuUPABDc3pmqO29i/24PCCC9Hoz0r5REkNtFWtJ0qiXG9eWpi/Hh017Jb
 RryIPPZPF2aipgmyRIYiodTBJ9YJNiSCzAjc9yxQ4i//46z70EfJX2P18T6DsLBW7JQEBUO8k
 8ZEzLIaHac/gfwHAMGMj3Hv2rixPrq+mfsG4uFdMNwV1BrA4ZKlang71pn7tOBPBNJvsTgROF
 9sk7Cczfhd+nvBlwSXs/Ntq+Ed5MCjywdLlMuocYwl38C4Kko7MXvcWCJ788Qs9a87cY6b9Ae
 f9xLw7ISzWIm/hz5Jq3hH8KkTxEhovRycXD1pYldNz6LseM0mvEX32e01mADpMzUuqBEwwHvd
 YcamvCNnF8wXvNRKMAvQ+oUolF5mOpRjdTnUtTKUSKbw+Hu8kmP3Ys7xCVgAufJxIBDFP6VXB
 PGPA23AapWh3hD1ahafSBS8P2W0k7ZJ1lWkeNDIb4mmkWQijseIUihroKlyreC08AreJfoabp
 mI5gdA9U8tR26jJHPIaQLMIUMyhcUKEt6n9evzWYSEYHIQOs/UHmbtClWH44s9dZhbBtM57/l
 Yt8P2gBmYer21QIiFTodyx9NivU7U89IdC2QEgrIckZzQmwK4Nj1a4zq2xHtpS9McTwhZhYPG
 aj6uH+hhDvFFw9ho4wCt0fhlwWn4wR6mx07C8V81EBVE75xjkNdhLe2yJTj7HxSyBoVUBhfGL
 1n3TOHzeWjGFcMbS798iF+IQ==



=E5=9C=A8 2024/9/4 12:07, Ghanshyam Agrawal =E5=86=99=E9=81=93:
> Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
> Closes:https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>   fs/btrfs/ref-verify.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 9522a8b79d22..4e98ddf5e8df 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_=
info)
>   		return -ENOMEM;
>
>   	extent_root =3D btrfs_extent_root(fs_info, 0);
> +	if (!extent_root)
> +		return -EIO;
> +

Can you reproduce the original bug and are sure it's an NULL extent tree
causing the problem?

At least a quick glance into the console output shows there is no
special handling like rescue=3Dibadroots to ignore extent root, nor any
obvious corruption in the extent tree.

If extent root is really empty, we should error out way earlier.

Mind to explain the crash with more details?

Thanks,
Qu

>   	eb =3D btrfs_read_lock_root_node(extent_root);
>   	level =3D btrfs_header_level(eb);
>   	path->nodes[level] =3D eb;

