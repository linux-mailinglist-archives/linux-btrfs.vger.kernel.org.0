Return-Path: <linux-btrfs+bounces-4510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D48B0392
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43467283658
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F1158212;
	Wed, 24 Apr 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VMbPGqAy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nGxJ07mU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72715667D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945435; cv=fail; b=EEsBQB+YvkHBV9lzujBsCuByMZbC1Lb+5ovb9dZNDpMiYcK16GkuPhmTmNze+zu/esPFjbFv+p+xgOeL5ZifTloF+cOY6ECYIB0XU96aML/tRM+nTsIsArK/bwkuVc1MPJr8wgXAFJllUneDWR45hz6QBeBqH2lgg3SGUKGBQTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945435; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ro8DQiSrmAb5fGDZo1VuE/do4LVkRlDNo5pi57L7AZ6Z5omXzfUN45iHIVb6Sx49VtTdbBKXaGMKQys39sow3pZWCkrLCu4AvzUs5KuqD9ZAtVCMrrGnlXyYi41LofJT09BBvZcombwTvl1ZF5TWJfjUZ2QC+QV9QkM3N/6EPPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VMbPGqAy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nGxJ07mU; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945433; x=1745481433;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=VMbPGqAyyGyDA+wSVpxCidaPr4FRLRg48tJJDeUfJ1Plgtg8LHDa2zyc
   NgfvqvhI3j/wEG3nCaAiQyeUcy8ix7PMBuz51k1deonh58j5EmrcuDkzE
   cLi08+B6xx0xL/MpO+wXG4/oCdgvP+Y1QWoq0Ka7E1SrDkn05oXu7CAPs
   4712oLPzjMfT5mR3Ry7ICMGdU/0Cy/R9xVQGueACqPC3TSuZVPqva9ErF
   zmCJa/N4/BTPwrcAQidnuSRaTmhzX39Cn6yFvrTLbrRyrxA07bCznPyYc
   LO9Ossd5Sq8Hv7ZwZ1ALm3dwmm/wc1WVheHoYap47tsmXH1U4pomPtQEj
   g==;
X-CSE-ConnectionGUID: ORwkfj7FSRiItBpywFkdyQ==
X-CSE-MsgGUID: 5oqUgNdbSmao52hGpv5WmA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14729454"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:57:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA2cqyj5TQNb+q285mUYKFdRPOiOVGzpMhr6ge/2Solc1ve3FWp5O8iqVJ32IBPSLkFQ2yX3drrPjxJdQ+R84dg8CC4uzBTygHIAn7P/06lhQRoEB9fYPb4LoVRjLe2YCuAbq+aoHDqRx/xA2IdltVDpWmD3m459sxao1REag8HrRMN/uImAI8NWdcStI7VZYOyKz7gN8fEknlMZXIzpvOA6ABhdJrhlij1/9G9RT240/QM/imE3+dX1qDeP8gmDy4kadKLxDnmr4zwFT0uqPH+54K5fpfoRNDvKdHFav4uVZj9eaWSJb48W7rM8+VNnIHKlqQW5eHPnY+F7hskSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WzkbqA+jxnbj6HeTJQ5ymtl+0lQco5q8lO8au88+iibXzEwFYCVOgXGIg9EMwEUQeYarljnXLUIsgLCQFt2XyaU6VXjLuDkfleX6nSMFXZstM1+HX3PLzmFAJ/uGHIINrkZRoAz40wre6M9YNBy26GCNsGxavuLuRWl6KCtrFSHDvDYHk9ApsKnjC8o2RtLYrqsoq5MZxIpwWQ2GQbuIXq0YlLhgWRMeGfcwO1aNzx12Mt7D4c8WakhF/9BtUSCjPgoYhxB5n/tS/Szqc7DiRVRielyc27tEeybpdi0/FTqdHpGzexvxA/HD8XVXqkBbKBKmkze5MpwrympiyAZLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nGxJ07mU4/XGK8nL3EH9ot3bZgyQNwp+fkef/7fGIVLVPDA5GyQD0Tywy7oqkw6oW6jDKtVZBnJJkHXr6cuiGAip5hRvakMy3ydWMwc3qX4J+YJR7qbt+zybTj4LRxuiY8jEtErrpwDtff4/05BKoCoAMABZqZpTh5m0QP2Hfmg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8003.namprd04.prod.outlook.com (2603:10b6:610:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:57:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:57:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: drop unused argument of calcu_metadata_size()
Thread-Topic: [PATCH] btrfs: drop unused argument of calcu_metadata_size()
Thread-Index: AQHalhJndKmLHxJAA0q+XaVTDVcAk7F3DdgA
Date: Wed, 24 Apr 2024 07:57:04 +0000
Message-ID: <c7c3472d-d2d0-40d8-9d1a-2cd2a68acc73@wdc.com>
References:
 <ff912bc5410aeb9f71a5b7ef5fd9376065dfeaf0.1713940243.git.naohiro.aota@wdc.com>
In-Reply-To:
 <ff912bc5410aeb9f71a5b7ef5fd9376065dfeaf0.1713940243.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8003:EE_
x-ms-office365-filtering-correlation-id: c04eed70-56b3-422c-eb09-08dc6434219e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2ZILzE5b1M4TXV2SzFETGRTbEpUb1ZreUtDeDcrSk1PQW5KbU1JL0ppMFNy?=
 =?utf-8?B?cG50OUZtVVA2WWoyVVRTZlYxa21uRVQ3ZWJFMnFtWmdScmNFZ3BZejluRzN3?=
 =?utf-8?B?QzVldHgybG5zc2kvbjJ1YTVqRGFOQlBGNzA3UjFZUjZEWURKVzN3M3l3YWJh?=
 =?utf-8?B?dGoxWVg3ajFib0hmWUhwbnZ2MVZKSWZHQkZ1cERERlpvcEZOY1ZLc2lURmRH?=
 =?utf-8?B?ZFRZMC9lMUFwY2EwY2FDQjRWMXh2MElhYjlQZW5BMDhTWi8vNHFHOWNtbXZY?=
 =?utf-8?B?Z3ZoL1ltUVdNN2c2Sm82V3d2SXRrK3lBRkI5ZFEyR1JDQ3VGeGxWdDcwT2NL?=
 =?utf-8?B?UzN1dkVRUkhDL3RPUFUyZGh0eHpkcnJ1dWgzWWpKQUtZWlZOQmlneDlTU2ZJ?=
 =?utf-8?B?dFMwVW9YeXdnTTZXVVVDM3JKZjNRM0hEM3NJWUZVODJsUlQrZmd2YytxU2Vw?=
 =?utf-8?B?dmlnVXVuUEhMMTVTWUtyTWd5dFRFOHdGNnEzemFOb2hiQStDeXNyOFhiL2w3?=
 =?utf-8?B?T1cwc0UvVTREZHRjSFRwNGh2ZVFmZklUOUY2Q3VNUWFTR2RzWXh6MUNOcEM2?=
 =?utf-8?B?V21Ea1pOZmJ2SnNxTFNTVndHejFvMjdPV0Zrb2tOS1cvQWhJRjJyMlBvdE9i?=
 =?utf-8?B?WitielRKVTlZbzhHOTdvUUVXbUF3QUQ3Ykk1amoxb0U3UDlYczJ0TmJ4V2xy?=
 =?utf-8?B?TVYrcWxiK0JVNEJXUk81Y1c1WnI0NzlFYkFCWWE1UkZ6ejFIcmtuc1ZZeS9y?=
 =?utf-8?B?VThaSnprOVV0MlM0R0xFbWNvbnJKNzhHSnl0MUFXcUZNY2o4TkF2c3NidGtm?=
 =?utf-8?B?NVhVQlFQSUYrOGhxL0Q4RDY0QkNQUjlrTzU5TTBTWldacVZMekJ6cXJYbHVE?=
 =?utf-8?B?RVMwYVFyaG04MEtWNVNSSXUrRVF0N215R2tiQzZEM1NkY0NvNG5MeXBZU293?=
 =?utf-8?B?eitSN3RnbHNSek15dGtyczNmUEJFQU02UGlDWDA4T01nWWdYamd3YnVjYzUv?=
 =?utf-8?B?SyswdXJ2SGszOUpjVmxJOG1SNk5LakZ3aEZUZHBubk5PdlNkdnJhTEpYOHFs?=
 =?utf-8?B?bGxGaFYrb0RTSENxQUJVRG5YM3R2S3VKckdxc241ZmJBNFArTVFFMzZENWxH?=
 =?utf-8?B?YjBlbXNrZElYOGd4SGZKd2VzeFZnSm5xT29zVm81cDBia0JHbm0yU0N1dmlP?=
 =?utf-8?B?bjcycGc5eXhBblRaSjc4eHBOcEw3ZGtnTTVVNENhU2hXUDJMSENzbkR6WlR6?=
 =?utf-8?B?OGgrZlZpYnlrMUMyZEpIVGxTSEMyK0sxTHZhaU9ZMmdheU5lcWdRNWlSejMx?=
 =?utf-8?B?ZGNwTDkvaENVSzdrb0xrVWpBWjhpRnRQZU1QTVlSZXhMUHRzUUJVbzhLVHBk?=
 =?utf-8?B?WHFrWkdVZWlTM0hDWEVHRy9FNkt3cFBIT2FldTFtazhVbFUyWmNHc040VytG?=
 =?utf-8?B?NE50WWt3cXRaOStscUd0NERGMmNzQUNvaWhiWWNmV3Y2dTNDSXRXK2VwaFZX?=
 =?utf-8?B?R3NtQmFpYzltVkVrRnUxMVZuY2pidDgrREthTEVmYjBzbkh5bkFBVjJPam96?=
 =?utf-8?B?alhHVkhEZDlDUnlVYnpWbE5OcnVtNXNKK0lKaG5wZHpwdC9IVEY4ck5jSVo1?=
 =?utf-8?B?bFFBYlEyZjE4R3ZmQ1NkdVJYdWhla3hHandKRU5FM0QxYmJQU0NPKzhQU2RZ?=
 =?utf-8?B?TXlRUE1XK0RJZXhEVm9zNnI5TXNqdVpiMThhZGlGWVJGaGlFVDFyckxmQ05j?=
 =?utf-8?B?dXZyRDlBb0ZidTIzSzFBQ25PUExkak1wUHhlMFN6MlJLejRuejRsVG1yeFRR?=
 =?utf-8?B?anZVWDdacWJsY3FqanErUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGV1Tk5uNUJCVks2VG9ZRHNwRlAzdzhSa3RmTmZUZ1NrcWx0UzVEbVZNV09H?=
 =?utf-8?B?MktuYi9GRnBxdXZBWlJtMEN4aGR4TnBXMXovdzRZSG9BN21jY2FwRGhlcDdX?=
 =?utf-8?B?UjhBbnNzaW10OE9tOTh0c2RnbkZBMDdKWFVqOTV4aTR5RU9kUzlPS3RBRjZE?=
 =?utf-8?B?RVdnVm55MXZoeTlpZGFhOG1NaFhyV0dhS3JZRHZPSnV3eW1mNnhvc29kVkRB?=
 =?utf-8?B?T2kxVEFXMTNqbEU0Mjl1b1NSQnZBRjdhZ3NWQXJ0WEYydEhuSE43V21KNnpq?=
 =?utf-8?B?OEdPaXJ3ZERiMGNHM25WOXNuUHFLMTNkMDdiM0VZTXJqVlA1MmJiR2JQTFUw?=
 =?utf-8?B?TVIrNkN1RmlHZTlyRU56b2xCb2xvTEJZTk1nK085OTNBTmpSblZCWjVaRTVo?=
 =?utf-8?B?VWx5UlMyaCtmRnpjT1M4eGJnSkRSQkVhL1RpeWFOWlBHRFVMcEt5eUIzaWhU?=
 =?utf-8?B?aHV3NTg3MHY4LzUzZWludlVLMzRVUjhZMStPS1VIdVpNQnk2TEhnWi9hSHZa?=
 =?utf-8?B?djBWeVRRSFZsc09ualcrZzdFU1ZGUzhidWt1N2p0emtJc2VZOHl3WkQ5dkMy?=
 =?utf-8?B?Ym1MNWtDODFyN29jM29TRlBuQlB4d2lzQnAxZ0YxVEZJVXhuZEhvM3hnQ2ox?=
 =?utf-8?B?OVZvend0UnN2TWNhV2pBMjFwY3FpQ2VOOHRWenZVd1hBdUgrSFRWZ1NLVUsr?=
 =?utf-8?B?ekhmcXJuaTd0b0J6a242R1haODJDWk90R2x3TTFXT0xJOVd6NERQMkh0SURw?=
 =?utf-8?B?Z1NhVkJWSk5lQnNjV1AxYVI1TVh4Zms0VFFOUDhtTXBUSHc1OUR3bFhMa3hi?=
 =?utf-8?B?NlNTMFFmaHpOM2ZzODNOQWMzYlAxYWFYUE03WlhOTkoyUUtRUmVJS3RrZ0Vn?=
 =?utf-8?B?bXZKdWlqTHY2K2s3QS83T0txZW5rLzFzS3pJQUI5a0tXemxmaHkxYnVjemV6?=
 =?utf-8?B?bk81SlVwWGcrZzFxOVJjSG11bVIwRHh6aG9Rc0dGT1ozUHAycWozcThlUTZI?=
 =?utf-8?B?djZpM3MwbllWbVlXVC85b2ZuZmEyR1ZrN3h6OWpkaUVqd096U0ppQk9iU3NW?=
 =?utf-8?B?K09NUWc2ODFMODNLTHpsQjJ3U3E3c3Awb3pJZ0UwK0tyMXp5STdoSVBhWThG?=
 =?utf-8?B?Rk1vODhLN0ZTeUl0YUJzTHJRa1FxblJpMkhTNVoweXpOVFpTOUlmRkJHMCta?=
 =?utf-8?B?a2V4Wms1QW4waGtkT3d5bi8rYUFKVDhQMmF2WnpGWkprTmRHaUhIMTBDRWNG?=
 =?utf-8?B?dEFoeTRjSUdNdGMrSWNkWjVCeEsrWnh5bngvekNBa01FbWVYWkx5cUhwZGtl?=
 =?utf-8?B?aGhmcklaTWdtcjVTaURndnpsUUUrNERPQVJIRlZqZkd4U1V2cDNWM3VEN29Y?=
 =?utf-8?B?NlVTNy8rajNGNkNUZk9kQkttdVI3TUIydW5aL1hGMzZJVy8wdytiNjlSQzVG?=
 =?utf-8?B?azl4V1RzVE9PaTdvbEdpRmVnMlBqLzZVc1FudjZDaXlYTUdGckV3bXF6VEZy?=
 =?utf-8?B?dXVCcFE1UWZvYUoycklDeGRLQzErc3pqeTA4ZFhseXh6alBPUklsdUlscFJE?=
 =?utf-8?B?KzZqdVh4SUNYdVd4RVBBTVhUMzhHeWdzc1FOMzAzbEMvc3pkTkw1Ym5RTm5P?=
 =?utf-8?B?enNheUN2VTRWajdSS0pFQkp1d2xKTjdPcjUzektsUWRJc0NZQWsvbTA1VWFU?=
 =?utf-8?B?ckJpQzdXbHhnZWc1UFpjVnhiUjNMcW5TbERhd2VzelZvZlZoTWd3QVFyMGR4?=
 =?utf-8?B?MGxXd2dHVmcvOFdOa0lRUmVoMVRyRnlSZWttaEpxMjFXWCsyNW5lUThaaFZu?=
 =?utf-8?B?M2Z3WVkzV3F3SjRWb1NMZFpOalIybG15WHNrUlRmWjZUbkVZQnVEcGx5a29H?=
 =?utf-8?B?NDd4L25YUm1KZHplUm1NbGh1ZFRpTDdWdk9ncUJFa2lKa2JBcWMyZFl6bGh4?=
 =?utf-8?B?alNIQzZjWlJnYitMZE9qWG4wV0dyRTBQRHhoeVlrNENoSHJYS09OMUZSbWJF?=
 =?utf-8?B?cGVMZVk0M1RRZlVzTEVsMWE0RVRlVVNMSnBodEZVUE1hVTVtSld5OEVNU002?=
 =?utf-8?B?d1pPa2gyR0lyMEN4SmVKSFRtbUZ0aTJzcTdwWDhXNk00VXVhTDExOFJKTFZi?=
 =?utf-8?B?dk5HWW9yazI1NWhNaUF6eGttU3JBQi9BYXJUNmYrY0dScUJ2c0NaUGk4eEdW?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5796DE097190A24C85B1F0C9793C742A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JCcdxaumguWsgG+oGNywlzSPYli1p4d52Q0PzdsDwqXlPbol8++HoL3SYfRANDyYVkOs/6n6nBKtSwmLIMZT/4ny1of/qO0nqEjUj+5nRlBT182z4cR2xiPsEWqSpTSZ0sNpFt/nL5ul7RpF77E/3KNcIFsjzvjdPUQBV5QHs3Yk9Syr2EbbWLK8OasTWIEtAkkoU+grO3yfkOcRCghgApi5bhiH/xcL4D5c/6fiTS9kSaJ62lEeOadxxjHmtGt7xEkhGjrwknBUWtW62SBQZ4PL3ajDW6rciKyk0MbazI6XaODqbwCeZ0tTn5BH9vRQ20NCu6dwzPXomWAgtJo8haX7eMzXwxLbmKQDbQEzc+Bv3Mg54iB9Uef5+2yVtuxPiHYccZbkaaSJcjPecS/3GOHNh4bps0p7gzZG+34MTiBf6Q65yaTcQUD3SihuwqjYf5fHmCi7+Hxl96zQMyezXk5WwzIi1E/Y9vSD8Pqno3yqbRmKHeBxqPhUmf1IFGep5lpziPistEf/3e/GRMgIBJ+n9Zf2TaM4myxdVRo6TIkmGFxL2TYcMq1YgFrww27mC9HeVI471Yv2kKsm3FAN7wkqB/MkhuZZ9/v1zfwXz/ly7Y3xyAjCCNF4rwppX1cC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04eed70-56b3-422c-eb09-08dc6434219e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 07:57:04.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CPulrQph6DEMU5CoEBbWVGR/mvgjZ1+UTgWtQLCJQRIn04dAmlKpsYwnk69V9eOxmpPJZgZ0tKZH4vOizweM4Nq4VtCISdtU7Bu/EfFXp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8003

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

