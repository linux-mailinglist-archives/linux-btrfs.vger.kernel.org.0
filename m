Return-Path: <linux-btrfs+bounces-10548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F69F6232
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2B1883EF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED453198832;
	Wed, 18 Dec 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ol35g117";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BKkLgKrB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C2158D6A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515758; cv=fail; b=jt1B8II+Q2oJ1+Z8Xn6X96vSystGqeezAmiPysapRPjWwusznjRHBbpr4BULlNsWfbiN0AwfITT9aS80wk4XW5352c4ce0z6D/VIknT484xPs2MopOBuP2EG6HvSn0B7SCzlqmu7k+R60wquD7zh4wWDVJPHcQiHlz0CgEn0Nh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515758; c=relaxed/simple;
	bh=OvMU3rHE89/PX0aKiHeN7OC1iYyZh8r/6HKFw/KYfo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2Hl9R5uL7CpW5qJRfT8m3RVC8pE3DJ4zX7O/oVi1UE4J0Q2MkYvf6LLehZu7IOXWa9wARmsT3W+fxRkbz4+/I/ftnzKaZmZeNDh2b9r9tv1pOaxdOWgc0Hlk2gWJ8evTBB420kEg/CRG/4B8ktmMDMuXL+hwWrXdhidF04avzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ol35g117; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BKkLgKrB; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734515756; x=1766051756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OvMU3rHE89/PX0aKiHeN7OC1iYyZh8r/6HKFw/KYfo0=;
  b=ol35g117hbrgDgpZ+DfUFVN4+a9DxG7AithZ9a8/h8vSrMeiGn6SGsuY
   3WClJfd1TPWnJEuzHl1jIzcDRDWGLUq87p6oaoWC/lpvrbSGSN7vU1rFi
   AZFvcL0K9mH98dIbRn0iNJA36NadfX6oAKMv3V7gtafJi74OCgtuDTv7b
   PIWFlLmHy+L86q6+G+YFLdxHgoj14ntAjfanBet45lLRxz4PlnxoTanXS
   GsmsbYG07wgbXiu/a+FdddkA9X5stDAn94TZJV9MGv7MnRhdLgJsbH5a3
   GLAGKFd5lSLiYsESNZxTwd0495zoxU14QH2JJrkQnvoD9k8EeNsh1s8pf
   Q==;
X-CSE-ConnectionGUID: K9yNjyXoTSi2pdIrS/wEIw==
X-CSE-MsgGUID: hM5cZb62TwGKXq2OeqkjYQ==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="33966287"
Received: from mail-southcentralusazlp17011030.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.30])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 17:55:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBTFv/geoSItoo59U07aNszLjj7mZDSbqdt3IseVOLsH5xcnf5NhCFKM9uNOwzAWK44VjChGCX/rNMbNwjNe1Es7/9Z3cJOWIpPNLlhGYdaVddQcl0Tf+KkCckF6ZJDOeJAy8NfBwX5Vemr0AJD4lEDHv3ZnDgJ1iSBoHrsNjU0DQYzBy2z3+juq+mtlNDhy1RNJGiiozOJbCDiWyC3uudeDytXlNKCs0b3MEgpu0/IpaH2UtwHMzAVIcV0OgyLHItkQuGprQCsIu3JGkdjzvknmS48Uadb5XwHf5fLX+j1SzZZYH52UannKINQhbiOzo/TK9C3aY+kH7ZBO/57c6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvMU3rHE89/PX0aKiHeN7OC1iYyZh8r/6HKFw/KYfo0=;
 b=mWu3LiwGG9+tCanZd/J5yOhO3MQqPz39irndlMHjSbzpJpq1wGripi5bVURF3fPioin81ePyHpuQsXDQ31XUTJmmjOAcpB73xT6jRSt2Hb3ihPTSaGMZgzDcTaJUnCqD34lSjz+ligPZmdYTbHmc4f41VujLH49yWlrdbfhBGbioy+y8qu3Y8YLNT6tsWeOjDJ6odvo/mwFGqy8HYoKMkLk3GJTOQmwLe/Rnp7U5G8qq4w6/F6QR8x09TUXNsLBeFLS+qIULjAii/GT55E/2Ptf//U/EcP2ZDBAh8Xm5i22A8DHlvdzwK20YAX3wihKmOpdam2BNjpHLPZQL3dVoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvMU3rHE89/PX0aKiHeN7OC1iYyZh8r/6HKFw/KYfo0=;
 b=BKkLgKrBAO9B7/bsvsGXsNDjt8SvWefYg1S/n4Rgnt0NuI2oon3FxrDiCwCHE/y2QjqtFlmeC09EueTIqGdTeT3MjIsaBh+aByJrRoc153c8s3ETKJibWFA1NMeyYzC4QcD1QTy0Dlgtutb+KOmQWFccBIRrelGq+YkS83NcM7A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9457.namprd04.prod.outlook.com (2603:10b6:610:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 09:55:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:55:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik
	<josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>, David Sterba
	<dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu
	<wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 04/14] btrfs: fix front delete range calculation for RAID
 stripe extents
Thread-Topic: [PATCH 04/14] btrfs: fix front delete range calculation for RAID
 stripe extents
Thread-Index: AQHbTGtOVhyV8AtrSkue5ms4yhdWebLqkKqAgAE8iAA=
Date: Wed, 18 Dec 2024 09:55:51 +0000
Message-ID: <91fbee26-e3a9-4413-9028-7579ed7b4b08@wdc.com>
References: <cover.1733989299.git.jth@kernel.org>
 <e996ff4c30ef83f271f2495d700635287d5587d9.1733989299.git.jth@kernel.org>
 <CAL3q7H4L05uE1wVtrW21-bSJvtiQpwHk_aQ8OJy7JEa8zwVNmg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4L05uE1wVtrW21-bSJvtiQpwHk_aQ8OJy7JEa8zwVNmg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9457:EE_
x-ms-office365-filtering-correlation-id: 69bd424a-9afc-489d-9e71-08dd1f4a27d9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGwrSFM0K3B2NXNwZ1ZsbGprUDJzOTlLWGFZOTFIK1RyaEpHSEE0MTBuSENX?=
 =?utf-8?B?Sk1BNlhuSGhEZkFRRllhRVlOVXhjS2FhN1VRczJGS0NSdDJva0pwLy9WbHA0?=
 =?utf-8?B?M0hiTjVvMnNLOEVRc05KTXJaKzFZdS9kYW5oa2RCSnR4TzUydjRGa1pOTnMx?=
 =?utf-8?B?cXRza1E5TXRwcVVhc3c3eUlRQUwvZmZleiszVzBGdGJJNXVIVGEwb2xFMkY1?=
 =?utf-8?B?bGFxL1BTcitlTW91YnpxWjFNckNyV0JTWEkrQ1JFaVlMUEhDRkhETWxLMUxp?=
 =?utf-8?B?bHZyQzNJTzNENm4vaStQbGpPY1ZXRDBEdUQ3N3haT01tc1EwcGt4Z3pqZ1gx?=
 =?utf-8?B?VjNwdGtyVmlHNkpHcy9DbGlYc21DWEs0NWhXMzQwUklxVW91RVQwakk2ZXgv?=
 =?utf-8?B?bzZJVmRkS0E2bHJkUFhJaGtCcExkdDRsaEwyWDJvLzFtdGk4TXJoeExmeVVy?=
 =?utf-8?B?aWV4U3JsQ0pWZ2k1M3NHaXpFeUFLNC9EMVlBeFhnNVBBM1hITGZCRHkwZUl4?=
 =?utf-8?B?ZS9yWUtUbFhEL1QyTWhUSjRCa1dNZjNhditveVdlMnUzWitRb1FMQjB2VmtY?=
 =?utf-8?B?R0JBVFdnb3VJdFpISWxwU0ZyKzhtL2JCYXVxaWl5dE0rbUw3dGNBT2NQN0tN?=
 =?utf-8?B?dEJ1aW9rSThQMUYrOUlFQ3VSYUI0QWIxenZHZGI3ZU1VakpNVWtHd0tKblJo?=
 =?utf-8?B?MzR6ZWtFdDJqeGtRR3N6ZnR2djNtWmZ0NEQyc2FBYlI3SHVjUmhDbWhzZE1t?=
 =?utf-8?B?Tm14V09Fa2pLbTBvbGV5M1ljTGVNV1ZkZWNuTTkzamc3dUpNVkFNYTJTK2VF?=
 =?utf-8?B?MXFuNEFRZnQxRVZ0Q0ZBd0Y2VjFvc0FCbkpJcTdRZ0ZiWDNqenFRMG9TNjVx?=
 =?utf-8?B?bkI1dFI2VWdOQTdEUnFHcUZLNVdLMGdIakhpRjE2MnczSlpKb0VmY3d0d2hZ?=
 =?utf-8?B?MU42dGR3T3dodXdVL1FsMitqTjNLQlZaL3lpTVQ3L3pCYVlkZ3pFOHdhK2pT?=
 =?utf-8?B?VnlOT050ZW9PK3dSancyN2t4UWpSVzh5bFVPWFVWbFM3L1NNckk5eXNoOFN3?=
 =?utf-8?B?TTR1b1kwVVlwelJEVjUxTXZmQ3V6R2x1NTZsRkQ3WnlrTTZUcStzWkRBN0lL?=
 =?utf-8?B?WU9BWmZxZjM3bVZIOE5GWThTMnI2NmNmYVNWczJEMTdVVU9FVkRCNS9LbU9y?=
 =?utf-8?B?dmQyK1NUOWZTMEdxbTR2dWxLV2NtdHhjYUdjVlVPYW1UelltSHhNWEx5SjA4?=
 =?utf-8?B?SXIwNUJQUk95cUYrN0dyWlRzL1oxTFVsWjhDd2JVWC9ING5xbkhIZ3FDOVpG?=
 =?utf-8?B?SWRCNmJJaGsyMCtIeUFDdkdhRXBRQXdrZkliWnpkY1V0MWw4SHBtdlpQenpo?=
 =?utf-8?B?Qi9TK1VUZnBmdDRKN2svMERMMHMzSmd4QnQxY0twcEh4b3Axc2RQb2VuK21n?=
 =?utf-8?B?K3IzZE4rSzJBQVdZaUtSSkNaT2ZnajFRZTdab0g1NFlpWjEvODFFSlZSMDVq?=
 =?utf-8?B?N2FhWGNhcU9DMUJOc1FNeDJjVk9UOC84RXFVU2RqZXBjWlRONDdZSHhNdExX?=
 =?utf-8?B?ZkZvcmpLSHhrc2x2WWNNZVpCdEZqK1FTTnBCVEhtdzBlaks1UFRLZk5jM3RP?=
 =?utf-8?B?aGNSOHl2VFN0WS9wVTFUdHp5eDdlRVY5ZlJBZVNwOUtDcUVsaTZjY0RGVXBZ?=
 =?utf-8?B?TEo1WEE3VXJJZW9pVTh2enpYRkJhODdOckdnYWNYbTNiVW5qcGs1UUdodVp4?=
 =?utf-8?B?bzV6TUNIcjlKMDNFWXBKbFBsRnk1VUFuVjNrSW9ZMTBUUytGVkF3Nm9rUzNl?=
 =?utf-8?B?ZlhyTUQvOVdEY0MzNEtXbUVEZUNMNXgyZ3czbmhLbGEwTkgwYklRRWhYWW9B?=
 =?utf-8?B?OGpTR0kzZFdzcGw5Q25ONjFUOVM5OWRhdjhFdTdRMCswSVc4U3htY2pYQUdV?=
 =?utf-8?Q?3S61MhSB8EtCJNy3lAQUmQA3ffoOJkXn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmFISVNQczZLQW43bXc3TENncFNoTVBOcTRZd3JxaWgvV0Q2a01IeUkxZnNs?=
 =?utf-8?B?VCtXakozOE9jM05BM1hYK0kxWW9YblJHdlFrcDR1RjVJd096K21CSTRQd1pN?=
 =?utf-8?B?ZldEVmhRaFpYMnIvZjlVQ2NTVzY2Y05YK1dIZHVBcHRpZ0xLcVlQTGcxY05D?=
 =?utf-8?B?OVJaZVM5VElIdGdTZEhlOTVvWGJwOTM0OTBlOTdlV202VXRXVmxCd0tNWmlE?=
 =?utf-8?B?VUdFNkdjbU1NRzNFT2pDQks3THo2UTMvc3Q0UTgzNlJadHgvYVVZUnlkc3Y3?=
 =?utf-8?B?aFFLNzJDdTdKWHpXcHdkWmlSRWRtRXYrbWUrUFZ1UGsvMzdsS1FQckZCR0E4?=
 =?utf-8?B?Z1RJd1BNOGVrd1hmYzJWWVNsamdzd2dmNWZUN0puUTIya2xDQnpwend3amhL?=
 =?utf-8?B?MHptcUl6TFIzYkhnNFJWb0NOSXlCcmlMRk5DblBLMXh5UVZFdndEZFdtYnNO?=
 =?utf-8?B?UVZ3MnRoYXkyaW1kMm05MVVRN3pPOG9XODZ0Y1BYNHVSN01xZVNPNTFQY3Fn?=
 =?utf-8?B?WE9zWXczdWFtOEovQllWN0hvRDVwaFNmNUFQaXJFRmVXT2VJNmxZYm45bzho?=
 =?utf-8?B?VXpGK3FQK3pvREdjbzVaRkFZd0tUUXBzQTI1VXhQVmtBYnQwdEwrcDNkeWNY?=
 =?utf-8?B?aEE0SCtvanpMU1g2a3VPR01WMnJwZHk1YlFERkw0T0h0NFYyQXNwR0FleWdU?=
 =?utf-8?B?NFhwRzlQVXRDQ0JpZVNjZ0d5dlhOcTV6N2VtZm54UGkrWE5pamhXKzQ2K3d3?=
 =?utf-8?B?MmxhVjdGTzYvditBUG1sQ0pCMVFQTWNMQUlJRkdwWkNaQU1NZmpWL3Y4RnRS?=
 =?utf-8?B?WkJYdFRTQm5IWnVrZnNLWk9MT0lKUHVtWExJSFZOUVhPUGFiWW55SG9UNmFo?=
 =?utf-8?B?S05wZDl5T1NDY1lCY1FjUGdHOUdzQ1V0RXQ2eTJnTHZRM0pJeGFnTGtkVVZU?=
 =?utf-8?B?bFg4UWZLN0w0dWRMQ2xmaGlKRjlxZy9HVEptUFdMWWJmSlhLYUNlS3pSaDQx?=
 =?utf-8?B?amJaNDdxZEN2cE1NSEtncnpkUEkvL0pJbkUwQmRuVmtaRkUwZG5GVzdFY2dN?=
 =?utf-8?B?MHRpTVVFN2dJNWM5RHpRUWdnUGNNZ2ZYYjgvc3oxRDlxKzJESFJIVjRoR1pL?=
 =?utf-8?B?RTVkVExsVUEycG5RL2I1amF3cGR1c3lyOXJzNWg1RStsdlQ5T1dkRXFmMksy?=
 =?utf-8?B?MWtRM2hFbWVJcXRJVGRVSWF2OUxLRFNsM0tlQlA3Q0xSRk9vYU5Tck1sdC9o?=
 =?utf-8?B?QXY0ZUR2V0h3cnFwVXJZVFg3MVdkLzFvK2JFRXJ2VDlaS0t3amp0MXJ6a1cx?=
 =?utf-8?B?dW10dFJpWkp2cFBnVUZ0a3NRUjJYWHRvZzArU0FmNEFuTVVwV3BqSGdvYVVI?=
 =?utf-8?B?dzh4NkErbk02dHJ3MWduUUUvS29lR3R5enNSRFppWUdHV3J3ZVcwS0xEWmRI?=
 =?utf-8?B?ZXdHbkVXMG10d0hYbFpSUzRuTmM0eWtzeXdOZXhkcHpldGpGRHlFTzFwMlNo?=
 =?utf-8?B?N1plbkNOVVc3dDFoNG9BZWQvaG5ZQ0F2aFJ2cWZIMFZNbjZxV2NGLzQvMXRr?=
 =?utf-8?B?WHkyRStacDRBSktURHZsM1dBWElDcDdSS1Y3T0VLUkowbzBMV1hoV2tzenZJ?=
 =?utf-8?B?Ulc2Ni9Mc0ZodWNUQm5QWnNVVjhlYWt3cmtoM1d4Q0hZT3JzVkJQZG5qWlZo?=
 =?utf-8?B?STFobnlHM0VyNUhmMGNjVGhyMEZVdXEvcmdkOHZ0Qm5rM1ZOS3A5bGFKQUpB?=
 =?utf-8?B?TjRNcElKNTg4b0xXM0tmMWpZdFo2YXBEbWpRbXA3VTk3LytwdTVDWTJ3MmFu?=
 =?utf-8?B?b1NDeXlON2Fza0NTSXI2QklFVjBLR2R0eVQvMjZDZFRudGkva0E1ZE9DOUk0?=
 =?utf-8?B?Qy9TUmVxMTB3Z1NaekN5Ukk0anVvbmJYdzBQS0pqWVo5dXpWdU92cVRCS0N1?=
 =?utf-8?B?NFJBL3hpOTQwZDhLM0cyTjI1VzdlTTUwbFhzanBadnBDc3Iya08xNUtsVk4x?=
 =?utf-8?B?dG1KWkJzNHBMaTUyVXE5bWpvM0c1cWNFNXN2cmg2ZmFSc2tkdmVvb2Zvb2hM?=
 =?utf-8?B?Uzl6TlRsUXhMUFNGUlJ5R3dDWW9NR1pBZGRoYnljcE5zaXMrQWxkMlBiYVR5?=
 =?utf-8?B?TklWcGkyY0xVNmtsdFNJVGdWUk15cVErTXJLYXNwNVdnODV6Tk0rN3UxL3Z6?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1D532762D5D3D47B65D85D5E56EDF93@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xULxIUyFtXJ4ARBVZDwIejnXWSh1mZaw43mkYpkyU+kLb2S3TaUYcHkD13O1hAoSgnkT9ON3mpX6JWKePG9SgzypJI5J6F7c1UUQgqNOyQfH3ZZl7btIs0T5sk9THl5Rt1eg9+5ZZY6nlHhOMsJYz3tyBDub04MrqXPmP+O09x6M6OYOXrWamzrCnPxPXEgmAOjssNVtGLupxVG1W8cUu9N/JGp3zvnFM03f5gh0gtjIAJ29l6sCrYp/VznNcVUEvYEnq1fRi5YIAnHyYz8vxQ/GrwHVPN1eeiJP8GycDnsyWnfkTFw+QcpF8DzxjuGf8Rt9isUG0V8FkpPNWpRJwPmkDMYY0PCwUwn60b/5EQQj32XBp7Re+lO8Ky6ONB/TzWdPmso0z/tSt4Vk3/ZYdm5RV+nCYTRwXi6wt0OiMuePOV6x+CO9k9JuW3tWAbb3EchNvl2cNyf76+h3U0u1u+5zS/aC+c9DJBMGHk5DMb2RcoXh3LI5j7ESNEbXDoJYQLTHMstygkSxp05sIC2WZnfLrtKyVKsypLkcI/dIdkF33DiJfreFo8jCnXqYdMYVP4YDgLQIhGTRlfafg8IYEVB6LARSmodT6fhtQb2BZxjhcYrSltNKLocOjdY+7XF+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bd424a-9afc-489d-9e71-08dd1f4a27d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:55:51.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TWsKXcqSKT/i0ymhyfsOu0qn+kchrA3gDJnqy/5r9MYHDbvGSewrDFlZqi2mouuAkLBWqP3k5JdvFpNA4qAMrf0sdbi7PeeN5+/FHOPOmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9457

T24gMTcuMTIuMjQgMTY6MDMsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQogICAgICAgICAgICAgICAg
ICAgICAgICAgIGJ0cmZzX3BhcnRpYWxseV9kZWxldGVfcmFpZF9leHRlbnQodHJhbnMsIA0KcGF0
aCwgJmtleSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGlmZiwgZGlmZik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtleS5vZmZzZXQgLSBsZW5ndGgsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxlbmd0aCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBBU1NFUlQoa2V5Lm9mZnNl
dCAtIGRpZmZfZW5kID09IGxlbmd0aCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBsZW5n
dGggPSAwOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gV2hhdCdz
IHRoZSBsZW5ndGggPSAwIGZvcj8gV2UgYnJlYWsgb3V0IG9mIHRoZSBsb29wIHJpZ2h0IGFmdGVy
IHRoZQ0KPiBhc3NpZ25tZW50IGFuZCBkb24ndCB1c2UgbGVuZ3RoIGFueW1vcmUuDQoNCkkgb3Jp
Z2luYWxseSBwbGFubmVkIG9uIGZhY3RvcmluZyBvdXQgdGhlIGxvb3AgYm9keSBpbnRvIGEgJ2Rl
bGV0ZSBvbmUgDQpleHRlbnQnIGZ1bmN0aW9uIGFuZCB0aHVzIEkndmUgc2V0IGxlbmd0aCB0byAw
IGhlcmUgc28gSSBrbm93IHdlJ3JlIA0KYnJlYWtpbmcgb3V0IG9mIHRoZSBsb29wLg0KDQpCdXQg
dGhlbiBJIHN0YXJlZCB0b28gbG9uZyBhdCB0aGlzIGNvZGUgYW5kIGRlY2lkZWQgdG8gbm90IGRv
IHRoZSANCnJlZmFjdG9yaW5nIGluIHRoaXMgc2VyaWVzLiBGb3Jnb3QgdG8gcmVtb3ZlIHRoZSBs
aW5lIHRob3VnaC4NCg==

