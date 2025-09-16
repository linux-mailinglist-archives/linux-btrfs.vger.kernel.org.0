Return-Path: <linux-btrfs+bounces-16847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E0B58E96
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E7F7AE601
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009C2DE71E;
	Tue, 16 Sep 2025 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k2qw1Mpr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w8cFQc7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C945227
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005199; cv=fail; b=u9Y17eryvjHUxJiIk74fj39vYB9IxyvoV10HEjdeAC4MvYgvnFWUHfak+kYJXJyqUD0hTzDBbqpRLZch0Iz5n2wlsqkcA60O5m6NF13kFTcEiAhW1j9GJLPy9DYlqGOdlckqHAkH8ECovWZ3i2tONqa5Jvn7EdX3/4oEmCU9Ys4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005199; c=relaxed/simple;
	bh=y6/4cZ60onoM+rprweCUHWLxSZqO3mMv6GkvPMSOYyI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eX7vAx/b/iG4kPBAIX3Y6wsowMmnL0dgAK2bcUTCTddP59fb9UJYkiXSvOO+Csy3+5LH/Lp0w1sODt9j3dn4oMgf8iLOW3MXFWIdjI/BXpnqSdQLwJtup85WI6tIf+xjkK2kgX5rlq8TdRylCHHntqyqswT447nxft6QWMi+gXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k2qw1Mpr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w8cFQc7o; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758005198; x=1789541198;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=y6/4cZ60onoM+rprweCUHWLxSZqO3mMv6GkvPMSOYyI=;
  b=k2qw1MprepyCg0JuuNzIpgOq0qgWf8Q6ptnz8O/mkx6TbW/LSZcUToHT
   cWMI8k/9Bj7PIH4oPpxn91KkXRkxrnI8Jfw5stdepXNoBHqfyPRBVB7N+
   v62ItLNLg01jplqoeNULZ/9G2C8tAZl0LZfYI6S8I7AjdvIt/MPkhuXEW
   sBKJQ94gc1owpl1y8FLyUq4QOu7cD3dG5DM+aeFIXcNhfIURR/onsbQyZ
   2ucf27BpCHJrI2+FPCv5gUgeoQ/MVd5HIbjHbdDtxhiV+V53QtuLPHCgk
   E/r52D7p33YA1tg2SAvolR1PFpPF8kBr3/nSz2T7tAins5ex2UuyWxqQo
   w==;
X-CSE-ConnectionGUID: 9krBBQ6ESGesMLqL9mV08w==
X-CSE-MsgGUID: ddtGo7izTbKwOiHhX7yhjw==
X-IronPort-AV: E=Sophos;i="6.18,268,1751212800"; 
   d="scan'208";a="118800819"
Received: from mail-southcentralusazon11013057.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.57])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 14:46:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HymsNvVlYF/2asAfHCy1fSIBYActNcasjKdOkjRs14cPyGnbvPMJHU47hepo6qRXLa/3Tflg+zxTVIn6nlLJ9PPUvhBcGpHoTAmEmQDUIIOWV1GvIW3xrN17iJoa51c9V/PQOkpbtee4pR8L2yJ4SQdk/MIuwThDIquzihMb0vg5bT9bSkuojNDJnM6fN5eis6ILghhwrIL5/gcezipdc44MOs7mZxD0qkGdY35ug0K2lzJ3LK43CjhtAFIIafWGEzP9FozKwSUdBbHOQrGdPV+UfLPvzMPdPkvnfpd3P8dyCgc9qWpMvQeazrE5nCPF1E6kleJYDv2f6wxjcqp4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6/4cZ60onoM+rprweCUHWLxSZqO3mMv6GkvPMSOYyI=;
 b=BaUfrGgQD8gyAszOBq1TpKGIWOmzh1oY7irt0pmfW09HfhCuVznDrS9XIXtfVfET7A6NO1rEtjsk+WldrD151jkO3BKVZddAroSRKxl7nZb4BFrGgM5jndvFB7gZ8y63ieeyPuF0TtmUl0d3ZhcdKuwoW5ubsg8LTw2MVICCHfGuP1OvA3+zvrk3CSR6ti/UorB6yWG6vb5YBX5969fgCB1uMqBZlWyKAgso0QISKDPcy1RzMszmpBLr4FcmElBx8zXJ035iA4bg3akJy2Jxi1Yc0crd4uyOQeRb8NNdYhoXSWVN3EhRXRO+Xn7mcPzBsBPNxwI0att0eZU6x0EyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6/4cZ60onoM+rprweCUHWLxSZqO3mMv6GkvPMSOYyI=;
 b=w8cFQc7oiiDvvqZMFKqo0mOtBTL3QBH77wImS0mVqknTEsY6vU8fiPzIJXEPCo1Kw1U5OaXnqKZbCMdOzaQdTvzng8cQs+kLe9R22/4yQKN2F2HDkZ8TAqVPaf4hh4/usTxSg3ajkAaFxccyZVvJ35YDNj9qqy8Jq6dmjpZ1w9Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8171.namprd04.prod.outlook.com (2603:10b6:208:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Tue, 16 Sep
 2025 06:46:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 06:46:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/11] btrfs: print-tree enhancements
Thread-Topic: [PATCH 00/11] btrfs: print-tree enhancements
Thread-Index: AQHcJl8G3K6VaHW8Xk6RU612W8A6YLSVXouA
Date: Tue, 16 Sep 2025 06:46:35 +0000
Message-ID: <870d8fd4-4215-45b0-9920-eade552a30e6@wdc.com>
References: <cover.1757952682.git.fdmanana@suse.com>
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8171:EE_
x-ms-office365-filtering-correlation-id: 30404be3-21f0-43b6-af68-08ddf4ecc78e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dG03bVdRT1R6SVhJM1VuMmt0V01nd296R0ErTVJpT250YmVPa0pkVWxISjlJ?=
 =?utf-8?B?V0lkYjFqdk52cmw4Wnd3cWZXQWxUWGNpMkxZSldPbUVOMWFPUmpLbXhYdXY2?=
 =?utf-8?B?QTQ4UWFMQ0RqUk81NDJmc3pTWUhjOWhEbkxteUdHMTNJVnFIYUdQZ2EyaHAz?=
 =?utf-8?B?QnpySlZBMGNsUENtS05tbGZ6SExUYk01Q2lmRG90R3NKYTd3SjFqdC9IYkcy?=
 =?utf-8?B?Q3kxMmQ5MlgvVVlQcEk3OS9ZZWZiVTZoUDY0TnRDY2RqYzBLamVrR2M1LzhN?=
 =?utf-8?B?TlQ2OEtVSjRlaXFBbHorSnhvalVlcldlbjhqeUF0WTNDdEtKbzFsTmRvVC92?=
 =?utf-8?B?TEZWdk9EMElFSlBsdG5vNE1nZU1wRnZCZzExOUxUdjhNWXgvZ3FnNUIzQko5?=
 =?utf-8?B?RXdmaHl6WXZsd0F5UW1wak0vT2h0YnJKMno0Ym5rM0RTb09sUU9YcUxlMWQy?=
 =?utf-8?B?UWVpVVgxM2I5NGJZVEhoMm9ydmVKaGYrR2g0azRSS2krRUJ0MXJXM2pNakhx?=
 =?utf-8?B?SnRKQVR5b1cxR1ovZE9sNG9wUlE1V3FSdVRUbVJJa1U0UmIyOW9vcEJuQ2NG?=
 =?utf-8?B?QVBEdFcweVBmSW85K0Jkd2lxY0RuMHV3NVI2anVOT1UvKzFnUEVLTkV0azhC?=
 =?utf-8?B?Y1pHQkY5VEVPYnZVenhqV0NFaEx5TDVDUE9uakROSTBhZHg4QVRwdXNRRFZl?=
 =?utf-8?B?S3h3ZTZTdHlBbk9nM0tWWS9kQWNHbWVqUEtQL3BrL2NEUndsa3lTVXdxZCtw?=
 =?utf-8?B?Ums0a1NkS2ZzeEQ1RnREUktIMzZaY1VBc2pJZm1MK21WUk1lL1dLYnNmdmpB?=
 =?utf-8?B?OVU4QU1nb1VEZk12b3AyVmxTc1pkUWNGYVNyQmp1TndCRTZndVhEd0hOaGJ1?=
 =?utf-8?B?U1QzU2xRaEVwRkxGQm5vNDdHMEtodEUwcVliTHRrVERFWE8wZ09TakJIYkNP?=
 =?utf-8?B?MERiRGZ5U1JrT0RDUzJsNVFIdlB1dGFqaUZhM1BLNEUwbTlSQWNXbVB6NStH?=
 =?utf-8?B?aWlVY1Fnb2pXdGRCLzFvV0RRaHpndW1iUzhhdTF5WkN6Ymt1TE1TMHh3amRa?=
 =?utf-8?B?N0VpcXV3QlZNQ2pibFdZcmhvRmlhZFZ0Ty94aUdwZ1N4ZmZiTHNGS2ozSmpO?=
 =?utf-8?B?ZDBhdFQzblhkUkQvdE9ES2oyWHJnWXhlWCtxeU9JbDREeU1MaW1GVGh3UTVY?=
 =?utf-8?B?WTRtdmpRUmU5VStJek5VZ3FibUxuaVZXSmJ3K3h3cTZVTzd1cWNYSEVyL2k0?=
 =?utf-8?B?OVl4MDkvTEI1M0U0NTdrazdEWTNaMm9FZWU1Y0lIdzlGemZWVkdkU0lSY2xE?=
 =?utf-8?B?dnhSb01MOFlnc2hKNGlSWTB0djYveUVCWmRLOUV6ZVZvUjR3Tm9Tc0ZSV21P?=
 =?utf-8?B?TnZISC9Hb2NqM2pKOWE3RWc0cnNHc0JxVXdFVC9vMlR3OEl6TWJENHp3YjhE?=
 =?utf-8?B?MXNJalBGUjNZYzJuTytJem5JbXdIdHl2U0k3UXI5RjFXcnhEZlR1dHNlQ0J3?=
 =?utf-8?B?N2FCMXJtTld3RFQ5SGhtY2NPcGVEOGpWQnh1OE5RYm5jb0E3czJ4bm11cXB6?=
 =?utf-8?B?bHNpbHhxU3lyN3dMd2NpQUxQRWd3cWxRQm1xTmNHcFNMV3p6dExjUUdpQ2JK?=
 =?utf-8?B?RllEWUQyZFJ0UmhEU1YramJFOUVvVGd6c3ZLU3NPUmFja1EvN0xZN1g5R1M3?=
 =?utf-8?B?NCtzL1hEVXhJZWhVb09CNjVmTWVFVDh6YTJITGRiWk9TTnA5VjdUNW01WU1N?=
 =?utf-8?B?a1ZQQ2xnbzFNMXREWm92RWM1QnNmZXNGdzF6ME1UVUJXSVZrQnNsV2hJL1gz?=
 =?utf-8?B?bDVZNXF5YVRHKzFJUlIwSEI1SmtVYWdtZDhtRm5qa0lBb2tNUEV1OUZQQUZm?=
 =?utf-8?B?RG85b0diRGhDU1g4U2xOdCtQRjZUcGFvNURPWFFIelpBVlVsS3FTbEN3andJ?=
 =?utf-8?B?NHlSQTRkYjJremcxZDdSODF5NWJsRUdmSThta2JyalE3bnUxbHhlcmZhY1o3?=
 =?utf-8?Q?Vok47Kre2C6a7ex/UV3FhvTmFnNxQE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHhha1hmRDlpMGlNTmNCY2VCVnhIK3JIdlZPYXJ4Mmh4ZCtKcVlCMU52T3NP?=
 =?utf-8?B?aTdpV1RIQXBmRzBKKzVhQlBnZFBUUFc2aTJnU3lVbGtvaWRQRnA2eURhM0U0?=
 =?utf-8?B?eW5zMkxrNVk4MkJTYXF5WnU2MjhZQ2d1QnhiWGxUMkxUNloxeEhqKzR0a2FS?=
 =?utf-8?B?SWFWR00zcUpNajZtZEpsazFRM2pQbmxrMWRXY0gyU2c4OHp2YTlLZTV1Qzlq?=
 =?utf-8?B?cU9KVmNHMGJ0TEdxSHVVUXFOTWpsZ1ZwMnk1WkdxRzVucmZwMUtVK0ZYSjB3?=
 =?utf-8?B?ZTlTQ3RMbG5uY3MwdFZMU1ZGb1lzc201SC9FT1hUTEVsSE1GeVc5VGppbjlJ?=
 =?utf-8?B?UXVoaHpQRHVWaEJkUjhVR1VNWFN5T0xOZTFhWGRuelo1YmtZcndycGJPV01v?=
 =?utf-8?B?T01haE5IWkJEZ2M2SEpueTl4TlZWR0FiWHdZSFlyNGV5Z0pVYmxVcWxvUEY0?=
 =?utf-8?B?d2c2L1c1NWZKUVdPc1VUb1ozMUVyUHhDeEpFU0VqUjVFY2UvWjQ2OG40WGp5?=
 =?utf-8?B?d2ZhV3ZSVmhvSllYU1BiajF1czN3MFRTODBjVnhEb042WUkvdzl6bVI1NVFt?=
 =?utf-8?B?QWM0K3NpbDV2bVlubzJrRWV1cXI2QzZaSVFsaW13OTlyVlFPelhhS09YbGlC?=
 =?utf-8?B?OG9VL3VKRDcxU2VvM0ZuTFd4ZWcrbWdFNnNaZ3ZBc3BjZEltbHJMQjFTelpB?=
 =?utf-8?B?VXQxQWc3NUdub2ZveEJMbGlSSVNZcWtSTXFNWnFvWEowNHR2bFR0N3BZaVc4?=
 =?utf-8?B?TnpSQkJiTUZ3UkVTZHFWbnZUeWhCc0tJY21iRjJGb1kzaUtJVThQTHprdytV?=
 =?utf-8?B?R3VPUkltZEVDSXJqSHEwaS83UitqeGMwZUNaYStnZitqN0VETEgyalVKOS9y?=
 =?utf-8?B?K0xoZ3lzUHF0YVo0MDJhbmNlU0sxRDBZaXh5dXpRdFVlMzZwajB6SEdjOVRX?=
 =?utf-8?B?MW9ydlM1ZnhIcWdhaFhYOEdYSGJ0Sy9pRFRMK3RqRHBEdFJhSFhNVzlqb2Q1?=
 =?utf-8?B?MDdFWElGRk5vUkxDNVRGQkVmaDdDc2pwSkV5b2N1MVdoNHJhN2JZNk9OQ3p5?=
 =?utf-8?B?Y0xGUS9vZmNWNCt6Wjl5bUhtQWcwSHdQTnlzR3B1Y1BNenpSWXVUeUhBK2da?=
 =?utf-8?B?NVNoTGs4cWJaSUllZ3MzNHlQcnBzdnFRaFN0aTUvS1F6Sk9hY2dtUlo1OThO?=
 =?utf-8?B?eDFWQzh4RjZaaTNJMjQzNzIwZG1rUGpTOEUyM2pVV2hlOUNlME1vVjY4Mk04?=
 =?utf-8?B?R2M2VTdUVWVYNVorN3EyUld5M01KMTRVNjBBVng0YVdNU1lqYi82SjJVQUly?=
 =?utf-8?B?L1ZGbEQ0d0VVcVUxZlFKVGlBRHUvbHVJREhMNUVyVUFwSkRFbGtBc1MzQ3I1?=
 =?utf-8?B?NVRrd3dzZlNhSXdKaTZnUW8ycVkvSmZac20rRENLbHRsaU8ybnZRNlp3U0hH?=
 =?utf-8?B?am5PZkdSWHlJREhsQ3RnRGJlQW9jditLYUcyTzJ5ditvNTh1dW9OZGVxbER3?=
 =?utf-8?B?TGdnNHNXU0d0ZGlzZmx1M1JPTHErVE0yT2NBS0xZNXVuTmJhZ2h4NFY5M29n?=
 =?utf-8?B?OEQzdXJNT3hBcnYySzRSN2xFVGdITHZkWW8waU83ZGlmdm1SeW5LYzRrY3dK?=
 =?utf-8?B?K05DeFFwUTQ5aWRmRVFYanZ1Rk0vYVBqM1IxR0VuYzlMdmJTbVVraW11a0Rz?=
 =?utf-8?B?eldOUDhIbjJZQ0U2MVBZY2xOYXVIaHB1M3kzT2MxR3F1aytyTmdTVXBpS2tX?=
 =?utf-8?B?KzJTaGhUYytvRlhnM0tVOWo2NXpLeXRvbUhEcU9KVjFrTm96N0NkNU1ldFpk?=
 =?utf-8?B?R3duRzYyVDUxR3ZyZjdrRGdRa1BFRGV0Qnd1MEthOEkrSW50aUtZOFpGTDZh?=
 =?utf-8?B?VnRWOEVBTTVpbStTLzlYTWphSW1sQ1hFS1NxSDNGUXdMTHdEeFBKbTlkZTYw?=
 =?utf-8?B?UlZPTTFSRnNGVEl6K2RiZGV0Z0Q1NGZCdWo3bzVYMjI3R2E5US9PQURxcmgx?=
 =?utf-8?B?bEdqRzBlajNZNXlLYzJVSm5Sak5vb2VySDc2Vi9neTRab3cyTk5HZExvNEk4?=
 =?utf-8?B?Z1JJclRhK1VGSkJEZzJhYTJOTkhxSnJqZ1lCeTJHblRWR0pXR2grT2ljUHMx?=
 =?utf-8?B?dDVweVF2Z0E1NVZYbThra2RHaTg5czVKZXNwSWNYWGh4OTIxOXczR0FTUDcw?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4EF0E788EBB7147A52AEA8F86EA3443@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qp281JUq/LTPHkKqAH+KtCaQ4+TciK0hvjyf+9pUPgGLq1ztXet4U2nIiPzlfQr46iHj7ubLqMk6b7WobB7OdC67ezUOhOviLQVSLZavoC3T9heHpTAFwI73/PKy6BNg/zKsaicKbHf4HIbYvLV8dvkxV5wli2homrJxUQLFOy88qvOaWceTtn/1KT8knou222hWra13FWhDZljs6xDvLJZtuLkbGIysn37osYIslfi/YCmMqkaMPPrKtZSuMUDbyjuENa4Z65ehYHNXoPJnZ4B8GAyZzA41lPegQmZmDj2FPiOINyQG022y7r2FO9otDU69CpDZqnknubLgF07JHM/JVhP/AAc+THSzdi54O16u92T2O/r/SdSNtNAopotUO5xwME5Iq+iPlHLJ9mDqN2s5BY8ZmfvZvdpvMpIlwfmfXfKvfBgd4m4RI8MQhR99ZebUjG8fB3+4mzRbYVlb7eDUolx9TmWaMcCot782boU8JPeAWcUsRjtprJuYCMNY/AWCQUANg/5iI8uClPuy3v3GoEMOmIYH13RagKARZmLCvNxWEUfYryks7JBgCdA6GeWDOx5ASzyIEuz2+pOy6NifwCFDLTqri2y/xmZ5vulcDVyfqGk2iHxlmqv5gpg2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30404be3-21f0-43b6-af68-08ddf4ecc78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:46:35.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMW6ASwwTkmVaHYA9htGPAJrXYsuhQyBZDXeWCzAYvnoV1oL39Sqa38HXUGqCHeRjtAhYhHENd6EehFMVHcygP+sohW8hxqACE55YXqLhlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8171

T24gOS8xNS8yNSA2OjM3IFBNLCBmZG1hbmFuYUBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9tOiBG
aWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4NCj4gVGhlIGZvbGxvd2luZyBhcmUg
c2V2ZXJhbCBlbmhhbmNlbWVudHMgdG8gdGhlIGtlcm5lbCBwcmludC10cmVlDQo+IGltcGxlbWVu
dGF0aW9uLiBUaGVzZSBhcmUgbW90aXZhdGVkIGJ5IGRlYnVnZ2luZyBsb2cgdHJlZSBsZWF2ZXMg
YW5kDQo+IGFwcGx5IHRvIHRoZSB0eXBlIG9mIGl0ZW1zIHdlIGNhbiBmaW5kIGluIGxvZyB0cmVl
cywgYW5kIGhhdmluZyB0aGlzDQo+IG1ha2VzIHRoZSBkZWJ1Z2dpbmcgbXVjaCBzaW1wbGVyLiBE
ZXRhaWxzIGluIHRoZSBjaGFuZ2UgbG9ncy4NCj4NCj4gRmlsaXBlIE1hbmFuYSAoMTEpOg0KPiAg
ICBidHJmczogcHJpbnQtdHJlZTogcHJpbnQgbWlzc2luZyBmaWVsZHMgZm9yIGlub2RlIGl0ZW1z
DQo+ICAgIGJ0cmZzOiBwcmludC10cmVlOiBwcmludCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGRp
ciBpdGVtcw0KPiAgICBidHJmczogcHJpbnQtdHJlZTogcHJpbnQgZGlyIGl0ZW1zIGZvciBkaXIg
aW5kZXggYW5kIHhhdHRyIGtleXMgdG9vDQo+ICAgIGJ0cmZzOiBwcmludC10cmVlOiBwcmludCBp
bmZvcm1hdGlvbiBhYm91dCBpbm9kZSByZWYgaXRlbXMNCj4gICAgYnRyZnM6IHByaW50LXRyZWU6
IHByaW50IGluZm9ybWF0aW9uIGFib3V0IGlub2RlIGV4dHJlZiBpdGVtcw0KPiAgICBidHJmczog
cHJpbnQtdHJlZTogcHJpbnQgaW5mb3JtYXRpb24gYWJvdXQgZGlyIGxvZyBpdGVtcw0KPiAgICBi
dHJmczogcHJpbnQtdHJlZTogcHJpbnQgcmFuZ2UgaW5mb3JtYXRpb24gZm9yIGV4dGVudCBjc3Vt
IGl0ZW1zDQo+ICAgIGJ0cmZzOiBwcmludC10cmVlOiBwcmludCBjb3JyZWN0IGlubGluZSBleHRl
bnQgZGF0YSBzaXplDQo+ICAgIGJ0cmZzOiBwcmludC10cmVlOiBwcmludCBjb21wcmVzc2lvbiB0
eXBlIGZvciBmaWxlIGV4dGVudCBpdGVtcw0KPiAgICBidHJmczogcHJpbnQtdHJlZTogbW92ZSBj
b2RlIGZvciBwcm9jZXNzaW5nIGZpbGUgZXh0ZW50IGl0ZW0gaW50byBoZWxwZXINCj4gICAgYnRy
ZnM6IHByaW50LXRyZWU6IHByaW50IGtleSB0eXBlcyBhcyBodW1hbiByZWFkYWJsZSBzdHJpbmdz
DQo+DQo+ICAgZnMvYnRyZnMvcHJpbnQtdHJlZS5jIHwgMjU2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMjIgaW5zZXJ0aW9u
cygrKSwgMzQgZGVsZXRpb25zKC0pDQo+DQpMb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

