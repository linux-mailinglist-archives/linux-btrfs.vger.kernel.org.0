Return-Path: <linux-btrfs+bounces-937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C68117A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7492860D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70642364AA;
	Wed, 13 Dec 2023 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FnzdxQmS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wND7Q1Pm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CA11A;
	Wed, 13 Dec 2023 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702481788; x=1734017788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kG5sepBHv1AUOZAohaWAYpCVvdB4w+kAnk4CDPAsoVc=;
  b=FnzdxQmSOJypAi1qeGsowloYwUvuzBLTBBj25kTSMzTThmrWxp9vrkwF
   ds57Xyn1GulswKcAPTEW6k9Cm6aXR5j1WvLE/kDumwEJ8ynik7RcTUwAx
   A8L9rIKbgLjxmcb21ySTJZmsJ2KhlSVVT51hsHYVZHdquN14oOT1Daqvc
   oR20OTU/1RU0LVhltdoPJueg+RMzvl8JryDfz4SPRzlH2DRkZM7gHHrKa
   W1D9VMw3/CcJnE4NUllPD1xi8Hq60W6zIhBSJrqQixl57gLptsXpiyPqK
   wfGqfmxIVlLYzFtPNrMCvy+X5Srh7qgfXYGJOVrL+bEaIZv/dOWgnzn1S
   A==;
X-CSE-ConnectionGUID: I5k2s0HsQWemq2Fl141zhg==
X-CSE-MsgGUID: dJlFdOOiSc+aMXFPXfNu+Q==
X-IronPort-AV: E=Sophos;i="6.04,273,1695657600"; 
   d="scan'208";a="4807083"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 23:36:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcKQbln+RoSO+dpAapCzGVgANPQm/Yf5Uq/lS6bTHf7jjLQx+Lw41XEmxQG6/n0t4zJjR/eet+PjenWOzHKYH2/Ius16PAzph538lLCvvLgQ5Yhd7DreJEfIfU5uV/255dqGca6TJKv+XssA5ZnMtRj2ZWRSde5dRlx8tcauTEt834p+xWvrAyjkdWL+u0qKkeqdxi+V6aGf77r+HwnUbBj432ExG1VwORG3uWwZMfDdYkQ7FyHurN71+fNqPBqCvDf/MfTCowwjIzJMtH5Uhip2/IzP8M3vE8SU/cdjt/WiBN6r12BT67hJmWIoNSegxVTCa9YVF4LRo5ZKnvUxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG5sepBHv1AUOZAohaWAYpCVvdB4w+kAnk4CDPAsoVc=;
 b=mAd4yjzZyscLU8p8Fq5TDIy9EGwT4+goBeWLvSsIGD8BANF9vxlsYO31kAwNu3ehPbt1Svic6HGBhjKygwQJZ6wwfbojkZYPZQumlnS03A18qOvLk88Be8DoConSJ5gIvFAMjMbJR+Acnc62WezAwpMlRHoTFxLblVwJp2z7GcWQwevcpxq4v/XA3tT8hB9wsnEr2VR56trcRSb9HI+1/DkFGJkLKgVX4PDrUOtTXYwTFKLuwKgKTQLqn1+YdqFGENl434hHw4Nioo7To8XKixUjVhsP0JVR4b66HquCZT2sNe3mnPwSQ5IzO08JVjncNhrDe7N+pBFanz08qZfTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG5sepBHv1AUOZAohaWAYpCVvdB4w+kAnk4CDPAsoVc=;
 b=wND7Q1PmHIbvEsBBChqe9g7OKZz+ABmTET+PL1yFPrHjaYaXxBsyA72IG28c3Av23OgIawitaVcJ7vX7PY7kTvhXL9r4du1EYRoCnJgg68iqXPOwhnudcX8Yz+jR8jf/qEnv+accXHP2EiKN8fGWluTZ7eU1ixdwRcYTAS9f8CU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8939.namprd04.prod.outlook.com (2603:10b6:a03:560::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:36:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:36:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Topic: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Index: AQHaLPgdK+jg9mbUFESmBC+cO90CU7Cm6y8AgABvIAA=
Date: Wed, 13 Dec 2023 15:36:23 +0000
Message-ID: <3719a73b-aef3-47e4-92c3-ec055e8bde9d@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
 <ZXlyPqtXO+j90vJb@infradead.org>
In-Reply-To: <ZXlyPqtXO+j90vJb@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8939:EE_
x-ms-office365-filtering-correlation-id: e1a0b49c-3804-499e-9bcb-08dbfbf14333
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8pOOX61rLyQxs0XDHCK5BQ82G/d9ZPlsDQzRd74l5yPHPH2pcuyCND6m+FnARCItC8bZ7afLGBZ/egi//gI0AI0E8YjrLRAq5tIGKytix7GQNuRRtVj+4AhCaTo4Umx87OcfCfT2mzWSjwEbKiKA+8kD8chv2Retld6/3TbnIErAo98NHVcGTA9cuURvLMS/is+SKfqY1BLIRI9Rcd17+sMjWLltEWU/KVIvEe+UtwXdy1Y7bwIhS9P8LIgZjHKMJ6ciEbyvqB4vK6/ASHsCZCI7PfELo31p2f/YDizBOpC4kIL8PLfuaure5kFJN2g9EV3JB/FdOEp7S5jTpjUw1E752iZN2lIdNgYJObG/r0PE6wtkA7MO0wC+MFpThgYIC/aS+LKZpWuB8aP0OBhgBMUg/mEXLpSWRfD1ZDDhUj3zFxe4E2Sft+hOl5v0HgSlKC6vBUzG2CLdF7etNJ4pzDdstOMk3tKjR3vLISo0TpzPSgayTc2b5c2TmRSAr0yCvXZJz4oMgePdzo8EciggRLl5wXlJI38H1m35dfLamDvstppy5PD6E+ZPm4qZjpPqTxvzm4Y5MRuYQSd/eaJtk0WL5ANUGScdV8YJBQeTZY9NyvxravvlnEU3wd+NlerIXxaRRVFsBVBLrythdrqzJDC7NNAKfe6GupqDKyhiRV9RV+OvC7XEgy3HkhOe55JM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(38070700009)(91956017)(66476007)(76116006)(66946007)(66556008)(38100700002)(82960400001)(122000001)(36756003)(31696002)(86362001)(26005)(66446008)(83380400001)(6506007)(6512007)(2616005)(53546011)(2906002)(6486002)(64756008)(54906003)(6916009)(316002)(478600001)(71200400001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1BqeGRBZ0t1QWt1ZnBiMzBJcG00dHY1d2cvQ0czNXp4d3VJUm9GNTlPbVdm?=
 =?utf-8?B?cE1YMGZDdEFtanlEb0JnZHZybzN0ZzhUMEJvMlZzWTg0NjlTVVpUZjJUQWRD?=
 =?utf-8?B?dmcxU1RnQTV0U2s4VVNCMG1NR2JaVjl2dVNDWXVZMFgrdnFuUkp6RHA0NXRz?=
 =?utf-8?B?TnZtQmdKNUVaY3VqMEYrcCtrYkt2dUFIWlQ2QVUydklvS0dsMVVnUzQ4dzlN?=
 =?utf-8?B?QnI1Z3lrQnRYRVEya3FKenpnNFhTNFlMMFFRYm1QejFFOFcyVnAzVzZjYVFP?=
 =?utf-8?B?RGNUK1doUkErYUIzYmxZUythQU1RU0trcGJVMDhpem5QK3NlSFRvbVpHOVN5?=
 =?utf-8?B?YkdHS3liZkEwUVNEWHRUNittanIwdERYZmpiOGRaS2JRNDhmU3BYazNybnFZ?=
 =?utf-8?B?Yno0SVVONTZRUlg5cmt2YkkxWHNDT2YrdjBsYVVXZEhmRGxHNThXL1ZYKzFQ?=
 =?utf-8?B?SzBPdzVYS3lVdVZCQ0RQeWpLVWVvR3A1Qmw3TXJDL09xZGpnbnFkN3ViT0N3?=
 =?utf-8?B?UWJQTHdqaC9qa0pjaTMvV3hjdElCOUVuNzZkZDFLMms5M012WHhvUnloNWZh?=
 =?utf-8?B?VkpmcGtrYnNTeFNqWFJmQXRubW5TZFBYY3ByeGsvRytWdmtvZEpxYWRYeTVT?=
 =?utf-8?B?TkRxMHZRR0tDazNqcm8xU3ZpUHZ0QUhIZk9ocVRWaTBaNFM2bUpGTUh3VFBr?=
 =?utf-8?B?TGp5UnNkM1VHbUtIZjBJdnRSSzd1ejhRSFVJbUtETFkwbVFCbHdzei8wMEM0?=
 =?utf-8?B?R3AyejdBYU9sNXpudkpNazJVcHBnZWVvN1BVSmMrQnNGTkcwMTVtb0hzSmw5?=
 =?utf-8?B?QWxZYjJmOWF6UXo3NWMvczRXRFNsNVRDRjV4NFVsN0dXdzQwYTI4aEtGdnRv?=
 =?utf-8?B?TXNvSFFRNFJ2VGJaZkNwN0YwZlVnSEtpYVpJMGxHZTNYdEZCUDBYNGhGQkVD?=
 =?utf-8?B?dkttUGJxVFgwY2Uzd1JMSWl5QzNYVzJ6Mm9Bb2x3Z256U3VubWtyOWFYaWRP?=
 =?utf-8?B?ZW1WWnBXTnFrTUhHQ0FNRnVqTExsdnRaZVNiZlRxYjFRRzZCOVkzc1VRUDBl?=
 =?utf-8?B?VXpuVGxuYXVMaUxWTVVFUkxMckQ1UFE5NXlnZTdwUVhjQWljQVZTRG1Kb3Jr?=
 =?utf-8?B?MlFQeXdaTzNvV1k1MS9BM0lRZERhTkhZSERtV1plT2VCbWJZY3Nmb0x0YUlO?=
 =?utf-8?B?bEdzM0RpQXlsYzc0alFjY0Vza1Q0c2FjS3pSM0t6Ky9MVDNoZEZBUlhCalN0?=
 =?utf-8?B?UFZFVFFrV0JHbGxxMVpjajVOTERxY01aRXJrVlNrZ0tuYVowVlNYeTNMQmFY?=
 =?utf-8?B?N2N6eVFFMHhlZEgzWUVreUV0ZEN4dnM1VzNueFFyMFRGbWFwQ2szMjlxdDFT?=
 =?utf-8?B?WWRRWWxqYmRQTnozVVNrbXh3Tm5DY1h6ejdOZVI4MEhsZGtrKzR2RWVZOGov?=
 =?utf-8?B?cWd4d0gxdXNoWFE2ZDdCM09HMDFmdURrN0xaTmNaUmpzbW56a2ZvSjEwK3Ez?=
 =?utf-8?B?alllRVBOMU1OMHM5QVh4aS9aekxzN3haMGorME1YYmZyT3UwSitrS2VqOUgv?=
 =?utf-8?B?U1p4czRqYjE3MmMrUHZRSVlKU3pSU0lUdHJ0NXk4Zmd6SHlyaGQ4RnFCMTdy?=
 =?utf-8?B?RVkxNmpJN1podStnazViREtIS0ZueDBVV1JjWmZEN0d5V1ZpRVJ1VzFhMFRS?=
 =?utf-8?B?eS9MUnYwS3BOYno4L0NkQUppd2VNNzNjREtnNEExMUJwY2Y1YlA0WU5QS3hD?=
 =?utf-8?B?ZnZueG9BRTNaZktXNnM2RzRESURQc0lxQk15MDN0Lzh2V3pOWlFOYW5XbFF5?=
 =?utf-8?B?bmZWV1FyOGxKNWJDcHFRV0s5VW1xeG9HRXdUTitwNmJub2ZMemptOFdkeUZQ?=
 =?utf-8?B?ek9WRk9IM1puMkFjMW1HYjk2RjBQSmFLRk91OE9wTUhBaFcwekNOVFo2MVNl?=
 =?utf-8?B?dEtxNVErcUMxTDF4czhndkthbU02QlhaSWJ4SUFKcGNVTWpyMnFtNllMMk9n?=
 =?utf-8?B?SWp6NmdZc3ExYW9IUkNHNGVHbVJIbnNpZDFWdDZpa0dBUCtiK2t2Q2w1QWNt?=
 =?utf-8?B?U1BPZDZZM21SV2YwRnRqL0lMQzZMblhuSUJnT3VlWmR5VmlWM3hUZXZTN3Vt?=
 =?utf-8?B?VStZbG9XWEYzSmdtUjBZWlNKTTNndkxCRW9ENmowd3g2RkthM1VzL3dxRnRa?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3DC566BF5F60E4193463FD32F928A0B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rZX3S2e8qM9GO9qNM9AFeWkyUVDki2hFNi6ETfjT1wbYpkQjeB8/ofOCi5AV8XEbP+G8lcfoKQubJ4drtDEgf9wdYmo/es1BCnHGuhjpDZ/2LPsABmPYxSnvK2xipCpp1P6wqqVVH2rDD1k/531wEN6ENsPDOoQ4hv6i6H14Bedb3Rn0O4H03IpIboeslWfCRCpno4EG5yCegthYb13DVUXvo9dQlmlK8PrX0GrFjmeUHMZdx7r3RDRmMt5Q1fKOUUXXpF3PmG4cNO5Az53pkMsGMIkpA712iDNnK/tGkKIx8sXpT51O0Y1ybgWBWp/KjNsaZjBrYQVYmrWix2FaqyHwOof1ShL6uYfwr0+J1yE8wZZZovqaOY5FbusT2f8yqrB7V0a8ELeGwFhpvP1cfAtjXnddxDBuEtpUS669KkR+P4ReEBcPUvhkHV1la1LnOXbIPsMcQnO8yMr3sHtdwNwl/7bxs8FZNV/+G68Gjlx5rAR88/PUa+s/aOgsPodDRlB38Iq2WJYP0A/UZcJq7vOG6SkM5DE03lwYTjno1UBqrBi1PYQpk2laZNcT55axEOPsYW4hScUo3yyczFLqnvbndYkyurhzZvPVDdZdrjWwvr+ogJS4nnV4i7Ni6U4o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a0b49c-3804-499e-9bcb-08dbfbf14333
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 15:36:23.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Op1J5piFH1vEziJY0hcCRdjmsCWzO6gRACTEwoejlth2VEt6d86ib1Dq97Uo28JpSoYWVrlaCgV7OsXA4fxaOaVa9DKvj2xwI4U4lSb1uq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8939

T24gMTMuMTIuMjMgMDk6NTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiANCj4gSSB0aGlu
ayByYWlkIHN0cmlwZSB0cmVlIGhhbmRsaW5nIGFsc28gcmVhbGx5IHNob3VsZCBtb3ZlIG91dCBv
Zg0KPiBzZXRfaW9fc3RyaXBlLiAgQmVsb3cgaXMgdGhlIGxhdGVzdCBJIGhhdmUsIGFsdGhvdWdo
IGl0IHByb2JhYmx5IHdvbid0DQo+IGFwcGx5IHRvIHlvdXIgdHJlZToNCg0KSSd2ZSBkZWNpZGVk
IHRvIGFkZCB0aGF0IG9uZSBhZnRlcndhcmRzIGdpdmluZyB0aGUgYXR0cmlidXRpb24gdG8geW91
Lg0KVGhlcmUgYXJlIHNvbWUgb3RoZXIgcGF0Y2hlcyBpbiB5b3VyIHRyZWUgYXMgd2VsbCwgd2hp
Y2ggSSB3YW50IHRvIGhhdmUgDQphIGxvb2sgYXQgdG9vLg0KDQo+IC0tLQ0KPiAgRnJvbSBhYzIw
OGRhNDhkN2Y5ZDExZWVmOGEwMWFjMGM2ZmJmOTY4MTY2NWI1IE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KPiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gRGF0ZTogVGh1
LCAyMiBKdW4gMjAyMyAwNTo1MzoxMyArMDIwMA0KPiBTdWJqZWN0OiBidHJmczogbW92ZSByYWlk
LXN0cmlwZS10cmVlIGhhbmRsaW5nIG91dCBvZiBzZXRfaW9fc3RyaXBlDQo+IA0KPiBzZXRfaW9f
c3RyaXBlIGdldHMgYSBsaXR0bGUgdG9vIGNvbXBsaWNhdGVkIHdpdGggdGhlIHJhaWQtc3RyaXBl
LXRyZWUNCj4gaGFuZGxpbmcuICBNb3ZlIGl0IG91dCBpbnRvIHRoZSBvbmx5IGNhbGxlcnMgdGhh
dCBhY3R1YWxseSBuZWVkcyBpdC4NCj4gDQo+IFRoZSBvbmx5IHJlYWRzIHdpdGggbW9yZSB0aGFu
IGEgc2luZ2xlIHN0cmlwZSBpcyB0aGUgcGFyaXR5IHJhaWQgcmVjb3ZlcnkNCj4gY2FzZSB0aGFz
dCB3aWxsIG5lZWQgdmVyeSBzcGVjaWFsIGhhbmRsaW5nIGFueXdheSBvbmNlIGltcGxlbWVudGVk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+
IC0tLQ0KPiAgIGZzL2J0cmZzL3ZvbHVtZXMuYyB8IDYxICsrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9u
cygrKSwgMzQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9sdW1l
cy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+IGluZGV4IDMwZWU1ZDE2NzBkMDM0Li5lMzJlZWZh
MjQyYjBhNCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvdm9sdW1lcy5jDQo+ICsrKyBiL2ZzL2J0
cmZzL3ZvbHVtZXMuYw0KPiBAQCAtNjIzMywyMiArNjIzMywxMiBAQCBzdGF0aWMgdTY0IGJ0cmZz
X21heF9pb19sZW4oc3RydWN0IG1hcF9sb29rdXAgKm1hcCwgZW51bSBidHJmc19tYXBfb3Agb3As
DQo+ICAgCXJldHVybiBVNjRfTUFYOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQgc2V0X2lv
X3N0cmlwZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgZW51bSBidHJmc19tYXBfb3Ag
b3AsDQo+IC0JCSAgICAgIHU2NCBsb2dpY2FsLCB1NjQgKmxlbmd0aCwgc3RydWN0IGJ0cmZzX2lv
X3N0cmlwZSAqZHN0LA0KPiAtCQkgICAgICBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFwLCB1MzIgc3Ry
aXBlX2luZGV4LA0KPiAtCQkgICAgICB1NjQgc3RyaXBlX29mZnNldCwgdTY0IHN0cmlwZV9ucikN
Cj4gK3N0YXRpYyB2b2lkIHNldF9pb19zdHJpcGUoc3RydWN0IGJ0cmZzX2lvX3N0cmlwZSAqZHN0
LCBjb25zdCBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFwLA0KPiArCQkJICB1MzIgc3RyaXBlX2luZGV4
LCB1NjQgc3RyaXBlX29mZnNldCwgdTMyIHN0cmlwZV9ucikNCj4gICB7DQo+ICAgCWRzdC0+ZGV2
ID0gbWFwLT5zdHJpcGVzW3N0cmlwZV9pbmRleF0uZGV2Ow0KPiAtDQo+IC0JaWYgKG9wID09IEJU
UkZTX01BUF9SRUFEICYmDQo+IC0JICAgIGJ0cmZzX3VzZV9yYWlkX3N0cmlwZV90cmVlKGZzX2lu
Zm8sIG1hcC0+dHlwZSkpDQo+IC0JCXJldHVybiBidHJmc19nZXRfcmFpZF9leHRlbnRfb2Zmc2V0
KGZzX2luZm8sIGxvZ2ljYWwsIGxlbmd0aCwNCj4gLQkJCQkJCSAgICBtYXAtPnR5cGUsIHN0cmlw
ZV9pbmRleCwNCj4gLQkJCQkJCSAgICBkc3QpOw0KPiAtDQo+ICAgCWRzdC0+cGh5c2ljYWwgPSBt
YXAtPnN0cmlwZXNbc3RyaXBlX2luZGV4XS5waHlzaWNhbCArDQo+ICAgCQkJc3RyaXBlX29mZnNl
dCArICgodTY0KXN0cmlwZV9uciA8PCBCVFJGU19TVFJJUEVfTEVOX1NISUZUKTsNCj4gLQlyZXR1
cm4gMDsNCj4gICB9DQo+ICAgDQo+ICAgaW50IGJ0cmZzX21hcF9ibG9jayhzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbywgZW51bSBidHJmc19tYXBfb3Agb3AsDQo+IEBAIC02NDIzLDE1ICs2
NDEzLDI0IEBAIGludCBidHJmc19tYXBfYmxvY2soc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2lu
Zm8sIGVudW0gYnRyZnNfbWFwX29wIG9wLA0KPiAgIAkgKiBwaHlzaWNhbCBibG9jayBpbmZvcm1h
dGlvbiBvbiB0aGUgc3RhY2sgaW5zdGVhZCBvZiBhbGxvY2F0aW5nIGFuDQo+ICAgCSAqIEkvTyBj
b250ZXh0IHN0cnVjdHVyZS4NCj4gICAJICovDQo+IC0JaWYgKHNtYXAgJiYgbnVtX2FsbG9jX3N0
cmlwZXMgPT0gMSAmJg0KPiAtCSAgICAhKGJ0cmZzX3VzZV9yYWlkX3N0cmlwZV90cmVlKGZzX2lu
Zm8sIG1hcC0+dHlwZSkgJiYNCj4gLQkgICAgICBvcCAhPSBCVFJGU19NQVBfUkVBRCkgJiYNCj4g
LQkgICAgISgobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDU2X01BU0spICYmIG1p
cnJvcl9udW0gPiAxKSkgew0KPiAtCQlyZXQgPSBzZXRfaW9fc3RyaXBlKGZzX2luZm8sIG9wLCBs
b2dpY2FsLCBsZW5ndGgsIHNtYXAsIG1hcCwNCj4gLQkJCQkgICAgc3RyaXBlX2luZGV4LCBzdHJp
cGVfb2Zmc2V0LCBzdHJpcGVfbnIpOw0KPiAtCQkqbWlycm9yX251bV9yZXQgPSBtaXJyb3JfbnVt
Ow0KPiAtCQkqYmlvY19yZXQgPSBOVUxMOw0KPiAtCQlnb3RvIG91dDsNCj4gKwlpZiAoc21hcCAm
JiBudW1fYWxsb2Nfc3RyaXBlcyA9PSAxKSB7DQo+ICsJCWlmIChvcCA9PSBCVFJGU19NQVBfUkVB
RCAmJg0KPiArCQkgICAgYnRyZnNfdXNlX3JhaWRfc3RyaXBlX3RyZWUoZnNfaW5mbywgbWFwLT50
eXBlKSkgew0KPiArCQkJcmV0ID0gYnRyZnNfZ2V0X3JhaWRfZXh0ZW50X29mZnNldChmc19pbmZv
LCBsb2dpY2FsLA0KPiArCQkJCQkJCSAgIGxlbmd0aCwgbWFwLT50eXBlLA0KPiArCQkJCQkJCSAg
IHN0cmlwZV9pbmRleCwgc21hcCk7DQo+ICsJCQkqbWlycm9yX251bV9yZXQgPSBtaXJyb3JfbnVt
Ow0KPiArCQkJKmJpb2NfcmV0ID0gTlVMTDsNCj4gKwkJCWdvdG8gb3V0Ow0KPiArCQl9IGVsc2Ug
aWYgKCEobWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDU2X01BU0spIHx8DQo+ICsJ
CQkgICBtaXJyb3JfbnVtID09IDApIHsNCj4gKwkJCXNldF9pb19zdHJpcGUoc21hcCwgbWFwLCBz
dHJpcGVfaW5kZXgsIHN0cmlwZV9vZmZzZXQsDQo+ICsJCQkJICAgICAgc3RyaXBlX25yKTsNCj4g
KwkJCSptaXJyb3JfbnVtX3JldCA9IG1pcnJvcl9udW07DQo+ICsJCQkqYmlvY19yZXQgPSBOVUxM
Ow0KPiArCQkJcmV0ID0gMDsNCj4gKwkJCWdvdG8gb3V0Ow0KPiArCQl9DQo+ICAgCX0NCj4gICAN
Cj4gICAJYmlvYyA9IGFsbG9jX2J0cmZzX2lvX2NvbnRleHQoZnNfaW5mbywgbG9naWNhbCwgbnVt
X2FsbG9jX3N0cmlwZXMpOw0KPiBAQCAtNjQ0OCw2ICs2NDQ3LDggQEAgaW50IGJ0cmZzX21hcF9i
bG9jayhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgZW51bSBidHJmc19tYXBfb3Agb3As
DQo+ICAgCSAqDQo+ICAgCSAqIEl0J3Mgc3RpbGwgbW9zdGx5IHRoZSBzYW1lIGFzIG90aGVyIHBy
b2ZpbGVzLCBqdXN0IHdpdGggZXh0cmEgcm90YXRpb24uDQo+ICAgCSAqLw0KPiArCUFTU0VSVChv
cCAhPSBCVFJGU19NQVBfUkVBRCB8fA0KPiArCSAgICAgICBidHJmc191c2VfcmFpZF9zdHJpcGVf
dHJlZShmc19pbmZvLCBtYXAtPnR5cGUpKTsNCj4gICAJaWYgKG1hcC0+dHlwZSAmIEJUUkZTX0JM
T0NLX0dST1VQX1JBSUQ1Nl9NQVNLICYmIG5lZWRfcmFpZF9tYXAgJiYNCj4gICAJICAgIChvcCAh
PSBCVFJGU19NQVBfUkVBRCB8fCBtaXJyb3JfbnVtID4gMSkpIHsNCj4gICAJCS8qDQo+IEBAIC02
NDYxLDI5ICs2NDYyLDIxIEBAIGludCBidHJmc19tYXBfYmxvY2soc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmZzX2luZm8sIGVudW0gYnRyZnNfbWFwX29wIG9wLA0KPiAgIAkJYmlvYy0+ZnVsbF9zdHJp
cGVfbG9naWNhbCA9IGVtLT5zdGFydCArDQo+ICAgCQkJKChzdHJpcGVfbnIgKiBkYXRhX3N0cmlw
ZXMpIDw8IEJUUkZTX1NUUklQRV9MRU5fU0hJRlQpOw0KPiAgIAkJZm9yIChpID0gMDsgaSA8IG51
bV9zdHJpcGVzOyBpKyspDQo+IC0JCQlyZXQgPSBzZXRfaW9fc3RyaXBlKGZzX2luZm8sIG9wLCBs
b2dpY2FsLCBsZW5ndGgsDQo+IC0JCQkJCSAgICAmYmlvYy0+c3RyaXBlc1tpXSwgbWFwLA0KPiAt
CQkJCQkgICAgKGkgKyBzdHJpcGVfbnIpICUgbnVtX3N0cmlwZXMsDQo+IC0JCQkJCSAgICBzdHJp
cGVfb2Zmc2V0LCBzdHJpcGVfbnIpOw0KPiArCQkJc2V0X2lvX3N0cmlwZSgmYmlvYy0+c3RyaXBl
c1tpXSwgbWFwLA0KPiArCQkJCSAgICAgIChpICsgc3RyaXBlX25yKSAlIG51bV9zdHJpcGVzLA0K
PiArCQkJCSAgICAgIHN0cmlwZV9vZmZzZXQsIHN0cmlwZV9ucik7DQo+ICAgCX0gZWxzZSB7DQo+
ICAgCQkvKg0KPiAgIAkJICogRm9yIGFsbCBvdGhlciBub24tUkFJRDU2IHByb2ZpbGVzLCBqdXN0
IGNvcHkgdGhlIHRhcmdldA0KPiAgIAkJICogc3RyaXBlIGludG8gdGhlIGJpb2MuDQo+ICAgCQkg
Ki8NCj4gICAJCWZvciAoaSA9IDA7IGkgPCBudW1fc3RyaXBlczsgaSsrKSB7DQo+IC0JCQlyZXQg
PSBzZXRfaW9fc3RyaXBlKGZzX2luZm8sIG9wLCBsb2dpY2FsLCBsZW5ndGgsDQo+IC0JCQkJCSAg
ICAmYmlvYy0+c3RyaXBlc1tpXSwgbWFwLCBzdHJpcGVfaW5kZXgsDQo+IC0JCQkJCSAgICBzdHJp
cGVfb2Zmc2V0LCBzdHJpcGVfbnIpOw0KPiArCQkJc2V0X2lvX3N0cmlwZSgmYmlvYy0+c3RyaXBl
c1tpXSwgbWFwLCBzdHJpcGVfaW5kZXgsDQo+ICsJCQkJICAgICAgc3RyaXBlX29mZnNldCwgc3Ry
aXBlX25yKTsNCj4gICAJCQlzdHJpcGVfaW5kZXgrKzsNCj4gICAJCX0NCj4gICAJfQ0KPiAgIA0K
PiAtCWlmIChyZXQpIHsNCj4gLQkJKmJpb2NfcmV0ID0gTlVMTDsNCj4gLQkJYnRyZnNfcHV0X2Jp
b2MoYmlvYyk7DQo+IC0JCWdvdG8gb3V0Ow0KPiAtCX0NCj4gLQ0KPiAgIAlpZiAob3AgIT0gQlRS
RlNfTUFQX1JFQUQpDQo+ICAgCQltYXhfZXJyb3JzID0gYnRyZnNfY2h1bmtfbWF4X2Vycm9ycyht
YXApOw0KPiAgIA0KDQo=

