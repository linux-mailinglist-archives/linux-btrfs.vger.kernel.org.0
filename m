Return-Path: <linux-btrfs+bounces-1051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965B81830C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23301C23813
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391051172A;
	Tue, 19 Dec 2023 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X+csPsZ6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UiP6CVGI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42AD2F5;
	Tue, 19 Dec 2023 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: be1ebe2c9e4511eeba30773df0976c77-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fqi5PuDextsAkD7mE0WzWDXEo497JH18SP1ZnS8/ZAQ=;
	b=X+csPsZ62wmYieeNlRlTipVC+/QuSxahRe1+twBBs+20VCKrGVcQo1M6QS7RRAto11xW7UIWSKoNKicAgcFjC7DrEhzB5v0nKPFuvu9tTngVS49VZfIFNnanp+CD7ynxcO7o7jjM43i/Yj41y3nswtxv8zmOgxaUA3tfyfhUoZ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3d9a3dd8-6ab3-424c-a483-e08deb3badce,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:0b7ad6fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be1ebe2c9e4511eeba30773df0976c77-20231219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 189787465; Tue, 19 Dec 2023 16:08:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 16:08:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 16:08:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U105SCWZMZIzfxpuTZadlYk1KZTctZQetMNrprB8oewzEhPUw8WKLL69nCTmIBz1Ot2rS4gVqZiQ7RD5mudGaOgjPFax5aKEsQ7A+xozwijAPO2PfdKBZN/ErMD2YPmhfK0MlHrFkhVHfaoLetyUEzNDmFozJzci2LQdULHgrN42vLQd2x0vOurCDe5TiMhJw+aOCO0vLUMZ2K34uwdZ1jz/fm/xkl5FX9HuFyrY3U3XU/7BCtelu+0BfWLMsKRdT5r4qUU5c3zYdN2FNm2RyAuDIEUMzyt8tFvjocWSOdwUl/UjT7WRTtw0wAjY5Xh3rN3hwQh1Wzq+AIHCD6IN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqi5PuDextsAkD7mE0WzWDXEo497JH18SP1ZnS8/ZAQ=;
 b=kfE9TxNMeXJfJ7wQA72jnrpAm809YTOhGUL6yNmixIv13tar5GMhHSShRfEVtuehyLL48FhKpJJAzHGMvBbh5Cs4wVTOrcA656NAYZWr/3+/j3OEf2lzSSpbMJ2tH+edmmNRZB+XSzJCHgy8+4K45Je61ckLoyP2Ro/wlLhINgBvRks+IZDwmChACZt9VTCHKhnlQmbMHCz9r4nGVQhTQD7roF2CxRF0XJicLSK3/Uk4N3hzfhFfpQldnJzBtPO7WGmuxHmpPWaLMtID+O143qbwPVglpds+QPq4IbU636vFKCCm10eCneJyp3VjpRgBSfF52KyP8o/JLGXJR0kMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqi5PuDextsAkD7mE0WzWDXEo497JH18SP1ZnS8/ZAQ=;
 b=UiP6CVGIkE7DgiQthlbR0SjYOJYSd9ecAKLReukMDTecbrH9q6J9YqnY9lnMUbMN6aHx0/UtFjdSnjjZc0xf/eQ6kSQdX3JuJl8dEEf+jumV49fj3mPENlQ5+NUQa4KdaZk3f8nXo0PzCoFPfPlkL3VhUDg0r2FpWCPZOD9RoXk=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 KL1PR03MB8403.apcprd03.prod.outlook.com (2603:1096:820:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 08:08:04 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:08:03 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "Naohiro.Aota@wdc.com" <Naohiro.Aota@wdc.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "stefanha@redhat.com"
	<stefanha@redhat.com>
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Thread-Topic: [PATCH 3/5] block: remove support for the host aware zone model
Thread-Index: AQHaMQnzmungF0TUfUKNyx6s0ULXRrCukLgAgAAK6ACAABiogIABgBeAgAAOhgA=
Date: Tue, 19 Dec 2023 08:08:03 +0000
Message-ID: <dbc4a5b4296effd88ba0ef939aa324df0969545c.camel@mediatek.com>
References: <20231217165359.604246-1-hch@lst.de>
	 <20231217165359.604246-4-hch@lst.de>
	 <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
	 <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
	 <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
	 <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq>
In-Reply-To: <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|KL1PR03MB8403:EE_
x-ms-office365-filtering-correlation-id: 71f96fa1-0bc5-44e2-4db8-08dc0069a031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIOwdUT0evgHVouyd3BbICALWNdrlC1ybgNvDHTsYIu4nakgUIUgdjKizFuyY6c0h5j1x7DvJTt3DFHHL5w5no7KVYhaFtlF/Hkwdf8ky63l6Ln7KtsGSqX/ER1gBuCguGut/WhlPxFdOb81GDOJmwyVpOLim+tlCeGQW/k1DFt98ar9812BqnLf5moYminlIVXxqYn2VO/FRgHlfYZ/Cn/fD4PfV1bekWliJ413N7QZQuML8w7tTNXl9W15vaH24L69Y0wO3e4xjJL12GIE51UbmExqKA6aFAcrcLiXZzkWHQ7AQgSlGHqxt09E2Gig6wfg1IGbtKntTbx0ts3Vl+nex4d62FqcSEsirDmI3jGMGxu9alrJTvhGJuQVtzfe4V+g7RLMw16FMjKsTm1EG03Y0TthICAmTPy4UK1iB49dMhhvkrYTypGN2y7OTgFoDOpKgAasqmhqozJK4esBBsftm5HfMSpokxjOJBWqXiWt+y5hkcrHz0JzycA24uGHbdIPkFmhltvgW3ClGCSp8WRUUTKld++laasXDe33ItlA+uVXsNIKtGFqi6Keslwtw/1HjZARc8P6aECVqiMKXSewaQ5dX9UwxYACZKjOzd3oXQ4PUAFJLjlu8178RmM1zdmRivV4yuCedC+6bz9H1nK1/6YZHNcVDiPPRxAxlYayi/4iofaT2ccudPYGIOX7GFXOu3lA1LZPSZBIR62AUnb4UhoRNqNxe6zQtnACnIE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(6506007)(8936002)(8676002)(71200400001)(66556008)(66476007)(66446008)(66946007)(316002)(6916009)(478600001)(6486002)(38100700002)(122000001)(41300700001)(2616005)(4001150100001)(26005)(83380400001)(2906002)(4326008)(76116006)(86362001)(85182001)(36756003)(64756008)(54906003)(91956017)(6512007)(38070700009)(53546011)(7416002)(5660300002)(76704002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hEbFY2dGtWZjhJNzRFSDhEQUJMMHJzWHFBWm0wTHh4eFhtTU92dXpCUjBT?=
 =?utf-8?B?NHpxcytvcHlNZGU1akRROSt3aUd3eExYKzU4bWhLK1lqaHBPUW1uRDJLWHpy?=
 =?utf-8?B?c2VaQ1Z5S3VoMlVRb2hFL2RUUXFPOThLNGtIeXBMNnJZUHh0dHN5S2YxZFpm?=
 =?utf-8?B?VkdaNldTZVN4OWNXbXFiRjJCdjFaMWsvV0YyUWZwTUhRajZTOERVUDQ4TVo3?=
 =?utf-8?B?cU9reGdLeTI1elluZXFDNmxjSG81QlI1Tmx5QU1lejlaMkRpRFlMWFV0ZkZa?=
 =?utf-8?B?MFV6SzVJZ0M4alZ6V1ZyOW1qaDVGYnZMZTdiU3cvenRYb3ZKTHNXQ1NuUkYy?=
 =?utf-8?B?V2hwYTQ5cmc4aW43Q0RPMHQvaVBZWUxCQkxsOThNdHAvamw0VUxHdWM5ZnZl?=
 =?utf-8?B?RzZMNVF5TDBpOUw0a09LZS9ncmRsZENubU4ySjA3UGR1a1M1WEhlQXlBaE9B?=
 =?utf-8?B?cXZkL1IvbmVyT1VFeHp2aVFnWUNBZHRxWVRuMmxld2VNc2lhenYwTnVTdjVP?=
 =?utf-8?B?M1o5MG1rREx4c1lJbU1EQndMa1I1b3lnUldob1N4OHgzcmkrbnlkVWdQNUtT?=
 =?utf-8?B?MDNOVnhCUXdBK0pMaUxoZ0d4Sk15SUFKOXdGTTRweUM2Y1Z0TE9zVXE2N3o0?=
 =?utf-8?B?QVVMdUo0QkRrYWFyRlJpTlVqVHFiNmgyaGhUeUQwcGFvcmpIUGVBakZHd1V5?=
 =?utf-8?B?SkcwQjFKYVNMdXljQXNxR3dBS2t0bzhpTmQzaDZScE9GN1F0MlEzZVpHU05l?=
 =?utf-8?B?cGN6Wk9HMFpsRlo0VWpUYmptSmVpckdieVR6YXR1Q2hBRnpONkQ4M3h4aFBS?=
 =?utf-8?B?cU4xeGZhd3RvMmdsNnNZSjdiUEwybDJJc3BsU2xLamxLRXA3UzRLQ0tpK3dD?=
 =?utf-8?B?YmgxaW5TajY4eHZxc3QwcGI5SENSTG9Wc0lybDRlMkk2SDM5VFhBQjhkTVdO?=
 =?utf-8?B?elVCdUpCcnA3NUk4ZkloTjd0OUNFelJrbGIwbzU2OFNicTFTTFZ4UlFoVHgz?=
 =?utf-8?B?a3hDYzlsenF4SHZSb3IyOTZSeVZRNkJYREsrajl4NXA3RU1md1VZQUhaWmdm?=
 =?utf-8?B?ZlFucHpzV3NFVWFlaUM1YVdaOU5IOFZDd1JJMlQwQ0dVRWFRR2FkM3lPRGZ5?=
 =?utf-8?B?ZXJLWGwxa3prMGZlRjBuUkVtTHJWZHppbURFdW4wVmFJUnlnbzd2WENLQjlk?=
 =?utf-8?B?cWJsVWpjRStWUk9LQnovRTdwYS9hMHlUUjZ0eUh4a3RVVVpoYzFQOGg2T1RS?=
 =?utf-8?B?eHl5V3RqUVRTemVwMkgySnRXQzViRE9kbTQvbGVMdlBoR25ESVdTRmhXZWZT?=
 =?utf-8?B?TlNxVk1RMkQyY01sSGZrN0lFaWZ4SkRVMXRnMStUdFFYRCs5TCttNURzSm1z?=
 =?utf-8?B?RzVaL01zbDJSZkVSa091OXdGd1BkaHJGT3RJMmQrSUplbEt3TTR5M1ZFQ2Z6?=
 =?utf-8?B?RDloZm5tV2wrbXg5QlRQYWlCNlhZZENUUDY1R2Z1SmR1L3BLTDFwcXVoUVRt?=
 =?utf-8?B?bldpNS9GMFFaMDN4RmtNVXpXYTljeFc2SVAzY3c0MjRwNmFIeHZnMFhabThk?=
 =?utf-8?B?MXFVOTRzbVppUTVKejlLTG9HRXVVelgxQmdTTzVMZFlLaHdWWUl0aTdiUEFj?=
 =?utf-8?B?Q1BtdnIyS0tPdGYzUGxkbnJ1NHErZ2kzc3VGbzhjQW9ZM0VlaUx5M2FEcVhS?=
 =?utf-8?B?aUZtaFhEa2lERGtrTHVyU0Zad2Exd1VnanM5d04ybFZmbm10UmJKUHRCekhC?=
 =?utf-8?B?TU9WRDlpeGNCd3ZIMlJMNGFHWVgwRmFVTlM0a2RrYU4rWXNXQTZjUGduTzB3?=
 =?utf-8?B?Wi9JT3VyekpzTS9NL3NGVUI1MGdSZkl0MytGODJnL05DM3hnNXlxV0lXcmM1?=
 =?utf-8?B?NTRvWjRaOUpCQ2lZZFFRMVUrejUzcjRtOW13V1ExZ2hRamVXNnBJT1BKMG5i?=
 =?utf-8?B?WG02Ymh2VzErTTMwZlAvVmxSdUxiOGwwaE42Z1RaS0pNUXdseEJRSm81TFF5?=
 =?utf-8?B?Vm9TT3djb3AyWTk3OTljQjMxMTRtRy9aUkRJckpIUytrbElPdFdpcmNkS1FL?=
 =?utf-8?B?SWJ5anFDKzI0Wi90SXliTFRFWXQwY3lsSVdyZFZmUkZDcy91WURvMW5pYmtv?=
 =?utf-8?B?RlpaSFNrUjlNZ0ZmaG9BWjNZd3lzUmhROVhSeWJGaUZGelBEQWpjQmYwVkNB?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B2147AFC3F8F74789094B874733C9F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f96fa1-0bc5-44e2-4db8-08dc0069a031
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 08:08:03.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCACFSPBzLjx73VNjQo9enFmEtBjJwx4TcVm1VlieMt/AFumpmfya2I6G4AX7A6gO+3C/Y3AVVOuzQ8vX2Nz9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8403
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--37.397200-8.000000
X-TMASE-MatchedRID: 2SDSohiwfqTUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCvg6JVNagPxEuHNkj91+t05+Mk6ACsw4JvUKr73HHTU4aUX
	s6FguVy3fgah7sKHg9vFjRYaB9JwD5klZmOW5FuOiAZ3zAhQYghSRa9qpSosfw01zN1c0miKXjm
	yK2W3kzTSx04qVd9Brp0n2j1ByEMgqvVOPrBalEAwfhKwa9GwD2yk8ad/lrSAkt9BigJAcVvj6M
	mrFFoU/N3OLy2u1nwOvxSlbcA6wU4w4KKK7/xalj5hLPCX3ZdPlNvCpVWkX43BF/Z15SOgL7ZGK
	jxi6EyUxJ6rawp6j1jLf6yEk9cqoSSOWVJeuO1DSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5
	d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--37.397200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E9576DAE46C9F059628CF9422F9F4BC7C0C210AB61E3C547BB30548320620D862000:8

T24gVHVlLCAyMDIzLTEyLTE5IGF0IDA3OjE2ICswMDAwLCBOYW9oaXJvIEFvdGEgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gTW9uLCBEZWMgMTgsIDIwMjMgYXQgMDg6MjE6MjJBTSArMDAwMCwg
RWQgVHNhaSAo6JSh5a6X6LuSKSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjMtMTItMTggYXQgMTU6
NTMgKzA5MDAsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiA+ID4gIE9uIDIwMjMvMTIvMTggMTU6
MTUsIEVkIFRzYWkgKOiUoeWul+i7kikgd3JvdGU6DQo+ID4gPiA+IEhpIENocmlzdG9waCwNCj4g
PiA+ID4gDQo+ID4gPiA+IHNvbWUgbWlub3Igc3VnZ2VzdGlvbnM6DQo+ID4gPiA+IA0KPiA+ID4g
PiBPbiBTdW4sIDIwMjMtMTItMTcgYXQgMTc6NTMgKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdy
b3RlOg0KPiA+ID4gPj4NCj4gPiA+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21kL2RtLXRhYmxl
LmMgYi9kcml2ZXJzL21kL2RtLXRhYmxlLmMNCj4gPiA+ID4+IGluZGV4IDE5OGQzOGI1MzMyMmMx
Li4yNjBiNWI4ZjJiMGQ3ZSAxMDA2NDQNCj4gPiA+ID4+IC0tLSBhL2RyaXZlcnMvbWQvZG0tdGFi
bGUuYw0KPiA+ID4gPj4gKysrIGIvZHJpdmVycy9tZC9kbS10YWJsZS5jDQo+ID4gPiA+PiBAQCAt
MTU3OSwyMSArMTU3OSwxOCBAQCBib29sDQo+IGRtX3RhYmxlX2hhc19ub19kYXRhX2RldmljZXMo
c3RydWN0DQo+ID4gPiA+PiBkbV90YWJsZSAqdCkNCj4gPiA+ID4+ICByZXR1cm4gdHJ1ZTsNCj4g
PiA+ID4+ICB9DQo+ID4gPiA+PiAgDQo+ID4gPiA+PiAtc3RhdGljIGludCBkZXZpY2Vfbm90X3pv
bmVkX21vZGVsKHN0cnVjdCBkbV90YXJnZXQgKnRpLA0KPiBzdHJ1Y3QNCj4gPiA+ID4+IGRtX2Rl
diAqZGV2LA0KPiA+ID4gPj4gLSAgc2VjdG9yX3Qgc3RhcnQsIHNlY3Rvcl90IGxlbiwgdm9pZA0K
PiA+ID4gPj4gKmRhdGEpDQo+ID4gPiA+PiArc3RhdGljIGludCBkZXZpY2Vfbm90X3pvbmVkKHN0
cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QNCj4gZG1fZGV2DQo+ID4gPiA+PiAqZGV2LA0KPiA+
ID4gPj4gKyAgICBzZWN0b3JfdCBzdGFydCwgc2VjdG9yX3QgbGVuLCB2b2lkICpkYXRhKQ0KPiA+
ID4gPj4gIHsNCj4gPiA+ID4+IC1zdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1
ZXVlKGRldi0+YmRldik7DQo+ID4gPiA+PiAtZW51bSBibGtfem9uZWRfbW9kZWwgKnpvbmVkX21v
ZGVsID0gZGF0YTsNCj4gPiA+ID4+ICtib29sICp6b25lZCA9IGRhdGE7DQo+ID4gPiA+PiAgDQo+
ID4gPiA+PiAtcmV0dXJuIGJsa19xdWV1ZV96b25lZF9tb2RlbChxKSAhPSAqem9uZWRfbW9kZWw7
DQo+ID4gPiA+PiArcmV0dXJuIGJkZXZfaXNfem9uZWQoZGV2LT5iZGV2KSAhPSAqem9uZWQ7DQo+
ID4gPiA+PiAgfQ0KPiA+ID4gPj4gIA0KPiA+ID4gPj4gIHN0YXRpYyBpbnQgZGV2aWNlX2lzX3pv
bmVkX21vZGVsKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QNCj4gPiA+IGRtX2Rldg0KPiA+
ID4gPj4gKmRldiwNCj4gPiA+ID4+ICAgc2VjdG9yX3Qgc3RhcnQsIHNlY3Rvcl90IGxlbiwgdm9p
ZA0KPiA+ID4gPj4gKmRhdGEpDQo+ID4gPiA+IA0KPiA+ID4gPiBTZWVtcyBsaWtlIHRoZSB3b3Jk
ICJtb2RlbCIgc2hvdWxkIGFsc28gYmUgcmVtb3ZlIGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPj4g
IHsNCj4gPiA+ID4+IC1zdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1ZXVlKGRl
di0+YmRldik7DQo+ID4gPiA+PiAtDQo+ID4gPiA+PiAtcmV0dXJuIGJsa19xdWV1ZV96b25lZF9t
b2RlbChxKSAhPSBCTEtfWk9ORURfTk9ORTsNCj4gPiA+ID4+ICtyZXR1cm4gYmRldl9pc196b25l
ZChkZXYtPmJkZXYpOw0KPiA+ID4gPj4gIH0NCj4gPiA+ID4+ICANCj4gPiA+ID4+ICAvKg0KPiA+
ID4gPj4gQEAgLTE2MDMsOCArMTYwMCw3IEBAIHN0YXRpYyBpbnQgZGV2aWNlX2lzX3pvbmVkX21v
ZGVsKHN0cnVjdA0KPiA+ID4gPj4gZG1fdGFyZ2V0ICp0aSwgc3RydWN0IGRtX2RldiAqZGV2LA0K
PiA+ID4gPj4gICAqIGhhcyB0aGUgRE1fVEFSR0VUX01JWEVEX1pPTkVEX01PREVMIGZlYXR1cmUg
c2V0LCB0aGUNCj4gZGV2aWNlcw0KPiA+ID4gY2FuDQo+ID4gPiA+PiBoYXZlIGFueQ0KPiA+ID4g
Pj4gICAqIHpvbmVkIG1vZGVsIHdpdGggYWxsIHpvbmVkIGRldmljZXMgaGF2aW5nIHRoZSBzYW1l
IHpvbmUNCj4gc2l6ZS4NCj4gPiA+ID4+ICAgKi8NCj4gPiA+ID4+IC1zdGF0aWMgYm9vbCBkbV90
YWJsZV9zdXBwb3J0c196b25lZF9tb2RlbChzdHJ1Y3QgZG1fdGFibGUgKnQsDQo+ID4gPiA+PiAt
ICBlbnVtIGJsa196b25lZF9tb2RlbA0KPiA+ID4gPj4gem9uZWRfbW9kZWwpDQo+ID4gPiA+PiAr
c3RhdGljIGJvb2wgZG1fdGFibGVfc3VwcG9ydHNfem9uZWQoc3RydWN0IGRtX3RhYmxlICp0LCBi
b29sDQo+ID4gPiB6b25lZCkNCj4gPiA+ID4+ICB7DQo+ID4gPiA+PiAgZm9yICh1bnNpZ25lZCBp
bnQgaSA9IDA7IGkgPCB0LT5udW1fdGFyZ2V0czsgaSsrKSB7DQo+ID4gPiA+PiAgc3RydWN0IGRt
X3RhcmdldCAqdGkgPSBkbV90YWJsZV9nZXRfdGFyZ2V0KHQsIGkpOw0KPiA+ID4gPj4gQEAgLTE2
MjMsMTEgKzE2MTksMTEgQEAgc3RhdGljIGJvb2wNCj4gPiA+ID4+IGRtX3RhYmxlX3N1cHBvcnRz
X3pvbmVkX21vZGVsKHN0cnVjdCBkbV90YWJsZSAqdCwNCj4gPiA+ID4+ICANCj4gPiA+ID4+ICBp
ZiAoZG1fdGFyZ2V0X3N1cHBvcnRzX3pvbmVkX2htKHRpLT50eXBlKSkgew0KPiA+ID4gPj4gIGlm
ICghdGktPnR5cGUtPml0ZXJhdGVfZGV2aWNlcyB8fA0KPiA+ID4gPj4gLSAgICB0aS0+dHlwZS0+
aXRlcmF0ZV9kZXZpY2VzKHRpLA0KPiA+ID4gPj4gZGV2aWNlX25vdF96b25lZF9tb2RlbCwNCj4g
PiA+ID4+IC0gICAgICAmem9uZWRfbW9kZWwpKQ0KPiA+ID4gPj4gKyAgICB0aS0+dHlwZS0+aXRl
cmF0ZV9kZXZpY2VzKHRpLA0KPiA+ID4gPj4gZGV2aWNlX25vdF96b25lZCwNCj4gPiA+ID4+ICsg
ICAgICAmem9uZWQpKQ0KPiA+ID4gPj4gIHJldHVybiBmYWxzZTsNCj4gPiA+ID4+ICB9IGVsc2Ug
aWYgKCFkbV90YXJnZXRfc3VwcG9ydHNfbWl4ZWRfem9uZWRfbW9kZWwodGktDQo+ID4gPiA+Pj4g
dHlwZSkpIHsNCj4gPiA+ID4+IC1pZiAoem9uZWRfbW9kZWwgPT0gQkxLX1pPTkVEX0hNKQ0KPiA+
ID4gPj4gK2lmICh6b25lZCkNCj4gPiA+ID4+ICByZXR1cm4gZmFsc2U7DQo+ID4gPiA+PiAgfQ0K
PiA+ID4gPj4gIH0NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBwYXJhbWV0ZXIgImJvb2wgem9uZWQi
IGlzIHJlZHVuZGFudC4gSXQgc2hvdWxkIGJlIHJlbW92ZWQNCj4gZnJvbQ0KPiA+ID4gdGhlDQo+
ID4gPiA+IGFib3ZlIDMgZnVuY3Rpb25zDQo+ID4gDQo+ID4gVGhlIHR3byBmdW5jLCBpcyB6b25l
ZCBhbmQgbm90IHpvbmVkLCBhcmUgZXNzZW50aWFsbHkgdGhlIHNhbWUuDQo+IFRoZXkNCj4gPiBj
YW4gYmUgc2ltcGxpZmllZCBpbnRvIG9uZSBmdW5jdGlvbi4NCj4gDQo+IEJvdGggZnVuY3Rpb25z
IGFyZSB1c2VkIGZvciBpdGVyYXRlX2RldmljZXMncyBjYWxsYmFjayBpbg0KPiBkbV90YWJsZV9z
dXBwb3J0c196b25lZF9tb2RlbCgpLiBBcyBzaG93biBpbiByYWlkX2l0ZXJhdGVfZGV2aWNlcygp
LA0KPiBpdGVyYXRlX2RldmljZXMoKSByZXR1cm5zIDAgaWYgdGhlIGNhbGxiYWNrIGZ1bmMgY2Fs
bHMgb24gYWxsIHRoZQ0KPiBkZXZpY2VzDQo+IHJldHVybnMgMCwgb3IgcmV0dXJucyBhIG5vbi16
ZXJvIHJlc3VsdCBlYXJseSBvdGhlcndpc2UuIFNvLCB0aGUNCj4gaXRlcmF0ZV9kZXZpY2VzKCkg
Y2FsbCByZXR1cm5zICJ0cnVlIiBpZiBhbnkgb25lIG9mIHRoZSB1bmRlcmx5aW5nDQo+IGRldmlj
ZXMNCj4gaXMgKHpvbmVkfG5vdCB6b25lZCkuDQo+IA0KPiBTaW5jZSB3ZSBjYW5ub3QgY3JlYXRl
IGxhbWJkYSBhcyBpbiBvdGhlciBmYW5jeSBsYW5ndWFnZXMsIHdlIG5lZWQNCj4gdHdvDQo+IGZ1
bmN0aW9ucy4uLg0KDQpOb3QgcmVhbGx5LCB0aGVyZSBpcyBhICJ2b2lkICpkYXRhIiBjYW4gYmUg
dXNlZC4NCg0KVGhlIGRldmljZV9pc196b25lZF9tb2RlbCgpIGlzIGp1c3QgdGhlIHNhbWUgYXMg
dGhlIGRldmljZV9ub3Rfem9uZWQoKQ0Kd2l0aCAoYm9vbCAqKWRhdGEgPSBmYWxzZS4NCg0KSXQn
cyB2ZXJ5IG1pbm9yLCBzbyBpcyBva2F5IHRvIGlnbm9yZSBteSBwcmVmZXJlbmNlLg0K

