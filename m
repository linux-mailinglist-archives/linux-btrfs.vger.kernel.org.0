Return-Path: <linux-btrfs+bounces-5267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853828CDD90
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD371F22BCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4557128815;
	Thu, 23 May 2024 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Tc+cPxoT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47332628D
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506381; cv=none; b=o6SCzqlZauKrcyXCtcQfIi6cutKjRNw31yueCMD1ha2PwB6FqmPMppj0qD59SCSCxQI7ZwuUZqhdlHyjEaMCQTviX6Of0lhcL3Pf0oUx9k5GRaJEPQgdGoosoQ353nbAl3CHFOIQeg+qOFJgLxN5LDbNu27AymYI1+3VP1el/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506381; c=relaxed/simple;
	bh=nvBS9Y/ZwkzvKeRa67mSbLngIqPAQHFemKzq7AJov94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2OB75aXg9z8nHH45pjIxhhe7hhXfKkduKuXTSKZA3Pj9PIEykj2/FhZlEId4e+dmb1XqvBM5kze8KjXjYeeSpThotbTSpuHG3/ySSD1rErj/NdpRD/JnH7nwBI91jhNmOJc2Grq51eGBKBNxc6vtYyNNjyq7GILvYMn9ryYI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Tc+cPxoT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716506371; x=1717111171; i=quwenruo.btrfs@gmx.com;
	bh=UOpxcFMrTQ3qxyRoQQqJfijOZsFRnbko/jwlAvCUsFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Tc+cPxoTU3Azr7XEqFF6xSfd/u0fTTVnfJMU6sp3pMuZdWgpGsiVmb5TA5NUh06W
	 kQGbB5OzGEVqgiTdZWhhGIuzZBRl2tnRkX0T4O2XKyZmhLj8ldGeKfFBwZ6poMY7G
	 uWnnafPwAyjjVeajSg1ywjtAqlv46UzMiq0xJrGs1ZUN+U89nhhZzbe5PnerrFiC8
	 LhRTWieu0zz74TEboMwCvvqrD8BDW3uPUUM6AI33Ig5zXp3PjR3yiCetGEO4HGHe7
	 4HBp0MzsWCq0cLyl8euiBKsoRQ0N8RM+LGgZf9VcXM2G+IqI3Pc95uGLj+y6ivE1M
	 E493/rUVp+rrjNCfjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9nxt-1sDJzj32o9-005pHm; Fri, 24
 May 2024 01:19:31 +0200
Message-ID: <f949b5b3-4c0a-417f-a9b1-7c5859bae8a0@gmx.com>
Date: Fri, 24 May 2024 08:49:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] btrfs: introduce new members for extent_map
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
 <41be25a4c77c46f8725c13636098f5f37e5c3d93.1716440169.git.wqu@suse.com>
 <CAL3q7H4ESOZTAaG4Opf3u_8p4BJ_cQPDGs-SdY9vCCFHe6KrCg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4ESOZTAaG4Opf3u_8p4BJ_cQPDGs-SdY9vCCFHe6KrCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Z1VBUJ9grYDDC/ASYVD72cVXGctS5a63XWb0vVwdAJ2JoXg+60
 Ml4iD+5dfb2xwVaRGKoe0+wSn2SEaF/hm5dftHq9QvMtJ6tZ6te00FETzRjWHeCR8KwKSEL
 cvQv7u7r2UtEhZ5J9VHvxvsrolEodGwlXGDEAF7khZ+2/sB06AB8LG9EN7Ly6BxlthMK1EG
 gISm6fosH5KJr8GShiElQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SRbWtrJ5ywM=;b6tAZXfIJY2/g2AMtje8sSdAk15
 Eo3V63r5yDSQjUiRvgeYlleosv5xej8uPx0hn+9dbPzRbG72DpPOafwIZcJnzWNELQ9iDsTyc
 PN9WkmQ9HJbR8SD6RVwqE2g99XuoVwvE9/8hwTrBeBy6w5BrpEoMRgxCQkUfRJHH4W4bG3owR
 GtL0VjUX+3X/3vcpBQbvVimKjhhm0yB+srJ4SH2O/Q0snEnFHckfuiFiCRpO57JZOh93XlBmD
 i4x/DXRcM9s1iuNXN62tdpw+PFZSg2d4pTsduzHLF/9a6KyGC+hjhrNp088VSQr0JlOjkE1c8
 vy6uTzC++t22WSvCbMqJowctDW1uj/h43D5SmSLCHOUAYFhge0eq0fOU3W8ICe+bdp97+gbWN
 /BiXz67+JLb1saNWqMlNPHLAlEwNqer2iytbtMJYEIgOjh8J2vSLaeQFIrF1dSbJFIMIq4B0b
 /5vWxE87y3hqcVo/b+kUH/wSPMW7K8AtVHbX27SmaHBGfe5m5YxJ7piSOqtkergqw/A0nXexa
 tYX4lVLnOlGEG2HIQWGsnWc8dLjL3ns/5Z4BhDLJOfr67FGsMz+8KaZBMVsU4sUxmzdTYd+uU
 tzEQV81tBRB79CEcDcdQIHqqQc0Go+/4iV7MdkYg4RYNM6iCl9EM8wr95bbEFvX3VrU2LC/89
 WMc4hwRk7IUN/kF5CjoX1DM88ppSD+QFffDE2M9nggOQeZiMMaNPwEwkWyJsrs2BIMdga3vD1
 rKM/ZSO9rVoRFao6KVdfMB2xYGlzuieBXqbdkXqS8Hm9waMWpJvpiSXgI2hNy+KyLgHHYWLnV
 kyUlF5abzTCNRU4BpMRJZe9kUpa78Ldw77Py50Loimkao=



=E5=9C=A8 2024/5/24 02:23, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> @@ -832,10 +897,11 @@ void btrfs_drop_extent_map_range(struct btrfs_ino=
de *inode, u64 start, u64 end,
>>                                          split->orig_start =3D em->orig=
_start;
>>                                  }
>>                          } else {
>> +                               split->disk_num_bytes =3D 0;
>> +                               split->offset =3D 0;
>>                                  split->ram_bytes =3D split->len;
>>                                  split->orig_start =3D split->start;
>>                                  split->block_len =3D 0;
>> -                               split->disk_num_bytes =3D 0;
>
> Why move the assignment of ->disk_num_bytes ?
> This is sort of distracting, doing unnecessary changes.

It's to group the newer members together, and to follow the new trend to
put them in disk_bytenr disk_num_bytes offset ram_bytes order.

I know with structures, there is really no need to keep any order
between the member assignment, but with fixed ordering, it would be
better in the long run.

And unfortunately the cost is that, the first patch doing the
re-ordering the members would be harder to review.

>
>>                          }
>>
>>                          if (extent_map_in_tree(em)) {
>> @@ -989,10 +1055,12 @@ int split_extent_map(struct btrfs_inode *inode, =
u64 start, u64 len, u64 pre,
>>          /* First, replace the em with a new extent_map starting from *=
 em->start */
>>          split_pre->start =3D em->start;
>>          split_pre->len =3D pre;
>> +       split_pre->disk_bytenr =3D new_logical;
>
> We are already setting disk_bytenr to the same value a few lines below.'

Sorry, I didn't see any location touching disk_bytenr, either inside the
patch, nor else where, especially the disk_bytenr is a new member.

>
>> +       split_pre->disk_num_bytes =3D split_pre->len;
>> +       split_pre->offset =3D 0;
>>          split_pre->orig_start =3D split_pre->start;
>>          split_pre->block_start =3D new_logical;
>>          split_pre->block_len =3D split_pre->len;
>> -       split_pre->disk_num_bytes =3D split_pre->block_len;
>
> Here, where slit_pre->block_len has the same value as split->pre_len.
> This sort of apparently accidental change makes it harder to review.

Again, to keep a consistent order of members.

>
>>          split_pre->ram_bytes =3D split_pre->len;
>>          split_pre->flags =3D flags;
>>          split_pre->generation =3D em->generation;
>> @@ -1007,10 +1075,12 @@ int split_extent_map(struct btrfs_inode *inode,=
 u64 start, u64 len, u64 pre,
>>          /* Insert the middle extent_map. */
>>          split_mid->start =3D em->start + pre;
>>          split_mid->len =3D em->len - pre;
>> +       split_mid->disk_bytenr =3D em->block_start + pre;
>
> Same here.
>
>> +       split_mid->disk_num_bytes =3D split_mid->len;
>> +       split_mid->offset =3D 0;
>>          split_mid->orig_start =3D split_mid->start;
>>          split_mid->block_start =3D em->block_start + pre;
>>          split_mid->block_len =3D split_mid->len;
>> -       split_mid->disk_num_bytes =3D split_mid->block_len;
>
> Which relates to this.
>
> Otherwise it looks fine, and could be fixed up when cherry picked to for=
-next.

So although it's indeed harder to review, we would have a very
consistent order when assigning those members.

Thankfully this is only a one time pain, there should be no more member
order related problems.

Thanks,
Qu

>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.


