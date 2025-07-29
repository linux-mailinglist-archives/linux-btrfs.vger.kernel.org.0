Return-Path: <linux-btrfs+bounces-15723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340DB147E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789B51639AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0ED24503F;
	Tue, 29 Jul 2025 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d2ZH+xVG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kc0yxhCc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F018F6E
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768100; cv=fail; b=WD8/xEJ5p6niV5gZ7e/YjO3aT588e5rFj83ct0dunDGYvbU3fCNtSp1cOZldqwDd5LyqcSsRMhhrqBsMMrqahO/qFS/G0oZdo1abiGtEa2BsOyOFLv29snUWL9EqQcCKWsrK7I2zXJVBz3th/JZwaaDiSLdS7AiqVO1sQ01Q+ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768100; c=relaxed/simple;
	bh=lfP1uxQ3rI5kOsLc23pf2WRfIRJxU+s1ALw01YJY8ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cNUT2FNVNNVeOTRkNHB/58rlAsENu4XdTzf+jtXOuvCJxFk/aLGuC1LRd7kkjalDqpSJyMoLFMvQiPfEqRv2odkJhu0jXmTVoXeFFaCc1psr624jkLKfoUxxPKhIlHtUxfpI0ZOTORQB6pMzqpddnZFDAINeXTXG0Ktg+GILYlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d2ZH+xVG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Kc0yxhCc; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753768098; x=1785304098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lfP1uxQ3rI5kOsLc23pf2WRfIRJxU+s1ALw01YJY8ro=;
  b=d2ZH+xVGBsURaE7Vx6evddTCZ5y40F4YIiI4sbhlEAVPVvN0XOAju2sX
   Sy5QDgv/GmSXE40Iwh6fLSzMqiUjobp78BY6qpKHs67vQWnmwBQpBOWgs
   czHPG5z12UC8rmgvaDxIBLvJ5Bh4c/dhoF4FR3RyfXAkS5QKttXG1rcgQ
   01S05LhWiQ+Pw3ztq/HhmKym/CfHC2ks3Q3UHzuXpeToEJN3cnSiSdU5K
   jQbk16KHnwcC3m3b6aKqBOh3SCyUHnqRnbby2aoCl5AtsYkaY2a4OnXhZ
   P3Zqu5zrD7NVIQWhqYxdIGFDOgsV8r9o5Fvd8/bbZkYdJtSact38OPrMa
   A==;
X-CSE-ConnectionGUID: PP8ykU6bQgacYTpam4BKrQ==
X-CSE-MsgGUID: a0GwcWlwQ3WO4rlynVOV1Q==
X-IronPort-AV: E=Sophos;i="6.16,348,1744041600"; 
   d="scan'208";a="100999871"
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.75])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2025 13:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p08qlASyaGc9L0K9N2mfg71sbUXvMk3YQPjs6UEF9+CwfdeXsitylyjMTl1DaNFEqbvcDIZCPRa2tlnEBrpjAKfN+F5WsU7/wPWLy4bMjEzIWecUvTjGqVlORA4nqU1YMmfDb8cMBGoh1LRgcWMNl+Dz2cTOme91PPjw/YqUn/V/QIImXj7y7supsVPJD7ap8SzC7t89gyHsxnroFoTluOy9/FrnxFKqPAkD+/1kWLfpL+QC+k/BR0yd7qC0c44Yh87bscN6eKdwF+jZFZo4D9PxCquyvvgAjosfsMT2spvq67KEmvQ3C8tNexeyJkYDCF9HdADtuG383I6MQGPNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfP1uxQ3rI5kOsLc23pf2WRfIRJxU+s1ALw01YJY8ro=;
 b=awooYGKE8BjVPryaJRXbst08I++8MEh6Ofb+2kXFSIqAPXUtabfSIEt3Nz/rq7XLyJ29QpxeD1bXMaLk+TFWaZqe79CI0OgPWBfwG8YOfMKTYOtEGSnz7rBlfJ6XKdOqmZ6hz3Fsuk3WNQebwgBikXkiougcp3Swe/gxttTtqkPuP2IVHZWmeYYa2Y7FmrPmRjhW9zmF2oeS3UCU/p95K4ZRg0jEfyZsSq8iF0/L7E/6ipA8yPFC04f2KzN1uzhLXJGhqDJ5wuxCaiYvermrjtw6Zujh0AzzHbjKd13A0TrUXRn2ZM8gwmSQCspxCSGAxJ0Q+vfOUnebU1fRTtWZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfP1uxQ3rI5kOsLc23pf2WRfIRJxU+s1ALw01YJY8ro=;
 b=Kc0yxhCc8RMkzsFl1soIN4nvvsKvzkylno8lshfi8ywNXGB2SWzqLZJO0tElpRluORPFWvp6ivBi0/IacDyQO+0ViT3SxqJw9THdSKFOuUMxch+iGZ3a50EQJkOrE+VLIFe/WCkaPjID+j3gaMa1178s0yL1cR8JYdiH0rTshxc=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7429.namprd04.prod.outlook.com (2603:10b6:510:8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 05:48:08 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 05:48:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: simplify error handling logic for btrfs_link()
Thread-Topic: [PATCH 3/3] btrfs: simplify error handling logic for
 btrfs_link()
Thread-Index: AQHb/6Oe9lofMPkFrEqkjmQC2uX24rRHnFsAgAAh+wCAANsbAA==
Date: Tue, 29 Jul 2025 05:48:08 +0000
Message-ID: <3bd7644f-5df1-42ae-8163-63e8a399dc96@wdc.com>
References: <cover.1753469762.git.fdmanana@suse.com>
 <fcedbeb4d8f0c9afbd99d0c768ad181842b41dad.1753469763.git.fdmanana@suse.com>
 <847191e9-e4f3-4359-bdf6-22b1bd95a0ec@wdc.com>
 <CAL3q7H7FcnsL7XSJzKhhyw5QbcK0iTv5f7bB22q_rTq8g54v=Q@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7FcnsL7XSJzKhhyw5QbcK0iTv5f7bB22q_rTq8g54v=Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7429:EE_
x-ms-office365-filtering-correlation-id: dcc9b5e2-73f8-4604-c581-08ddce637f10
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEgvemR1TkpBVEF4azZiQWhiRnBXTEI0Tk4zYWdHdnFKd2NrVnlLeE8ydW5o?=
 =?utf-8?B?NGt5Z3pmekVqRlErTmEzakRNeGpTQVVhTTU4aVYveVc0dWIyMUorRWpuY1Ns?=
 =?utf-8?B?SWs0TW1MZjhpbVpBMDZlbmJ5VHM0WDVUVk1DYVJsMnl4ZkRCWkVPdm8ybk1r?=
 =?utf-8?B?bzlQU2w4b1o3eEw3cTVDWTdibDFOaEpqc0pZdkJPdFZlY0haYkJmN0k4ZytV?=
 =?utf-8?B?b3UrY3BGLzFDR1lyVUJPSWFXamlpUnN6VmZaV0RKeWY3QUxtaUs5aGI1Vysy?=
 =?utf-8?B?dzBqZXhEREpGWGh0Ylh5LythNk5ZdzFEL0xFZlFXNGR1MlBXT0xadmR0N09t?=
 =?utf-8?B?UkNsMWdxckNvVFNhdE9RK3ZmSDVCNytleGtFVW0yUGNlaGI5cXlPUnJ4WXB4?=
 =?utf-8?B?Z0I1SjV6RlZCL1dQTmZQMVRMcE9pcG5FK2FQVlRBS2ZaM3JLWXhmWDl2U0xl?=
 =?utf-8?B?c3ltZGxxRnBxNWpoV2JtN1RQVmJ3Z0hsRjQweXRSV0lCdVdTd0J4SzVrNHdC?=
 =?utf-8?B?a09YTG5ablliR25Oa0NQYk5pRGpCRXJycDYraGdUZm9UOWVLWFBackNGbHVL?=
 =?utf-8?B?Vnlwc1hxQWdqSVoyMGNWWVFkeElWTGlMbUgwdnNtV0xqSG9tWWhsWWxZanNz?=
 =?utf-8?B?VVNqbnVXZFRESFRWdjZwM2xhQ1hPL3lmek9KRnp6RDRxYmc3eFNpVUtCcm9H?=
 =?utf-8?B?Z25sZS9iZFFQd2dtbHRzTFZjRWRJT296WXJJWXN5dFZwakQ2RzFMcS9TbHRq?=
 =?utf-8?B?VWdNZ09BM3NLb3R3anc4QnA4NGxKTUIxQzZ4UzNaQzFSSHBnZ1B6TXRDOTQy?=
 =?utf-8?B?ZG1oSFExYm91ZUZTZ3J5N3FTSGREbjhhQnFlSnpjT290VGs1anZtNzZ2dnlO?=
 =?utf-8?B?TGE5S1U2K3lOWktvd0t0bnlrckVjcFR2MjZXdEh3TCsvcllvejdTc3NMSzR0?=
 =?utf-8?B?MEJ6VVl5L3RHVzFpdFBYWHlRcFR5SERpV2gxeStXd1JPTElkYVFZMGNJcmlN?=
 =?utf-8?B?SFpBdjJsRHVDdnVlYURtR2V2elhxQk9HT1hXdFBrRmh1TzlUQzU2dWJsVDRK?=
 =?utf-8?B?NzhxcFVvTjl4R0o5Ui90NkFnKzE5TXRFbVIzREMvU1RncVQ3OFBrQlpmYkJN?=
 =?utf-8?B?WTIvWGp2ZnNGaXZGQjVrYWYvUXFIaWFaNVBhbWxxS0w5b1FMTmpDQ3R0aGcr?=
 =?utf-8?B?RElncTNhakxiS1hjTldSQzk3MWN3NXU0Wm1jVVRrZk14ZkZ1WTZyMzVYQWFq?=
 =?utf-8?B?SUk0V05aS3l5RWZoaEtRdTBQT3loMnZlSFZUWFVlN2dkSEI3eWZZUWdkQWRS?=
 =?utf-8?B?TGhpaDQyNWpyRXZNNFFpUUZUVVhoNmNScEFXakFLTFJsQmVLcFh0QjNsbDdw?=
 =?utf-8?B?bnpxRUMwaThha1BlakdibWZOVG8wR3B4RW9qRXBUaTAzRWMvZzQ1a1ZYaE05?=
 =?utf-8?B?bnlkYXg5Y2tvcTN4NzRqV2xqLzhqcFZGYkZ1YXovKzVGVWJJckpSQmRoaE9Q?=
 =?utf-8?B?b1o0bkViN2hxd1FTNU5GNFpYSlladkxaTWU4bjhGMmR3ME5JTVhsaytrNm0x?=
 =?utf-8?B?d2FabHI4OVUxTy9zMXFyZDAwaGZYQTYwdnZ0a293Y3Z3bGYrQzJFdFI5dnhJ?=
 =?utf-8?B?a3Jha1hVckRhRjN4bTFKY2UrTXVldkgzRE4wNHZLek84Rk15eDlNczJXd0Vh?=
 =?utf-8?B?WHpXekd0c3ZoNHhWbHNMaDRVT3BXa0pJNGF1Tjh6cEQrNTJvZS9rZXBpL2dH?=
 =?utf-8?B?QVRXSStrYklpWDJWR2hGWkt0b1RlVGRIZlpVTE9IV1dQanJldlJybnFETE1T?=
 =?utf-8?B?aE8wWHBZNHNoRUhEQWp4TSszcU1kYWU5alNWMTJyNWR3Q01Xd2djMDFMYUx1?=
 =?utf-8?B?SUY2dVdRdEpkaHFtK3NCMkJPZGw0NVQrNnlDcmxOQWp6YnNPZDB3Y2YranJN?=
 =?utf-8?B?ZVF0VzBuNW9Fd2RCOEZVT1NtU3Vzc2J1U1dTRlhrd20waHZaKzBtandSNlRO?=
 =?utf-8?B?MEt6SW9sd3lnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGt1L0Vhb28yMkd0VFBscmsrMkNCTEVBdjVyUXhGZkdFSWtxM2RPZFFKeTFl?=
 =?utf-8?B?T2tvT0RQK3Y0N0pIOUVNSmgyTzkreDFKMVZSWnhWSFRWMWk4bm4weHQwdHdP?=
 =?utf-8?B?WHVPaHhsRVd6QmlDOWk2Ky9Jdk1qbDhJOVhKdnlYWitrdjgvczdZMkUwUndy?=
 =?utf-8?B?clBkVDNPSXZhYjFpSHBnUXFRU1I5WERncWZNR0tmcE9mdlhXeTQ4VnZ0aWlQ?=
 =?utf-8?B?S1E0L2dsSlRaSVZqK1NTdjhjN28zQ3ZRK0VXb2R3M1E5L282UnIrRENoN3Na?=
 =?utf-8?B?VkhrdG92RktMVkNjUnZMSnBsb0tEL05qN2FTVUNmVFF3MHRjVDhUUHorRzln?=
 =?utf-8?B?REVpM0ZIYWlWd2NLR2Zsbk5KalRjeHpHbE9iZzZpdUtIaG9PeEExcElBbHo0?=
 =?utf-8?B?SVpKcWNTQmFLQVlrdkVTQTl2Y0hQcjVwb2JYNUtwY3lKdDI3Q0pYNlB4V3BK?=
 =?utf-8?B?TEE0c2ZBcWE5aE12cDFLSXFkbTJIcHl6QitFaFJDZXQvbWptc2YyMWhiWTJP?=
 =?utf-8?B?VXNpdnROQjZsZXorS1g4bHpCRXcvQ04vcDJhK1hwaGtQcU5uRU9sZ1RNdzYx?=
 =?utf-8?B?emhVdkRKSkgyNVJrSkptblA1azExWVg2ZFBrbWV4bldZRWNnd1JNL0ZTN0hy?=
 =?utf-8?B?ZmNwcGFDbnU4UlVKeTNEbjltYmgyRXZCczRhMUNrbkowbm5MVklWN0hpejF6?=
 =?utf-8?B?K0hQWFJnaUkrOGkwMjZKWlJOeHZjTktyaVU2ZUVFbEVDSkpDT0VnYklrMFNo?=
 =?utf-8?B?Q29Ca3RkaFBYWnNQVEtDNC82MWFOY2ZlZkFReTcybUwreHRaR1NMNTlOWkJW?=
 =?utf-8?B?TGlZM0V2V3BlcTgvRjFNVHhTQnp0QURYVzRlaGNGVTRHamRoeENOOVJ0Q2sw?=
 =?utf-8?B?blZmZjRpWWZJYWI1d2lQZDRUd1FteCtCTU1jaG8vRVJwR01iMlpuTVJWaFQy?=
 =?utf-8?B?VlZKL2IrV2lqQU1BM1hpdmhRU0k0Q2ZCZHZxZVRIc2k4MHlWRmJHTXhNZWdi?=
 =?utf-8?B?TXBpM2U3K3pLR1JKd1hPWjdycS9WaUhObFRDbXFlYVhqVjRQaW51bktpaTRx?=
 =?utf-8?B?QW1EVVQzY3B4aC95c0dEU2NZN2dreTJVN2VwYUliYTFEWTlZL044VjdjeElS?=
 =?utf-8?B?cjlweGErUlpLNDZYSEU0b0tSY3kvaU9nd0p5azJQb2wvaHh5VU1FVXFuTy83?=
 =?utf-8?B?ZUpiWTNETkRTMlUxNnBXWis5amhCenl0ZEtidFFDUHh3MUY2YllFbVc3clR2?=
 =?utf-8?B?dHNienNCMkRTcHE1UE4ydzBDcEJ4cmQvODVpQ2lGUnFyZWMyZjZYMkFCWUd4?=
 =?utf-8?B?c3haWkdQMGQxWmFnNmFFNUJCRC94QjNOUS9CWXFtZlJHUElJZnJhMGg1dGh2?=
 =?utf-8?B?RkpKbFhzcVBKOElQUU5QNTcyNGhqWVUyb01tdEJuVmc3V2dwdng0UzhXUWZD?=
 =?utf-8?B?STl6eUhWSmZzOTlJQTI4b3pzd1Z1TURuTTBSR2tyNmJuRFJqaVN6LzRqOHF5?=
 =?utf-8?B?V2ZsWm9GQnNjNnFDVldVNVZPK2lidEF6dEhZU0NhdHlLN1pJenhIa1lPWGhz?=
 =?utf-8?B?a2hxUzhNUHpkZ1hGc21nb0M2ZG1HK2tTRXRzLzZMVy9uc2dHVkZIZ2dsaVUr?=
 =?utf-8?B?U0lUWWgxVlczWFNFUWZ4dHhacWhqWllVNU5qdGNob2dRL0pWODRleTZ6QS8z?=
 =?utf-8?B?NmwzZXZUcDRlamg4b0F2SHEvNElCVkVOYU5heWw3R3B1bHYvQUlOMUw2aFBl?=
 =?utf-8?B?ZTl5MkhaQXRDV0tBV1d2d1k1VXJNd2swL0I5VDlDRjh1Qi9PL3J6UThKY1c2?=
 =?utf-8?B?NzhHd1BCb09TNithbzYrZHc1eU5BL1JzaUZaMTFIK1NKRGl5SFFwREZaV2Ra?=
 =?utf-8?B?M3hXdFk4L3NRV1lUcXJXSDRlNzFBeUtzbG05Zk5QZjN4ZFF5M05rV2k0RWpX?=
 =?utf-8?B?UTFZeExLTkdPUGI5aFc1VWQ5c3B2ZTAyb3pXWmRuSWl0NDV0c05HV0hIbSs1?=
 =?utf-8?B?djZPVmFMeFdwQ0RNUEFPQkh1T2RsWGF6OTJFMUhwNXFuTVJFaWFrc2k4YTFF?=
 =?utf-8?B?WWdZcEhmUFRvREUrcHdic2J3eXNIYUdOd1NiclVlSi9OcERZZ1F6V3hvMUJ5?=
 =?utf-8?B?QlMwYWxHaXMzWmpKVFZYUTlCRUhEVDE4WTBJOG1BZ3A2OW5taHlUNzNYeFJX?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B27BDC23D3AF34D9F933AF8D6235950@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jxRkSjAbISkeCjgtyg0VaVzuaVuXJrEoGRKbjHZGR9dwNoVlL76Pg4HMry4G7xQc3PAq/dur1wHhEsvPtdj0A3NvxWn+qP19UF7uWmzprceCvWgRbZShh7vqtzjSMl4HyuVMtQ9d1uBfk6aObvE+qbUe+P6eTQrl19HzpLkD9vnvQ/qm/7uHfeoOVBD2fI4mgAUJt26125QwAygmbXfbA/KViXGP7jWLlgIRf0GUoB72hi3nifgYxS0vxPp+rM+JpJYcuqTg1D1W9wKWgNm18X041+orNMfXMAnd6Q4ONdHSJQambO1XIYM15algiohQX9YQ32FZGLb8wwA+pGtYR37QXWpuOrcC0Hgm2mjuH9drEEHEa6uN05x7+JndXhWaXuKVXPLgrF76Sawq5U8LBEEwZConTwMoUjU/l8gSZuwd/RHO5xJjBz8jyNYoVNQ/ZwZ4f1WRjm62mskkDBo/7FbjeQp8HCOaLBuG2XzxiagA7QbTs4qSa3BiM4hcNGiQCy+nHXIIVaiB6FYpvckx5YBSj4XlIROH7Z05WC+3GPhDyMhsepEZCu4HaXFz3dlZsb1oSKeYi0FzK9foCymBYmWoC3XPNJp9XLSm0iRf1+1DliPGdMzc84t0IM8ogWhB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc9b5e2-73f8-4604-c581-08ddce637f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 05:48:08.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xm8Nb468Kam7kEiSB84mfOcj+GNKd4CbgzlM+J9EUhvLERkQeXU7k+v/zSflCcjAfrK4LBsPBZuNzRtI4ea2paM2FyB493W+07IhLyArsQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7429

T24gNy8yOC8yNSA2OjQ0IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBNb24sIEp1bCAy
OCwgMjAyNSBhdCAzOjQy4oCvUE0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+IDxKb2hhbm5lcy5UaHVt
c2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+PiBPbiA3LzI4LzI1IDExOjQwIEFNLCBmZG1hbmFuYUBr
ZXJuZWwub3JnIHdyb3RlOg0KPj4+ICsgICAgIC8qIExpbmsgYWRkZWQgbm93IHdlIHVwZGF0ZSB0
aGUgaW5vZGUgaXRlbSB3aXRoIHRoZSBuZXcgbGluayBjb3VudC4gKi8NCj4+PiArICAgICBpbmNf
bmxpbmsoaW5vZGUpOw0KPj4+ICsgICAgIHJldCA9IGJ0cmZzX3VwZGF0ZV9pbm9kZSh0cmFucywg
QlRSRlNfSShpbm9kZSkpOw0KPj4+ICAgICAgICBpZiAocmV0KSB7DQo+Pj4gLSAgICAgICAgICAg
ICBkcm9wX2lub2RlID0gMTsNCj4+PiAtICAgICB9IGVsc2Ugew0KPj4+IC0gICAgICAgICAgICAg
c3RydWN0IGRlbnRyeSAqcGFyZW50ID0gZGVudHJ5LT5kX3BhcmVudDsNCj4+PiArICAgICAgICAg
ICAgIGJ0cmZzX2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCByZXQpOw0KPj4+ICsgICAgICAgICAg
ICAgZ290byBmYWlsOw0KPj4+ICsgICAgIH0NCj4+DQo+PiBEb24ndCB3ZSBuZWVkIHRvIGNhbGwg
Imlub2RlX2RlY19saW5rX2NvdW50KGlub2RlKTsiIGhlcmU/IEl0IHVzZWQgdG8gYmUNCj4+IGlu
IHRoZSBvbGQgImRyb3BfaW5vZGUiIGNhc2UgYnV0IGl0J3MgZ29uZSBub3cuIEFuZCBpbiB0aGUg
Y29tbWl0DQo+PiBtZXNzYWdlIHlvdSBzdGF0ZToNCj4+DQo+PiBbLi4uXVRoaXMgbWFrZXMgdGhl
IGVycm9yIGhhbmRsaW5nIGxvZ2ljIHNpbXBsZXIgYnkgYXZvaWRpbmcgdGhlIG5lZWQgZm9yIHRo
ZSAnZHJvcF9pbm9kZScNCj4+IHZhcmlhYmxlIHRvIHNpZ25hbCBpZiB3ZSBuZWVkIHRvIHVuZG8g
dGhlIGxpbmsgY291bnQgaW5jcmVtZW50IGFuZCB0aGUgaW5vZGUgcmVmY291bnQNCj4+IGluY3Jl
YXNlIHVuZGVyIHRoZSAnZmFpbCcgbGFiZWwuWy4uLl0NCj4+DQo+PiBTbyB0aGUgInVuZG8gaW5v
ZGUgcmVmY291bnQgaW5jcmVhc2UiIHBhcnQgaXMgZ29uZSBub3cuDQo+IFllcyBpdCBpcyBnb25l
LCBiZWNhdXNlIGlmIHdlIGZhaWwgdG8gdXBkYXRlIHRoZSBpbm9kZSwgaXQgbWVhbnMgd2UNCj4g
aGF2ZSBhZGRlZCB0aGUgbmV3IGxpbmsgc28gaXQncyBtb3JlIGNvcnJlY3QgdG8gbGVhdmUgdGhl
IGluY3JlbWVudGVkDQo+IGxpbmsgY291bnQsIHNpbmNlIHRoZSBpbm9kZSBoYXMgYSBuZXcgbGlu
ay4NCj4NCj4gSW4gdGhlIGVuZCBpdCBkb2Vzbid0IG1hdHRlciBtdWNoIGJlY2F1c2Ugd2UgYWJv
cnQgdGhlIHRyYW5zYWN0aW9uLCBzbw0KPiB0aGUgbmV3IGxpbmsgaXMgbmV2ZXIgcGVyc2lzdGVk
IChhbmQgbmVpdGhlciB0aGUgaW5jcmVtZW50ZWQgbGluaw0KPiBjb3VudCkuDQo+DQo+IFRoYW5r
cy4NCj4NCkFoIE9LIHRoYXQgZXhwbGFpbnMgaXQgdGhlbiB0aGFua3MuDQoNClJldmlld2VkLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=

