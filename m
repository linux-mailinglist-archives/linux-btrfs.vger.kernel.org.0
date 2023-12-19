Return-Path: <linux-btrfs+bounces-1049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A448818219
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 08:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1321C23434
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C812B6E;
	Tue, 19 Dec 2023 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZtmiD7n3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CTb7Xv28"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7B11725;
	Tue, 19 Dec 2023 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702970180; x=1734506180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rfRD4ignYJ/VAkAxEjOqQbVl1zMT3CB1I5tBCo+vOco=;
  b=ZtmiD7n3jOb97xNu6CwknGxualDJQ+s7YlyuORyFy0/yYyxe/TnFsNLz
   lJfTMJN3+O5nLpdXwmmtODdsECubsZzNAJcmjX132DuI1VKewn3pR1gy4
   xDaCNAJFmwFfzeT6mucMN7dMawnFJy/dopaNsoYDBpQf/TRrEstmi+ZS6
   oOp26QfjX1h48gm88aYPlMrCbfWnX0sOaoVB2PM47KcIQxGx9SlLAQpvY
   ZszYlMvvSte7W4y0jEE4TniOHCGy9TBu0rr4hPXql43PSFmnFc71QqUvq
   c1j4JY6pHneo01YWbO2yoTKk9gV7fzOZl68JP9ABgVN6DBe+fYrTRGQwJ
   w==;
X-CSE-ConnectionGUID: 4Ab4igGMR8yNQZkBD14tKg==
X-CSE-MsgGUID: tSbngy/zR6C8KGdt8Iii7w==
X-IronPort-AV: E=Sophos;i="6.04,287,1695657600"; 
   d="scan'208";a="5378561"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 15:16:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7UBPHpzhq4nXLDi87Q8aUnurL6QAVQwpEr+LEudov/ejHxr01DkIEbx7ZHnGFrgI9Ch9KTMKvo2ZOqI5TjmOOGwtxGji36Jq96go0pBldeAyi46F2anoHhKuoroZG6px85hZK+F/xR8WnGzS/Mye7KWiE7DnPLt7BdKcWYhNtego6Mbyzxat/B2157m5nm+ukSXPoeUI4xSKx5lcQhg2qO56b1cu8/lXnT80YscomZmCR8SzwEr1jqTxwAd8g0BLv/VeWZLCbFQRoJtes0OKGoZ+fGQ8JgVig9PdC7O7aGUsUUEivh4eeVj9F5bZHGiWnz427glLJfX3XuvUBdbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfRD4ignYJ/VAkAxEjOqQbVl1zMT3CB1I5tBCo+vOco=;
 b=ipGd/rEUuMhKoiaz1ayCEzQ5DSjOU7C5uvtvzQFwNMJeqIKbp0no8CPmOniLvEF4bEGd3PInyBgjh+OFaBb4j3w8XcSnngR6vASW8c44AEbDvtuWMBho+xm63oh1UlGOqvD/Lcx1wV6UHUKfJv6s20aaGEnHkIfWd+HK+TI79XhT3awCPQX/negW8/q4RB1ZdmTNhiuj2tu7Y/EJaQJosAqpYEZiP2jucS8ZyH8lgjooCeStFA5AouZh9aqYXTDjmaSc/yQqgD2NGio1DN+S87HpPOR0MiCkZSB1Yt5KKr4n1Tr7tozUvr/xPyewGWDxpRqq/Ipa0QAqshU3OX6sKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfRD4ignYJ/VAkAxEjOqQbVl1zMT3CB1I5tBCo+vOco=;
 b=CTb7Xv28JQKFiYGeJzkL4SuvKdClEbktj7kkbXbkQbnXtH2zLn5g9fG+0qBn4bmSIUhzmsUJGBBGrp+k4EDq1ww2A5aE877AdxDrAQmYBPxJQxEi009PXlOx3AjS2MULruilptrqMM20uTzAQhFzi8zQ4r/+7+IFRwygY725V3k=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7214.namprd04.prod.outlook.com (2603:10b6:a03:2a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.39; Tue, 19 Dec
 2023 07:16:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:16:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
CC: "hch@lst.de" <hch@lst.de>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
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
Thread-Index: AQHaMQnyRLw8vgdvyEaqeES04tuEZrCukQcAgAAKmQCAABiqAIABgBMA
Date: Tue, 19 Dec 2023 07:16:03 +0000
Message-ID: <do3ekgymdpa4skyz5p3dp6qcqq7zuty73qrpmftszmffunnxpm@fyswyalaxzfq>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-4-hch@lst.de>
 <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
 <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
 <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
In-Reply-To: <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7214:EE_
x-ms-office365-filtering-correlation-id: 4b36fa95-9e24-4c2c-e790-08dc00625c61
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(53546011)(71200400001)(33716001)(26005)(122000001)(38100700002)(8676002)(4326008)(8936002)(5660300002)(41300700001)(7416002)(2906002)(4001150100001)(478600001)(6486002)(66446008)(6506007)(6512007)(9686003)(66476007)(54906003)(64756008)(66556008)(66946007)(76116006)(91956017)(316002)(6916009)(86362001)(82960400001)(38070700009)(76704002)(27256008);DIR:OUT;SFP:1501;
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGRpajB3aDkreVhUYmlpVlZuaUdudGxCeTBZZUJVWkVBY3BlUTdCa3pGTk9m?=
 =?utf-8?B?ME9uSFgrZkt0Z0owVWUvdisyUkdhaDZ5WWZxUFdURGhRKzMreWJFdHROK1Ez?=
 =?utf-8?B?a1lYYVlQQ2d1cDBHcENmQTgxL1FmS3JidURpTkM5cGdrTVhXRlh3QmUvdHJt?=
 =?utf-8?B?UjI2cHA3SjZqWlhMU3BvYkpZa09sVmtmNm1ZR3Y0bU05U3IxQWdlR2hTN204?=
 =?utf-8?B?bnNmOVp4Smd3dFBwSzM2R0p5eGFCZHNGUW1pVDZ3eUFBMWRMb1ZrbmdXbWpy?=
 =?utf-8?B?M2hyVHpIOUdwbitWcXBNVXJLbnVSUzVLaEZpN2Z4RmkxQm9aUEZoNjMrenZI?=
 =?utf-8?B?MmQweC9VUFIxOTlIN1dBTGhtRmJQZzFpN0xpeUtDQWxjNXJDWE15cnJvcnlI?=
 =?utf-8?B?L0lMOFMvb255NGQ5bTV4Sk5TZXpIRmpZcW80Sko5Skt3NnFaeVdRN1lsUFcz?=
 =?utf-8?B?Z09VcEFRM1AvZ3pvcGZsdGVDVVRGNUxMcHZla1JhTFFxUG9rZVFxSFdRZGlF?=
 =?utf-8?B?QVhjNWEvajl6OThadWlURWxQNENqcWYzUWEvd3puMHBLVGp2dGdHNzgyQVly?=
 =?utf-8?B?ZktiYUxvRVhOSlVCam5MNXFTK2tUUmVjekRJMENxVnZIblh4QWlHVDVySzlK?=
 =?utf-8?B?akVGRkZ0Z3ZiMm1oTkYwZ0RJQWV6eVRXeVkvTEhpUHJGMkZjSndBM0NsTjN4?=
 =?utf-8?B?Y0s4dGczSytRY1oxaXZDWmZid3IwTmcycy9nZk5zS1c0YjgwMWRmRWJIazhl?=
 =?utf-8?B?TXFQNlNqZFg4cHZ2bTgwb3prd0c2SFRLYVBhclBvc1hRNW91VTZGejFIcnRE?=
 =?utf-8?B?VHJwM2lyRXcxbFRIdHBDd00vWkpWSm82TEhES25VUkIyS2pyOEwyQTdtWkR4?=
 =?utf-8?B?UWgveXhBejFKaVhXWlZ5QU9paVFpUHRyTnhpd09lQTVQV0t0elRwQXRwSG92?=
 =?utf-8?B?ckNtNXFLVERybWo5MHRqbGlwQm42Z2lnN0dhRTN1cXNtbVQ1L0tpeDZOc1d6?=
 =?utf-8?B?RFVYYWhOTHdmcHlpSmJyaEYrNXU4Z3dMUVdyZzU0SnlRTjh5ekllSWFYOXUv?=
 =?utf-8?B?SVpCTDhvaEpPUit4WjVkRFl1dnhEb1RpeC9GUlFpaXNoS3luK3JpT3NlOGZZ?=
 =?utf-8?B?YUVpTCt1NFMycEFuNHJ2QlhzdHdTVEdIQzk1MkRNemI4WklNdkpoemU5ZFlL?=
 =?utf-8?B?TTcrbDFwbkJFc0R1ekdvcDlNYzhLVkl0LzJhSnFjaW96aDltOXRZenRScnl6?=
 =?utf-8?B?b2dTSHNkZGdnSjlVak5WWGFaQmNOWGQzY3hTUjM5blowNyt2OENvMjFKNEE1?=
 =?utf-8?B?K3owTHZXanl4ODcwRVVnbzMrRHdnWFcxQ2RCRVJCbnA3cDY4N2xreFBmZFF5?=
 =?utf-8?B?aysxNlBEeVVpekwxQ3N0TWd0RndEL0V5U3dQaUVPd09WeEE1eGxYbGk3SENV?=
 =?utf-8?Q?V0ZO/91/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RCtHaEJxV2pmMXc5TW1Ccmt2NmREcUJSeCs2VjM0TmwrdjkrRlpsU1dwU1dJ?=
 =?utf-8?B?czFBdXlPSUpiVEZ0U1ZJV3hncjdqQzhFWi82Vm5aUG1GUFdIOTlyM2lhY2RG?=
 =?utf-8?B?UVJOWWh2bm9HWkRGaDR5a2tXeWZBamduazR4cjhDVlQvbkl3dkZ6bzBIbUlY?=
 =?utf-8?B?ajlkZUZFd0ZZU05ORjhxWUtWSVdpSnU3c3hBcG9sN3VRdFBDS0QyQkxrWk1l?=
 =?utf-8?B?WmJrbFo3RXZyeEc4WnViZCs4ZUZyMksyLys0TDJhWlRIWXppNW83QWh5VUpC?=
 =?utf-8?B?TnpwMnlaTXRTelhwd21tY3RiVE41Q0N4a2R4OHBVLzMxZDk4SnRoWHI5dkhw?=
 =?utf-8?B?U2ZpZ3ZKNWZrd2VZZnptditlS3AxVWt4ZlJhT2N1a0ppb2FMSm1jVlc5R0F1?=
 =?utf-8?B?SHU0ZGRPTjB1SUhEQS90RlZqUVlORjhqSlh2VTR3RzVMWFdEM0VnS0JNa252?=
 =?utf-8?B?alpnTmcyU1ZZL1Z4dkJqa3d4dkNuVkdHeE54Q0lNTVhpcTRZR0tlV3UvNVdk?=
 =?utf-8?B?NDhXSG40cHhHYjFMM1dYMmdkeFJ5UG1IVkNjZzhsWU82a3hyTWwrOVRqVTRX?=
 =?utf-8?B?MkhsZEtPTDVjMEpUM2ZBYU5DbzBIR1NqZllGZ0lHRFp3RGkvMWhKN0JWVysr?=
 =?utf-8?B?V1lKS0dWU2I3RUlhT3NKRzZuUExYcklqMEhRTG9pek9aKzdjblQzS3djZDhm?=
 =?utf-8?B?V01IOW9nVXFSRkIxNEtuK0ZkbmNpdVhhMW5sTERJeEFFb2xOTzMyKzM5TVlI?=
 =?utf-8?B?ay9CN2pvTTYvZXF4Wm9vRTdhemQ5S3ljTkxpNTBJSkVROHBGSlJ5RWE1a1Bw?=
 =?utf-8?B?UVVPWTJoS1Nza2ROR0VPVzl3d0N0TFNydnNVd3loVXBsd2RydnJrZUNrUmlE?=
 =?utf-8?B?VmJqUUJEK3RteWd3Z1NPc0diOUpPWngyeDYwUjkwSDFBRDA4SXVCd1lxSXd4?=
 =?utf-8?B?alU1VVk5MDRUcDV4a3RtTloyMkMrR1ZhTVRWNVBSQVAwR0JOZmlGVVZkRnNP?=
 =?utf-8?B?N1NlZTc3c1VibXJLRm8zM2pNd0M0LzdhU3o2clVRaFZjUWRid3NwQm1NTHJm?=
 =?utf-8?B?OHp4aktKVzVWMXNSYkQ3Y1QwdW9lUEx4K2FXRGtVQWxPMmpHOVpTZVNUVmc5?=
 =?utf-8?B?Tkg4U0ZJVzhWcHBKS042M2lsRDhvTW1DVVpoeGNINGtraHF6VVRWZVRVdW5l?=
 =?utf-8?B?bGVmZVpORER2VEtIVk5kUVdqWUUreVljR1MzU2o2MlozVXYrczU2UGdQMWFZ?=
 =?utf-8?B?LzB2ZnlWYWpTOGxReWpMbEUrd0ttcEd6VldxMjdZQ1RlYzY4OHhVUFg2T3kv?=
 =?utf-8?B?VnVCWisvWjhOb29KdEEwN2lvbEtYQzE1UDJNcFFGSDFhMG1IeTIxaHVTOGZP?=
 =?utf-8?B?TkMvRURtUFl2YWV1ZUt1QlRmTjR5QmkrK1RpS2NVbU11WFVmVGNLLy92Y29G?=
 =?utf-8?B?d1g1YkNEY0RlS2IvMVhIR3grTXAxRU5YcTVKV09DamRQcGJKdElzWGZFNnRl?=
 =?utf-8?B?aGRUaStic2ZRN29MNmxpUkN5L2xLeXIxSUpMd0F6Rko3TWNPbzlKMUFyeXcy?=
 =?utf-8?B?VjhSa1pXMnR3UkgxQStrWFI4WlNFTE9MNTBqMi9CVlJFdHVnNUdRM2FodHhq?=
 =?utf-8?B?ZWdsVDZHeGVBUllhL2FGZEVDeGpjdDFNNnpOdHQrdTYwaG8xRFE5N3d0czQw?=
 =?utf-8?B?dDVWc2dTNlkrRFhwcXFpQUIreTc2VmU0eTB2Q0FsUUxLMlRaQVd6N1c0ZzA0?=
 =?utf-8?B?bkhMRkQ4QTRWcXlFL0w1WUllTGR6YUFRaWNuQlRmQVNyN3NQcTR0cjk0VERr?=
 =?utf-8?B?THVtSmxKSVUyQzFTQStJcHFPRko0SVBLQmFmaHJLdHRIVmFpRE9mMGtLaDBi?=
 =?utf-8?B?QlZUdWM4TEp0Y3hVeU1GNlFTTFdzMTk0eFRjcUJDNG1FWUFLR1V5bkVQc0Q4?=
 =?utf-8?B?NExiNm5EY3krYWZEa1pCM256UTVCMmcwdTJRRkNLbEpDQlF5WkljVHJSVkRI?=
 =?utf-8?B?RCtpRjJvRm5MdDYzMFdQSmJhd1dmRWYyV3ZuUmN2emdOSHdydmErOURqcXJM?=
 =?utf-8?B?VUFaZXN3dDJOcW44dmFrWHhmRjlhQzlXTi9jRGJiVHRVK0N4NnZkTUl0NTFD?=
 =?utf-8?B?M2QxVVQvblVoVjRZWGxiaE0zdGdLUDhmM1ZaWEgzb0NCeXBhaXIyWG5KWVl0?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <205D953ADCBB3145BB727AAD0BD1F1CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kGoSDMNr6LWgawtUz5V/TbU32+1Uo84dWFkdENba87XkzkReQRTWza2CykZWGsd/WA6rNeLiqBReAx0R1LbyttswoOY7SOoCBg3GJ1WaN5l2rhCsxKqzl48j+XKE9Nv0+EIxPzgegpYdBSZlDWUtK6eqTI0cvuuAjrdKh0IHm6O7ZE/i47xgCSndLorMYI2Otat0B7cio/5G2M193dyNN52b5LsBs9gbPqc5W9bPTTZPT1R3BGPEHoyhexpMVvQ26+3WlMNcFUIKYgd59CaF6HukCLwIZLOzFDBkZJWN30pLgpIirKBGAMmj8XKC+SPC5lDvM0ZCZeMoruU/OA1od4NtSO16S54YPsXOgC/7xIfOIsOH22JDaM8oJiACJ7QqQGe8+qx2HTrafqeT3u7GDP1aJO93Hi5sJa35KfE64NwNx99lnLky7kB0DksdBW84s9ewiNTXChz/GgXH5Nbxu7taH2BLyqfT8nFRSnCSWHDAKrXV4CzbUOW9E8JOtSBgJQZ4/uNh41wtH7b8iP9xadDGN8xRJaP4JD7oOWhJwJFB9U0maMjj9zXJ7xO+LlsrmZuO5V3MFtb2vIFfAGozwSkGyDUUsjoS8F9yuBFoENVb70rIPwoliZKtvW0xTuT1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b36fa95-9e24-4c2c-e790-08dc00625c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 07:16:03.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmNM4QmH1MyJps4qCWqdM6DFUeY4wyb05BVuO1jK5x4NQyYU4gf3XHj8WzkJLrJwhgHHz/zP4WTv+UrdPg0NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7214

T24gTW9uLCBEZWMgMTgsIDIwMjMgYXQgMDg6MjE6MjJBTSArMDAwMCwgRWQgVHNhaSAo6JSh5a6X
6LuSKSB3cm90ZToNCj4gT24gTW9uLCAyMDIzLTEyLTE4IGF0IDE1OjUzICswOTAwLCBEYW1pZW4g
TGUgTW9hbCB3cm90ZToNCj4gPiAgT24gMjAyMy8xMi8xOCAxNToxNSwgRWQgVHNhaSAo6JSh5a6X
6LuSKSB3cm90ZToNCj4gPiA+IEhpIENocmlzdG9waCwNCj4gPiA+IA0KPiA+ID4gc29tZSBtaW5v
ciBzdWdnZXN0aW9uczoNCj4gPiA+IA0KPiA+ID4gT24gU3VuLCAyMDIzLTEyLTE3IGF0IDE3OjUz
ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21kL2RtLXRhYmxlLmMgYi9kcml2ZXJzL21kL2RtLXRhYmxlLmMNCj4gPiA+
PiBpbmRleCAxOThkMzhiNTMzMjJjMS4uMjYwYjViOGYyYjBkN2UgMTAwNjQ0DQo+ID4gPj4gLS0t
IGEvZHJpdmVycy9tZC9kbS10YWJsZS5jDQo+ID4gPj4gKysrIGIvZHJpdmVycy9tZC9kbS10YWJs
ZS5jDQo+ID4gPj4gQEAgLTE1NzksMjEgKzE1NzksMTggQEAgYm9vbCBkbV90YWJsZV9oYXNfbm9f
ZGF0YV9kZXZpY2VzKHN0cnVjdA0KPiA+ID4+IGRtX3RhYmxlICp0KQ0KPiA+ID4+ICByZXR1cm4g
dHJ1ZTsNCj4gPiA+PiAgfQ0KPiA+ID4+ICANCj4gPiA+PiAtc3RhdGljIGludCBkZXZpY2Vfbm90
X3pvbmVkX21vZGVsKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QNCj4gPiA+PiBkbV9kZXYg
KmRldiwNCj4gPiA+PiAtICBzZWN0b3JfdCBzdGFydCwgc2VjdG9yX3QgbGVuLCB2b2lkDQo+ID4g
Pj4gKmRhdGEpDQo+ID4gPj4gK3N0YXRpYyBpbnQgZGV2aWNlX25vdF96b25lZChzdHJ1Y3QgZG1f
dGFyZ2V0ICp0aSwgc3RydWN0IGRtX2Rldg0KPiA+ID4+ICpkZXYsDQo+ID4gPj4gKyAgICBzZWN0
b3JfdCBzdGFydCwgc2VjdG9yX3QgbGVuLCB2b2lkICpkYXRhKQ0KPiA+ID4+ICB7DQo+ID4gPj4g
LXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0gYmRldl9nZXRfcXVldWUoZGV2LT5iZGV2KTsNCj4g
PiA+PiAtZW51bSBibGtfem9uZWRfbW9kZWwgKnpvbmVkX21vZGVsID0gZGF0YTsNCj4gPiA+PiAr
Ym9vbCAqem9uZWQgPSBkYXRhOw0KPiA+ID4+ICANCj4gPiA+PiAtcmV0dXJuIGJsa19xdWV1ZV96
b25lZF9tb2RlbChxKSAhPSAqem9uZWRfbW9kZWw7DQo+ID4gPj4gK3JldHVybiBiZGV2X2lzX3pv
bmVkKGRldi0+YmRldikgIT0gKnpvbmVkOw0KPiA+ID4+ICB9DQo+ID4gPj4gIA0KPiA+ID4+ICBz
dGF0aWMgaW50IGRldmljZV9pc196b25lZF9tb2RlbChzdHJ1Y3QgZG1fdGFyZ2V0ICp0aSwgc3Ry
dWN0DQo+ID4gZG1fZGV2DQo+ID4gPj4gKmRldiwNCj4gPiA+PiAgIHNlY3Rvcl90IHN0YXJ0LCBz
ZWN0b3JfdCBsZW4sIHZvaWQNCj4gPiA+PiAqZGF0YSkNCj4gPiA+IA0KPiA+ID4gU2VlbXMgbGlr
ZSB0aGUgd29yZCAibW9kZWwiIHNob3VsZCBhbHNvIGJlIHJlbW92ZSBoZXJlLg0KPiA+ID4gDQo+
ID4gPj4gIHsNCj4gPiA+PiAtc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBiZGV2X2dldF9xdWV1
ZShkZXYtPmJkZXYpOw0KPiA+ID4+IC0NCj4gPiA+PiAtcmV0dXJuIGJsa19xdWV1ZV96b25lZF9t
b2RlbChxKSAhPSBCTEtfWk9ORURfTk9ORTsNCj4gPiA+PiArcmV0dXJuIGJkZXZfaXNfem9uZWQo
ZGV2LT5iZGV2KTsNCj4gPiA+PiAgfQ0KPiA+ID4+ICANCj4gPiA+PiAgLyoNCj4gPiA+PiBAQCAt
MTYwMyw4ICsxNjAwLDcgQEAgc3RhdGljIGludCBkZXZpY2VfaXNfem9uZWRfbW9kZWwoc3RydWN0
DQo+ID4gPj4gZG1fdGFyZ2V0ICp0aSwgc3RydWN0IGRtX2RldiAqZGV2LA0KPiA+ID4+ICAgKiBo
YXMgdGhlIERNX1RBUkdFVF9NSVhFRF9aT05FRF9NT0RFTCBmZWF0dXJlIHNldCwgdGhlIGRldmlj
ZXMNCj4gPiBjYW4NCj4gPiA+PiBoYXZlIGFueQ0KPiA+ID4+ICAgKiB6b25lZCBtb2RlbCB3aXRo
IGFsbCB6b25lZCBkZXZpY2VzIGhhdmluZyB0aGUgc2FtZSB6b25lIHNpemUuDQo+ID4gPj4gICAq
Lw0KPiA+ID4+IC1zdGF0aWMgYm9vbCBkbV90YWJsZV9zdXBwb3J0c196b25lZF9tb2RlbChzdHJ1
Y3QgZG1fdGFibGUgKnQsDQo+ID4gPj4gLSAgZW51bSBibGtfem9uZWRfbW9kZWwNCj4gPiA+PiB6
b25lZF9tb2RlbCkNCj4gPiA+PiArc3RhdGljIGJvb2wgZG1fdGFibGVfc3VwcG9ydHNfem9uZWQo
c3RydWN0IGRtX3RhYmxlICp0LCBib29sDQo+ID4gem9uZWQpDQo+ID4gPj4gIHsNCj4gPiA+PiAg
Zm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCB0LT5udW1fdGFyZ2V0czsgaSsrKSB7DQo+ID4g
Pj4gIHN0cnVjdCBkbV90YXJnZXQgKnRpID0gZG1fdGFibGVfZ2V0X3RhcmdldCh0LCBpKTsNCj4g
PiA+PiBAQCAtMTYyMywxMSArMTYxOSwxMSBAQCBzdGF0aWMgYm9vbA0KPiA+ID4+IGRtX3RhYmxl
X3N1cHBvcnRzX3pvbmVkX21vZGVsKHN0cnVjdCBkbV90YWJsZSAqdCwNCj4gPiA+PiAgDQo+ID4g
Pj4gIGlmIChkbV90YXJnZXRfc3VwcG9ydHNfem9uZWRfaG0odGktPnR5cGUpKSB7DQo+ID4gPj4g
IGlmICghdGktPnR5cGUtPml0ZXJhdGVfZGV2aWNlcyB8fA0KPiA+ID4+IC0gICAgdGktPnR5cGUt
Pml0ZXJhdGVfZGV2aWNlcyh0aSwNCj4gPiA+PiBkZXZpY2Vfbm90X3pvbmVkX21vZGVsLA0KPiA+
ID4+IC0gICAgICAmem9uZWRfbW9kZWwpKQ0KPiA+ID4+ICsgICAgdGktPnR5cGUtPml0ZXJhdGVf
ZGV2aWNlcyh0aSwNCj4gPiA+PiBkZXZpY2Vfbm90X3pvbmVkLA0KPiA+ID4+ICsgICAgICAmem9u
ZWQpKQ0KPiA+ID4+ICByZXR1cm4gZmFsc2U7DQo+ID4gPj4gIH0gZWxzZSBpZiAoIWRtX3Rhcmdl
dF9zdXBwb3J0c19taXhlZF96b25lZF9tb2RlbCh0aS0NCj4gPiA+Pj4gdHlwZSkpIHsNCj4gPiA+
PiAtaWYgKHpvbmVkX21vZGVsID09IEJMS19aT05FRF9ITSkNCj4gPiA+PiAraWYgKHpvbmVkKQ0K
PiA+ID4+ICByZXR1cm4gZmFsc2U7DQo+ID4gPj4gIH0NCj4gPiA+PiAgfQ0KPiA+ID4gDQo+ID4g
PiBUaGUgcGFyYW1ldGVyICJib29sIHpvbmVkIiBpcyByZWR1bmRhbnQuIEl0IHNob3VsZCBiZSBy
ZW1vdmVkIGZyb20NCj4gPiB0aGUNCj4gPiA+IGFib3ZlIDMgZnVuY3Rpb25zDQo+IA0KPiBUaGUg
dHdvIGZ1bmMsIGlzIHpvbmVkIGFuZCBub3Qgem9uZWQsIGFyZSBlc3NlbnRpYWxseSB0aGUgc2Ft
ZS4gVGhleQ0KPiBjYW4gYmUgc2ltcGxpZmllZCBpbnRvIG9uZSBmdW5jdGlvbi4NCg0KQm90aCBm
dW5jdGlvbnMgYXJlIHVzZWQgZm9yIGl0ZXJhdGVfZGV2aWNlcydzIGNhbGxiYWNrIGluDQpkbV90
YWJsZV9zdXBwb3J0c196b25lZF9tb2RlbCgpLiBBcyBzaG93biBpbiByYWlkX2l0ZXJhdGVfZGV2
aWNlcygpLA0KaXRlcmF0ZV9kZXZpY2VzKCkgcmV0dXJucyAwIGlmIHRoZSBjYWxsYmFjayBmdW5j
IGNhbGxzIG9uIGFsbCB0aGUgZGV2aWNlcw0KcmV0dXJucyAwLCBvciByZXR1cm5zIGEgbm9uLXpl
cm8gcmVzdWx0IGVhcmx5IG90aGVyd2lzZS4gU28sIHRoZQ0KaXRlcmF0ZV9kZXZpY2VzKCkgY2Fs
bCByZXR1cm5zICJ0cnVlIiBpZiBhbnkgb25lIG9mIHRoZSB1bmRlcmx5aW5nIGRldmljZXMNCmlz
ICh6b25lZHxub3Qgem9uZWQpLg0KDQpTaW5jZSB3ZSBjYW5ub3QgY3JlYXRlIGxhbWJkYSBhcyBp
biBvdGhlciBmYW5jeSBsYW5ndWFnZXMsIHdlIG5lZWQgdHdvDQpmdW5jdGlvbnMuLi4=

