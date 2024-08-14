Return-Path: <linux-btrfs+bounces-7203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94D9525F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 00:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C75B22CF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38914A4D2;
	Wed, 14 Aug 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b="Py9nI4YI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020073.outbound.protection.outlook.com [52.101.165.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65987346D
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675715; cv=fail; b=C2IMxynhHPDONuW4BsJLqP3ZrITYtR3qcYWXzxTo/qqVeYXDnKWNn/TwbKi3Lw7eJkr4zrQ0sDBvWuyMsSWYTaAmVjqB3dBwtOAiWritoLgeTFPpIFo37NN+Lp89iM9hszMNqliU879qSpiZfpFDFHH+6+OsS4ITl4I0frxdIOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675715; c=relaxed/simple;
	bh=asf8h1q7ACqsp7AKesxUP1jRGrbRMAF0IvznF0Rq0A8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUufkYpsz5dfEfUlbS6A1roY8l1lDcv/pOI1fXa3VFeRH37/DatOTzp+4rwZ9vySlzf5OkOJzqIp92bX34W4sglkY2/k8kYPjotyxcPa32IWX3QKJTcuj6orzZyPN2W+pSN0h+bIgiRX6z0DON3dwobaz+kfRrKfPtYbPhAheF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr; spf=pass smtp.mailfrom=ensta-paris.fr; dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b=Py9nI4YI; arc=fail smtp.client-ip=52.101.165.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ensta-paris.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJYRWZXBEhyIT02om+YFWvnnIg4XCo+P/pfaOes9bO45mI9eEh0wOy5brwO+R3NI7Rhmb4hGwU9k4eSMNQmnVlZXyR2eLEa+sAPWtonDIh5BRNYS3MM9V0xKWUjMo+zdGZB6ovOe/XQAahwPBrOuEfYeqz6zJjZXtJ44N8IsOz85JDapw15pNgD6ZO20ZLAjHqpsvhAe6YIy/p6CG2uon40wSq3WDDWK9HaVLJ19t1gkNeRnOkCsjPViSIzntoj3EoznfQE6e/ISa8GPNufQQb0R+g6Eo573rpqeGzEaYY/ABW55+jc1fLB2PX96nvGxcrKIPPEm/Mz9CQDT19/oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwcDdPdz9khNU4sWGEZWIycEFgCNSY5HisPpgAB26Y0=;
 b=wbqpvgBezoMfnauGFSdqg7/A/UDEkEbe3532tlSoY0qkBjuvxaaGWpx/pTVMqWPZJDY9qV2T4Pv6euYjhBs2kYWmy49Xb0jKA8h0toJKSAr3WgZzEIKkE+z++Yia4Kq16VN5CAB4YwWB2ORZg6TB4JWikZM5soogMG9tPWkhr2/xaVKbcX+3zUOSwCy2DPYzKkmsZqlI0doNntyA0f3243VLTg1SWeRQzJff3cdzEA6UwCvDmIADrch2kSvsYhnpC2QTkxZdy2dyKOu58/ogkRZK7W8aVEdY8rEcNMWjLrpfkTgvYMuDj9hPrP7J7vzn44VILpHqvHsbAfgTB3z1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ensta-paris.fr; dmarc=pass action=none
 header.from=ensta-paris.fr; dkim=pass header.d=ensta-paris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enstafr.onmicrosoft.com; s=selector1-enstafr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwcDdPdz9khNU4sWGEZWIycEFgCNSY5HisPpgAB26Y0=;
 b=Py9nI4YI7hfFzwxbkbUYtwtrNjvH/S9VVyNV8pOR8scZXxyWNYMPShf2esf15K/U1gf+G8ZGgarv5d6UHcZQaw3lqclO9SXPjNchtdZKWTNUSesxjnG1//iDtPtpSOnTSW8FH3wbfED2dBEikniCrSRRVnbfWosLRO1mk0UXXyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ensta-paris.fr;
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::10)
 by MR0P264MB4622.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 22:48:29 +0000
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8]) by PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 22:48:29 +0000
Message-ID: <d3879be4-177f-4469-b800-6d2a49640dd8@ensta-paris.fr>
Date: Thu, 15 Aug 2024 00:48:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
 <133cc484-f609-4274-a745-6567d7635855@ensta-paris.fr>
 <60774a81-7123-4bc9-b59a-4f845529584c@suse.com>
Content-Language: en-GB
From: Andre Kalouguine <andre.kalouguine@ensta-paris.fr>
In-Reply-To: <60774a81-7123-4bc9-b59a-4f845529584c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::20) To PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b1::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1P264MB2232:EE_|MR0P264MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa8b84-fb44-4b02-79a1-08dcbcb33656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|41320700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	TNERY2osKPYmZaAXnKK42ny2N3N3QSOLwAr1w/rQetDoqYkY85JhW11Yr98Km5BJJkt/gaoDoRswX1qTz/4EiHNl3QnTTTssbk+rgY6SbhibKhEU8t9Qseeiae0p+6pYMfXDctuB+fJ0/l3V0Ph3z0s1hjeeoMCxGBOKEd4glHvSSwBLPn/DpYpgTcqiEtX8HKCplmJU7gaOGSqCGLNn6Ne+fpAjPhi0rhEw3S8TatRzuERYYWAsQMsgvY/KnGHM0yx60iy5paRE/c4Fv6mimVT1++6T1Acc0OE7zG1DuJ9JS2KxR99lHHJ2Ugc59+TgJGclk2FrcBgCxx3XJzCbRNndivS9LkxsoUUYeI2wmC+Iid3dvAS878B3ziN2zS5a2CbkDa3ohbys0n3exEThJ0NVssi54LclHL+KhevmmqcSDdzCJFzbI9/SmvGu1SBQH5IncMn8FxWJRLvigCJtCjKRk9GJNAENoDtEM0F4jbW1XjkDYsseFFCquK/6J3MxTKbCCJh12O4Q6RcjVjrq5WPOdjgoX8SUpYr6K68TVJoEe2SIYt4Pn9GWb1s99yJdfM2sYQOnMZnrn20jmKFQUEYNuRUly6y4XM6YfQqsrRtYe6ouP9r82IhNr3lcHowq6xANC790yZDhBvOAx44wNBGfOWcJ1dW4fw8I2CZqnQA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllJZGszQWFZVFZtL0lOSTlJUG04b0d3VDlyTklWaWl0STFtdnlUYVV3eEFp?=
 =?utf-8?B?WjNQVFNCN3RzVTdLcVNJWmhxYjkxZ25VWHZqQWcydlY0UWZPSzNvdm9ieWRs?=
 =?utf-8?B?TnFhaUFKK0haNUhFTFZRWWhLU09vdFF1REN4TUU5UzNqOEV5VDVYM3h3RHhV?=
 =?utf-8?B?TllHRGlzclpOd2pXT1VYZnFSd1NsVnBiK2dsRUU3NjIxRDg1YnUzY1pHN1R4?=
 =?utf-8?B?U0xqUG0wZ1FZdElVZklJa1o0WTV5Zk5BMitRdFpGMzZVbzNBVlZyWmNybG82?=
 =?utf-8?B?T0oxcUFIeDRRSDNXNHVFOXJXeDEvem9nMm5XNEVuVFluYTR0aThBcXVsTWg5?=
 =?utf-8?B?ZG90NlhKSnlWMnU3dFJhS0tNYmtKQytGQjdGVnZidk8wS0JuNHphOEZzUDVN?=
 =?utf-8?B?ZDJoME4ydGZTZGtZTXg1YmZxSVY5STFPVzMrSVdTa1ZVcFkybVNyY3cwV1JI?=
 =?utf-8?B?WTF4QzdaU1dkS0gyZDFvT1FaakNRM09tS3pPTVVyckExS0hELytNT2xJS0Fk?=
 =?utf-8?B?cXQ1UHZoT2Z0cmlHZGVyZmRTMlM3elNhRk1tMG9VOUdOdk81dXJFdVVySXhW?=
 =?utf-8?B?OUJ4dTVHdkdUSVVsUGl4b2ZGYWVCZUdrTGlxeHQ1MTdTdnlOTG9ta2FrcnBh?=
 =?utf-8?B?VWJKWnV3UHpTQVJMRGlxRTdTWHM0allRL21UZkZQQnJIMUNQU2hqMlRLYWwx?=
 =?utf-8?B?UHRaKy9sUjlMMTZvNjcxVWp5bi83NjNGOFN1MXJLZmRyVHFzekdzYTRlK1dG?=
 =?utf-8?B?MjF4TDVHMU4xaEZmK0VVV2ZWcVEwa21PVnFSOGxubVozNTR0czF3TEpSRUF5?=
 =?utf-8?B?QmhiREs4K1ppZ0hxQmNkck1HMnRLbmlWYjVWZkVUbFN5M04vQTFadlBuS1g5?=
 =?utf-8?B?dUp5UVlXdGJzUkl1UWF6TjRTdEdJeUhjcTJJUHZ5dC9LelZQYUxOUGl5VXlZ?=
 =?utf-8?B?aG5YVUMzTmNIRXRtdFFLcmJDUUo1U0ptRlR5cVMvV2hCcGNuSXVWZUZQU2Uw?=
 =?utf-8?B?Q0xZOFFOVjRmdWNjTzZkc1FVK3ZueU5sMVdzWXAyN2ZKQ1hGTDY3U0pRbGwx?=
 =?utf-8?B?aTk3UzEyWm9ic0JyR3daNytlVVhSWXpCU1lzd1VQd2JOaUpzaWtDQ2RjZFQ1?=
 =?utf-8?B?R0NLNThEejRwOFZCZEhIMXpmdVo2dHVYeVBPOVBrNTR1aXZhNVR2Z3hZeWQw?=
 =?utf-8?B?ems1R2t3THpab1pqMlRRWW0zRVlnNDJRT1RmN2pZaTZKdENjZU1ESmdZL3Ra?=
 =?utf-8?B?N1NmSjFBRngwcUlwOWRXZW1PMDNiZmN0TXdYWHRraUpPSnBzcUx0T3NLb3hG?=
 =?utf-8?B?Q0VVUmpKbjhOMU9OMEU5dFIwMHg5aklwRTB1MkVUMU1aNVA1RWNCRm8xUGNr?=
 =?utf-8?B?eDllTjlvMWxqYlBvcTlxZWZmckQwRkQveWpCbk5mLzhoWHloRTJrd2ltb0JJ?=
 =?utf-8?B?dlRlaUw0ZzQxR2E1TGh2M1VxczZnWjAvY2lHMUorcnc0WW9QOXprNFh5TWpj?=
 =?utf-8?B?dHBSN0I3NURuRm5Dbnp2Z2tEZjVCYXFwZG1vVnF0dTdFR1dwdEZhRGVCcWFN?=
 =?utf-8?B?anhyWEtUVitIUG92M3VrUzhvTTJuSTB0eFF4bndyTEdpS1Z2Tmg2cG82VTZJ?=
 =?utf-8?B?dHJqYS91SkQ4MFFIUTFDZ1hNVHpZQWxtRXY1QTc0ZXJHK3VZZkRpSDY5R25S?=
 =?utf-8?B?L2NINDNyZEViMHM0ZTBkbEFSQ1licXFJMFlHTjJPTUZpcis5aXZMbWJFekZp?=
 =?utf-8?B?YnEwTXZhZVY4STdpbE54d2Y3RUtLb0t2WkJGWVMzbVY0eUhsRGE3TU0vREw0?=
 =?utf-8?B?MXF1Ylp4SWY3aXNXdFVIRkZJTzMvNG4zYXdZUGRDN3V4ZDFkb3gxYkpxaVVs?=
 =?utf-8?B?c2FyK0VuWjJIc1hPZ0NpZmdUbFRqaXFyQmRrckZ4K3huT0pqUXJlTEI0V0Qy?=
 =?utf-8?B?QjBzd1ZvUXVIVzRTNnU1K1RKN2lOMmRSNGFINmpjN0dMRXZxRGVKYkQrdnBX?=
 =?utf-8?B?blZLQk1iRmtET2hiN0pRcVJCUlgwdlpRRUZaVXlPVC84MStmRUVsRWhCbitu?=
 =?utf-8?B?MC95a3Z3dS9Mb1FCZUh2eFhEWTY0MzJIbCtNMEpZQ2dTNlUyRTZEcEFrN1BE?=
 =?utf-8?B?RTJNMEMyMTlwSkNGSTJUMlhscE91QnJJeXJJa0Rtd2ZUSUxydFhIZEdLZzVi?=
 =?utf-8?B?dVNMUzkxeTJIWXpacGdCbUVJdnpMRTNwRXRTNE56b3JSYUFnaDJxVWdCSEZJ?=
 =?utf-8?Q?EIrZJR1gKZmZzTvn2XWAjLAZS2TKMesyKjPODzu4mY=3D?=
X-OriginatorOrg: ensta-paris.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa8b84-fb44-4b02-79a1-08dcbcb33656
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:48:27.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f6c3f3f-c20f-4ade-b8c1-3e0fba16ec71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUAjeMyPEDEU0b1sjHvoq1WAz1R3ORWbyLEKbZRjAV9cx/Vqv5R80eKi64W0HOuQoGbzUNKWK6Y/nWWbiT1YRM5bk8jtZtvaN1kxqox3KD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4622

Hi,
Sorry for the late reply, I was trying to read up on the internal 
workings of BTRFS and trying to follow your advice while keeping up with 
a very busy workday.

TL;DR, btrfs restore didn't work, ended up using 3rd party software 
which worked, will follow your advice to avoid problem in future (+ also 
backups ofc).

Anyways,

On 10/08/2024 13:01, Qu Wenruo wrote:
> TL;DR, if you are not very familiar with the on-disk btrfs format, it 
> will be a hell to follow.
Can confirm, reading up more,
> # btrfs ins dump-tree -b 231990525952 <device>
>
> Then look for something like this:
>
>      item 11 key (256 ROOT_ITEM 0) itemoff 12961 itemsize 439
No such line or similar is present. Nonetheless, I seemed to recall that 
my home subvolume id was indeed 256 so I proceeded.
> That bytenr 256 is your home subvolume id.
>
> Then go with "btrfs-find-root -o <subvolid>" to find your home directory.
> And grab the block number again from the first several candidates 
> (which are the best ones), passing it into btrfs-restore:
>
> # btrfs-restore -f <subvolume block number> <device>

Unfortunately I get a checksum error repeated 3 times for 3 different 
supers.

I attempted several numbers and none worked, at which point I tried 
using a 3rd party software (DMDE and UFS Explorer). Both reconstructed 
some of the file system hierarchy, DMDE extracted corrupted files, UFS 
Explorer extracted files perfectly, I was able to recover the entire 
home directory except for some browser cache files.

Oh, I also tried photorec but grep-ing through the results only found a 
few duplicated pieces of 2 of the files I wanted.

I suspect that with a better understanding of BTRFS I would have been 
more lucky in using btrfs restore (and I will try to understand it). For 
the next install, I will apply your advice to avoid such problems (and 
obviously do backups...).


Thank you so much for helping me!

Best regards,

Andre


