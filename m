Return-Path: <linux-btrfs+bounces-5956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BD916583
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096211F22872
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D885EE97;
	Tue, 25 Jun 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mv30f1/X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB341494A8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312516; cv=none; b=uefXOYudFo2VrxKwhqHGkvXEKMRo2QpuvNB84nstJ7WlzRjYYmDe6/1+pFBNJdJ4ALTW2Ku4QjDZ5rr6KgbzMuzW9IAOHM+86Y5oCikofy33LuRrYw5wZ5qa7BWZ4tmZmgfMZ1Nd1Q2WmZQRu0JAnVcbrz0BuSaPBgWXCJlOJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312516; c=relaxed/simple;
	bh=BQE8k2DO+HN+6QSxrNamozQoVvPVEuchdxyrC2aE9D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpenalYBiurB5ZcxcfXtOvsSldKIFyx+5BzE1wu0pEA3hrKno7iXoEGPaAWApmTIEqSOXsLdXfxGvD6d2TVGYU1bRzbzbh8BrYF/A3I5UqTX6PLrkBw/nuDzEqT5gVpMbrCD7BH5fQo1rKAnU18/YaBQtjxW2N9v8MZ9K2+qQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mv30f1/X; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719312507; x=1719917307; i=quwenruo.btrfs@gmx.com;
	bh=eIpr5Mgw1oZOpoEgWlLevmE2sA5hS9zKE2F5/u8ci6I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mv30f1/X12Xwje5TzcAbBOKZtOk95160RtmtXsZgmvipFXSbsIH/tW9LDm8DEt9r
	 0OJg7dkPS2GOHlIolM9H96xZoz83hvGdl7Tc0f9a60iQwmRzCePHANJyZd4r70yXk
	 Nirye65D6wHOmFE3mwllCYrT1SEwAQCNO5mHjN5IGH5cgAjWf9Vr6tg3aQANVTNuT
	 dHDMSR2P4ihn2+sGjHUn4ilKAJ4KkkZyGNodP7tCc1aGIugvr7FHPGqtwXQ6VY4Qe
	 cV2YGDYgvwy5JWRp3ruIZ5iW/N1KDynpRrLOzvhLzKAgfVDW5jXZx4AVmDyvVj0ZL
	 ITBXd8T+d+chKrDt2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY6Cl-1rqV8B2DM5-00Xzs5; Tue, 25
 Jun 2024 12:48:27 +0200
Message-ID: <3f0450b8-b43b-4451-bf62-17a088e05ab7@gmx.com>
Date: Tue, 25 Jun 2024 20:18:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: cleanup the bytenr usage inside
 btrfs_extent_item_to_extent_map()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1719291793.git.wqu@suse.com>
 <a963c3b347e54bc23b9c0b39e8e864ae309dd148.1719291793.git.wqu@suse.com>
 <CAL3q7H4eayxdogMgJKtPTNZVO-qcsZ9tcQrRGVCoEAzbsa0PEQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4eayxdogMgJKtPTNZVO-qcsZ9tcQrRGVCoEAzbsa0PEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RLLJgOOUK38suF1wyJpACtVgHP8FzjEdMvTN+NvGWFKX/Ix7VaP
 49pwK5Euv/oY63orrqyETZDKigX+7Z2HwTeyCIsJJKcY90u72KhDoxjlDPRdRRaBrfMzVsz
 tEzMdLj/DzwUZ5+U3wTR7r13Oq3caw+joY1GXYOEY8eZuZJl9CDI35soMlHKJw26Pu6GnhW
 LfyrusXkEgVWfoliFEFIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0oRBH7dX4JI=;82NxPJH5a/KO7UyE2wCY/k0lB3t
 avwk+eulT08+DTDxACL1xiDc1mvKHmD6fEtNcK9bTmIJWBdulHUNPcBNnHv3W/VwGKT/Z/Kn2
 jl2Xrvznlb8F76RjHDRCLa7lmCqBgUstd1NaaxKnyR0v4V+V5EsC5duWfQTlm4ruQ2MrgH1PG
 /l6q7Y1VxssdNtkdO8l7jzzDzfVtt5EwoynHj4yl1WupI8zZAfI3ipCJ5OWbfI8sU9lUnswUG
 yV66eu+bMXkXcgYlV/P5Ck9vu4eakOta1ZU7vUL040fKLG9FTRw0xCegMR8Xtz5MiVTmO0I+7
 A11n312GoL5ernX+1tAQbHE5QZT1xJ7LUicYn0o9J+FbjRtv7Irui7YpCSUjwkhfBMorueKXs
 fOzAJP5EjtpGl6uW2zL7QbpH/YSydSESZ0yRkybAH7aEJvcW3wUH0w2auvoC7RjEFBaEOf5Tb
 LkSz+JQLQhFJQVq4iyc+i6zlXZibKkHD+DX3oCsHR6dIJVaGy4Kl9HYBhYQ996f1mJwHK4Xn4
 BS/pEp+5IPfKHc+jz0P+wYC3DYHRsAYGHbjSd/dtZ6k3c9B9uwXS13X+lBX64gaQUCNKD5ZZH
 HlptpMB0jojYKqNyZOROQcDFX6fMVNEhD/Vfyx44Ec35U5P9bZlK10UgylhDdAHfV46Q6p94w
 Nmh8Az8L2ftmHIOtL9KO3EN4/+qESChdfivHn/LePXY9giYoH/10b6pySYz6O2HXXiOz1dYiu
 MyMM6npblzl2e/dZgULswOjIsOvFjwx5W57ci5PXFGuiz76S/PerVuaaNqIzXi9xD5Dw5KgLU
 WbyATep4QK+YjMLwR1YhqqlSgXuI2Lt/U8DuZgc8MPMyw=



=E5=9C=A8 2024/6/25 19:49, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Jun 25, 2024 at 6:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEMS]
>
> I wouldn't call this "problems", there are no bugs here or anything harm=
ful.
>
>> Before commit 85de2be7129c ("btrfs: remove extent_map::block_start
>> member"), we utilized @bytenr variable inside
>> btrfs_extent_item_to_extent_map() to calculate block_start.
>>
>> But that commit removed block_start completely, we have no need to
>> advance @bytenr at all.
>>
>> Furthermore with recent enhanced btrfs-progs check for ram_bytes
>> mimsatch, it turns out that for truncated ordered extents, their
>
> mimsatch -> mismatch
>
>> ram_bytes can be smaller than disk_num_bytes.
>>
>> [ENHANCEMENT]
>> Thankfully all above problems are not really going to affect end users,
>> fix them by:
>>
>> - Declare @bytenr only inside the if branch and make it const
>>    So we can remove the unnecessary advance of @bytenr.
>>
>> - Manually override extent_map::ram_bytes using disk_num_bytes
>>    This is for non-compressed regular/preallocated extents.
>
> I don't see anything in the patch changing ram_bytes.
> Perhaps this is from an early patch version never submitted, or from
> some other patch?

My bad, when re-editing the commit message, I got confused with later
patches.

I will remove the ram_bytes related part.

Thanks,
Qu
>
> The code itself looks good.
> Thanks.
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/file-item.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 55703c833f3d..2cc61c792ee6 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -1281,7 +1281,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs=
_inode *inode,
>>          const int slot =3D path->slots[0];
>>          struct btrfs_key key;
>>          u64 extent_start;
>> -       u64 bytenr;
>>          u8 type =3D btrfs_file_extent_type(leaf, fi);
>>          int compress_type =3D btrfs_file_extent_compression(leaf, fi);
>>
>> @@ -1291,22 +1290,22 @@ void btrfs_extent_item_to_extent_map(struct btr=
fs_inode *inode,
>>          em->generation =3D btrfs_file_extent_generation(leaf, fi);
>>          if (type =3D=3D BTRFS_FILE_EXTENT_REG ||
>>              type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
>> +               const u64 disk_bytenr =3D btrfs_file_extent_disk_bytenr=
(leaf, fi);
>> +
>>                  em->start =3D extent_start;
>>                  em->len =3D btrfs_file_extent_end(path) - extent_start=
;
>> -               bytenr =3D btrfs_file_extent_disk_bytenr(leaf, fi);
>> -               if (bytenr =3D=3D 0) {
>> +               if (disk_bytenr =3D=3D 0) {
>>                          em->disk_bytenr =3D EXTENT_MAP_HOLE;
>>                          em->disk_num_bytes =3D 0;
>>                          em->offset =3D 0;
>>                          return;
>>                  }
>> -               em->disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf,=
 fi);
>> +               em->disk_bytenr =3D disk_bytenr;
>>                  em->disk_num_bytes =3D btrfs_file_extent_disk_num_byte=
s(leaf, fi);
>>                  em->offset =3D btrfs_file_extent_offset(leaf, fi);
>>                  if (compress_type !=3D BTRFS_COMPRESS_NONE) {
>>                          extent_map_set_compression(em, compress_type);
>>                  } else {
>> -                       bytenr +=3D btrfs_file_extent_offset(leaf, fi);
>>                          if (type =3D=3D BTRFS_FILE_EXTENT_PREALLOC)
>>                                  em->flags |=3D EXTENT_FLAG_PREALLOC;
>>                  }
>> --
>> 2.45.2
>>
>>
>

