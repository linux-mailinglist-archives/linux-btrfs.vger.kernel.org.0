Return-Path: <linux-btrfs+bounces-9061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833039A9F63
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D338281E35
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03819992E;
	Tue, 22 Oct 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IssweJjh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XHy+KK8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E481990C7;
	Tue, 22 Oct 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591020; cv=fail; b=ajtWpPQ7sJbBMMBGChoP7EOMRdrdC7Sclgw9oq27G41Q2UrecZqf9lPYkKwz2EY9JguVW+nNuUY8Qm9u7xmnuXAt1u2spTGRclSgrxvZuDrRR3/Ziwap77q6O90gtinavbufWIsFy/C1Z2hzoMGBsdYlfyecWqxaxF+CwNZ7kFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591020; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WuTFDMeEi0hHJjF4HIcZwj7Y43K7Frc0PzFgTgVyloZYAziS8k9samuuiStZUttVl6aPLb9Z8l6zEywZLMizxRvHnbCa0A1HWZ1/dIqEXLqYbqMFzOQq1C6jS32KA7Ao8a3Hz3Lzn/ACrmhLVWWfddK4liMc4+f41mu4DXSap1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IssweJjh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XHy+KK8j; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729591018; x=1761127018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IssweJjh3GyPZt315JrOHzcuU/YQwDM/HIATse9k2EUk75Avudi4Z06p
   1gDeRzxKe74JrIgi56MOeeJr8smzeZzJMaQLo9z+/dlMRPJqexG80uCTi
   4NL9MQ1jGzpwZzu22nEXJwkY+PuSXD3rGNY5Dwa7l3PAB9L0bBLYpCNsW
   v2qUZqUbg9aEni7lt//HyLVv5bQEiecWKIvvnPepJMYuFYu6P/8ZNUkhi
   Iw5c9oqJhXNkUYqdzMx1nb0WCZyO2DrrkGni2YczWdvt96VXfWULo/Wby
   k80zpF6NGuV2VcyfdTdv8e6ofa0reHZ9EKuInczGQIzhhrgNllPq7ia//
   g==;
X-CSE-ConnectionGUID: we6v7BP0QkK5nLZejv82/A==
X-CSE-MsgGUID: ezadN/HORdicJHD6mAOUOw==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="30543023"
Received: from mail-eastus2azlp17010019.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.19])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 17:56:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAVWNJImItz9q5NbfTw4zN1GmNEJYIH2ivWer6zlNLPth7cM90deNkMSIkSI6ayLRe8ofwU20VJKuyFKCx3Nx/oinod44Vf49dXlsgScWhhojothq0QR3BpcZCRLZImWYe0BSBl6JAb2+itRwmKkzff/n6iTeQY1B7d9R0xExLWGVgOTg9COeaNeT/vHmFVggCOzKBsuGhK0M8TDm2qRwdcaqzDaIiEA8h547MVQVvko27Gusl/SjZE+RG9jiha56LFn1voX4efugh8NRK73yirpyZfUgdNUGfnuRh/s4SUHGdAmH1+1Qh6hy+1zOscziMw5gXrcZdPX+LAw4mUw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YoApFTXDb8sJB76/7R/UioQ4GYPR6fGO2mCwEZV11elX2nF6Yem/0EO42dVn/lICuDAutigMnvGRV621/5JjOfaiXBEC3k7jpDQsjV9arXZ3GdEZ+A63pC1qTNR7evjpDki6htqUyZaJ5USlvEAoiMuyUKjc/LVurtYOkstNFw1IT+5gzQdZmOv4eirDau/SVYRCLkF/tineYUw/y41259/wGEOKrqdbQjgD6DIs0RKriRVTgWR4BTKbfXWU2EHzeB4EYrsaf8sxNA8qrdPShir5slq+9uHhUFp+3pUld6amPUQK23Ly+kUGWhiow5krjMpPlYjHL1JVGvcQ4p1IcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XHy+KK8j2Y1k7iRES47lBy77xe8Eq7biPyECreXs75j8gbVyVny3o3UnztBvjqs5kt5iSyxiq5k20L4RzOEURxTCNFiCLp6hwIZJKrZtk3pLiHrJtSv30E1IXYoPgmUPrJy0Mpy8fS1kH/u8rNMbYCoGEzciQXQ8NofVBTHpdc4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8889.namprd04.prod.outlook.com (2603:10b6:208:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 09:56:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:56:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yue Haibing <yuehaibing@huawei.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>, "mpdesouza@suse.com" <mpdesouza@suse.com>,
	"gniebler@suse.com" <gniebler@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Topic: [PATCH v2] btrfs: Fix passing 0 to ERR_PTR in
 btrfs_search_dir_index_item()
Thread-Index: AQHbJGW7PGlhMIIU10+67dlmFP11h7KSiKIA
Date: Tue, 22 Oct 2024 09:56:51 +0000
Message-ID: <7e62c539-40f0-41e5-ae71-cb68bb5eec03@wdc.com>
References: <20241022095208.1369473-1-yuehaibing@huawei.com>
In-Reply-To: <20241022095208.1369473-1-yuehaibing@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8889:EE_
x-ms-office365-filtering-correlation-id: 6bb15d99-cd8b-483c-68f4-08dcf27fda01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjdPZWU1bGtWUXJYaks4TVVOSjNPb2dEUzNjVUx4Um5RNExjZ2dHenlUQysv?=
 =?utf-8?B?TUlKSDNrdkFJc1M1L2RIZHFTQTd0QjlDOG80dEtucWNnL3RMdmx1cGxkN1Yx?=
 =?utf-8?B?UERVQThoeFBtdDBzZmdpUnl2dTdVckU0a01aZ2FobVh1czlZK282aUZjc21m?=
 =?utf-8?B?U2FKd1JnRlRwalg1RmMxa0hlaVNRcEhIUEtBemdKQWdiaHZkTkFzZjdrczRq?=
 =?utf-8?B?QndiSFk5WUx2dmFhbFZCNGI1NVdYSEtJZStxZ3czb1FNc2VTQUxYcjM4VjRX?=
 =?utf-8?B?ZHoxNjkwc0VHWDV5UExUVDlBaGlURnk4ODBhdHpxSmg5SDZ3Y0JBQVdTZy9F?=
 =?utf-8?B?WmhnODB2Vnl3VkluQU54VmpGMWVCeUZ4UEFIeStFUjR3Vzd3cGdFZUgwbEZY?=
 =?utf-8?B?ZnJuWXdZUVZjeTNJallEYnRqMEU2clZNVHRpNlpiTHN0SGxEUVhIYThGUTlz?=
 =?utf-8?B?WjJCRzBIbG9ZQ2Y4TGlJeXlaV1h1d1FMOHpNbjlsbUFDcll6SklyZ2dGMzJM?=
 =?utf-8?B?M0xGeWk4SlQxbGEya0UxeFVQWWx5YUxTUDBpcG11ZzBIci9ZQXhDVFM5THVF?=
 =?utf-8?B?ZUdHR2RXNnF5YVZDTC9jM25iOGtnQ1VQL3pydjlYTEFnTHhoM1BJa05wWlFD?=
 =?utf-8?B?WmRpY1JEQ1FYYzErQldmUjhVQXBJa1dKTXlrd3VhN1NsaFpSSzQ4NVFNa0lC?=
 =?utf-8?B?dDdCNzJjUm1mNFFVOGZZYktqNFNzeUNLNjZTYlNDR2xpclJET1NUZVlKdUVM?=
 =?utf-8?B?U2ZhTktDbkh2dlM5NjNVeDY2aVdyUEJjekRWdS8zS0pKVnoxTDYwMStzbFJY?=
 =?utf-8?B?bHVYK01SU1FVTEpFbkJXQWFKMTB2aVFvL1hBOVUwVzRnd0kvK01UZElNQ3I5?=
 =?utf-8?B?Y2ZoTFFQcFlxcGcvQlNUcEVxcjJyZExrRTNkRVluV3ZoRmZHTjdiNFp3SWdI?=
 =?utf-8?B?Q2J0b0tNNGtId0FsTCtiYW1hbS9pRkUyNmt2ODRJaEdxMzNKR0Frc0JvcVJK?=
 =?utf-8?B?SktBUWFIZERjS3VzMVB3cGY2SGFoTW1BZjFYeTRndDQ1T0tLTHd1a2dBLy9U?=
 =?utf-8?B?QzRueVVqZlEwbDdqME1lYUp2cWRHMFdyU3NIc05wQ1UwUTJxKzZpdEtLbjVI?=
 =?utf-8?B?bXFHOWNGcFBnTXNJVHRZb283WjlJSVNmbmxnT01jVTBBbHdBaVd5UTJuMkpS?=
 =?utf-8?B?eWVUUkNyZ2xpRWFMUzA1S1o5VUpyVUtVbWdsVGc2RXZYOUlLajd2eTg3KzE4?=
 =?utf-8?B?REF4cnZ3SDEyVVl2QktWQi85K2tlby9jYVRYby9ZVWoyamZzdm0vdUdaU0Zs?=
 =?utf-8?B?cWxUUVJTVHZyTU1xL0V3STh2b2poSHB2Wlc3Qnp6MFBKNDdMVUZWNTlpaTU0?=
 =?utf-8?B?bzVQTEhsbE0vWWo0RWZMcnFvd0lIcGdDd0xIdHZWVFE4RzJhV0s2T1lFaFRl?=
 =?utf-8?B?bkNFVEdSWmRuNVhyUEJEYitZeEJSUlQ2VHQ1NGY1Zk54WHFPZmZCTVhEdWJq?=
 =?utf-8?B?aXRVMEFZc2xiTktUUCtqdExVOGlSb08xSlZ0QjZOVGI0eXdnT1B1SVNHRHk0?=
 =?utf-8?B?cHVOdk56cU43c2FWMWxna0xLZ0p0M2tPaEdwTjMvNVNmdWFWUTh1N1d6bnFB?=
 =?utf-8?B?b2c3NkVmNTFrcjZyOFViK1l3OTRwNHdUZktQbU5PMStxMnpZYUQwK25DL3lM?=
 =?utf-8?B?ZC9ERkxXWFVRWFdDQkFEb0V4eXV0OFZScHl0OFN5bjZWZGhheWdLMzcrV20z?=
 =?utf-8?B?R0ozNW1MQldLV3B2enE0a01lQzRNRmVtOHBCejBWTU1FUVp1U0JHZnlsbkxr?=
 =?utf-8?Q?BfUXxpkBb/g06XF3QyIw2Ci0QQDLcVDbv7Hl0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2FJRVFkYThZSTNCUlQrV0tBaFdYQkR5Lzh1TnVFMDZXTDliWXQ3VU5vWnVw?=
 =?utf-8?B?UTM4Qkp3V1ZoYk53SllaTWxLZXdaOFpMeE5talJZU2VUYThhelRrTmhFMkJn?=
 =?utf-8?B?ZnVETFFqbmVGa0o5RDZjNnh3dkI3T3p3TDJWUXdVZzhSZnR6RjNCdjcvU3Nh?=
 =?utf-8?B?Y2NVS3hCTUxjbis3dVRrVkVpaXJHdVJOUXd5dGdQbUFWLzRYckVYUGVEaUhC?=
 =?utf-8?B?QjVoZTkvbkxnTFdPVjhZRVpGVUlRSG5DQi8rbXhPYmt2UW40SDZTS0tyRWkv?=
 =?utf-8?B?R3FtWXplN0xod0JzeVBZbE9HWjZnYlNZeitkd0hoR3ZWZnlQNTlPekVUMWxY?=
 =?utf-8?B?ZUdWSmhURkVNUFJkWWVwZkdoTDJyT1ZjRkVhUUJQZHlRemZRN3lqN09ReS9R?=
 =?utf-8?B?SEJEb1dSTE1rcG9mOE9ZUlY3NCtPNzBqd293REhRMXVnajZEZHYvY245S284?=
 =?utf-8?B?ZE5rekZDWitZSFJpZndOZzh0eXhYRDJTaGc3UUd1Q0NoL0RNRGxadWFBdm9a?=
 =?utf-8?B?bHVsQWVyWTJaY1ZJOGJVdGcwTXB1dkQ5aHpJNGhRSTVWL2xZNDhTREJqRDlu?=
 =?utf-8?B?clRiOVpCSmo5aFplellwN2JFVC9xZS9NZnEvamh6VktQZlFHRTlCRlA3Q1VT?=
 =?utf-8?B?TDFGV1VQQ240eEMycnVyYU5vOFM3NndQaUlIRlBvdHFXbUttZDJTM28zNXoy?=
 =?utf-8?B?U2ZkajZkeXdIQm9Wbk5BTHNhUWQzNnRVL3MzYWdhVkZ6SFhNQm1ETjBnV0U5?=
 =?utf-8?B?SUtrVWdkT2hhYk04cHBOSzZ5Zit1M1FPMUZBSVExTlZuaGw1QnlPenppa3Ew?=
 =?utf-8?B?VEh2aXdnYS94ZkUrM0oxN3VRblp3NFJRNzZJb2owZEtqbHBZRlYyWkJLNkVL?=
 =?utf-8?B?ZFJBaWZnT3VDK25JakdLY3N5Q1ZiSWRiRlBNMG5lZWsybWlLcjhCWXVDbml4?=
 =?utf-8?B?RTFydE1kVmhnelVJd2dGbFN6STd2czQzVk91SDJuc1FRR2k4NDFzOEV3RzdC?=
 =?utf-8?B?UGdaeVFselRySEl6SkRNampEbVBPWWV2cWpVRXdXUnNVWXZJMWFsOWhqUUZV?=
 =?utf-8?B?ZWhlcWF5NWZLYVRiVVg4cWc3YStnMXl0L1NuL0FHNU1KaUxjSEV3SDRYN2dt?=
 =?utf-8?B?QmJvMlVhM3FWY21oUDlWNmk4WW80bjhnU2JFK0Y2Z0NPNjl1L0pVVHZWUExV?=
 =?utf-8?B?VUxzeFJNTVJ5a0FJNDM0Z05oRVp4SWQzemRvYVBFelVmODJZK2ZmYkhodHZx?=
 =?utf-8?B?Ym9CSmdHMXVXUHV3eUxNNityNzZxQzRLZ00zNFFyTHU2UVdYc2NiYnB4OXhw?=
 =?utf-8?B?OFA2YXFxN0lQbFZkR3d1TGRISDJLbS9hS2FwYjFEbHh4MWhFK2ZEWTgyZVlo?=
 =?utf-8?B?b1hzY0JOcXRaVkRKbEpnZlVGTTFLRFkwV3duK0NoajlpanliRGtPd1JoYXlZ?=
 =?utf-8?B?TVlqZ0xXN3loTHZUYjJrcCs5N2IybExDRGdxYm1mbVk2UThSNGNwVFV2SUtu?=
 =?utf-8?B?ODFveWxGZFc2dnF0UWdtNktrR2xyS2wxb3JMQmJqNm8xUkw4NWMzVmN3R1l4?=
 =?utf-8?B?aWRycGtMWW9HU2g2SDluZjJYMkFOaEFNa2d0eGhrUUdUWTcvVTY1K3FaQi9L?=
 =?utf-8?B?WTlOeTNWdWpDczg3aC9GbzliSG5uZ0ZRZnFQVThRQUpGMSszdWFkU2tNVklQ?=
 =?utf-8?B?NWYrNXh5V2RSaW8ydHVva1E5c2JEWVZYK3NlSXFzbER4OW1TRDJXeWJkRUph?=
 =?utf-8?B?NFplUTd3cjBkcnQ0Y0ZzdUJXNGFnc2djd1c2eGFWTkhsYWtydTBqTi9XaU8z?=
 =?utf-8?B?UEFJY2NIK1QrVTZQMWd4MHdOTm9zQVZtRkprVU9sM1J6YkMxUkp4c2Z1RGpx?=
 =?utf-8?B?SDdPakhpdmVSQTBVVzNaM0JrekJiRjhnd2dkOXhqVEFXSWxhOG55NTRib1FO?=
 =?utf-8?B?THpZR1hMcThWeWF3a2grbXh4NFNFZ1RXampEeVU4akdOQ09xeXF4QytRRTR6?=
 =?utf-8?B?aWFmUTd0M1JQYVYwOFllSk1LZ2N4a2Y4VGdHQ3VJY0VldlgvdGtHOVlKc1dL?=
 =?utf-8?B?OXNieFBVZFNZT3c1YUZUOWJoQlNYVWtsd2IvZ3dvcUwrZFlvY2JaUlRaZzUv?=
 =?utf-8?B?aExuN3RvM3ZVU2Z4a3ZHMTk2aW1tWEFwUkJyWkRibGZ2T0ZvdExvdERaK3Y5?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A89126C14E2164CB69FAD5660DC37B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MKc+EZ6qA+d5wOZI90JKUy61tmU5uDIQlSFdzJMgP1aSxZ1e0wsN7AtgIhYYDS77XbBB0iabUfsLShgERZcZJ0wl/FXMMm4A37a+xbdOLtnmYJZv2igQy/KxkR8x/YoDwTjNGr4BPp+lKrZGhhXMUaE+w9t6e+t0elVg1a0MZNmVYWPubJxEQnfK3Kr8mzjzurckx3dX2qSCcGWrjT1pGFjry4UZP15yI7YHJPU55HJ2/xN1pccteXb7TrrzqNBbhc7afVQ2J3Fs9kOWz55ve+2tc5EYA+UXxTXtIPARuGUOvUHbBEX1B/cO7d7oAzh5BV+ogp0MuMiyg0gzyLfvprEO4XdcQ0Cplj4HvWBVFa5HghBjMSDEXapBjx9LpBfq7cyPLAdkvJocLcl6CDQB2PjnmxDtc7PWDA8mu3LiXf+LicCjtP6bcxIZWaHCuaMeD0ZRBwzzOt9dbYvkpk36//LEeoGWgb3ThsdNrOG14NP19VYCWRuFcbtx3UH9yJZadrkdY/wVztuTQqMxsGWY2mNizZU/Q+S+FIBxDY81o/2XMS7OFEjZjvn3v2rFOP5gPmsHYfl3X2J+I0pVH3qqQuGx84sJxD85/GWqlfNw6oS+OKfAEpYfC/6Eco8Y+CcW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb15d99-cd8b-483c-68f4-08dcf27fda01
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 09:56:51.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nV2apLIaf554P97CtccH+t0LIENtdHO8ZJRPkXUKna66l2/elVRb5wd36i2u9HE7yKRA6/6PxtV5ROqeIp+U+FY1wiy/Zwi5iXo7yfw6isA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8889

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

