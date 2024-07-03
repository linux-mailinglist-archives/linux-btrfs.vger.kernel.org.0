Return-Path: <linux-btrfs+bounces-6174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71592653D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1961C22DAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC5B18131D;
	Wed,  3 Jul 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TvpBCyPE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y6LDi1Qv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB981779A4;
	Wed,  3 Jul 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021663; cv=fail; b=GSLMJ2RxfWlx3zF4x3qJT4MQTNdp/huYdN4kG93jtnsQUCQKDUwY1LvOrn043OFaXrt+xjbHv/tf1QXRMlMeE7gtIEVVV5YgqrVtyDjVk5pfezTJXS8gfw71cX1IEFz/3IURz6Qw7B9B0zcCnEdpM+zKXRCaQ/bNOuNmhJopml0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021663; c=relaxed/simple;
	bh=rPYF/fjUA3IDLq+E49J6dTwWnK7MnYvp0FvzD/p+/+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AlWiWjXDZV11bBliwN54IS3UEZcJ8ry//pagEuCSuvjdHkg5xtR0guqYBUviH5yAOfuAX0ejiIFOMOC3ZANytCX+8lX3Zr6m/gP94vhASqz4VRr2ZNWKaeu+PbUd3efSxmEPUB07uqIxJWWpRF5YJiqdh7EY2uXRH4ijiaZEhPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TvpBCyPE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=y6LDi1Qv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720021661; x=1751557661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rPYF/fjUA3IDLq+E49J6dTwWnK7MnYvp0FvzD/p+/+g=;
  b=TvpBCyPESLVNog160L577RLhf4Ohi0yQtHo8SpSPhpr3xxMUHdpMsEKI
   2LD32nvfbEtLcMKiHwajVoDGZKWOC1cZqqaUhEOrrd9AEBEwxm3iY0iYs
   6EcQ4r0OGbMqVEp6oXTE/Hsu1zFaqBEJ8Ol8efisy97kfIzRiJtxgj+1g
   cD/yDPJ9IiPIEyH6BWTxwuujrWVWQf38u1v1DPibStc1D0nmF0ikeyP61
   FSVld3GvDW+TYyMD8oQ8ZKPxqYSwTpkfUXc6R/Vke2HYrIDLCQ5kWjtT4
   IVGXTq5DgoquQP9eXLEqaJoTYdTV2oKKWYH1J+pwwJUSyncEzfpkPrUwy
   A==;
X-CSE-ConnectionGUID: P4R+jKoBRpCC9sp3D/lchw==
X-CSE-MsgGUID: /ZrD0CBNTcScjw+y9kP1qQ==
X-IronPort-AV: E=Sophos;i="6.09,182,1716220800"; 
   d="scan'208";a="20029258"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 23:47:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0zMHAk4QoIuG7Eqr5h/SDtzL8fYMWfa91e26bYjGDbo2RAI5IDaqndE4G1shfKn4Pcgy26e911qmXb1YbTLDHtz4PChep5+8j7Ir/D2/vN2PVxS/+jBAyYrGCjxoSoFPs/64E0T9Z8PS0tyW50yTCE48EkavH8+rkkP/aD8UlRkYIv7pNxwSJ/EOR30uvqnzxxOvNrFY3g9zCts7zOG8x3lBSa8WAMgAZaSlHcOYmKp6V9kinCf97oO/JXaRDhDlNoYJHBSxB/E7BbUsPWwPgp+YInmfsoXmQHO75vmsFQE8zyyjWdHG02lc4vlHM16aP01umalfCTfPTeulhi1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPYF/fjUA3IDLq+E49J6dTwWnK7MnYvp0FvzD/p+/+g=;
 b=df2TUsoqQnjY/BXHe3F+8v+32rxp01n6FoyWg7IUq9mTfYhpKPff9bS8L9/IcAL1rhPOD+Y+o5XjgS3trAYSo2Iq6JWwygT3tgrzwhTvLpLIj/0XR6auxQvgPfLO+q1EEJGnBeotTyCgnwJDNSdDIZaoyhLGtB0Ny9dMEt5W8I0N6Ob4CLW+xCr9GuIAvfYItaiVeN6x5+n4JrozWMOAaKFyozO3MGnBMlyX8UKUEawxSsgB97inV2nKCYIJeYnYjLj2hbugUcWGaX5S+5rffYN+1weokpIk7KQt5ods/QBpanLObwdjw/55onH8FEECXvUPFK8jXfCWZZUaMVAhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPYF/fjUA3IDLq+E49J6dTwWnK7MnYvp0FvzD/p+/+g=;
 b=y6LDi1QvVGuU5i7EN/NFp5ziyIfk/DGc2TECWQF1zC23M3DMZhCHgQI1LIARVykXQuL21LWnD3TzHG0lj8+dIYBklGnh2pcg/U3hm+S9IznnM0H5YVm5vY+MSvv55kyxKKU6CknfiC2E68xW1AonkVaL8b6EA5ZBCOlP6TDWWww=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8892.namprd04.prod.outlook.com (2603:10b6:208:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 15:47:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 15:47:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH v3 2/5] btrfs: split RAID stripes on deletion
Thread-Index: AQHay6EBF335OD19KES5XaqQotfTKrHh6KqAgANAswA=
Date: Wed, 3 Jul 2024 15:47:31 +0000
Message-ID: <cf65595c-14ea-44c8-a002-2f23340dcfb0@wdc.com>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-2-e0437e1e04a6@kernel.org>
 <20240701140709.GF504479@perftesting>
In-Reply-To: <20240701140709.GF504479@perftesting>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8892:EE_
x-ms-office365-filtering-correlation-id: ab6e9326-9bbb-4ccc-24b9-08dc9b7772e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVlyYkZweEN3YjRGR0NWZUQyRHQ2c3pWZ0p3Q1Q2dVhjL1ZQOFRKVW5TdC94?=
 =?utf-8?B?STZ4U3hrRGFBeml0b0hKZlByd3NkK2VUb3hDK0ttMUdTcENRQmVUQkZSbGxK?=
 =?utf-8?B?L2VVV1hqbE5GamV2amJLd3FPTkxsZ0VQWndUUnJxdXd0SElWZWd3eEQ5ZUlx?=
 =?utf-8?B?bmh3MTAwSnVYMW1YYUl6VzVPYTJkNUt4cWd5eWQyYmdHakF4eXhMKy9DTzgy?=
 =?utf-8?B?eW5xckt4K3BTaXR5NWNqRy8wd0RWR2REM2l0TENldmhqckQvMG03NGJSVjFH?=
 =?utf-8?B?STZUcHRuemNITG5GcFErb1hyRWtGM3cvNFI4NXgrMVFSWTluN2k3bDZtaHhr?=
 =?utf-8?B?TzFCaklPRnFScEdFY2dTL1lIN2h6Z29WQ2w2SEFLNTVCR3AxUlhJanNxWnl5?=
 =?utf-8?B?M1NBUTFiWmFud01Sa1BzanUzVkxuVzNPQVdZTERLU2Fva3pPcGUrZmxjM3Vs?=
 =?utf-8?B?bXNzbUhzRnJXbWhhZjREZ2h4Q2p6VFFUeTgrQWd4ZzE3eUFWckRDS0hJYnRX?=
 =?utf-8?B?ZUNLcE1JNUlaaXJNbk1vUjM0cDhpZDRyb3hTUG5qVlloa2RudTJVUXVmYmF0?=
 =?utf-8?B?TDg1K0Z3RENGVFJqN054Si9neS9zcnNabDhEL21GQXc4bVhVdzExQ1h1QWlp?=
 =?utf-8?B?djFGZGZWcmExbjJ3UVpkNkFwR2RpalQzL2JyeFY4b3lHMS8wVnY2UG5mMExv?=
 =?utf-8?B?WFVYOUMzTW1lZnlSMWdUMzNNSHVpYlAyY2pZVlkrb1RmbUQrRlBnTVhnMXFs?=
 =?utf-8?B?Y25Zd2NJUkRFL3ZhaWtvZkNUN2I3em1mblFkOHJiV3hvTE05cFBLaHliLzFM?=
 =?utf-8?B?NmRicU8vNTVrcWYxaVEwMGxWZUpxS012cG02bzRPZ25nN1gzMzZpUHVJbmpQ?=
 =?utf-8?B?OEhlQ3pqMXM1VVVkdkhrbUZsNVlLQVNvZThFYVVWdVUvMVh3NE03N0hhWjZJ?=
 =?utf-8?B?eE9RY0FwTGhVL3dFZGNPOFVBTHF2R1c5QnR4aCtLVEo5d2NtSTM2ck5LaDJt?=
 =?utf-8?B?UGt1aTVLZmVXTlF3QTVWZjhHeEZHWmc3RE43ZWRsZEdkeFJlV0MxRGxxQUFr?=
 =?utf-8?B?eHkwWlo2eDAvdGNBNmtZcDdOejlyekFENjV1SW9hNzNNWnlOdlZQVnpUM2Fr?=
 =?utf-8?B?d0MvYmNNcm1OTG1wZnhIVTNybUxYanF6cENpRHZPeDhmQ0xqL1Zqb3hqK3NR?=
 =?utf-8?B?OGdVOHZtRW9XUTRuQlE3eXJUbG5KSUdBNy9wckVVRmFrRytIdmdUWXNHSS9y?=
 =?utf-8?B?c0EvUXdOUHRmVWJia0o4MlEwODhLMkF6UVRFQlR3NmdUTmg2N1FySDF5aTZH?=
 =?utf-8?B?eUZGM2hicGlCQ1ZuTHUvdVNBWXgwV1R3Mm9Fc0xtbzA0ZFZZeVplNC9IblNI?=
 =?utf-8?B?V0szTWk3RGRCTWNlYW1yTXRkZCtEeHFDRVQ0RTl4aFhmdzNsN0FLVEFGKzQ1?=
 =?utf-8?B?dlBNenJvQWNuYXljcDJLQ0JiNG0ySnFiai9iczMyQmlleVdkQnRsREhmNTFM?=
 =?utf-8?B?aC92UzNMNHg1OE56MUx2YjlicWNZOElWSWJvRkpyamdUK3ZOSlpFWmVXVENz?=
 =?utf-8?B?K3R4QzUxeVBreENkVXpDSzRPeU9RdTB5V2tocFR2amF6eTBjSFc5am5HWmZV?=
 =?utf-8?B?OEFsM1BYaGR6a2dpN2doandxckxJdHJPR0JDR1JYUlNCbkJLZlk4YjU1N01G?=
 =?utf-8?B?Z055RzNXK1IwT0p1cXljblp1WU1zejlhRkpHdEhBNlF5SkVveFpPMnIvY3Az?=
 =?utf-8?B?R0taQmNReXVraWVGbXRHeUhCbUhNdmxmVGx3OTJWL1BrdHVlSkdmaUtyWURj?=
 =?utf-8?B?TEhML0c0WnhZTmZ0U3ZualBCbGFSRDh1NXBxUjQ1UXVWMUV6OXpoV29MT0N3?=
 =?utf-8?B?ZXRPSm1UR0lzMlRCTGMzeWdGVEZUU0NRSWx6bVJZQmhhU3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFhwOHU5MVVmUWlsR0lWeDl1M2pwbkZEVndVZUl2R0ZQdEszSUhTMzd6Qlp4?=
 =?utf-8?B?TmZ0OHhLd3ViNGhua0RYSXA5R0M2VGlIYzV4MmpuUnZQL3dEUE5WdTNpMG9G?=
 =?utf-8?B?cG9FLzl1SFhZOVprQ3BUOWovMHQvdXlVUzk5MkxwNXpNVGpDSCtCcE1WSEsz?=
 =?utf-8?B?ekY3cXVvSWtEb1VBWjgwOTI5RUVxVnozT3dwT3hrWWZmdWhjanNndWhGSlV2?=
 =?utf-8?B?VGhXdVZiUnFBYU9vOGRveVpHNlR1NVpqem4yYkVqN1VOdVhFM2UzTW85Wjhy?=
 =?utf-8?B?VVZ3VldWSGRtWW91VHE1MENMYjlZOHFzN0FFdjIzZGpSOXNDUFVieUtRNHpC?=
 =?utf-8?B?ckFkVDdvVkxBcXRwRGJzSUxRR3Bnbks2RlVhNEp6OHhJVW9JNW0rTWlnd3JD?=
 =?utf-8?B?UTQ2b2sranFJOURFMFM5T242SXdyL2ZlNWdGaENTT3dkOHE3dFBhSWFlYllJ?=
 =?utf-8?B?RmJBd3Q4ZktSRkdra3pIeXdPbkh0cTlGVVVaL0NmcWY0M0N4RUkrdGtCTGlI?=
 =?utf-8?B?TUhDemNiZGMyWlJ5NHcrQXVYbStBVVNYMms0MWhWc2g2bVRLN3FTRUw2VVNI?=
 =?utf-8?B?MmVjb3hwRVF3NUxJbk1FTEJ0ODhoZSs4empPZlZBaGJSTWs4Rnp2TU8vTmdG?=
 =?utf-8?B?Y05DRm5iUk8zSUJmeVZicC9OSkc3ck9XQmJpRkcrVGVuMWc5VGR1VHFSNDgz?=
 =?utf-8?B?d3hDQXpJNlhxUmViT0VoTW1tM3FLelJ1K0xVMVI4cE5xSnNQMEJySFpYYkdN?=
 =?utf-8?B?QXlFcmFsQ1NNeUY1WU92MEJtYUdsWlM0MWFLVFRpQldaMGlidG9PS2Zmbm5W?=
 =?utf-8?B?Z29wTDg1Vkc2ckNWLzBTMXQ3MTZrYkNCdkI2U1pHRjZZYUlaZVRoazNkY21h?=
 =?utf-8?B?b29xTTA3ZHBxdjIrRU4vblpvZXVVQXArRHpuU2lVOVI3eGJiSmdrbmNpZmVx?=
 =?utf-8?B?OTdwYUNodUhOZ2Mwd1p4TjRsUDZZbjF6WVF4Y0tFSzFnS2xnT3g5dFcyVFZa?=
 =?utf-8?B?eXNWa2lyUE8yYVJmL2o4UGh0NEVXUjNYY3BYZ1dRejBvMGMyTzZuNG90d3py?=
 =?utf-8?B?Ky85WEV1bk1kazVQYzZ2UDVWSXVlNFhDeTlGRnRYV3BidFJZRHZaL0dVZVR4?=
 =?utf-8?B?TTJ5a2JLbHhBZndBRWFydll4NmJoUUdYdDBzYWVSQ1JqcExtTGRFaXZyd002?=
 =?utf-8?B?R0xsRUhpV2M1SmQ5eFdWWUo0NlRCTGlwTC9JNHVxUzA1aGZWNUJrdGNNSXZ1?=
 =?utf-8?B?d3l2N0ZOUGtCNk5wbTZ5dkJCdGUvOHdoRURLT1lwYmFmTGNwZ21MZjFEeWRs?=
 =?utf-8?B?eXRoK3hUbWhQMUFPK25TYjFnV2psNHBwMXhibHhyb0FiaTVEZ0ZiZGp4OWl0?=
 =?utf-8?B?MEZXVnJhWGNab3gxK2ljNjN5UW9rdHZkUFg3Q1l2WHNMZEkwbFhNK2dJSm1S?=
 =?utf-8?B?TllXWnJ6Wk9WUnZZcE5tYWErd2lvNFFoUFl4YXFLRC9IWmlUVXhYdTI1VEIw?=
 =?utf-8?B?cjdMTW9seVJib0hnTHRteVJxTENHQlA0SVN2c0psc05oVUNqQ0g2M3I4MDA5?=
 =?utf-8?B?UXVEWmF5UThxOFhkQWk1VlZKaTFwcFVsUms4Y1QyRUpOaUx3bGVtb0RnMmQ1?=
 =?utf-8?B?VnNBRzJPZnVGakxydi82S2FmT1AwUnR5MzNlelRWNFNLQk1RMzVMaDlYbG9t?=
 =?utf-8?B?UUJNQkVBTkpqcEZJS2lWVE5Hb2FmZWFWbUh6QlcrZXpXQjlSbnp2QWcxNmtW?=
 =?utf-8?B?NHhlMzlqRzdZWE1kYWVsWWI4YkVqOTI0RW16bDIzTHZyUXI0cDY3TEhSK2lm?=
 =?utf-8?B?VElEM2VpckFMRnB1Vk9jeTdwMFFNMFMzckc4NE05UEdhUEhvS3c1T2htSGFP?=
 =?utf-8?B?c0o2ZnRLQngxK0JmdldndDdJODQrU2lpd0ZWdXpPU1grUDdLLzkrVnVaK2tl?=
 =?utf-8?B?ZFIrZnVaTjJQb2V5NUpvQWxaT2dFMEVXZVhvNGs0NVcvQ3pFQkpZenk5TzVU?=
 =?utf-8?B?QU1JK3JhVkY2cDg4cEtxZkV3aW1FdThGdkEvTVh1Yyt2OFoxY3RndStTVTNu?=
 =?utf-8?B?Z2RBMGljcDBldm1kTU1UTklYZmVMR2hkaDRRR0NpbFVTSzFENUs3OEhOMGN6?=
 =?utf-8?B?V0NSL0k1MFE1VXhSQVg3QTZSWlVHRFQ5ZTVtNlBRTjdsUkczbTZaQ003OW1R?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AAA27CCD2989147976EC27B4BD9B292@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0PcNrpQH+DFQ45iu4yatpZGtBc+S5NaC6OvByDFdz1Lckv91BEgBeSIgdk2shvZm5vVXvC/N7M9TjBZpUuIWg7/r3P1eUrIus826vgSG1jNRwPh6SHaetTUizgTCvWMpLtBRUvYSpssYKRycIIuAryZX1Sqx7pt+BbVvkucV0SdwUPlOXpyY8Gv01Rio0IhfMEmZdsdHr+AtrZzyqZVVP1tGrKIFUsJZPMQYKzNb38cxjs1ciOMsfqNSRJ9BfEN2k074YpRqEJXeaQmTAw/OjSYupFlwotjk5QRvG6IBfbn/O2TsibBFi4xfFRJQ+5EwcT9lE6OtWX2Rz8DkBK14jb0NBQdGRSHJqJXQHUVFXOQHI65l99A2o8V8mfWQ7uYUNQnhYbvp6mAT/vnhS3uh7qh/qLQcY8wq1jmsTTlBvUltrFqB/k2Yrd5iZP1CP+fK9gjHTAj896sfTaJY1O6BnhwjuB3CAtU1k44/Pdb0Ye/zXLH2VCufshH3VQ3GGzJZab7ok6PDBT2Y9nQAdyryat0fj3N02h6x+6UwbRnTbEzrx+91F4J5KMBJbKaue0ktTb4mDc6J4FAawIgLC+lSRXyiuRGx/hhXuYnPq6NCHPPuC6wX4tT95de0wUlrfPR1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6e9326-9bbb-4ccc-24b9-08dc9b7772e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 15:47:31.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHGnnXw02myZtsHx1cJsG5g2NzObg8TWnSPZ59gzFVMYjTPBAstpQPax0GPAht2cdLmFw7hTG4LfE58lFX+tAPInxKaB5FULcYrCTrM6Ric=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8892

T24gMDEuMDcuMjQgMTY6MDcsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBPbiBNb24sIEp1bCAwMSwg
MjAyNCBhdCAxMjoyNToxNlBNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBG
cm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4N
Cj4+IFRoZSBjdXJyZW50IFJBSUQgc3RyaXBlIGNvZGUgYXNzdW1lcywgdGhhdCB3ZSB3aWxsIGFs
d2F5cyByZW1vdmUgYQ0KPj4gd2hvbGUgc3RyaXBlIGVudHJ5Lg0KPj4NCj4+IEJ1dCBpZiB3ZSdy
ZSBvbmx5IHJlbW92aW5nIGEgcGFydCBvZiBhIFJBSUQgc3RyaXBlIHdlJ3JlIGhpdHRpbmcgdGhl
DQo+PiBBU1NFUlQoKWlvbiBjaGVja2luZyBmb3IgdGhpcyBjb25kaXRpb24uDQo+Pg0KPj4gSW5z
dGVhZCBvZiBhc3N1bWluZyB0aGUgY29tcGxldGUgZGVsZXRpb24gb2YgYSBSQUlEIHN0cmlwZSwg
c3BsaXQgdGhlDQo+PiBzdHJpcGUgaWYgd2UgbmVlZCB0by4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0t
DQo+PiAgIGZzL2J0cmZzL2N0cmVlLmMgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGZzL2J0cmZz
L3JhaWQtc3RyaXBlLXRyZWUuYyB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKyksIDI0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9jdHJlZS5jIGIvZnMv
YnRyZnMvY3RyZWUuYw0KPj4gaW5kZXggZTMzZjlmNWEyMjhkLi4xNmY5Y2Y2MzYwYTQgMTAwNjQ0
DQo+PiAtLS0gYS9mcy9idHJmcy9jdHJlZS5jDQo+PiArKysgYi9mcy9idHJmcy9jdHJlZS5jDQo+
PiBAQCAtMzg2Myw2ICszODYzLDcgQEAgc3RhdGljIG5vaW5saW5lIGludCBzZXR1cF9sZWFmX2Zv
cl9zcGxpdChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICAgCWJ0cmZzX2l0
ZW1fa2V5X3RvX2NwdShsZWFmLCAma2V5LCBwYXRoLT5zbG90c1swXSk7DQo+PiAgIA0KPj4gICAJ
QlVHX09OKGtleS50eXBlICE9IEJUUkZTX0VYVEVOVF9EQVRBX0tFWSAmJg0KPj4gKwkgICAgICAg
a2V5LnR5cGUgIT0gQlRSRlNfUkFJRF9TVFJJUEVfS0VZICYmDQo+PiAgIAkgICAgICAga2V5LnR5
cGUgIT0gQlRSRlNfRVhURU5UX0NTVU1fS0VZKTsNCj4+ICAgDQo+PiAgIAlpZiAoYnRyZnNfbGVh
Zl9mcmVlX3NwYWNlKGxlYWYpID49IGluc19sZW4pDQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMv
cmFpZC1zdHJpcGUtdHJlZS5jIGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQo+PiBpbmRl
eCAzMDIwODIwZGQ2ZTIuLjY0ZTM2YjQ2Y2JhYiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3Jh
aWQtc3RyaXBlLXRyZWUuYw0KPj4gKysrIGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQo+
PiBAQCAtMzMsNDIgKzMzLDk0IEBAIGludCBidHJmc19kZWxldGVfcmFpZF9leHRlbnQoc3RydWN0
IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsIHU2NCBzdGFydCwgdTY0IGxlDQo+PiAgIAlpZiAo
IXBhdGgpDQo+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+PiAgIA0KPj4gLQl3aGlsZSAoMSkgew0K
Pj4gLQkJa2V5Lm9iamVjdGlkID0gc3RhcnQ7DQo+PiAtCQlrZXkudHlwZSA9IEJUUkZTX1JBSURf
U1RSSVBFX0tFWTsNCj4+IC0JCWtleS5vZmZzZXQgPSBsZW5ndGg7DQo+PiArYWdhaW46DQo+PiAr
CWtleS5vYmplY3RpZCA9IHN0YXJ0Ow0KPj4gKwlrZXkudHlwZSA9IEJUUkZTX1JBSURfU1RSSVBF
X0tFWTsNCj4+ICsJa2V5Lm9mZnNldCA9IGxlbmd0aDsNCj4+ICAgDQo+PiAtCQlyZXQgPSBidHJm
c19zZWFyY2hfc2xvdCh0cmFucywgc3RyaXBlX3Jvb3QsICZrZXksIHBhdGgsIC0xLCAxKTsNCj4+
IC0JCWlmIChyZXQgPCAwKQ0KPj4gLQkJCWJyZWFrOw0KPj4gLQkJaWYgKHJldCA+IDApIHsNCj4+
IC0JCQlyZXQgPSAwOw0KPj4gLQkJCWlmIChwYXRoLT5zbG90c1swXSA9PSAwKQ0KPj4gLQkJCQli
cmVhazsNCj4+IC0JCQlwYXRoLT5zbG90c1swXS0tOw0KPj4gLQkJfQ0KPj4gKwlyZXQgPSBidHJm
c19zZWFyY2hfc2xvdCh0cmFucywgc3RyaXBlX3Jvb3QsICZrZXksIHBhdGgsIC0xLCAxKTsNCj4+
ICsJaWYgKHJldCA8IDApDQo+PiArCQlnb3RvIG91dDsNCj4+ICsJaWYgKHJldCA+IDApIHsNCj4+
ICsJCXJldCA9IDA7DQo+PiArCQlpZiAocGF0aC0+c2xvdHNbMF0gPT0gMCkNCj4+ICsJCQlnb3Rv
IG91dDsNCj4+ICsJCXBhdGgtPnNsb3RzWzBdLS07DQo+PiArCX0NCj4+ICsNCj4+ICsJbGVhZiA9
IHBhdGgtPm5vZGVzWzBdOw0KPj4gKwlzbG90ID0gcGF0aC0+c2xvdHNbMF07DQo+PiArCWJ0cmZz
X2l0ZW1fa2V5X3RvX2NwdShsZWFmLCAma2V5LCBzbG90KTsNCj4+ICsJZm91bmRfc3RhcnQgPSBr
ZXkub2JqZWN0aWQ7DQo+PiArCWZvdW5kX2VuZCA9IGZvdW5kX3N0YXJ0ICsga2V5Lm9mZnNldDsN
Cj4+ICsNCj4+ICsJLyogVGhhdCBzdHJpcGUgZW5kcyBiZWZvcmUgd2Ugc3RhcnQsIHdlJ3JlIGRv
bmUuICovDQo+PiArCWlmIChmb3VuZF9lbmQgPD0gc3RhcnQpDQo+PiArCQlnb3RvIG91dDsNCj4+
ICsNCj4+ICsJdHJhY2VfYnRyZnNfcmFpZF9leHRlbnRfZGVsZXRlKGZzX2luZm8sIHN0YXJ0LCBl
bmQsDQo+PiArCQkJCSAgICAgICBmb3VuZF9zdGFydCwgZm91bmRfZW5kKTsNCj4+ICsNCj4+ICsJ
aWYgKGZvdW5kX3N0YXJ0IDwgc3RhcnQpIHsNCj4+ICsJCXU2NCBkaWZmID0gc3RhcnQgLSBmb3Vu
ZF9zdGFydDsNCj4+ICsJCXN0cnVjdCBidHJmc19rZXkgbmV3X2tleTsNCj4+ICsJCWludCBudW1f
c3RyaXBlczsNCj4+ICsJCXN0cnVjdCBidHJmc19zdHJpcGVfZXh0ZW50ICpzdHJpcGVfZXh0ZW50
Ow0KPj4gKw0KPj4gKwkJbmV3X2tleS5vYmplY3RpZCA9IHN0YXJ0Ow0KPj4gKwkJbmV3X2tleS50
eXBlID0gQlRSRlNfUkFJRF9TVFJJUEVfS0VZOw0KPj4gKwkJbmV3X2tleS5vZmZzZXQgPSBsZW5n
dGggLSBkaWZmOw0KPj4gKw0KPj4gKwkJcmV0ID0gYnRyZnNfZHVwbGljYXRlX2l0ZW0odHJhbnMs
IHN0cmlwZV9yb290LCBwYXRoLA0KPj4gKwkJCQkJICAgJm5ld19rZXkpOw0KPj4gKwkJaWYgKHJl
dCkNCj4+ICsJCQlnb3RvIG91dDsNCj4+ICAgDQo+PiAgIAkJbGVhZiA9IHBhdGgtPm5vZGVzWzBd
Ow0KPj4gICAJCXNsb3QgPSBwYXRoLT5zbG90c1swXTsNCj4+IC0JCWJ0cmZzX2l0ZW1fa2V5X3Rv
X2NwdShsZWFmLCAma2V5LCBzbG90KTsNCj4+IC0JCWZvdW5kX3N0YXJ0ID0ga2V5Lm9iamVjdGlk
Ow0KPj4gLQkJZm91bmRfZW5kID0gZm91bmRfc3RhcnQgKyBrZXkub2Zmc2V0Ow0KPj4gICANCj4+
IC0JCS8qIFRoYXQgc3RyaXBlIGVuZHMgYmVmb3JlIHdlIHN0YXJ0LCB3ZSdyZSBkb25lLiAqLw0K
Pj4gLQkJaWYgKGZvdW5kX2VuZCA8PSBzdGFydCkNCj4+IC0JCQlicmVhazsNCj4+ICsJCW51bV9z
dHJpcGVzID0NCj4+ICsJCQlidHJmc19udW1fcmFpZF9zdHJpcGVzKGJ0cmZzX2l0ZW1fc2l6ZShs
ZWFmLCBzbG90KSk7DQo+PiArCQlzdHJpcGVfZXh0ZW50ID0NCj4+ICsJCQlidHJmc19pdGVtX3B0
cihsZWFmLCBzbG90LCBzdHJ1Y3QgYnRyZnNfc3RyaXBlX2V4dGVudCk7DQo+PiArDQo+PiArCQlm
b3IgKGludCBpID0gMDsgaSA8IG51bV9zdHJpcGVzOyBpKyspIHsNCj4+ICsJCQlzdHJ1Y3QgYnRy
ZnNfcmFpZF9zdHJpZGUgKnJhaWRfc3RyaWRlID0NCj4+ICsJCQkJJnN0cmlwZV9leHRlbnQtPnN0
cmlkZXNbaV07DQo+PiArCQkJdTY0IHBoeXNpY2FsID0NCj4+ICsJCQkJYnRyZnNfcmFpZF9zdHJp
ZGVfcGh5c2ljYWwobGVhZiwgcmFpZF9zdHJpZGUpOw0KPj4gKw0KPj4gKwkJCWJ0cmZzX3NldF9y
YWlkX3N0cmlkZV9waHlzaWNhbChsZWFmLCByYWlkX3N0cmlkZSwNCj4+ICsJCQkJCQkJICAgICBw
aHlzaWNhbCArIGRpZmYpOw0KPj4gKwkJfQ0KPj4gKw0KPj4gKwkJYnRyZnNfbWFya19idWZmZXJf
ZGlydHkodHJhbnMsIGxlYWYpOw0KPj4gKwkJYnRyZnNfcmVsZWFzZV9wYXRoKHBhdGgpOw0KPj4g
KwkJZ290byBhZ2FpbjsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoZm91bmRfZW5kID4gZW5kKSB7
DQo+PiArCQl1NjQgZGlmZiA9IGZvdW5kX2VuZCAtIGVuZDsNCj4+ICsJCXN0cnVjdCBidHJmc19r
ZXkgbmV3X2tleTsNCj4+ICAgDQo+PiAtCQl0cmFjZV9idHJmc19yYWlkX2V4dGVudF9kZWxldGUo
ZnNfaW5mbywgc3RhcnQsIGVuZCwNCj4+IC0JCQkJCSAgICAgICBmb3VuZF9zdGFydCwgZm91bmRf
ZW5kKTsNCj4+ICsJCW5ld19rZXkub2JqZWN0aWQgPSBmb3VuZF9zdGFydDsNCj4+ICsJCW5ld19r
ZXkudHlwZSA9IEJUUkZTX1JBSURfU1RSSVBFX0tFWTsNCj4+ICsJCW5ld19rZXkub2Zmc2V0ID0g
bGVuZ3RoIC0gZGlmZjsNCj4+ICAgDQo+PiAtCQlBU1NFUlQoZm91bmRfc3RhcnQgPj0gc3RhcnQg
JiYgZm91bmRfZW5kIDw9IGVuZCk7DQo+PiAtCQlyZXQgPSBidHJmc19kZWxfaXRlbSh0cmFucywg
c3RyaXBlX3Jvb3QsIHBhdGgpOw0KPj4gKwkJcmV0ID0gYnRyZnNfZHVwbGljYXRlX2l0ZW0odHJh
bnMsIHN0cmlwZV9yb290LCBwYXRoLA0KPj4gKwkJCQkJICAgJm5ld19rZXkpOw0KPiANCj4gVGhp
cyBzZWVtcyBpbmNvcnJlY3QgdG8gbWUuICBJZiB3ZSBoYXZlIFswLCAxTWlCKSBhbmQgd2UncmUg
ZGVsZXRpbmcgWzAsNTEyS2lCKQ0KPiB0aGVuIHRoZSB0cmVlIGF0IHRoaXMgcG9pbnQgaXMNCj4g
DQo+IFswLCBCVFJGU19SQUlEX1NUUklQRV9LRVksIDUxMktpQl0NCj4gWzAsIEJUUkZTX1JBSURf
U1RSSVBFX0tFWSwgMU1pQl0NCj4gDQo+IHdoaWNoIGlzIHZhbGlkIGFzIGZhciBhcyBrZXkgb3Jk
ZXJpbmcgZ29lcywgYnV0IGlzIGEgdmlvbGF0aW9uIG9mIHRoZSByYWlkDQo+IHN0cmlwZSB0cmVl
IGRlc2lnbiBjb3JyZWN0PyAgQW5kIHRoZW4geW91IGRvIGdvdG8gYWdhaW4sIGFuZCB0aGVuIHlv
dSdsbCBkZWxldGUNCj4gDQo+IFswLCBCVFJGU19SQUlEX1NUUklQRV9LRVksIDUxMktpQl0NCj4g
DQo+IGJ1dCBsZWF2ZSB0aGUgb2xkIG9uZSBpbiBwbGFjZSwgY29ycmVjdD8gIFRoYW5rcywNCg0K
T2ggcmlnaHQsIGp1bXBpbmcgYmFjayB0byBhZ2FpbiByZW1vdmVzIHRoZSB3cm9uZyBvbmUgOi8N
Cg0K

