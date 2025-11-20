Return-Path: <linux-btrfs+bounces-19229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD48C76331
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 21:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597C94E20E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC132FA11;
	Thu, 20 Nov 2025 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lqhYeIsa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013079.outbound.protection.outlook.com [52.103.46.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAB26ED53
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670430; cv=fail; b=X5BlvfAClJ1757c9bdyBRMHeMUjf5FV90++E8i3wVBupTzgLb2uGo70oOWjDmTUmryIGYJT1rmSKW7jEYsqHGQVpMYSTE1DfH63QBk4PGA2/WI/UzVoEdpvGiHZb0JXkkEO0wXTC7TE7VCDBC/DFarGYhAsfX8w58vi+tNQ/k/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670430; c=relaxed/simple;
	bh=QSbw4LIjqDAaO7dAKyrdTQW9YMo/1akIl58ltgSJeEw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=cIjZ9kGYAkVMv4EBxzRhNTQY595yGJP1g0GPB9zbJQxLP4tLLxIDvdOl3918CLHzF6CXoVp17DPjmGa89wM7ONwkwe/MJqKPrGKpXt+F+wcae0s4idDeWKPCktGYXEZT2WkDYWre/8hkNeQji0A4RpnEqyUgzWXZqUNG9a/C6TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lqhYeIsa; arc=fail smtp.client-ip=52.103.46.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dznpi9hWXdhn/TZIu2zxGY5QzZ6sanhxxgkYFBjww5TnlY+nh2YGYlb1b8MLx22jsv9pyYE1smCgwfhI+neS30g4zgrJKTA0M+QYM82RBbXhsTNndJX9gJ/XOPoLQDAalemLkCes0Fu6SfKXqgTsyAqlYksTZPzQ17b0//9cYaFPU1oBapX/8X6xenRUAusPZ/mowaQpHqrBoTA37MmeiLy3RYZy0OWxJWCdngGyIQ3sCmzRwLxE8/ODloCJQEpbxaV9mZQjfwv0yGOZ5d0rmQXs5SSM5G1sZrdJ27UiN3NZV9rMupOqdZm8zodZGCNntzq3CY8Au8DB1oUazW4CIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et37IcE/aUf+qKnQrnfirdAcKaKvQ9JLHKrxyjyHG4U=;
 b=HBiLq/Y4bFPoRXpJcpz29h0DXDbDUhcKNk5LZWiizASVzrn8B+8FZDupr/tLXpW3TGTuc2vTLPTQST22OWUrezPQ4I14eSpxr2bq2gfu8Q71uEZbuCmd8C7DlS11cUJqVjwjn2DxOk50Wevn297cr6DROfIv2ItYb+kjFNQQd6JAQeeWYrZCKyVepr+LbgnxG3Z/+IPFg+5IRsx54ObrTgYr6VXcnuBIlNw2tHH0Ntu7JFc6LpCKQfJaTkTmMWXL1gp7ObsDTMyD/VrN6nm+e4O6vbPKaDdVziElNxdP7Iwd99IpFdf5NcRXQdfskCUeMZni2TpEYF6JD8CeVnDyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et37IcE/aUf+qKnQrnfirdAcKaKvQ9JLHKrxyjyHG4U=;
 b=lqhYeIsaRuMjFXEUYoABYZq1Mlyq3YmVk285TK29xWuccX85pmxB4PJKFEP5cpbqWfg5eoGnq2KrPpYm1nzwageJfc97p9aFoHCc1JwHReaywGHl+Kv+zYTUbYbMoYLRVdwxSRgUE6Tnt35sgP9cdtW6nZ4oPqrlOMUBKTiXs6h0ls2vx99hZVOGsktOs0uI8EJzkhdE6i/e4Yj6UKl/eEP9AhX2xDq6Jm0ej38Hlw5JNXokrFuX3Aegv4UJEEDkTW4+hfbDiVOt+fbfxu/NB8xSCLO9U6lw54u4F/BI+vLagiQ4dDuoMIbr0BqGWZ+ParMIYo5yakB5kR4ZTGFhuA==
Received: from AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::13)
 by PR3PR10MB3785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 20:27:03 +0000
Received: from AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7118:e579:8c6d:25c6]) by AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7118:e579:8c6d:25c6%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 20:27:03 +0000
Message-ID:
 <AS1PR10MB5747E8FFDB4C6188879410909CD4A@AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM>
Subject: btrfs send: output file corrupted after suspend/resume
From: TK <tk2345_@outlook.com>
To: linux-btrfs@vger.kernel.org
Date: Thu, 20 Nov 2025 21:27:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
X-ClientProxiedBy: BEXP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::11)
 To AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::13)
X-Microsoft-Original-Message-ID:
 <6a3250e46dcd514a1aa182c7c4b7488533ccc46e.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR10MB5747:EE_|PR3PR10MB3785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d42d881-2aca-4fba-69cb-08de287329dd
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12DdgSaIndyTpt8agEZdjfNIVVIM+cuzpE9di4PAMmJoOQY/U+cKtfnyhjUhwAwrGQvDi76n4KwmTQJmA7NbZsGBObzoGEKeTiT76l5Oebt5CMXswl3HTN7bFc7We/tKgZ5nOuV+wh8UhKt7FnSeWfGMrLmvDzqIZnOqnvaQYMQWiXPRqVjAd3AP6tpBOtzShjQn1xXtOFh9HV6TsR98iYYfTxbHw3m3CIoAbjJmRlOMwXwhLGlACWW9K57bdm4PDgklHlPvvDBYqRdjuGTrZMewYGkMs2CtcItknrvcs/OYdaaORb3mZPMcoSEKt8NyavWy8NZBS+nvA9wKo/lsc+SZO3RcFCm9OyqRt28v7ekQUppT2WjsVVbipsJwybQWICCEqFeRrEYEL6kQe0RR1mFA7GviroidhW0bRscAPARuJKF1WSudbUDP+QWl2E3i5FNx0VuALoJiZC72b+H7tnetu2g/hjQdJrj0d23GipdNt3rAbwMeTtqD1sLN/yRtwH16H7c8Xcyx4DoTzDOgZMcYJiY00OyxCtuAvW5XvhO6ohwtfWBEXs77WdXxvVk11AhFODs1ZEvBKXAaRWTlj5XcMU1tcu7JYcsCDMOf9WEokUNaFQ5dlDrI6b4sqKoRitWZCZddiEqobF6kIUB0SgTbXNU2kkQJ7Oh7ysPuRgkW07Fp4HFwgIzlcDI8slVYRSYuJSLPRm/Q46pwIwnsTgfjC/jKCp1vUWgvLjpg16tffj+RcAFkRdY2I
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|39105399006|461199028|19110799012|9112599006|8060799015|15080799012|23021999003|440099028|3412199025|40105399003|3430499032|3420499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhoRTVyaWJLWGR5NEZsUlBKN2Y0eDl6Z2pLelo3YWJUV1RUK1RUREtVNm8w?=
 =?utf-8?B?WWNwN2JqZWdVWDlaZmdBOWd6QnN1ZVpxSVowQXk2dWExdENrdjk2YlI4VG9n?=
 =?utf-8?B?YUk5eGxNUUdmb0kxK0ZSTE95VlZOajY0RWk0K1Q3cnc1bWNRc1NUd2hhdld6?=
 =?utf-8?B?Y0JkNDVsY2lXTWg3R3kyYVlBMGdiNEp2SVRqbzRHWU53NUF6UW5LWm9NZVNl?=
 =?utf-8?B?cUhDbGVWUXYzNW85SDEvelIzMzVnZFhrOHRaZDdpQWkyOE1zNGt0TDZEQ1V3?=
 =?utf-8?B?OHIyaWZzMEJrR1ZEU0tYVVRHMitJNDJ1ZnVEUEQwRzlJcDB2THZuZHhhdjFM?=
 =?utf-8?B?N0lDelZKdDNaa2lueGZwK2dBY1dKZm81WVduWlhuYjVRbDY3UW5tZ01TNURi?=
 =?utf-8?B?Q3d4bktVNm84cFhHS01US1QreUFLcWZJOXowYWUzZmxVcGUvSVcrRDR3RHlY?=
 =?utf-8?B?OUd4UmdYTW5sbjgxVjZyY21CUmJBc2VCYmdzVFRkTkZCSWVWS2ttdERBMDhE?=
 =?utf-8?B?T2FOeno4S2kvS2U5eFlzYTJpSU9aL25OUjNWMTZrY1hmRlVqSXZZVW5vYWVO?=
 =?utf-8?B?cU9IcGxmSDhsUXIxeW1UQW0zbjI5QzhmQVV4b2xyVTRsTUVYWThyUmtRVSsr?=
 =?utf-8?B?QkpIbkRseEY2MjZWNHlGNUt0ckZXclhGODhXZXIzNnF6cUpIaC8vZVF2SGtj?=
 =?utf-8?B?eDhBakV4dVhXcW5VdVNqdURrWThIcGVGSm9VMHE4V09HdWh3UGh2RGNDd2hk?=
 =?utf-8?B?UEZyZHhneUZvY2J1TjhSSGN3dEQ5UXhabS84MWNSLzJkWm1rcnM1eGFCZmN2?=
 =?utf-8?B?UjB3K29PVEpyN0M0Mm1rMFZYbzlURkZqQlhxZFhBUTU4eFFSUzNzZ0hDZUJ0?=
 =?utf-8?B?M1JhTTJRdXB2K0pndUJ0RHprbVFxSEZrTktDblltdyt4MjVZL2MzMUY2b09K?=
 =?utf-8?B?SGwxZVIwd2dRbVpvSHM3Q0tJaWRJdnplRWViTGl0alkzV3pqZm1RUGRPaVhk?=
 =?utf-8?B?bHVVa0xIaENrM1RsaEwzUTJUdFRhRDlwcllpTDFkMGc0QjRZWkFTTDk0bnlk?=
 =?utf-8?B?QzZZVnplVTd4elMrYjdON2ljK2VmL2U2Y3RlajJtaE9XMUNqWEw2bzljaGNG?=
 =?utf-8?B?QjVqSUw1M2J0cmx6ZGw3aXl2YWxHbzAraWJ5LzJQR3BnaWpscVl2VUoxUUN0?=
 =?utf-8?B?TUJ1ZklXczA3UGhTWitMWnEySEp2ZlJNT3N5REVEZURBSDJHbGJTSWlBc2lw?=
 =?utf-8?B?NzE3ckE5NlQ5Q3NuN05pSUtTQmRmb1FRTTU2Mk5leHAxcW05RmJncE5uNVZR?=
 =?utf-8?B?YmtlSytJVzhNUzBTbWpFR0VDTWpqZmRJblpRM3MyWklDS1ZhQlhPYVBsRWJh?=
 =?utf-8?B?YjJ2SngxNU5xN1hBU2NpQzR2YUdydWxSLzZxNnhsdjF1OXBvZ1gzZElTd3ZC?=
 =?utf-8?B?SkwzNFF3akVyRjIvR3FKRjZNVjNRSW5XanorR1lpQWV2dGk4MjdLYW0zN3pP?=
 =?utf-8?B?U3lXQjhuU0QzbzF3eUNVeUFQT3pBMzJKODZ5cmJHTk9Pd3lqTE9FY0ljTE9D?=
 =?utf-8?B?cHBMYnpSem44NjdUY2djN212ZE9BOWl2ZHByYXdqbEY0dFE0d3FRcXNTREJx?=
 =?utf-8?Q?WHH57NE3MaOuRl8vAFb+TnaR3BD98GNhl4IIQzWQypP8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU9acEs4SC9jRzhUTGxUREdJdVJMSlA5Zy9kYmtxMjVpTWVUTlRMdk5ZalVM?=
 =?utf-8?B?K25NRXNNa2M3R1QxeGFKdDgvckVxc2ova1FvT1R0b1h5QU01OFBMN3czYkcw?=
 =?utf-8?B?MDlZSkU1R01Hai84aHhSUXJuQUlQSktJZzJZbkQyWUlYU0duTFFOdTMydlhC?=
 =?utf-8?B?RlJnZWFZTExaL2hncDI2Sk9rTnluY1gwRG50MHZnUWhmdFQ1c1hjYVNkdWJU?=
 =?utf-8?B?MGlSVVZCMThKR2dUbVBUQWNjbmxEMlZwdk5rUEhEZXRSMTRpZEx6eXFWZUdI?=
 =?utf-8?B?Sk9WZ0U1NTVkM3V3YWRqa3lMVTdtVlhMOTlGbzYwQ1NJTFBZOVdyWFQ5V2hi?=
 =?utf-8?B?SWpoTG1COHoyWXY3WUZlSEtUbjlETmk1SGVzaHhqMHNTRzVWQWtKaVVpQjM2?=
 =?utf-8?B?OUhUR25nWkNSOVpsYm10aWphVnU5Q1ZiZmphWlE5WkJMZWtmU09wWU5RV1F4?=
 =?utf-8?B?aUI0c2RPZm9maHlLQkoyUzJsdXU2N2kxdElBbnZqN1pRWDg4VDdLNHYyRERH?=
 =?utf-8?B?YzhvTURkeTR0K0ZhczdlcitPaW1BT1ptMUdEQzI5Y0NXVUM5R2N4TmcycHd5?=
 =?utf-8?B?QnA4djV4QlRTL3h5SnhreG1NRjMxZ3o3dlpqUVhzOG5jLzBRSUpndHVKNEJG?=
 =?utf-8?B?bXNXUGtKWFhJNjFwZGNwLzRwelYyUkxCV2Jjc3g0MHNJd2hrZ2E0RVFjdDMw?=
 =?utf-8?B?TTVPTkFTdjd4WUQyaUNiaHhEcWNMdzBHN2VrSGtMcDRoeElmVVZKeHMzTEF1?=
 =?utf-8?B?N0dqcE5qaGtodGlMYzh2ckhPSy9IRFQvOUY2VGRqcnhXSHFOd3d3dCt3bmRO?=
 =?utf-8?B?N3lvVGZsQlFCSzZPVHV0VmNhcEE3Uks0MElmM2pLSXh1REV0c3hNOGF5UGZn?=
 =?utf-8?B?amxlWHBQRE5JakJmL05RQUhXdmlTcG9PZVNmOFFTM21BLzZNTmpVOFEyeVBv?=
 =?utf-8?B?YlE1NjBYazVSUldYQUVKekRYTVpVNWQzTHZTdmJwODFmNGwzS0FwUXZtdWx0?=
 =?utf-8?B?aE40UU1BUnlvV2N4eHdZczB1OENoRnRsMTBQb3BITWp1N2VNZ3Z5blNoRHdG?=
 =?utf-8?B?cGNJNnRHVEhEZTZDOVBXRUdlQ2JXWnhMcVhGL3lZRG81SHVWaU11RkZUVnBo?=
 =?utf-8?B?c3RqTzJwZ3A3eG1MZmNBS3Q1T09TRWo5ekNtNXRORXJNMmc4MHdzNjlTbXJH?=
 =?utf-8?B?ZWIvWGN3MzFMUkM0QVY3cGZhSnpHdWZWVGVOS2hRaHJWTC9mRDNHUzFtMmFU?=
 =?utf-8?B?cE9DSXdoM2ZaRCttU1lzSE5vWVdFOXFYU0cyYnpFWkY3MXB6c1RyeXNlVk1m?=
 =?utf-8?B?KzVZOWl2dTJoNFZSY0tpRkorL0k0QVdKR1cvUXNFTnMxajlZK0F5M2dHcXRG?=
 =?utf-8?B?VEg3cGU4V1cwamFzemZDQ211akZoRThiTnFnbGVOcnVScHlnTHczR2hiN3pD?=
 =?utf-8?B?NDRQRUtpbkwrKzFTK1pYVlFkOVJoNGJDMkJXYUpvWTRPUVk3NUlBdkM3eGho?=
 =?utf-8?B?T1QvcXpjb29zOCtmU2hadHBQN2Z3VlM0MG0vcWg2MldrMjVRdjdEZHJCQWFx?=
 =?utf-8?B?clU1RFc5azJLN2t2M25WdVhubHpycDNrbXpEb1V0SHFZeWRQVFVjdDB5NmdG?=
 =?utf-8?Q?niDQVvpbDg0+WK5JP3VjOO6W+sUad1dyc+QG2UXoCqow=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d42d881-2aca-4fba-69cb-08de287329dd
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:27:02.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3785

Hi,

btrfs send produces a corrupted output file, if the system is =20
suspended/resumed or the terminal is resized. strace shows that the =20
ioctl() gets restarted:

ioctl(5, BTRFS_IOC_SEND, {send_fd=3D7, clone_sources_count=3D0,
  clone_sources=3DNULL, parent_root=3D0, flags=3DBTRFS_SEND_FLAG_VERSION})
    =3D ? ERESTARTSYS (To be restarted if SA_RESTART is set) =20
ioctl(5, BTRFS_IOC_SEND, {send_fd=3D7, clone_sources_count=3D0,
  clone_sources=3DNULL, parent_root=3D0, flags=3DBTRFS_SEND_FLAG_VERSION})
    =3D 0

The generated output file is longer than the correct one. It probably =20
contains partial data from the first ioctl(), followed by complete =20
data from the second ioctl(), causing a crc error during btrfs =20
receive.

What is the recommended way to handle suspend/resume and SIGWINCH?

/tk

