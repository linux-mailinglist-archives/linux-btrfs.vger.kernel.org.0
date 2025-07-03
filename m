Return-Path: <linux-btrfs+bounces-15220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DBAF690E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 06:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BF24E8002
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F128D8DA;
	Thu,  3 Jul 2025 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OxgNmRL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011035.outbound.protection.outlook.com [52.103.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA564A98
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516255; cv=fail; b=I0sj9ZJrKCxw5Z2jmIDEtxOOQnd4h2DHpERCiOfbii0bb3hVt6YZCHz1kBNf2AFYm0AW9rFh3U/JIuCUlDXNtqaCa8zVbOTeh6KdfZcPdGmwMlpIChZ9DBFZjs2nuESL6KK3EuvoL59WbjASOyYRnG8s1TSteJhPsleiJ0s7i3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516255; c=relaxed/simple;
	bh=vzCRoTU/1Q8RbjPZ1MfBwGGfKAQSLNLcFIax9bJdl6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xk5ykXLbRY37AZQj5n3dlg8AJB4BqhLuzmr2EjZDLMIdBY6JJPuVYElmYBtChRkeU6J6ZBwTPbhuzEtD4XL1LU4mk6aH+9odD1yhD0GfN4RJ3+kBZ2aJ9mEp3zXAtiVnrqsQ52l4Ye2Sles9QfEDvubrB2LOSk1gf7FUeJbaeJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OxgNmRL5; arc=fail smtp.client-ip=52.103.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBC1Wjy9YqK5N2MDxVR8TSeBcKxqiBFWbxxkiclSwY4fWN/dORO+lk50v+alrHPtCNtrDQxR4Rh9xqVHIIIAy7hZfXtq7WyBE3JYnnqcM81R2MuinMkoYwFDObANaczAeNQPcWtOa+1dhN4nqEuRFEzoaAbZykiamo5gxq5liPG+ZIqUR4sORO2ftU0Nw5hq5lZekWWHDxqnl9TRVoS34VU/lwij334ozGN7W/50baiypm0D5AVFctrChrmWkrXrT5bpzwYjHvPs6rJMWcG1E0rGsCbf9jtjVql3iaAHBgp4YWt/i9P0ic5Q64tRuAfxeAtUgrEnTXFffcwOSHvQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyGFXChaZCTETaw1mlob94HmokTmTzyNVHM7RqMBzGY=;
 b=dTPeEADiaPVs1P/z4xZv28xzbeYzzo/pviCjeplG83PTF1e/sgmO9XzJltksoGCytaUcjg9ul4YbdwOOpUroYRkZtTPuypLEwAeziwGwbVaceP1gGbpOQELsC2nzAARvPTbNDdhPbuDH0yN/aqcondigVINGAaL61AMUjJIdeDqeaQq2zG3QoYkJgOQ4sLrfN9OVvnJRvh2U1wS4VcIavqJ1kYRA3Zes9mv9X0GjlnwPve0hj4Zt1+Zja8XUj78q0q4qbSHAQ/PbeMHn44t+l1k9hnFnHu/gojv5H4IBfH/0R6wIrig1aDqH25328mP5tXNALuzI+qDhnabMKC52HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyGFXChaZCTETaw1mlob94HmokTmTzyNVHM7RqMBzGY=;
 b=OxgNmRL5PO+C9XpOJtdRfZTTuTvHiVvCFMeduwl+lM4I4oye4Fen0u43Tk/rlHCGvdFXVhaQeC0Mw6OP3PxLkCrgYw4daUYMoQk+vanyFaQecc7B9EPJu1W/b7NXHmeYh6lVt7ZqtbKf5gruZb0/qmeDr0vZBQHBnEsqcHCG3BVwrK5ja+GwmfP823doQeidNEhbLnSz2wJmjYeJW/02Lg6fmr3bDTHFap8eFyPpwrTuibmTvr87AGZvybFosbjPgkooPe0+XJp3FMbWJDrKqicT2ZK5OqNXvpdt0PdQ1MJkgC/76lRAm4mKp1RWCgOAwvK3kZYkHy3uXSsjQZG2jQ==
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com (2603:1096:405:1fc::7)
 by OS7PR01MB13649.jpnprd01.prod.outlook.com (2603:1096:604:35d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 04:17:31 +0000
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45]) by TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45%7]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 04:17:31 +0000
Message-ID:
 <TY4PR01MB138533C94778E19D3109C40489243A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
Date: Thu, 3 Jul 2025 16:17:26 +1200
User-Agent: Betterbird (macOS/Silicon)
Subject: Re: multiple devices btrfs filesystem device detection on recent
 distro updates
To: Christian Heusel <christian@heusel.eu>
Cc: linux-btrfs@vger.kernel.org
References: <TY4PR01MB13853B64BF6DB7BEA98170AE99240A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
 <7aa130d3-7772-47ba-97ea-9f5002c037d3@heusel.eu>
Content-Language: en-US
From: Mio <mio-19@outlook.com>
In-Reply-To: <7aa130d3-7772-47ba-97ea-9f5002c037d3@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AK1P299CA0007.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:17::26) To TY4PR01MB13853.jpnprd01.prod.outlook.com
 (2603:1096:405:1fc::7)
X-Microsoft-Original-Message-ID:
 <c380394a-36fe-4fc1-8d30-003f133ae434@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB13853:EE_|OS7PR01MB13649:EE_
X-MS-Office365-Filtering-Correlation-Id: 641d7aa1-50fe-45f7-a601-08ddb9e8871b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|15080799009|5072599009|6090799003|41001999006|19110799006|461199028|4302099013|3412199025|40105399003|440099028|10035399007|26104999006|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU1HK1BNWHpnaUErbHFVK0ZWM0ZiUmFVb01JS0hQK3hXV052WG81WWxMRUg4?=
 =?utf-8?B?UWIwMGVEWWNhblBFclVEMGlzTXJ4K1JwY0IybEZvSFVNZlZybkUzeSt2bHBi?=
 =?utf-8?B?RDE4dTBQQkNPVzRjMm9hL0lhR3RielpuYXZibllsL3g0Qm56Y25mZ3RZSDJy?=
 =?utf-8?B?bHQ1TG0vU3FhWnpsMGJoc0VIcjZOb0JYeXlKSjBGN2hSQk9XbVJRRzhUOFRH?=
 =?utf-8?B?UER6UXBodVlQUmhvcEYyUHppa1ZraldPaGJsRU1hRjRPVDBoZ2VtaDNpbEdl?=
 =?utf-8?B?S3VydWIzbmxzSGZmVm1IN3NxZzlNSmNaVFJyU1ZPQUo1U3VoRjR5Nk9OTlVv?=
 =?utf-8?B?N2FDSmNoR0ZyMDZhRUpsa282cmQ0dUx6MklQejlTbzZnWXpwVUJOWmVpMFIv?=
 =?utf-8?B?Zk5lWUZ3THdlKzMyYXZuVG9SYldnYUFhbHpVckdKU29WRUlISEo3MXoydnVh?=
 =?utf-8?B?VUQ5b3lnS1kwYnp1YXJNVkdTemRFSlBWYlpCOU9KM2xEUGU2ZnZVcS9JRzIy?=
 =?utf-8?B?Q0JyM2taNkRPemNEWVZOditidklmK245cDZBZ0E1bDNsbVVVb2VHU3NZYUJi?=
 =?utf-8?B?NVpIQnI5b0tUc0poamNDMithM1YrSzVHVUFoemFISXRYcm9GQk5nZFJ5dERs?=
 =?utf-8?B?WW1iaVNDV0puc1lIODZCSzVlTTN4M1lGTTVVR2szTmV2ZU0zTloxa3lQenB5?=
 =?utf-8?B?K2pGanNkOEt2RVpTSGdpcTJZVjBaSU56dHoxUCsvRHZoS1c1SkdJMFIzd0hC?=
 =?utf-8?B?cXlNV2ZnTEo1SHRFeDlRTGxFb05MbjhadmdaRGR1eXIvMWtYdjFlSml3WVV2?=
 =?utf-8?B?c0JCOTV1L0ZuQWRleWQ0YWI0ejhVamtlNk5CcnlGZDZ2VnMyVndCc0hiK0xS?=
 =?utf-8?B?bFlPd1FtVE0vd0lUaTRQdWJOcEFyVlN6eFlaRDREb3BLeHo5Nnc2NUxiZlJ0?=
 =?utf-8?B?VXc2NHFZUjNXMEtpTDI1dzlXTGE3enp2TWdYQWlYU243SVdqQnN6bDhIcFF3?=
 =?utf-8?B?ZUdiMXYwbUpEU0FqalAyTDh4eUJQMi9ld283RlljOEJwNFY3bTFHcGd4Ylph?=
 =?utf-8?B?eWV4U2Q2anV3WWJMZng5bzRpQVR3NFAreVVqNG5PdWJSbUpqN3JvVXkzVUJt?=
 =?utf-8?B?T1RHT2M5WFVDRmtibXNzclM0Wkkvbk90UlZhVEdab21QdWVJUktDZ3hCbzZW?=
 =?utf-8?B?bVRoVTVFZlBreG1ieWZVcUJQTis5K255NjlVM29kZ2lEdDA3Z1dvVVhGVlMx?=
 =?utf-8?B?SHd4eTFpcDU0bDR5eHAyeTRlY3lqMmNGUVRnVGZpMUNsSFZxMnV3bTBYSWtO?=
 =?utf-8?B?dko0eWhNMWtYeGpXL0I0d05FRENwMGVobFRBRHJ4MGN5N293YkVYNnVtNHRQ?=
 =?utf-8?B?S0V4dEZIS09LK2ozTmIzZllxc1RkVzlPMnJNa2RFR2FsaFRiNjRPYmZYMWxy?=
 =?utf-8?B?dG5VSHgvK3JIbk94cm5ack9hTktLcUFNaGp5VDlmVndLRXU3QW9RTVcyUEhY?=
 =?utf-8?B?NFFESG1XcUZzSVgzbGZoVlFKWXpzWG5FZldFWndsUlNmK3dlVklCd0k1Mkov?=
 =?utf-8?B?NmFMZ21KKy93TkFPNVZDV1M4clZXVXVramhiZDdheTRLcy9EZmlRTlk1RkNn?=
 =?utf-8?B?Vk03TWxSdWY3TVY5eXpWQUIwQlkwVjlBenNsTGlsWi9NemF5WTlNVktYZEpH?=
 =?utf-8?B?RHF4S2hoZWlkREZkVzYxaWsrZzkxWVZHSmJ5LzI2S0hIVnJEdVJUeW1ZMy9O?=
 =?utf-8?Q?/MZm7fGSBBW0iVnOcm7wNvTxGQpiD/7A5Vtm4sa?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z25Oc2ZTUzhMMittdWZFaS9PMmtOUTBVT0w4SFVjTFdPQ1E1TmZJbWtwMm1U?=
 =?utf-8?B?TzV6S29QS1YyMTdQS3k0bjl0Sm9jWitoMWl5RmgydjJ3QWJCNEs4VjJJM05p?=
 =?utf-8?B?dDZDdE42ZTRWaUJnREV0aTV2c0xMOHUvRnVUVTVFSCtlbjR3bXp1ejBKUitn?=
 =?utf-8?B?QnJCMWZscmlEUXg3QWJQRGc3bThsUXRmQXNXQWV1cmpCaTAwNWdMc2JYN3lj?=
 =?utf-8?B?eGpkRFZqZEozTzhxcE9maEViS1VZdkFXNkdwU3FUNHNNZkJ5NDJUUmRkMkJP?=
 =?utf-8?B?YUFoc0J2dDhwYkJZKzluaURWelZtaDE1TzJvaEYvNzN4ZmZTYTFzTVNEK054?=
 =?utf-8?B?Q3JWWXNnSEw5ZzdmUVRWNU1BWTJwVHRQbytlSUhsVXBSOHltWEJ6bVNPMWZk?=
 =?utf-8?B?RlQxN1lFZ245cG1tMTZkZDlGbFhoRXJMWDMxclF6ZVNIWVVPUmpQN3RBZFNt?=
 =?utf-8?B?RFBoOS95aDR4MEtPQTNjQlZjd1hLTllvZzVmSWttZ1ArZGp6cko3Y3BaQVlG?=
 =?utf-8?B?VGE1d3Jic2NUblhYa2ZTallrb1NvbTZHb3VSK1JhMUVWTkQ5YnR3NWV6OGgv?=
 =?utf-8?B?OFgzSXhhM1BEdEM1OVQvYjZMbEsyS0RaVnVEU0M0TFVPN0FvUU1FNEc1VFRE?=
 =?utf-8?B?ZFd3b0hJd0tXUyt4QUFqSnRiUjNCUHpTb1BENFQxOTgwTHZaenFSRU5wNktV?=
 =?utf-8?B?eXNaa3J6aVRHbm01RFFTRUZNU3lPd0QwVXBPcDcrYURLKzN4RGovOTViTCtv?=
 =?utf-8?B?TXZzelQ2SEJuOE0zZU1lcFhZMGpNNlVGZitxb2xIdnZSVkcrZ3lQYW9KdE8r?=
 =?utf-8?B?SEgwWGZwc2VKakl5OG11YkZCa2twL2FxSGdUR1VEUmRhbGJrZ2JwWmw2RDht?=
 =?utf-8?B?dDl2WFVHRi9xTlVQd29oUzBjaEhrV1hCOFBrRStBUERuOHZzUnBYV3JrU1RH?=
 =?utf-8?B?SlpHNHc0V2hxSE1pVTVUT0NYaWNsNzZEUENTNENUcEIrVG03QkxFclZKZThh?=
 =?utf-8?B?cHprUzR0Y0FvVjJ5R2c4K0RNditLSlhOZGtBZEhPNi9DbFFXUlJSSkN6NVZB?=
 =?utf-8?B?SDhxcVliM1NEZ3VFbjZyY3h4d3ZKWSswSTNMMkwvL1RNNXpXOFFRSlZWeGFn?=
 =?utf-8?B?MnZwOFRnMjE2S1FlS2w5K3dYd04zRExVN2daaFBYQ3BvNG9CMFlRQ3o4Q2dZ?=
 =?utf-8?B?OVg3eTJKalVmWmRiYjJTTkhTMWhSTjgwQm5CTFBuKzE4ZkFJelRQL21CZFdy?=
 =?utf-8?B?REw5SUUwNjdXd2ZvWTVXL1JwdEdDbDU2bGppR243T3RmU1FweEkxUzVNVm5F?=
 =?utf-8?B?Q2VWZ3ZYaEhScEthb0x2QjN5UkpsMWJsTkJVWlNZQmxBYjd1TVkzL0JVbFZL?=
 =?utf-8?B?Mnl1SnlnSTUveE1ZYnpxVExtbGkvVU5GRWdNRzhDU0xXL28wTkhnQ3Y4QVpX?=
 =?utf-8?B?NEc1MkNOUnY5TVpGYUliZG1lSFVSZCtveWFwNEYrQ1hGUmxIUkQ1bVplVnZ6?=
 =?utf-8?B?RER2NzFpWFhxT1JWVzJBSDJyRk82Z0ZxS2QwcDVHcTUyVU9KUVRDT3hZelJD?=
 =?utf-8?B?MXVrM3JYUDdCVlh1SEMwVUlyaTlObmZGbUJna0FKMkd0Q2hZdGhwNk5pOUxE?=
 =?utf-8?Q?9towWnbuz607oRYZWtD72oxOgfGK8tEUkzqrqaxGFYFk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641d7aa1-50fe-45f7-a601-08ddb9e8871b
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13853.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 04:17:30.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13649


On 2/7/2025 10:54 p.m., Christian Heusel wrote:
> On 25/07/02 09:40PM, Mio wrote:
>> Hello btrfs mailing list
>>
>> I am facing a device detection bug on multiple recent distro releases and
>> rolling linux distro. It is a bug in userspace and not a bug in linux
>> kernel. I was able to test different linux kernel versions from 6.6 to 6.14
>> on some distros. The userspace with the problem shows errors on all linux
>> kernels and the userspace without the problem works fine with any linux
>> kernel.
> Could you re-test with the 6.15 kernel (i.e. included in the archiso
> released on 2025-07-01) or even the latest mainline released candidate
> (which is 6.16-rc4 at the time)?
>
> I have a prebuilt version of it ready here, but you'll need to find a
> way to run it on your system:
>
> https://pkgbuild.com/~gromit/linux-bisection-kernels/linux-mainline-6.16rc4-1-x86_64.pkg.tar.zst
>
> https://wiki.archlinux.org/title/Archiso#Kernel

Thanks for your message. I think that the bug is in user space 
specifically the util-linux package instead of the kernel. So I have 
reported the problem on util-linux mailing list with additional 
information that I tested the filesystem with an older version of 
util-linux. 
https://lore.kernel.org/util-linux/TY4PR01MB1385345D7813E44642723316E9243A@TY4PR01MB13853.jpnprd01.prod.outlook.com/T/#u 


Sorry I clicked a wrong button on my email client. It might result in 
duplicate replies from my side.

>> The problem is that lsblk -f command can only detect one device in my btrfs
>> filesystem. The filesystem has 3 devices. When I run the btrfs fi show
>> command, it shows a "Some devices missing" error message. However I am able
>> to mount it by using the device option and specifying all 3 devices
>> manually. After that I can see my filesystem correctly displayed in the
>> output of btrfs fi show but lsblk -f still can detect one device.
>>
>> How could I inverstigate this issue further?
>>
>> I previously reported this problem on
>> https://bbs.archlinux.org/viewtopic.php?id=306625 and
>> https://github.com/NixOS/nixpkgs/issues/408631
>>
>>
>> I copied following output with OCR so the result might be slightly incorrect
>>
>> btrfs fi show on archlinux 2025.06.01 livecd
>>
>> Label: 'HDDPool-data' uuid: cae95f2?-f8c3-48c5-96d6-e263458efda2
>> Total devices 3 FS bytes used 10.49TiB
>> devid 3 size 9.00TiB used 6.96TiB path /dev/sdb
>> *** Some devices missing
>>
>> btrfs fi show on archlinux 2025.01.01 livecd
>>
>> Label: ' Rescue3' uuid: 623630d3-64d8-4917-ade8-412101d23b40
>> Total devices 3 • FS bytes used 10.48TiB
>> devid 1 size 10.91TiB used 10.48TiB path / dev/sde
>> devid 2 size 14.55TiB used 10.50TiB path /dev/sdc
>> devid 3 size 476.94GiB used 28.00GiB path /dev/sdd
>>
>>

