Return-Path: <linux-btrfs+bounces-1962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE8844198
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C621F22378
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7F81ACB;
	Wed, 31 Jan 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eCjXQ1DR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bhxMJSo1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4C80C1D
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710538; cv=fail; b=iGxBrotP7Az4SxxgqhNkVS1SCgxFHHid2NUTVckkIS1JziiVTCr36/Hc/zOXn0gFIh12Ak1C/EQiUmvgmkChDm7PWxnpKMgQwVHPtZxYfxNirkIC5jKlSOrZh4tkBFoj0w1t7c9otCszlSrtiTkvv/RMZawyLFxNV1Z4BZasZ98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710538; c=relaxed/simple;
	bh=GRbea/0+LHlmyvBfM2XpNeFU3rYJww8IDX+q36NGzeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AudDNNhn5/Y0zf9Ta+pxaGWfVd/ZS32O8Uu4al0XZXeUsp7Im0VKfx28E9i8mhZww6gZiFxUUA50FlIeYR6TiZVjRlabN/oqBm7s5mc2KSGiEi8rxNzBthxVaWYXpca4KaZb6lymTxlDb28SiCFDlb7XMFEdyAYQf+Di1IGWq8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eCjXQ1DR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bhxMJSo1; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706710536; x=1738246536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GRbea/0+LHlmyvBfM2XpNeFU3rYJww8IDX+q36NGzeM=;
  b=eCjXQ1DRzqeh2jwn3OXM6nFQqjLAeV0+wppxVMcM7sI6pUXS4917f275
   I/I0qyiPwr33R+yd6daDOLzsqA1SAs2+dYj2mVRyTPga57/1hsuj+Ggqi
   P7nUXwLp/z00SQjf9wwvqXiTgNR/NZzWnNk+hAgE366R8D7Ma6fPaEoox
   36XtLOyqYvDvTyfclsOKa7ibez/kYQcOp6Bn4qwrQQLLeIRSB66yz8U/C
   Ni/EZp3LDFEuBZJVgt9cwAjDymxyKk4cTTQp2klVLQkETofTw4eI7CWkS
   ENhJMkoS4cAlYS5RuHeJYUp5C1n/ytjSm0iE5a2YFBIoInrt+o0HVspd7
   Q==;
X-CSE-ConnectionGUID: Et8bwPm9TPiNh7d+nAJxMg==
X-CSE-MsgGUID: uI0g61nMTZmnRLLJRZ47bg==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8704602"
Received: from mail-eastus2azlp17012018.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.18])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 22:15:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkvo1ePGysRsEjikoa6IZrdG/t7lFGwNH4WR7sWBKhxOIxAH672gpEG24RWCUbfHVPzCVJwl2Z6ZgGAVtgRB/GkNsK4fZ/rsINgPTDa35ybvruH/OV7vuSBIk5zU40I2gOVgzxGAL3yM4jWPGN5vgTkI9zQdWbm+ABHtr7kwtFhP6ldSoG0TzlcqAtxCwDd3jpTwpjNxhGQ5NmGIy6wZusQKuY1sYwaMi3ovMFqrMmHfB/G0H34W5Dr3Zd+uOec5A7RnVQy/qAJ8CGM9F6U12wXgU6vNmHqh7wI46rcrLnR7r015e8arwZpNaWcIh7OZdQR7NvCLb6Gf5MYqI14/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRbea/0+LHlmyvBfM2XpNeFU3rYJww8IDX+q36NGzeM=;
 b=l8xn/D8Pl9pNqYZKup0NVkPeVmnLqSRhnsDayxYZcOZUTV6oaGp0vzEwn38rzwWDJ4OoI1TcA1xx48djygk/3ca0nx8fLpDOxND0TT27eN6TElwn6uK5cT2IuOvuxNB1GaB664SeRu04aGI37LInhmnJN2rQbVAOi9uryb0iUC8MVuN5qLfBnybj/XGK4iHYHppC2gunf0nwcA2SVY+bKXoHf6XN6bqw4ReUvxnWkAk2xqzZQXnGdaUz+C4yyG3R6TkWxdaPEnZa1N4J8qr2+3YMwXQN7CvMyXUOvGXu9gUUJK54QQIwgqm9a7Spl/RhWjHeJIDaqzQMFQVipPGfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRbea/0+LHlmyvBfM2XpNeFU3rYJww8IDX+q36NGzeM=;
 b=bhxMJSo1ZfFxDm0wl+bP6GCTRigFonY5TNi2xxl4RF0ytxn/kgXz4Olajxicr9oBWoAyPuGLinrsGxbVsFJxkPcVTZZsn5TKtgFRX+4HP8zjf9KTY1a5QAYpBlq//uzxwB+vXZhhbMJqznQvXdftl+haVrCnU1m6SfSig7+5uMg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8487.namprd04.prod.outlook.com (2603:10b6:a03:500::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Wed, 31 Jan
 2024 14:15:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Wed, 31 Jan 2024
 14:15:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>, "clm@meta.com"
	<clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync checksum
 behavior
Thread-Topic: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Thread-Index: AQHaVBVA0u908WnQYEi7tSd1G0r96rDz97sA
Date: Wed, 31 Jan 2024 14:15:32 +0000
Message-ID: <9624d589-43ff-40c6-81af-2c7b577edb22@wdc.com>
References:
 <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
In-Reply-To:
 <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8487:EE_
x-ms-office365-filtering-correlation-id: af1c8499-08df-4950-215a-08dc22671641
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sXpbi7mYE0e+msME8ytK71ojnfdIk3xfqIc9kjnbZXztBmmVp8PFRbDiwE4S9cm5pky+DIk3Ad/JZ7CYoAbrXawL3VqRwtjU298hpMOWQRYoHcIargprmaErYOVVjqD2frVe//3Nm52qaK3rBQGlNU3VQ4qR06MnHuVHtvMzsKJv0XHYbs670iehvUGyPiuG9L9kx/iYS0EItEy9wbq5xMVY3cIXbepCpxHCZJkrREhiaLEtTRClO1aUocRXR9RM35pK2i7vlaS4GvMyJTo7RtR/5SnnxLMadRE9A/1lZAbCAjbWNbKUk6jSz6J6nPLwPn9lEJU02/JKWyNFrsl9+xCNHU2NaT5SQ8WQQ7ovPsuN2r+k0Kx/4xfdjHYuVp41DOPGUnX11Eol/WG7yP+msyC64mTRLAhixIh1W4UzRRRw3ZUrrK+lNsiNnUXhU2smB0pECyhp9gAcE50a+Yb26av5KPEBns/6YiWxYnhqSmHf2BQDa3Lnvjn/BaXGa/NrIXtgMfGVSbz6TNULtA3ZhXf0/8Nz+mTla9lmZWHLQClJcK5GyliZas4QLq3hmyUYZLgmMBrGSBxsF0OsZbKICaqkzwsVWA5Xu3h3GuS3CE24EpJGk8hSXnYQMq+dVVL0+ph7VuMEUDbtLu+ngvLkN2YTQTgaTZhMewixlcDW2Dns7oelgcfuNYooG/YN32dzlA7cbRGwY98DedzTdDhR7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(54906003)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(91956017)(31696002)(110136005)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(316002)(38070700009)(36756003)(6486002)(6512007)(38100700002)(122000001)(82960400001)(6506007)(478600001)(53546011)(83380400001)(71200400001)(26005)(41300700001)(966005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjlxcTJlVnlYNlpXZE1heFo4QlB3Qmx2ZEpXYTZ6M2tCYlM2aUFUL1BOK2Iy?=
 =?utf-8?B?WVhpS0JBdUp6emxJczFITmZJL2M5Z29HcVdkbDJST2FPc045WUg3TlVaZjQz?=
 =?utf-8?B?dU5kSnptUGFyYzd6ZkEraWZUdE0xRWozNmt4MXIrZEFtKzdaeHp6U1VWMEVT?=
 =?utf-8?B?OFNRLzhJZ1ZvSUVvMUU0a1ZLVFNuSHhMQnRvaFZlbFBCQmVhMVcwR2tpR1dq?=
 =?utf-8?B?RC93TlU3WUZhU3ZWMFI1VmwwTWV6V3pOaVhUNGlKRHdGeE5jNmdLdWFGTnJ3?=
 =?utf-8?B?ZS8zdVl2N0NRa2tnRFhQbVE0TStUeDdBdkhTTmYvTEl6KzRuSjFKUVhGNFI1?=
 =?utf-8?B?Z1Z1ZWxiS3ZsaFllaHBLZHBlb2luNXpGZ082T3ZpakRzWFhsb1BqZFhycjR4?=
 =?utf-8?B?cGxuNjEvRitSSGVkSGdoOG5zcWVPZXlOM3FSS0RsYzBBeGVJSDdKTDNqMElh?=
 =?utf-8?B?bXQ5SzBVc1daNkJMd2J5aHBqQ0l2R2gzc1RSMzFacTlkc2NRdGVMQ3RKRGc5?=
 =?utf-8?B?RGNkck1rcDVJaXlTR0VRLyt1TDIyWGgxbmZ5Q0NZcEN1Q2NaMzBCSkcyOUVN?=
 =?utf-8?B?V0JhZkRzVXpPaVlsdnV0T0ljOGJGL05ZMmRWMUd2OWpqUmVPaTNjYi9WOVZa?=
 =?utf-8?B?a0c0SVhJNjh0Z29yUFppSWNSbitFY0x3UW1UeUpkVGdSMVhFTzc1bU9qaVgr?=
 =?utf-8?B?MEdNZHhWalVBa1J0RWpXVityNVJKM3hINHU3WTJsV1Jrei91cmxXWVg0NzJO?=
 =?utf-8?B?L0dnYks5bk1TQTBYRG9KdStUZnczRGhOOWV0T2VPY0dPT0w0NUF5OUlCM05V?=
 =?utf-8?B?c1VRdmZrSlNBWXZGNFVsc1ZyaFIwMGJBSk1TdVU2Z2tGaDVWaTBSeTFZaXNt?=
 =?utf-8?B?TDc1RVNJTmwzZ29HcmhBL0VUM2tPbWJNUW5TZno5VVZNYUNUeG90T1hPTDFq?=
 =?utf-8?B?ZWhFaHlCZEpNcWUzOEdSL3dBOWpIQUl4MWtmYnpBYTk2a1NQYUZmZllqVnhl?=
 =?utf-8?B?dHk3ZklYMElxN1BaTC96V0lIaERMMkhTVi9abHJKRUF3TmJGNzBCb2dMUWo3?=
 =?utf-8?B?OEJsVFk5cmt2UnBYWHErd2NoZGJsNWh4YkxmeE4rMlhtSUQ1cDlaaEJnODMr?=
 =?utf-8?B?d2dzYkp3N1dYMjVSOCtRTElTWWpVSWY4OUI4YnJxdkNBV0V5d3JLS1JMVVZV?=
 =?utf-8?B?TWtINWdlZDQ1MkRrc3FXN1JYSlRoZkxxYS9OdDhOMGZCbVp3SWY1akVuR0Fa?=
 =?utf-8?B?MkUxV2JHckM5L3lyRitNUDVFWlV4ckF4U0NGeloreHpVaFBKZXhndlRDSW1Y?=
 =?utf-8?B?dkZjK21qY2JCOUNCeVBTVno0SENOM1hmcjNLT2tEbmdXQW5GZ2xjRlNadUJF?=
 =?utf-8?B?ajlQOUpVeUVySnpNL3ZtWjVFUnVVQk1SVnFNZmVTYXNIaFFYYWttNjltVkVD?=
 =?utf-8?B?RGxObm85QldVT2tLazJMcWNXMSt0elV2b290ZGRrY3JTNGxsVjFJaTNKRThR?=
 =?utf-8?B?aU9KYnhWWlp2L243L1ltQjd6MmVRQ0lQMDFSMk5sZzJzK05ERStzd0x0MHR3?=
 =?utf-8?B?WWhIZW1KVE5uUnR2dHJkR0JvSzJITlBQalR5Q3lxNUQrTzBycXp2TWdwVFZB?=
 =?utf-8?B?ZWxCU2NjZU9FeUVJdjc1UlVzRDgxVmRMblhsZzQxZHdDcGpYcmo0K1BhSGtI?=
 =?utf-8?B?TzdYNHB2SFUrL0Q4TWZPQVJZeEJKYVgyWXdHUEVVLzdGTmR3d1VFcUxialp2?=
 =?utf-8?B?RTdDOUMwRFdHTitPSFdqZmp6dTB0WkVzaGJVRjl6Sy9tYzViaXI2Yml6TXlU?=
 =?utf-8?B?c2dTTTZORm9FUmRTdVdXbEt3aDBrN0wyajRVTmVVektFS3l3S0dUdmE3SVJN?=
 =?utf-8?B?NmdRQjU0aHRMTE43Tnd6Y0JJb2ZwTVlVYkxSczdzaEZtVGxwUWpLbktTSVRW?=
 =?utf-8?B?dGVKVjV2dm5uWkRtYmVhNE5vdkpjcFBkUkNFQVN6NHBGWldySDIzTkZDV3dj?=
 =?utf-8?B?aE9TZFNEWDk5L21WWjNVaTNFODNncXVnWThNRzFOZ0lGeFh6dFJuTW1SWDUx?=
 =?utf-8?B?N0RDK3VmRjBBVDU3OHZldzVjVDVXTzRoK3NESWprSlF4WFl1NU9hQWZZZ3pH?=
 =?utf-8?B?UENWa2xmbFVwamZESC9mZVJtNUNYL1VYQWxiaWNPTzZaQndFeEFmRkFXUXRu?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC94E5F123583344A2B67CF92F954271@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WrTqxC+XwQovYAdP6eryp/slX2AyNOxyu0vXP/yR3RKewIYW9FTKMdyM4ZP+WRxQ9ZMRg/HBdvRr6f8uESgA5I/H7PQ74uFRAWpK53k0EzPHm9MrRXzH9XRer/u1PgzLEy+L2rbi4WDE9/Y2ZxsRby1cian3OOOJkXriJ82A3/t05aIazv1NIGcyRCthCFxCbBNzlYH+A15CtyOUi3OXybuN5WQ/5BHFCQyRAFsxPPfb6qwbTFmgUW/dG3aDtxIJmnfLiU8KbGLU3g0RBicBsXMc9CdZRRjnFArL0akEaI11lMiTCYN4XSxm1ATzDkGz0fc/ccyWJD951qjkTFm2uX0mFhT1Q52dIhJs+H0diwkoRQXK25zi+YJepucg2B2g0YlGhGaBWQcdhMuRGIbHi+A69NHYk5H6pYhY6FxFTxMqMlDmMfwYt9jsN0t1w8UugAKXRsezJ0vkD//i/ZrqLm4edFfAsKnNMJ4bmUq1xql/TzjrK3H96VY/6YvAoTGVGfeEr1wg2isGQ/CpwcefGJtO22TD+06CX1iyqWuw/wCaUEEFtc2Dkj2Qxes8/9tTHF1ygNT4u/8+rE2NqvuOl4EObVM8MqEo3TmKncA3z0/q3GPCHmHcb/0vff54V30J
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1c8499-08df-4950-215a-08dc22671641
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 14:15:33.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adDl4JdRATjnGa1xnKBWo7TAIlZv20e8TJynzCZ/80qRI5KhMm5WVjphxuenz5uoe8Pa86z7vQHlYaQ/l8zQUZVj5phbHqJeYjxmROohHXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8487

T24gMzEuMDEuMjQgMDg6MTUsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gV2UgZGlzYWJsZSBvZmZs
b2FkaW5nIGNoZWNrc3VtIHRvIHdvcmtxdWV1ZXMgYW5kIGRvIGl0IHN5bmNocm9ub3VzbHkgd2hl
bg0KPiB0aGUgY2hlY2tzdW0gYWxnb3JpdGhtIGlzIGZhc3QuIEhvd2V2ZXIsIGFzIHJlcG9ydGVk
IGluIHRoZSBsaW5rIGJlbG93LA0KPiBSQUlEMCB3aXRoIG11bHRpcGxlIGRldmljZXMgbWF5IHN1
ZmZlciBmcm9tIHRoZSBzeW5jIGNoZWNrc3VtLCBiZWNhdXNlDQo+ICJmYXN0IGNoZWNrc3VtIiBp
cyBzdGlsbCBub3QgZmFzdCBlbm91Z2ggdG8gY2F0Y2ggdXAgUkFJRDAgd3JpdGluZy4NCj4gDQo+
IFRvIG1lYXN1cmUgdGhlIGVmZmVjdGl2ZW5lc3Mgb2Ygc3luYyBjaGVja3N1bSBmb3IgZGV2ZWxv
cGVycywgaXQgd291bGQgYmUNCj4gYmV0dGVyIHRvIGhhdmUgYSBzd2l0Y2ggZm9yIHRoZSBzeW5j
IGNoZWNrc3VtIHVuZGVyIENPTkZJR19CVFJGU19ERUJVRw0KPiBob29kLg0KPiANCj4gVGhpcyBj
b21taXQgaW50cm9kdWNlcyBmc19kZXZpY2VzLT5zeW5jX2NzdW1fbW9kZSBmb3IgQ09ORklHX0JU
UkZTX0RFQlVHLA0KPiBzbyB0aGF0IGEgYnRyZnMgZGV2ZWxvcGVyIGNhbiBjaGFuZ2UgdGhlIGJl
aGF2aW9yIGJ5IHdyaXRpbmcgdG8NCj4gL3N5cy9mcy9idHJmcy88dXVpZD4vc3luY19jc3VtLiBU
aGUgZGVmYXVsdCBpcyAiYXV0byIgd2hpY2ggaXMgdGhlIHNhbWUgYXMNCj4gdGhlIHByZXZpb3Vz
IGJlaGF2aW9yLiBPciwgeW91IGNhbiBzZXQgIm9uIiBvciAib2ZmIiB0byBhbHdheXMvbmV2ZXIg
dXNlDQo+IHN5bmMgY2hlY2tzdW0uDQo+IA0KPiBNb3JlIGJlbmNobWFyayBzaG91bGQgYmUgY29s
bGVjdGVkIHdpdGggdGhpcyBrbm9iIHRvIGltcGxlbWVudCBhIHByb3Blcg0KPiBjcml0ZXJpYSB0
byBlbmFibGUvZGlzYWJsZSBzeW5jIGNoZWNrc3VtLg0KPiANCj4gTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtYnRyZnMvMjAyMzA3MzExNTIyMjMuNEVGQi40MDk1MDlGNEBlMTYt
dGVjaC5jb20vDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzL3Az
dm8zZzdwcW42NjRtaG1kaGxvdHU1ZHpjbmE2dmp0Y29jMmhiMmxzZ28yZndjdDdrQHh6YXhjbGJh
NXRhZS8NCj4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNv
bT4NCg0KQXMgYWNjZXNzIHRvIHN5c2ZzIGFuZCBmc19pbmZvIGNhbiBoYXBwZW4gY29uY3VycmVu
dGx5LCBzaG91bGQgdGhlIA0KcmVhZC93cml0ZSBvZiBmc19kZXZpY2VzLT5zeW5jX2NzdW1fbW9k
ZSBiZSBndWFyZGVkIGJ5IGEgDQpSRUFEX09OQ0UoKS9XUklURV9PTkNFKCk/DQoNCg==

