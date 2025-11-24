Return-Path: <linux-btrfs+bounces-19285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38211C7F730
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 09:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A525A3444E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF632F28FA;
	Mon, 24 Nov 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PNc89KFn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FPfQ61Dw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBE2F2612
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974738; cv=fail; b=FkxxTo6Hp/a7jRSbdkgap7bm+q8Q+Hl4ulphjKuz4ccukg3RSNLgYBnghB7Hd1IcXzLIn1wDqu1e4uwh+2YBjct55hZfWhIXE4vMWWj2TWeuhhrUrKvt/TuieEBpBfjryLOkkkAKgIV6ZdtxWvZcYxuMyPKwc5kTHj9bda989RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974738; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SItuCDgz4E5ky7k4jka7fUA21yB3miDFsQ0tnoqBs7MWMFXG97LT7QkjpdlD2oFF1xPIWRKqFqF+WyTOPWUWuOHndIiHAg3U2Hsr8H85aqLpJEqVyuBTpm4B7hsvegEnP91StiYPLSYu/8Xbr4GUhj/XVl7sjOgZ3kZHlj+kkXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PNc89KFn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FPfQ61Dw; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763974733; x=1795510733;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=PNc89KFn+AQkLvgiv0c3JQWyXJrwPn6txB+shwyyAZzjiW7zwImFIoIC
   iBIfCAJv13aoEaV9aKnVMtT24k0ptiHKFlVb2jK3pXWPjrGiJHB5Uhf3+
   BEqXsV5z1I8bgoMImWx3K9e9G63le3GnW6WtOyNw44PfC1VegwZSfO0zD
   NWn2NGXArMDCInrma8ldXAOrosYkV5JUt/U+z1fpsqLbHmq1BK5Beofsn
   AGGkKmTYnknn+ONaE8eoauq2wXQROhAWLdL/u52lsMb8LvD/9Q6PazF1s
   d05ev2xXyus8CG79pl5fg2FvbMg4ncP4xhvnbS9ec0OydSKtaTBS2FdtD
   w==;
X-CSE-ConnectionGUID: 4bcTNrwXSqWAbVAt84lCgw==
X-CSE-MsgGUID: pWZi8e6sSfSuNC9wwH2N8Q==
X-IronPort-AV: E=Sophos;i="6.20,222,1758556800"; 
   d="scan'208";a="135673792"
Received: from mail-westus3azon11012044.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.44])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 16:58:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzKoj75v2vPew+jGINxWOhBXylewU1A7db9Rg+TpLhvXe4J6vp6wDgbKmgRL+wBXHDvQw6XMreS254g7/Beu+gJJe7CYSaXFXhpe4WKRbWICC7t93Nq6xfbh2sKEoEWa+bDTU6VGWJ8Ke7EESLuFRtKFGe/SLFYMeatqFs6/tv/+6Ns+7rwxD4dZmG6bovN1ZkcK4kt7CyHCP12OGHhAWskAt2RZcWky1irVy3omJHidU0TcGqvR4i/rFdV6VwlzqDXe2fhInkY98izPs8Yngu52g99UsVQuKY9MRMawjB0vxiV61DL8XlZONWxSVUVfPIbZLMYjWgLgwkMSihr3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=mrL6eiU0QefokO4N1u/QGC4taqMiFSlI9jUt39YQ/HmN3vDmvDCo2psOjubFsL5s56zKeg8AtfG5CpTCsiBvX+kOTuBe9Lb+JKHB4kzXpeWv1BO/GRpUrOMkiSYH8GdW80EJzi3BVb/jykW/NBvYDRQgR+Roy5Qvs0qrE98hnphTpek0TZ0Y4x2hxjFJiu8hfaRDIsgdMjH5H32MnNWH7NTu4UPLxFSwVigUmAaQf19Zx7iJWhOv0nj/GyCxItP0clCYSoQgvgGPZhWAl73Vv9XkbSd+ZIIbP7YGKuCBuhicjVW5iN5UFa8De1FIetycNd4XW/dG0AQFhzSel+h6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=FPfQ61DwrFBUYwLxPg1N1J62g0+l45V4G3RTXFwUAYG2ts5ZTMF69qs97i0lclZywJIdipqqY/ruCMG05kT6iHOm9AU/O+y3ANtCLtAmjADiaIOJHlSPHi8jbzTD1y8JmEz/4Q6A8ITP4OjZjwtpyEivz93fW41LSdraPh9eXUw=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7214.namprd04.prod.outlook.com (2603:10b6:a03:2a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 08:58:48 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:58:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun YangKai <sunk67188@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: update comment for visit_node_for_delete()
Thread-Topic: [PATCH] btrfs: update comment for visit_node_for_delete()
Thread-Index: AQHcXPX4GH8EvkGHwEq9kCMGX4WKirUBhnKA
Date: Mon, 24 Nov 2025 08:58:48 +0000
Message-ID: <b1fcb67c-91f1-4819-9277-9086acda9b65@wdc.com>
References: <20251124035328.12253-1-sunk67188@gmail.com>
In-Reply-To: <20251124035328.12253-1-sunk67188@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7214:EE_
x-ms-office365-filtering-correlation-id: 8a3a3eec-41cd-4530-fe04-08de2b37ae5a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ri9DbTh1VGJua2FZeDhpT1ZxVFFYU0g1SnpKNERpWHBvNlphQ25SeTJ5dUdF?=
 =?utf-8?B?a3M1K0NhQXF5R2k3L0xsanFqQUNrSGE3dzBZSWI3YWZBQ0tEdTdoeGRmZHpO?=
 =?utf-8?B?cVZ5TjFPaHBOSDM0eGRDcFpzVlBxc2U3OHFYdnZXcmphV3BibkhVSEk2QUZy?=
 =?utf-8?B?UmEyalB2NnV6azBMT2NESDlCcHg0cEgxVzJSV0pMQVVtaU02M2hDWTVhZTJC?=
 =?utf-8?B?b0Zvd0U1Y2pqUFhvbzkvTU1pcFF2bzl5S2Y5Z3RWWmlLL2IvQk9GR0RWWlc0?=
 =?utf-8?B?dDJKb0dkZXppOHYveW9HMHgxSVI3STVUTmFYbkNsR1NLVnlXRk5ic09VTnlt?=
 =?utf-8?B?TzMvWkRYYlFmY3JrU2dLWHEzRHV0K3ovaUlETnNFZVp0dytxaldYdjZTanVB?=
 =?utf-8?B?T1pPa09xaW5qTjduSzVXeWF4QzIvQ1d1ODhQN253bzhYcXhCOGJRN0JkTmJT?=
 =?utf-8?B?VzFDcFllR1dCUHRPdmFFeWdWVGZ5TlB3bEdYaEJvN2poRnd5dXI4MkkvMnhD?=
 =?utf-8?B?RGwvRjA3RFYxT0d3d0pveXF0a0NqS2xkZW5PUG15NEEvZWZ3T1NzaC9OZSs3?=
 =?utf-8?B?TjZWL3NHTXdkcEU2TjVia3BUNTdkRmJseUlTUDJ1SWhGNTBvTzJMYU5hamdz?=
 =?utf-8?B?QmkrK3p4d1JVRTRTdG5XY0JJQXU4SlhvUURhREVYUVdXZnFPWGU1STA4Ny96?=
 =?utf-8?B?T21KTkU5U2tBMnV5ZjJNdFMraVdoQzdDSVdnWW9xbTZ0RUx6TWRqblU3NlVi?=
 =?utf-8?B?Q2ZGWnFQZEZDYnYvbmxSQlJIcXdDbEgycmJWZXdmR2xjdkRSWGFLV0s3ODJI?=
 =?utf-8?B?NzllT2t1Mmp0b0laUXMzWmdrUHVlbSt1eUo4VW1PYTNWZklOdGFzR2FXbTFV?=
 =?utf-8?B?M0RyWnlWb1BuMXhBVklFS0IvY3VRNVF3aHYreWVheHNlSHFqQU1BUHltajZo?=
 =?utf-8?B?NCtPSW9Wc0hnR0JtZlc5emxxUGl2YTIyamNqaU5kUVBoNkpsWUZudDM3aHJI?=
 =?utf-8?B?Yi9yeTQ1eXhQWTB0UWZXbFhpM0lVeUFnUEdaTi9KVytvTnN3N09KTWNDVFhs?=
 =?utf-8?B?dFlDTmc5VTBWeWI3U1MvWThnamRBK1VmS3VTMFFXRzFDU1h0NmQvTHpTV2J2?=
 =?utf-8?B?UVRITVVJZTZkYmY5dG9iTFMwOWFXTjRPNVR4VWRwSitCYU5nQzBCWHY1VzEw?=
 =?utf-8?B?Wmk4TlFpdm9wZkV5OXlLTWxNWElPL1FXQmFRUjAzSXJEaEpaQTU5UENlWDNZ?=
 =?utf-8?B?VFZ6T1ZPUkt3aXJ0K1Jma0luRzFSY0lOOVF1Mk42aWs2SHZKVUorT25PV05L?=
 =?utf-8?B?bk5rczE5djNsS1AyMTdndDQ1ZDIyMlFVN1JyQWt3T3QwMzlPcm5kWjFrLzQ1?=
 =?utf-8?B?STdFSnRoY01mMndYWEYzbVRrT1lCRzZDYTVJL0lISHFDYzFwQWdLRmN0MEVV?=
 =?utf-8?B?TFRxRUxvRndDRmFaQ3d2bTZmd2FwTStMRW1KSzFpVmdINTkvTGxkTzhKYXRP?=
 =?utf-8?B?bHEzRXJkaWdEZzJYQjhGVFgvUFIvdkVmTHRxODVta21kUjNGYzZZbHFWQnNa?=
 =?utf-8?B?em5Kc2VVZDlLbGhGZE5CZDBWV29sQnAveS9VbENLQTlMU1ZSeEdRUFlBSG44?=
 =?utf-8?B?bDZRYkQrOEtHeWdOMUEyY2xjNjhaMW4vQ09yRmlrTG9kWmJzdCt6dFluVkhI?=
 =?utf-8?B?ZE03UmxnMWRxRlE1SFY5dDMyNDNJTngxM284ZVhOLzRyQkNmWDRGUVVKMTRy?=
 =?utf-8?B?dHNvY1ZRN0lPR3FRNkVUZitpU3ZKaER2N3dYd2FaUTVZemNVQW5WWUd3cHhF?=
 =?utf-8?B?aTBnMWNVSGw2cEhlQmFPU1Jodm1sZE94TisxQmNld2JEb1pDam1OMFBMMXNp?=
 =?utf-8?B?c3E3MmZqTWMvUDQ1M1BzVnVIeDd1ZnVCbzZ2eHU3ODIzQlR0T0xPUFRvellz?=
 =?utf-8?B?TWRpS1B1ZVlWUVZPZWpWeU5ybFVJRUg1U1h6VVBad3FhdVMzcHhWcWtVcUtS?=
 =?utf-8?B?aFVCb1Z5bzZFSDIzeFVycTdhQitlRDVZdlYra0I1U3FmV0VKQ1V2MElJTjY0?=
 =?utf-8?Q?ER4wKf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2FkTW9scDY4K3duaEUyQXd2S01MbE5XV2dTODNYdXozNmticDRYRFlFVTBn?=
 =?utf-8?B?S1lFaGs5UVZ0RkIvSmpQa1BTZ3FRWnRVd3I2UWp6aXF0MFUwYVovN2lSY0pQ?=
 =?utf-8?B?U1dVVmhER3ZxdHM4ZHNPRUMraDJBMWVHcmZsUTdwWW40UnV1a0E2VWZHZCt3?=
 =?utf-8?B?L3hLUS84TkJZZHZSODBLSWxmVjJtMXB6eEJKSE9DQU5PK1pCYmlEVEEySnlQ?=
 =?utf-8?B?cUVVc3EwL2YzK0VkTG9XTThWMkVzT0QzOUwwcjNmaDQxOUVXRFBqeDBkeXdR?=
 =?utf-8?B?aC81cHAwbEwvL01sOE5aT3UvYm9uM3ptMjhXWW5TV2pmejlZcVNLN3drZUht?=
 =?utf-8?B?RjFiRFhuZFRXNXR2emZ1ejNMYUkyempEbnBpTEVMT2xqWFc2aWJsQ2Nqczhq?=
 =?utf-8?B?TG5hNUtrM21JbXorMzJSVm5xckh6WkxnNHVQbEYxUitOWU9kQ1lnMEJsWTBi?=
 =?utf-8?B?NFpUSjB3MVNVSm1CTWNOUjgyOVNKR21WYUJZVGszVVNMeXZBYVFFU0Vqemg2?=
 =?utf-8?B?S2ovZVpaSnR2V2h2YUJXbm0yb1cxZ2RHK2Y1cHFqdkhCTTBsTHZreFd2WVJv?=
 =?utf-8?B?VTUvSFNZMUwranJsd1FRMjNyRWY4dzVDM0l2RTRYUFJOSXFWa2hncXZJQmky?=
 =?utf-8?B?YzcrNzNaMTVwdW1JZENUNnZFZktwSTA0L01od0hMT2xEK0gyd3M3N1FmSCs1?=
 =?utf-8?B?OW9mTDMxc21ZVzNBZWpveW0xNHh5a2VhMVdiTnNjYXFnbXN0YzZ6dlQxRitl?=
 =?utf-8?B?WnQvYWVHVndiSzI0WU5oTEJoUG51OGtYQnJjaWx0KzV3N0dQQnV5VUE3ZUFp?=
 =?utf-8?B?QU1ZVmEwcEZoWTZhcm9KVFZid0FPM0t1V1NWZmp3cWRkb3JCV0xHTTlRU2N1?=
 =?utf-8?B?NkM0eHVRWWQrZW14dkpEUWZ3SHlDQWZhZkNvU01GQXZ2eGtoTzBFOEkzMm5V?=
 =?utf-8?B?eHFPblFwZkw5THlKU0tJcTlncW51Z252eTNMTDRZZzhGN1lzbG84V3FRUzZH?=
 =?utf-8?B?SzZVbkdXblhnck5XUnZpbzBVUDVudCtwWlNvTjlpUzF2QUlON3UyeDlRTXgx?=
 =?utf-8?B?SG4yRm44OTV2N01pcmRlS1NwaExUQ0NWWFdCZnZ4c08vdkdsUEhmV3djYlhP?=
 =?utf-8?B?Wis5UWtBMVBLb3BnaVJDaGhENWY2QS9tanpWQmJlTEhSOWQvRU9kVy85bGhO?=
 =?utf-8?B?MDhwL3kxY1ZwdXhpMmpzQ09ucnE1MEpBaGFicHhFckx6MmtNUDBISWlOd05x?=
 =?utf-8?B?bTdHdDR1N1hHWXh4OXFldm8vRHl2OTlXaXdDN3lrbDhNb0ZSQzRjcHNTc1Br?=
 =?utf-8?B?TlMzbmlhajBIRWRBRjZnQmErYVFBMENwWS9BUjdiWHM2dFl0b3VBZ0FJcFNB?=
 =?utf-8?B?QWhSZkl6RWNYT2pwUzhlYy9sbHhxRDIyVWE5K0hIdGJjdDhkaFlZbVg1WTVV?=
 =?utf-8?B?SFZ1cHljdzkyYk56eFFDNVAyajNWYnYvTTZzNEpFVEZZV3ZncFRlby9tMnNF?=
 =?utf-8?B?REhNUkc2akVNZmxYeVNkQi95NXN4OTZjSHBRTWpWSC95Vi90c3htWHRoTEJk?=
 =?utf-8?B?WTljRG9rb1R1UUZ4R1RhZTdXZWZwaVlyMjUvZzJwTDVueXBkZW9TZlF2YWt6?=
 =?utf-8?B?T3dvMmtLU1BHUytrSVJtY1BLYmJPVDY4bE1jMEluU1FGZ0w0SWM3UDhxWWxD?=
 =?utf-8?B?YTUrRlNLY2hUMlJQSFZsYWNWbmpwclorNy9LbHBIR20vOForWWI3S1lkWnVp?=
 =?utf-8?B?S2JQdW9LQTFFQ3o1ZDdDOUpPMVR4c0xIQ0pZaDdhK0hYNHVYdTQ4SnVlMHlh?=
 =?utf-8?B?cElJYWUzYnYyVFhBZFVjclVLRG9kdUtOaGRsSTdiVmlLZVdTWStKWlFYYWFn?=
 =?utf-8?B?aFhheGsrSkZOejBwM0h3SHlscTc5eTduVXZtNGVTekxFeHZ4cW5Vdm0zeWhU?=
 =?utf-8?B?V2N1S2hvbVNsbitFMVd4SXllVFl4UWJacUdMQzJUQ0pkbnNVUDFvN3VpZVBP?=
 =?utf-8?B?NjBSVFcraVFZNEYyaGtsUTNIODJRVDZ2NUlxMEpjdDVwQ1hJNmV2Z29DWUZE?=
 =?utf-8?B?RWczMHlpNFdxLzZwMTlHUmhHMVdyckdHSFVJYU1ZeGVLRkt2ZWl0T2NRbG1s?=
 =?utf-8?B?ZjBpdjM4aUFJV0ZRbG5UaHkzYnhWd3J1MFQ3bW5na3BYQ0YrTkxCYytaY2Jk?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D270A67E1B0449428380F3211D664FA0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wxGY1MFok6AfpuSrC9wavnFdjv90VhmfIKkb9p2foCgh8yTIqrVqJRVEvODVW9Dde1n31M/6iQXpyu22QEQzRGu64Oet6vk8ieM3edMQUWMhPfFlri0OanLVqWRGuxlF8XTyXslaDza8w4vBsqy7PS5/kfeo0pMODx6xhSFVm3wJ4bMmCcK888x1SUJkR8QJHbototdzR1nbH+9j6ueylVcIvOs5L3w734NM0A8hIjWvfyltVZro/AnIMhH15fp/uKemeqmRgxNKPqJfeMCoLdn6TZ9kYceoFyaZTswSDyHdYQewuCQQzwWuNLGkFwf1/kOxJTKjgfs3n5CI+Iiq9mka7yjaF53Bo9Zo/VJcYrGrdjoXd4eaqLWruKl+cfG/m5hgRMiH0LR/75PuufP5JccKRV1ZTGGc07yPxamqlcTgumeLrpMasqr23rGGXci3QdB+SAxdZzhnD8yuyX+mm04JnxDgyHGA22Yh2+IBoSKn4JB5sVCPRbELjkxm9TZUJ1uancAuuctFehS/+Y1ZQ2dqY0ncqZ3Ad83tL5ITaH+n0BUZYIX4BpaeVjQPDhQcuaHOlEAVrLdRE5o2wJgG6DA5RMMQXByqfb7Gw1lwfjGwanBxxrlPNe/lfC9D2RSx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3a3eec-41cd-4530-fe04-08de2b37ae5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 08:58:48.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KIAjWwi6UnBL6dl5pUmKO82B5Jtl3nPrO1lQCl0IPg51KTi5LoWOUTOlNWWiWoJCXflaSJxSyJUEME2gMeeVteWYP6z2P3F6EUhDQURzgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7214

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

