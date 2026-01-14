Return-Path: <linux-btrfs+bounces-20499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD7D1E4FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86562300AFE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244338A9B8;
	Wed, 14 Jan 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hGMwuIQZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qUqqhViV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493838D
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388820; cv=fail; b=V5Z4xYopj6U1g84v75LnjyxE+x5OG3/Q+/9K7rRCL1XRLxwwTbGVwyYQWxnVICQ33nB8AvGe+GLyHrQEHpL/IRL+mNFNzGSTSt84O+UpxmQ9fGZ3xZvW5LdQiK/ssnRyEMApMbJaxukSdzq89xG2YTJCAq7mMd3BXTaF0Uw8+kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388820; c=relaxed/simple;
	bh=BHM++bgdv9fX6P6ldRe9DN0Z4CgG++kHZtAslTEZUv4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNyD/nDzCffVuPFRa/8Fc4MdvzuG4Y51XDPP79F+mYnZwlnzNJFC/TSoIiVEbeBm1jDxg0K/0qEV460OGlCZnqa6icmgNxBXCUBD6mHx8rnbSMUeFJJHSjNvzyBhjAjjIXzt6dYYRkymPWjjQXHYwHFe9UJeW/Ykh2o0rZjed8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hGMwuIQZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qUqqhViV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768388816; x=1799924816;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BHM++bgdv9fX6P6ldRe9DN0Z4CgG++kHZtAslTEZUv4=;
  b=hGMwuIQZUOnQYTjui/SmjRNOR6d8kC1O4Fo7wzryz32roViwC/bXD4HM
   x0aB8KhAD0pN0DlK0RokyfDqr8zjQGkd457vjNLYdlZL4f9jJRbUUnbE+
   NEX61v3UpnAuSWzBpmHrRcRuTzhWCF9RgGG3LnC1uzqxDkBdgC29m7KWo
   99LgHLHvPQuD03x1ESCEtG96WBstlREex4+UnL9eXijrtzmJi7tKGZpel
   SwrpNNPNsyeD8KOvVM04heatCp0lc5IQqC660BQcNNjFDKJBBMp8skEcs
   nnootidAyXdiE+Yt3+7DWenN/09szalKRgiXHz6ISQl2YlWzoudVwtblk
   Q==;
X-CSE-ConnectionGUID: rstSBw96RB2c9p84zE/Zww==
X-CSE-MsgGUID: BKmX9xsfR1W2Y9k6f9/aiQ==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="139950383"
Received: from mail-westusazon11012060.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 19:06:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrlxTDgISiMj7YRjbYk1BIGNlXWqOoGe/nRRMkqDSZphFX/WtLZq0H0PhYlQt2lvqPp4kRGUrkFVkUrPdd5zlWTq0g5KjUkAYcJ6Kw/U2XRqCRK6YPAkycFePpujhpumcDCTwm/Lt0q7GWsm74HhuKL+acg+GJ9Spde2Z8hOa0MOn/AkluAdwxM49N9OWKIvG6CyRwI5YQnP1qBwj0LPMxYQ8lqVEtoTdbBm9QsxkiOFXTa4/oGjoJuVxHhjhpTTbjcxH+2RBeGsPBj2oF2T53UAP8n0RTr4Y1CeMRpPxF3z2KEMP8XB20/yrr51ilw2SiWIsQha/sy/mTTx+VBsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHM++bgdv9fX6P6ldRe9DN0Z4CgG++kHZtAslTEZUv4=;
 b=up1a4HB12XzfS06OC+LRvYhyAbL1+Lj8QWS0GiE0IjukLc5SYRr3HOEx2rq2zZz5ts7EZn58dqP2p9LnEe0Ng+foCUiDAR6qlgRjRhD95g55jlPUswACw1dKgU2uc0urdND4yKqlvGBW7bUpUFVH7YJYS+lg5YC61z+tHrGXDnwpHre0u7NYxTHshCnX4Sfn4qsp/3a0YL/h5DwJ6EFjraUhBL/4Yl6qHceCOo2W7UU6xe3j4IecjpjLK1rb5Wf3xQvIs1rtOGW3BCJJa45w9z95M1WB1dME38qaEznR6OzX4YWlxN4IH7/aNUm+9i1kvk7WrvLnLnCLnl/XRcOCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHM++bgdv9fX6P6ldRe9DN0Z4CgG++kHZtAslTEZUv4=;
 b=qUqqhViVdQT3ZMXWW5eVa6Nov6Q6iZgAo6vzBMFVE6a18vOUYzKrFOJIGL9fwDYc3KA2Cxy/AYU6wq75s5fnookxuXk1Ll9eaeDfq8aMKN3Dd8loFn1W1KrepkT3n6PE2wRT9JZuZHkiv5Mq81CiqbuBIaj65tGSPWZsACHz0k8=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9493.namprd04.prod.outlook.com (2603:10b6:806:444::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 11:06:45 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 11:06:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Martin Raiber <martin@urbackup.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] btrfs: Use percpu semaphore for space info
 groups_sem
Thread-Topic: [PATCH v2 2/7] btrfs: Use percpu semaphore for space info
 groups_sem
Thread-Index: AQHcg/VxjdOuvPAIuEWlQ16ltPI6OLVRg9EA
Date: Wed, 14 Jan 2026 11:06:45 +0000
Message-ID: <a94e6115-4be9-4d70-b911-beb704834578@wdc.com>
References:
 <0102019bb2ff5805-8aa151b8-1fe7-4087-9610-4c3314b3b144-000000@eu-west-1.amazonses.com>
 <0102019bb3929cb7-0796a008-bf1f-482b-948c-1adb2318dbe3-000000@eu-west-1.amazonses.com>
In-Reply-To:
 <0102019bb3929cb7-0796a008-bf1f-482b-948c-1adb2318dbe3-000000@eu-west-1.amazonses.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9493:EE_
x-ms-office365-filtering-correlation-id: 10c3ba46-2168-4324-6649-08de535d015b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1QxKzNSZUlMR0JaYlJiZVVBSm9YSThVaTliWmk5NVpYLzhBNjNTK2o2VHNJ?=
 =?utf-8?B?dVRJelRpL3BnYUxTNllrd3JFa1RBTXNyS3U0N0xaSC9xOUczZzJhZGpoRGxw?=
 =?utf-8?B?WjJWU2VpcjJieUxZU1o2N1ZOZjMyZmloNmlTaytIOFVqWE52V01FV3B5NjFI?=
 =?utf-8?B?Wk1CU2VLWkZWQzlxQzJMdFlic3JZZ0thUGF4N3NCdHl1dmRMVUY1bVhrODRq?=
 =?utf-8?B?UUcrci91UHpmcEswSEZpSVB1U2d3dmhwUzcyRXllMkpFQ2JnQUl1U08xZTdm?=
 =?utf-8?B?U0JJckFkTXJnSWd1c2lGbnQrYXMvT1ZTWEZ4elhlQzMvK2NicllwNnBpSUhG?=
 =?utf-8?B?c1NsZXExa29KWHlBa1JKK1RCb1I0WXhUejlrT1VYRHRKbzRpRlFNWnpsczlL?=
 =?utf-8?B?SDFvTWN0Lyt0SEdPN09KZjNHWFBiWkdyaHdqamFXYUFLeSszNEFVNFVhKzZW?=
 =?utf-8?B?elluTFdVbXBYb0wyMEgvRUdEME45RlE4TzdHQ3ZHMFovNzFCNjdQcGpKMDRo?=
 =?utf-8?B?K2tRQzE5M2hkWXlqemhXVHd1c1JsMDlQU1Q4S1BTdHdOREdpUjZlaUxjN1lF?=
 =?utf-8?B?U3R0VTlZSG5LTHQvL3pnOXliUW10cEpvMVJ1TmVYYjdVL1lZdlpiREFpR3p0?=
 =?utf-8?B?ZmY4Q3NSWVVRbHNZRkcrYVp6alNnRjNhaGVNUjQxamMvbno4bjduQkFBd1gy?=
 =?utf-8?B?TXN6emVyZ3NsQi9aWU1WcHNYbkUzbUF2ODQ3ZmZiWXdQNS93NGNJcG9nRE1S?=
 =?utf-8?B?Z0VBSXY0N0twdnJlU0tpbTUxZmZFYXk4MmhXUXIzNGt3MWRwK1pIdlBaRU9q?=
 =?utf-8?B?RjlZRmR2NlRkbVBpREw1R2M1Ni9oZ0IwN1o1ZXFiakhWVFNWN3Vwc1Q2RWND?=
 =?utf-8?B?U3Z5T2ZjVmNzQWRvVHNjbTZLNm40cHJqbFFYREVxMnhuMHRxQ1Jlb3gxMzRT?=
 =?utf-8?B?TlFiMkp5STRvbkpXWHo0bGJsUGhqZXBBaEQvWjBOWkJmbVd4MFFJTUcyenNH?=
 =?utf-8?B?ZVRlTmZWUlliQXAzQUtJRHpMcG04UVpXN1FJRnVxcnZMUnZUSWUxMHI0ZFFV?=
 =?utf-8?B?L3NVYUlnTlMvcDdnTGRxMEkvZVhENjloZzJBanlUUytkYmdEWENZblhIcUR0?=
 =?utf-8?B?YlAzOG9ab3NDVFFwaU9UU2ZVRmpaMWVkYUduMUFoT1dPTHBPc2dPbHdtaENP?=
 =?utf-8?B?VHE2MVloSlZaM2w1WEE5N0k3MzdWUldEakh1dUJwb1VIUDRINHJFeVUySGZ6?=
 =?utf-8?B?eEh5aldVL2RpN1RzOGtGdnBKUTFZVWxWbGV0WDNiOS9mVjdrbVV6ZTdSUGJ0?=
 =?utf-8?B?bElOaTEwOFZFeE1teDE5S3pYRUZHQTNyc1Fsd25WQ3lyL2dNd1JYMXJvM0VH?=
 =?utf-8?B?a00xRkdXaGpZTlI0ODJKMmxMOTV4U0hlNzlHRkNwMjYrVXl2R0JiTUs1WVVo?=
 =?utf-8?B?NlJqbGlLU1Q2RXVYREI3VDBFL0g4NThTRFM1RHdWM1dlR2lJRjEzaklqYlZD?=
 =?utf-8?B?UUJ2dWJzUk1UOHR1UmNLSnhJN0R5Ti9Eb3hrODZ4bUV1ZzVzcWRrTHRLdnNp?=
 =?utf-8?B?dUFmUUtjNmpZTEdRTGcvNS96NnlHa2RLS2N6MVNwMmExbDlxRkJZY0VQWTNU?=
 =?utf-8?B?T0tMSy9YK0h5N011cElCeHZ1V2hQKzBiYytQQmdFUm42N3E4S05xY0hKM04y?=
 =?utf-8?B?eDlTaFVxUmpYU0g5aktPb3M3SGRHZmVyaGJmbnBlR3VIZlRndnpPNklFd2pC?=
 =?utf-8?B?b0xycFlONzZWNVdRWUNlTUt4c282c3d4YXVlSml6ZjViWCt2TWxaTytUUzEx?=
 =?utf-8?B?Q09zQUs4SVRKcXAxakQ3QzRSTmRuMk5vRC9GZS9TaTJyWWhYS0FjbGVRVUUz?=
 =?utf-8?B?N1FHdHkxZEdsSjJuVnFXcGhjNDNnUW9ENVN2eTRPUHRORWNQOElnNk94S0ww?=
 =?utf-8?B?SzhjZGNmRUdQZ1R3Yk00Y2R1MS8zQ2NuRVpzOWhLSGIxM0VhQTJSRUJIUmh0?=
 =?utf-8?B?WnJkcGM0TG8wU2t6VGpNeHVDNmVqV3ZaWllLeTBMNDN3WWtqRFdkT29xRFNP?=
 =?utf-8?B?d3ZDZysreHFXM1l2Z2tjVkRoNEJoaWd6ZGVGS1hGVnRxdW4zNkc1a2w2d3ph?=
 =?utf-8?B?aFM2eGU3U0ZEeW1RbDhoamRrUWg3dUYwZnljeTlBMDZrUDFXdXA4Y212TkdZ?=
 =?utf-8?Q?D00wIhY5vnAywEonwEC31Tk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjdrV04xT25WN0cwT09JSGpFSitWTzZpWm1wc1RPU1U2OGdXUDhXcjFtNmZI?=
 =?utf-8?B?WlhkVlRNSGtvUkJla0w5M3AycHhxdjFlUHVlUDVmU1lPNXlzSEhTQjRvaFZS?=
 =?utf-8?B?dC8rUEZEVWN2QUJyUnZQdmJ4TC9QWlZidXpzajB4Um9HNVRZQ2tRY09ZQ1VN?=
 =?utf-8?B?MExlYWFwVUw2Sk1uN255eW9Vamtwem90dzI0dFpPZWlsM0VmaWpiTEtCQjkw?=
 =?utf-8?B?WmNOdW1lQXVSei93R013aDFMNGdJTXJWVTU0U3prdUpnVHo5NXNVUUNqM1Q2?=
 =?utf-8?B?NlpzQzNPY2ptdHkxSFh6V0RHL2E1TDg0VkhJWU5sU0hjU1R1c0hsN3BKSGNB?=
 =?utf-8?B?RGxHcm5FcTVKajlZRFBvdnlLQ3Y5YzdBWjVBUVI4d0pFV0Nnc0xuTlBZQ2ZK?=
 =?utf-8?B?TXk5VEY4cllDZ0FWeXlyZ1gwbzArVWgvYUZTNTBQVnZZd1BVdkVKR1gwRTN0?=
 =?utf-8?B?LzBwVzlwWFFBZ2loL05PM2pFeVp2a1VOWGR2dnJBbVNRSnlWenM1dkhaM2Vi?=
 =?utf-8?B?dTZWekcyVVVQMlY4Snh4LzRoZFFKNDYwSDRiN05aeWJhNHZQQWMvTmJGQ00x?=
 =?utf-8?B?eXpEUmI1QmpNV1BBWUNENnc5WWZJK0lFRE5HU2Fidm0ydnVId2NHZDJwb1dN?=
 =?utf-8?B?eEFRSzVwWGRsZ2NQNTU2ZDZZOHYzTHRYVkpjSVoyVEV3cC8vUFgvdjk5bWdR?=
 =?utf-8?B?Z3JHbGozL0hrT281ZEU1UGtOQ1JjbFY3VFJ2VExJZUdxeUVMbXYrT3VzeWdW?=
 =?utf-8?B?bkZNZ01PTjZMUE5QWFM1WjYvVzIwamxPWVJRK3greGxyM0VQRVppZmd3eHNy?=
 =?utf-8?B?V2w4QkJGWVFiQ1BXaXRnNTBYZDQxem1QOVlLeDdWSnlrckVyL3d5ekdrTlJC?=
 =?utf-8?B?Tm9sSERhcTM1N1JFRXdqU1REZk9obnZ1cG5pUjVvQ0E0dloxckJjVlA1N1FV?=
 =?utf-8?B?a2NWaHVoZEFxazlZWHhZYzUvL0tKZmVsQ1M4SE5pbUhsQW5ZRkRYREwzd0pP?=
 =?utf-8?B?blV3am15NDhBalRUVWhQK3JVTHJDR3VybytSNDNpR3YzMTNpMWpPV1AwK0V0?=
 =?utf-8?B?Vjkvb1RTaGs5R1RZeWRpbzdrdmJuYVZHMWhRZFJvMTMvclFNbTFrZ0FpVjJK?=
 =?utf-8?B?U1Qwck1mNW13djAyaWJYVjdiN1RzbDhla0lXOGNqakdhU2ZYQjlJc0YzcThE?=
 =?utf-8?B?V2ZuanMwM1pHNVdVVG9TbytycnhOU0FaaTNaWDRYdDNicW5VWVVFdHJiUW11?=
 =?utf-8?B?d3J6YzA0aVZldys4Mm9XTHZUeFNxTUFxZDVUb3dQMDh5Y2FIR3BoZWQ1b0Rl?=
 =?utf-8?B?aXlKYTZKaEVhaE1SL2V1QTVNK3JjSEhvRGRLVmpKK2VvZCtST1NHYXpCanFP?=
 =?utf-8?B?cWwyVmovZDU3bVljTE5hWFNBdHo1c2t1RE9MNUdSZFNNR0xCdUVNN2cwWXQx?=
 =?utf-8?B?aWNWaEs0TDYyTlhrUVVjRnV1SC83QitkenVxSEZNME9URXRIOGJjbnpvNVVS?=
 =?utf-8?B?N0xIbThzQXBVMWNwN3lWbzVXc1NlUTRtYUhKTWpCQ1l4WGI5bytqY2Q4dE1V?=
 =?utf-8?B?Q2VrUldpeFNFTURTNFAyQlJpaGtuUmd5eGphNWJ2SDNxbFovM2hFdld6QThF?=
 =?utf-8?B?T1EyRVhpeVZOT3NGSDdTdEJpTUkrMXFkUFZWMWZLOElrYWdPWk8zbmJYSkJ2?=
 =?utf-8?B?Wng2WDNkOW43eXpyM2t0amRyWnFDNWNhbTlqdGNiZjRQTUM0THJhMEZlSmpC?=
 =?utf-8?B?T3Bob0IwLzdRWFFpdnJiZ040VkdqbFhBNGk4WHNpcDVWTEEwWVRUSnlJQWJM?=
 =?utf-8?B?M3g2a3Ixamx6MTZxWXEwTnhHWE5uN1FKSk1MTVdCUyt0UU5LRDBQR21uTWg3?=
 =?utf-8?B?UHV0Yjk4UTFIbWNDdE5aR1lkVjAxSlBkNlVJcDU4THQzTXA1bWkrUU9heHBv?=
 =?utf-8?B?Y0paZy9OYVhuR1ZOQWJ5anByNUJGeGowYm1kbnNWNk5UekxHWmVRZCtFcWVm?=
 =?utf-8?B?VTBFR2o1TmkrQlQ4Rmw2Q3FYVlg0ZlRNSmRDTEZ3L3Y0K1F5YTU2VmJxRVZR?=
 =?utf-8?B?a3VCSEZFb1dnaWNsWnYwSHVNcE9aNlNUNUVHK0JzWlZGVGM2ZVhCcWVha3Yy?=
 =?utf-8?B?c1AzckxLeDJ3WCtpbW5PRHgxUTN2NTVWNmJTdGVNTzNSeFlweXM2aGcyTEor?=
 =?utf-8?B?NkxWZFh5ME1CbWVMdUhFeUpRdTJ5RlpIcHNreTErYUtVS2hxMjZaYUNIcjdw?=
 =?utf-8?B?aTNTYUVFTEVVOTJaT2RPYjRXSkZDdER0N0RzWm5RT0J5RGpyajFWNEpKWktC?=
 =?utf-8?B?eWhDTmkxd1Q5QTVpdzRyeDRVTWhsZDZyRVZJYTlBelNDS1pXWnZDdG4vS3I1?=
 =?utf-8?Q?bGkcvzWgre+wAke4HheIAq5Rd/AACw6NppqDIsBmtEIhO?=
x-ms-exchange-antispam-messagedata-1: qhlANdxtnaTGIdqJDFyV6v1Vdij2AZ3eSTw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <689B94FA6792664FA360AD9DEB2EE141@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RVPJcf4H3wtYSMKZlKP0zsNeKBAyyocBpYlrLqqMEfQ+2GlFJxij0WetgeZJQ+Dx+Tf5JmbuJz4walZhOHkXm31aaWO/qTEqEws82rGvOcarAWJAxvsNOkmVwE1IipUKQsWTgHf0uEEtHC2sF9Krr38TDiOZsqq1Tafx2hBN7J8cKHYaqBr/64RmVssYkm9r5DFWIfIskvFbADMswxXLqHnvS0x0bFw4Ku0Hpdqr3X2qIesOQTJkd7/MPkvKaB5vNNjs4KjGVw8Ck54VQOIkgtoIk/jH/zGdHQg7PU1RMWkVHz6tnXN4aJjUY0DeXzCM3AgLov+Gy3J/x16MHiRlaTnpV5AQ4GbnLZHHWmFj9YYN+dUQecrhz6JKQz+8/qe2VVwKlGXQrX0N7kjuokxmn/+cKfuYtD/iCIiilKze6+j9snGMqgHuoiVWquskhX7eDTw7yVWNwcWhVazkpdvTdu73/55/8bMHCmBJU72vfnwdm5aiWwfdX9XKrSLn89JfpR5UGhCxjL09yXfb+y2L3l0OFSZnX2AnVnuLiYOg0C7SNJ0Ur13/OgfY0mcNYk+2QrtJcD9IZnhllLQTznCKN1ZWnCtNg9WDvjhkieVFSgO60/McVccdjv12NqR5B+AL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c3ba46-2168-4324-6649-08de535d015b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 11:06:45.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkhwYw/KvhnmDrkRGitawnnlvBH9trXn9S2i4C1rcsQPpECM6hRo8Wc5aU0UIccas8Ex4yctq302+ww2VroQsRBe9u/z3jgs2dS+KRqSCGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9493

T24gMS8xMi8yNiA3OjU4IFBNLCBNYXJ0aW4gUmFpYmVyIHdyb3RlOg0KPiBDaGFuZ2UgaXQgaW50
byBhIHBlcmNwdSBzZW1hcGhvcmUgdG8gc2lnbmlmaWNhbnRseQ0KPiBpbmNyZWFzZSB0aGUgcGVy
Zm9ybWFuY2Ugb2YgZmluZF9mcmVlX2V4dGVudC4NCg0KRG8geW91IGhhdmUgYW55IG51bWJlcnMg
Zm9yIHRoaXMgInNpZ25pZmljYW50IHBlcmZvcm1hbmNlIGluY3JlYXNlIj8NCg0K

