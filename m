Return-Path: <linux-btrfs+bounces-22133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGK+LppfpGkcfAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22133-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 16:47:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC21D0780
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1219301465C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A4274B4A;
	Sun,  1 Mar 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b="E6LbVuLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A4430BB5
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772380049; cv=none; b=lP8Z22hXbR8djstzXTeJX6SHXzQDQNR+jEJUHmVpUh2nBZT617Gu74YXwg7HWvfD242915E7NnG6hWMp+L4uyTi2dHIicUQIIIAINw2qRoTU4Ih4kTVCGM3WXYinkm1acpdobaAb4/ZbJxi262q/9BzEcTB3QHPql1IWTPCCDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772380049; c=relaxed/simple;
	bh=03HYBv225Rz9T/p6xzFxto5gWzkBRqalNzSM/EtMi+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V1FJWbtOYkccHBDkcCJIUoeKLJHWvR3XzA7X11hqcP8/OgUo+VeETm67Mbh/9VVWWLf/JBrU0ZTWLfWxJDsx+FmGBqyJc3xpN26+5OTg76uI/tC3OPhCSsg1FK1rGnSivEz5PPNzivVlZaLWqSNIRXzO+sl+4D+89EeoYwsIAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b=E6LbVuLP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772380045; x=1772984845; i=pj.world@gmx.com;
	bh=03HYBv225Rz9T/p6xzFxto5gWzkBRqalNzSM/EtMi+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E6LbVuLPY9jF7k1qT1YXNUmq6g1F8gYwG/NYddU62KoWdovK8AIKFqEY1I3SIrCr
	 d1PmJ01kDLuKfkW4G1xqpDO/XzSiQ5C5k2agTzq4A0ukeq6eFf7O32/cAIIE1YgG8
	 1XgPwu3JMK0DEvL14xeY9VkVVqMrlsiRGdiGadDaQWKhSPU01ncMVw00o6Ha6kqnb
	 k/RuPUfBaifoDijvTrOcPd1eF91IFFhyu36Rbrk6YjXynx0qu5YFylDbHVZrLt1Ja
	 ZEThLM9iNGPU5ryCg8DK1AdJzJOfSUHj1e9zdjwWzuuOd0RaqSI9VyhUVo/JHb534
	 Tf/s299F0p+nVmpgug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLzFx-1wEWse0flx-00WGwQ; Sun, 01
 Mar 2026 16:47:25 +0100
Message-ID: <0afbb856-6d28-4307-98c1-a8f78987e52e@gmx.com>
Date: Sun, 1 Mar 2026 09:47:23 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
 <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
 <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
 <0ed6fdf0-842a-4641-90e4-5239b5049e4b@gmx.com>
 <121b0011-8076-4a0b-baff-384b6ec62986@gmx.com>
 <8adc2517-a0fa-497d-ac3b-8700d39bb085@suse.com>
Content-Language: en-US
From: Paul Graff <pj.world@gmx.com>
In-Reply-To: <8adc2517-a0fa-497d-ac3b-8700d39bb085@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XORFW0HqCiEjrx8U+Q54u+vZXD+xew8h+SBKdPcdX2zXn9GUYz
 otKb1/fZ+1Qc16po5DM/NwuIFT2y5OPr3n6yTViBtzLfvGBhSAWVsu5TUzAv46lCk1yswpc
 BDoBOgutCUR++HsdKcJ82+chZwa6adwccppbm053J/byL07a/0K7U/mx3M+9uPGxmLkZZnY
 kQks1BkUKBfyy+sfGJkxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wED7vtmtmY8=;+oL4z0QxA7g1uDXpAVN5fCYX8Ts
 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
 PkqaF7gA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22133-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,gmx.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pj.world@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22DC21D0780
X-Rspamd-Action: no action



On 1/28/26 2:49 AM, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2026/1/28 19:12, Paul Graff =E5=86=99=E9=81=93:
> [...]
>>> Unfortunately btrfs-progs doesn't have the ability to repair it yet,=
=20
>>> I'll craft a branch of btrfs-progs with the repair ability soon.
>>>
>>> Meanwhile please prepare an environment to compile btrfs-progs.
>>>
>>> Thanks,
>>> Qu
>>
>> Hi, I would like to ask if there is a solution to the "dropped ghost=20
>> subvolume" the filesystem on machine here exhibits as of yet?
>=20
> My bad, forgot to inform you about the fix.
>=20
> In fact the fix is already merged into btrfs-progs, but not yet included=
=20
> in any release.
>=20
> If you can compile btrfs-progs, please fetch and compile the latest=20
> devel branch:
>=20
> https://github.com/kdave/btrfs-progs/tree/devel
>=20
> After compiling the devel branch, you can use `btrfs check --repair` to=
=20
> fix the problem, which will add back the missing orphan item for those=
=20
> ghost subvolumes.
>=20
I did not know how to compile from the devel branch, this is=20
unfortunate. I waited until openSUSE Tumbleweed btrfsprogs Version=20
6.19-1.1 was included in a snapshot which took a while but seems to have=
=20
worked. I first ran # btrfs check --repair /dev/mapper/system-root from=20
a openSUSE Rescue CD image, it completed. I then ran # btrfs balance=20
start / yesterday when the drive was mounted and it took 12 hours or so=20
but did complete. I think this problem is finally fixed?

Thanks for helping with this.
Paul

> Thanks,
> Qu
>=20
>>
>> -Thanks
>>
>> Paul Graff
>>
>>>
>>>>
>>>> [6/7] checking root refs (0:00:01 elapsed, 94 items checked)
>>>>
>>>> ERROR: errors found in root refs
>>>>
>>>> found 496776130741 bytes used, error(s) found
>>>>
>>>> total csum bytes: 465839608
>>>>
>>>> total tree bytes: 16133832704
>>>>
>>>> total fs tree bytes: 14983905280
>>>>
>>>> total extent tree bytes: 624771072
>>>>
>>>> btree space waste bytes: 3613129770
>>>>
>>>> file data blocks allocated: 1062495817728
>>>>
>>>> referenced 976540409856
>>>>
>>>> :~ #
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>> -Greatest Hopes
>>>> Paul
>>>>>>
>>>>>> After passing,
>>>>>>
>>>>>> |:~> sudo btrfs subvolume sync / [sudo] password for root:=20
>>>>>> hightower- i5-6600k:~> |
>>>>>>
>>>>>> the command returned to prompt very, very quickly.
>>>>>>
>>>>>> A second balance attempt results with the following output:
>>>>>>
>>>>>> |:~> sudo btrfs balance start / WARNING: Full balance without=20
>>>>>> filters requested. This operation is very intense and takes=20
>>>>>> potentially very long. It is recommended to use the balance=20
>>>>>> filters to narrow down the scope of balance. Use 'btrfs balance=20
>>>>>> start -- full-balance' option to skip this warning. The operation=
=20
>>>>>> will start in 10 seconds. Use Ctrl-C to stop it. 10 9 8 7 6 5 4 3=
=20
>>>>>> 2 1 Starting balance without any filters. ERROR: error during=20
>>>>>> balancing '/': Structure needs cleaning There may be more info in=
=20
>>>>>> syslog - try dmesg | tail hightower- i5-6600k:~> |
>>>>>>
>>>>>> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device=20
>>>>>> dm-2): found 16 extents, stage: update data pointers=20
>>>>>> [93690.667290] [ T69656] BTRFS info (device dm-2): relocating=20
>>>>>> block group 1495819878400 flags data [93703.323923] [ T69656]=20
>>>>>> BTRFS info (device dm-2): found 33 extents, stage: move data=20
>>>>>> extents [93705.575991] [ T69656] BTRFS info (device dm-2): found=20
>>>>>> 33 extents, stage: update data pointers [93706.769453] [ T69656]=20
>>>>>> BTRFS info (device dm-2): relocating block group 1494746136576=20
>>>>>> flags data [93725.570642] [ T69656] BTRFS info (device dm-2):=20
>>>>>> found 39 extents, stage: move data extents [93727.449779]=20
>>>>>> [ T69656] BTRFS info (device dm-2): found 39 extents, stage:=20
>>>>>> update data pointers [93728.465650] [ T69656] BTRFS info (device=20
>>>>>> dm-2): relocating block group 60294168576 flags metadata|dup=20
>>>>>> [93736.722689] [ T69656] BTRFS error (device dm-2): cannot=20
>>>>>> relocate partially dropped subvolume 490, drop progress key=20
>>>>>> (853588 108 0) [93750.594559] [ T69656] BTRFS info (device dm-2):=
=20
>>>>>> balance: ended with status: -117 hightower- i5-6600k:~> |
>>>>>>
>>>>>> Please see the following referenced, prior posting for stuck=20
>>>>>> subvolume removal similarity. https://lore.kernel.org/linux-=20
>>>>>> btrfs/9f936d59- d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>>>>>>
>>>>>> Is there a patch for btrfsprogs? If so can the patch be merged?|
>>>>>> |
>>>>>>
>>>>>> What are your thoughts on this?
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>=20


