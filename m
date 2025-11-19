Return-Path: <linux-btrfs+bounces-19137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8BC6DE7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 59B282DEB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D663491F9;
	Wed, 19 Nov 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BnIbn/AS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VqdvWJGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF92D8797;
	Wed, 19 Nov 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547109; cv=fail; b=IvBdx2XkSq9XVkuyy3V0XRbP8iKPswM/O9Lbfw0flQ4OAKNu7cQ+smf5MaexitgvesGwtrss1tQS5wrhNpzmJT2W94EM8X3A0dCJaMeqF9mY+m+eZKOzjvCN6hRt+oj0pc8jgb+17CAvv77W4SZMRHU0KmTgw0FDnC5sITb2fYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547109; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioagmyNxQKWKaJvE4EBWWHxWHpgWjLnwunxh1t1KAkvQQwovxwpZBcUSgd94VQadOfe5VvkYgKEWq2hAWPmUqxkKl4QH1QgvuFchyURwcA1OVjO2j+8612zvvQFIZyWyl/oV1nvp6PBFVuYQKt73uJjeod1Zxr/Z+grfJZ8Impw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BnIbn/AS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VqdvWJGb; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763547107; x=1795083107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=BnIbn/ASsUjqCYJ1quG0x+kQF0gXY6Xz0MGacs8Uv7Ya/RBvQZzzUvfW
   6sCgLTTpWa1CZrNDdPyaHb51pY0AhEo+hUV+OpbaJqcRSPByv/sfWN1yJ
   vvZBhF2LXH5wCazLDCB5cCWhGLbXBe14/pyxqTqeTojo5t6o4AQRwHi/W
   qQjB4nPTr17+b6fDaJgo8kxi+Ni0rK6lpgV/EUb6mXaoQBhG6mAQe+Hin
   qDh2I7ol5rQNZanp8af+H7dhFljcfkgIydtLYqwwGrWrflwdPrWtsS7Ch
   +zA8twbSKxc7Qq/3ZMnKItcTbJxuWuhrkB7ccHQHgSwRueQyuSG+xkehi
   w==;
X-CSE-ConnectionGUID: xnexjHWuRC62kQESSkH/GQ==
X-CSE-MsgGUID: rtg7bxI6RTGGBMNWzQD01Q==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="132357593"
Received: from mail-eastusazon11011047.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.47])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 18:10:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmHoqR1Faz/HnNYjfV0QcedB1YfIJqCMHCX14T8iHJ3hXnnVqA2CEh//0AHEiF2oHDJwGkH6LCweDK8vy1tJSFep7v8eWsPIQaLpQ68MEP7JYvnLoSV9T7FencED3lZVhky/D7ARhCy0SqrewaxGOg+fxHRr2EiBgHLkuSqPcu+Uy5YyHLJBFn7s24P0/NNMhzBtNzhIfmlfYnTHduNwc5nIH3iIwtk09O44RUGEwrS6K2BkJHiJEEvpTW9qX+hppB3kRid8b75Ft+8ng9hVa/p327p8iUSsVqd56Vi5oO1DIk4IhYnQnD4l7IK7YUFpbfkXZct0J9+KcC1G/d7UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=rd8IoueneAnpl9qq5Pus5h66uGcuYkb2n/GiiqgKzPuwzTcuLxsmFvtc1/fP4u9m7i7pmLvcrK6I6UxXhkt1jvozaugMg0AFfJ+nxUAy63okY02cYuhhpnrDyixsh80KRGVCy+HmkoMv5eUVSK0lMJO9zAwP79pdhqFXIY5HIyENNNflo3jIWGKmLKT3gclGeNW9mI6sIznHvasG3zUTOh5T+CGS0X/UbPI5X/QrvmF662Ex2gM8Hh7wIpIsSfyP0qh19+CkitELmyAxl7YyqemogFcUAhzRXQGnp7COC6YvhMFxZ/xzBuf1LCJjbv0ALSpD/XT5xxJTWavkg+B/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=VqdvWJGbZ2eqPRvk2G9i022HE2gFLFBh/JqJaPAWgPcYLgAAyW+Dl7QjInLqzjeKFJJHOn43ZJoGAoSF8uxqoyIgSk3Qrpsyjv5TPjnLhUPA8x/EnrhjpOdYwvxYBPbJwd+5P+2bG+dlTH96aynqQn50MDq9GPfaCAYIAiXj87Y=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7802.namprd04.prod.outlook.com (2603:10b6:510:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:10:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 10:10:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] btrfs: move inode_to_path higher in backref.c
Thread-Topic: [PATCH v7 5/6] btrfs: move inode_to_path higher in backref.c
Thread-Index: AQHcWKXA9ICOVBJL+kG94Xlj8LkZv7T5yC4A
Date: Wed, 19 Nov 2025 10:10:32 +0000
Message-ID: <b0443fb1-147d-48e3-b379-9a9fbf38b52b@wdc.com>
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-6-neelx@suse.com>
In-Reply-To: <20251118160845.3006733-6-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7802:EE_
x-ms-office365-filtering-correlation-id: 9e2799fe-7209-43a6-10ce-08de2753e010
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0dKc1R4R1ludjdMbHJxWEZJelN3WkFWR0grSTlGcWxTbExyayticURnYTR4?=
 =?utf-8?B?dDdwN1N4M0hXand4T2Rtb3FxSmdOZ1Fnb0xhdkx6Z2NIZnhQTHlTZlFXUkwx?=
 =?utf-8?B?WnZwR2NleVRLNE5nS2pYQk1UMDNvcjJMc2hVMXNzS09GUnhXSlVTNGhDcFA1?=
 =?utf-8?B?VHJnUjVxb3dYSzJOYXk2UzVmZnZpdkVNcXdheVozVUNiYWxWTGRGRjFlM0Vr?=
 =?utf-8?B?ZWNKWVlKMFU3a0hCZkIzSFF5Qm15L3VEcDNNOWMwLzNHVUxSd2IwNFF6dzBH?=
 =?utf-8?B?L0lXbjJzbVB4VERabmtzd3pSaGRQa3Y5OERQS1pFNk5zTHdGeit1dVdEcDFS?=
 =?utf-8?B?Ymx1TEVnUU5ibFpnbVhuV3B4YlorUDIzcVpjT0JrR1dGM1JjV1lUeVpXMXZU?=
 =?utf-8?B?VlplODlOWTIycWdvRWxWWVZPdDVaNnBPaDVPTFdCSTdKSFY5cnlmVEFVTTY4?=
 =?utf-8?B?cFFjY0YzNWZRczJReWJXSmpXQmhKUDA5L0RMWTZZTEFQT0pXNzRsYXJQSy9G?=
 =?utf-8?B?M24yczl5NTlRQmRZcGlFc1RHV2pkNkd0WWJzc0l4TFA1MHNxWmptRHNwUXUz?=
 =?utf-8?B?RHM5Zkk0dVVyNExEdW5yMFBjbHEyc1BBRWFyVExqd1BFZjk4YVN3c0hzaG5R?=
 =?utf-8?B?L0Z4TkxCZTBoUlFSVVhtQjRHWXo5NS84cFVCMVF4QlljNVpiTzZmOStZbUVw?=
 =?utf-8?B?ZnZzYi8yaHphaWd6TXdtMllSU0Jqa21XeXdYWHFjTXk0bWpBd1NRMjFyVU5W?=
 =?utf-8?B?eEJ1UmlJNEt0WGVIV1duRGlwcit2SzhtSmRsdytDOGlCSmtGVFJZZURGMnJX?=
 =?utf-8?B?OHhvMHp0MGlSZVVsNkEvRzNzSXNabFpPMVZVcGNmamNJWCtXM0U2dTgyUkJm?=
 =?utf-8?B?a1RyWkpxcEwvLzhvcm1MV3U1Q2IxS0NpUXlCK25pT1JjMGtweVBFVE1XNFdC?=
 =?utf-8?B?SWpvR1NZaEtDTm5CQ1pFbnVIMU4xVDFYWkQyUEVUbW9TWWZ0ZTJyMTVoVDhl?=
 =?utf-8?B?WGxOTkNNN0hqd3hqc2xhVEc2YmZiZVE2Nm1CNmdrclRRS3MzbkVMdmJmVWJa?=
 =?utf-8?B?UUJZUDRNVEFhbW1kMjF5ZW01Q2JmUmFDM1pmT3NWSStQNGZFVnoyZFhhLzZB?=
 =?utf-8?B?SXRhWU1PclY4ZkppMHZURmlwWk5BTEtybk92MUh4NnEzclEycVZia2VhbjFh?=
 =?utf-8?B?cFUxUm05YnN6QU94Ny9CQlRQa0o1Z1pLelFjbFYwYytBZ1V6LzFBdi9Wck0r?=
 =?utf-8?B?RE1vZTRHVkVLcFhMRnl5YWl3Umo1TWhFWWVveTF3Sk5mWFlQdk1nQW56YXpL?=
 =?utf-8?B?QnhpOEs5QlhNcmhiVllzSStYVG4wcmxKWXdmRUdqRHRsK3c5QUZycnBGS056?=
 =?utf-8?B?NlQ3dEZtSG1lUUtiZUdjdHp5RGI0MGM1eXR2cGZlVzJvTGc2T3p4ZTZ3Z1dM?=
 =?utf-8?B?ckM2dlVkc0w5d0hHcXZQYmE4WWFFWERCV0s3Ui9KVkIxQTFoZ2grNFI1akR6?=
 =?utf-8?B?TldmT0U1Mjg4YTY3YjJ1RUhXczNCQkZVVWhheHZSMDFDRHBaaGZjc0p4TWRC?=
 =?utf-8?B?ZWRPaXBqZi95ZnY1M0FJcmVhcXY2MWI0Y1dEdXdIL0haaVl6OUg5SGR1Nm9K?=
 =?utf-8?B?UlBzS1VwYVF6bVhESlVNMStmMytMc1E1aGZwQWJ6THdLUXdyUmRaUWZwOGxK?=
 =?utf-8?B?T3plM1U0aW9nNkFsTGs3a041bTNuQWpTbGVJOS9PTkZoZlJnRFZEaHJFZG5L?=
 =?utf-8?B?dlR4RjRCNlRBKzlnSnpYTldKZHQzdHJFSFp0SXlUd1Zwa3dQSzFLYzZHdklu?=
 =?utf-8?B?OVZtWXA5YmQ2ODZZcjNqNHF0UzRJeURBMWlZY2FxeHhmSjJQVHFhWDB3Y2x6?=
 =?utf-8?B?YmZKNlVsbnc0VmN4R0tKdnB5UEluUVZSbFBtaEM1MWQrZ1dMU0JKdEJyb0JZ?=
 =?utf-8?B?enc2d215bDU3WDRjcmpGWWhBdlRFdy9HT3R1T0ZDSGZtWTduMnY2NGVEUGN0?=
 =?utf-8?B?eTdFaHhFa3JBcTAvSmpDT3RrVEQ5WmsrVUlsZ0NvN1hIWFBHZkhmU2VMOGpl?=
 =?utf-8?Q?6mj9dI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXdYeG9KYVMwRlFqelVLNDBlMDk4cXNhc1phbi9uQmYyeVhXS1RKWVUzRkQ1?=
 =?utf-8?B?Y3JZbCs5MUZDVExwS0Y2N0V0bVQwY0N5NHIrSFI0bm95bE9EbC9yR3F1b1gv?=
 =?utf-8?B?SEFZQ2ZaTkJCeTdlWUFvbEdaVE1ZN0xYdHMxTW43Ui9wTHhJdEhCK1F3Wmxo?=
 =?utf-8?B?VGg0Q3dyTXBlMEtOMnVHKzl6MjhVWVQ1NENrY0hXKzlZS0NLZ1R2WGtYTWYx?=
 =?utf-8?B?eVgwMFZRbFNWdkxmNWprc3dUU1VZRVpjYzZ3SjlZTTlFd3gwenFhNThDWG9T?=
 =?utf-8?B?TVlyaXppTi9EKzVFbk9iN29nc0Y2OHRSUk5INW9wdjBvMEhoUWRwWklSN0ZM?=
 =?utf-8?B?RWErd1pjZ204dU5UTzExSGIxbUc2UTVOdHJnQTg3eGpMNTFpSDZFbTg1cTNt?=
 =?utf-8?B?Qy8xTmRYc0tKTFJrYWxvVDdQM1F0WXMveEhFR05QQXJsR3hxdzl5ZUM3Wmlz?=
 =?utf-8?B?QTMrcFlXSHMrbEtRSHlRNGFPWGw0QWJBb2FDVG80anlDWTdlVUs3ZmJRYWd6?=
 =?utf-8?B?RGlDODB5VGU1VGI4TEUyVlVCRzFPaG1Yc2NLdzV3eHBnUStNZ2F3bXMxdVpx?=
 =?utf-8?B?OWtRdlNQcU1VNGp0OWVpOHFXTkdaVjFGcmZhcjNtOUExaG03cGZXdlBVVnlH?=
 =?utf-8?B?Y3F5K2dKU1FYeDlNU2VueENHdTg4MC84Rlc4V1RLakd3NlB4UVBVOGtzQVp2?=
 =?utf-8?B?aUlpZWxkNWFHc0ttZzhhM0hReTR5QXlKbi9XR3BJMHY1TWlPSjUyL1BaNnha?=
 =?utf-8?B?OVg5dkpnYm1kSTExempwdzgyeGxGZWNPYTMweFVUWTM2MUQ3L21sZDJ6UCtI?=
 =?utf-8?B?RnZERDhESkNLRDlOTWgraE9KUk1oTkZaek9HZ2xxOGRhNk5BWmttUWJWVmlY?=
 =?utf-8?B?cUQrNExJZzFyS3F3bi9ML3J0QkJxV1FBSWxzWGViZkZOWlZPbTlidGRZT3pQ?=
 =?utf-8?B?aTRFQkRtQ0IvbFNPWGtsK0xzUWJxQ1lZY2tqV2EwRmY5eDVoQlgrdTc3UWli?=
 =?utf-8?B?OXozbWMzVGQ4aVUyK3FXbWNnOFdXYktZT0YxZUsyN0c1TGc5Q1JxUm81UCtz?=
 =?utf-8?B?NFY0d0dRblp1cTNOKytDazNqSmhrSzA2cG5IeCtWY3RhWHNXNzUrREFrdGJ3?=
 =?utf-8?B?ekFlT1ZwdXBDKytmYkhNUzAwdDJNYVFwM05qTlFVL3RFbU5nY0tmVFRad25x?=
 =?utf-8?B?TmhYTFBqRGMvK2RlRW12UTJqL3BjbWRvYTlPK1p6NVVsVU5BQ004ZXFxTEhn?=
 =?utf-8?B?dUI4b1ZFTURObDN1ODNnZURibm9ydHpjOEpNVFlQNVUvRXhGa2NLV2ZnaytS?=
 =?utf-8?B?cWRiQ1I4a0Mxd1g1eFpVS3hhMlJEY0NLMTllOTUvc1o3c3dreEhab1FRbFN2?=
 =?utf-8?B?VXovaWhBMjlQK29yN0J0bUN3NDlobXBRY1FsWGFuellpQVQ4K1MyM2NrSHp6?=
 =?utf-8?B?VmFmK2VQRnk1aGNoN2F0L1FlSGludW9ZbWhEK2N1cTFHekIxVGtrajY5ejNH?=
 =?utf-8?B?MExxOXJ5bkFkbDZaMXFObTRObXE3UmlSd1l1Y0xFSEd6N0RIeVlMVEE4SEYv?=
 =?utf-8?B?ZlA4QUhZNU8welN2dGlscmJtVHVFRVRlN3o0L2RsamxUU25OUFhTc2FWT01w?=
 =?utf-8?B?aGVLZ05vV0orbjAzdWp5a2w0Z20zYUZBcEVwWkVpZFBRNVlKQktjZVg4WUtS?=
 =?utf-8?B?dVB1UHpjVWhSMXB4SFhvWHY0ZVNBWGNEMkRkRkMreHJhSVUwWjlXZXNXbjhq?=
 =?utf-8?B?ZUZBQVlGb2c0dzBENFpZUHVIR1BvRGJsTzdhc3FwZ21jVnNYNmd4a2JSalRJ?=
 =?utf-8?B?aS9PbXdqRUVLT0VrT0J4WDMzOFduSlJkTnpKNVB5TnFRcVdhNTQ1Sm5lWGR5?=
 =?utf-8?B?Mm4zRXlraFFwVjM0aFlIeDJoZkhFMU5HY2RWbHBPWERLV3RNQ2lEcmEySUc4?=
 =?utf-8?B?VjBMY1BnSTNqTlRBZ1dGc2RYMTV4S0U2ZUhRMzV2RzVBUnRIejhTbWpReTBw?=
 =?utf-8?B?K3o2akJYRE5aRElhbm1qU1BJSWdWU0pCdTMvck5yMXJnNVgydUVHMkJ5aVF0?=
 =?utf-8?B?MVdBaDdHZWNoQko3dElWczBhK21HOXduaHZEbEtxMFFhTmxseDhtUkpVdjQ4?=
 =?utf-8?B?NEt2QmVXTnNLU3RVVURFaTMvVzYyV3VSOTIzZFVaSmE4RFc1L1ZhWVdnV0Z6?=
 =?utf-8?B?aFQ4M0trMXhrN0krWVlMbU43R2lSL08zcHFqdmRQOXIxNW9OM2I1TmtVY3VI?=
 =?utf-8?B?WEloZ1QvajQ0ZDVydm0wNFNVZ2J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E18780D721EEEF48B5CB82596F98B9E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UCdD8BviEWGIQT/2QR5P6MkR2POrlaIWF703hFZq6gGOwRJS4ocyggFLHp+24x9KbCoHLTp32PrcIxDi+Lg24ciOm/Kzssiifo5pr0fgPI6ItZDrKpE4nxIo28aDrZe5e4PK4FpFraHKFYwRtPe/JJBnwcKzVmMyuZyZFSAulF+zcrFdID8Sz5NUiC9C8pSs6Y4UT55vNE8niX/XN4lFhcj9qTAB6UJGyG4sXJVJfrVZsLasu4q27D357AVxn7WF739plNVyE0fS7bDyK35cPAel89RL69GwYbhiVCycw4pU1hVS7k7Nsdme9DuANYVXvJF1QpixYlmCFDBzfrCVMCaQ2aP6KUIBeq0/RqnqIOUqxdQOHA6t0TVGwDfOueJQRBRGZgjES349V0RgnDoOGoUHIyOqHFKOmRzRFe+BdjF/84GnEvFhKg/0t7BRsCZz0tlMFvShYqiu1Hx1GzQrondupdeP965TwBEEoZKwILQOzxrUji0CreLMMRsOOhnNfRrRui1lSyjsRtz/v3iaqOyhpATyyitypPvrj2ttZ4z+rTi2AKktWDIcAOe1NbYSTNfYWauL8J/TZbthyoZmFWZT7D0xAnydain2tskm6UYz+R29KXuwXOqxrwKqpQnZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2799fe-7209-43a6-10ce-08de2753e010
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:10:32.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMNyWgW0nNl5ofuVHYZjs9x6m9CjmBE9/JSX6JHT7WCmbN4cQ/7t7sATngisz/tjRGETXivqiQym5KN0n1cSLSacY5CcNBb5QW1NJJWj1gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7802

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

