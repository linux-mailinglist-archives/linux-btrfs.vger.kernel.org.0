Return-Path: <linux-btrfs+bounces-17825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCBBDD7C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94A09355D83
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D03191B7;
	Wed, 15 Oct 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cw4DZBod";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vG+cfW9f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011431770E;
	Wed, 15 Oct 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517957; cv=fail; b=ErtBq7R3lXgbtBll4zEo/AjaUYloWDbyWLfbSCzKjM1ibIZ/JL+PG/uSYcp9tqE2REKHNbMIGVg+09TWG6f+bPSYmyYbnnVmQtX75+WR57jHZJi/09284v5dl7qqybkwR2HlOr3GirJ/IGRm7sBTwSIvO1WYAAtA2rFxYTM9uA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517957; c=relaxed/simple;
	bh=A2GpvKJ4ahZsHUZz6JgmuR4VgN2dtP91WoZ+uZaIzF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3LdXs+4/oOTMGFZihsQWqUTZaGAkpfMXo5TCYNBaGuv6+dEaS5GMV0t2QOyoqtvLHRK8mNnjq+jRjQu0wxvQ7OrrdMtMoe/lc2Jmma2hoZEDZbRZ7FmxbGaWXoDODNS7tDx7HGbDT+HNU3CM4fI5r38aiKl6Zd9GPzuoIT3ufs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cw4DZBod; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vG+cfW9f; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760517956; x=1792053956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A2GpvKJ4ahZsHUZz6JgmuR4VgN2dtP91WoZ+uZaIzF0=;
  b=Cw4DZBodUKoBXMZQkukz879Xz9zB5/fA9RQPTm98vWDVJR0/hcxJqe1Q
   7l5DlyVDUTmYyLuOdM6xKXxCiYWxOSKn9DnwAyW4BDwBRG/H7hvdEafL6
   4VbjoH4HAwiJlP792kYYlI3a4MYQYWZzc9O3aFofoJEtEiUXGNgzmamRo
   M3otWX2zy/VsbzRIZ/W+XpRokkOxMcc70EtpH+LduBP4UjsNLLTdFe9jQ
   H4hQikfgiXN0+cHIIOQlG5sEc8nFd75unGA9v5+OR+49W5OQt+HV+2pii
   JEs8iuxZ8h8ROtiuUjcqdT3l4XG8dJq0TM8ZeKDJfUcubkz+zMt8GBcGs
   A==;
X-CSE-ConnectionGUID: fr6X4GwpQ/W71OBuS9Z7fQ==
X-CSE-MsgGUID: sEjIyNDUT+2MU0yl/CVejg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754928000"; 
   d="scan'208";a="134488321"
Received: from mail-northcentralusazon11010060.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.60])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 16:45:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa1WW3bZqZIQmvWjy5g5mObLPYlw8XrXgNxa6vN7Q83V29ZA5guZySHdus6Brl1Yivzklf3q3Z6gKBm3HK/I0GGa5x8OWJvKGydzETgPw99HpC5LTJhoO/pg+lVnEj9qg01oSMe2kk5TmgwlTwvuHIfywZmQ0MBdcay8Lwp/b8It8FMtswupV2QYi53Fp7Tc2MB66wD2SD0g7VtE9+5/G3wU17OzD85YleIaLOby2Dmmvgeb2kL6MY6+rcRyhOuSSF5bANbF78sZr+jRjiGjml4e1w0kOxCk5yMSIddjPHQRCtai3XMfQdkx62/+SJl/z+YAKJMmmgH2pixS9fIBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2GpvKJ4ahZsHUZz6JgmuR4VgN2dtP91WoZ+uZaIzF0=;
 b=ucWc/VWmqQWyd97H4okjNPXZxNcRjLMb9PP6208fi9g9U+6SIfsJ5kofpJAypobEg/RwnNyg00Ko4xWLCzyWLAe0t2Oj0K0N8TTKn09GA1HCo7rUC0tkQk6iLDggY6dAmdZ/Cql8dL1vqY0XEHM42bq/GT62WZXWTnZ1qJOFvyMNBftUFH1hHJv1aTdMbFiB5PBrQx/I3RIdmcVEOHo7WMmLZJmYD5JhUIRYVtaaQTqAunq0nARLbGBfT3Mcy1DKjbtcPTloSxmyeSLhdjj8HyDHUNb3vgvNfeDaEU9YVs1SfrHSp67CnNbuY0ZZJcuxD5NW83yCQv/WAnBt57Y31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2GpvKJ4ahZsHUZz6JgmuR4VgN2dtP91WoZ+uZaIzF0=;
 b=vG+cfW9fWUi7YTeFZHcmsgWosU2/1hY/i40me1toGeREUjbij/1Un/UM63vr33mwdRWOP9AJVKAYwnhFVmzXR0eZ3p68vcD/brzXUnnmCUSwSw8tVFFU1Fgun3H54UzV6R8c5rxECZpAGyYZ3+SgUgkOPoYWBHcUv9dzyjuGrt8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7526.namprd04.prod.outlook.com (2603:10b6:510:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:45:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:45:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>
Subject: Re: [PATCH v4 2/3] common/zoned: add _create_zloop
Thread-Topic: [PATCH v4 2/3] common/zoned: add _create_zloop
Thread-Index: AQHcPOcRlqoVh7x8tk+dUKauCz6mjbTCIPuAgADFb4A=
Date: Wed, 15 Oct 2025 08:45:51 +0000
Message-ID: <c5767a79-7750-4418-8c6f-1dc533f6df5f@wdc.com>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
 <20251014084625.422974-3-johannes.thumshirn@wdc.com>
 <20251014205913.GB6188@frogsfrogsfrogs>
In-Reply-To: <20251014205913.GB6188@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7526:EE_
x-ms-office365-filtering-correlation-id: 753259c2-9b45-4b17-c309-08de0bc73f1d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M05seUFQWGN5S3BBbXRyUHFoZU1rZkpoY1lEcmovcWVNUngrWDN6cTloMjRt?=
 =?utf-8?B?L3dZR0tNRlNHYzBSdzlqaWhNS2pJaUF5azIvVElmQklGeE9Zb2c5WTUwSnp3?=
 =?utf-8?B?ODFzcVJkZ1dqMEdaeU1xYVZucDlUUnY4T1h5d3FrN05TYTZ6a28yY3JPbWZI?=
 =?utf-8?B?Q3BQMUd3Q3M1OEdXK0lYdzNaOXZ5ZzFFSVJ6V0pXUHRid2ZzeDFrOGRhTXVX?=
 =?utf-8?B?My9CVUU0TXZyTzUwS1RocXhwU0x3Q1VkTEhlM1lRbXZ4VFBOZ1NQTW1sdlNC?=
 =?utf-8?B?MFdWY3BPN2xiNTI1Yi9zOUZ3d294VnJ0bjBRV1JDamVYbGdiVDNqMTEvZHhF?=
 =?utf-8?B?T2sybjRIQmNyZWZrMFoxZ3RzcXBITHZ5MTFlcGNhSjVIeGFyN2ZKdDVVT3B6?=
 =?utf-8?B?NVkwM09tS20zT2VVUG9oUE1md2I0ZzkzYWQxSEFEOHA0MGpmNjdhVkp0QUU4?=
 =?utf-8?B?ZWhWQ3dGZTlYam1JWjE3R0RROFBueDJNaFlqUERGbTJDS050OFMyb294VnlD?=
 =?utf-8?B?dDc5ZG9OMlBnTE4zOXB4cFB6amluOG1tUHF1NW5IN285dTZpTUxQUnhSSXBH?=
 =?utf-8?B?aEFzVjVUbDVyM0RSRE1pRmZLOWhwN1MvZWlqd3pYL2VWYW1MKytvcU1KWVlB?=
 =?utf-8?B?Yi9LN1hRdmVzWlVxQjV3aTBlbXdDN211V1J6aDB2YWdlWkhHK2tYV1JXYitO?=
 =?utf-8?B?cnc3bWkxcHFCNENLVnpMVjVXYTVIUDcxZU9NTnhxWm9ZMThwY2pWcWJYMStU?=
 =?utf-8?B?R0tyZ2M0T2VRQkpVWjdrZ2ZLbFE4RXluM2s4WmZrSlVkODhzRmx5eUFWdFd6?=
 =?utf-8?B?T25PeFJqZTJhZkxhbXRJWmxwVzE3bHNvRVBxd2pkR2dNSlNabXlQa1FtQ2FR?=
 =?utf-8?B?Ky9sd2psdnNXVmRLSndpMEhPbE9vNStLRjBlMFdTUm13UG90Y2tEZTVudmtn?=
 =?utf-8?B?YUNRVE4zYWxacjBFUXFPMVVSdUozTlRyb0lsamo4clZzZ2JtSWJPMTlHamY4?=
 =?utf-8?B?Y0c0TzlpUnNUZVRFT2E0WU5obDlTQUVyUjA2NDdXOGR0L0ptQ2Z2UHJpckNT?=
 =?utf-8?B?ZmZxV1M0R0duNmNHTDlMSkZCdGx1RVUvZ1RnVlRtZC9GYXF0TWRkSWo2b2tB?=
 =?utf-8?B?YmNwWHBLQVUyU2ovcDVCMEtoTWY1T0k0ZTJrUHRJcVJtQnJUUmNhYVUraEFO?=
 =?utf-8?B?NXNzczV6U0xyNGVSMzdwR29MYUhwOElDdHo4L3VySFFVcVBmaWhEcytFSlgy?=
 =?utf-8?B?WE5FUHQ1SVJYbEM5NzJHZml5MzMwL0krQ0xYeGsxeTBramJqZ3hCZk9RWjZh?=
 =?utf-8?B?UkVyN1lSVFpTenNNMjF0ai9TZDNkb0hvOGc5TXMxSmNMNm11VUMyeFNiTHBt?=
 =?utf-8?B?SmpIRHVETXpNclJYakx1T3NiSy9BbjVMUHExUEtRajJ5Yjh4ZXFDQ1dOK1NG?=
 =?utf-8?B?Rzc0d3BNMmhEcUtxdVZNTVhOQUp1WVQwcGYvNkhXU0V5bjlzWGQvMkhYTjZX?=
 =?utf-8?B?MWlBeEZETmwzWjRZbzN0bzQ1cU9HdnFxSmxiVGlROGVVSVZhTXhhTVVDcHJH?=
 =?utf-8?B?UTlwcDBJVnEyYjdOL1huZWFRQ1o2SkNNNjg4US9ZaUg4Z3k0cmt0M1NJVUFJ?=
 =?utf-8?B?SFMvRkNtbGNMalc3VHR2WWZCbkIwY2ZpRW91d0JZZHZmNXBncXZ3MGNNMlQ1?=
 =?utf-8?B?ckZPQmlnbmZ0WE9abEVXenBkUzdUeHpPK1c4TWp1ajdCWXN4bWlMcU5Hbytt?=
 =?utf-8?B?TmliSjJXcjJEOXpvRmFpTnJrNCtGQkVWQ2RjWlRGeG5YUmNOaTg1cEgzUGtR?=
 =?utf-8?B?NEUzRUxGYk1qMnlJUWVqd1JvbU5leUVnS1BhUnB6MWV5NGJ5b0VsWlRHZVpH?=
 =?utf-8?B?cWIyd0tVMkk0M2pZTmV4SEpYTWtMNXJmSTVtSUNWVk8vblRmamxjdHRQdEtE?=
 =?utf-8?B?cmNPeTBSSS9lbjB1Mm5RV00zQjJXWUhVVnptRkVFS3ZWa3ZDZFdNREtrN2VU?=
 =?utf-8?B?cWhtNlUvWkFOcFptRWNsak1PczR0Yy9EczFFQnhrTit0clNjQ1lzeEMrWW1z?=
 =?utf-8?Q?KzYw+p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGVQaU81djFYU3RUbmk5aUtEQlp4eGhucERiQXA1YXhQMEVNSENIQ0hTNTQw?=
 =?utf-8?B?QVdPN2xicFpYNDVTMDFneU4zd3lnM1RtdkxwNjV3Z3RFcXU1WUh4WUY2SHYw?=
 =?utf-8?B?T3NoU2F0Q012ZUdwV0lDOW5sS2lMU2VTRUwwWlZtbzJlVUNaT3hqa3NNR0JB?=
 =?utf-8?B?RnowTDZ5NkF0aDVaRngwS3crTUVDcG9SV0RYbVFVU2pXUHdEeldYelN6UFZw?=
 =?utf-8?B?V015dHhzQzk0WThrSzVMWGdiVmsvTVNqc1c4K2luMWxJSzhzTnpsRjk0b2tZ?=
 =?utf-8?B?MVdzYUJHM0FXY0R4QTZ1ZXkveE1OVC9mQ0E2WjRhbXdDMWdHT2RuZVRQQ1NP?=
 =?utf-8?B?d2dWM1dJcWhKQmxVV0JYN0w4YW8wUGI2TFVwYk9UUjFVSDBZcXBNQmtmS0JG?=
 =?utf-8?B?U1lHYmk2Nmc0c09IWkhkNlVRd2JDcHdORDVoUWJ6RFFGT0Y4cFZMKzZUSUpk?=
 =?utf-8?B?UC9Qa3pTOWF3R2lWckNTc2VhT3ZnZk5nRXJqOFJDZkkzYnVqdXdWU3FXSitF?=
 =?utf-8?B?TUZKVlo0Zk9YdncvNkpIOTRhVUMrc3FJM2JMMjZjYzZpOS9MamppY0RObDQ2?=
 =?utf-8?B?TFd6MU0zaG5NTjYwKzFnVlBiT1BmS2ZUNnFuQUlwaVFEN3VTTEdlU3BTNUpY?=
 =?utf-8?B?QUZzbzBGNDR6ekpuSmRjZ2pFTHZ1elBCbGJlMXpTcGRjOWVEVVVtTXlFdTgz?=
 =?utf-8?B?OXFGeGcrNG1iclVrSkFhNy9LZS9DUUtsdmFpRkY0YzM2WW1Cank1YThBV3Ny?=
 =?utf-8?B?YU1yb09FY1F5VjZIdzV5WHJBTkQzQjRaOG5aZWRLQnJldEtMa0NvZ1poNDFE?=
 =?utf-8?B?ejd1T041SHVRVTl2RWxSbGZYRGpHaXJ3WGc1aFRDeUpwK1Y5dStFSm5oWmxJ?=
 =?utf-8?B?VXhaQk0zNjdMUytMMlFJLzBrTFVFcmxFK2pZdklTQU83eVBHRU1YWjZUajN3?=
 =?utf-8?B?azRXM0JYVTE1SEtSRkMreUtZQUVyaWYvL1pkSHJjalVVU3NDU0JkZ1JOTmxG?=
 =?utf-8?B?K05hWm5MSnVNUU5WNE1BakNkdk0rY29jb0FwM1daOXF6VWlIeEN6WVA5a21t?=
 =?utf-8?B?Uk1HR01vS21GQTdFZnNLZ0FIREw5bmtycUxSMTFBeCtqTVRKYUFaNnpLUVBC?=
 =?utf-8?B?aGd2Yi9qcDhxSEpaYmoyMjBjbk00d3Z2cWdmMk5SdW9uMldaMHAyK3NyeCtN?=
 =?utf-8?B?SHZ4KzIzTHo2TEpKVjhReVp4ZkFXR0JJZGVpcGEvdVd2Q25NUytSaXlJM0pU?=
 =?utf-8?B?VXlPeHMxTG5jUDBNM0x4QVV2RVZqbXJiWnZGNFRFTDdHYVZFUVN1c2E4TWxO?=
 =?utf-8?B?QjRWakd6VVdCK1JGYzN5YnhtdjZYajlnNEIzRU1OUnhsN3NnTndaRXBnN1VJ?=
 =?utf-8?B?dGZYRUxUTnNSUzBmZXQ0SUJ6VmQycHpqMFZSQmpTeDZPZ2pmcUVseVl2T2Ey?=
 =?utf-8?B?Zmp1RmVWUFFFVWg2YVEvTGIxY0dUcUl5ZVR4S0w3ODVOODJYYS92NXBFWk4r?=
 =?utf-8?B?ektnWWxZdXl4blA2TXhmR0NJa0VGZmlBZTZia2ZEMlplYXJ0SGppNTlwdzlE?=
 =?utf-8?B?aFhoSStHbG91UTZTYm9Sa0FlbGQ5dzdESXZhOTI2aFR4TUp4cDk4UUl6NmxR?=
 =?utf-8?B?OEVrOU9TZnh6WXV3Wm0vekVEYzhseW04aUlkWitaMVpXVzkxYUlCUDZSdmcz?=
 =?utf-8?B?alVlTGFyRDlubU5CbDBEdnhJTVRMT0ppaVUvK1M5Y3EwZGtrM1hVcGtDSWk3?=
 =?utf-8?B?c3lhWGU2Yk9tZ2VSaTk4aEs2SzVlR1JPejlob2xtcnkvS3hJRzV4RzlRVy91?=
 =?utf-8?B?L002MkRwUyt3OHR0VERjSS9Ha0NLZEFINzBjaEo1Y2twVUlNTmpTUGNyS1Fy?=
 =?utf-8?B?N0thbVdxRm5XdWRLR2plTkgxdUNtL1ZLV1N3OElNRDdacEN5V3dQNCt4VHRC?=
 =?utf-8?B?M0krU0FHbUV1aWJBYklqdzA4Rmd1WGcyNld3T0VVdnB5QTFQUGtTT0hNT2Zp?=
 =?utf-8?B?RXB4eisrNUVOMnEwOGQ0M2NFM0MvSlV1WjFQZDNRQU5vWjhOSVdFZ3dINlJC?=
 =?utf-8?B?WGV3ZWpNamFPbmNGQWwxMll3WkdMV3VZS2NXd09aWVB3YXczUERVWVJpRCsr?=
 =?utf-8?B?OERnNW9GTHZVQWUrL1RJSU5IalB4TUtLT1B5bDhmTW1GUVJTOHJ0L2J3dVJl?=
 =?utf-8?B?NXRmNk93eHF6em9leWlsd0hvbG1qcU9MZ1IyK2QvOC83WUtMcVlLUkRpUis5?=
 =?utf-8?B?cXM5M2ZnUTNUcE5EdkRxeEwzdE9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BEF577C3C7DA747BC57EBABD3FC0C57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 zTYhfIRlL6qfsOwGwjP1TMxoqrX3GMYZT48WY3+IjUQzFAInSC7qaejP6JvxwlZhQC8uFDLK8HNeo8CnANmGBf2Pcnk+7DvkNq1SMJbeaOgNH2oXlQfWohVxud5SOF0S9hveGy6vAiYM/G7Yvjwd1vAXjceMv1VZV0XC21gcnzy7twld++S40JzJt4Tao/Qli16Hp9MdzVORnLFSCCDzGa6KMin5w9c1ecV/jZImtEJs1Dy2sxIkhjY7uOoCeTwCkuKd9rBi1Dq0QmUgnUTVaqAnwXf5M8jhNsMuhBH3avd+P5s+tklfokoJllrCEK00oSxvsGUUavs7f4eGKUtb2u73sZdlj0gj4oVItKf1EgWVUdTov1/M7nZJi64ie0AktI1b8vIW6BLecCewlfsVk+6nC1wE+ouA3BHqCGlwV5SFEA8QWUpUQFvAWrDjgKRSxDXwBALhd35d4Mp5feQKYtKq0IUD72C/dH42BcwzkhaJe31AR5x7+Dy6uSzyQ4r1uUCNu6YeixLDA74riQfNQZg412LqK66CPjlbfmtvAf42OU50FvPeeQryvAD6j1OQjCdJFxFJsfNaLD/TmJVv1lUzMiC+DcpbXytmnMJ/1Ic2k2+ajtSr5KQgYITzHgOq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753259c2-9b45-4b17-c309-08de0bc73f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:45:51.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpW64UuIKIf2z9xogKDj/j+wh3yLA4KgADsXWti8ftPSUuAJV3uSEMcE8pxie3grHj6GrJbMx5VAFIkerc3Pxx23ZkFUd7wwIqNJ+U/c3uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7526

T24gMTAvMTQvMjUgMTA6NTkgUE0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMTQsIDIwMjUgYXQgMTA6NDY6MjRBTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gQWRkIF9jcmVhdGVfemxvb3AgYSBoZWxwZXIgZnVuY3Rpb24gZm9yIGNyZWF0aW5nIGEg
emxvb3AgZGV2aWNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgY29tbW9uL3pvbmVkIHwg
MzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29tbW9uL3pvbmVkIGIv
Y29tbW9uL3pvbmVkDQo+PiBpbmRleCA0MTY5N2IwOC4uNTVhY2YxMjAgMTAwNjQ0DQo+PiAtLS0g
YS9jb21tb24vem9uZWQNCj4+ICsrKyBiL2NvbW1vbi96b25lZA0KPj4gQEAgLTQ1LDMgKzQ1LDM4
IEBAIF9yZXF1aXJlX3psb29wKCkNCj4+ICAgCSAgICBfbm90cnVuICJUaGlzIHRlc3QgcmVxdWly
ZXMgem9uZWQgbG9vcGJhY2sgZGV2aWNlIHN1cHBvcnQiDQo+PiAgICAgICBmaQ0KPj4gICB9DQo+
PiArDQo+PiArX2ZpbmRfbmV4dF96bG9vcCgpDQo+PiArew0KPj4gKyAgICBsb2NhbCBsYXN0X2lk
PSQobHMgL2Rldi96bG9vcCogMj4gL2Rldi9udWxsIHwgZ3JlcCAtRSAiemxvb3BbMC05XSsiIHwg
d2MgLWwpDQo+PiArICAgIGVjaG8gJGxhc3RfaWQNCj4gRXIuLi4gd2hhdCBoYXBwZW5zIGlmIHRo
ZXJlIGFyZSBkaXNjb250aWd1aXRpZXMgaW4gdGhlIGFjdGl2ZSB6bG9vcA0KPiBkZXZpY2VzPw0K
Pg0KPiBMZXQncyBzYXkgeW91IGhhdmUNCj4NCj4gIyBscyAvZGV2L3psb29wKg0KPiAvZGV2L3ps
b29wMTAwMA0KPiAvZGV2L3psb29wMTAwMDAwMA0KPiAvZGV2L3psb29wMw0KPg0KPiBUaGF0IHdp
bGwgcHJvZHVjZSBsYXN0X2lkPTMsIHdoaWNoIEkgZG9uJ3QgdGhpbmsgaXMgd2hhdCB3ZSB3YW50
Lg0KDQoNClllcyBJJ3ZlIGNoYW5nZWQgdGhhdCB0bzoNCg0KX2ZpbmRfbmV4dF96bG9vcCgpDQp7
DQogwqAgwqAgaWQ9MA0KDQogwqAgwqAgd2hpbGUgdHJ1ZTsgZG8NCiDCoCDCoCDCoCDCoCBpZiBb
WyAhIC1iICIvZGV2L3psb29wJGlkIiBdXTsgdGhlbg0KIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFr
DQogwqAgwqAgwqAgwqAgZmkNCiDCoCDCoCDCoCDCoCBpZD0kKChpZCArIDEpKQ0KIMKgIMKgIGRv
bmUNCg0KIMKgIMKgIGVjaG8gIiRpZCINCn0NCg0KDQo+PiArfQ0KPj4gKw0KPj4gKyMgQ3JlYXRl
IGEgemxvb3AgZGV2aWNlDQo+PiArIyB1c2VhZ2U6IF9jcmVhdGVfemxvb3AgPGJhc2VfZGlyPiA8
em9uZV9zaXplPiA8bnJfY29udl96b25lcz4NCj4+ICtfY3JlYXRlX3psb29wKCkNCj4+ICt7DQo+
PiArICAgIGxvY2FsIGlkPSIkKF9maW5kX25leHRfemxvb3ApIg0KPj4gKw0KPj4gKyAgICBpZiBb
IC1uICIkMSIgXTsgdGhlbg0KPj4gKyAgICAgICAgbG9jYWwgemxvb3BfYmFzZT0iJDEiDQo+PiAr
ICAgIGVsc2UNCj4+ICsJbG9jYWwgemxvb3BfYmFzZT0iL3Zhci9sb2NhbC96bG9vcCINCj4gTWF5
YmUgdGhlIGRlZmF1bHQgemxvb3BfYmFzZSBzaG91bGQgYmUgdW5kZXIgJHRtcCBzb21ld2hlcmU/
DQoNCg0KVGhpcyBpcyB0aGUga2VybmVsJ3MgZGVmYXVsdCwgc28gSSBvcHRlZCBmb3IgdGhhdA0K
DQo+DQo+PiArICAgIGZpDQo+PiArDQo+PiArICAgIGlmIFsgLW4gIiQyIiBdOyB0aGVuDQo+PiAr
ICAgICAgICBsb2NhbCB6b25lX3NpemU9Iix6b25lX3NpemVfbWI9JDIiDQo+PiArICAgIGZpDQo+
PiArDQo+PiArICAgIGlmIFsgLW4gIiQzIiBdOyB0aGVuDQo+PiArICAgICAgICBsb2NhbCBjb252
X3pvbmVzPSIsY29udl96b25lcz0kMyINCj4+ICsgICAgZmkNCj4+ICsNCj4+ICsgICAgbWtkaXIg
LXAgIiR6bG9vcF9iYXNlLyRpZCINCj4+ICsNCj4+ICsgICAgbG9jYWwgemxvb3BfYXJncz0iYWRk
IGlkPSRpZCxiYXNlX2Rpcj0kemxvb3BfYmFzZSR6b25lX3NpemUkY29udl96b25lcyINCj4+ICsN
Cj4+ICsgICAgZWNobyAiJHpsb29wX2FyZ3MiID4gL2Rldi96bG9vcC1jb250cm9sDQo+IEkgd29u
ZGVyLCBpZiAvZGV2L3psb29wMyBhbHJlYWR5IGV4aXN0cywgc2hvdWxkbid0IHdlIHJlc3BlY3Qg
dGhlIGZhaWxlZA0KPiB3cml0ZT8gIGUuZy4NCj4NCj4gCWVjaG8gIiR6bG9vcF9hcmdzIiA+IC9k
ZXYvemxvb3AtY29udHJvbCAmJiBlY2hvICIvZGV2L3psb29wJGlkIg0KPg0KPiAtLUQNCg0Kb2sN
Cg0KDQo=

