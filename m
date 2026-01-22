Return-Path: <linux-btrfs+bounces-20911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L7nORkGcmmvZwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20911-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 12:12:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1865C73
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 12:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBC356C2FCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE5239E97;
	Thu, 22 Jan 2026 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qdSo0FPO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gdokKFtG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4EC326954
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078763; cv=fail; b=UwCsAnwu3LzzZik7wQuuSCGMT9Bp9M0XaZH8NHTYFgw9IDkfavqmhNU+lH5ZwfiKpkRaP6WUXd60csdWE2dYe1SzDY0MjVImCX7tQMIn8gwBkZxlZI0NRSmllfj/274q97ZPa9YXVb9Ky5Z/L1AJq1l5r8HcPiWqYUovFI2BxI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078763; c=relaxed/simple;
	bh=N43qrwKg10Pc9/qSQmd0djOK7twG8Ht7/xp19p/yjA8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jO/gzAg8rNxD8STi1j5TpSoVKHGTksR0DRw7KwiSo8x5BA0ZE0rFUMT5Rt6jTm+szQpPqkSHfLGVGt/vLUxCUdcaMBLmwiqCurRdE8Ly2lREXeLJio9XnVhFRGuxAJzFJQuHLCNPPbTK0y8KSf6wVwp9nXeybZPL2MKcbBLP9yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qdSo0FPO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gdokKFtG; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769078759; x=1800614759;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=N43qrwKg10Pc9/qSQmd0djOK7twG8Ht7/xp19p/yjA8=;
  b=qdSo0FPO7teh+j5VooW2NtcvNBuX5AnUqIYMtrlSLjUMwCihW25kEf2m
   AN3vaQxjqUxdjnD8+HnynGF8J4q8nY/5+fOy+Tb+ZMPvX0szDXzGi/nck
   L/gYUEaeR5HLfQDL0TKnkIbfzj4F/3HmC7MMmUo4JOjtSBzryX88ALcti
   cJmMEVd8eYuLmmBhQzJBvUZ8BBWj3yo+cqLVFFMs0ZnBlNK39dQxg6l9m
   QMR/PRP+XnjQ4sb/Thm+IXQbQ6oY3fv9M+Z1lmmuyGCdim2LEyOqIMc31
   igzpbtjSYsJFgqFm9rtwmWFKRQeLg1O5XJocb9+4zuWeI+Ok2dRHm0+0M
   A==;
X-CSE-ConnectionGUID: T4rC5+stRDW4clom9R13yw==
X-CSE-MsgGUID: auTcUqwQRLqh2uN6Dd3eSg==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208";a="139014234"
Received: from mail-westusazon11010017.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 18:45:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKjfK29tkJQKsaQOEnCVPSelRUyWyBgq0zw9DD4hRTUgPARNHPXgm3z/4eWyJP5h6PnF/7uHvxZnjcYHWzZNmVgyi1eb6EnyiaTsqq4dbUwnKY1iLjbUMUAEYLpn0716vhl5iPxYqfFzvTpdkB3IBx1/vwIBfL0FxG4duvZbd2+9IVyH/aJETCk4c1kj3lZ/iuX5ar6Nr3YFU2ps3qDut8Ya/9eaq9bo7yjCxJvA+kperLHq+bt2Ym+fL/qeLqaSkUNUIi62Ww4ZsNJLCT7wXmiX2tzHYkdl0dy8bgPd6FrJ1y33HnvbiRatitkdorPy0kjc1oxq5LHjbpy+o8a5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N43qrwKg10Pc9/qSQmd0djOK7twG8Ht7/xp19p/yjA8=;
 b=LEDlnwNqN3o9/DI/62WKIl80cdCMy7U1AMvIXaknIwAXyyOrq+3uxLLggg0CzLcP8XudwS4Hno8Fj3v2/Xqfs7BSdBhpKMFJz2PGvyWN77H69dEQGE8hHEkhkxixAJsU+lmPFcOuOD9+MHRj3DOEPKX/RvRaTLqoZzE1lWoj2rxY3tAymZHgbSOr2UBECzspNTuwBmVhmQocv4mWak8162j8xDQcpigtbtdenqrGLjQ71WCVotunya2rDzGotiL00j7X6IrR9nWV+D22AHHxJb+tHx9+Id6JBRdft0Z3C+jMo3fm3LFdMCbA6PQ7EkBxRDecc74ExAX6raM9Nmy9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N43qrwKg10Pc9/qSQmd0djOK7twG8Ht7/xp19p/yjA8=;
 b=gdokKFtGndl3vUzWhf/mEcifd/7fPoO73vQJ1XXMCB+afttSRTg8V8PUKJJ9i00mm4/fTQ3wRMXUvAwgtdUbaK5SZjRL2LKHVbEAkwYQAdbq6Q7fVmoGd7a5s2l1sbD3OTz/6FhjfNbSPDGW71jcPOdJbDX+WF3M9prVnSyMOq4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA2PR04MB7578.namprd04.prod.outlook.com (2603:10b6:806:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 10:45:57 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 10:45:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/19] btrfs: fix a return value and remove pointless
 labels and gotos
Thread-Topic: [PATCH v2 00/19] btrfs: fix a return value and remove pointless
 labels and gotos
Thread-Index: AQHciwgpjxObS470v0OYEFdVU1Opa7VeAoIA
Date: Thu, 22 Jan 2026 10:45:56 +0000
Message-ID: <815d30cf-a156-435c-bffe-a1eae619fef7@wdc.com>
References: <cover.1768993725.git.fdmanana@suse.com>
 <cover.1769012876.git.fdmanana@suse.com>
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA2PR04MB7578:EE_
x-ms-office365-filtering-correlation-id: 61b94bdb-4586-459a-9f90-08de59a36c90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?eCs0RVQxdjh5aDdxUHg1U2kxTVFPRWxWcUVOY05FSjNjcCtJK1l4aCtoYzdj?=
 =?utf-8?B?UW8rNWtPcUo3eXVkWlE2RmZDODVhODloVHdpREY5SFNVVzFKNFBEY0U3NVdK?=
 =?utf-8?B?WXFZaFdkb3BmL0VRd1FhM2FrK0k1VytQc2hyZzFPL3V0NXkrSXRSWlp2Ykli?=
 =?utf-8?B?RlpOczBmQ0wrMjJVYnBPL3Y0WWV2T0VvWEI3b2RVR0JuUjFobFB3V0FSd0Yr?=
 =?utf-8?B?Zk8vNXJ0bnRVak8vL0hab08vd29mbW9CODRJWVZ4ajdZNzhKZ05GWG54a2VT?=
 =?utf-8?B?bEhWMGl2QnRKOVhpenVGZERMb3c2L3hmdDRIMmFkalBiemJOR2FVd0F1TkRj?=
 =?utf-8?B?K3VWSWptenMzTWc3ajEwcndwczZsYk1hSm9iV2FMYU1WNFFreWJuRG1ZdU1V?=
 =?utf-8?B?YW1qY3ZEb1d0ckV6aGVIOXpiZ1hHQk5oWERqZGVyaE5Xd0JvOHNIQ3VIYitS?=
 =?utf-8?B?SlloYjlIU0hpdnJqOU1KNFlBWmM1VHNWbG5TVWFyUlZ1ZVF0OXZuYWxma3J1?=
 =?utf-8?B?TUI5VE9NL0RWc2wwSXhlWDBLclljd1JZRkJOTzZhWDlvcU5OUUxpcXdWQ1dp?=
 =?utf-8?B?dHlPeUpvNkFMQlZKY1VCR0ZNa2ExMUdGSkVwcTJLRHdMUG42L0xRL053VEc2?=
 =?utf-8?B?VGc1K0RxU01tU2grSlowYUg1eGVnbHdHTVZ1MFZCRVlOYjgyc3FGZzhjMGlY?=
 =?utf-8?B?RGVML3BsdzhpZTZGV054b1hKeDF5dzk4V0wvRWlVamNic0JYdDBZd3A4UWxJ?=
 =?utf-8?B?OVNqYi84cXRNcEhnWkxyWHNyK1IzdWc1cmtrR2pLTERMV3VRa01CUTluOFhL?=
 =?utf-8?B?TTZTNk1HZHhGWWhXZngvWWp2UHVYR29GbVBUWGxiRVFDODkveGVaMG5xR3Rj?=
 =?utf-8?B?a2w5RUhRRkpkQS9sbkdpLytlUkRDMXk2UW5FRnNsSGFoWkRITHZnc0tlQ0Jx?=
 =?utf-8?B?TVNxM2FZVGVDY0xyQ3FFUm9nbGJ2Rno1Y2MzYm1id0dmZ0pXaytodWJUUEh3?=
 =?utf-8?B?NmVTTTVYZjUzeVpxQm1lZ2Q2Q2MyMDkyYWFiVlNCZElZQ2lGMm1ldHdjM3dk?=
 =?utf-8?B?ZlpDa3o3a3lxVUI3REZuVmtTZ3M2d3RuUnB0S3FXeUZpM0F5UHcrTWxSWXNQ?=
 =?utf-8?B?bG40K2hOWmJNRnB5Z21xNTdoNGM2Q3dXMlpCelRCOVBFTTg4aUoyWG1yTHQ1?=
 =?utf-8?B?RnUxZDlrTVhCaVQyL3dacVNjQU9zcWNJMWZHUG10OVVEMmpWdGNxQXJ1NS9a?=
 =?utf-8?B?TG1YOTBwUlo0U29idm5WSThEUzBpMzhleUtIUEpSWWxZK3lUZytqLytkbXVO?=
 =?utf-8?B?Nno2L0tvNEovYnIvYlBQOHBIV1dGVVdrK250QXJGRWMxbi9VcmJrcVFZMHY2?=
 =?utf-8?B?bmxUQ1ZkZEc0RnFJaVl3U0JORTFDOWdISk90R0puejNMVHl2ZW4xbCt6dmRV?=
 =?utf-8?B?REc2d0Q5WDZDUGowTzhxN2ZsRWZiNWZneGtKY016dzc1aGVWTDdPeHAzL084?=
 =?utf-8?B?c0tUUXE5WC9xOUtRZ0wwREI5KzBUUm1VdzF3WEVpNm4xUXBaVzdlam5UcHdU?=
 =?utf-8?B?R2k1QlI1MTV3VGkrbG00WUtyMUdRMjVEUi9ra2E2WjlYSEVVekhrM2xlZ1lZ?=
 =?utf-8?B?QVI3UUZFM1UzbEc5Z0pzRDh4RjB6ckcvZ1p3TDRnczJMbmVkTm1tQXI1bllB?=
 =?utf-8?B?ZnBzeVdnVVM0K1ROblhpbVc3cnAwZ0lSaW1KcTUzbWtOMUpGQjVqY0xnWGhm?=
 =?utf-8?B?V0x5YVpaYlVPSDg5aUpaT2xpUVhOZlFCQTVLaUhCZythRW03eXplZmtrR3Mr?=
 =?utf-8?B?YmNFVFdWOGY2N0lVS2c4eFJJZThkaWFpZ2RyazR0TEhqSEpqd2U1VkwyWThP?=
 =?utf-8?B?MFY3SWI1T3BEUXUreXJEZzNSRFZtNXd2Si9lWStNU3haK09PS3hzVENmVTFO?=
 =?utf-8?B?bVhxSUdBSDAvbjhKT1UxYVdtbzVyWWtKZ1EzZ0Jid1crNVVZWkdndkllN1N0?=
 =?utf-8?B?ZDVBaXBabWJhMzhGN3YvMkFHdWdTUWg4NDZJNEVuRzMySkVHeUhjelFzTXlT?=
 =?utf-8?B?YW9IcXhJTUx0dTM1T0JsZTV6QkVFUEhKd0dNRW5jMkxjMUZZR0F2aHgvSVVU?=
 =?utf-8?B?VHdGTFNhdjBjL1B3bU9GRk12eXNZYkZFNG1sSkhjcFlkZ2VWekt3WjJtZ3Mr?=
 =?utf-8?Q?IoW6Bj/lc35RCFduBM+Rw+c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1JOZmphQ0FWRXJtMURYNy9nMyttbEF3eHozWkV6azgvaHF5SkY3SkY2eTIy?=
 =?utf-8?B?MHgzZE1VRmQybEczQVlCeDdzbXNSdy9NcjVRSWs1NUlYbU43Q2JNZjZ5RC9k?=
 =?utf-8?B?MFJyZUV1dVJBaGtqQ2dCWTJZcSt0RmdOTDA3Z3Z5K1Y3UVhSNkxEUWJkcTNT?=
 =?utf-8?B?VGlDVGZTT04rZ0kwc28vVkdZbFNiVEhIMVpCc05WTE1RTkVobW5veEpHVHdB?=
 =?utf-8?B?TTJDNEc3Sm9TYU9NYU9lbHVXbTBlTjR1ZS9wLzdwcXAreUpwQjAwRnp2bWox?=
 =?utf-8?B?QkdDeHJDM3JVYW52UlJJbXFNd2V1R3M5Ukh6N3hIZmNkTVpkNDFyOGFSS2NP?=
 =?utf-8?B?QjJyeFBaaWtGREZhYVB6bmJuUmZTUVhXNlZ0SlBHVDlaWHc1UisxdklpTWd0?=
 =?utf-8?B?Y3loRll2NGtxTzN6eklueTBWOVJZM1NadDR4S1BLTmN3aTNBSUl2VDVVRnp0?=
 =?utf-8?B?L3kvUHVUQnlmS0lTOG5ZLzJTUXlRbVZPa2w5RU9hK2Jaek9ESWg4ZE13UWZY?=
 =?utf-8?B?cTMwb2RONjQ3NlQvM3NJODdQcFVJQU5wTFB3WjhJa0lBelFNSGNPaG53cXJ6?=
 =?utf-8?B?T3BFWUUxeldzK0krT2c4MEVsT1hmZlptSUlpdjJVUGQzVFN1cG92ZXB1YUov?=
 =?utf-8?B?T2pwcVpPUlpleDNrSEgwaW8rTFBWb2Y2T2RsTmFPK3pBTnBXbWM0NFhpdnM4?=
 =?utf-8?B?S2lyUEZJWUduYVRsMXA2cDhEMkVrSk9ncnZKVVlORFowTWNZcXRUVmtDMFRo?=
 =?utf-8?B?dDNlTFNXdTRodUYydWtuWlpPelpBY1h6WWtuOXNXQmpzN3hncC9SZHQzL0k3?=
 =?utf-8?B?bXg2NUFrQktBWHBrZitSQlFoWjgvVEtWbXZNM3pjZUtYQSt3V0EzcTZxVE9H?=
 =?utf-8?B?Vk9LYXdKM3RjaXIyTTB0Mmo1S1c4bFY0MFRDMWxjajVORUJraDB6M0R3NlRl?=
 =?utf-8?B?cThPQW80UUxPbGJCS1hYS0FoaHM2dC9FZGJnakhWb2k2VlJTQ1huY3NPS2Q4?=
 =?utf-8?B?Wkwwc00rRnZmZWh3a2VORUV5djlYZ0FhcEI4eTAxQWQ1ckx4SEFJeTBRckZp?=
 =?utf-8?B?bm44dnJXT2tnRDVuR1AvSng2bDcxTDZuUnI3QmNXMnpmYy9GRkpNTTd6NjA0?=
 =?utf-8?B?QjBub2RUeVAzQ3F0d1YycXZBM2JqWkI2YTQxOHBaTlFMb0NjYlo5MzhCc1NV?=
 =?utf-8?B?VTRNQnc0TnpDei9ZeXdmRmRwL2FOazduYW53dWpoRGVTVUs0OXFFNktBTHl1?=
 =?utf-8?B?OUQ1OERlWkdGbytHSWRoQ0tCSkd4R2gyRDcrdzlqVzdRV3J6Sm94UDJVb3R5?=
 =?utf-8?B?S09KeUUyR1o1TUpVMXZkaDBuS2FiU1Z4SXp0eTlBaXh2QkhvU0RReHBNakoz?=
 =?utf-8?B?Z3dMajBJSUtWdlpraW1Sd3VxcmRCZEl2UU1kZDFyMHpMNmxBSHdyTnpJUzJK?=
 =?utf-8?B?WnJadVhyN25MRjc1dFNUbDh4MkJTWUdzbU9LYkJ0cWNRTlRRZkpWTXI1TTZX?=
 =?utf-8?B?dTdBeC9NWUZzR0JJeWFTY3RlNzZYQUxOeHJXUU1ScUd6OGZYc2xzZWNEUWNz?=
 =?utf-8?B?eW01WFJaUmtIWmZ0UWhkcVZubXJsN1hoSDJWWVJ2TlZxYWtPK2hTU1lHQUFp?=
 =?utf-8?B?TGVNaUNNcFdSR0gxdURBQmZYOEM2VUYzRVVXVlF6c05PZzJMWm81OGdseG5V?=
 =?utf-8?B?UzJBK3A4NTZRQldvcDNiMUgrRG1tYXZ5MFFJSGh1SVBwYUF4NXJFUG1WSDM5?=
 =?utf-8?B?MEljYk91ZzlCU3FJVUo5S1VDTkNvNldqUzU1RFNuTG5tNG93c3NXNlFEaUpr?=
 =?utf-8?B?emQ1a2VQcU1IeENBR3h5cDJDUlhxYzg0NC9PTzhZOUMxTkZRT2wvbEpVZ3Vz?=
 =?utf-8?B?K2k0N2ZueHdreGhDMWduR2lobmxXMmJ1TElyWld2aEwrKzFNL1VhTEI5ZXgr?=
 =?utf-8?B?QzN5Rk9kb2JMd2VJMllyRUZ1dEt0QkMvWENvNkFydDVlbTlZYkYraWRjYyt4?=
 =?utf-8?B?MzhqdU96VURyQVh1cmE1WXEvZlhSV3A5U2ZIU2g2cDhSTGtQL3I4RE4vaFQx?=
 =?utf-8?B?bkVXaXJQN1U5Tzg4SXp6eUpaZnVQV3U0cXVMeTIveGR6Wm1CMnM2ckR6NTlk?=
 =?utf-8?B?TVhCTTdiNGQxQkZITHFWb1BRVXVSZXNhWU9yOXVJdCtXcXVwMldycWoxWU9K?=
 =?utf-8?B?d3JjMkN2VGJ0YXRLdUpuTVB4ckhyUjB3aW5FYy9HMkJBU0ZoOU5xTHp6ZGNY?=
 =?utf-8?B?VlpLdHVROEliaVh4R1hmMDZFVnZhNXl2clYvUzJiMW9tanpuZ2pkQ0c5K3lt?=
 =?utf-8?B?L2tCYzlUdjdhTGRzaXhtMktrSm5qSG1qc3dGaFV0WUZmbHFqT215RUZYVjJa?=
 =?utf-8?Q?W9DoJACJUAV+i9FHwACDHJ2vg6HUzmkATc37Fw44sousF?=
x-ms-exchange-antispam-messagedata-1: 4c4go2IUisBoJzyCLABBDnXWgm7fNRe8oPE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE198D47A3A3449B25D55225670E316@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nuYO5ZWbfpymtFL4+mto+u8qwqQmNh0BVd9jUy92e896WkjLQyJ4+EAlwzF2pWZAUbHoWgyQEbhXyEbOSH3GBGtEFDglD1WBB58oyb0JM/ZBMv8n/IWli8zbNKCZbPokfa/nkXZw6Ia8IflgphHbpVT8nTcPaI4ZfHv19bt48gj2KLgSpXOkjLXlQurGvi1wI3Og5CFWaW7si29VWrvdnBGjv4/B60dS7s7mQd6wm11M5wi2vloUTcithHXkdVpbNnVvuwZ0Aj3JArZbY9xA/lfn4NcWBE0M8yKU1Sw6F3wxV8ncsXVgcj9pIA+Y77kyPIZQXVc7Y84S2Ar28DB/beRBZFBcj8kSmNcdYn3M/91VQZo3SS4wtsliSON8hj0mXPp5X18eAWgzghrF3XIGvDthnONfAKWsAuqzSXthSjA894SLkdTJuuHmjdMRVz2VVmnpL99QsmCtB0iayfOXJePZj8nZIYUG9lVpJUf6CXbO/1cKzn9dswOg0K+XdBE9raBdCzGk79SbjkUONdjtlZjygYH5i+RmxtG3nIqHQW75N3u3sU4YtVcMHM7tuWvHEy/BZ+GYkQl0yOaLLb+kggNH+V+wcXuXgP4jZVFvMgGf6pMa6dpq+P2IlY50qjC9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b94bdb-4586-459a-9f90-08de59a36c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 10:45:56.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4OYarpz8zzV9+3UlPq1s2zSX8GcG8hL83gPb85n4L/Kb5eRPcTfU9y1Inf4VftsHdcBmwpaR2IErshEOQvmgQ1Y7mJblNGjFrhKasap7js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20911-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[wdc.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid,sharedspace.onmicrosoft.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 6CE1865C73
X-Rspamd-Action: no action

T24gMS8yMS8yNiA4OjAwIFBNLCBmZG1hbmFuYUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBG
aWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4NCj4gUmVtb3ZlIHBvaW50bGVzcyBs
YWJlbHMgYW5kIGdvdG9zIHRoYXQgY2FuIGJlIHJlcGxhY2VkIHdpdGggYSBzaW5nbGUNCj4gInJl
dHVybiByZXQiIG9yICJyZXR1cm4gLVNPTUVFUlJPUiIsIG1ha2luZyB0aGUgY29kZSBzaG9ydGVy
IGFuZCBtb3JlDQo+IHN0cmFpZ2hmb3J3YXJkIHRvIGZvbGxvdyBhbmQgdG8gbm90IGxlYXZlIHN1
Y2ggZXhhbXBsZXMgZm9yIHBlb3BsZSB0bw0KPiBjb3B5IGFuZCBrZWVwIHJlcGVhdGluZyBpdC4g
VGhlIGZpcnN0IHBhdGNoIGZpeGVzIGEgYnVnIGluIGFuIGVycm9yDQo+IHBhdGggd2hlcmUgd2Ug
Y2FuIGVuZCB1cCByZXR1cm5pbmcgc3VjY2VzcyAoMCkgaW5zdGVhZCBvZiBhbiBlcnJvci4NCj4N
Cj4gVjI6IEZpeCBhIGNvdXBsZSB3cm9uZyByZXR1cm4gdmFsdWVzIGluIHNlbmQuYyBhbmQgbHpv
LmMuDQo+DQo+IEZpbGlwZSBNYW5hbmEgKDE5KToNCj4gICAgYnRyZnM6IHFncm91cDogcmV0dXJu
IGNvcnJlY3QgZXJyb3Igd2hlbiBkZWxldGluZyBxZ3JvdXAgcmVsYXRpb24gaXRlbQ0KPiAgICBi
dHJmczogcmVtb3ZlIHBvaW50bGVzcyBvdXQgbGFiZWxzIGZyb20gaW9jdGwuYw0KPiAgICBidHJm
czogcmVtb3ZlIHBvaW50bGVzcyBvdXQgbGFiZWxzIGZyb20gc2VuZC5jDQo+ICAgIGJ0cmZzOiBy
ZW1vdmUgcG9pbnRsZXNzIG91dCBsYWJlbHMgZnJvbSBxZ3JvdXAuYw0KPiAgICBidHJmczogcmVt
b3ZlIHBvaW50bGVzcyBvdXQgbGFiZWxzIGZyb20gZGlzay1pby5jDQo+ICAgIGJ0cmZzOiByZW1v
dmUgcG9pbnRsZXNzIG91dCBsYWJlbHMgZnJvbSBleHRlbnQtdHJlZS5jDQo+ICAgIGJ0cmZzOiBy
ZW1vdmUgcG9pbnRsZXNzIG91dCBsYWJlbHMgZnJvbSBmcmVlLXNwYWNlLWNhY2hlLmMNCj4gICAg
YnRyZnM6IHJlbW92ZSBwb2ludGxlc3Mgb3V0IGxhYmVscyBmcm9tIGlub2RlLmMNCj4gICAgYnRy
ZnM6IHJlbW92ZSBwb2ludGxlc3Mgb3V0IGxhYmVscyBmcm9tIHV1aWQtdHJlZS5jDQo+ICAgIGJ0
cmZzOiByZW1vdmUgb3V0IGxhYmVsIGluIGxvYWRfZXh0ZW50X3RyZWVfZnJlZSgpDQo+ICAgIGJ0
cmZzOiByZW1vdmUgb3V0X2ZhaWxlZCBsYWJlbCBpbiBmaW5kX2xvY2tfZGVsYWxsb2NfcmFuZ2Uo
KQ0KPiAgICBidHJmczogcmVtb3ZlIG91dCBsYWJlbCBpbiBidHJmc19jc3VtX2ZpbGVfYmxvY2tz
KCkNCj4gICAgYnRyZnM6IHJlbW92ZSBvdXQgbGFiZWwgaW4gYnRyZnNfbWFya19leHRlbnRfd3Jp
dHRlbigpDQo+ICAgIGJ0cmZzOiByZW1vdmUgb3V0IGxhYmVsIGluIGx6b19kZWNvbXByZXNzKCkN
Cj4gICAgYnRyZnM6IHJlbW92ZSBvdXQgbGFiZWwgaW4gc2NydWJfZmluZF9maWxsX2ZpcnN0X3N0
cmlwZSgpDQo+ICAgIGJ0cmZzOiByZW1vdmUgb3V0IGxhYmVsIGluIGZpbmlzaF92ZXJpdHkoKQ0K
PiAgICBidHJmczogcmVtb3ZlIG91dCBsYWJlbCBpbiBidHJmc19jaGVja19yd19kZWdyYWRhYmxl
KCkNCj4gICAgYnRyZnM6IHJlbW92ZSBvdXQgbGFiZWwgaW4gYnRyZnNfaW5pdF9zcGFjZV9pbmZv
KCkNCj4gICAgYnRyZnM6IHJlbW92ZSBvdXQgbGFiZWwgaW4gYnRyZnNfd2FpdF9mb3JfY29tbWl0
KCkNCj4NCj4gICBmcy9idHJmcy9ibG9jay1ncm91cC5jICAgICAgfCAxMCArKy0tLQ0KPiAgIGZz
L2J0cmZzL2Rpc2staW8uYyAgICAgICAgICB8IDU0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
DQo+ICAgZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyAgICAgIHwgMjQgKysrKystLS0tLS0tDQo+ICAg
ZnMvYnRyZnMvZXh0ZW50X2lvLmMgICAgICAgIHwgIDUgKy0tDQo+ICAgZnMvYnRyZnMvZmlsZS1p
dGVtLmMgICAgICAgIHwgMTYgKysrKy0tLS0NCj4gICBmcy9idHJmcy9maWxlLmMgICAgICAgICAg
ICAgfCAzMCArKysrKysrLS0tLS0tLS0NCj4gICBmcy9idHJmcy9mcmVlLXNwYWNlLWNhY2hlLmMg
fCAyOCArKysrKystLS0tLS0tLQ0KPiAgIGZzL2J0cmZzL2lub2RlLmMgICAgICAgICAgICB8IDIx
ICsrKysrLS0tLS0NCj4gICBmcy9idHJmcy9pb2N0bC5jICAgICAgICAgICAgfCA0NCArKysrKysr
KystLS0tLS0tLS0tLS0NCj4gICBmcy9idHJmcy9sem8uYyAgICAgICAgICAgICAgfCAxNyArKysr
LS0tLS0NCj4gICBmcy9idHJmcy9xZ3JvdXAuYyAgICAgICAgICAgfCAyMiArKysrKy0tLS0tLQ0K
PiAgIGZzL2J0cmZzL3NjcnViLmMgICAgICAgICAgICB8ICA4ICsrLS0NCj4gICBmcy9idHJmcy9z
ZW5kLmMgICAgICAgICAgICAgfCA3NiArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAgZnMvYnRyZnMvc3BhY2UtaW5mby5jICAgICAgIHwgMTMgKysrLS0tLQ0KPiAgIGZz
L2J0cmZzL3RyYW5zYWN0aW9uLmMgICAgICB8ICA5ICsrKy0tDQo+ICAgZnMvYnRyZnMvdXVpZC10
cmVlLmMgICAgICAgIHwgMTYgKysrLS0tLS0NCj4gICBmcy9idHJmcy92ZXJpdHkuYyAgICAgICAg
ICAgfCAxMyArKystLS0tDQo+ICAgZnMvYnRyZnMvdm9sdW1lcy5jICAgICAgICAgIHwgMTIgKysr
LS0tDQo+ICAgMTggZmlsZXMgY2hhbmdlZCwgMTc5IGluc2VydGlvbnMoKyksIDIzOSBkZWxldGlv
bnMoLSkNCj4NCkxvb2tzIGdvb2QsDQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpXb3VsZCBiZSBuaWNlIHRob3VnaCBpZiB0
aGVyZSB3b3VsZCBiZSBjb25zaXN0ZW50IG5ld2xpbmVzIGFmdGVyIGVhY2ggDQpyZXR1cm4gc3Rh
dGVtZW50Lg0KDQo=

