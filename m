Return-Path: <linux-btrfs+bounces-10602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587389F75FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 08:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D31894DC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348C217649;
	Thu, 19 Dec 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="krL2B1j3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zXhNXXey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88581157A72
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594210; cv=fail; b=STE5CWkdrahelJ/gJDDEDRaWo7uwltmyuhQBOBisEIHqDf+ZNu6RpYLmkxzNvTYBA93gaUilT60tGcBysXGY74oSbo8GcYHID7NgLbF5pW4E43szLm+ZqWNDrkY8n8xz9DzlTtDokj1YCETexsmJSJUuQcsxfuE7hPS3Q08QWE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594210; c=relaxed/simple;
	bh=bNhYWokYtJt1hbSpFVTlGq08lfVLEJwDJkd/KsOmk5w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2KELftdufLFtx0C4qvIYwlPo0i3FWzl4SlwyOQdo4XotK4HZgfj7gyHLz5fA6crjP7XxDS2ivH2n172IVVdg925kBEvQchmLFMyfMqRaoRQ5sHkKN3o01j9xT73q9Qh+a8b81Gkqr0WOxL3qI8SZIilPTrAkQsAxA+ndLmdarQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=krL2B1j3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zXhNXXey; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734594208; x=1766130208;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=bNhYWokYtJt1hbSpFVTlGq08lfVLEJwDJkd/KsOmk5w=;
  b=krL2B1j3eTT6O6MifFwhss4b+Q0K+t/MuGrv7zsiO/wQRXJUfS9SEMB+
   7D6AgbDrqAldvGYQXGG7U53pBd4Z/uErFp7JNGQyy25XuhAJ3fWQebYJW
   WCWD+ih/173jrXj2Zc4uLRvZUFUQmE47eMSVsPlXn5Uxp/ojuzHNhMjng
   qcOmOX+e+s0iEa3xTX8yY4XAJlU1tK7id85fsjGKS74mM/Wz9KNpAuCRM
   K6uYUIY8c7dPxq3Dfy4DlfAmicHLbhfNnJhSrbGzxYWPR+6gpQQSoiN1/
   2PkYXKHuoQcjqczPhBqASw5a/3vzOb1yfJp14MIaqBuru/KFaoIdhh3v6
   g==;
X-CSE-ConnectionGUID: Ggh0N55sSJWz6UdRm47jgA==
X-CSE-MsgGUID: BDNynkM6TguFGqaDVQncoA==
X-IronPort-AV: E=Sophos;i="6.12,247,1728921600"; 
   d="scan'208";a="35373118"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2024 15:43:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he3sxBuZgu2oObaYRJTvhvaam14b65mCQOf+QjKAFeXdppEMcL1jxS4ItIlVQ2mYooe6uLMjXf5c08a+cTZPYDeJanVU4OVxBCSkEN6BUUKcqLSq+zsgmmvANU3TtwylyWTnmOyZ0bw23hEX3Lu6yXA1Hda3LH4nztOrUu9s8dN8zFzc562I9xMPI95XeneA14FY0/VyuieXAMykVAqsoFTzewtgEsB+aA/nlT/713Otwbt/9cc3lsmh6TZhVW/HtB961rb3/Lh7IjfnPgY63VQ62oOnq4vqDNN74NXW02ErO+Z5v5mLrB/P5eAU4qJSt++o5cBSySKZxy0ApANgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNhYWokYtJt1hbSpFVTlGq08lfVLEJwDJkd/KsOmk5w=;
 b=lqA23mN6xF9eurOZGPrqPtJ4H0YAtPJFhGuu+WY9D0amnJ3cOb25v4q3FLzHUJVP7CzAo8hprqgjnEM7K0F/0/YkkcbVxdffxRnBdt914plRaWz9+vTkWU4xyUGylWxd0f1SXopxfHPjuWznBUYkA9SCb1TOJ6K3iQRMMFYkKtKi85Aj77dtvSAk8v8Wz3qemvgI1Iadt+ByuTx03HkGuiRqc0jdYM9rtCDul5A9amWnd8TxLJeK5S3TPt9vvyZQOnyhynG1q4+P9E3tvmglAzcgKJIffGbm2bCHCWRGOdj+kMSKfzMt3fF+69l++KZoAOJ55U8kJpk+m7Gp/bTY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNhYWokYtJt1hbSpFVTlGq08lfVLEJwDJkd/KsOmk5w=;
 b=zXhNXXeyMLwhtwq8PbQ8RAq6/Kl9svadG47ZYUViJ2GR3MB3NHoAbhKbo2LrvyaxzU8yeZ2Qr/bBVgixj0yJl7tWMXeDR5BW/y80NVWYg9hZKi8dwEg/FhFhh++6gXV5KkcVHVE0CkmJtugrZOs5R7CsJDx4+hSIXy58RePoJpU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8309.namprd04.prod.outlook.com (2603:10b6:510:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 07:43:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 07:43:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
Thread-Topic: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
Thread-Index: AQHbUW9YuiuhY6un1UmqdTEylaQ6U7LtMHuA
Date: Thu, 19 Dec 2024 07:43:21 +0000
Message-ID: <d4c06674-c2f2-45b9-9c79-b573df97aca3@wdc.com>
References: <cover.1734527445.git.fdmanana@suse.com>
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8309:EE_
x-ms-office365-filtering-correlation-id: 5ddd6d7f-502c-444d-3b2d-08dd2000cfdc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cCtuUytmZmhXMnpjM3NFeWtFSmZ3cVV0WXdwS2ZVWStQTHU2emg3T3pqcHJB?=
 =?utf-8?B?N3JjODY2emVQZ2FEZnpiazVzWlFUZlprQVZaM0ZSWHVzSGR3Q2pUSDNUOGw4?=
 =?utf-8?B?MnYrTVBMUkttV3p5QmZ2c21CeENiZzArOGRFelZGblRjaUx3STI0aUVramFl?=
 =?utf-8?B?eGNrRnJjSWJoTkZvNzhLWndyNG9BZG9uekxvelVmZTUzZjlwQ01nTW1EVG1m?=
 =?utf-8?B?VGE4WGJrUDRuYU9sbHo4cHRTVEswS3NXZmc3NTZFOG1sRndWVmR0QmI1TEtk?=
 =?utf-8?B?MEFYb21zeVlHckJPSnNSODV4Z0xvTkxZMU1oekg2ZURqZGpzR203TmdRSVRU?=
 =?utf-8?B?UEEyNGFwdkEvY1dBMm9rMUUycVZVYjFZbjdwUlg0NGYyUW9PSmVld2xnSCtY?=
 =?utf-8?B?VzZ0VkN0RmowVGtsVzRQMkp0anFxNzZjYnhiOEpsdEp0Q3JTNUZsYXppN294?=
 =?utf-8?B?Yk0vNTVHN0EzM3ZMbWNMZ3FMaTFrOG1PR0VCZmJOdzQyZnBYYjFGSk5IbFBk?=
 =?utf-8?B?U3pZdUNscVdzN2FwMzhPa0xTZm4vUFZobytEalRhUm5MaHZsQmtDa05GWnpw?=
 =?utf-8?B?eWdWK1FNTWZjUVUweU1ZMC9od1BRdXNkNVVtbExSUnlzbmFwZlZWekV4MnpI?=
 =?utf-8?B?dUZwUU1KVDNPcy82K0p6QUY5YXBnWTFnSXptNVBxcTFvUDNyU21CczMwNUdR?=
 =?utf-8?B?WVowUkE4MWluRmJlRWtLVkJLejR1U0R4VWFoYjlTdzVPaGNpNyt3UHlwVTUx?=
 =?utf-8?B?b0xxSExMamNSQ1lhSUpXeVZ1UG56bU1GWHpFZElOM21LVEJ1cDZhL2hlY09i?=
 =?utf-8?B?Z3ZYVU9UQ2dkTHJhdXdkMElERzA0UHZsWDBhRlZaZnpIcUw2MXhSelV5dmJR?=
 =?utf-8?B?UzdTRXl2VFZpd0U5NjlUZDJSN3pVbHNKOTNkZWE0RG9VQmFONGNXNlozb0RR?=
 =?utf-8?B?UFlkV1FSeURzRDAzWXllYmozRVBBejU3cnZjL294SkhoNnduQ3g2dC9CSzBt?=
 =?utf-8?B?VWVvZDZ2Qk4wdUxDYWN4MHI4dGdtbFlvQzhwa0xsN2hYNUZMNjFJdjRYRjA5?=
 =?utf-8?B?VzZ4ZzUwVTlDVWloK0pwN1E1YWJMdS90YjZqa1FsYjdGZVdZZXkvYmxidzY5?=
 =?utf-8?B?U2R4YW0xMk5rSzhId2dYVUxFL1huSFJRVUhMc0tPNS9aZ0MzL0VvRERnVjFF?=
 =?utf-8?B?cjhaOWxKSVMwNGpjeXRSSTNiLzMvQlBRSnRDVldZN0dFSTV5QlhNcEtmbHhu?=
 =?utf-8?B?Z0RrQzFNSm53TWFqSjJOb1pWcEFFNmk3M2wwNDc1ZHNVTjlWK0NwSFBaQ2ov?=
 =?utf-8?B?eDNwRkdiblVvdDFMRVpJQTAxRytkalF3YlgzdkpTSTExMjZ6dEUwTkd1V293?=
 =?utf-8?B?eXlxU0FpSjZMblJZcktBdmJWdEIzMEYwamVIYWRSc1lUMVlvc2UzVUkrZ0s0?=
 =?utf-8?B?cndSMGJUdVA3V2N2RCtONnlpSkpxWWFEckpXNVc0NEdwb242TjhsMEFGN2Nm?=
 =?utf-8?B?U0lZVmFPRzRYNVJmYmRiVlVKL2g3Q04rQmp0WnZuTjZtL0IyS3dSTDFoays2?=
 =?utf-8?B?SHhSdHhLTVpxNFBYbzYyMnFQblgySzFGVE9PR2dadnpCdmZ4aDB5dW93Vnk4?=
 =?utf-8?B?Y2l0ZWVMcTVFMjkzeFFxWHRQR1ZnMEo4emlDTWJsV0MzcjU0dEkzTHBhMmdF?=
 =?utf-8?B?SnZYV0xWOVdzTGhsZU4rZStPTWtiUHozNkw3U2pkVHAzMWE2RWdZTWZ3Rit2?=
 =?utf-8?B?bFZBMCtTWlpLdFRBWE9Zb2ptellDMzhPa3FKeU5WVG9kclRqRmhJVlpQcnZJ?=
 =?utf-8?B?NzZOVGtKOFZQOGlTVzlUa1lWdkNtWjIxd2tybnZJVFFQRlluSWhGNnN2TUZj?=
 =?utf-8?B?Qy9VUlYrS1dmaGQvTUk4OWhVOXdFRGEzR0U3UURFcTk3c3dtNW95R3JCQTZP?=
 =?utf-8?Q?dP7kos0CL+RvHk3ANgtm+e7i8G3uUdGm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnAyb0pkV21iSXkrZGlTTk5PSndNMjZLWUpUK21BNGxERC84aHdyZnpMb1Ra?=
 =?utf-8?B?a3lhUzlhSDZLMGx5VVNUeWFMNU0yb1B1SXBuekRDb0s5a1VOb0RaMzNCYzRr?=
 =?utf-8?B?WlFPbjJ3akN0emtTYlRMdnNTMm12QS9jNWtwNUk1V3dGWU1GSVhtOHc1R21p?=
 =?utf-8?B?Vmw4b1BxL1p3amJpamZkTW1iMGhEVTRiYVJvZVZBelVkS1JNYU5rcXRiOVBF?=
 =?utf-8?B?TGF6RTg5dDFZbmVlNVJYdmZTWFd6Z3VsMVFSZGVDOXlFVmR3TkQvOWE2NmVL?=
 =?utf-8?B?TmI3RzhxQTlPRFhVVHp2b2xWdVdqTW5ER0V0RXlFdjJvdVRsc3JOaEZjNXRu?=
 =?utf-8?B?ZmlSZ0ZuSzVqYURJNGZIZnNMUzhtTFZxNk5VdkNrRUlrSGRHKy9COHVicHFG?=
 =?utf-8?B?WUVCNjZqM1JjOHNQRjZicEZ5QzA4OUUya1ZmWjREWjdkTGxvL3Y0TVp3Nnkr?=
 =?utf-8?B?NndrZHRkZXJJVEdYMXA0WjloSVp2STRTMjFKOFVuTmg1c1IwOVRqMWF3QzFu?=
 =?utf-8?B?U3h6VVEzWHFNTDdJZDVHNFd2Z1N3Vkc2d0hsWlRLQnIrU3R1eHkwcHNpS1Z3?=
 =?utf-8?B?NjV5bUxiRUNWaFlIS2dOazZJcDNXczN0T0I2NUEvb2lnMXg5dVUrYUhEM09D?=
 =?utf-8?B?aEhKaEJwem1OVDNtbG1GanF4QVk5UGhabjI3T0tjQ0RRUnNOOUZFZXVLcXJZ?=
 =?utf-8?B?aHRMaEhqNldtSjkySzMwV0tTa1l4VEt2ditQcDZ6YTJ6Zm5iVm10WjRockpx?=
 =?utf-8?B?R2NVcUozQ2JXMm5CZlBiVHY4aWxlMlpRdFV2MFBUejd0MmZPTE8zRkhWNlhn?=
 =?utf-8?B?aUlGbDlrYjJINXNaQ0MydzVxdTUzQVUrT1lNbFZwOGJ1THhtN3Ruems3K1pD?=
 =?utf-8?B?Y1Z1OFI2UWVoUlAzajdxejFGdDVtT3l6aTNKT3JHbkNSaGErTXR0NStsT243?=
 =?utf-8?B?ME9sVGEvVytXdmhpVHduRXJYOUgrS0N3QmNNQnRoajhpVVAzOElSVXF3dVBJ?=
 =?utf-8?B?VlVRT2JtdEJ0amRxaFlLZG93VGtsTEM4QU83Y3E2MThxY2FLcjNmZG5JeXBl?=
 =?utf-8?B?ck45Q0gwcDNYTHFzNFF4b3NiVFhGOFpIRkd3cXl3YWJLaFNDeHJjN0tqb1VY?=
 =?utf-8?B?Sk13cmZyblcvRzZKYmpacGFrd3g5eFFFQk9jd0dLYUdiN1ZUVGozeEp6dDFy?=
 =?utf-8?B?alREek94Rzl6NisrVU8vMVRReklBV3Y1MlY2eHpxalBBVkdnSXYweGwzSFA2?=
 =?utf-8?B?UlRTeG5SMWxIaDFmaEIxdVRkU0xCQ0hQbS9uY2M5TE1jSHljY1QyM0ZPQSsw?=
 =?utf-8?B?VzRxU2ZqZXRUWm5MUjRPak4xWVpONGc5NTFRaitWeG9sRENCeGhQbjBIVCtx?=
 =?utf-8?B?b29ISUU1b3grUGxscXozUXYvb0RwekdlcFpReEJCS083RE9OWnppRnFkVW1J?=
 =?utf-8?B?M3F3VnlZQjVxd3FEakJ4M1dsOUlqOEd3b3pGbFU2dk13Y0ZNRmhPMVhLSWxS?=
 =?utf-8?B?aEpqZlMvcy9INUhaWkYybDlxMUU2QmloVXBvbWlZaWZPK0hlRTZYVmt1cmtl?=
 =?utf-8?B?THQyei82a1ZvUXh3L0QyNjFVbE56ckVBb0wya0lJRzlKcmRGVmV6ZnJRRnZy?=
 =?utf-8?B?dFVreTVlZjB6VjE3QkZpQlRBVm5CQ0s4WllnTGRKUHFjSnlmck41a2VvOTAw?=
 =?utf-8?B?a1dGNFV4TmdnWjZVSi81WlhIc09OYmtoQkY4MHVRZFozVGJlVFBib285cjkv?=
 =?utf-8?B?NCtPOTJqcjJXOEs4TElvN2VYM3ExUmJlSUIraVUxVHVmcExzKysyZk9lelUy?=
 =?utf-8?B?TmtJOGYyYjFEdmF0YUpUYUNFcXpqYy8yM01aSkJCYzNONTVkVjUzOEIyeHNP?=
 =?utf-8?B?NjdqZklKTWJzMTlQL0lyWXVvcFBlbmdONVVUcjZXN2NnNlpTeGgva1F2Y0ZY?=
 =?utf-8?B?N0RrZE8wNHpuOGMyZDJkVzJ0dUZKSG5JaGNrNWVUdkhlWDVXdDVDQ29yb2Vu?=
 =?utf-8?B?VXpJY0RhWXlhZE9pWHRJNW12VzJiMXNYUkY2WDFkcGVRZHRYRnBQTzdTQits?=
 =?utf-8?B?YW5lbk1xZm9oVUdleHFRVS9sa3k4UFNJbnV4c3FXQmdaRmhIY3lTMkR2U1V4?=
 =?utf-8?B?ZytHUlMreldibE1xc2dyS0ZCSE5LWWt1N0doMjJKNktsM25UNHBYN25UWjVW?=
 =?utf-8?B?VmFScFI2c2NNajA5dmpMSW0vNDUyazYzN1JXakZwLys1TTZSYmNBUFM2cWtY?=
 =?utf-8?B?US9oTUZMdGdidmFoVXVIZzlGQWZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF435128D201546A1F99A40DECADB5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QwZGyXTO6ZSd23RGX7sGft//NFWBMKFgIFG9gbcjiWc68VSTHxMLvR8TGJ03t0XDKqvebhN33+/59t+0tDPvoKqF4t7AalMgzdzeWeTlXrARCMjDozn1L8R31dP6Vpyb/R7g+sGKcoPijFrc/1ibGLMxYid1lR3RfoVbBUB4J5/EVCm+ZiJVKmB6eJ9QVmqF9tmKQVX39C83HIMtZCFa0jqranU1uzq33+IPlFiWzIdZjwqIo9JUF7mWuEHdcnnkivTBarkylOQuKcLaq5Sj8YRIHg+Shg9Qbw2tE3Z5TBXXkJ59geLi0yui9d+QKrQfM3IcHimi3jyx0wSIzfIYlP3+sy45MvDQHiLHpnutUwOVRUrhhU6Ne0Wind6bKw8IQGSfCGlYbe9Ch2F2igExH7IzvcvIu2B26IX91CZUzqJUiU58Q0PYFK2wmL7mReC2njB+S8wzUYyab6xPyBYqGF5kqlEFpH5ct4PDANdf5wtjYJM468OhNO9Fe22625ZQs2z78GQN4ZUFl5d5ctC6kcKNWkWAiSakpTcws10AlSqBpNTXUUjqnlMYKBu5Li7B2413F97B5Wk1IIQhM8JDLqKUQrrRa9HB0NkyWtgiV/6B3NToBuRiKgchruQWRn9R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd6d7f-502c-444d-3b2d-08dd2000cfdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 07:43:21.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CowuZUqloVMhqnP6kfn5LpNQSxarAcB6TPZr8Hjg+yks5jOKfKuJ8pPwccmWMQlgDibkr6rjpfvLw67qAmmpLOlDV94ycHkdZ5BAXvIYSjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8309

T24gMTguMTIuMjQgMTg6MDcsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gVGhlcmUncyBxdWl0ZSBhIGxv
dCBvZiBwbGFjZXMgY2FsbGluZyBidHJmc19tYXJrX2J1ZmZlcl9kaXJ0eSgpIHdoZW4gaXQNCj4g
aXMgbm90IG5lY2Vzc2FyeSBiZWNhdXNlIHdlIGFscmVhZHkgaGF2ZSBhIHBhdGggc2V0dXAgZm9y
IHdyaXRpbmcsIGR1ZQ0KPiB0byBjYWxscyB0byBidHJmc19zZWFyY2hfc2xvdCgpIHdpdGggYSAn
Y293JyBhcmd1bWVudCBoYXZpbmcgYSB2YWx1ZSBvZiAxDQo+IG9yIGFueXRoaW5nIHRoYXQgY2Fs
bHMgYnRyZnNfc2VhcmNoX3Nsb3QoKSB0aGF0IHdheSAoYW5kIGl0J3Mgb2J2aW91cw0KPiBmcm9t
IHRoZSBjb250ZXh0KS4gVGhlc2UgbWFrZSB0aGUgY29kZSBtb3JlIHZlcmJvc2UsIGFkZCBzb21l
IG92ZXJoZWFkDQo+IGFuZCBpbmNyZWFzZSB0aGUgbW9kdWxlJ3MgdGV4dCBzaXplIHVubmVjZXNz
YXJpbHkuIFRoaXMgcGF0Y2hzZXQgcmVtb3Zlcw0KPiBzdWNoIHVubmVjZXNzYXJ5IGNhbGxzLiBP
ZnRlbiBwZW9wbGUga2VlcCBhZGRpbmcgdGhlbSBiZWNhdXNlIHRoZXkgY29weQ0KPiB0aGUgYXBw
cm9hY2ggZG9uZSBmcm9tIHN1Y2ggcGxhY2VzLg0KPiANCj4gVGhlIGNoYW5nZXMgYXJlIG1hZGUg
b24gYSBwZXIgZmlsZSBiYXNpcyB0byBtYWtlIGl0IGVhc2llciB0byByZXZpZXcgb3INCj4gYmlz
ZWN0Lg0KPiANCj4gTW9kdWxlIHNpemUgYmVmb3JlIHRoaXMgcGF0Y2hzZXQ6DQo+IA0KPiAgICAk
IHNpemUgZnMvYnRyZnMvYnRyZnMua28NCj4gICAgICAgdGV4dAkgICBkYXRhCSAgICBic3MJICAg
IGRlYwkgICAgaGV4CWZpbGVuYW1lDQo+ICAgIDE3ODE5OTIJIDE2MTAyOQkgIDE2OTIwCTE5NTk5
NDEJIDFkZTgwNQlmcy9idHJmcy9idHJmcy5rbw0KPiANCj4gQWZ0ZXIgdGhpcyBwYXRjaGV0Og0K
PiANCj4gICAgJCBzaXplIGZzL2J0cmZzL2J0cmZzLmtvDQo+ICAgICAgIHRleHQJICAgZGF0YQkg
ICAgYnNzCSAgICBkZWMJICAgIGhleAlmaWxlbmFtZQ0KPiAgICAxNzgwNjQ2CSAxNjEwMjEJICAx
NjkyMAkxOTU4NTg3CSAxZGUyYmIJZnMvYnRyZnMvYnRyZnMua28NCg0KRm9yIHRoZSBzZXJpZXMs
DQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCg==

