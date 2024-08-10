Return-Path: <linux-btrfs+bounces-7086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638294DDA4
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE081F21966
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250015FCED;
	Sat, 10 Aug 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b="Vm0tVjaJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021110.outbound.protection.outlook.com [40.107.160.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC36C8D1
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723308359; cv=fail; b=lI18Tsdk6FDfqSiQAf+yz/ivHQcVu9RCQRwkQjIULOMAhqvfiUGnbtyQmMpoeoqawHpRgmH/cFwZ4j4R1V/QBygcjLNl9myQSKY4PGCrm2Sdca9sVPQWgCoyF9tKQOiX2MKBXRizJRK53rRSih3FjN4chyLrJ2WYJHMloufW8BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723308359; c=relaxed/simple;
	bh=R4+wlGuqxqfQGw1j01ZxG83JVihdJ8PmDuYus8FXG5E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DiXsP5lb1n4ORrSrvsAGl4HyJbuWmmfa6Tq+dQYzFue/RC2zGvAX55FNQxqKg1rAirMbpQHYfmcDW1PQpx2IlQWZuai5DDh3SOj3HDxZHHCcaqzl1KyDVPFpsCyE5FtJUZm8KrYwV5r8UMxfJMU8CBBXa5UN3BRWF3gKo8VD3k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr; spf=pass smtp.mailfrom=ensta-paris.fr; dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b=Vm0tVjaJ; arc=fail smtp.client-ip=40.107.160.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ensta-paris.fr
Received: from MR1P264MB1812.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::13) by
 MRZP264MB2809.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.19; Sat, 10 Aug 2024 13:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOzb4VLrMaHlkgZgBEv6Yrz5CvqZfGziJjurcdN0ebHvQKZ+LMdn/h+6+s/4Nh1e2B/SpqB8RT1i8siIwW1wFIaIhUKeAyEtW48AVKeouNJ+zl9fSry/fIQsbXaVF0ABK6E2K5Okb9lk++CYOlnbyQk57JMB8ruHiylFLpv89tDyWGEgXsKOKFyZeIL4RO0O1tuxu1uoF5+2UBUFMZMzzZlpSJ/kV1KIxJXCawGCzcHgtIhkxESwj5ZtBChK8zl2mhLWUG4VMfhJSPOuCsPNTdASS3DlG34bwf+4ayY7CNjPmOqL37TmemVAobeTE/91CL3gkhonJuv1VHLzGyIr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKyFy8wD2fjh4eIPzBqYeMSQzOGxpQ4N4Lf1G6QBQMQ=;
 b=wfaGgoGJqN9W/omdsnuaB2eP0XG7jaOGjxOcO0ps3k2TBI5oba8hCgifdXi2L3CnImo8zhjVUgVzMsNrd6r278mP84VqyyVKOhOQVR9ovTu5ITL5QIc5tMAFvbmRZCTDIyv9iPrBs41UPT9yl5FqLhcYmm0C59tjpL47sRSTDYF+hJHcGPNUmV9WANXhOE2SLRuu2YEkPDLeArcF5OorCxrAR0LxeLVeUgyT3cEa2vZ8w3D8mSzVERPN1ABoAvuPoyuvi17X2nc+nkXiopTyjTwNK0NoQzgaDgkFH98WGCjtWSTLy7qWLFTfl22n4I7jYrpbIEs35qKyPSRgZm6n9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ensta-paris.fr; dmarc=pass action=none
 header.from=ensta-paris.fr; dkim=pass header.d=ensta-paris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enstafr.onmicrosoft.com; s=selector1-enstafr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKyFy8wD2fjh4eIPzBqYeMSQzOGxpQ4N4Lf1G6QBQMQ=;
 b=Vm0tVjaJ4NjBGLQHLCCHOw+M7LbZQWW+tyErnJVkNPuOr4LkcoqZps/e/oFIuyllaEFvUHhyQoOPnserVYXiBgi1f4TKCasw7kINr6gQLDz3ek7FyzQfygUh2qODcT/4WQ7alBDiXPpHMirspquA171gyU+iQKV1sIzYVpej+S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ensta-paris.fr;
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::10)
 by MR1P264MB1812.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.18; Sat, 10 Aug
 2024 10:34:19 +0000
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8]) by PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8%5]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 10:34:18 +0000
Message-ID: <133cc484-f609-4274-a745-6567d7635855@ensta-paris.fr>
Date: Sat, 10 Aug 2024 12:34:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
Content-Language: en-US
From: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>
In-Reply-To: <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0102.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::18) To PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b1::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	PR1P264MB2232:EE_|MR1P264MB1812:EE_|MRZP264MB2809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3903213e-e9dd-41b5-0d53-08dcb927fd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|41320700013|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bFRQaWR3b3dsbUJiUy9Wc2RxdXl1VkFsM0QvMHVtZEozUGRxTDlvc1pDYkRY?=
 =?utf-8?B?S0lteWE2WENzbEV2dnFNUzlQUFBsV0hEOUNQV202SEoyb3Y0QXgyOXh0dUsz?=
 =?utf-8?B?bUFYaytoVlUyYWpzeXY0OTFTRWxZZ2pYT2J4ai9Qd0lScWFwZlRXS1k2TEVt?=
 =?utf-8?B?NUJVUDlhc1NCTkRUNkxRdHRNNlNIN2gvWXY1cjRXZk1ydXpWU3FZN0J2cC9K?=
 =?utf-8?B?MlZ1b3lldlk3MlZFQUJSeStXVmYwczkwN2FSNVc2TTBMbnhYZHBERy84NW8x?=
 =?utf-8?B?d0J3bnh2MEdXTVhLU2VuejI4UlZlZC9mNCtRcE9jQU96bHR0VEFEdTZaek1E?=
 =?utf-8?B?cTkrTDNjMldPUklJcmtOa3NwMFk1RzBELzZuKzBqNHNiZ3hWQkorOEwyU2hk?=
 =?utf-8?B?Q1FxUVRiekVkK3NuRkZ0YTZBNE5WUUZrTWU4aC9UeFBDcXlHbUxIREpiKzBO?=
 =?utf-8?B?elVuUnVhVS9RUlNLL3Q0TEc5RkY1aXphbFdSTWZvb3M3QjhrbC84bWxFNVRk?=
 =?utf-8?B?Q29XY1gvQVpNZzdKWmROZXU1Y3RvYVE4REVqZEVIcGRQbzF6eS9Zc3RuNkpu?=
 =?utf-8?B?VlFQZFVIR3BaM0QwcWhsWVgxc2NKOFlpU1JCMmxTaGJ4TitXSVlYeHhMY0ov?=
 =?utf-8?B?VytlamNiMVFyandQYjBJUHpSTW45MWt5YkpLODlqREt5Si9QdzdtbUgrenJN?=
 =?utf-8?B?WWNJaWJqZkh5WVpjcFRsRjI4eUxoZUxZbTViQ0d2VG5HMFFYdmJpb3habFZw?=
 =?utf-8?B?SFlkMis3MmxXdUxCSGRqQVhVdmtncW1OK01SWVZNWUNnOTg1OXRDeFVZdjdJ?=
 =?utf-8?B?cCtpTmtwanFNeUMvMndrUDFRd2VJWUx4VUxhWnBwSWFpM2Y5WFIzdXA5WjFY?=
 =?utf-8?B?bXRxRFQ4Y1FIUklXbGRldFoxSitCa0NtOENnd2F5NnFoTmxDNXM5c2ZKMnVq?=
 =?utf-8?B?RytkRmlLazNVenRTV2s4eUtkZ1JJcEtMWVdGeGtQRVRMaVlJMDBpU01mTFVL?=
 =?utf-8?B?Y0JONElDZktEMzVsYmJNVHRVNlpBR2g1eTc0RWRBLzVEd0dpSXVsaS9rTVBu?=
 =?utf-8?B?bnd2VlY1T3N4UXdJUG9WY2xQU0QyblZmV3A4QnJGejkra3pVaGxZNUU0NHAy?=
 =?utf-8?B?VjVhREM3TFZTWGJicWkzMGpHMlRWeUxiS1F3SzFZUlFsQXRnQUxjNDc1UFFV?=
 =?utf-8?B?WmFmZUtvcU81Vm5oZkVUdzFtd3N4bTF1QmNvNkk5R2tPZHMvRlJSZVB3OW5H?=
 =?utf-8?B?NUtnUEI0RVBJNTlvVXVJUTc0MEdnVEJsbkVDRTZjbDFIOVBMMktMcmF3Qm1K?=
 =?utf-8?B?SUgzUFd5NE85QWxiMnUxQ3ZFM1p3dUZUNnc3dmNTa0pRTEJlRzdwRjQ2ZzBR?=
 =?utf-8?B?Qnp6MnJSWEp6WGo2TTNFUXFpMmtsMWQ1UmQ1MkpZbS9pQXNmWFlscUZ4Qlo1?=
 =?utf-8?B?YTJ5TXI2K1ZWS3RFcmJpbElMWUgwdmtuSEhKa3JTTzF2ZGt3M3JNZzBmUlor?=
 =?utf-8?B?MFVCeE1rdEtWMVhpOU1NeHc1Q2NDdVV3OGpxemx0bnV0MzhMZitNSmpGSW42?=
 =?utf-8?B?aHJPVlJicGpKMm5RYXAzVVkxNWpOTmJFdUZPNFhkeWd2UGJMY2s5OVpia2Vz?=
 =?utf-8?B?a3NLS25uM2xySDcwK1JuMjlDcVdoRXdzTFhuNHJBQjExbWZEL1FvNTZFek9y?=
 =?utf-8?Q?PbpWWHw2Zc5XV1MyHsdx?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cS9kL3pMaUU5UC9mOXR4ZVQwNEV2bTZ3cWNiR3pXWHN3Nnkxc2tCS2xWOEda?=
 =?utf-8?B?S1FTaWlZbUc5ZXVYaG1vS1k0QTgxeEpyeEZZMUt3MEE0dUFkRlpiWlAwaUdB?=
 =?utf-8?B?WVhSNDdlVUlMWUFvdDR0QW9iNE1mNzdXVzNUU25ud005LzAyaC9kakYrQkh1?=
 =?utf-8?B?bm1LRW9BaHdiYTBIaHlsWHo5UHo4V0ZTYXBTTHBCeFZLKzFURWVXbjc4VjRM?=
 =?utf-8?B?YktZYUJHM09kUTB3MG4ySE00czk4aDRVTGg0TzcvN1FJeWhlS3c2WUFWSTZv?=
 =?utf-8?B?WTkrc3I4RFVtV2RlYlZwYnpySUVCV3RLQXFXT2ljS1oybzRlaWUzVkx1MHlF?=
 =?utf-8?B?UFowTG9laTlSbTErUjR2ZUUwMG9yTmkrK01TdzJqanR3eGFxdisxTG9RRHZK?=
 =?utf-8?B?TGxkZEdJV0xrQW1LVFpoQ1VyRXJPYm13R2xuK01CMEZWYXBLdWZ1YmZxcE1O?=
 =?utf-8?B?Mkl4QlN2dVNDV0tORzdkbndDQ1VOYXlaYkZ6N2hseFMwV0ZDTDNCMmpCUkRI?=
 =?utf-8?B?RUxiTXZTd3VhRW1KNTBkalZBWTFEa01oSEI5UUpnZmtFaWJ3dVUwTVNEU2Ey?=
 =?utf-8?B?b3VhWlFwT2lYbGpJNlZUbUw5TlpuWmc2QVBaZkhneVhOR1FIUGloSTVZOVNP?=
 =?utf-8?B?cTcxSXBuQlJ3N3E4cnM0bEM0cWMvTXFDRXcrbDZqbGtRK3A5M1RESkx5djBw?=
 =?utf-8?B?NHNVNUFDUCtJeFNrRWhyQUFacS9TenhhUnZjamYzQ0lra1JaZUdMdzkyQ2Ev?=
 =?utf-8?B?SitBMlZZaHlTS0R0aXhBMkJiaUlkRlVBRUNOZm5HcE92KzEwZ08rL2xWVHpO?=
 =?utf-8?B?NnB0UnRYTVM1WGQ5MFQxMEo4UldSYlRmUmVSSU43VjZJaTdpZ213U1oxUGNG?=
 =?utf-8?B?bm1JY0dUcnhMNm8xMkVWSmhDN09TS3RPSEhTK0pyZzJGQWVHRGZ5QS9KSzF2?=
 =?utf-8?B?VUNSMzE4R3FNTVM1VENmVXRPNXVDUXduUHI0NmpWaEVZT0FjZmNTczl5NkRR?=
 =?utf-8?B?cXR1QXFDSUN3bFNhMWw3UkU3OVlsV1pTSWl2VVovd0pnVFhmZm9mN0tjc0RC?=
 =?utf-8?B?WHErUmx1V1RvZkhvbzhQb01PL2Jja0hMMCtYWjY5OG52SldtT0paajZqNHlQ?=
 =?utf-8?B?K0pOc3k0VWkwYzdHMURPNzIzSHNiTGYvZ0tlMGpPOW1yVFlFc3Q5TGNJVUFw?=
 =?utf-8?B?Y3ZUMmpJQmwzWWdDOElhQlpobFcrekFRLzdvMkRWY3ZmemtmMm5FVmRqcHha?=
 =?utf-8?B?US9XcG5mNVgvWGYyVUtla2ljZ000SmFoWVZadllCVUtubmF1VFphTW9ZRjgv?=
 =?utf-8?B?dzJNZUczcTBWTWZCYnNXRkUwcDFJWUZEOGVkZW9mdkM2RE5CYzhVNDVMbm54?=
 =?utf-8?B?c2o0ZlVVNzRYeWZJckszM2E4UStiMndpb2JYbGYvenFjTFhYS3RhN3A1cWZP?=
 =?utf-8?B?b2Q3WEY5dGZRWVMxWHBMME5JU0YvZWduVE1SUzExWHA2MmhmTVV6YXd5VHRw?=
 =?utf-8?B?OTh2YWt3bkVOMW5OWGtRSEU5ZE5pWGljNFkrcjV3UFBvUnlWUCs3MmpzMW5q?=
 =?utf-8?B?amRIN1M1ZGk2dXhMMmo4U1M3Z1pGTXRLV3ZTSDBWUkN6bXhZTjBtYTdPQTNI?=
 =?utf-8?B?M0NGb3dTWWpCVkFEaUNGRytBcHQxUHFCKzROWmtjNjZVOVJMeS9PYTJtNUJE?=
 =?utf-8?B?MkVyVy9mbitJbXRpTHlVbEFlTnJhRllRZENlNUZBcGg0QlNhbkZNMXhQb0N1?=
 =?utf-8?B?SjgxcjlFRVNkRGhlMGlkSTVLWVVDa1VpZ2tOTFduQ01NNjJGMHEveHoyVWl5?=
 =?utf-8?B?WlJxWFlCdENXalR5Z1NCM29ZZzN1dmFoKzVZWmx3THU3VnVFeUpRZVRXbE9w?=
 =?utf-8?B?NVJYSDROTEVVUUxaTVpPdUVmTHoxV2ZibEZnamRaNEZLUjRUUkhvdjk2bmM1?=
 =?utf-8?B?czVoTjd2NytZa0xuWTZEQkcwZGZUNVd6L2RlZ1NaSmJnVHJ4N1BmWjBTSVg2?=
 =?utf-8?B?QXpVVjNvSHhjakZQYTNld0Y3UUFSb29lcVhBY0gxNVkrbTdiNk40ZmhxRGJW?=
 =?utf-8?B?QmJMQ2hlbDZuZzFaeHFBN29jT3B2OGRPYnBsZWkzUHRpYXhhNWUxWDVZeTY4?=
 =?utf-8?B?UnJzT2RMR2NOMjM3d2lCbzQ0dmswMlBoYmk0dEpuZTBJWGQxaGNjQVIvN2hv?=
 =?utf-8?B?a0xSaWJJOEU1ZzZQUjdqeFhHWWxMZkk5eWJERWNlek9HUktPNnlOamIyNXR3?=
 =?utf-8?Q?EpiGjsxQqMWCf0PZ36v2KCcPRrcKWJRhobtc+6RSd4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3903213e-e9dd-41b5-0d53-08dcb927fd76
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 10:34:18.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f6c3f3f-c20f-4ade-b8c1-3e0fba16ec71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvPXk58WMOccCSivtTZAC1+o7QtOnk67el86sstmioQXN3R4SymObrRZQfaJzrRQYZ5kNvf/wp6XVP+/sXsRErO/z66iJu2UiGwe26Ya4lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1812
X-OriginatorOrg: ensta-paris.fr

On 8/9/24 9:31 AM, Qu Wenruo wrote:
> But we do not have such tool, so normally one may go with
> btrfs-find-root, trying to salvage a good fs or your home subvolume root.
I attempted btrfs-find-root (without options) and it returned this: 
https://gist.github.com/Semptum/83ff8f1b590d214b34562d53dea5fddd
> Then go with btrfs-restore to salve data.

I attemted to use the dry run restore command with the tree root it 
found (275009601536) but the error was the same.

Thanks

Best regards,

Andre


