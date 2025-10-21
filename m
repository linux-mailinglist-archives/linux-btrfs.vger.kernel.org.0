Return-Path: <linux-btrfs+bounces-18107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD685BF5DCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46BC3AB337
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6CD2F068E;
	Tue, 21 Oct 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hNN8nbJO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yiw0diYD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781872ED167
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043481; cv=fail; b=ZjeWJ8RXcIXixVGNmC5bV74wXKE+sEk288JOMEPOG19FspXVUPHhajyH19EfvcNOT1RvNwBQFKe2aVrdJGA2lPCNU+ISWAN5I+v8Lo7zG/Bh4BCfPbEDVWQ5odqtekhscNvDqYppZTZDrsMgQStqUoFMsPhjENJvNcBljBpM8RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043481; c=relaxed/simple;
	bh=6p1waRJv9t2yFFHyjGgAMvs/dAFL9SNgCEM1v6xNgts=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIODRZBqxTWuHOhS7HDSb34REJytlqHLwGKD+isd+ohZ9XWxrQmF1E5iGsa36kFPa3+axhPs8vogWwFU0vnqunvqI/nFMKQhQ/ebdDcK68aGyGcsxOO8ZSKzP5Cwfs6D0Gf5gGGd9fipU6W/kFCalZb6FiBF76eFx9hsW3Qe1Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hNN8nbJO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Yiw0diYD; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761043480; x=1792579480;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=6p1waRJv9t2yFFHyjGgAMvs/dAFL9SNgCEM1v6xNgts=;
  b=hNN8nbJOpL90pc8+8G0/uXnvmdV2xgtVnI9yXxx1mIkDq6fSCxlZOdL/
   4BB1/eDbDbkRAYtyHYrZz+lN+ObrllJ3K9bQOI8FxrMUzsO1gEMxt6fxa
   Q1Ct75fc/CqgfP9rof9RYFG3+rnsi0rr0geIQvB3DWVn3EkFzwADSbm1A
   D1ZJGISIAbdwZ7lUeMt7pvizySP3s05Xn1pd+7v6q1LrUgVNJvLEvk4j/
   DqYFmQCFhK5GIc7NDuEGdb7e23cXXllO0BeXVplxFOuemWCX3wlrmUDP2
   sKFM0xVaawqsVqmR7Dvq600H18QgNA7lWgs272mVfgqEvAJpuZY3cz3Oj
   A==;
X-CSE-ConnectionGUID: Z44nhHKDTqKTqpxD2xLj2A==
X-CSE-MsgGUID: ZfXyDK++S82athCnyqgunw==
X-IronPort-AV: E=Sophos;i="6.19,244,1754928000"; 
   d="scan'208";a="134575772"
Received: from mail-eastus2azon11011003.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.3])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2025 18:44:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNgfF+vUJQ+hja2ylzzMIV6mKx7vOHCHP0bAbPXsQfFtAq361i/qrX6Oms0MIIkn/LVm25bSQZKrujaMI3gDGxlRx9/XU7k5nrZj5ooLQSe2Fvvxyv1zM2yNKKlsSIl01BFgY3b3PICxRsdjp7T7u4s3gMnbY0InsSut3vex38otjOetE1HmVo5xGroflyl5Fpv8UoHd/yUmVoeFz3DqJeunsYbYq7JvknYaycRn0EPT/Vm/gTNZTmSuKSbKKAJMQ4ijImMUvV1Gi9X5VU7tHtn80c78A9nnB1FYxTEdsEhLV2SVAvcWR6cExHHk+qRwUlOI4zEEwfv4V5yewBJBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p1waRJv9t2yFFHyjGgAMvs/dAFL9SNgCEM1v6xNgts=;
 b=sV84wg21eOUnjgpZ2oaU4LQxnheUDaK5Kr3Su//nwLDSW1QA85kPNoFKxA0PSN9UlEO6cTDyIrGjNpmvJshN6TillmYocfrOLWKao/yPyaYNZh95820MJml4VDf0vNDAoqkbXd/aYz4FwPCe7hMZSQnAbSTR/mj5bqYo8O1hLb51PU5yOXUnGJ37cDtn0HFKYgdyaYFWb2HHqt0NfeR2YPn94bSfrp2emH8WcEOr4s5UA/TLMML6wdtQmhBtlHQb1kNL4QdhMMtH3f5+5DK9GvsKIADUpz9qxdjiVJJIdvpwLquyY4GqrPNRPCLMFNBs5HuKGGm/ZHd0Zi9qaRUT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p1waRJv9t2yFFHyjGgAMvs/dAFL9SNgCEM1v6xNgts=;
 b=Yiw0diYD5mGZu71SCMLmEyBjqqeIKiiyKRIqm6noneFZ5qZ3UWtZmKYgj98HrOUFOPX5Dlpu0LFtqM2KErAednMH98wf4u6rcBGDFDEVlh0NrXuISM35PWGBGi/fdEkCP0KgoMAVeqGo9MNJK6Nl04uVtjVHdq7Z/gp+5rJamGU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8887.namprd04.prod.outlook.com (2603:10b6:806:386::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:44:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 10:44:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: allocate bounce pages for direct IO
Thread-Topic: [PATCH 2/2] btrfs: allocate bounce pages for direct IO
Thread-Index: AQHcQlt2QfTMeaejPk+1rWdSNrTQS7TMaqOA
Date: Tue, 21 Oct 2025 10:44:29 +0000
Message-ID: <5d907fc8-8bec-4a9c-914a-e2c3caf5d18d@wdc.com>
References: <cover.1761030762.git.wqu@suse.com>
 <2d2faa4c2393015d225a27e4a729fd19216467e6.1761030762.git.wqu@suse.com>
In-Reply-To:
 <2d2faa4c2393015d225a27e4a729fd19216467e6.1761030762.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8887:EE_
x-ms-office365-filtering-correlation-id: 953ada60-64b9-436e-d81b-08de108ed047
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlVFdHZ4eGdKZzFKcXNyYkFwMEpuNHVvSmNZM01xK0dHd0Z1dE9ZK01QUU5l?=
 =?utf-8?B?dUp2aFJMaXJoS0VDSWVBNmlUOGltanY0Z3ZUYlJyYmIydDlLa0c1UkYyNkxn?=
 =?utf-8?B?eHhZY0tHT1FKTTFlMFRSN09OUEZmeEpPeHFIbGE2NGZRTVZkM0drMkp5M2Fv?=
 =?utf-8?B?cEx6RmluN3BPNEtmUGhoRGlOOHVTZGdZcExWWHJVYUJVZmpvNnpiZ3Z3c2ta?=
 =?utf-8?B?cGlDdVR4cjVXeWRKMGF3RENSdWdxT0ExRzNzbnNENWZodks5Kzd3S1A4NkVv?=
 =?utf-8?B?UElnaWNLbVNUT0IyZDNob2czd3VmNWlSbGgxY3QrZW4rbkV1SHJqMEIrOHJ2?=
 =?utf-8?B?WnpyNHBiWUpHb2VDZlMrYXhxbnFSaEVoWWxJOFZ5VEFvTkcyTGNIYm1RQzdC?=
 =?utf-8?B?Y05LdTBkNGtJdDhsaVN3bHB6Q3VxaXcwOXpPQXNWaXo4M1BWVWZNSzF4NThs?=
 =?utf-8?B?d0o1QVRtZGJkTThZN01tYnpWS1VjMWJ2MmdqRnAwZDhEMVN0dG03WUFna25V?=
 =?utf-8?B?OVIwYjFhVjRRT3l5UU00SjdqTGQ5b0t2c0hZazJ1WlBjdEZrSlpaZTV5SG1T?=
 =?utf-8?B?L0VVNVFUU3BEVm9qZWdtbnJRcmtiU09FSFpCektRYWtaQWQycWI4TzNmUlNy?=
 =?utf-8?B?M1psVFBKTXFWV2Rrd2M4Vks4Sk1rUzc5T2dDdEtpcm5zYXQ3Sk9tcDRJeGxt?=
 =?utf-8?B?SWFMRktaVmJ6ck9TS2dHZHFmQThzb0hyaEQxOTRIZXc2b3cxZ3A2RUF0bGhB?=
 =?utf-8?B?cDJwNEVudVBrMVV3NkZWY21mUGVqRk1RWENxNzU1SUVxYWhYUkw4VjcwUW1K?=
 =?utf-8?B?a1o1ai8xbEVOVTUxTFRnK1Y2K0Qzc3IraGdjRzJvMlFyaXhZY2YrczRPS2F0?=
 =?utf-8?B?Tm1RK0ZtUGtXMVFzWmFjTVd2MG54eUR0Y054ekR1QW9HY0YvcWE5VjZ3ODZZ?=
 =?utf-8?B?S0NjaXh2eXdUbW9OdzYzeVhlSG81Yk0rQlhRWEw4WGxsU1NRYVQ5YUNVcFNq?=
 =?utf-8?B?R2gxSFRLOWp5YWt0eURWbThMUDIrOVYwc0FzOTdxMCtFYW1BeDZBZXJHK01L?=
 =?utf-8?B?cUhIbWVhL2tnYXk2SFJlOERRc2swZnlDY3F3VjREeGRocDhOVmxEdWU5enUx?=
 =?utf-8?B?Z0U3RGZkUmhmc2Jxb2ZNbEJKTnpKaWtuU3hYTGI1ZUVHcnBGZVcyaG5DRjZI?=
 =?utf-8?B?d0dqSWxmRmIvRDJYK0wveGRROVQvOTcrM1I4S2d2WXZZNThXUGJvRjZkY05R?=
 =?utf-8?B?aitrQUVWSlV0SS8wLy9PRHl2dFljSlVWOTRJRkU2YUFHZ3hxUWNSQjc3YVU0?=
 =?utf-8?B?T0pvZHUzNS9sK0l3RjJyTjA0QVYvSUNQbGZzS0RWbmZacVp5NHhvV3orMDVP?=
 =?utf-8?B?KzFuR1haQWVlelkvMlBXZFhyVVJESlFCT0gwcC9jMFpFV29FUHFhSG1yaWdv?=
 =?utf-8?B?bXQrY0pNaEZHNlhQODVQRHdjakx1UW0yMURWV0p6eEh4K1EwZ0Zlb2pQOHpP?=
 =?utf-8?B?cUhyZGpZa093bTB6L0dEd0Jqc1IxYi9vYytNM1ZPcFRodnFIcHh6dlBGT0c4?=
 =?utf-8?B?M3dINWZreDcrYng5U3dxN1RVbTVxWkJqenBVUy94RlA3Z2p0RFB4NlBNTUZ3?=
 =?utf-8?B?R3dQV0orS0ZUcFdRSVcydFRIUlU4S1dXUE5oRGdiZHVlcmpxWmd0ZEdERXUz?=
 =?utf-8?B?TDdwOE9KTHc4Vi9CTHFWRHcvMC9sYlB4M3ZHY1d5cTdzNmJpeSsza1h1SVNV?=
 =?utf-8?B?YTJiNXRydk5CbU5TMU80TzZkbnlveTQ2MGk4TXpBWWhiS05GcUxoZ3NJWHky?=
 =?utf-8?B?ejZlZjJFRjVPdVJBUE8vZjNPd1ZHNFBERmJPRkQ2WGszbitNckxsZEFNSTI0?=
 =?utf-8?B?SWJNT3QweVJ4YnRGZUNLakRKWlhaMSs1TXlzT29VRElVbHI3WjdxWTBYbUZn?=
 =?utf-8?B?aG0wQ01SQkxBb3FJUTEvZWtSTlhCb0xKTmxvWldzNXg4UjJrZ1NFWHp3TmVY?=
 =?utf-8?B?RFFQblRHdlJVQ3E0bzkrZGJTZ2doUTBLbzNVSFdBN0F1aHFZSTBxQWUyWG1J?=
 =?utf-8?Q?odgkH0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0ZTQjJ0ejd4dnNxVWNtTlYrVStzNDkvdkJPSDNFVldUR0EwNmxoQ1FzTmhY?=
 =?utf-8?B?YVlFYjhKcFZoRzlEaTJVbDl2OTk5Wi9WU3plS01XcENqd2YwLy9mTGFiUGxo?=
 =?utf-8?B?TFdQWXVpamh4cVpXaURVVEVKVGhHUEpqSVFCNVQyM0M1bldOVEdVZSs3ZW0x?=
 =?utf-8?B?cXNVRXNob3RORlhNcWRRb21xZHdDckV5N1d0Ui95SDJ3U2xGdzJCdUpNTVlL?=
 =?utf-8?B?R1gwVXVGc0xKRFlLR1hTMEc4ZkNzNGpUWTJVTXIxVXkxVEswMDJrNHJSd1Q0?=
 =?utf-8?B?S3dyV1NOcGxlQ3U4YmJad05xaVhLUDBsV2k1Zi8wdTJQbkRDS0pUdFlKYlBu?=
 =?utf-8?B?U2VKRjlYeEJiYmZNTW0rUWxaT0tObXpoYk5HRFpremNGMXFBRGoyejQ1Wkp1?=
 =?utf-8?B?VDkrdWkzL1NFaGRFb1N2N3hxcXpOdXRodVQ2Q0dBajVWSTV1UndubmV6Z2Ez?=
 =?utf-8?B?U1dwUlNPWm9TSWQwTTROaUFsTDl1U3pzWjBIb1NNc1BYT1MxWEJocmdCWG11?=
 =?utf-8?B?cXlHOWRRVTBhdW9jQzdNSlZLd3F6Q2lnUG9jUmtMbHNUZDZMZjJwQTF0c09k?=
 =?utf-8?B?c3VVMlhjSVVtSklkN25Gc2pqNXUxSnA1aHlWWUl6Nkc1Qzc1d3RCdTVOVjFr?=
 =?utf-8?B?RWkxbHRvanJkbkhsOWh0TG9obHM0OFdyYVV6ZmhlNnE0TzZVeXJRdXA2TTFX?=
 =?utf-8?B?NlE4TU16QVdSd1YweDZLMUpEKzVvWlpibVFjR3ppUVZ6SU5Ua2dId3BXNUtS?=
 =?utf-8?B?R3NEOHdGUGNaNXNDN0x5dDZZMTBaNkhwTjZiZWRmUi9GWkVsV1NZR0ZXSm84?=
 =?utf-8?B?RWRteDd3MW8vWlM0MVBVWDBXWE5YQnJpYjMxM1UxU0RHRHJ4WThSZHZvNlRJ?=
 =?utf-8?B?RWNrNlM5VVlERWFWdlFsbm1FTlZmQUN5RnJ2NkRIRVU4TWJMRjFJczI2RWQ0?=
 =?utf-8?B?MllBSmE0Q1h5aU5Canl2YnlTKzVwWmhUSlFYRldidlJsUE0xUWlBYU1raXE3?=
 =?utf-8?B?ckhiMHNYRERucVVaVEZCTGZWdng4RTlkZVE1cGtCNUVKdG8ySS9CcnN5SVN2?=
 =?utf-8?B?c2Y2d3ZDYXBxQ3dCakttby9mcDdHbE5OelpuNXpFUGJ1bUVqVHFIbGI5M3NS?=
 =?utf-8?B?RFQ1cVF3b1kySHhKVmZXWmRQdUhzOE01RnhlT01vZ2NaQ1U3WDg3S3V6VytT?=
 =?utf-8?B?eHQ2QWtDOXFLYnZNWmNHbFB4TURaRVQ1Q3AyNTJGRjRKeFVySkNIQWJEQ3ZS?=
 =?utf-8?B?U2JHRDJpZ0hsT0w3Mkk5cURCRHpsSThPNjhWRnhtQnJqaHgrb2R1RDVjZGIv?=
 =?utf-8?B?OUpNT1RxQTFGNVZwUFJWVmJEcENDZkQxQURxNStwZW0walYvSUxPcHdLTjhn?=
 =?utf-8?B?a3VXK29WR3ZvMmMxay9MQWhJNjNEcisvUFJaTmdDck1sdlVKU1dSb0tXelRs?=
 =?utf-8?B?REU5WlJjNFV3S3VxS2VUVXJpU2tDODZJb2tzTjRIREZuZitnbVhZUmxqOEoz?=
 =?utf-8?B?NFRzakljcDN6ZUZ5eGV2K055MzYxbDN1M0QyVUtlWHFNeVcvOFRBY1d3cmJt?=
 =?utf-8?B?TjdsOS9Jd1phQ0tRVWlMKzVkZkNHVmlwSGN2VVg0ZDFmYWtBZXo1Z25leEcw?=
 =?utf-8?B?ZEtQbDdLOGVvZ3RKNiswb2VqcGtIQ0dEWVdKWnhVMkhzK0M5WXRoL2N0Mk04?=
 =?utf-8?B?bjZHOUZLbmZNNWhsOW9OWjZnTjFRUHM1ejZGR2NRa3NjMVpVQndmKzUxVE1h?=
 =?utf-8?B?aXFuWHEva0wyblNIUUJ6L3MwOE11ZUlaZUhGUytBRU1NaTlBV1cyOVpJY1Zs?=
 =?utf-8?B?QW1HaTRHVlVHNXNxc1E1TTV6OHpaY3RyOVdjalluSTF1ZHhLaTU4SFZsd2pw?=
 =?utf-8?B?ejhQMGlNWU92d29FTGlkblZWVkt3R1FDVnU4VWlKNGlIMXovdG9oQTQ3V3NY?=
 =?utf-8?B?c1pnUUVrQzVHc0lPRDZVUjFtYjhjZnVlSVIvQVB4M2E4WGhDSG1FNThZZ21q?=
 =?utf-8?B?SjhoT2xKMWVaa1NGb3lNTGZxNkZjVHNiTUpQSkhYWnFaZm1uRWs2TEJqNzVJ?=
 =?utf-8?B?cENSL2V0MGNmOEUrbXR2U3VreFhOMGM4L05HdzR6Y2FieVJsaGVMc1F0d0py?=
 =?utf-8?B?ZU1hZzZEd1NpZllkbHYzTkU1L3MvaDgwT1Zxa2M1RWJMOUxYMnF6TkNhdFMr?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F71CC715C9294F820AFEF4561E8FFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AKwPmPTKFjVieNs0m26tWNP0uqqabScJt/+o4fFTZKQGh6lTpUTHGxAivbKNavdIeDj58oG9IT6SVoKc5OsZn2pUr7ormiWMhfoihkqJNYYWhZnIN8ZgB7m8bV1snYig38grStTGEWtNbRB81phfK+ZXpDK55Esxt+EPiVwTQy63FqBgMaCCkC7uy5OGJh3n9FIV2UuUu6kCSfex4WwJLaTTffwXHpbiqg9/oM23ZCoYhs91uCfI1pdkWCtSFBfSHl/+Ixj50K/ywTlNs0WkMCdJ2/jJeNKCsGqmcWBXFURZ6Rk5n+JqCl4UtUJTNWQJ1v8X2oK8yBj7R9/JpN1Ll9hP4ft2OyCy6i/tX5tTnVj15fA2H4m3O6ivZmpXJcow8LbpeK5xq6odrWnPH/dp29Q1+ybp1w1Nxo7BSogSrouf86PMoc6dQvZBfMWGZjCTcnAtZUe/xr3JmZJ5ODH8lGS1O4swy+mp31QDrzy9p4uDD6hg6xv6mKXrSPZdDfRZ6IDGQld0Ruy0derhnhsExhHq41hr6My/BWorVUPa05HkX5us8aKkSSmYqg91+ERB2ESWzSKneCb12Tdllz2vwT0HgBgSvCXhCrt66V8M2qyI4wWrfg1JWFS9cnPbAFBb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953ada60-64b9-436e-d81b-08de108ed047
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 10:44:29.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q85UWtSvbdHmYNQ7hYJgo4cTNalwkiskLytblN+WZIm30mY5B7lb7REeyD+LGCsh+USO5xZokEWbnNsRqkjcdk5qeidAudv4pHEhm5bBtjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8887

T24gMTAvMjEvMjUgOToyMiBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPiArc3RydWN0IGJvdW5jZV9j
dGwgew0KPiArCS8qIFRoZSBvcmlnaW5hbCBiaW8gZnJvbSBpb21hcCBkaW8uICovDQo+ICsJc3Ry
dWN0IGJpbyAqc3JjOw0KPiArDQo+ICsJLyogUHJvY2V0ZWN0cyBAcmV0IHVwZGF0ZS4gKi8NCj4g
KwlzcGlubG9ja190IGxvY2s7DQo+ICsNCj4gKwkvKiBOdW1iZXIgb2YgcGVuZGluZyBib3VuY2Ug
YnRyZnMgYmlvcyovDQo+ICsJYXRvbWljX3QgcGVuZGluZzsNCj4gKw0KPiArCS8qIFJlY29yZCB0
aGUgZmlyc3QgaGl0IGVycm9yLiAqLw0KPiArCWludCByZXQ7DQo+ICt9Ow0KPiArDQoNClsuLi5d
DQoNCj4gK3N0YXRpYyB2b2lkIHB1dF9ib3VuY2VfYmlvX2N0bChzdHJ1Y3QgYm91bmNlX2N0bCAq
Ym91bmNlX2N0bCwgaW50IHJldCkNCj4gICB7DQo+IC0Jc3RydWN0IGJ0cmZzX2JpbyAqYmJpbyA9
IGJ0cmZzX2JpbyhiaW8pOw0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmYm91bmNlX2N0bC0+bG9jaywgZmxhZ3MpOw0KPiArCWlmICghYm91bmNl
X2N0bC0+cmV0KQ0KPiArCQlib3VuY2VfY3RsLT5yZXQgPSByZXQ7DQo+ICsJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmYm91bmNlX2N0bC0+bG9jaywgZmxhZ3MpOw0KDQpTdHVwaWQgcXVlc3Rpb24s
IHdoeSBpbnQgcmV0IGFuZCBzcGlubG9jaz8gY2FuJ3QgdGhpcyBiZSBzb2x2ZWQgd2l0aCANCmNt
cHhjaGcoKSBhcyB3ZWxsIHNvIHRoZXJlJ3Mgbm8gbmVlZCBmb3Igc3Bpbl9sb2NrX2lycXNhdmUo
KT8gRXNwZWNpYWxseSANCmFzIHRoaXMgaXMgb25seSBwcm90ZWN0aW5nIGEgc2luZ2xlIHN0cnVj
dCBtZW1iZXI/DQoNCg==

