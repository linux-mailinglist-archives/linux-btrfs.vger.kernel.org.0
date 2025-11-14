Return-Path: <linux-btrfs+bounces-19018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F4C5F112
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E334E3AED
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2242F39BF;
	Fri, 14 Nov 2025 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b="azjcCKqG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F52DAFDF
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149106; cv=none; b=fl/dIgs5VHzfIIOJRecsw3yITwjPdnBclzuLva4ubHuI+cY3MlZtnDCQ2KtDOzfUxdvX355D1C5uj+XbSKoXBFsPL3QIAgaorcvrUESWPWeb6VCZ3sZHCf9Z1VVQncNXQk0jia4xhqFZev3qaZM1VZ9k7zCtAFxV6fod22+DN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149106; c=relaxed/simple;
	bh=1Dk3c914EKc8jKE90RRxMEl/qLFX4LOS84bgjtVVJPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fR4tGkm75UdRW9KO4qWbDFD2hK4HD3n8pNe4wMNy2XR0f9OaO7HGYMuVljDtrYax0Q/OQCyLwy6QEyeZylDbqMmchKyFP4EAX9V3Jo5VGivP9fTQynEgt8+HDVzGsG7/GIpCuenDo1TViYejIZzaK3VkvpmIEtAXaSgVo8rDDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b=azjcCKqG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763149102; x=1763753902; i=pj.world@gmx.com;
	bh=1Dk3c914EKc8jKE90RRxMEl/qLFX4LOS84bgjtVVJPo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=azjcCKqG+15jxlCo0aVjhYgH7+aXCQLgLEZOWzj37e2bBnmGfeyjbj5Qu51X0wYa
	 Yg70PlAmeuNztMbN74Z3sSsnx61Ul/CPQctSjL+AIHryjur2HbpNL+3JBXE4Ackva
	 5ucZkiiXMlIyN1k0PqYERjkoAsPiixiSKqfPcUMg6b9OZ9OA2969oKBLsr1mnf69o
	 bpBa7590IqhFE1jHQALHRoNLb+9OMXbvWqzQs4gtW/s+2N4K7myF5BsIChWKfDJfE
	 MKX4ps1Okqik+HDpWoJsOWCz9DW8v3ylIupKd45nELAd2++sSv3FFkukXGgDrHIZZ
	 6szPP8nTJgOfwQJ47Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.6] ([75.168.199.57]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdeX-1vN41I3MWr-0068po; Fri, 14
 Nov 2025 20:38:22 +0100
Message-ID: <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
Date: Fri, 14 Nov 2025 13:38:20 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
 <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
Content-Language: en-US
From: Paul Graff <pj.world@gmx.com>
In-Reply-To: <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TIXDh08bsCsZyqiFNmXKEkeIJUKYDXbP+IqZ7nfOXVfP7Igk1sg
 pTmI+BhqZpSIlg2IAKQtIZZWQ02l1GVdswqjHdlS2/kRyZ0pvb7wOKn7MQwQDdlPcQC6nKG
 nczKB+M3nfolI+E7SLvpbHwZ56xogXNoTriLjZ9qkCG7uNaFq7Na7Mmo+t2H8XGAStU0GDv
 ANLKgDwWhBqlPBflrgw9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FmC2eCw1vf8=;qn9Ee8q5PD7A+mTsPBUjVJKy3oM
 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
 /1bhP9niGkqYrKClw=



On 11/13/25 4:54 PM, Qu Wenruo wrote:
>
>
> =E5=9C=A8 2025/11/14 09:10, Paul Graff =E5=86=99=E9=81=93:
>> Hi, currently there is a dropped subvolume error when running a full=20
>> balance on a single SSD.
>>
>> |:~> sudo btrfs balance start / WARNING: Full balance without filters=
=20
>> requested. This operation is very intense and takes potentially very=20
>> long. It is recommended to use the balance filters to narrow down the=
=20
>> scope of balance. Use 'btrfs balance start --full-balance' option to=20
>> skip this warning. The operation will start in 10 seconds. Use Ctrl-C=
=20
>> to stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any=20
>> filters. ERROR: error during balancing '/': Structure needs cleaning=20
>> There may be more info in syslog - try dmesg | tail=20
>> hightower-i5-6600k:~> dmesg | tail [38576.407681] [ T29728] BTRFS=20
>> info (device dm-2): found 37170 extents, stage: update data pointers=20
>> [38584.873805] [ T29728] BTRFS info (device dm-2): relocating block=20
>> group 64891125760 flags data [38607.693519] [ T29728] BTRFS info=20
>> (device dm-2): found 33194 extents, stage: move data extents=20
>> [38641.574032] [ T29728] BTRFS info (device dm-2): found 33194=20
>> extents, stage: update data pointers [38649.812477] [ T29728] BTRFS=20
>> info (device dm-2): relocating block group 62710087680 flags data=20
>> [38662.710999] [ T29728] BTRFS info (device dm-2): found 43884=20
>> extents, stage: move data extents [38696.292982] [ T29728] BTRFS info=
=20
>> (device dm-2): found 43884 extents, stage: update data pointers=20
>> [38708.587669] [ T29728] BTRFS info (device dm-2): relocating block=20
>> group 60294168576 flags metadata|dup [38714.889735] [ T29728] BTRFS=20
>> error (device dm-2): cannot relocate partially dropped subvolume 490,=
=20
>> drop progress key (853588 108 0) [38723.736887] [ T29728] BTRFS info=20
>> (device dm-2): balance: ended with status: -117 hightower-i5-6600k:~>|
>
> The format is a mess.
My apologies for the disastrous output format above.
> Please provide a proper formatted dmesg instead.

:~> sudo dmesg | tail

[sudo] password for root:

[44928.672213] [ T96240] BTRFS info (device dm-2): found 55680 extents,=20
stage: update data pointers

[44937.810972] [ T96240] BTRFS info (device dm-2): found 4 extents,=20
stage: update data pointers

[44938.590658] [ T96240] BTRFS info (device dm-2): relocating block=20
group 60294168576 flags metadata|dup

[44945.516661] [ T96240] BTRFS error (device dm-2): cannot relocate=20
partially dropped subvolume 490, drop progress key (853588 108 0)

[44955.995468] [ T96240] BTRFS info (device dm-2): balance: ended with=20
status: -117

:~>


>
> Along with the kernel version.
Most current openSUSE Rescue system CD used for btrfs check, uname -a >=20
6.17.7-1
>
> The relocation is rejected because there is a half-dropped subvolume,=20
> which is not that common.
> It maybe a problem with the fs that there are some ghost subvolumes=20
> that are never dropped.
>
> There used to be kernel bug that can lead to such ghost subvolumes,=20
> IIRC the latest btrfs check can detect it.
>
> So please also provide the output of "btrfs check --readonly" of the=20
> unmounted fs.

:~ # btrfs check --readonly --progress /dev/mapper/system-root

Opening filesystem to check...

Checking filesystem on /dev/mapper/system-root

UUID: 605560ad-fe93-4d09-8760-df0725b43ee1

[1/8] checking log skipped (none written)

[1/7] checking root items (0:00:14 elapsed, 5328460 items checked)

[2/7] checking extents (0:01:01 elapsed, 984830 items checked)

[3/7] checking free space cache (0:00:12 elapsed, 471 items checked)

[4/7] checking fs roots (0:04:32 elapsed, 910644 items checked)

[5/7] checking csums (without verifying data) (0:00:12 elapsed, 895024=20
items checked)

fs tree 490 missing orphan item (0:00:00 elapsed, 94 items checked)

[6/7] checking root refs (0:00:01 elapsed, 94 items checked)

ERROR: errors found in root refs

found 496776130741 bytes used, error(s) found

total csum bytes: 465839608

total tree bytes: 16133832704

total fs tree bytes: 14983905280

total extent tree bytes: 624771072

btree space waste bytes: 3613129770

file data blocks allocated: 1062495817728

referenced 976540409856

:~ #


>
> Thanks,
> Qu
>
-Greatest Hopes
Paul
>>
>> After passing,
>>
>> |:~> sudo btrfs subvolume sync / [sudo] password for root: hightower-=
=20
>> i5-6600k:~> |
>>
>> the command returned to prompt very, very quickly.
>>
>> A second balance attempt results with the following output:
>>
>> |:~> sudo btrfs balance start / WARNING: Full balance without filters=
=20
>> requested. This operation is very intense and takes potentially very=20
>> long. It is recommended to use the balance filters to narrow down the=
=20
>> scope of balance. Use 'btrfs balance start --full-balance' option to=20
>> skip this warning. The operation will start in 10 seconds. Use Ctrl-C=
=20
>> to stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any=20
>> filters. ERROR: error during balancing '/': Structure needs cleaning=20
>> There may be more info in syslog - try dmesg | tail=20
>> hightower-i5-6600k:~> |
>>
>> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device dm-2):=20
>> found 16 extents, stage: update data pointers [93690.667290] [=20
>> T69656] BTRFS info (device dm-2): relocating block group=20
>> 1495819878400 flags data [93703.323923] [ T69656] BTRFS info (device=20
>> dm-2): found 33 extents, stage: move data extents [93705.575991] [=20
>> T69656] BTRFS info (device dm-2): found 33 extents, stage: update=20
>> data pointers [93706.769453] [ T69656] BTRFS info (device dm-2):=20
>> relocating block group 1494746136576 flags data [93725.570642] [=20
>> T69656] BTRFS info (device dm-2): found 39 extents, stage: move data=20
>> extents [93727.449779] [ T69656] BTRFS info (device dm-2): found 39=20
>> extents, stage: update data pointers [93728.465650] [ T69656] BTRFS=20
>> info (device dm-2): relocating block group 60294168576 flags=20
>> metadata|dup [93736.722689] [ T69656] BTRFS error (device dm-2):=20
>> cannot relocate partially dropped subvolume 490, drop progress key=20
>> (853588 108 0) [93750.594559] [ T69656] BTRFS info (device dm-2):=20
>> balance: ended with status: -117 hightower- i5-6600k:~> |
>>
>> Please see the following referenced, prior posting for stuck=20
>> subvolume removal similarity.=20
>> https://lore.kernel.org/linux-btrfs/9f936d59-=20
>> d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>>
>> Is there a patch for btrfsprogs? If so can the patch be merged?|
>> |
>>
>> What are your thoughts on this?
>>
>>
>>
>>
>>
>


