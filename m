Return-Path: <linux-btrfs+bounces-1010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC9816669
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 07:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4871282737
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F90101C8;
	Mon, 18 Dec 2023 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ffnGK2Mz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AXcFOqIJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A89F51B;
	Mon, 18 Dec 2023 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ceb90b189d6c11eeba30773df0976c77-20231218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5jR1tByfn4ZfoGG+doGtt8l8D1XAOygOz4FRRA87vUg=;
	b=ffnGK2MzmAk/0mLPBMBBCoQ/FpynoZl8T7HO9ANBax6VwV3isqnx8spaUqsSKPtEw+xqEILZuvW4jzIfFjmxHWfZtFWxyV4FM1mQ8OKMajglMUY8IYXA21Y5yj4oKwJRxe9btJ3Ptu+SW8oLor9EeSLGo43ZWyyeDRlKDLjJ43k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:639da332-80c9-4641-bd73-24855836444e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:25155161-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ceb90b189d6c11eeba30773df0976c77-20231218
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 897286797; Mon, 18 Dec 2023 14:15:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Dec 2023 14:15:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Dec 2023 14:15:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/mV/dIp+pho8YN+FEYnXHrhrFYAdVhS3xPyDHZmHm5MEUQIiSDW+WtqGFuSJG/IIWSxJhYv8IgTojW8Mytd8iQV2KtkfTW14Ninya5pKoEHZzSJIx/waA/iRMwBycseMYDxIhr4f8X4sJp7p5kd4y4LycWQGLlvWo81zb9WC6kFG7/ktHCeW5ksp9cD4uf+rfdNdchpBGohfLd4ghSuYRjmhrBfyjyu01FV6tfo3KvsHOguhYcN5NkUGLIjvoqEZM3kw2T8pGUQG75lW2TDWGlktS9nGulO0jd+8TS8zCCvqjpDWta/lF/wDcyt4NXX3kV8Z6cRmitBIJEVlJ1Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jR1tByfn4ZfoGG+doGtt8l8D1XAOygOz4FRRA87vUg=;
 b=QrXiyMax26B64vodBugxjQlqWdXjj2lMrUZWtFGAvBjs8BlSnsGLzy3i673ZhdeV8t153wYNYwaVDPvCVuiq3Qq8E/XNQR8vMVwHFVV5SHDLI41fXFHQs/CmdQ87dC2wQ7UyA06sfLTVSqIr5oS8grNX27z2Bf7LLCfHWb7g4qiAlUguRpkY6b+P/DcU8vkJZfRZRqKAvTkdHln4WCEtMMnD2inYqMXDfny2VL5nz5UkMGTInT58FfDr3PB98Ns0+M4/VP2Q64bzEzPjtVz2PssAyfBh5mIKv+jy5sKHHADplXcSGMJOst1YFzEgcy5585KjXDPDk4EpGW6QhAaY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jR1tByfn4ZfoGG+doGtt8l8D1XAOygOz4FRRA87vUg=;
 b=AXcFOqIJgJB9BX2nQIn6YDYgUmnTwZUOE4dWsbpa9JH4H9sMVlFOC6Ddk2z99KDv8ANXHNktR3gK4DbBBuGpEAhFL8hKzwFEIMSdgkg8c1EeVRa3MPnECp7HhENgKZwxV1kiol/hW71qG1OW6jS78J7pz44ec0MMDKssIHC25mg=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB5375.apcprd03.prod.outlook.com (2603:1096:400:3b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Mon, 18 Dec 2023 06:15:11 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 06:15:10 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
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
Thread-Index: AQHaMQnzmungF0TUfUKNyx6s0ULXRrCukLgA
Date: Mon, 18 Dec 2023 06:15:10 +0000
Message-ID: <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
References: <20231217165359.604246-1-hch@lst.de>
	 <20231217165359.604246-4-hch@lst.de>
In-Reply-To: <20231217165359.604246-4-hch@lst.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB5375:EE_
x-ms-office365-filtering-correlation-id: fa923b47-68ad-43ca-75b4-08dbff90b087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5ds58/7E2qu8icCAcVJZZbKfCoSf3qlY6K/Ax14S02vtpS1vqSGKzTWL39Nj9LmcAqYznqPq30pthVDw7sldbMEgiTpY4eI33prO6xUmBCnb/nOE4gbzmp/jic+/26Ee/zfs/wrbdxPEiJsrA6lgmUX76YY9odTA2nai5gxQT0OtjW6VEuqFIwhTaM4R7g5hwkE4Sk1FuPEnUPpDy89whdntycvZoQBQqr5wosDu3ru5ym9JfyGot5hy3USZdkip2gc/ZVUP1RE/98HNuXWVNNRqDva8sUcFS+i18TK3XmJILbeb2t4rnl3FT2cbGklxCC8+QRH6NRVDfBl402KuwWbo/mJSH9Oyy3m2gD81zpWLa1ZcDLA0ObQ+av0SQWh6SDSKGpVmyAo/+VLpFc3bXBdhpfRLbX2gdtBMVYn4YhfjjHVZn3fP9/NaRK86EqhHAllhfP7Pc0e1zZvwtXACwUBw+dYZLcZcL6Qq54mGhYWqmuWP0E/t8EiSzlTHO+QdvegWlGTSFb6Ow0k9D2ijyvZrRzH6+clOqC1kjEHTgiMry8S/X59GFTKJhe2igEcDvPCEkw0tppn1zLAa2hIidy1kOv6hqar1AvBetWnbfjPOUIO5pSsug1Xxbs/RAvphf7lfkqRaff5aO0pfvBVrvWiEyzy9uDXa+WNVFsj8GynjUSpIhw7o2QTKrLrMwch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(76116006)(316002)(478600001)(64756008)(66476007)(66446008)(54906003)(8936002)(8676002)(4326008)(66946007)(6486002)(110136005)(91956017)(41300700001)(36756003)(85182001)(2906002)(86362001)(4001150100001)(7416002)(5660300002)(38100700002)(122000001)(71200400001)(6512007)(83380400001)(2616005)(26005)(6506007)(38070700009)(76704002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmFiODBvbDJDL2gyZnhrY1pWMTZKb3kvYUFnMmppbnRlMmRtQ2gwRDR6MTAr?=
 =?utf-8?B?ZnJsZWhNTmdhVXErenA0cXRKYVM5cTJZeUl4Qkpya1BjeG4xYXMxL0YxYUZF?=
 =?utf-8?B?VWlRYzBFSzhHd0U1WmRiRDNWbHdNMUNyaVZGMU9JQVJDUU1QNWxaa1BtNytp?=
 =?utf-8?B?SUszZDU1dC9leW55Z09vRTBXdHBRNCtncGRWVVM2eExBSmtzbEE3bk9naXp6?=
 =?utf-8?B?aURhT2QyVDVhSHRIRCtNNG5icHdnenZjYklyQndBSnJWQVl0T1pkbWlXeXV4?=
 =?utf-8?B?WXpQVVV0V1NSeWhzNkpDdU5Va0V3VXQ1SGRId29GQ256b21SYktIWmZRYWJh?=
 =?utf-8?B?M3hqdXpXYU5UUTRqWDFEelNpOVlWRldWZm12T1hydDlsNjJMdFVhRFN6RFc1?=
 =?utf-8?B?bEJQRXVtdVBERmtqUVN1OGFnWkdESGdJbnk1TDF1Y1J1cGhvNStzYTg3WmhV?=
 =?utf-8?B?SEVvUmg2YlNqMDhLcHNQVk1rNGVIQzlKd2hTSHhjdzNiSFhJTE9IT1ZYcW8x?=
 =?utf-8?B?WFlrYW9qZk14dHE0Wjg0bENFb21ZSWNyKzhuZENQcW1PRXNWVGNMeXlaOGQz?=
 =?utf-8?B?bXcrZ2llWEozb3J4cXVzdzVpUE9RNSt1RWUyYUt5NXExeXlNL0p6SHloUkgw?=
 =?utf-8?B?M0p0d0lvTklTZGRweEh4b3RiSEdJVnVZUlBuLzV5YlBTQWJsZWpxVTZ4K2FN?=
 =?utf-8?B?NWRES3lwZjFkOUkvWUhvcnNjcEhvMGlLdzBkTTNqWjdRandpTlZCYU1BU0cy?=
 =?utf-8?B?RFJGSnh1akxZOTU4U2ROTE1HYW5OZDhJV2RROU1jOVQ3Zm5OMHU4OU1XNy9l?=
 =?utf-8?B?WWFDNUFmRkhCbG9RVW0rK1JzSktzRFBLYTVwZmJmWHV2ZWVYNFhHMGxsc3hD?=
 =?utf-8?B?a3JXeSs3aWE4UEswSGlZTFVqQlhSczNvUERHS3FLMUFuRk1nWTZxQStqVm04?=
 =?utf-8?B?Y0ZFbWVHN1N2ZWhCak5oRFc0aHRsKzcxYVlCL3ZzTVc1Q1F2NlM2MlFoaE9v?=
 =?utf-8?B?Zy9iN3RvbFVncnZRdkJ1TWhuOVdFUDZlZ3AxS0dKaFhtTDhyVFBtSW5ManBI?=
 =?utf-8?B?TzRvUFo0YXNpT1JxRzdQQVlZeEMwUmRseWF3QXBVRXpZREp5OVVhZ1pqVWNk?=
 =?utf-8?B?TVBnbllRdW9PdzNKSGVldUt5YTBBakY2Z0wwMGFHWnRlMnEwRGF0U1h2Z2VL?=
 =?utf-8?B?SEdpNXc2akxUeWxvVW1YSWk3dXBoN2ZSd21iT0NyVGdscmFGamdBeThaWi9B?=
 =?utf-8?B?eU9tcC9OMUVqQ1VzcU1FbWpTbE04YS9ueGoyaERmcmVOMlhkWGtwb21xd2Nx?=
 =?utf-8?B?VEhrV1hIWmtiUmg5N0grQlpMaklmQVFUWkNDTDZURU1jRlMrWUU3UW9OUUVK?=
 =?utf-8?B?V3d6aFhqckRkQjNrbHdIa3p6cVVydmFTMkR1aVB3c0FWYnFEL3EraXdSWFR5?=
 =?utf-8?B?YmZtL2JnMGMyYzZvSXJSNitQWHRPU2RhcFNmZ0trUHZoN3JGTGJmMHIrWUtm?=
 =?utf-8?B?SlhQaEd2WTRzK3pIaHpzV0QxczdzeENjZTQvQnRVQVNVbkJ3R2pXRDdkaXdm?=
 =?utf-8?B?QWV3SStKMHpVU3RRRkcyQXVKODNnM09TN2ZqVkJ4L3dYaWQyYTUrdzZXTnk0?=
 =?utf-8?B?b2JBcTV6blA0ZWpYRE1USFpGbkhHcVNzeWFUZGlOUjMwcEp4QlJCUExzK1hw?=
 =?utf-8?B?R2RBYWhhZ0dwUm1LTklHZHNzZWVlL3NtNHBNWXY1WmF3ZjR3bHFsdW9DNG9P?=
 =?utf-8?B?akkyRU5iUlQ4MEc2RzA4Q256ZHVza2ZMejFscXQrOFAyNlRJSmphQWxkQm5q?=
 =?utf-8?B?bGNnWlFGNHBEMWtVblNDRmJyZ3NtTzdoa0xPeG1RT3did3FBU0c2eEpkMUo4?=
 =?utf-8?B?ZlVuNlRGbFN4elZYNUdqa21mejdxK0RVUlNzTnhWRGxjTytVZDFiNVZiTUxP?=
 =?utf-8?B?L0pRZkdrNVF4RnpCT1ZuMk0zdWltS1o0bGdtU3VYczloeWtaNUw3ZG5rMHBK?=
 =?utf-8?B?U014ZnB6eTVJZlYzR1BmODJNOG0yWHZ2eno2QmZKYlRHZk5ydDVpVnJvWi9z?=
 =?utf-8?B?VllLSG5XWUUyYm1vZkc0dGt2VWxJU2Z4UmdyYkhyTE1Rc2RLVUM4LzEyV2dJ?=
 =?utf-8?Q?y3B3MMjbwKIKi+t8jvO6fNg7l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB1A56FC2BF74F438B37D68ED374F888@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa923b47-68ad-43ca-75b4-08dbff90b087
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 06:15:10.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qjBdFv0lQ7OY+n+dEkvn41tQscQcJTt4hvHzGbFkIejnOU7jQpmH2m79I3gHGrfYIXH+B+9koCcLMI8WzydPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5375
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.422500-8.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4jPDkSOzeDWWjLOy13Cgb480C8Dp8kkTtWlF
	7OhYLlct34Goe7Ch4PbxY0WGgfScA+ZJWZjluRbjogGd8wIUGIIUkWvaqUqLH8NNczdXNJoil45
	sitlt5M00sdOKlXfQa6dJ9o9QchDIKr1Tj6wWpRAMH4SsGvRsA9spPGnf5a0gJLfQYoCQHFb4+j
	JqxRaFP+5RgNx1/nBx0I0xE7y3y0VidZi4l9eUhp4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrItRnE
	QCUU+jz9xS3mVzWUuBk431H65J9AA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.422500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 761C6D8B4CA4913BEE64E8EB26A0162019FDAE21535CA70310A0292BE819B9EA2000:8

SGkgQ2hyaXN0b3BoLA0KDQpzb21lIG1pbm9yIHN1Z2dlc3Rpb25zOg0KDQpPbiBTdW4sIDIwMjMt
MTItMTcgYXQgMTc6NTMgKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tdGFibGUuYyBiL2RyaXZlcnMvbWQvZG0tdGFibGUuYw0K
PiBpbmRleCAxOThkMzhiNTMzMjJjMS4uMjYwYjViOGYyYjBkN2UgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbWQvZG0tdGFibGUuYw0KPiArKysgYi9kcml2ZXJzL21kL2RtLXRhYmxlLmMNCj4gQEAg
LTE1NzksMjEgKzE1NzksMTggQEAgYm9vbCBkbV90YWJsZV9oYXNfbm9fZGF0YV9kZXZpY2VzKHN0
cnVjdA0KPiBkbV90YWJsZSAqdCkNCj4gIAlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0KPiAtc3Rh
dGljIGludCBkZXZpY2Vfbm90X3pvbmVkX21vZGVsKHN0cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1
Y3QNCj4gZG1fZGV2ICpkZXYsDQo+IC0JCQkJICBzZWN0b3JfdCBzdGFydCwgc2VjdG9yX3QgbGVu
LCB2b2lkDQo+ICpkYXRhKQ0KPiArc3RhdGljIGludCBkZXZpY2Vfbm90X3pvbmVkKHN0cnVjdCBk
bV90YXJnZXQgKnRpLCBzdHJ1Y3QgZG1fZGV2DQo+ICpkZXYsDQo+ICsJCQkgICAgc2VjdG9yX3Qg
c3RhcnQsIHNlY3Rvcl90IGxlbiwgdm9pZCAqZGF0YSkNCj4gIHsNCj4gLQlzdHJ1Y3QgcmVxdWVz
dF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1ZXVlKGRldi0+YmRldik7DQo+IC0JZW51bSBibGtfem9u
ZWRfbW9kZWwgKnpvbmVkX21vZGVsID0gZGF0YTsNCj4gKwlib29sICp6b25lZCA9IGRhdGE7DQo+
ICANCj4gLQlyZXR1cm4gYmxrX3F1ZXVlX3pvbmVkX21vZGVsKHEpICE9ICp6b25lZF9tb2RlbDsN
Cj4gKwlyZXR1cm4gYmRldl9pc196b25lZChkZXYtPmJkZXYpICE9ICp6b25lZDsNCj4gIH0NCj4g
IA0KPiAgc3RhdGljIGludCBkZXZpY2VfaXNfem9uZWRfbW9kZWwoc3RydWN0IGRtX3RhcmdldCAq
dGksIHN0cnVjdCBkbV9kZXYNCj4gKmRldiwNCj4gIAkJCQkgc2VjdG9yX3Qgc3RhcnQsIHNlY3Rv
cl90IGxlbiwgdm9pZA0KPiAqZGF0YSkNCg0KU2VlbXMgbGlrZSB0aGUgd29yZCAibW9kZWwiIHNo
b3VsZCBhbHNvIGJlIHJlbW92ZSBoZXJlLg0KDQo+ICB7DQo+IC0Jc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEgPSBiZGV2X2dldF9xdWV1ZShkZXYtPmJkZXYpOw0KPiAtDQo+IC0JcmV0dXJuIGJsa19x
dWV1ZV96b25lZF9tb2RlbChxKSAhPSBCTEtfWk9ORURfTk9ORTsNCj4gKwlyZXR1cm4gYmRldl9p
c196b25lZChkZXYtPmJkZXYpOw0KPiAgfQ0KPiAgDQo+ICAvKg0KPiBAQCAtMTYwMyw4ICsxNjAw
LDcgQEAgc3RhdGljIGludCBkZXZpY2VfaXNfem9uZWRfbW9kZWwoc3RydWN0DQo+IGRtX3Rhcmdl
dCAqdGksIHN0cnVjdCBkbV9kZXYgKmRldiwNCj4gICAqIGhhcyB0aGUgRE1fVEFSR0VUX01JWEVE
X1pPTkVEX01PREVMIGZlYXR1cmUgc2V0LCB0aGUgZGV2aWNlcyBjYW4NCj4gaGF2ZSBhbnkNCj4g
ICAqIHpvbmVkIG1vZGVsIHdpdGggYWxsIHpvbmVkIGRldmljZXMgaGF2aW5nIHRoZSBzYW1lIHpv
bmUgc2l6ZS4NCj4gICAqLw0KPiAtc3RhdGljIGJvb2wgZG1fdGFibGVfc3VwcG9ydHNfem9uZWRf
bW9kZWwoc3RydWN0IGRtX3RhYmxlICp0LA0KPiAtCQkJCQkgIGVudW0gYmxrX3pvbmVkX21vZGVs
DQo+IHpvbmVkX21vZGVsKQ0KPiArc3RhdGljIGJvb2wgZG1fdGFibGVfc3VwcG9ydHNfem9uZWQo
c3RydWN0IGRtX3RhYmxlICp0LCBib29sIHpvbmVkKQ0KPiAgew0KPiAgCWZvciAodW5zaWduZWQg
aW50IGkgPSAwOyBpIDwgdC0+bnVtX3RhcmdldHM7IGkrKykgew0KPiAgCQlzdHJ1Y3QgZG1fdGFy
Z2V0ICp0aSA9IGRtX3RhYmxlX2dldF90YXJnZXQodCwgaSk7DQo+IEBAIC0xNjIzLDExICsxNjE5
LDExIEBAIHN0YXRpYyBib29sDQo+IGRtX3RhYmxlX3N1cHBvcnRzX3pvbmVkX21vZGVsKHN0cnVj
dCBkbV90YWJsZSAqdCwNCj4gIA0KPiAgCQlpZiAoZG1fdGFyZ2V0X3N1cHBvcnRzX3pvbmVkX2ht
KHRpLT50eXBlKSkgew0KPiAgCQkJaWYgKCF0aS0+dHlwZS0+aXRlcmF0ZV9kZXZpY2VzIHx8DQo+
IC0JCQkgICAgdGktPnR5cGUtPml0ZXJhdGVfZGV2aWNlcyh0aSwNCj4gZGV2aWNlX25vdF96b25l
ZF9tb2RlbCwNCj4gLQkJCQkJCSAgICAgICZ6b25lZF9tb2RlbCkpDQo+ICsJCQkgICAgdGktPnR5
cGUtPml0ZXJhdGVfZGV2aWNlcyh0aSwNCj4gZGV2aWNlX25vdF96b25lZCwNCj4gKwkJCQkJCSAg
ICAgICZ6b25lZCkpDQo+ICAJCQkJcmV0dXJuIGZhbHNlOw0KPiAgCQl9IGVsc2UgaWYgKCFkbV90
YXJnZXRfc3VwcG9ydHNfbWl4ZWRfem9uZWRfbW9kZWwodGktDQo+ID50eXBlKSkgew0KPiAtCQkJ
aWYgKHpvbmVkX21vZGVsID09IEJMS19aT05FRF9ITSkNCj4gKwkJCWlmICh6b25lZCkNCj4gIAkJ
CQlyZXR1cm4gZmFsc2U7DQo+ICAJCX0NCj4gIAl9DQoNClRoZSBwYXJhbWV0ZXIgImJvb2wgem9u
ZWQiIGlzIHJlZHVuZGFudC4gSXQgc2hvdWxkIGJlIHJlbW92ZWQgZnJvbSB0aGUNCmFib3ZlIDMg
ZnVuY3Rpb25zDQoNCkFkZGl0aW9uYWxseSwgYmVjYXVzZSB3ZSBubyBsb25nZXIgbmVlZCB0byBk
aXN0aW5ndWlzaCB0aGUgem9uZWQgbW9kZWwNCmhlcmUsIERNX1RBUkdFVF9NSVhFRF9aT05FRF9N
T0RFTCBpcyBtZWFuaW5nbGVzcy4gV2UgY2FuIGFsc28gY2xlYW4gdXANCml0cyByZWxhdGVkIGNv
ZGUuDQo=

