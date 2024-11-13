Return-Path: <linux-btrfs+bounces-9583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FC9C6C64
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9544C28BCA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C61FB8A5;
	Wed, 13 Nov 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c8Sb4eyq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p69Bl1MK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E81FB88C;
	Wed, 13 Nov 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492526; cv=fail; b=s3pBoArtjgcUFbsYpzxOhxYyRAhgKhHG2omKnJwEwR8Afj3gE6REE2D4Dp07uTb49uFu/0sf8NT3n3InzkKPBpNZ+NeVMmuM1KPblvrJR4+AVB/x96/w7ntUnvpKpjdPkt1ZVEPLvOsvkt90WoEMAfkvQU8f9KiLpM4/lObAaj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492526; c=relaxed/simple;
	bh=A8oY89SgHQtzi8PeQL1cHS68t1rgTIR9Xf09TstDP8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EWBPyiZjHu1HW8K5BLO9CrEprxHbwjb4zSszpfA2S9GwguoP1yZnAi/wzyhJTbZos5uAwlyK5/Kp8Yu6loUMymGoFk6ge8XUzbS+eBTZWUX0kTMs7PFulWkzzahx1YmpdPJozv7h+GotutyKt3WujnqdJWlUfpwle3Tua9tUFtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c8Sb4eyq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p69Bl1MK; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731492525; x=1763028525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A8oY89SgHQtzi8PeQL1cHS68t1rgTIR9Xf09TstDP8I=;
  b=c8Sb4eyqJ/MUEh9nmFzKKU4esO+h617J2dk2YDLljK7ysDsf+32XI4Ai
   7DHjNHIfBaI27lLJEwkpmwOd4mohadQdaliToO3cTPFla3a0/GmZjQaEk
   M9gelhiK8ccweRyLI7n+3+t1XakVA8m06iHYWqEnK83p4+wvnwQ3yrkRC
   dm3TRnYEdA4JmPCYsSNv7CsRH8fO38Xt86FJpiN5/OfYWwrShuE3jzlkV
   rGDyQdq3D4PYPCGBhmGztu1ApVZ8ZtiMecgE0i/637+zFVmShiHOJ+7WV
   0HSrugikfMzIsTabNoESPAVSn7pLgoVrlU0MdrSnUPF8yD+oLN3KRB4l1
   g==;
X-CSE-ConnectionGUID: BS/9K0o8ToGjwQWkQA//GA==
X-CSE-MsgGUID: 2+OJ1m67RnCLxT/PppyGNA==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="31456461"
Received: from mail-westusazlp17013079.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.79])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 18:08:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlTorEpAY7HP8BYzQrbY8QOXEADCIiTcC8yxFvc6k6VlWBFTZ+Jd4urGz5LqFEvIUZIGJGbJFfnDl6gAmrt9Qf3MkJRttdOHUdh8Zn0AXvasHdEBL2h7Hz7PhcBMda5SwxrCQxCm4KVnKyzck/EwU7PShQBg7Mb3WCNJdIpbYmY5LVE9ApRRKz3j04KuTi3X5NZw+ITDOdjqrb4owJ7EL8q0WRfCVl+YoWua5XjuBMX3I1ADae/8QyFPbMBLRbRN+z0U53AUP0NM2lJt8siQNndiuEncyaISayskX2A0bb59pIVqGznw9ht3dXICczkpslrvad5TGOzxqxiQ8Z5bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8oY89SgHQtzi8PeQL1cHS68t1rgTIR9Xf09TstDP8I=;
 b=m/37y6IM0kHlTKPv14cEVSghut5EjkwUXaQVltbOiYK5BsD8kYJbZMrjuV6sLuR9TJaQ9JeLqeiXQO2MCccWt0DpMyeV3rNDzkutREW3V3T6LawR0p37Rxmp92E4foXW2DQuFNlNTpjnU6mFX0FOrMMyG/YlGLidEXb1h3q7G/ltydO0rf40FAoyHgpVrYSHwh0OAqMhs8eOA9XuSnBSsyZxJcFY9sK0tm7ll+ZYlq+J+VyFlDcXweg75+dn4imw/jICYn+h99+AHbJ9IOvX28jytfUUYpCXDfeXLX8K3WnMUf4o1Haf8+2G/nueO1mSP3ndUuLftZfy3l1fKTSaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8oY89SgHQtzi8PeQL1cHS68t1rgTIR9Xf09TstDP8I=;
 b=p69Bl1MKR4O6SdiLzaPsM9PF4ANTqcAr5R064jcA4awLplUzqThOrobWaM1GgbxNQmYg2tSXKGPEcukrADXfyFfXfsUG0AFTdh7en4UqiM0a81HRLHHmEKjrtTPwVc0LNUWsShKfYFTwxYIxQ2u2/OLAT97J5LepxnDRXQRFAqs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8474.namprd04.prod.outlook.com (2603:10b6:510:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 13 Nov
 2024 10:08:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 10:08:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: John Garry <john.g.garry@oracle.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs: handle bio_split() error
Thread-Topic: [PATCH v3] btrfs: handle bio_split() error
Thread-Index: AQHbLrMPs/PyEfgkbUuiv5UfyUGH8bK1BbcAgAAE5AA=
Date: Wed, 13 Nov 2024 10:08:36 +0000
Message-ID: <d892421f-3ecb-428a-b65e-4f0d0f5f08fe@wdc.com>
References: <20241104121318.16784-1-jth@kernel.org>
 <9eec1ccb-6e56-4701-83bf-3397d1bc5197@oracle.com>
In-Reply-To: <9eec1ccb-6e56-4701-83bf-3397d1bc5197@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8474:EE_
x-ms-office365-filtering-correlation-id: 1aa5e302-e066-4b8f-ac27-08dd03cb23ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmlQSmVpTnVBTEV4L3VDdWRqU1VYTVBrNjZUZktQV0JBV0VmTjE4OFlXR3J6?=
 =?utf-8?B?R3dFZTEzUE9tSUZucUg1ZEdNSks4aU5ZSDhHSkpQRUt6bDZqanVESmF0OHh6?=
 =?utf-8?B?T0FPZHFnT0JodXlPMXlXNG5RZytjcllONzROUHMyNUJRSDFtK3ZoWmxYdlBv?=
 =?utf-8?B?eWM3VDBFNHZPc3hOWVIwRmhNSDNSbHU3dWozK0dzdUdvOU93ZFI0bEU0NGlN?=
 =?utf-8?B?SzAzamRYWmdyRXBOS3FuZG9zRWxxaGs1UHFSNFZXS3FjdmdmNE5pYVJpcmdC?=
 =?utf-8?B?bGFLNG1TM0UwcWtuRno1V1BpMUMyZnN5bXM0RVhjaDdocy9qNXdmSVZjWjFk?=
 =?utf-8?B?MVZtT1grbGJoVG1qaklXQ2krTWFvVEc5eHBxaHZDKzc2MEcxaUVCU204RUg1?=
 =?utf-8?B?a0wxaDFXSkJWLzJzNnlYd05VVEk3SnpxZlhPemtxdXV6eXVDUnhEUk9LUk5s?=
 =?utf-8?B?UnNmMmVnclk4NTZNMmdYQzFjSW9BMXpqWmRYanJENTVzSHlHTWFFNW1nL0lL?=
 =?utf-8?B?RjYzRlJuNWNxN0NjUkJKZk03d09ZeEE3T2hkYUpkOHJIRkRxVE5FZmdsdHR1?=
 =?utf-8?B?QVpmbEZVb0NGdmpSYUJrK3p0eFJ6M1dWV3dzbGo3eW9sWUM4a25FOCtuT1A3?=
 =?utf-8?B?YTFYeGVxM1JhSzdCTFJaRCthKzVnSS9iWTd5TSszcjBkQUxYSXdKa3FEbUw1?=
 =?utf-8?B?OG8vMVZpZlRQVFo5blJ3YjNONkhodWMvUkQrOGdSdkhPd2NVQndBMmovejhC?=
 =?utf-8?B?WU9BMExvdnI0YzkyOXFiekd3eWR4WHNqY2NwV2Q5NUE1cHl3SWJtMElBL1R0?=
 =?utf-8?B?cWE2ajE0enVpY1BtK2ZENStySTkwM2JoMmlQVmpISjAvVW9WazZ2MVgvaXgv?=
 =?utf-8?B?QnpTaWJFVGdad2ZCQ01ranNrYnVIYVFZNStBdW11YStTa2prR0dmVUVKUFlP?=
 =?utf-8?B?SElCZEUvTVllS08wVHZOeGFuNTZyVFFFaTR5cEhUd1dEZExyRll6TnJ6SlRR?=
 =?utf-8?B?VzZkMSs4ZG9sL1JGd0R2RnI3U0UxYkI5R2tadzdSa2txNENFNWQ3QVhRY3I1?=
 =?utf-8?B?citIOHg4N1U3bEtwY3duK2wyVjFhQ0I5enRRWjUvdWR1SldkMmdnUWZMcGxt?=
 =?utf-8?B?SUEzd0pweGFUVktwU1ZQTitNNEs5RmtpdlgwYy9yOUFNK2dYSFl0amlyYW9k?=
 =?utf-8?B?QW9WZk5nYWlmdGlIYUIyU1RBd09KS1QxNDJYOTdkNGZaK214SlR4UjNqeHIv?=
 =?utf-8?B?a2RVK1JlNVF1YlU4VFRHOTduZWtadElFZTNYcDNNMERJRHlXdFpSZ0FqZE9U?=
 =?utf-8?B?NGhtc2MycXBKVElwQ0JKK2R6M2FiTEpXOG5pUStrdVV3UTVHVGE2TFBibFRJ?=
 =?utf-8?B?ODdwNHJ5a01tMCszNit3R1hmZnpSVnhtbHhVc0hsNGV2RVlQRlJWOGgvbkNn?=
 =?utf-8?B?S2dDelgrQTV0U29iMFB2TmpmSzRVQWZoamE4eEkzdGZEMEtJNVRQaUdPeTFM?=
 =?utf-8?B?TndibklNMGxGUXVWd2RkeGpzZWFmVzZmWFV1MFN6aXprUUlDR0M3azV6VHVT?=
 =?utf-8?B?SC85NEM5KzBSNTBUOU9PVXREU2RQS1RRYzQ3cVZPUzBEVkZKSHg2RXNNK0NW?=
 =?utf-8?B?ZVdONWY5RmxHYjB5eFNGUkxFaGVxaFkwOVN3S2hqTFZjeThYcXB1WXVvNloz?=
 =?utf-8?B?Y2dsMGRIWUxBYU5YQ0RrTXdMWFZpeGJwN1FYYmNJMzhkQURuUUFYL210OHNV?=
 =?utf-8?B?K2M5T0pWS3RKYTd0eHFheW1ucTJYS3ZZSC9KSlVjQzVVd20wdm5DYjBwWVd3?=
 =?utf-8?Q?siwjYQbT+w8P/PcYqsoOF2Uc3umAyUxl4GbV0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzdOUFBaT0J6WG4wSWRwS0hLelVKajU0WnhSbjI1NHBxU1FxQk1SeTFaNVdZ?=
 =?utf-8?B?OEJ1dUhlNldxbnlSR2o1Wmp1eEVGMXJZMlh3bUhrZ2JjV3Z6aVpENUFUNlc4?=
 =?utf-8?B?aXpxWjB1ZXovS09JNS8rMVg2ODNMNWtLU0hDM0pYYnV6YWZ1ZDNnbFdaOG1C?=
 =?utf-8?B?VW1jMm52bHFkT2UrT05CZElSWmM3R0tyOVVJWXFXcUlqYTl0b0NiT1FIazd3?=
 =?utf-8?B?LzBjQ2ZLbU5HRjcweEpNOGUzcU9Cc1BDZ2srd2pvQ0IrQkRXQnFNQXJoN0V3?=
 =?utf-8?B?cnppbmVub1k2czdKN3VtNlFsZXlrWndXOWcxZDZoWFlEQmNNVDBZZkVHRnlo?=
 =?utf-8?B?K1pXQ1c5MmxNWkVJaEVIa25IV0dTK1AxRHdhUjlMVFppWFRnNjVMajdrd2VG?=
 =?utf-8?B?LzJ6REVWbERPb2VKSjFFNFNsY05WU3pjUjYwQ0tvRmFEcnRJQnpET1FiMlZF?=
 =?utf-8?B?eTk1U0ZxdStESkhWTjFmZjZLb3hYWlNHVmNHdEx5VEV0V1AyYXErcTI2ditI?=
 =?utf-8?B?eHNjNGlEYjUrTHJhQUFnQzJ1R1F5dlNNZEN4STdRSTQyRmo0LzF3K0hlNTZU?=
 =?utf-8?B?UkNUUFRIMlF4UE1lL3ZwQmd6U3hUVWZlNEFMeWl4TkQybWhDNURDT0FtQjZu?=
 =?utf-8?B?Z1dEOHZ0bzBqbEQ1TXV1am85UjlvNFU3SG94RVAwYWxtMjhqS29TZGl6ZnJK?=
 =?utf-8?B?ZGNxYkxtK1BCM0F4NFMzUWxLVVhxVGRxTmpabnM0aXBIenNKbmhzNFA0djNC?=
 =?utf-8?B?S3BQOTdnVnNQSHF5Q2dKSzR5b3VkNGVkOGg4ay9WN05XWHBqUStCZUNuRFlS?=
 =?utf-8?B?NWhZNTlnSUlkdWFtZkN1V0ZDT09oV1lXWEhoazdOVmlOdWZWYm8wa0NvcEZw?=
 =?utf-8?B?NmNQelAwT0JwZHRzK1lwOHYwaHBNMCtFMlhyV21aeEdUTnpqQ2x3RGNNbmps?=
 =?utf-8?B?ZHV2K1ZEelB1Z3JBTGMrTUJoeG5NNWZXU1I0bEczd3krTTYva1ZQQThLUmJY?=
 =?utf-8?B?V2liRitmS1c5ajBjVm4rcGNUdHRRanpmYnd5ZW9RcStjak0rUnl2dVZtM1pZ?=
 =?utf-8?B?czRzRGRWTkEydzdDNmt2YU1QQm40ZlF5L2llckdLQWZZUm1Ob0R2QmRmdGFo?=
 =?utf-8?B?YTBQVkh6cFZzU2hjK2gxeXBFaUtGWm5RTmdTN1RnYUpVbENSZlhSQUtIVm5m?=
 =?utf-8?B?RTZRUUwxTFkybEpLbXhzemhkbTQ3L2NWbGoxb0dBbUsyV3NqdXgxTjVUNVh5?=
 =?utf-8?B?bGFXUHRTTHBVQjNOanlybjljNWxRMG1JZDFCSC9ibzd1UFAxVWJDRmpSKzFI?=
 =?utf-8?B?WVp2NkFESUJaUGh4bUVCQnI3WDkwcmpFVXZ2NThrbXIrVDhuRTg0YWYrUkJJ?=
 =?utf-8?B?TWY5ZTZKZXhCSEF2KzVHV29KV1ljMndVSUpwNmpoS29MaE1uUTdwcVVoaThp?=
 =?utf-8?B?eldpK3pBb0NvbFZqY0NTU1NPNFliTTBiUTMyMnNoNXM0bWpqa21haE1WcW1q?=
 =?utf-8?B?dnpob2hOaENLSDJoaWtGYmUxalkyenlyR25BT1BaMDN4M3pUZ0lxSmJ1NWR3?=
 =?utf-8?B?Y3FaN1lrUlRob3ZXN3dueHZRMmY4VnZGRWRYUFkxaW80ZFdDZkxkQ1k5SHFQ?=
 =?utf-8?B?U2hKbW5ENnhpSGg1cFJzZDNPeGs0YWg4TGFRU1FBbTJQQ2psT045blpFUUhs?=
 =?utf-8?B?bnJBQkhEK2pvalJxdVVXOHFBWWMrSVI3cVNZRExvNlRSeVIveS9ETW1FTXJO?=
 =?utf-8?B?cmRUeDZ5enVPWHl2cDEvQ1QwMTBPcC9VaXFYcjNhaS9jc1Q4dWNpVXBZSXV4?=
 =?utf-8?B?YXNORklSZGlKRXlkcThtSFF5VHZ4RkRhUTE1a0VyYzNQU2NVbDdBNkVyOG1E?=
 =?utf-8?B?K0hldlJzcmFXOTF2djJ5SlJuaWNKaUhGWmdGR2JaUmhicm92L0c3bldtWnI3?=
 =?utf-8?B?b0hwak1oUlVWcjZ1WkhQQk5tR0gxaDBYVitVbWxkU21DSGZjWUpZbnB2NTh5?=
 =?utf-8?B?blpIL0Q5TUhaeVNTcnFJSUtWZWYyaEZXbWFaZDhNQlVRV3E3R2hWTXFZQ3Fi?=
 =?utf-8?B?WXBzVXdBOUtwSDBrbnN4d09YNWVwS1BmWnp6N2x2L2NnbmdWRlRvdklFVmhi?=
 =?utf-8?B?cEFrajJpcVhwMjlMUldVTCsyTWtPV0lTMGRSS0d5ZWljQ0gzR1VTQXh6T2NN?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB79108B7314C34E90E1BFB95B184EC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	taPYuiy0ZIQIQtccwUaqao/BLFEPX/qOizb2orhfurWiQ7RMvVFG9AX3bh4WrjKp5RVI/Bm+bg9/vwqO0HX+l92UR64527LKxn9SYTVaxabi0npdBrucke9LF5NBtg8GaA0xrEqMnIFFu2mQhP12Mi4sRG7BTPLrf0NAdCPITEHnbTnBn76hb8rURm5313/0XFy6NZ0Wp7UYD2+h07RUmw7vBqtXD7DxD7iDyzfKEUz7Fcjy+i9CvxHGv0f5GZb6zYPqq1OuHzXsxVx2K+bYJczAoJQSw0d3KFPrVrLLCrZXTDehsYRkfzhhnlgkvqoEVYNOwb+ytZ9Swx48b3BtssTchmJDhMBd6DaEXGyT5blMtiV3C/PjsSwm7telQUUExNPotEgU86muG4pkUHl0bt2Ov1R6SCN72rW1Ih/jct/G8UNxdx58izRaKnbsDFJw41qZ+p99BUMLZKhmINfK/Ib4esUtuHqF/H6dKfwpnEa53+9shhbiUMmzvWS7zXs7lWnRBRj/QATCmgFkOod/FSeAns0i4zkizIvwMSphJZS13QJoodKmgC41ENsg+MqbVJSIskvcgS5laptrMJOaKO3cdDONQQJMngPc6gOJaCR9GeYr61k7ddBaNYZxpFit
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa5e302-e066-4b8f-ac27-08dd03cb23ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:08:36.8355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFs5oTlya3/CFTcAxO/YH3NSR7pvHfutKOKhu4OCOnuSqkfr6ROPC/j35vZ42go+ITlb3glHnflN30tqpsBWaHzfAtMvgto95K3MkXQtTPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8474

T24gMTMuMTEuMjQgMTA6NTEsIEpvaG4gR2Fycnkgd3JvdGU6DQo+IE9uIDA0LzExLzIwMjQgMTI6
MTMsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IEZyb206IEpvaGFubmVzIFRodW1zaGly
biA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pg0KPj4gTm93IHRoYXQgYmlvX3NwbGl0
KCkgY2FuIHJldHVybiBlcnJvcnMsIGFkZCBlcnJvciBoYW5kbGluZyBmb3IgaXQgaW4NCj4+IGJ0
cmZzX3NwbGl0X2JpbygpIGFuZCB1bHRpbWF0ZWx5IGJ0cmZzX3N1Ym1pdF9jaHVuaygpLg0KPiAN
Cj4gSSBoYXZlIGEgY291cGxlIG9mIGNvbW1lbnRzLCBiZWxvdzsgSG93ZXZlciwgc2luY2UgSSBh
bSBub3QgZmFtaWxpYXINCj4gd2l0aCB0aGUgY29kZSwgbWF5YmUgdGhleSBhcmUgaW52YWxpZC4N
Cj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IFRoaXMgaXMgYmFzZWQgb24gdG9wIG9m
IEpvaG4gR2FycnkncyBzZXJpZXMgImJpb19zcGxpdCgpIGVycm9yIGhhbmRsaW5nDQo+PiByZXdv
cmsiIGV4cGxpY2l0bHkgb24gdGhlIHBhdGNoIHRpdGxlZCAiYmxvY2s6IFJld29yayBiaW9fc3Bs
aXQoKSByZXR1cm4NCj4+IHZhbHVlIiwgd2hpY2ggYXJlIGFzIG9mIG5vdyAoVHVlIE9jdCAyOSAx
MDowMjoxNiAyMDI0KSBub3QgeWV0IG1lcmdlZCBpbnRvDQo+PiBhbnkgdHJlZS4NCj4+DQo+PiBD
aGFuZ2VzIHRvIHYyOg0KPj4gLSBhc3NpZ24gdGhlIHNwbGl0IGJiaW8gdG8gYSBuZXcgdmFyaWFi
bGUsIHNvIHdlIGNhbiBrZWVwIHRoZSBvbGQgZXJyb3INCj4+ICAgICBwYXRocyBhbmQgZW5kIHRo
ZSBvcmlnaW5hbCBiYmlvDQo+Pg0KPj4gQ2hhbmdlcyB0byB2MToNCj4+IC0gY29udmVydCBFUlJf
UFRSIHRvIGJsa19zdGF0dXNfdA0KPj4gLSBjb3JyZWN0bHkgZmFpbCBhbHJlYWR5IHNwbGl0IGJi
aW9zDQo+PiAtLS0NCj4+ICAgIGZzL2J0cmZzL2Jpby5jIHwgMTUgKysrKysrKysrKysrKy0tDQo+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmlvLmMgYi9mcy9idHJmcy9iaW8uYw0KPj4gaW5k
ZXggMWYyMTZkMDdlZmY2Li43YTA5OThkMGFiZTMgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9i
aW8uYw0KPj4gKysrIGIvZnMvYnRyZnMvYmlvLmMNCj4+IEBAIC04MSw2ICs4MSw5IEBAIHN0YXRp
YyBzdHJ1Y3QgYnRyZnNfYmlvICpidHJmc19zcGxpdF9iaW8oc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8sDQo+PiAgICANCj4+ICAgIAliaW8gPSBiaW9fc3BsaXQoJm9yaWdfYmJpby0+Ymlv
LCBtYXBfbGVuZ3RoID4+IFNFQ1RPUl9TSElGVCwgR0ZQX05PRlMsDQo+PiAgICAJCQkmYnRyZnNf
Y2xvbmVfYmlvc2V0KTsNCj4+ICsJaWYgKElTX0VSUihiaW8pKQ0KPj4gKwkJcmV0dXJuIEVSUl9D
QVNUKGJpbyk7DQo+PiArDQo+PiAgICAJYmJpbyA9IGJ0cmZzX2JpbyhiaW8pOw0KPj4gICAgCWJ0
cmZzX2Jpb19pbml0KGJiaW8sIGZzX2luZm8sIE5VTEwsIG9yaWdfYmJpbyk7DQo+PiAgICAJYmJp
by0+aW5vZGUgPSBvcmlnX2JiaW8tPmlub2RlOw0KPj4gQEAgLTY3OCw3ICs2ODEsNyBAQCBzdGF0
aWMgYm9vbCBidHJmc19zdWJtaXRfY2h1bmsoc3RydWN0IGJ0cmZzX2JpbyAqYmJpbywgaW50IG1p
cnJvcl9udW0pDQo+PiAgICAJCQkJJmJpb2MsICZzbWFwLCAmbWlycm9yX251bSk7DQo+PiAgICAJ
aWYgKGVycm9yKSB7DQo+PiAgICAJCXJldCA9IGVycm5vX3RvX2Jsa19zdGF0dXMoZXJyb3IpOw0K
Pj4gLQkJZ290byBmYWlsOw0KPj4gKwkJZ290byBlbmRfYmJpbzsNCj4gDQo+IGVoLCBJIGFtIG5v
dCBzdXJlIHdoeSB0aGlzIGhhcyBjaGFuZ2VkIChhbmQgd2Ugbm93IHNraXAgdGhlICJmYWlsIiBs
YWJlbA0KPiBhY3Rpb25zKQ0KDQpCZWNhdXNlIHdlIHdhbnQgdG8gc2tpcCB0aGUgJ2lmIChtYXBf
bGVuZ3RoIDwgbGVuZ3RoKSB7JyBwYXJ0IGJlbG93IHRoZSANCidmYWlsJyBsYWJlbCBhbmQgZGly
ZWN0bHkgZ28gdG8gYnRyZnNfYmlvX2VuZF9pbygpLg0KDQoNCj4+ICAgIAl9DQo+PiAgICANCj4+
ICAgIAltYXBfbGVuZ3RoID0gbWluKG1hcF9sZW5ndGgsIGxlbmd0aCk7DQo+PiBAQCAtNjg2LDcg
KzY4OSwxNCBAQCBzdGF0aWMgYm9vbCBidHJmc19zdWJtaXRfY2h1bmsoc3RydWN0IGJ0cmZzX2Jp
byAqYmJpbywgaW50IG1pcnJvcl9udW0pDQo+PiAgICAJCW1hcF9sZW5ndGggPSBidHJmc19hcHBl
bmRfbWFwX2xlbmd0aChiYmlvLCBtYXBfbGVuZ3RoKTsNCj4+ICAgIA0KPj4gICAgCWlmIChtYXBf
bGVuZ3RoIDwgbGVuZ3RoKSB7DQo+PiAtCQliYmlvID0gYnRyZnNfc3BsaXRfYmlvKGZzX2luZm8s
IGJiaW8sIG1hcF9sZW5ndGgpOw0KPj4gKwkJc3RydWN0IGJ0cmZzX2JpbyAqc3BsaXQ7DQo+PiAr
DQo+PiArCQlzcGxpdCA9IGJ0cmZzX3NwbGl0X2Jpbyhmc19pbmZvLCBiYmlvLCBtYXBfbGVuZ3Ro
KTsNCj4+ICsJCWlmIChJU19FUlIoc3BsaXQpKSB7DQo+PiArCQkJcmV0ID0gZXJybm9fdG9fYmxr
X3N0YXR1cyhQVFJfRVJSKHNwbGl0KSk7DQo+PiArCQkJZ290byBlbmRfYmJpbzsNCj4gDQo+IERv
IHdlIG5lZWQgdG8gdW5kbyB0aGUgYnRyZnNfYmlvX2NvdW50ZXJfaW5jKCkgKG5vdCBzaG93bik/
DQoNClllcyB3ZSBkby4NCg0KPiANCj4+ICsJCX0NCj4+ICsJCWJiaW8gPSBzcGxpdDsNCj4+ICAg
IAkJYmlvID0gJmJiaW8tPmJpbzsNCj4+ICAgIAl9DQo+PiAgICANCj4+IEBAIC03NjAsNiArNzcw
LDcgQEAgc3RhdGljIGJvb2wgYnRyZnNfc3VibWl0X2NodW5rKHN0cnVjdCBidHJmc19iaW8gKmJi
aW8sIGludCBtaXJyb3JfbnVtKQ0KPj4gICAgDQo+PiAgICAJCWJ0cmZzX2Jpb19lbmRfaW8ocmVt
YWluaW5nLCByZXQpOw0KPj4gICAgCX0NCj4+ICtlbmRfYmJpbzoNCj4+ICAgIAlidHJmc19iaW9f
ZW5kX2lvKGJiaW8sIHJldCk7DQo+PiAgICAJLyogRG8gbm90IHN1Ym1pdCBhbm90aGVyIGNodW5r
ICovDQo+PiAgICAJcmV0dXJuIHRydWU7DQo+IA0KPiANCg0K

