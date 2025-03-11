Return-Path: <linux-btrfs+bounces-12178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19023A5BA25
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E92E1892599
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54022257B;
	Tue, 11 Mar 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W50PTeq5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BCVeK7rR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95164146593
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679333; cv=fail; b=axH2CD7jQhNQWBihKsHtzJgaZgf7M0jiRFeUwXKoGRcAWREjd032sqePlw2CzwMD1TEV4OeZKoCtKEH6wGbuJ88UHOqgJRqrIt6jzjtruK49jcwM08B7GLC3brzVmoEWxAxrKcle0pqJaHy1n8eJJgFPn9gmEKb9GuLorhVTBJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679333; c=relaxed/simple;
	bh=fD/bWbNlWmwkzlTZ2//HVl/6p9/n4qxng2dGcYZ8ZrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0Qvbn+ETl7zY3/3lulxwKulMg7bD0T0dJ3Od7IQYXxlkbP7H1kVVxCATeyK8cFrchBrLiTjRo7XtaDu655KFA2cqud4rFX/jqQcqvHEosuja5g7vnGW+lP0sMdPl2KVngwr/qIXC8Cei1cpT91uV3Mc0p/qxDNjGB+iQy5EgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W50PTeq5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BCVeK7rR; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741679331; x=1773215331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fD/bWbNlWmwkzlTZ2//HVl/6p9/n4qxng2dGcYZ8ZrQ=;
  b=W50PTeq5Q7mv+fEaI4zR0xVmhnJgaUIuXTA8C1MZsX7A77j7U5HTGdXf
   vfUwnlL75DOFnINcQIcY/w4azTFH+MtgJAKyDXQ0GXMWrj/ly862YPlSz
   o8pgpbnKCp+5YzIatFxd8O756C3JoSaghvbQrS20qBSIRPyGfD3R2kDV+
   XjsZipbnfVo07PZ9JAJ1bB2CRAfjD9OGYSCDtdOyYz/sR87PJVsNk55+3
   mSmtSBM4iDfyh6mwMinKJLEkpnQQKegDQMbmpppc/Ebhuxx57uQoLilgi
   HFaGqWiYHNAmkNvSGYXIj/LG4SEOub3Mqd1J6QtLZgA9riispbkZkvazv
   w==;
X-CSE-ConnectionGUID: P3q2J6YrRbevgTRSaa+iwg==
X-CSE-MsgGUID: EL6Gm0yHTyG5AXWQUlNeXg==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="46717096"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 15:48:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR0S9N7HWpcE0A/IeguFnNTepaL2N2+x5Rk4YKlviB1SBSA3z0uQJEPcT/Z2fpn6T5+2SCrszv9wNf5bREOMBTKVXFP+TPZA9RiDP9VqgeWS0IUJz2bqT/C1HywDua4KuzR9pnKGfWqlHt/tzO1/1aoKwCKtJR93k/c4ornn685cIGusnazrxRQ4wZjdl+eYwyP1J7nezLNCZ1rsSMUrsZRtjnA3zvf0tR8LkyoDf5yA70idX0SERs5YTwwT3NJBK/e3TFwsONltOpHHTBTxyBBKzsUTxvbd1/Fjhfk9cX6ifO6AQ/FamY6BCSJLv+XvKRqSlK6zJn5uAbON2RgSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD/bWbNlWmwkzlTZ2//HVl/6p9/n4qxng2dGcYZ8ZrQ=;
 b=OerZKSb9b1lKfb9B9fKuULE3QcDaQEmgFst9/lKlm03KGvKmRHVrcCyCs8ykFamincA0nVbPcm/aq4Iu34kP7qP8AWBPrwOPvSLFZR66BMKqNNpCJUJciPZ5gMiSM/0MRm+bv4BdyclEKEB/GAXsiC56KovOtfCV4W9+O77BbFae6CwwkDcOM/cOItHA/a3QJW9cPu5LQQq3fA+hmEvgKRy3Lco1FfIHEm5EaRkK8gmhgtKjR+EzLwJGrSzsT8kbJjnprsPhQ8xaCva4dWjsyRfe/yZjpZfJr6dgL2Ig8qo1PAhIVRDPWXgmjaPijN03d8YfT8Np/CiAbq9nJQdH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD/bWbNlWmwkzlTZ2//HVl/6p9/n4qxng2dGcYZ8ZrQ=;
 b=BCVeK7rRlD09XEXjGU+I41wmM/wOJhdr2TNH17udNclqVGYrLP0F92ej9tlEPKFZwxzI4VgXWp7/lwe51sltunDuz1qIMihkVtEtpQfiCLRtgxbGcMktTL3udemIUGvw43syPtBRCvfMp2GK6HyFRj7dot5CiebJaP+wlivYrfk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6499.namprd04.prod.outlook.com (2603:10b6:208:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:48:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:48:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index: AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAAGiOAA==
Date: Tue, 11 Mar 2025 07:48:42 +0000
Message-ID: <5b3439e9-eb22-4c9f-8980-9cb9e2fd2374@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
In-Reply-To:
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6499:EE_
x-ms-office365-filtering-correlation-id: 1b548e26-93ea-440b-f2da-08dd6071250b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnlMcHdWOEh3Zkh0bDZqVERNc1p4WEJveWJoTDNmUW1kUEdXNFRiUTdjRTAy?=
 =?utf-8?B?ajRoRTBtdGt1NWtNUytQSzBVOTlKZ3lrMXArWW55TjViaGhkRWtlRzUxQnBE?=
 =?utf-8?B?K1NnRFNsR1JibFZ1cWhJaEZuL0xFdjdVNG1OM2gxMnA0TWcrRWJtSE9yYUNi?=
 =?utf-8?B?VWNUQkc3Wk41VGtYS011blVZeVVteERhWnJwQmtUeWoyTDVleEprSXdEQzNv?=
 =?utf-8?B?WE5qWnAxUGJ3S1VIT1d0S3FyUWp6d0o0TFkxRHJDcW9rL3hveEVnd0ZPbFJS?=
 =?utf-8?B?WEdibWhtdS83RStSOXR1UTRDeVEwZUl2bnl2ajNQTHFyN0daL3BqZlZEeWxu?=
 =?utf-8?B?UGNVam5udVhOVGYycG1TWi85T2NCc2RUNjArc0sxMlEzZVNJbERJSVMzKzVW?=
 =?utf-8?B?dW9URXkvbzBPUzlBcW9ac0tDWS8wOG1RcDNHM1JVUHlMTnNOU0VrUnRJdVF5?=
 =?utf-8?B?bGNGZVloVGNPK3JZZVJnbDVjQ0JuZTBMMUJKUEthaU1NMFpwYXlxcWgzd0la?=
 =?utf-8?B?bDV0TkR4ZFB6dXB3TUtsL1EzeE01bnVVdW5TRVJnQjFFK1dwK09SS0VxOVJN?=
 =?utf-8?B?R09oT3IxWjVhNUgxRmNtM0E4TkdzWEpYODVaWWx6L2VCV1ZoT1JwRE1MMUlq?=
 =?utf-8?B?QUpBK3JzVU1wOVp1cDkwR2NZL1hacERaakFVZ0VpTHBrWEl3ZEZ2TytDRVVD?=
 =?utf-8?B?YTZDOUphUW9uMUx4Qk1OTFhRbHlEOGtESHBwSHVZOGdrZ1ZncWVDM3hBSUQw?=
 =?utf-8?B?ZGZ2NXhWQ1Bydjhjc3lYY2pkRnJKV045SzZsSjFtN0Z4ekh2SnFIVG96YmNO?=
 =?utf-8?B?OUZPbnRKTlRRblcvMzQ5V0cyamRGcGtUanlTd3FzcDYwcWlkZkZlZVpIR1B3?=
 =?utf-8?B?WVd4MjJBdzhvR0dtSytFU3ZJUVJYcFcyYm1aTTlQd253TE9VNlNYUjIxdi9Q?=
 =?utf-8?B?ejJlRk4vUVZjbjcvTDVxSjVoVUZxRS92T3laK2tFK2FEdjU3QVVwRnVqbU94?=
 =?utf-8?B?aVpHNkF3bkNZUm12RHV2d29IdDFTaUFKQ0txUFhJdEZoNWZ1a1BIWnptMm9t?=
 =?utf-8?B?TWR6NE1PNmlRTW9MeWZaaE9jd1REUTVRaklyVnhlcmw2ekFmZkJtSnUydVd1?=
 =?utf-8?B?dG5wQ1RYWUw4Sjl6c3ZTdVdEMDN2UEFOQ1dUVDNJcGhySDMvZER4OFozM3Iw?=
 =?utf-8?B?NEFyenVYVWdzUkdRRXArWDhKTm1MMng5NDVPQTFKUkdkZG1BR0p6RjN2bXBz?=
 =?utf-8?B?S090b0xhUExlL1lxaFI3UHM3MzgrYktzeXZuMDk2b2JuMFZGOXd5ZEtMNVZy?=
 =?utf-8?B?WWdUV1JFRDZuWmJnU1NqR202akFaV3NtNFpuZmZQV050dW9wNjVaTUk2L2tY?=
 =?utf-8?B?UWZiRGtNLzhiRDRtLzFzQnBZWE9UNWJVN013OXRUMlk4YU5VZmZHYlp3a3VE?=
 =?utf-8?B?aStGRTZ2N1c2V3Y4ek1HZmRXT0Vha1gzUTZYeDc1NEh3NXlRalJ6ZzYyWXF5?=
 =?utf-8?B?ck8zajc0QmNacmNEMTg1VFZqQWZaVHBOOWV3Z0U2aTRBMWppSTFaWll5dG9J?=
 =?utf-8?B?MnhZWE5PK053enJsY2ZkaDZ0YjNRbnlkT045VzNpZCtlamF4Q1hpcDV0a2hl?=
 =?utf-8?B?cFBpcW4rTStGZ2MvZysyL2VYa3ltWWNXOEFsOFVvNFluUHlwNGcwRjNJSjlv?=
 =?utf-8?B?c3BSdTZVc2dIcXVjUWczc0hMNDJpeTdDaVZzTU0zTUFiLzJVa3NJQit4aW1H?=
 =?utf-8?B?TFhCL1pMd3lPRXU2eE5NUnRtRlFvbEo4ZnZRb2JCaXhJcm9SKzFSVnRjTlNy?=
 =?utf-8?B?eVR0WmZ4aTlQbUNaNTEzdDlDNmV3akpGR3J1VkpWNDFTRTIxWVMxZklJUFBY?=
 =?utf-8?B?NWphdDc0ZFJkZkZzUmd3VjB0Y0RJMGlWdmtPRjN5cHFNQ2ZRR2pQZUVoV2VC?=
 =?utf-8?Q?BIlbFRWtCC5bgLrUsDm8EHzSBPrOMoh9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0I3YXdvc0l3YkhtaUhUOXcwMEFRdlRFZnYvejdiVVZDeWczMGFVS25BOEJV?=
 =?utf-8?B?ZHdhbGNLRzZPVzJScFhoMmMxQjFJeVJvZkMvRFczMmRUZGVBM1NKYlN3azJz?=
 =?utf-8?B?UG9VaXhnYUlhb1A0dTlrb2FCem5KKzhmZ2pVSUU4VXdDN2ZoQWdmcVJhTU81?=
 =?utf-8?B?VWQxS2RUQlJ3MmtLOG05SUVMdFQ5aGxWNGNmekxqMzNrR2ZOempBRFdWc1BE?=
 =?utf-8?B?Tkxxc0xFVU9xV2ZIUkpxdVFGZ0dkRlJ6eTNDM0k4d3h2ZXJpUWhIbGI3NzJn?=
 =?utf-8?B?K2ZhRjBJazV2aFd1S0Vzb1pBZDBOM3BCbXVZbkhzRVJKQW82N2ZvYm0zQXVR?=
 =?utf-8?B?MFg4MzNka1dwbU1lR1hpRUhWaUh5SnVGVHZuVVBCVGdpdkVSZDFaSXJ5Q0ZG?=
 =?utf-8?B?Z3VnTDdZN3p3WFluVUJTZndXa2VybCs0SGxVQXlZVDdyUjRTaVZhczZuajdZ?=
 =?utf-8?B?WXBCejVBRUY0VjY5UVdCd200bklETlRDb1VKRnJnSURuV0tPN3RmY3FkZitN?=
 =?utf-8?B?Y1RWUVg2c1VtUGhHMVJjcEE1OUFzcG5ZK0MrTVBWR0cray9EK3VPcXBwM2wy?=
 =?utf-8?B?QTNIWWVNVUo2NFU2VEJFaEhudDNnTlhZbG1tU3JFb0lqd3pTb1FwNnJmYnN5?=
 =?utf-8?B?Ty9XblpVQ2piSHJCenNreUJ3cU5SUFMzdHFZN25Idkt5VmJFSXJkUlhhSW95?=
 =?utf-8?B?eWFGM1V3dTBTeC82NmlSMHZSYmk0NEJLYmxFY21qU0o4dkpOeGxLOGtaeUQ0?=
 =?utf-8?B?MVlXRE5sRTVETzR6TUhINmlhblZoc3EzREJHZXFoZTNqcmRONjFKREJHc09l?=
 =?utf-8?B?d2RnQTJ4Z3ZYeGNPNVdjdmZ4ejRFS2M0MkxCUW5DWk4yR0hWdklKTnFpS0Zt?=
 =?utf-8?B?WUp6NHNCR01JMUY2RkxtcWZzdEgzWThHYmVnbGdDTTJWa1VGa3c1WHBlZkpO?=
 =?utf-8?B?YllBVENWNFB3RW5RQ3FydktiVVFKWGIrdzlwb2NPKzk2dWFON2FCN3BxMVNI?=
 =?utf-8?B?cmZuc09HTFI0Q3puQUdlYWswZ0NtK3laOThvWWh4a2d0YWNBT2dZNldPRG02?=
 =?utf-8?B?UW1pNjhuWG11Ymh0RFcxSGhkRVl2dnNEQ3p2OE85MnlSUzhsK0VmeDlNeTdn?=
 =?utf-8?B?S1JtTVRQTHgySVdKR0hONVQybG5VNmNwQ1o2a0VkV3FxcXBVWlYvZDdNL0hy?=
 =?utf-8?B?UTZOT3ZNeVltYVRyemhUa0xtR3liRksyUWp6dUVRN0s3TnlWUDBsS0pjSjhn?=
 =?utf-8?B?OGtJUjBwUUYwNEM1QndVK1lvdmJJUGwzMzdGRHdVR1hvQzkvbTA1MkMvSHB2?=
 =?utf-8?B?SjRjd3YrRDluTE1HTXBqL01uZnY0eThJT21KS2FLNm5SUWNPY1lIbXBYT0pN?=
 =?utf-8?B?RGttSVliTmlnNHZVNFNWRS92Nm9FcE9UdkJwUGhnTUpxRW9Ndmw5UTJTMzBn?=
 =?utf-8?B?NE4vTUNpcEpac2xLdFBTb3lsVGV4RTJzRlFFQ1Y4TUljTlhGejBYNE9sZ0dN?=
 =?utf-8?B?TFZTL0V5eG10VW94MGx2YWRlbWpDTmd2bGVsRnFmd2hhaFlWRmt0T0VLUUho?=
 =?utf-8?B?ZS9kckkyeXdJNDFONDRHN2g5ZUl0ZE93d1V4aFFwQUdyNmV5aFE2R2RTaVY3?=
 =?utf-8?B?eTlIcnlxd2ZmNHpONWxTLzBTbzBmMmU2eFhQMVRsUXZUL3hpeVpnR3VzNXVr?=
 =?utf-8?B?bGJRaHlLK2EyT2FkV2x6dVdPb1ZINy90cjlvSGZEMWVRMlo1OTlxa2FNZ01x?=
 =?utf-8?B?N1RSNzUwKzlJOStzSHB6QnZTOU1tYThkNmM3czBvSk50U05vL2I0VjhGVHBk?=
 =?utf-8?B?WndWamd5ZFJSQm5oUHpXYno2Y05KQXhTd2ZrYnl5TGZld2ozY2VTdDcrZ1pQ?=
 =?utf-8?B?aXkwRzFDcURJZk1YL0pvK1FBSlRzcE56MTZqaWVRRXhodmtFN3pyN2lsbmth?=
 =?utf-8?B?dDFYL0Z1dE40aklFQlg0Q3lMcmlIMjBSZFFyVm5mdVp5aGpMMVZDV1o3VWFq?=
 =?utf-8?B?eWk3clA4aXI0RUhUTkt5a09DNmplQXZIdHV0SHdyTUFTT3FBRlVodDJWUGVi?=
 =?utf-8?B?SHh4ZHcyR2ZEMXJhdmorcDloMDFLUDBLM1lPRjB5SXJlWDhiRmRkRVdtNHBV?=
 =?utf-8?B?SzR2dTdqRlZ3aDRiTDBKQ3g2dnBXdHZNVzY1dEpKSXJHaDl4VnZ1V0dUZTZw?=
 =?utf-8?B?Y2lXSUROUkZ0aGZRWkc1ZTN0dlVyaGxhRVJXWnRna3V1YXVjSkhHV0VjTUdZ?=
 =?utf-8?B?a3lDcm1XNE1sSXY1WktCZnV5VHB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AFC6FF178D90E45865F417D41239F76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pZuZ0G2OVAAauC8Ox9/qGfJY3yKIdaaf+qLjQbvDzVA8ABCXnnQ37W/3rg7Islqm88PuVHjBKv8DLUbc/QTdKCdFWRfJ4Z44fS2ZrejPpqyvwKRew+m46zISj1HChlrXtscvvEG8ayy1OT8KZ+h++FmgwjTLJploZ6PWyE1xowypvb8HUty8tfxsUerUxh8CdTceDi5UpGfR5epNrWodZOaZffDPWe0qujO1mdJDqKJv64/Mk4QRkNC5Y9gRm73KPocpv6KtM7rjHL293vr1ymYIc7kUlm9S3QnP7QbDDeIVO4rqMyhliLm+Zq/kBszo4fZZc8lVOTX8ul/M/laKlyRJI1r95OskBsfnQnjkEp9xQcdZOw4S/URK8n1qzju+uS2qddm3CghXdvR00Svl6Mo801RFZCO9c9o94O0XTFUoLGtnZYL8t4rIIqEfJxQPJmxvkDkDqc2zcmFLYDU3uHsnM1BWaHbaJQPHCxysat3M1jZot9pX9VlMyWQUWq4HkwdMCEdIIZP5Ztl+0QdEGYrj7uO3mmg8OwL8RqQyS1wt3xUcwYb+lwaJsyJDhYlGhh8Ik27REDhsGqr7N40gZnGKN1sYC2BBmmjTmsJuQbmKJmx3+RNGM9bvQuNGAnkD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b548e26-93ea-440b-f2da-08dd6071250b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:48:42.5542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwuT4v2IXyZ0vTtBt3OcOefZ2GTAwQLWPfalbB9UReYg5TCZodscIiPRaY6Ijb2/iFdrUi36QBR4TI0d+HtyyUGmGVuCY1joqUqWD+s6WEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6499

T24gMTEuMDMuMjUgMDI6MzQsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4gSm9oYW5uZXMgVGh1
bXNoaXJuIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4g5LqOMjAyNeW5tDPmnIgxMOaXpeWR
qOS4gCAyMzo0N+WGmemBk++8mg0KPj4gT0sgSSBuZWVkIHNvbWUgaGVscCByZXByb2R1Y2luZyB0
aGlzIGJ1ZyByZXBvcnQuIE15IGN1cnJlbnQgcmVwcm9kdWNlciBpczoNCj4gDQo+IFRoZSBkaXNr
IHdhcyBzZXR1cCB0byByZWNlaXZlIGluY3JlbWVudGFsIHNuYXBzaG90cyBmcm9tIGRpZmZlcmVu
dA0KPiBzb3VyY2VzLCBhbmQgdGhlIHNlY29uZCBkaXNrIHdhcyBhZGRlZCByZWNlbnRseS4gVGhl
IGZpcnN0IGRpc2sgaGFzDQo+IGVuY291bnRlcmVkIHNlcnZlcmFsIHBvd2VyIGxvc3MgaW5jaWRl
bnRzIGJlZm9yZSwgc28gdGhlIHpvbmUgcG9pbnRlcg0KPiBpc3N1ZSBtaWdodCBiZSB0aGUgY29u
c2VxdWVuY2VzIGZvciB0aGF0Pw0KDQpidHJmcyBkZXZpY2UgYWRkIGRvZXMgYSBmdWxsIHpvbmUg
cmVzZXQgb2YgdGhlIHNlY29uZCBkaXNrIGFuZCBiYWxhbmNlIA0Kd2lsbCByZWFkIGRhdGEgZnJv
bSBkaXNrIDEgKGluIHRoZSBTSU5HTEUgcHJvZmlsZSkgYW5kIHdyaXRlIGFzIFJBSUQxIHRvIA0K
Ym90aCBkcml2ZXMuDQoNCj4gQW5vdGhlciBzcGVjaWFsIG9ic2VydmF0aW9uIEkgd2FudCB0byBt
ZW50aW9uIGlzIGZvbGxvd2luZzoNCj4gJCBzdWRvIGJ0cmZzIGZpIHVzIC9tZWRpYS9jb2xkDQo+
IE92ZXJhbGw6DQo+ICAgICAgRGV2aWNlIHNpemU6ICAgICAgICAgICAgICAgICAgMzYuMzhUaUIN
Cj4gICAgICBEZXZpY2UgYWxsb2NhdGVkOiAgICAgICAgICAgICAxMS4yMFRpQg0KPiAgICAgIERl
dmljZSB1bmFsbG9jYXRlZDogICAgICAgICAgIDI1LjE4VGlCDQo+ICAgICAgRGV2aWNlIG1pc3Np
bmc6ICAgICAgICAgICAgICAgICAgMC4wMEINCj4gICAgICBEZXZpY2Ugc2xhY2s6ICAgICAgICAg
ICAgICAgICAgICAwLjAwQg0KPiAgICAgIERldmljZSB6b25lIHVudXNhYmxlOiAgICAgICAgNDI5
LjY3R2lCDQo+ICAgICAgRGV2aWNlIHpvbmUgc2l6ZTogICAgICAgICAgICAyNTYuMDBNaUINCj4g
ICAgICBVc2VkOiAgICAgICAgICAgICAgICAgICAgICAgICAxMC42M1RpQg0KPiAgICAgIEZyZWUg
KGVzdGltYXRlZCk6ICAgICAgICAgICAgIDI1LjQ1VGlCICAgICAgKG1pbjogMTIuODZUaUIpDQo+
ICAgICAgRnJlZSAoc3RhdGZzLCBkZik6ICAgICAgICAgICAgMjUuNDVUaUINCj4gICAgICBEYXRh
IHJhdGlvOiAgICAgICAgICAgICAgICAgICAgICAgMS4wMA0KPiAgICAgIE1ldGFkYXRhIHJhdGlv
OiAgICAgICAgICAgICAgICAgICAyLjAwDQo+ICAgICAgR2xvYmFsIHJlc2VydmU6ICAgICAgICAg
ICAgICA1MTIuMDBNaUIgICAgICAodXNlZDogMzIuMDBLaUIpDQo+ICAgICAgTXVsdGlwbGUgcHJv
ZmlsZXM6ICAgICAgICAgICAgICAgICAgbm8NCj4gDQo+IERhdGEsc2luZ2xlOiBTaXplOjEwLjg0
VGlCLCBVc2VkOjEwLjU4VGlCICg5Ny41NCUpDQo+ICAgICAvZGV2L3NkYyAgICAgICAgOS40MlRp
Qg0KPiAgICAgL2Rldi9zZGcgICAgICAgIDEuNDJUaUINCj4gDQo+IE1ldGFkYXRhLERVUDogU2l6
ZToxODMuMjVHaUIsIFVzZWQ6MjUuNTRHaUIgKDEzLjkzJSkNCj4gICAgIC9kZXYvc2RjICAgICAg
ICA2LjAwR2lCDQo+ICAgICAvZGV2L3NkZyAgICAgIDM2MC41MEdpQg0KPiANCj4gU3lzdGVtLERV
UDogU2l6ZToyNTYuMDBNaUIsIFVzZWQ6NC45NU1pQiAoMS45MyUpDQo+ICAgICAvZGV2L3NkZyAg
ICAgIDUxMi4wME1pQg0KPiANCj4gVW5hbGxvY2F0ZWQ6DQo+ICAgICAvZGV2L3NkYyAgICAgICAg
OC43NlRpQg0KPiAgICAgL2Rldi9zZGcgICAgICAgMTYuNDFUaUINCj4gDQo+IEkgYW0gaGF2aW5n
IHZlcnkgbG93IG1ldGFkYXRhIGFsbG9jYXRvciBlZmZpZW5jeSwgYW5kDQo+ICQgY2F0IC9zeXMv
ZnMvYnRyZnMvMjNiNjhiMzgtYTYyNS00ZDkwLWE1NmItNWQwN2Q5M2M4ZmZiL2FsbG9jYXRpb24v
bWV0YWRhdGEvYnl0ZXNfem9uZV91bnVzYWJsZQ0KPiAxNTEzNTY5ODEyNDgNCj4gDQo+IDE1MTM1
Njk4MTI0OC8xMDI0XjMgXGFwcHJveCAxNDAgR0IgPj4gMjUuNTRHaUIsIEkgYW0gZXhwZWN0aW5n
IHRoYXQNCj4gdGhlIHJlY2xhaW0gcHJvY2VzcyBzaG91bGQgaGF2ZSBhbHJlYWR5IGtpY2tlZCBp
biB0byBjb21wYWN0IHRoZQ0KPiBtZXRhZGF0YSBidXQgaXQgaGFzIG5vdCAoZHVlIHRvIGZyYWdt
ZW50YXRpb24gb2YgbWV0YWRhdGE/KS4NCg0KWW91IGNhbiBmaW5lIHR1bmUgcmVjbGFpbSB2aWEg
c3lzZnM6DQovc3lzL2ZzL2J0cmZzLyRGU0lEL2FsbG9jYXRpb24vbWV0YWRhdGEvYmdfcmVjbGFp
bV90aHJlc2hvbGQNCg0KPiBBbmQgdGhlIG51bWJlcnMgSSBnb3QgaXMgYWZ0ZXIgZGVsZXRpbmcg
c29tZSB1bm5lZWRlZCBzbmFwc2hvdHMgYW5kDQo+IGFmdGVyIHNldmVyYWwgYmFsYW5jZXMgd2l0
aCBtdXNhZ2U9MTAsIGJlZm9yZSAod2hlbiBJIGVuY291bnRlcmVkIHRoZQ0KPiBudWxsIGRlcmVm
IGlzc3VlKSB0aGUgbnVtYmVyIG9mIGJ5dGVzX3pvbmVfdW51c2FibGUgd291bGQgYmUgbW9yZQ0K
PiBleHRyZW1lLg0KPiANCj4+DQo+PiBBcyBmYXIgYXMgSSBzZWUgdGhpcyBpcyBhIHN0b2NrIEZl
ZG9yYSA0MSBrZXJuZWwsIGlzIGl0Pw0KPiANCj4gWWVzIGl0IGlzLg0KDQpUaGUgc3RvY2sgRmVk
b3JhIGtlcm5lbCBzaG91bGQgbm90IGFsbG93IFJBSUQxIG9uIHpvbmVkIGF0IGFsbC4gV2hpbGUg
DQptZXRhZGF0YSBzaG91bGQgYmUgbm8gcHJvYmxlbSAob25seSBkYXRhIG5lZWRzIHRoZSBSQUlE
IHN0cmlwZS10cmVlKSBpdCANCnNob3VsZCBzdGlsbCBiZSB1bmF2YWlsYWJsZSB3aXRob3V0IENP
TkZJR19CVFJGU19FWFBFUklNRU5UQUwuDQoNClN0aWxsIGl0IGRvZXMgbm90IGV4cGxhaW4gd2h5
IEkgY2FuJ3QgcmVwcm9kdWNlIHRoZSBpc3N1ZSBoZXJlLiBBbGJlaXQgSSANCm9ubHkgdHJpZWQg
d2l0aCBjdXJyZW50IExpbnVzIG1hc3RlciBhbmQgYnRyZnMtZm9yLW5leHQsIG5vdCA2LjEzLjUu
DQoNCg==

