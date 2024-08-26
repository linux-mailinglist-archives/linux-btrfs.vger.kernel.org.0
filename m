Return-Path: <linux-btrfs+bounces-7531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3495FDAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F2F1F255B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4D19DF68;
	Mon, 26 Aug 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GI4vsleI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2040.outbound.protection.outlook.com [40.92.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF482C7E
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713480; cv=fail; b=WKLfZlx083RjARVm0qcrLcrKeNlXbs9b7XDysRwwOLciIS8XTTpHSQgC3YTUSZdzNhmC2gW3j4SN6uAdDMYcGrFHYcUekMTJog/D0/aVrLIPbSeMgBClvda4fa8iyecu4v3iSO6ahsQAMgCEOui31AXIR5uX8+beM8e2HLzwH90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713480; c=relaxed/simple;
	bh=vS/C4CpXO1KAgtxGf3co0xWCqNcXiKCT6t6xE20AnU4=;
	h=Content-Type:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:MIME-Version; b=VYKW7yjxt8nza2r2kYfcTfvlXzMjl0rV6TQtf8FR/o39zdHInaChoEw7T+TtXdlOcxDUwx+g/GK43WzhEFUoeQ6zcNMdytzt4nwzrUQncojCRiJmdSvNuY8e6935i+g+vjm/8DshFn9quwCk6QTS0A+mHNd9b6NyETFNzEhBSx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GI4vsleI; arc=fail smtp.client-ip=40.92.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAkkhYIU5QP07+44FjcwVeoecmMcW/PzkWTvEAqmSTIEONHgoDTI33zTo50UGm8ZvX17a2atABLY1kebrPgIDxgj+5jxaHv6dFKTVSpTT8hbppGFOZA7m0ZwcC2Tj2gJ7dsXLJNsN9N2Dja8wCYpD289dGj5g45KIH28C+zKSBzCDeUIxBX7M5cZv8tiqQCbiJIyx7FFUH8wwNBNI6Ocruak4BrKwe/iFzwgWEiyEUfjbQi7GwQWrzyCS43+PKrspWVmkoARg3IZQLRHx8Ea7kWvAiQUVFT4DH0coZAMQHBWJIweig1+MO0XARrkP2WuMw9/OCGajDzJ5y+o6O8CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv60O79Fhhcec7XwmdTS2y2/mF+F/qF9IpQ+TvNDuro=;
 b=OVBkSUt06Ih7Tga1b0ThE/rgxZ+EWiU6D6uPWbgYVlB5In8sBIsLqTfp0JWj7CoTf4JyYSCerewI3IYvqurTVDapitkT4Qwg5mnBnuFPOn8eH+kjof0mT7WdtNFl7ViNeWLDFaZLaNKdjO0DAfvxoM4cvTlia6V/C04GEJBINgL3V6oW4ixH1byyA/kDdZegzZB9VoHmTJFOdGxZVUkC6hNDge3XiYjcP3jyYm+JnaPa9/0KlNMYL2CMMlJ2gmwgvTFgZYn8L4i+0SFkakqL9U1KjqzJDwnYOamVJAjKubBQ+A1Xqny8tr+Ee22QNPE2+xKs5zPCzE5jCOyxAFhKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv60O79Fhhcec7XwmdTS2y2/mF+F/qF9IpQ+TvNDuro=;
 b=GI4vsleIy8h1gTpgr1+kqsWp9IFWkn6Kzr1infEUIXnoAEzbALwuTGdpS23ep1nSj5EL1UFqZSui8HIkw6ypSSpfZUlQVSjVdwZ1hwsGMVEIDJzmUhfYfuLTh3wc5j/p9q19LxNfTyL5/DC2oCNwaGNiHBKZmZSIXso+WyFzGR5pD8R3sE0EHln/Nl/wKspEgYpBjjHdhWMt2/1D2COofTmABu2H/Zg9ymGP7zUXrNZlxwPQLt6knBLCPBe+1bp3e6wElfFMXUQ+VGvSGR7ZhuZizwPltnBwYxWnMnW3CXZDX9xUiNVf2yG3G1K7i1GPimY7a/uRB9AYZVypBwdKPg==
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:54b::7)
 by PA2P250MB1069.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 23:04:36 +0000
Received: from AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61]) by AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 ([fe80::e8e5:32e2:57ff:ab61%2]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 23:04:35 +0000
Content-Type: multipart/mixed; boundary="------------jSJqvbfjlV51OgYwOHhNv2kG"
Message-ID:
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Date: Tue, 27 Aug 2024 01:04:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
Content-Language: en-US
From: Pieter P <pieter.p.dev@outlook.com>
In-Reply-To: <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
X-TMN: [glYVMmZwLSUTF1LLFsEKdbhcdpI1Espq]
X-ClientProxiedBy: AS4P190CA0069.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::15) To AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:54b::7)
X-Microsoft-Original-Message-ID:
 <869641e2-1e5e-4f02-a74f-1eaf219a6ef2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P250MB0886:EE_|PA2P250MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 4360c875-7dfe-4daa-b6a5-08dcc623743f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099012|15080799006|461199028|8060799006|19110799003|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	FRyh2XS0hEKzVKNH59hKONDlUD/nsfDQAC7EbQIaxDR0PCjLrn6GTmZ+JMi98RDsh7/9Cof45xt/K6EVB9etHE61Nq/f7YZVZptbWdl3f9K1TJLzZYrK7qqHBajLht64ykv54koxzelVtSs9X2KT+zDIh2Xny3OLisMlQYYvXYXjUuAXozDVYX/3Cx772XGcv2GAtnm040ta+zYpTR99LwutrT9/O13SZEZVeo6nYq8iL0AUULS1srOTfNepL59eRMsltiafW16Dazpjp0VUckHjDINKy62ddLW5ew7Kk5hJpvw92+KBOuXMMqAxqrg+aOPr07WE/kXMsciYv4VHfUhhipK/JT7ARo9WgN1h06+v20At3+efk+nnaH6Ys6lcLBM70+5t4zzgEQAQcDLyng1+/de62ZW94aAghAwBpNqiddkDwTrstq+AZycirlHaK3J6ifEwHqzgmaj3fJLmGW51OAPOmzwBsgXzBZaBMF0eBH68G7+n3IW4Ks5GJ1b8RFeeMdDENvrKXcF9L9XbhH3A6HxH1kquTq+8MRmtjQhtRIRDuehRfJv8k0RZxnN+BLUM38LHM+kwxJpRb+H25DeoOmO51Ove3RP11fDW52SDDyxF9qw7j3RKbXM49WMvgw8qPANXNyy5Xltka52tw4NyW2vHTe++vx+G9RxGxeS0tDj8qakKvbYplfyJ7PleZHNKFfe6U6CduAAKzpSaZq8zh10CEpwiq/1OzY2dRaGAEBJHiGkOzTYHCtafL1V3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHpzSm1uSzE4U3Fza25Hak1YZ3dmd2xLWTRQbWd3WXhqSnR3Vkdid2lXa056?=
 =?utf-8?B?bS8xOEZGNEgwbjloSWhuY2c4cDdoYW1sRXk1clN0dkx3a3ZaeDhRc1BvRkFx?=
 =?utf-8?B?YWJKNGRseHVzUG9Bb3JJdXc0ejdjeFAyWVJxa004Y0QrZ2hNRTlJZ2VPMXRW?=
 =?utf-8?B?cWR1dlRuN3QvMndBLy9jYnJuM0lUYnV1bVRrYmJsQVJIZWJqNXJ3TWgxZ2p3?=
 =?utf-8?B?R3FzWGM0eFV1ci9VSElFc1FiRUV6Rm12dFJNbEJTdmxWQmNVdTNaYkFydlQ2?=
 =?utf-8?B?M1Rvd1VyZEthOTluRStIMGMvTTNEcFVvZHBzVWQvTUxISnNFNmQzZWxkYUM0?=
 =?utf-8?B?aG1wdElNck52YzIrUGtCdEZtdEl0UHduTFJCVkVISHdRRDZReVRrcVZNMXNj?=
 =?utf-8?B?NENjQmpOQmlKQWtYSEd2cXBoWUFsZElaQVd2eGF6N0IwTFd3c1Z4dzVHR2NJ?=
 =?utf-8?B?SG0yVXYvMzVtVUdwTUcxWHRjS3FrNVlodFk0VjVSUks4MmNMU1V0SC90Uzho?=
 =?utf-8?B?RHh3NUNOcEVteS9nMHF0WW0vbVJqQm9KSjYxYUNjcGNUZlpESUp5NEdBaWd4?=
 =?utf-8?B?SjR4QkJtNTAxOVpxRnVWRERaYXNWUVE0dkpzR0FDbUJGNFRZKy9ueW95eUdU?=
 =?utf-8?B?ZWZxQ3BDUXpsRVJRSTIvQU1QN3dCVHNEemQ1aVl6L1ZrVEJSa2tiQWlLTTFl?=
 =?utf-8?B?eEg4MU8wQVRicEwzNUk5cTlUUVBONkVQL2RiSzY2Mmg5bzdFbWVjWTVnOFFF?=
 =?utf-8?B?K3VWa0cxWlBpbjJXTW85L1BBWjhIMm5BeDZOcFJYWFZBQlZSdkVjbWVGRU14?=
 =?utf-8?B?SXZoQ2NRYXpPSW9XQkJOcTg1c0lnV0tzVlVTZVEzT3FweU0vQlorZ0x4QWlF?=
 =?utf-8?B?ZFp5MkRBeUNZaDZBM3VYaEZFclVHc1hUQTRHUWhpaFkwU1dxLzkvTm5Ld1Vq?=
 =?utf-8?B?a2lhajZQbWNZWnZNSFlSVC8wUW93K2hyRExia2svamRYaVdoeFhWNUdkamxn?=
 =?utf-8?B?eWYrbGZUbEQxZTRlTWx2QmcvdHQwcXN0Rm9qZGJUVENOU2QrbkUxQ1gvY2hR?=
 =?utf-8?B?d29hUHBIR3Fnb2JyMS9GS3RZd2EyTUFlQnpPLzBSTzBCQm50a0VmRUdZZ1ly?=
 =?utf-8?B?NXh1a2Vod243RStySHVOVldrc3hpaFRDSEp2bkpJNGJuMWRGMW0vZFFMQkRu?=
 =?utf-8?B?eFdhQUNKMDZGNEFoeG12VWZHb1FsL0J5U2dlblVpNUVxWWhOaWtoMzBOL2hH?=
 =?utf-8?B?OHV1TnkwWnhQbkNQMTNTMktKV0VMemNYL2Z4UUx5Y0E2b25sK0Z1Vi9UcHZ6?=
 =?utf-8?B?UnlqUEdhWFZaamFzQXNCZ2lyVDlVUVhhL2pVZHFkeGNGMW5zYWJNTXpRU2Ri?=
 =?utf-8?B?MWdMeTNGbkRzSFIyNGZXYk44bzVPdTN5eHYwd2FqOEUwUUNzNWx2TDlENlhV?=
 =?utf-8?B?Q1ZXSms0SnVWUFBNRjZUa0wwKzJYRElNU2EwTFdoQ3ZGYlR1dmdYNVI0N1J6?=
 =?utf-8?B?RDlZSVkzZmJTd2ZSRm1CeWVFRUFlcWFrMFBEeUZKbG1YSHJYY2E5Y1hxSmk0?=
 =?utf-8?B?S05jby9NUzlYTnJyNVdsS3k1bUpGMTlEV2p6Mi9EOE9JYTV2RjJtTXY4T3Bs?=
 =?utf-8?B?UWZJcVRlY3NTcDJYNTZoSEpEcGxPOS9MbXh4OU5TODJqTkxQempIV1pYTXFP?=
 =?utf-8?Q?RM/SIdnwxbUNsU7qSRm1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360c875-7dfe-4daa-b6a5-08dcc623743f
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0886.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 23:04:35.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P250MB1069

--------------jSJqvbfjlV51OgYwOHhNv2kG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the help!

On 21/08/2024 00:55, Qu Wenruo wrote:

> And in that case, "btrfs check --mode=lowmem" output may help a little
> more, and the same for "btrfs check --repair --mode=lowmem". 

I've attached the output from both commands, unfortunately, that didn't 
fix the issue.

Subvolume 257 is my /home directory, and the broken inode is a temporary 
file in a Chromium cache folder. I've tried deleting and overwriting 
that file, but this causes the file system to go read-only a couple of 
seconds later, and after re-mounting, the file re-appears. Reading the 
file is not possible (input/output error).

Is there a way to restore the file system by simply deleting this 
inode+data entirely?

> If above lowmem mode still doesn't work, I can craft a tool for your
> specific corruption if really needed.
>
> But that will need the dump of your subvolume 257 inode 50058751. 

Which data would you need specifically? How do I get such a dump?

> Unless the system is using ECC memories, I doubt if that diagnostic tool
> makes any difference.
>
> If there is already a strong indication of bitflip (and yes, it is), a
> full memtest is highly recommended.

No ECC memory, but I did perform the "thorough" memory test using the 
Dell diagnostic tool multiple times. It included data bus stress tests, 
march C- tests, ground bounce tests, random pattern tests, and some 
others; all passed without issues. Since I haven't noticed any other 
problems (the system works fine when booting from another drive), I'm 
blaming an unfortunate cosmic ray for now :)

Thank you!
Pieter

--------------jSJqvbfjlV51OgYwOHhNv2kG
Content-Type: text/plain; charset=UTF-8; name="btrfs-output.txt"
Content-Disposition: attachment; filename="btrfs-output.txt"
Content-Transfer-Encoding: base64

c3VkbyAuL2J0cmZzLnN0YXRpYyBjaGVjayAtLW1vZGU9bG93bWVtIC9kZXYvbWFwcGVyL2x1a3Mt
eHh4eHgKT3BlbmluZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uCkNoZWNraW5nIGZpbGVzeXN0ZW0g
b24gL2Rldi9tYXBwZXIvbHVrcy14eHh4eApVVUlEOiB4eHh4eApbMS83XSBjaGVja2luZyByb290
IGl0ZW1zClsyLzddIGNoZWNraW5nIGV4dGVudHMKRVJST1I6IGV4dGVudFsyMjE2NzE4MzM2LCA0
MDk2XSByZWZlcmVuY2VyIGNvdW50IG1pc21hdGNoIChyb290OiAyNTcsIG93bmVyOiA1MDA1ODc1
MSwgb2Zmc2V0OiAwKSB3YW50ZWQ6IDEsIGhhdmU6IDAKRVJST1I6IGZpbGUgZXh0ZW50WzUwMDU4
NzUxIDBdIHJvb3QgMjU3IG93bmVyIDI1NyBiYWNrcmVmIGxvc3QKRVJST1I6IGVycm9ycyBmb3Vu
ZCBpbiBleHRlbnQgYWxsb2NhdGlvbiB0cmVlIG9yIGNodW5rIGFsbG9jYXRpb24KWzMvN10gY2hl
Y2tpbmcgZnJlZSBzcGFjZSB0cmVlCls0LzddIGNoZWNraW5nIGZzIHJvb3RzCkVSUk9SOiByb290
IDI1NyBFWFRFTlRfREFUQVs1MDA1ODc1MSAwXSBjc3VtIG1pc3NpbmcsIGhhdmU6IDAsIGV4cGVj
dGVkOiA0MDk2CkVSUk9SOiByb290IDI1NyBFWFRFTlRfREFUQVs1MDA1ODc1MSAwXSBjb21wcmVz
c2VkIGV4dGVudCBtdXN0IGhhdmUgY3N1bSwgYnV0IG9ubHkgMCBieXRlcyBoYXZlLCBleHBlY3Qg
NDA5NgpFUlJPUjogZXJyb3JzIGZvdW5kIGluIGZzIHJvb3RzCmZvdW5kIDU5NzAzOTEwODA5NiBi
eXRlcyB1c2VkLCBlcnJvcihzKSBmb3VuZAp0b3RhbCBjc3VtIGJ5dGVzOiA1NjM5Nzg4MjgKdG90
YWwgdHJlZSBieXRlczogMTQ3MzkwNjI3ODQKdG90YWwgZnMgdHJlZSBieXRlczogMTMwODgyMjcz
MjgKdG90YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDkxMTkxNzA1NgpidHJlZSBzcGFjZSB3YXN0ZSBi
eXRlczogMjUyNzYwMTg5MgpmaWxlIGRhdGEgYmxvY2tzIGFsbG9jYXRlZDogODE2ODEyNTM1ODA4
CiByZWZlcmVuY2VkIDEwNTUyOTA0OTA4ODAKCnN1ZG8gLi9idHJmcy5zdGF0aWMgY2hlY2sgLS1t
b2RlPWxvd21lbSAtLXJlcGFpciAvZGV2L21hcHBlci9sdWtzLXh4eHh4CmVuYWJsaW5nIHJlcGFp
ciBtb2RlCldBUk5JTkc6CgoJRG8gbm90IHVzZSAtLXJlcGFpciB1bmxlc3MgeW91IGFyZSBhZHZp
c2VkIHRvIGRvIHNvIGJ5IGEgZGV2ZWxvcGVyCglvciBhbiBleHBlcmllbmNlZCB1c2VyLCBhbmQg
dGhlbiBvbmx5IGFmdGVyIGhhdmluZyBhY2NlcHRlZCB0aGF0IG5vCglmc2NrIGNhbiBzdWNjZXNz
ZnVsbHkgcmVwYWlyIGFsbCB0eXBlcyBvZiBmaWxlc3lzdGVtIGNvcnJ1cHRpb24uIEUuZy4KCXNv
bWUgc29mdHdhcmUgb3IgaGFyZHdhcmUgYnVncyBjYW4gZmF0YWxseSBkYW1hZ2UgYSB2b2x1bWUu
CglUaGUgb3BlcmF0aW9uIHdpbGwgc3RhcnQgaW4gMTAgc2Vjb25kcy4KCVVzZSBDdHJsLUMgdG8g
c3RvcCBpdC4KMTAgOSA4IDcgNiA1IDQgMyAyIDEKU3RhcnRpbmcgcmVwYWlyLgpPcGVuaW5nIGZp
bGVzeXN0ZW0gdG8gY2hlY2suLi4KQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L21hcHBlci9s
dWtzLXh4eHh4ClVVSUQ6IHh4eHh4ClsxLzddIGNoZWNraW5nIHJvb3QgaXRlbXMKRml4ZWQgMCBy
b290cy4KWzIvN10gY2hlY2tpbmcgZXh0ZW50cwpFUlJPUjogZXh0ZW50WzIyMTY3MTgzMzYsIDQw
OTZdIHJlZmVyZW5jZXIgY291bnQgbWlzbWF0Y2ggKHJvb3Q6IDI1Nywgb3duZXI6IDUwMDU4NzUx
LCBvZmZzZXQ6IDApIHdhbnRlZDogMSwgaGF2ZTogMApDcmVhdGVkIG5ldyBjaHVuayBbNzQxOTg2
MDA5MDg4IDEwNzM3NDE4MjRdCkRlbGV0ZSBiYWNrcmVmIGluIGV4dGVudCBbMjIxNjcxODMzNiA0
MDk2XQpFUlJPUjogZmlsZSBleHRlbnRbNTAwNTg3NTEgMF0gcm9vdCAyNTcgb3duZXIgMjU3IGJh
Y2tyZWYgbG9zdApBZGQgb25lIGV4dGVudCBkYXRhIGJhY2tyZWYgWzU3NjQ2MDc1NDUyMDE0MTgy
NCA0MDk2XQpzdXBlciBieXRlc191c2VkIDU5NzA0MDA0MTk4NCBtaXNtYXRjaGVzIGFjdHVhbCB1
c2VkIDU5NzA0MDkyNjcyMApFUlJPUjogZXJyb3JzIGZvdW5kIGluIGV4dGVudCBhbGxvY2F0aW9u
IHRyZWUgb3IgY2h1bmsgYWxsb2NhdGlvbgpbMy83XSBjaGVja2luZyBmcmVlIHNwYWNlIHRyZWUK
WzQvN10gY2hlY2tpbmcgZnMgcm9vdHMKRVJST1I6IHJvb3QgMjU3IEVYVEVOVF9EQVRBWzUwMDU4
NzUxIDBdIGNzdW0gbWlzc2luZywgaGF2ZTogMCwgZXhwZWN0ZWQ6IDQwOTYKRVJST1I6IHJvb3Qg
MjU3IEVYVEVOVF9EQVRBWzUwMDU4NzUxIDBdIGNvbXByZXNzZWQgZXh0ZW50IG11c3QgaGF2ZSBj
c3VtLCBidXQgb25seSAwIGJ5dGVzIGhhdmUsIGV4cGVjdCA0MDk2CkVSUk9SOiBlcnJvcnMgZm91
bmQgaW4gZnMgcm9vdHMKZm91bmQgNTk3MDQwOTI2NzIwIGJ5dGVzIHVzZWQsIGVycm9yKHMpIGZv
dW5kCnRvdGFsIGNzdW0gYnl0ZXM6IDU2Mzk3ODgyNAp0b3RhbCB0cmVlIGJ5dGVzOiAxNDc0MDAy
OTQ0MAp0b3RhbCBmcyB0cmVlIGJ5dGVzOiAxMzA4ODIyNzMyOAp0b3RhbCBleHRlbnQgdHJlZSBi
eXRlczogOTExOTQ5ODI0CmJ0cmVlIHNwYWNlIHdhc3RlIGJ5dGVzOiAyNTI3Njg2OTkzCmZpbGUg
ZGF0YSBibG9ja3MgYWxsb2NhdGVkOiA4MTY4MTI1MzU4MDgKIHJlZmVyZW5jZWQgMTA1NTI5MDQ5
MDg4MAoKc3VkbyAuL2J0cmZzLnN0YXRpYyBjaGVjayAvZGV2L21hcHBlci9sdWtzLXh4eHh4Ck9w
ZW5pbmcgZmlsZXN5c3RlbSB0byBjaGVjay4uLgpDaGVja2luZyBmaWxlc3lzdGVtIG9uIC9kZXYv
bWFwcGVyL2x1a3MteHh4eHgKVVVJRDogeHh4eHgKWzEvN10gY2hlY2tpbmcgcm9vdCBpdGVtcwpb
Mi83XSBjaGVja2luZyBleHRlbnRzCnN1cGVyIGJ5dGVzIHVzZWQgMTE5NDA4MTk2ODEyOCBtaXNt
YXRjaGVzIGFjdHVhbCB1c2VkIDU5NzA0MTkyMjA0OApFUlJPUjogZXJyb3JzIGZvdW5kIGluIGV4
dGVudCBhbGxvY2F0aW9uIHRyZWUgb3IgY2h1bmsgYWxsb2NhdGlvbgpbMy83XSBjaGVja2luZyBm
cmVlIHNwYWNlIHRyZWUKWzQvN10gY2hlY2tpbmcgZnMgcm9vdHMKcm9vdCAyNTcgaW5vZGUgNTAw
NTg3NTEgZXJyb3JzIDEwMDAsIHNvbWUgY3N1bSBtaXNzaW5nCkVSUk9SOiBlcnJvcnMgZm91bmQg
aW4gZnMgcm9vdHMKZm91bmQgNTk3MDMzNDE0NjYyIGJ5dGVzIHVzZWQsIGVycm9yKHMpIGZvdW5k
CnRvdGFsIGNzdW0gYnl0ZXM6IDU2Mzk3ODgyNAp0b3RhbCB0cmVlIGJ5dGVzOiAxNDc0MTg4MDgz
Mgp0b3RhbCBmcyB0cmVlIGJ5dGVzOiAxMzA4ODIyNzMyOAp0b3RhbCBleHRlbnQgdHJlZSBieXRl
czogOTExOTMzNDQwCmJ0cmVlIHNwYWNlIHdhc3RlIGJ5dGVzOiAyNTI3ODU5NTY1CmZpbGUgZGF0
YSBibG9ja3MgYWxsb2NhdGVkOiA4MTY4MTI1MzU4MDgKIHJlZmVyZW5jZWQgMTA1NTI5MDQ5MDg4
MAoKc3VkbyBidHJmcyBpbnNwZWN0LWludGVybmFsIGlub2RlLXJlc29sdmUgNTAwNTg3NTEgL21l
ZGlhL3BpZXRlci94eHh4eC9AaG9tZQovbWVkaWEvcGlldGVyL3h4eHh4L0Bob21lL3BpZXRlci9z
bmFwL2Nocm9taXVtL2NvbW1vbi9jaHJvbWl1bS9EZWZhdWx0L0NhY2hlL0NhY2hlX0RhdGEvZjg4
ZDlkNDZlMWFiNjRlM18wCgo=

--------------jSJqvbfjlV51OgYwOHhNv2kG--

