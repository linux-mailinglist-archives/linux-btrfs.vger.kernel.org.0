Return-Path: <linux-btrfs+bounces-13073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F533A90653
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0458E406E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17C11FF7B3;
	Wed, 16 Apr 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lyGvjcWH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mdtRUGBI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515D1FDA8C
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813002; cv=fail; b=maXSYzLiWqs0GMnXkOAGE4dvRafWkGkLsXGonrAQAOhF0C5WBailnm55IXTVYwr7Yk844gSOqSw9CZPWatx7h/gNY8czjbhzrVJ4YHYs7eaXynEGFZrwgXpf2OrJM05m2V0HbCT9UJPTF3OG7OBgcJ+u88OEm6uHzXK01hOrxFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813002; c=relaxed/simple;
	bh=bZindYCIFrnizbmF+pkbcwmSfj55vkJPwUCyjqTRViE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rv5uK7CZ0hOSaomSrPR5ncJKUzFn7mjkcbxHs2R9qmQ9OFL3vX6yTfwbKfeIA708Pn9nJlsk1H0IwVCrttWYnKa/8fBcWJZDRjhgiLEvR6s+9FGoId4/eoT4YeTWc/0eOTVAT5vi5zFsqdOeT7JzgJsb9KI2N9HLigvPAMKFyM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lyGvjcWH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mdtRUGBI; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813000; x=1776349000;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=bZindYCIFrnizbmF+pkbcwmSfj55vkJPwUCyjqTRViE=;
  b=lyGvjcWH+3N+mK4L0aiNyG8E4pWgvD1eDOImBx0Ka1/NDX5AUppoN9TQ
   U9UEGQoeISK47HAeFXzZBhZ+bvF7y5QjGdakG0zYbWROsrEMKP1HtBRAV
   NQ2OZGm3zM+qMYdguyLbc4MELpiK6JcrbpaVWIl+zvJJPDt/uq1rTWYJU
   697YWKafi2dEAR0LSHYI/bdVksnU+ZBnyTXaCNHWRbDLdSpJBJNcMJ+dw
   DFLRN+yeTOsURxaVUFlseM4GHz7Vcy02a5TUwu44SYjzuFIxSKrMV/hND
   SvLI4Tr28PqZi9M0N+dU4ZWjKPNr1Gzja3yL7xPmg0dwKAaxi6Pwf+8tB
   Q==;
X-CSE-ConnectionGUID: qeGUsKeeTIaRufCwA7UtdQ==
X-CSE-MsgGUID: Pht4qB+SR5mtiaEKwHpqWA==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="75631893"
Received: from mail-eastus2azlp17010023.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.23])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:16:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip/8cGHHpTgMc9yELfYV2D4gLs2A+tXSGtzG3SXvQ48+yyr7AfeCclXz8yoKuGrfSHMVwCl0ThiqH7vAeVIHi6uTlpa+iWZSRl2UvYECKEAA3WEEcGU3Eb7FpMb1EF+ZGgPWHhuroQQoE1M4u/oWC3zy0A+FiMZZGap4zpFuaJ25mEizZ+AttX0UNdn22dumcebp/TLWEIlDMr1oHzmUvJRfScAlmdNHIiZAVTbrEO7p6249SXmpvjF4JMFirP6ZodOMu9sTffWwhf9IWaRz1OuW3Bx6fpkJ6GMLSofwLueF+dVK1Fkl3Qh1vDIOsHSm/eMUgKjuw6BAEVqm3eyYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZindYCIFrnizbmF+pkbcwmSfj55vkJPwUCyjqTRViE=;
 b=AEq0+9DejB5nD8efQIqNfKlL1fgSiQl4OM4myf/KS2L14EGmT++E22oH8NSyj29KPfldFASr9EKQVBBaFQr/4xadWKtmx0eXxDFXE1xxpskRUuGt7uu5b9AZPhNT9G58gw/+Y6g+166Qp8T+lh2J7g3tUFgTOgll77f78MoDUUWzC5ala2Zkm+PI6GkBSxoPFeF18K0DJJvSrxWSH50ezeP0w1vIUr/RcMK5FvWsRMKecJkEsljnmesSG/T2899/zPuFlXG2FhViy4cYkYQZvy6CY+KsvKlXO6yncQDlFffZBYwO4q9MApao1UuRNQe0PVV62aYE8GZ8bISL7d4wGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZindYCIFrnizbmF+pkbcwmSfj55vkJPwUCyjqTRViE=;
 b=mdtRUGBI53VvtvmivmLMUH/7XMGW4KVnm7p7mMCVub2Qpyo7cdw1OUCmuOhCVbZecSg9j+y0j4b+p2LU07/2tKD976gpW3UabeyaelvWRUZa26lSJ2AE6hSV5UovHY8wAB0Xt0IqWn9qq1xmee9+/JCJX98ENd2/XyDKiEM1kLk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6810.namprd04.prod.outlook.com (2603:10b6:5:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 14:16:32 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 14:16:32 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 07/13] btrfs: pass space_info for block group creation
Thread-Topic: [PATCH v2 07/13] btrfs: pass space_info for block group creation
Thread-Index: AQHbmJZHAwBoYkPGzECi/wHNXHycG7N79BOAgCqPDYA=
Date: Wed, 16 Apr 2025 14:16:32 +0000
Message-ID: <D984L2OBF6UH.2M2L42KE449JU@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
 <1c2d3aa8f33d04cae6296d2d10a0688f435ef3a7.1742364593.git.naohiro.aota@wdc.com>
 <0d717282-474e-4168-80f9-5562c2e10996@wdc.com>
In-Reply-To: <0d717282-474e-4168-80f9-5562c2e10996@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6810:EE_
x-ms-office365-filtering-correlation-id: 38fa2305-16d5-4683-058e-08dd7cf149e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEpLT0hLS3ZpMkUzMWFWNE4ySkRzazhYZnMzMmJJSHdWSVJKODJncmFkU1Ra?=
 =?utf-8?B?aVJhbEJKL2dDRUR1aGc4aEIvRHcyTWFBVEV3QmlvSUN6U05vWjIwTnZUUFFO?=
 =?utf-8?B?TUNuOThsVk1qOTlIT2hhMWFhd0xRbktvaGhrWFpOcmw0TVVBckVnT3NJN01J?=
 =?utf-8?B?ZUN0elIxbUVUMGI3RzBXUHFmaVdMZWZmM2pSc3piY29XcGF4dk1TbWVtQTNQ?=
 =?utf-8?B?UU5HQ0MvZjExeEpxdHFFcWI2MS9PLzVWNUtucmUwRWNDcTJGaXVYamZZSWpw?=
 =?utf-8?B?K3FIQ2swOGUyR0R4TEVUY2ErUHRQeGJLVHFUaWl2SmZNbElHL20vSFlUVkIz?=
 =?utf-8?B?VFJKZmR4MVNKVEdWRFk3aHYwRERyNlYxaWZGTDd1SlpjT0FMT2xzRXJQektX?=
 =?utf-8?B?MnlrQUl3eStGNnBzdGZFQkdwNWU3L040QjlaWWVqTDE0YUtnN00yaHE3bEZh?=
 =?utf-8?B?WmhRN3p5YVRUbUVRTEtKZXZFSTdKYXluVGZyU3BSNGZDd3piMTQ0Ylo0WjB5?=
 =?utf-8?B?NnA5dXU1cU1vK0I2dlQ0dnVmMFlwN2VWczRsa3J6c0VCRVFqODlBdFZpVzB1?=
 =?utf-8?B?WnJSVXJTdXBncVZHVjZqN2w2WXJ3OENSZ1J1TGtqUHVRTENCYXpIY0RPUW9o?=
 =?utf-8?B?cVkrNGF2ZW02TE80R2VMeXlqMFdaTFMrVnZHQ0JnQzdzZ1VYVElPdTR0NUY4?=
 =?utf-8?B?U2FncW9UZFBBT1BsVG0zQjgraW9OaUJiME1Yak9oMFZaUXpwTjZFbnBrclZT?=
 =?utf-8?B?djVBV0x6ZUM2bnJLTVhPZ3B5dCtoMTlTYnhoaU9tMndqTW1sVEhxbFo3OG9y?=
 =?utf-8?B?SlI4NGVKMFFwcWsrNjdUdVFLWndIaEQ3TVdKZ2pKNHhPcXZyWkNQZnpDeE1F?=
 =?utf-8?B?L2I5TFY5RzRZWXpPWnlLQUhIazIvUGlSWmx3aE9BMmNzb3Vpa0R6dnM2QUkw?=
 =?utf-8?B?azIrNGkrZm1VRElkdDZ4VkhZV2Q1M0lJZkJQZFF2MjlhUDNObm1VWklOTG4v?=
 =?utf-8?B?Z2JGWnBReFY3NWcrMng2ajhFL2FnOTZIaGVWcnRDS3E0cFd3V1RNdW10ZWc2?=
 =?utf-8?B?QWpPSTlrR1Jpc0JIRHkyUlJGTHZqMk9sZ3hMR3hNaUp6RXFGMW5mdENVdllw?=
 =?utf-8?B?M3dSQ3lXTTd4OGFOdndGT2VRcnpsVGtDMnNyUDF5Rmw0aDNhcnBlTWFITFZm?=
 =?utf-8?B?VVIvTDRITTkzbXJZSGx0L3Y1eWJ1SHdNaUw3WUhld2ErUk1XcW5TeWc4LzUr?=
 =?utf-8?B?ejlCVmdpalBOaittQktpaStqR1VRNkErNm9sVS92a2xUMENZUUExOVN4M0R4?=
 =?utf-8?B?aFpGN0hpR254TzdhdVRkaHFZNkxjeE1oSmtpNTM0Y05vT0RzZmt1M2p6RFpI?=
 =?utf-8?B?bzV2OTNkSklNSzhQSE5JQVh4ZFhiRm4wYkJvRzdncXBiRzIrZ2dwUlhrU1ZE?=
 =?utf-8?B?eU44b29weEVIWXhhaU5jRHEybGJRY0toRlE5dGh2ejBlOVp5MTdXNExFa2pW?=
 =?utf-8?B?YlQzMVA0a3BqV2RQSVBCUVVUbHdybVAxeVZ4VHFhcDk3STMzZ0lqa1VoZ2NJ?=
 =?utf-8?B?VkRySE81M0YvT24vd244MTZoWTlUZ3RjVHZJTjBrRjBIMi9jTEQrQWl3YlBw?=
 =?utf-8?B?bzFtZ3djaVNvREFtMkdzRS81RHdBaU1MYXhaZmN2TGZhU0hmTEptVFkwMUdl?=
 =?utf-8?B?bFgzbXdzdlFoZnh6TmljZEZhTWE3d3VOa2R6ZUNFRUJBby8zWEc2RVdaekFK?=
 =?utf-8?B?cjVIUU4rb3FDZmQyT083ZWhUZWxrVXVDd0t5d21PbTM4QVpEOGpSNXJJSDhD?=
 =?utf-8?B?SzdtN0ZLeGFtWE81anlNVElaTHRmbTYrSnpKSVRoTitmR0dPbW5OWG4vdFZN?=
 =?utf-8?B?SzV1clNnYlFZNTFZSUZYcUV1OUJrbjlETk9oYVYwUUdjQkh2SmtuNGp6cndr?=
 =?utf-8?B?N3Rzd1pSeTlieFgxSlRuQVQ2bm00MHpLR2pOVWk4anBzV3Z5QXhEUnhoSXBG?=
 =?utf-8?Q?HjpuZxqmDl1+82/6LdakgJUk/4YYAc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmdUTGx0TktKRXBJWk9MSjl2amZuK0Z4OWl6bW94b3NzSHR2ZngzT29wZ3JP?=
 =?utf-8?B?c2I3V1VqQlkxSmdVZEIvNWx4S1Y2bGdmZ0NyTFdKVURZem53Q2RDOC8vbjM0?=
 =?utf-8?B?cE1GbTZhMkFHREdZcWJmakZIRW85c3NYZ3B4MUEvdTFYTWM5RTlDd0dRaHFv?=
 =?utf-8?B?VUk4aE00dDhFVFlUclIwOUhNR1hZejlZZUgrblRhSEozTkRtOVM4bzgveExq?=
 =?utf-8?B?aTFDVjZxQ3B1dDl5SFR0N0xObW4vU0NUeEFIMU1vd2hKZTRxV3dEeFZGdUsr?=
 =?utf-8?B?UFZ0SzF0cDYzWUxZbThiU0xBQld0MlpDdmk0ck1NMDRzSUgvMTY5MlJGTzF4?=
 =?utf-8?B?eVB5dnJjc09CM0VOZFJKVFJDeU1ad25XZjllT0pDZkxVZkt2akNncHJpRHRW?=
 =?utf-8?B?MzR1aUhFb2FkM2VnSjJtRW5NSWY2US9ZdUJ6U3czSGhUbCtpL2ZCV2dzV29m?=
 =?utf-8?B?TnhiL0g4dVRWdlp6TGhGR0IvSTE2NTAwakszSUJBMHJmMUtuMGxzOHVSRm9K?=
 =?utf-8?B?S0NQYXpPY21sVXVrTXRzalJqc1pRS3hsajl6ZnhmaXY2YzY2WnZxWUFZYXlT?=
 =?utf-8?B?WHZueHVNa2p2bEFkUjNIUExXU0FnS1phOWpQVlhuOWhYQzZNdkduajZ2TFNN?=
 =?utf-8?B?MG9aMmlUYVpmSHNUM1hJTEJRSTdzd3Nnak5LYUF2NUFTMnlYQW03L0xJcjNJ?=
 =?utf-8?B?amhmZU53ckE3ZE5YMThzTzVscGxHdDdzNnNvODlEeGZuRFBxTlZNdlJ5VGxT?=
 =?utf-8?B?R0ZTcE43OWM3ZVdXRkRmcWZmS0ptc014cTZ6Z0pab2NqM3REUUFEM0UxM2VE?=
 =?utf-8?B?SzBQai9oVUNVOXJjRy9Pdk9iT3NRcnN2Y0tnTUJFeGFXdGdDdnN5djdUc3VP?=
 =?utf-8?B?TUMvLzNnVTJjNWVHbTFIcDNQTXBRalNqbVdZWFlqd1RXN0JFWTNhTXdFSW9k?=
 =?utf-8?B?M3Fyc0xyemRtR3pVR2N1RFVkNVBNQnpUdUdyc1B0THhmNkJOSEFzb0d6Kysx?=
 =?utf-8?B?QVZncjlaS0p4ZEZOR3FwMHpJS01FamdVY3YzUkUzc2ZnbzBXTmVXVWU5T2tI?=
 =?utf-8?B?NWVDRDRhWG5EVFBzK0tzMVNTN1crTkhoak9vbzFiUURSYlFnVWlXNUVJdm01?=
 =?utf-8?B?MnMxME9ER2xMaE42OFN0Smd3S3JEMjVWVVpKZHJLZGtLQ01vSnVabmYvZm1F?=
 =?utf-8?B?Mm9EUlNJS3ZqVmM4azhrOG8rVDlkU3ZTUzU4TllnKzkvcGVtTnUzNlRDQXMy?=
 =?utf-8?B?eE96YnRNL1lSVUVKL29Wano5eDArS2lyK3hhSFp3TVdxS1NkSGhCRWUxNnha?=
 =?utf-8?B?ZzFFU0pHT0tvN2VuTTRLaUYxdGtqbS81ZmFsK21jdjY2Mll1UzE3UFpDeW85?=
 =?utf-8?B?NEdKTGoxdlJnM0RmSlJwVWRmd25nKy9YbjNteFlRSHVOYzROcXprRHR4NjdS?=
 =?utf-8?B?YU1kZitHbzNzOEhJWGQ2bXc4V0hDUlBLVmF6Q21ZZUZZemRna2xrNU9qb0gz?=
 =?utf-8?B?M3U4Qlo3WFUvam5SNzZ6TitPWUNwVWhUT3g2SzMwV1FPUEVCUkxRQmt5bWlH?=
 =?utf-8?B?ZVE3VEhxVTJwdEx6RnJUQy9tYzRkSElSSml0VC9laHhOYXFHanJFMzVPZDk4?=
 =?utf-8?B?K1pVQ2duUnd6UjNMK1JnMnFJcDBtSWpUMzVJUnVRbythNDU4cmZlVWZZSzFy?=
 =?utf-8?B?QklYUFpIQytSZjhtNXptbjZQcTByV1NRcWltSXVrcCtCb0Z4ODZNeWpHWmlN?=
 =?utf-8?B?VUR0RmU3TDc0eWpaS0xYQTRSNXdLc3pHbU5JcEcvaVp2cXJQdjNLejhZUWV6?=
 =?utf-8?B?MVlZUjZNME80WldOd2ZOVU05TEtwSFlza2VCUENrY3Nha3p4cXd0WFg2V0sz?=
 =?utf-8?B?N0dNQ3lLR3Mwb1pGK3djcEZRQkpUbjJtQlBmaEtJdnExRGFCKzFQTEFjcW1H?=
 =?utf-8?B?RFJ1dS9PUEM3bGJjd1BpM3JxcCs4SXplTlF0V2dzRWJSMlRuUWtxV01GZWFU?=
 =?utf-8?B?bW5Rbkt2OUVBRkg1UEhRbVB3SlV6aGpRakxGTDY5MkhmQ3VzZnlzbzcyV3Vs?=
 =?utf-8?B?V1p2Q0NONGhRendDd2FiZFdzYzZRVzg3bDJOTkcvSHZYYURuUGFPcnZXb2Zm?=
 =?utf-8?B?K21VUXM4bW9JQVBvcTljaUhHMUhkNWRCZ0FJcmJHeTZ0WmFvR0VkK29mMEZH?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F4C235B98CF0C4F8C2000356948284E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZYRANc5plR29I8u53Jn3CPzlk8+yZJYE5KORMKmBs2gUKs2g3cPpXKdGx2AyTiouGdgy21fJMpvDkMID1YRyymEd+3HeCUGdimPppToOubnAmG/6E5PCAp7+ikdodjUWMIuAOLyies6m94uZ7Y3r+b4lWDs+4zD4Ju5CuMh2crRecpNuZhWAXvyZ50ImXuWS4k5Soox7fm4gkTyM1c2GdtBD/PvWC/GrfVk5mb9hejfEv1qxnBkCyK6B9ag+q3RBn5zmUCMgcVj1OdCffH8531adrfRX+rglMJ4aIFOcrPpvbnnSwWxsBl24ebZ5QztHc3PxIZRfTkgcvBz/bB3ujUfzIBuHDwRgarGrfD7K/uhza5qiQg8Qq3xbkWGMl6gu9TayBXUei2KqAjUK+eswf6Shqs4r5Gfia0U9syV3+MhawE1nUPg8daeF9SDVTsq5G/t4KyIKrBJQbGPsvCQUpnBj5oshYXAvX8dUrEKEK8PPE0KSG5WShpQcGd8gZc7H93lv3I6TqE35KKjlgn4x/uaIWVJBu4fzZOLp22I8kygkldEzAXOpheCvd7MShP1KUubd4gVsnpRD+Qow6EfWbvS0t+gCP2NkLnWOqmzxqVkzRrYsPDzmsRw1PAkXHvrW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fa2305-16d5-4683-058e-08dd7cf149e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 14:16:32.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKs3vgLzwi5x/44nHaaiYmmC0zkwZJIGOXBIBj1fjkF1fngwhM47PPV+0i4CtjbYIx4g90A2vYNwQ+PS8I1yHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6810

T24gVGh1IE1hciAyMCwgMjAyNSBhdCA5OjIxIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBPbiAxOS4wMy4yNSAwNzoxNywgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gQWRkIGJ0
cmZzX3NwYWNlX2luZm8gcGFyYW1ldGVyIHRvIGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAoKSwgaXRz
IHJlbGF0ZWQNCj4+IGZ1bmN0aW9ucyBhbmQgcmVsYXRlZCBzdHJ1Y3QuIFBhc3NlZCBzcGFjZV9p
bmZvIHdpbGwgaGF2ZSBhIG5ldyBibG9jaw0KPj4gZ3JvdXAuIElmIE5VTEwgaXMgcGFzc2VkLCBp
dCB1c2VzIHRoZSBkZWZhdWx0IHNwYWNlX2luZm8uDQo+PiANCj4+IFRoZSBwYXJhbWV0ZXIgaXMg
dXNlZCBpbiBhIGxhdGVyIGNvbW1pdCBhbmQgdGhlIGJlaGF2aW9yIGlzIHVuY2hhbmdlZCBub3cu
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5j
b20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyB8IDE1ICsrKysrKysrLS0t
LS0tLQ0KPj4gICBmcy9idHJmcy9ibG9jay1ncm91cC5oIHwgIDIgKy0NCj4+ICAgZnMvYnRyZnMv
dm9sdW1lcy5jICAgICB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4+ICAgZnMvYnRyZnMvdm9sdW1l
cy5oICAgICB8ICAyICstDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9ibG9jay1ncm91
cC5jIGIvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYw0KPj4gaW5kZXggZmEwOGQ3YjY3YjFmLi41NmMz
YWEwZTdmZTIgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+PiArKysg
Yi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+PiBAQCAtMjg2OCw3ICsyODY4LDcgQEAgc3RhdGlj
IHU2NCBjYWxjdWxhdGVfZ2xvYmFsX3Jvb3RfaWQoY29uc3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8sIHU2NCBvZmYNCj4+ICAgfQ0KPj4gICANCj4+ICAgc3RydWN0IGJ0cmZzX2Jsb2Nr
X2dyb3VwICpidHJmc19tYWtlX2Jsb2NrX2dyb3VwKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUg
KnRyYW5zLA0KPj4gLQkJCQkJCSB1NjQgdHlwZSwNCj4+ICsJCQkJCQkgc3RydWN0IGJ0cmZzX3Nw
YWNlX2luZm8gKnNwYWNlX2luZm8sIHU2NCB0eXBlLA0KPj4gICAJCQkJCQkgdTY0IGNodW5rX29m
ZnNldCwgdTY0IHNpemUpDQo+PiAgIHsNCj4NCj4gUGxlYXNlIG1vdmUgdTY0IHR5cGUgdG8gdGhl
IG5leHQgbGluZS4NCj4NCj4gWy4uLl0NCj4NCj4+IC1zdGF0aWMgc3RydWN0IGJ0cmZzX2Jsb2Nr
X2dyb3VwICpkb19jaHVua19hbGxvYyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywg
dTY0IGZsYWdzKQ0KPj4gK3N0YXRpYyBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmRvX2NodW5r
X2FsbG9jKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KPj4gKwkJCQkJCXN0cnVj
dCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvLCB1NjQgZmxhZ3MpDQo+DQo+DQo+IFNhbWUg
Zm9yIGZsYWdzIGhlcmUgKG9yIHNoaWZ0IHN0cnVjdCBidHJmc19zcGFjZV9pbmZvIHRvIHRoZSBs
ZWZ0KS4NCj4NCj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9ibG9jay1ncm91cC5oIGIvZnMv
YnRyZnMvYmxvY2stZ3JvdXAuaA0KPj4gaW5kZXggYzAxZjNhZjcyNmExLi5jYjliMDQwNTE3MmMg
MTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9ibG9jay1ncm91cC5oDQo+PiArKysgYi9mcy9idHJm
cy9ibG9jay1ncm91cC5oDQo+PiBAQCAtMzI2LDcgKzMyNiw3IEBAIHZvaWQgYnRyZnNfcmVjbGFp
bV9iZ3Moc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pOw0KPj4gICB2b2lkIGJ0cmZzX21h
cmtfYmdfdG9fcmVjbGFpbShzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnKTsNCj4+ICAgaW50
IGJ0cmZzX3JlYWRfYmxvY2tfZ3JvdXBzKHN0cnVjdCBidHJmc19mc19pbmZvICppbmZvKTsNCj4+
ICAgc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpidHJmc19tYWtlX2Jsb2NrX2dyb3VwKHN0cnVj
dCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLA0KPj4gLQkJCQkJCSB1NjQgdHlwZSwNCj4+ICsJ
CQkJCQkgc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8sIHU2NCB0eXBlLA0KPg0K
PiBTYW1lIGhlcmUuDQo+DQo+PiBAQCAtNTYxOCw3ICs1NjIwLDcgQEAgc3RhdGljIHN0cnVjdCBi
dHJmc19ibG9ja19ncm91cCAqY3JlYXRlX2NodW5rKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUg
KnRyYW5zLA0KPj4gICAJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+PiAgIAl9DQo+PiAgIA0KPj4g
LQlibG9ja19ncm91cCA9IGJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAodHJhbnMsIHR5cGUsIHN0YXJ0
LCBjdGwtPmNodW5rX3NpemUpOw0KPj4gKwlibG9ja19ncm91cCA9IGJ0cmZzX21ha2VfYmxvY2tf
Z3JvdXAodHJhbnMsIGN0bC0+c3BhY2VfaW5mbywgdHlwZSwgc3RhcnQsIGN0bC0+Y2h1bmtfc2l6
ZSk7DQo+DQo+IGN0bC0+Y2h1bmtfc2l6ZSBpcyBhdCA5OSBoZXJlLCBwbGVhc2UgbW92ZSBpdCB0
byBhIG5ldyBsaW5lIGFzIHdlbGwuDQo+DQo+PiAgIAlpZiAoSVNfRVJSKGJsb2NrX2dyb3VwKSkg
ew0KPj4gICAJCWJ0cmZzX3JlbW92ZV9jaHVua19tYXAoaW5mbywgbWFwKTsNCj4+ICAgCQlyZXR1
cm4gYmxvY2tfZ3JvdXA7DQo+PiBAQCAtNTY0NCw3ICs1NjQ2LDcgQEAgc3RhdGljIHN0cnVjdCBi
dHJmc19ibG9ja19ncm91cCAqY3JlYXRlX2NodW5rKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUg
KnRyYW5zLA0KPj4gICB9DQo+PiAgIA0KPj4gICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJ0
cmZzX2NyZWF0ZV9jaHVuayhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+IC0J
CQkJCSAgICB1NjQgdHlwZSkNCj4+ICsJCQkJCSAgICAgc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8g
KnNwYWNlX2luZm8sIHU2NCB0eXBlKQ0KPg0KPiBTYW1lIGZvciB0eXBlLiBzcGFjZV9pbmZvIGlz
IGFscmVhZHkgb3ZlciA4MCwgc28gdHlwZSBzaG91bGQgZ28gdG8gYSBuZXcgDQo+IGxpbmUuDQo+
DQoNClRoYW5rcywgSSB3aWxsIHVwZGF0ZSB0aGVzZS4NCg0KPj4gICB7DQo+PiAgIAlzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyAqaW5mbyA9IHRyYW5zLT5mc19pbmZvOw0KPj4gICAJc3RydWN0IGJ0cmZz
X2ZzX2RldmljZXMgKmZzX2RldmljZXMgPSBpbmZvLT5mc19kZXZpY2VzOw0KPj4gQEAgLTU2NzIs
OCArNTY3NCwxMiBAQCBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJ0cmZzX2NyZWF0ZV9jaHVu
ayhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICAgCQlyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4+ICAgCX0NCj4+ICAgDQo+PiArCWlmICghc3BhY2VfaW5mbykNCj4+ICsJ
CXNwYWNlX2luZm8gPSBidHJmc19maW5kX3NwYWNlX2luZm8oaW5mbywgdHlwZSk7DQo+PiArCUFT
U0VSVChzcGFjZV9pbmZvKTsNCj4NCj4gc3BhY2VfaW5mbyA9PSBOVUxMIHNob3VsZCBuZXZlciBo
YXBwZW4sIHNvIGFuIEFTU0VSVCgpIGlzIGp1c3RpZmllZC4gQnV0IA0KPiBjYW4gd2UgbWFrZSBh
IGdyYWNlZnVsIHJldHVybiBpbiBjYXNlIENPTkZJR19CVFJGU19BU1NFUlQ9bj8gTGlrZSB3aXRo
IA0KPiB0aGUgQlRSRlNfQkxPQ0tfR1JPVVBfVFlQRV9NQVNLIGNoZWNrIGFib3ZlOg0KPg0KPiAJ
aWYgKCFzcGFjZV9pbmZvKSB7DQo+IAkJQVNTRVJUKDApOw0KPiAJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOw0KPiAJfQ0KDQpBcHBhcmVudGx5LCBzcGFjZV9pbmZvID09IE5VTEwgaXMgZ29pbmcg
dG8gYmUgY2hlY2tlZCB3aXRoIEFTU0VSVCgpIGluDQpidHJmc19tYWtlX2Jsb2NrX2dyb3VwKCkg
dG9vLiBCdXQsIGFueXdheSwgYWRkaW5nIHByb3BlciBlcnJvciBoYW5kbGluZw0Kd291bGQgYmUg
YmV0dGVyIGhlcmUuIEknbGwgZG8gdGhhdC4=

