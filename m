Return-Path: <linux-btrfs+bounces-1608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F8836CBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 18:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273A1281E92
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F906350D;
	Mon, 22 Jan 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JmynCsud";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AjTV5wc1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3642634E6;
	Mon, 22 Jan 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939474; cv=fail; b=rJZc8U8X/8g8laxZkNwZNQKSG9vDGUU+WaBXkoBYm8Esad6Zwld8pJ4sQLPjq9GyXaJ4VKSOySsKyakHSZq7CSOuchmF9akco9I2LsbBfH8ApJ3RjOU0qvJpNsn0aZ3c5p5c1vm5mnH8wjBoYBZF1IsVqN1X5Lg+ClB8QHFPawc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939474; c=relaxed/simple;
	bh=sUU6NwBQJJDKU1NMrc92sR47lbyfykM+YXgC9kbDps4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTCTrMmIfyJsFV74A8xmKloAcDdzCRy2SXhouzELO4U/9gtD0krjuj8/T8esqxPkBleZPRtU7x3qiz60EmSa/s8HdbXkFM+Efl2ug9OlsUKEHX9E58Hh/LkRw4HbWl98Yh577BLnUsbo80Bqos0OeVSAnvgxJfOnS/cAYT5xM4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JmynCsud; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AjTV5wc1; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705939472; x=1737475472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sUU6NwBQJJDKU1NMrc92sR47lbyfykM+YXgC9kbDps4=;
  b=JmynCsudgPXsj79VBW6H1h4PycRCKwqMFSwu9mZkFFi7U20Vs0vFkmzc
   3aV2Shk4OYT9oLEwONGb1vyRMhKe44l22fSqI4U0dLjoYmUx0E8WOWJ1K
   Au1IiAWbK1MDcWN8La7H9spE9v4aCLX3ouaMgJPmN5YiASREGTZCSfAjb
   KmupJy2KjZuDnaysux7jDeHsVTsZocsD+cPxe54mcELyn0a+1Xv6Rbx0j
   wmzw36+VvZGlg279MKsznqxu+rB1a1mZFQ+O57qijYbBTBnl8ABqDuPxY
   ajkYoFc3orLTkkNiD8wjJSc9ByIJ7+rqnfGXtND59s8pdgK8YISgtffd3
   g==;
X-CSE-ConnectionGUID: ORbud4m3TU+JemamTxpOLA==
X-CSE-MsgGUID: 5cLk8LxXQ2uZRXf45c4sKA==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7446363"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 00:04:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc++yFEoEzze7VbBVmfiMVITWNRjC0KDWk5/w5HBnwqfmV7cRKM9u1TAQupWgPJw1PlBzZEis45x6Mj0Zl+tBZHaJJz8Dyx5vMMBXioscsVjKxRpRrd/KV78FN6M2gHkiFh9Ck5EsV1ErnH6qrDLzVQer01Tw+bqNx8TUWWw4RmCPBUZuUFm8FJJ9FErGCglup3VlsYS32SZ8fo6rCUH3n1E6kprUEg1QdUQoRV4lzpHfu0ifChq5fVvnYESdWSs0Vp4lRGLxIumbVV8OruVIQ+BAhpKlXlW1KTZNvbCY61p+lZkYvAvQeLXeLDcPKT+P/y5XR9o3+9DeEnoIhogVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUU6NwBQJJDKU1NMrc92sR47lbyfykM+YXgC9kbDps4=;
 b=k4uM0UC8QQms6m6mv5E71mk+rCRjNegRCe6yOZeatOVzgozmiB9Csv94m073Cj5tBVfN+TDH7jF0+Lp4wTZHZ8iEV3WgAj099p9M3kWZybtlHHGuHSCPnt35uZtGr257RCcqYejt5h6tNYStd/G9GKyPKbmAFy8NbW3zEl1L12fl52EiUFNm8ju+T7qrOqthaHiwX473V3Pgv2NcQTaomDu6IOiBiLVyFLrcDxe+lW+FG0apVoqTdwPXfFIDH75BLESF/92hjUeuF5mC9wrH6AZ+6duk8pRjO7SsZQg0G+ZCXMneMMf9VJdrymnO+KgNq97/qtNxTyUpthlacRwtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUU6NwBQJJDKU1NMrc92sR47lbyfykM+YXgC9kbDps4=;
 b=AjTV5wc1T3JUK3b8M5IHvY/uYvBZj3aFy0ng88GFFa75zfhuD9guJL+rGcPNJrar9yfZGWuGLmMTbCnCH8ygJoEClhd15iz2C1DNs5d9+CYy0XLaUX/UdAzwDbo9AX1A5C+OefVe+dQomb3Qhmc4WAfwjOPMpYszFqJZGDA6wcE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7259.namprd04.prod.outlook.com (2603:10b6:806:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 16:04:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 16:04:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: kick reclaim earlier on fast zoned
 devices
Thread-Topic: [PATCH 0/2] btrfs: zoned: kick reclaim earlier on fast zoned
 devices
Thread-Index: AQHaTSDu45Bz3A9GokuSp7Q3dwUwdrDl/xgA
Date: Mon, 22 Jan 2024 16:04:29 +0000
Message-ID: <acc07e53-1989-457a-b85b-9ed802daeffc@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
In-Reply-To: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7259:EE_
x-ms-office365-filtering-correlation-id: c2433a3c-102a-4aa4-1aa7-08dc1b63d084
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yz7NZU3Q39GX07dHBR+5FPox0wJvQu2QnuMfIlAW2bBDHep2V9zwU2VaDRHedtzBpFpbao0yr2G6ZoHslpIYXc/WLAfcphIBaTgH75OLXCh2iJIofLee1C9nSnlC38HTZYtHQmpTi1ICPGuRw+V/Jw8BrvvC5w/oOTo4VWA8u0pv9LtrlfPuf92WNsrWXzUQ5JxNyr44cV7yDqe1/bPRIbrF5LMtqNd9I36TdBA7/1Pt675jLLGuwUpEPNkzvA5V4IDsZ1gZi5UHkss3pVGOZyU6WxKSsQmvd/DZItR8ymhpuyATeHukGtuvjVcwd7fVBOepW496QLqSwGhTX8BT6eS47lRmf2VdJ2uBiBWf3tikuQeIVO2nD/tNfJtq2DNHRYXG25qgt5VuVGP2N0kuAOeBhbnD9XjBBOm9vvOUNvkQrFJNAttPF7AuF6Gm2r0GMruQQVBnLxqzHhGMkJuuvqnSldhMe/kNektnmEftasBeqm4K9kaUhD6wrRFOs4gGpepOyVQu9gRK/lUf0NuzZ0Jx8zQHayFZVGboLLSkshbA+aAp3EV2ycEcjab1Ns3PKFLs5T8i6SJYShFPwCdIzZa8A8Z2SHVhLKrdBdng8AJ7HVS+gV0pBBPmaaLUeSOFE2kxJOl/Um33W896NkcyJ1CKVJhRIPHlErvtkncX1VxeR1dV3pWHweHUK52Dw199
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8676002)(8936002)(4326008)(66946007)(76116006)(66556008)(66476007)(66446008)(2906002)(110136005)(316002)(64756008)(54906003)(91956017)(4744005)(5660300002)(2616005)(26005)(71200400001)(82960400001)(86362001)(36756003)(31696002)(53546011)(6506007)(6512007)(6486002)(478600001)(31686004)(41300700001)(38100700002)(38070700009)(122000001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnlyTzZVdG9KaUt1c0twN1FDVHpIMGFITDJoVndOQ2RrVVNWMTgrb3BpR2t1?=
 =?utf-8?B?ZlVOTllXRit5MEl1ekdWa3RrME0rb3lQdzZQZ0ZsMHRzd08vR0ZiMGwwNjRU?=
 =?utf-8?B?enZyVWxETFl6bXN1ZlY4bEVtSU5ORnVKblB1TWNSLzF3OG9ZT0tMeFkxTUZH?=
 =?utf-8?B?SEg4VDJDRFloVGlmeFMrbGdveTFNbDVVQXNJU0xsUzdWb0RmdHg4SWlKUGI1?=
 =?utf-8?B?K2NjN2VqU2plVGZuTnlwYWtsV1hIZVFWNGREQVFCWk1vSDRrSDRXQTBSUG1Y?=
 =?utf-8?B?VG90Q1NHVHZwVXpSUkNUbzRWVS9rcVBWRkRDTG5QY21sTWRka01RTVVpdUdx?=
 =?utf-8?B?ZHIrcXV3czU1TDNETGtORVpwcnBqUHA3MlFkcDZ3TW5hQ3pPamtVMkZnOVdu?=
 =?utf-8?B?bjVNeHJYaExVMHRINlRIc1JOdFF4SlhuNXhiTVROaWN4YzB0NlRaSVlkWWRt?=
 =?utf-8?B?ZThhRmJzZ2NIT05keHZMNlBlZUh3bzBvQ1poKzZXZUVGaEdiZ1hBVnM4dzRF?=
 =?utf-8?B?akxRMFI5Um45ZmRFQWI2akRpbmRMeUxWak0wOTRRaU9UM3dlU0ZiY2RKRWNs?=
 =?utf-8?B?eUJQamNLWG85d0ZQQW5pdjRqUkJMaDFxbStDOUtUK1k5cEhmRXM4ZVZwdnQx?=
 =?utf-8?B?WkVhaE5INUwzVXcvdFVEZHhVSkdMWURzNklqOUtnMENRcUgrbWhoQTdWdTJx?=
 =?utf-8?B?Q0JOYXhlc2x3STZmb1lRRmRtWlRTVlhid1N0SUNUcEZqeVBQSXdlRG5Mcy9o?=
 =?utf-8?B?OTUzQW1XVTRnMkQrN3FQeG9XRGRMRE56aDJyVCtpS2V1cjZabkhhRlV5dVY3?=
 =?utf-8?B?M1hwWC9FYTltU0JOQWRDWDJWRzVxa1pSN2h2L2EwNDBaV3lrTTUycHBhOE1k?=
 =?utf-8?B?QWtERWE4LzQ0WWJXTVJCc1NvdWFUWjdKS0trdjR3S3VtSE12VmFWWG1VcEtN?=
 =?utf-8?B?a2tkQkQwQ2dHNEZneldySXVUK1FNc1JJM2l2RTkwa0ZieWdZMEE1QjJ0VThn?=
 =?utf-8?B?dTlVeXpEaW51aXcxZ3ZKbVFPaWxLTndaRUlha0c2b0VRaW04cHJncFpON2Vs?=
 =?utf-8?B?WHErQlRRM0M3OXBTc1BnZ3VwZTFoL3JZVXBKSjRoNndhb0wzUm43ZmQwUldw?=
 =?utf-8?B?YjVzRU04L2MzVkZSNnExb2pER2lPNk5GTU5wc1dkeTVETnRQNmlQZGxvK3BD?=
 =?utf-8?B?VmYxUVp6Wk4yNlNNRDBvc0pibzZXVmFlRjZtVWlhcGZSTUMxVi9hVnFIbjIr?=
 =?utf-8?B?NEY1WnNKZ21nTDhaejE0RkhHRHB6ZWRtSUIzeUxoZ0l3T0wrMHVnRzFqMUVh?=
 =?utf-8?B?T3BwTkdUS1BBVXh1a0o1eVI3WjE1MHpGVzByKzQwNXZHczdDRGtnVktaVHcx?=
 =?utf-8?B?dWk2T044VEpyUXpaNzMyRGRrWWZ3TXZyR2V2cVpGZjd0RFVFb2RiT1RXbkIv?=
 =?utf-8?B?akF2WWZxMkMwZ0VwbEtFNlVCQUpac3JTMmhYc3dUd1Z5QkhmWWVPVXB0c3pR?=
 =?utf-8?B?NmRycE9Heit6ZC9tMjdiWmJNRzdidFpjdVdNYUQyVlVIR0o4d1ZxR3BNOTZ0?=
 =?utf-8?B?TytWdjZHdWRWRzdVNUt0ZkQ3Ym5DUERyc3Y4ZHdNRmdxUUlZVXE2R3AxMXhM?=
 =?utf-8?B?T1N5RnNDbHVOUGlhK1h2bklKSXJEY0w1bWlCZXBwdnZ4Ty8vQ3E4a0d3NUVs?=
 =?utf-8?B?RTA0eUwyY2lVM1RlMkxodTVrQjZNZW1vcXdkOG91TFZiK1dWMTEvcURnWEw4?=
 =?utf-8?B?MUxEWVNRbzZyVko3WmZLOFZMQ0pmcXRtYWxjdFBzR3hNZm9kQS8vWnlnZ01h?=
 =?utf-8?B?dkdFRk1VVTZNa3I3VlRGZUhFUDQyMWQ2MUQ4SDBTUkphUTlmd2pjLzJlcnVy?=
 =?utf-8?B?Y0NaZDM5R3dORlhkUXhORU5sVWg1ZGJtdmZSUUhyOTRRVTZBd0o5cVlSRFhm?=
 =?utf-8?B?dmllVTAxWXYwNGh3aVUvT1NKT2c0K3Z4aDZDOXg2M3JyN1FwM0tmcnlnUDR4?=
 =?utf-8?B?ak9tT1VhaG5QWU9vbmFCVDQ5TXRialg3QmZtR2tYSnFFNG9jOVZJNkM3ZG41?=
 =?utf-8?B?QkZ2cERWVFBwWDlLaklFZURMVW1HeEhCeE4yRmplVCtlbEQydFUrZDZ6RStu?=
 =?utf-8?B?WnlKS2pYQmVZcDdyMXhRdCtRNWl1TThrR2wxQkFPLzBxYnhJbWlTNFJENGNO?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3DEFC7476EE74BBE046860DD922674@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VMhuZqzvf/bQitE7gz54vkAVSLIK14xbIihG3r5xGRcfU+IlQRiocoKxqLvDv7ZapHtYuNVyUP0ow/6/4+wbbI2PsLQCfT1si360p27GmvO5P0nGRNLBaXe56VAIXS5TXEl2/IOsluUeHdoFMrPL3zUdTJhIou6GgUigvoCxt1nxnCoPLAajORqGky2GsaA5jFmsArxpFw2KWIz0y0LrJCUeCMeD9LvKYGHA1oFUeBN4mm21OKBhmC/D5yqU7/pqW+UBqaQcKvH8h0Muc2HS4isGAMq/hBKG7i/lrFnDUE136+pwT5ed/drMfAOIYT74ScNUk0RQw3SYXOFEGH4FQh9tWTvvvb0ZAxp0fOHGonSN6goz1dVTvGFe/3Mvuumr/iJnBP5hrJ/xcWAr9WpPB8adUWVkkQaZunX3oDNoTy11UG+u5+wKd3Jut+brmUWHSRyD5WyhKnC8ylCg5qrP60Ea56Yvz6Gdov/AamON/hIm4+5j8plktIibRaiAT4coBd3tOu+2Ad+uVvugtruX71IXsYTVVxptAXsT6rsNO6+b/Rsg/WsoxEVYOohtyy1GYiMNWn3L8bs0s5KST+T/AKKGhYSjh6iUKi6OyWowF4/niaJj/4NhQd5ydjHsY8TS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2433a3c-102a-4aa4-1aa7-08dc1b63d084
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 16:04:29.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t738pfUgZw1klZt0DqJKE/vNEuZ7tAHe0x4yMNE+lvmeFBhcBsaRDZl1F3DXXEuRmhkq0HgGgBK15ixkPkJlT3wipGOHT4xBKhf+ibIat04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7259

T24gMjIuMDEuMjQgMTE6NTEsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gV2UgaGFkIGEg
cmVwb3J0IGZyb20gdGhlIGZpZWxkIHdoZXJlIGZpbGxpbmcgYSB6b25lZCBkcml2ZSB3aXRoIG9u
ZSBmaWxlDQo+IDYwJSBvZiB0aGUgZHJpdmUncyBjYXBhY2l0eSBhbmQgdGhlbiBvdmVyd3JpdGlu
ZyB0aGlzIGZpbGUgcmVzdWx0cyBpbg0KPiBFTk9TUEMuDQo+IA0KPiBJZiBzYWlkIGRyaXZlIGlz
IGZhc3QgYW5kIHNtYWxsIGVub3VnaCwgdGhlIHByb2JsZW0gY2FuIGJlIGVhc2lseQ0KPiB0cmln
Z2VyZWQsIGFzIGJvdGggcmVjbGFpbSBvZiBkaXJ0eSBibG9jay1ncm91cHMgYW5kIGRlbGV0aW9u
IG9mIHVudXNlZA0KPiBibG9jay1ncm91cHMgb25seSBoYXBwZW4gYXQgdHJhbnNhY3Rpb24gY29t
bWl0IHRpbWUuIEJ1dCBpZiB0aGUgd2hvbGUgdGVzdA0KPiBpcyBmYXN0ZXIgdGhhbiB3ZSdyZSBk
b2luZyB0cmFuc2FjdGlvbiBjb21taXRzIHdlJ3JlIHVubmVjZXNzYXJpbHkgcnVubmluZw0KPiBv
dXQgb2YgdXNhYmxlIHNwYWNlIG9uIGEgem9uZWQgZHJpdmUuDQo+IA0KPiBUaGlzIGNhbiBlYXNp
bHkgYmUgcmVwcm9kdWNlZCBieSB0aGUgZm9sbG93aW5nIGZpbyBzbmlwcGV0Og0KPiBmaW8gLS1u
YW1lPWZvbyAtLWZpbGVuYW1lPSRURVNUL2ZvbyAtLXNpemU9JDYwX1BFUkNFTlRfT0ZfRFJJVkUg
LS1ydz13cml0ZVwNCj4gCSAgIC0tbG9vcHM9Mg0KPiANCj4gQSBmc3Rlc3RzIHRlc3RjYXNlIGZv
ciB0aGlzIGlzc3VlIHdpbGwgYmUgc2VudCBhcyB3ZWxsLg0KDQpQbGVhc2UgZGlzcmVnYXJkIHRo
aXMgc2VyaWVzLiBJJ20gc3R1cGlkIGFuZCBoYWQgbG9ja2RlcCBhY3RpdmUgZHVyaW5nIA0KdGVz
dGluZywgc28gdGhlIHRpbWluZyB3YXMgbWVzc2VkIHVwIGFuZCByZWNsYWltIGhhZCBhIGNoYW5j
ZSB0byBraWNrIGluLg0KDQo=

