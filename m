Return-Path: <linux-btrfs+bounces-7056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6F94C732
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA520B238DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 23:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A615F32E;
	Thu,  8 Aug 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b="E7KQGoLL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021106.outbound.protection.outlook.com [40.107.160.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B99157466
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158478; cv=fail; b=qViFPU2G88Vc75pYSO7fcbNxqhQFXB2tdtt2M4BB5lka0JoV+MgfSxsJ3awop114l3J5roskKpZXTuZKY2aBMMtkyH5IgPnVC2DrIjPE8Fr6jQT39xQF4EQGZIkcpkH022U5lbIUgXFsLO0bNKQQI19NtP7+WxvQKFSHkzhylkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158478; c=relaxed/simple;
	bh=UJWtTwmuoC57byTveM8V2FoACRif+gIyvtTPapzX8PU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQ4shCa7ddPeXX2qVqpuJEWiN+zlXP7obto6ZOGL1XXB2gl3qjOk7hS4ApPt142JtI2FumuSSTJB1/rdwfMLGh1iTrny657mh28GpRSqxPz9xHb01QNjcCa8VXlE62hSl3tX6L6EPRCRIO165hFxFAN3NkH2KlDywQ3fy56BkLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr; spf=pass smtp.mailfrom=ensta-paris.fr; dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b=E7KQGoLL; arc=fail smtp.client-ip=40.107.160.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ensta-paris.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWij7/ye8aJ9PPK+G2QqaC15bYBYYDyAMTiMmu24KsmHMQgKb2oqvsGiuQpgQL2icUYctqa8gAmDEqKVKzjsh5Ongpaeuq9cPsKbSBu8lMOjZyLhqHH24GGINfGSNOD7vSEzQ7UWzEEMlSN6B49FiYxwdyR1VTCTW5Bp1PhiI87hIUu6A86K0XureINmdRVvpF7qkT60btZouz27AWKhv0pBS9uSjmEVaTNfe6jJZIwVhA23Qip91KfZJWQfv/78o3EbCCcj8QFmki4Brx2cfR5mR4g7CfyjbmguKlA8ecQU9tRs3nl5Im+MMMSDAmjgDcE0zLnDcN4MQ9atO8r+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwbM+awk+7dG+CawserZAHT8qYFnGe5zpuLPTJwG31o=;
 b=mfnUGa1b6wYUxuJNqoJwt0Z4zY17ThFgg4giZD+5jhMEzem0Qm3F85DKtclCpDHFrq4nZvvWOrx4+ISL8nTDYJEmegRE4Xw7uH0jG0x+AmNiO2nVHOMrHRoLCoH5Qc47iffWndEkX5VOaTS0FC6Ngtxt355TacSMPZ6ru1VnjR3F3uCGJvTdCbaJRRUvNC3ucd2hgus2fpDo8S3l+gJSRoTPY3JoyjJVIH06NUFu+pgfixLaNXntTGioXDAA+0Bn/8f1gIniUZae5rP44bpcvcLy6QRjLsZbU+8+hl313y2sqM1zQXK9OgdtagI/pxkfaTCEwP+s24Z++Pz2PV8qYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ensta-paris.fr; dmarc=pass action=none
 header.from=ensta-paris.fr; dkim=pass header.d=ensta-paris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enstafr.onmicrosoft.com; s=selector1-enstafr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwbM+awk+7dG+CawserZAHT8qYFnGe5zpuLPTJwG31o=;
 b=E7KQGoLLysakMmgWjpPAikXhLTjl7Ff6nYJiL9cwfAqeh8z7XKuz5huxinYdaq0G69zJkFvQIub2TTVM/rNNxRYPM06bl3psRFQtvGefBOnE6gO2t2Fd5D17KGElZbH42h2Sggxw6MblsUkqT8EnVGp/3M4CTdLt8V9xIeURjfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ensta-paris.fr;
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::10)
 by MRZP264MB2762.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 23:07:52 +0000
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8]) by PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 23:07:51 +0000
Message-ID: <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
Date: Fri, 9 Aug 2024 01:07:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
Content-Language: en-US
From: Andre KALOUGUINE <andre.kalouguine@ensta-paris.fr>
In-Reply-To: <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::6) To PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b1::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1P264MB2232:EE_|MRZP264MB2762:EE_
X-MS-Office365-Filtering-Correlation-Id: f9832066-94df-42ac-2f9d-08dcb7feeda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|41320700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1F5UTlKVCtOYW5rY1JFRWk0RWdlekorcUVhQ0svMDdRMXVicGdyZXB6cml5?=
 =?utf-8?B?UW5SWXlNbDM0VldFN0R0bTB3bjlERWVpSGJCT08zZTdGRkVvOXBEYmxWNnM4?=
 =?utf-8?B?amhodURwR3pOMUZKZnI1UjVsZGQ5QU5YbWZJT3VDM2U1WDRBMkw5bjhjNlQr?=
 =?utf-8?B?djF3THE1UDFjNm1UbjZMUDRjbm1NRC9YWSs4OVF6QlQ2NERNdmt4bXpUb1JH?=
 =?utf-8?B?S2RveHFvZEdtZi9MOVFtTlR2V1Y0dklIeUN6dFRNZ3VCQ1FILzVubGJJc1hK?=
 =?utf-8?B?cUNvTGh5bnp3QzNXTm0rNldGU2VGMS9rMzM2cnpnZmlnNXZzTzhueTFtcWhx?=
 =?utf-8?B?VnlTdUlBeldpYkdYK0R6czdCRjlORjg1ci9XcmtUTDRRT2VaRG4vak84WHBB?=
 =?utf-8?B?Qnp3RGROajRaZy95emFsNUg1WTVIanZXUDRBSFBacFpwbGlyVVpMaGRWMjF1?=
 =?utf-8?B?NVBOakFqRFFTT1ZpbzRiZndLR1JwbGl5UTlTSXE4VmFoeFhsREw0cXlJOXdL?=
 =?utf-8?B?Si9QKzgxRFNJUmNTc08xNXl6S2RUUGQybjcxOXZNVDBDN0ZIU1ltcjBXejBI?=
 =?utf-8?B?cHk4RzRPZ3RVUHUzT2dublluSnJDYzdtT2k2dnJCOGd5T0FjUjZaLzQ1TUVG?=
 =?utf-8?B?emhXODVleWpHS2Y5cUNVb2hnZ2thVnl3TmwwUjgwMXNndTZvZDJOU09sMkZk?=
 =?utf-8?B?Vy9rUXhVdm15TUlXdVdHVUFwQXlLZ0xyeW1qdGlEbnRCZ0RGSlRqc1lDWDVS?=
 =?utf-8?B?NXRTTGl1bVZtWkovb2lzR1lkNTZBOUhuWlh5OGFCMjJWUXJWRlVtR00vLzdH?=
 =?utf-8?B?YXR2SWYzWXVySzEvVGdpVittRUJUaE9wY2QvMExpRHNkVWkzL2pXYS9WaUl3?=
 =?utf-8?B?VHQrZ3pQVmdUVmlndFFhbmVjRGtQVk5yUGVLbG1EQTRaa2dzQkpDTVU2c096?=
 =?utf-8?B?dWtOYTNRSVlhY0JoRjN6NXZBc0doV3NPZXhRS3FDdE5FOFRCMC9xcDJ5R0tw?=
 =?utf-8?B?anV1TGc3eVJDbUE2a1IwaHZmTU52Nk12ZDBoa3RISk5xc2tPdTZUTHNDTGNF?=
 =?utf-8?B?THpzM09LMm9IWTE3NDd0STNwREhSc3ZSc1dCeGVaZlc4U3kwNGVtSUMyTCs5?=
 =?utf-8?B?VVRXVDAvL2pJMGpCczNRY0s5SjhUbWIxY2Q2TkVmV1kxcHVQYXhBTFRzb29E?=
 =?utf-8?B?VFdTN01YUXZIU1p2SlRUQmlNTVY1dXlFZFVEM3lwZGdGRXhBdkFtVmhzb2o5?=
 =?utf-8?B?dmpXS3V6WTd2SnJCaHNXQmp6TDFhdGFSWEgwSWRKeE5MQWFvUDJaRnRoMkM3?=
 =?utf-8?B?b1FNTmhQRUZ1YjlVaWNqdTU1UGkvNnlacVo0aXZnemk4RVdaeStKQ1RrelA4?=
 =?utf-8?B?bzZlMjN4Q0hSd0hVUHdleHdqUytXR3BQLzRwVm54UkdVTVpyWjZHUHArNmJF?=
 =?utf-8?B?QW9JVFZwRDM2S0JrVUF5V3pydjBnV25NTFJTaThPZktWM0hONjYzQklaQmxU?=
 =?utf-8?B?Ukh0SVRwV3hKaDcyMEpOa1lWUWFweTd6TnZHM2swR3I4MXo4WVJxRFJJc3BH?=
 =?utf-8?B?VE5TRkppQkg3bEh2YlB5SHFXalU4eHhBeVVJZlF5SERCYUFqKy85ckpKQ1Qw?=
 =?utf-8?B?bmljbWdGbmdxZTNHV0dOWFc0SGhGZGdxdy9EZXllL0FRRzNIZFYvOE1qVHhi?=
 =?utf-8?B?UlAxaDBXNEJRTjJ3OEUzckUxRzE1anI0QWhVd3psaU93Y2lieFhXL3NnWjlH?=
 =?utf-8?Q?+lnAt/Ldwy2ym5zEhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(41320700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVk2RFdrQjZjaWtiSXNtdWZxdzBjdGFTa24yOG9ydG1pMGhacHczamwxelNP?=
 =?utf-8?B?RFhHQkJGb3BhNFllWUtaUlhBU2JubFdZQ1V6WE5lVjNBeHIwOWNGVFY5cjk3?=
 =?utf-8?B?MnE0YjU3d1hjamZ3Qk1HbDUrbXp6dFBMY1o3K1ZRQUV4clZGWCtydUJpSGUv?=
 =?utf-8?B?YStTVjBEcEF6K0ppNWxrbE9KT1M0Uzlzc05CUFArVzFMb000UjdnSk9QMTA4?=
 =?utf-8?B?QlhWRUlnbjZteFJ6VngzeXBrbzBPK1kxNUhzckxRWWhnODJrdFYvL1ovcDh6?=
 =?utf-8?B?RUlqVHhVWXZ3UjdwMTcyUGpmVnVrNnE0OWFydjlJM1FGUVFma0ZRU0w4ekdE?=
 =?utf-8?B?dlNWR21HQ1d4OWtXNUJMaU94NlhoVVFLZ2NuOXdOWndvQmpoenVENkZWcHU1?=
 =?utf-8?B?NmxZbFZya1lTU2VwTEFYa0V4eWl0aWY2U2hnUHVIdUFXTkptTVBjNUZPZ1Ri?=
 =?utf-8?B?QnhWOEE5WTdRN21wY2ZxZ3MwaUZqMUhGcVhpYmxkb1RoZ2tYTjFaVE9GbXhM?=
 =?utf-8?B?U2tUQitQNzRjaTdCeGh6Sm9RV0dwSmtVa2JaYWs0UHVId3FOaGxFcWlBd1hI?=
 =?utf-8?B?bWExNVB0S0V1eFFYSHhJMnVkQkNlaUFSMWszM3NRRUhMb25CR0h3Wm0yeVAv?=
 =?utf-8?B?S2tkL3V2d3RjTHVSMEpmTlhrT292SUtKRG5jTkRBaHhPamI0c2VabUlyaWNj?=
 =?utf-8?B?emFMUW5sRUJKZVo5UkUwd3ozOWVDSjVxU0lYVW1aMDlITFZtNzR3UzN0VXpP?=
 =?utf-8?B?NXlPSzk3Ri9CaCtLRW1oVTM1Zkt1ZGFKTFh6bElGUkQzNStmRVI3bUV4QjA2?=
 =?utf-8?B?L3g3TExpQmN1aytDaXRWQURyMzlDWEZIWTBUUzFUaXZLRmluR1pUdThrR1cy?=
 =?utf-8?B?NmRpUHBtLzZWdVdpZ1I3bWdtMDVCWTdrVkJINGZlUFJSUDdoYjJTQnB5RWFH?=
 =?utf-8?B?VWgvR3VBWUVMS3A0NWdZNk5KM0hnaDJuTXZHMXptcGNja0xhNitZRUVPYjk0?=
 =?utf-8?B?aFhsSWh0UkpxbHg5WnlwclpaNzFEN3F0YkFkSVgrQzBxTnZCay85Rm9wRjFl?=
 =?utf-8?B?aCthbUdLZ21PTllsT1FleVR2YVVZSEVRc1V5a3I0R2FtcXZsVm5LR2FRQ1dZ?=
 =?utf-8?B?N1QxVDJaa0t3YWZ2QkRacHFHbkNmTkxJc0l6UmVNK1JscDRaTzByQ25pMWd6?=
 =?utf-8?B?dWdFcDdvL2l2dGRkb3RYL0FSZklOeXQ0NTZ0Q1JmMDBYRHdVbldjMVlhU3ds?=
 =?utf-8?B?Z3NUN3c5UGtiYlZuUjhUcGdiZ0V1SmFtY1p1TnJJbjFBVlRIblZGMHl6VjFU?=
 =?utf-8?B?TUt0TVhpYVp1dnRPTGJ4R2dYSWhRSnhZL0w3TlZ0MExhQkhxY09USk5uS0ZL?=
 =?utf-8?B?Ly95R1kzQkY1amZvOHBEWGtWZ25hQTVma1JvYy9qZzlseTl2ekVZYUZJeC9W?=
 =?utf-8?B?SDVRQWRDZGhpbzR2SDA4ampYUm9Ma1pxVVF1TlpocGU3S0lKMFVJSG1leVJh?=
 =?utf-8?B?eVpyamFmTUJ4Q202YlRKVW0xOS9aVEtpdXd2R3FkYTA0Ymc1aXNvQVhwK0cy?=
 =?utf-8?B?bmZXTDB1cEhNb2JOVDh1RFM1dktyWElyaWJpTDNsSDNabllwTUd3U2NNb012?=
 =?utf-8?B?NmF4dzRKVlpBTitFaFRkeUxRZk5DMFNESDVSbEZNL1IyZkVvTmdDMzhkcEcy?=
 =?utf-8?B?R3ZlTVpvMHA0SWNoWUNLb2wwU09QR2JPMzRtZk5ubWVpN0lmQnlUOHFKUnAz?=
 =?utf-8?B?U09rRVgvNDlUSVdMU0UyZ2lhendSdUtiNEhsMW5KbW81blBRNTYzd3VBeklo?=
 =?utf-8?B?eXlGZFB4WXRQaEtjaXpsZEZhUUd3Rm1IRERjd3Y0cUR4dFlRZWZLd0pnZGh2?=
 =?utf-8?B?dC9oNDdjUUV0YmFrZ2pIYUx5VStMdU1DVWZWN0czaTd0cUJsbDFPaUIvN3FM?=
 =?utf-8?B?U00rNDQrZWFFTTRZN0ZmZlpPY3RUWTBiQjlvQlZsZW9DdlY4cGs1YU1tS2Nj?=
 =?utf-8?B?dS9lOGt0ZVF3UmxocmNJcDBMZlM2ck9EeU02ei9VUFozTmFvVlBONXBGS21V?=
 =?utf-8?B?SE41aDduR3MrRWZUVkFRN096bWpXRVIwSWhlSzR1Ym8xWDBSb2JlMk1lZ1pw?=
 =?utf-8?B?WDJYbEsvWWRvVnV5SitFYjBGWlRmTkVHeC9hcnZNYU0vTWpyemJaVlVRc29S?=
 =?utf-8?B?N21sZEE3cEFEbWVFMEcza0JNRmcwVE5taCtNNDVmSW1reHBqd2VzWm9palZ2?=
 =?utf-8?Q?lbLNV7iPQQw7W5VzeVKMPGDRHuKqpZ4RVWOJY8brME=3D?=
X-OriginatorOrg: ensta-paris.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: f9832066-94df-42ac-2f9d-08dcb7feeda4
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 23:07:51.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f6c3f3f-c20f-4ade-b8c1-3e0fba16ec71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U+HeGQNNrmfyGPHMXafj1Vx0RAtRUMAVVYZ/PDgcO8GHEw/FWpmLDjf3br59zrT0+/eCwxkw0SBNJjH/Z2lh4xCE6chFLSK2fyqMh/Ptaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2762

Hi,

Thanks for the lightning fast reply

On 8/9/24 12:28 AM, Qu Wenruo wrote:
> Mind to share the model of the NVME device?
It's an SK Hynix P41, 2TB.
> And I guess you didn't do anything dangerous like "nobarrier" mount
> option for the fs?

No.

I roughly followed this configuration: 
https://github.com/egara/arch-btrfs-installation except I used 
systemd-boot.

> Furthermore, the error message doesn't show which tree is causing the
> problem, which I hope it's not some critical trees.
>
> So you can always try "-o rescue=all,ro" mount first to see if btrfs can
> still access the critical subvolume trees.

It gives the same error (with a small modification):

BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want 
211658031104 have 0

becomes

BTRFS error (device nvme1n1p3: state C): bad tree block start, mirror 1 
want 211658031104 have 0

And same thing also for mirror 2.

Thanks again.

Best regards,

Andre


