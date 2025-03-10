Return-Path: <linux-btrfs+bounces-12145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF9A59A4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 16:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A42B16BFFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE122A4F6;
	Mon, 10 Mar 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YRrKQs2p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FFKK8lzH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5EC1DFF0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621639; cv=fail; b=urSecwo8vL8ZeNIET0UTE1OQzEZwIFi1eZT6GsV3sHL7Ub0oIJWf2DUiieatzA1YmYYdWBLzBSiISzl3GJAwkM0ou9PfOLJBTYD5p+GNZumx8geoIJcGMlktMxIhESkH09leapSZ3N8vOy08yaNctcnJBW5nrQ0GrKSeerN3A+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621639; c=relaxed/simple;
	bh=IU6T+6Pg/sx0GQ0mkBvlibUhNKTYzskklO/Te7DZrlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sH6o6loSqz+NBaYP+tpIJOTasAE6u4SbxKTJgpplaAd1abkn01shA2DyQQYwOJJ5UTkGdDtsttrwCgg995qDtCp6LanCDzmK1wwfpxIYEMr98XJflunkITfY3Dic9qW9JvyxMsu5DlPQCiY+TIacsf12nTiepzIrZeGxnaYwKsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YRrKQs2p; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FFKK8lzH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741621637; x=1773157637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IU6T+6Pg/sx0GQ0mkBvlibUhNKTYzskklO/Te7DZrlU=;
  b=YRrKQs2pIS7PLJnl0zFJVaqQFyk1WYNpu6KTCfbLrOnB9vFWaIj7tDqt
   fq/2LCUjTAvBXsRnX6jiMrtYcLKJnJQ5j1gDWWAljUMAP4A1BuARJ5SUn
   /sIoZ5xeJC0YY3rXkswTNPjEtdjsWOn38UqoFwoWsbML2Ey7EPaRjrqkE
   E5QT1x4ht2PCReSWC65Zg0hz6nHFUwt8qNlbnv2RjTHcmkOzTK+eSwCbm
   kAEpfTsyyNBDKVn2OsPRcsVc76p/ItDmnMrJMzm9n3bSe9knc6A3CWYdc
   sUSQlt0cOOfhUz1oITwMT9yNgARiPAAaVp8IryztP+AaDlF6Jflu47oYa
   w==;
X-CSE-ConnectionGUID: RPe030q3SRyrjTB+mvWOuA==
X-CSE-MsgGUID: KAQGId+CTWiDRcVO6tpHiQ==
X-IronPort-AV: E=Sophos;i="6.14,236,1736784000"; 
   d="scan'208";a="46991532"
Received: from mail-northcentralusazlp17013059.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.59])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2025 23:47:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGnxWVQg+I/eAu8vyvRxSqh9JiLzGYJglE6T4weRt/vc7QWWN3iRHQBLaLVr8P9LbLB8ertufI2wZoZiWE/YSkiDdRmi3A+tZyFa+DWUsQZeZKSP0b7ldbwNU1G9Qmu+uQ6ZLHMJsx7Gfn9KUCdyERW9thh74ZM11f+CdGA37rIUafo9bOK0959QTnLAeViUq5S66U1fam5mr9stLCqkM9KpAdlQXuNtlqSV0ysxJ0z86xTfIxHy70gPaBV/+v2o/9w5WBESRkQ9UII8BwjGh6Wn2y8pF5jP+j+LMK38roMQ3SFrxHamulpWxCXvZTjzNBVmJW2nhyzDshOqoL+qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU6T+6Pg/sx0GQ0mkBvlibUhNKTYzskklO/Te7DZrlU=;
 b=PRPxSS3ljJMj6m6IEcW19WeVSWk5DWSEbECWcZGB8Xe5ig725pWqxboXEetoZ/Og/YUm9DJK4tV5lqLLr3AYfBytA8TfBG7nhh0q9Qe5sE44+BI7w0H+qGZF/oNBfgWHLhqw+bE+QaBW9YR/IHa3w53h8eL29DFj61s8QUQPLQVY3CDsWgkyaBPVXalJ9kzBQaAgxYmkCJpWan6/zq8MFbitkWpwqFQXauUNCOAoorEajLYRxzNKXg9vVxQy0/Z4g9B8mUOrmjJiG/zSHduzKhXayuTKOfPcSX3MJJ0MT599q6e/fte/WvvS9hMMSKHkG28nS/6jmQi7GA7XfY40Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU6T+6Pg/sx0GQ0mkBvlibUhNKTYzskklO/Te7DZrlU=;
 b=FFKK8lzH/x5jM5A7ntPbh6td3i0SFZB2kYAC0rJJBpOMvY6YFBjCaMBwtKUrgS8jf0HHDCxLR694pOcNS3+1oPKo0hQjf5G7ZgK2KvD5RgP8oypaEvD7pOwR+V1q89griRpW7FlSgAKMg6ar9qTZeblbd+bDh15cpMaAK9SiKto=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 15:47:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:47:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index: AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIA
Date: Mon, 10 Mar 2025 15:47:12 +0000
Message-ID: <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
In-Reply-To:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7623:EE_
x-ms-office365-filtering-correlation-id: b19b1fd9-3009-4c04-ae15-08dd5fead3a2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUk4dXJKQU9mMGlCeGhMTzFNNXZYQlY3bUFNbW82QlBLa01KanVpZFlwSkZK?=
 =?utf-8?B?b0JsRzBoOU5WOWZoYTZoTlhNdGIyRnQ1NHFoc1lsVGRoWVhkMmpjY3VLdkdu?=
 =?utf-8?B?akVWMXJlQ2RUMnpLdmNub1VUcmppYXVpSmw1RkM5T2pOK2hINWNZTVdSc29B?=
 =?utf-8?B?bGk2Z1h2K0grelRsMFYrRmo4VVU4cGc4eU40Tm16YzFjMFZJRmlyN0w0Q3hj?=
 =?utf-8?B?OFpia2p4ekJ2czFUUlhsL3VWc0RGbSsxbW5LNFJuYWYvY01TRUdrSUluQUVo?=
 =?utf-8?B?b1Y0aDFWSXc0ZUNvWU4rdm94MEdueGZ4OC9nSzB6UFZUY3JTalVhK2xCaTFi?=
 =?utf-8?B?NmFsVVkrOHFSaGRqaDUydFRpUHpienlWY1dYQnVnQ0Z5YU9pTGRWSllVTXNr?=
 =?utf-8?B?dk9BbHU2bDRodG5JSmhHNlpsQ0RlaDBqNHVrSWZMVDd4bnlaUUR0d1dveVlT?=
 =?utf-8?B?OUxkeDRBazgxTTBSM3QrMEdFRVdZdS9LMVBGaFQ4UFFLQUFTSWFuRitwMVUw?=
 =?utf-8?B?Zy8wTnhBTjBEejIyc09iT0Rycm50NWszbU1hQlloTXBybVNxYTk5VGp5Mjdy?=
 =?utf-8?B?K3JYN0JuOWMzdm1FU2ZGcERqMUV1YnVIV1IvNVV1YUFQai9wSTdOS2VFN3Nx?=
 =?utf-8?B?N2syeGJtVGRWcDQ1R091c1NrWUxoRFkwUGFMNWYycGpLZ2pzdnIwclJDcHNO?=
 =?utf-8?B?TlpNTFh0dWUxOU1pd1RKMHNSRDNWVklYR1B3c0N6d0dudUVZNkZERWhBU3Bt?=
 =?utf-8?B?UEpvL1pmOW5KOUdRYmpKQjk1eTdpeG9xZUdxRWdyU21mVXB5NmRUd3JSd0cv?=
 =?utf-8?B?eW1LUXFiL0VjWk9DMm1mdU0yTmJadkxNMWh6SVdZWlIrYk5pT2ViUmJuOFND?=
 =?utf-8?B?UXpCSFNRUHNNUllOclZraEhrbCtwYVViNXZTSU9jTHNzNlF3WDV1ZHk0aEly?=
 =?utf-8?B?aVE3Skt5bEhNMldscm1BRTUwaTFjcTl4OG5lZ3NuWG41Zkt2YVRpeTVxUE1i?=
 =?utf-8?B?ZUpWNFgxanZRRGNDZFVoa0sxZ01rR09NY1YxM3JaZVJkSlRiT3pwOHh5alll?=
 =?utf-8?B?UWJkaVQvWHhnUGRzM0FIcEVqTlY5K3h4ZDFjdWhDZ1M4enZsbkFtUW04ekpP?=
 =?utf-8?B?Rk5SWEsycWExdnhLVmh5c0NRTHJKMlRpZ3RRUWZSemJxVG5jTUZ0WmM1KzVW?=
 =?utf-8?B?THVzVFZyMW5LWExkWlNmUEI5RUhlUzYvQUNxejh3U0xEQjBJRTRlWWIyZXpt?=
 =?utf-8?B?Mkh1MFhQNHQ2eU5vQWtaMCtWZGNFdjhQT1B3NURCeEpwMVA0OTNrVTBldmsx?=
 =?utf-8?B?TWI2RW5YTDdTYlBMZzFnSUZiQU9Ud3k5Yk9rWk9aNkt5RGJTVWxyRHM2aGU4?=
 =?utf-8?B?U1E3TWQ2TUFOWk1pWUVVemZXdUhsYjhOSGd4ZXdGU2h0UmR1UWozbXVDak1u?=
 =?utf-8?B?UlNiVngwYjBQSWRqUVE4RWdBTmplbEMydis0Ty85YmhYWlRWckY0VEM1Wmoz?=
 =?utf-8?B?KzUwcDd5V294NmYyQkhqSEtTT0g1SlZYZDc3UXlmK1JtTHZvVEZ5R3RQdjNX?=
 =?utf-8?B?cXlYNkN6MEp1ajR1c29TMDdVRkIvai9Udy9iSUQxaTB5TkNRbHlLQXFMTUpR?=
 =?utf-8?B?MWFBTUZ2RThXOXlDbE03MkNHci9XOWxFQkJoTElGSVJSbXdoTU1NVjBLeGVo?=
 =?utf-8?B?dlVoc2FGV2lRaW0yTkRabnRIaWc1MWVEeitGaHorT3VGSHc0aFF1Q25TQjBE?=
 =?utf-8?B?bnZiVEpXcVh6NXlPVXM1Ym11TjV5OWVIbkM0VjA3MDFXbjNYSGxNOTc2a3Nn?=
 =?utf-8?B?cUR5OEIzaWc0N0lEdmJ1VnFZYUQvSjdvbjdUeUFnQjl5R2tzL2R5eDZIdVhQ?=
 =?utf-8?Q?PCL+/zCRw4FeN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1M1eUNzMjB1NS90aURXTktsQzZ0N0ZHRVlMSS9FOWFlY0J6am5ucjlXMXJn?=
 =?utf-8?B?bndOTzFUV0IzSFZRMWVZanV1MHIvWWZsM3A0Y3I4WjljYnJIdFNTelZlNGNv?=
 =?utf-8?B?R2Vwb0g5ZlBhUzhZMU5KRnY5SFFyc0tFenV2Zkc0RG9FRStja3JxTjZRblZI?=
 =?utf-8?B?MnVBMUN2Qm5YeWRhTFhHZ3JCUkJadURBbmhPbGNLZ3Q0ZXZCNkFrcXZ6QlFQ?=
 =?utf-8?B?Z0lYa0R2d1Q3ejZiNDBObUEwYzRuK3JqVWo2WUUraW90U09UYmhUVERNU20x?=
 =?utf-8?B?Ri96N2JOdlYxZWttaXZhM29KdUdWZnk5eGUxWHFoT3VRU0NmUng2SStMTzZ2?=
 =?utf-8?B?Wllpa3g0aTBma3lPd2JWZmFMTGRWck8rNjg2Rk5uVVZPRjE4TUYyS21GTmJF?=
 =?utf-8?B?L3Jqb29xalgzVWo0M1Q2WFl5THoxZVBnUjZkUE42a2hZQWFQV0RVcWZiYU8y?=
 =?utf-8?B?ZU4xUWt6V0UzZkVTMFA1Nml5RVNCU2xscXArc3pEaVZ5dVRua1JzL2xFendW?=
 =?utf-8?B?TDIvcHJTN2YvZzNJZVFmdXZDeE1aakJFSC9YYXROdTFTN2Znb1AvV0FMV1gv?=
 =?utf-8?B?b3N4MnFoc2N5QUxCb1RJWThGZGFucWs0Z0hhM0NaMG1UQmY3QUVKUHhXYW9S?=
 =?utf-8?B?NlU5SzJYMlFGY0NLWkY4Z2UzN3ZPNS9jSTc5NHM5WFFRVTFDSGJWTU1VU1Nl?=
 =?utf-8?B?UjU4cWdONTN2WTlIS3NwOUlWVE90T1grcy9aTDE4U2RzNllGdnlqUG9zeHdV?=
 =?utf-8?B?SWkwOWpvUHFpa2dVOUpZZ3RrUEdYcDVtcGo2SGJjNWViVThoR1ZVV2RxeFVB?=
 =?utf-8?B?RTJHZFIva3FtU1hGUmNxV21MbndYVnA4amZRNHl3UmxpYXY0YVQ1WGdWM0RX?=
 =?utf-8?B?VGt0MUg2cXVycXFKYlJwWURlamcwWWhhZEtTMnd1d0tiM2czdWxGNGg1ZDIx?=
 =?utf-8?B?d0FPenR2Z1l5b1hEZk5EZEVJOGtzNXV3bUhhRy9wQlNRbDdLbHMyVERVR2d1?=
 =?utf-8?B?aENPMlora0dTNkI1V0hSWmxmUXg1UjRlK2ZHVU1WZkFKUGR4NGlLa01nRm1H?=
 =?utf-8?B?Q2lhVVkzQnZ5UXQzZFUzem5leHdWMitoeGJOcmoxNU9IUUxpQ25rYmdIc2dR?=
 =?utf-8?B?RUw2UG5hd1FETGFqaWdhMU0wYXlRaEk3dXd0RkVCSGVGdmU0UG92bENBT2tz?=
 =?utf-8?B?eXBscCthSUtrRG5qUXNtN1lJcFVMSjVLQjBDNjhUdXJWT3ZydzdodEJxbURM?=
 =?utf-8?B?U3E1ck5qckxaOG1qdXcwMHpvSTR5QTZBRnQxbmphSTZxRllwWGRTR3AvU1JL?=
 =?utf-8?B?WFN6UlkwRHVqdGl0dEJzZUt0MzluUTZiNUcwdmp1bzNQaGFuU1hENXRyMXF6?=
 =?utf-8?B?VXdzNXJ3Qm1CYnJPb0R2Yk02dTF3SnFjUzNDUE5PYVU3b2hhdTV3ZEpzNjRB?=
 =?utf-8?B?WVBKUVJmWG1JU0k1QWpEMVBtSlFnVE02T1lqVnY5U3Mwc21TK0FVNU9pSXRU?=
 =?utf-8?B?cmxjeVNnUm9uMHVYRHFkc0ltbm1rMm1GcHhaTHNqZkl6eE90V1J2M0pxSUJ1?=
 =?utf-8?B?UlcwdCt1dWdyRlFHWWpZWlJnL2NlTEgvNzB2NDhVNlExZ3l6ZG43YmVLZ3Vu?=
 =?utf-8?B?dGxUVWVSZG1wU2pxbHF2TEFFRGVVQU9aY25oWjcxVVR2VUdBVkdXZFgwWHk3?=
 =?utf-8?B?c1BuRFcyaGJLcEl3TCtqQ3hWTmVqR3ZmbmY5NTh1cFFFajcyb0ZrN1BXeklD?=
 =?utf-8?B?bDYzaUJqZGJYQXc5Rk9SYnpBd2xZcmd6TVVDbGpvaDZoSWR6V3Q3STF5Q2NK?=
 =?utf-8?B?S1A3MGNWTzhCWUNVa1dhSUFEelpqY0RTc0dJeW1acWpwNytmRnVLSFFNUVNl?=
 =?utf-8?B?Y2RCTmV0NFhZRHppSVVkNDRhWkd3bCtwb1dQUVVwZHRuTytNU3ZBSllXVVpX?=
 =?utf-8?B?cWlqQzRtZDMzR2txRVpiLzRwSW1SOHY2UjljZFpqVCtYeXB3WFovak9GaDJs?=
 =?utf-8?B?YXo3TWYwM2EwZm9QMmNkNDJaREtJd3R3bVNNRXdDQXYzd0VsNUN6QkZsK1By?=
 =?utf-8?B?RXNCVWdkYy95T0VodFVwQmw2OUZ3TEExdTJiakpMTWZqQ1JSckhPcEJJNm9l?=
 =?utf-8?B?NkVwYUtIWDRSdFhWYnFKaDJzSEQ1eWZYV21QWnRjdC9nMkVzMDB0cWJ4MnVO?=
 =?utf-8?B?S051VUs4Ly9YaFdOazVqbENBRk50VkNSei85T2xFRTVXUVllWlNjR29scVF4?=
 =?utf-8?B?dnRkM01JZDFOUmtrRTBNM3lGL3RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9909A48FACF10468C701F4A04B11AAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LBNE3FbB4J55Ar364b3jiEVmkHDEwGUuy2O7MAwCRb8dZDqGSbvkU1xbB8CRyfXw+N3pa5lDHu3bj4vSb3przm3FpWRzqW3M/ZqGH+FW86kEG8F4J3+6jGheyOmqppOZsJ39ZrLo63ing1eSJfomDELTtp9Bv5I6fAxdi0kl7X0ydQX5q8Z1rVq1+Rk//JW7B3GVN9FeDu3EUsFBMjACdKzIAmhxcRALLzDrU1/KUvGddOQiacaGlEYxVfkNiIAUg66kYmhyaZfnY/Fu1vJZt+70+2+1MMuj3YdruBAxAsiOpR7CwuH9SEedq00ZtT52qdpDntBnSU0aIwTbXChuv5uV/TGQYFidX4Q+J6z7xjpkzQc0jgoOHQ888ITGRhqJjEJZ/MtaL2kf+eIFu9j2lV+4SifsZDssGqiodkPVuwwl5hCffNLT9oB6jj352ugAaXZwb8cAUZ9AEqt7MMlYCUI/v0lXhHpgvKNx9+NeJQqbDSTqECU0NIZahblxlNes29of4pEbf779zCKadt9fTcGRAQKPP4HPQn90xDRZWnuR+xz8wbWYCjg+UfeIgJqL9KcpxiW4yyqMEAtAlrLZarNg0hELl5j9aSxFBSLT/8PdiyISUluoXLwzHuaaHfLG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19b1fd9-3009-4c04-ae15-08dd5fead3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 15:47:12.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+/2SWHP+t7GBd8mx5ecrlo91JSjqlW02n3VmHwoAeC/HclAB5eKeBrfetj022P3olyGas4A6DaXUmpDf19mUnoRgJVKfrsYmqamVD+SkAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623

T24gMTAuMDMuMjUgMDM6NDksIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4gSGkgYWxsLA0KPiAN
Cj4gSSBlbmNvdW50ZXJlZCBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aGlsZSBhdHRlbXB0
aW5nIHRvIGJhbGFuY2UgYQ0KPiBCdHJmcyB2b2x1bWUgdXNpbmcgdGhlIGZvbGxvd2luZyBjb21t
YW5kOg0KPiANCj4gICAgICBzdWRvIGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQx
IC9tZWRpYS9jb2xkDQoNCg0KT0sgSSBuZWVkIHNvbWUgaGVscCByZXByb2R1Y2luZyB0aGlzIGJ1
ZyByZXBvcnQuIE15IGN1cnJlbnQgcmVwcm9kdWNlciBpczoNCg0KbWtmcyAtdCBidHJmcyAvZGV2
L252bWUwbjENCm1vdW50IC9kZXYvbnZtZTBuMSAvbW50DQpkZCBpZj0vZGV2L3VyYW5kb20gb2Y9
L21udC9kYXRhIGJzPTRrIGNvdW50PTMyMDAwDQpidHJmcyBkZXZpY2UgYWRkIC9kZXYvbnZtZTFu
MSAvbW50DQpidHJmcyBiYWxhbmNlIHN0YXJ0IC1tY29udmVydD1yYWlkMSAvbW50Lw0KDQphbmQg
aXQgd29ya3MgYXMgZXhwZWN0ZWQ6DQoNCnZpcnRtZS16bnM6LyAjIG1rZnMgLXQgYnRyZnMgL2Rl
di9udm1lMG4xdmlydG1lLXpuczovICMgbWtmcyAtdCBidHJmcyAvZGV2L252bWUwbjENCmJ0cmZz
LXByb2dzIHY2LjkNClNlZSBodHRwczovL2J0cmZzLnJlYWR0aGVkb2NzLmlvIGZvciBtb3JlIGlu
Zm9ybWF0aW9uLg0KDQpab25lZDogL2Rldi9udm1lMG4xOiBob3N0LW1hbmFnZWQgZGV2aWNlIGRl
dGVjdGVkLCBzZXR0aW5nIHpvbmVkIGZlYXR1cmUNClJlc2V0dGluZyBkZXZpY2Ugem9uZXMgL2Rl
di9udm1lMG4xICg4MCB6b25lcykgLi4uDQpOT1RFOiBzZXZlcmFsIGRlZmF1bHQgc2V0dGluZ3Mg
aGF2ZSBjaGFuZ2VkIGluIHZlcnNpb24gNS4xNSwgcGxlYXNlIG1ha2Ugc3VyZQ0KICAgICAgIHRo
aXMgZG9lcyBub3QgYWZmZWN0IHlvdXIgZGVwbG95bWVudHM6DQogICAgICAgLSBEVVAgZm9yIG1l
dGFkYXRhICgtbSBkdXApDQogICAgICAgLSBlbmFibGVkIG5vLWhvbGVzICgtTyBuby1ob2xlcykN
CiAgICAgICAtIGVuYWJsZWQgZnJlZS1zcGFjZS10cmVlICgtUiBmcmVlLXNwYWNlLXRyZWUpDQoN
CkxhYmVsOiAgICAgICAgICAgICAgKG51bGwpDQpVVUlEOiAgICAgICAgICAgICAgIGUzMDExYzFj
LTllMzEtNDM0MC04ZDdhLTE3ZGU5NTNkMTYyMw0KTm9kZSBzaXplOiAgICAgICAgICAxNjM4NA0K
U2VjdG9yIHNpemU6ICAgICAgICA0MDk2ICAgICAgICAoQ1BVIHBhZ2Ugc2l6ZTogNDA5NikNCkZp
bGVzeXN0ZW0gc2l6ZTogICAgMTAuMDBHaUINCkJsb2NrIGdyb3VwIHByb2ZpbGVzOg0KICAgRGF0
YTogICAgICAgICAgICAgc2luZ2xlICAgICAgICAgIDEyOC4wME1pQg0KICAgTWV0YWRhdGE6ICAg
ICAgICAgRFVQICAgICAgICAgICAgIDEyOC4wME1pQg0KICAgU3lzdGVtOiAgICAgICAgICAgRFVQ
ICAgICAgICAgICAgIDEyOC4wME1pQg0KU1NEIGRldGVjdGVkOiAgICAgICB5ZXMNClpvbmVkIGRl
dmljZTogICAgICAgeWVzDQogICBab25lIHNpemU6ICAgICAgICAxMjguMDBNaUINCkZlYXR1cmVz
OiAgICAgICAgICAgZXh0cmVmLCBza2lubnktbWV0YWRhdGEsIG5vLWhvbGVzLCBmcmVlLXNwYWNl
LXRyZWUsIHpvbmVkDQpDaGVja3N1bTogICAgICAgICAgIGNyYzMyYw0KTnVtYmVyIG9mIGRldmlj
ZXM6ICAxDQpEZXZpY2VzOg0KICAgIElEICAgICAgICBTSVpFICBaT05FUyAgUEFUSA0KICAgICAx
ICAgIDEwLjAwR2lCICAgICA4MCAgL2Rldi9udm1lMG4xDQoNCnZpcnRtZS16bnM6LyAjIG1vdW50
IC9kZXYvbnZtZTBuMSAvbW50DQpbICAgMTMuMzk4OTA3XSBCVFJGUzogZGV2aWNlIGZzaWQgZTMw
MTFjMWMtOWUzMS00MzQwLThkN2EtMTdkZTk1M2QxNjIzIGRldmlkIDEgdHJhbnNpZCA2IC9kZXYv
bnZtZTBuMSAoMjU5OjEpIHNjYW5uZWQgYnkgbW91bnQgKDIwMikNClsgICAxMy40MDA1NjZdIEJU
UkZTIGluZm8gKGRldmljZSBudm1lMG4xKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbSBlMzAx
MWMxYy05ZTMxLTQzNDAtOGQ3YS0xN2RlOTUzZDE2MjMNClsgICAxMy40MDA3NTNdIEJUUkZTIGlu
Zm8gKGRldmljZSBudm1lMG4xKTogdXNpbmcgY3JjMzJjIChjcmMzMmMteDg2KSBjaGVja3N1bSBh
bGdvcml0aG0NClsgICAxMy40MDA5MzddIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xKTogdXNp
bmcgZnJlZS1zcGFjZS10cmVlDQpbICAgMTMuNDA0NTAzXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZt
ZTBuMSk6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UgL2Rldi9udm1lMG4xLCA4MCB6
b25lcyBvZiAxMzQyMTc3MjggYnl0ZXMNClsgICAxMy40MDQ3NTJdIEJUUkZTIGluZm8gKGRldmlj
ZSBudm1lMG4xKTogem9uZWQ6IGFzeW5jIGRpc2NhcmQgaWdub3JlZCBhbmQgZGlzYWJsZWQgZm9y
IHpvbmVkIG1vZGUNClsgICAxMy40MDQ5MzRdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xKTog
em9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZSBzaXplIDEzNDIxNzcyOA0KWyAgIDEzLjQwNjM2
MF0gQlRSRlMgaW5mbyAoZGV2aWNlIG52bWUwbjEpOiBjaGVja2luZyBVVUlEIHRyZWUNCnZpcnRt
ZS16bnM6LyAjIGRkIGlmPS9kZXYvdXJhbmRvbSBvZj0vbW50L2RhdGEgYnM9NGsgY291bnQ9MzIw
MDANCjMyMDAwKzAgcmVjb3JkcyBpbg0KMzIwMDArMCByZWNvcmRzIG91dA0KMTMxMDcyMDAwIGJ5
dGVzICgxMzEgTUIsIDEyNSBNaUIpIGNvcGllZCwgMS41MTE2NiBzLCA4Ni43IE1CL3MNCnZpcnRt
ZS16bnM6LyAjIGJ0cmZzIGRldmljZSBhZGQgL2Rldi9udm1lMW4xIC9tbnQNClJlc2V0dGluZyBk
ZXZpY2Ugem9uZXMgL2Rldi9udm1lMW4xICg4MCB6b25lcykgLi4uDQpbICAgMjEuODM1Mjk3XSBC
VFJGUyBpbmZvIChkZXZpY2UgbnZtZTBuMSk6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZp
Y2UgL2Rldi9udm1lMW4xLCA4MCB6b25lcyBvZiAxMzQyMTc3MjggYnl0ZXMNClsgICAyMS44NDI2
NzldIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xKTogZGlzayBhZGRlZCAvZGV2L252bWUxbjEN
CnZpcnRtZS16bnM6LyAjIGJ0cmZzIGJhbGFuY2Ugc3RhcnQgLW1jb252ZXJ0PXJhaWQxIC9tbnQv
DQpbICAgMjkuNDc4NTIxXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTBuMSk6IGJhbGFuY2U6IHN0
YXJ0IC1tY29udmVydD1yYWlkMSAtc2NvbnZlcnQ9cmFpZDENClsgICAyOS40ODA5NzddIEJUUkZT
IGluZm8gKGRldmljZSBudm1lMG4xKTogcmVsb2NhdGluZyBibG9jayBncm91cCA4MDUzMDYzNjgg
ZmxhZ3MgbWV0YWRhdGF8ZHVwDQpbICAgMjkuNTU5MDY1XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZt
ZTBuMSk6IGZvdW5kIDMgZXh0ZW50cywgc3RhZ2U6IG1vdmUgZGF0YSBleHRlbnRzDQpbICAgMjku
NjcxMTY1XSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTBuMSk6IHJlbG9jYXRpbmcgYmxvY2sgZ3Jv
dXAgNjcxMDg4NjQwIGZsYWdzIHN5c3RlbXxkdXANClsgICAyOS42OTA0MzhdIEJUUkZTIGluZm8g
KGRldmljZSBudm1lMG4xKTogYmFsYW5jZTogZW5kZWQgd2l0aCBzdGF0dXM6IDANCkRvbmUsIGhh
ZCB0byByZWxvY2F0ZSAyIG91dCBvZiAzIGNodW5rcw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg0K
PiBUaGlzIG9jY3VycmVkIG9uIGEgdm9sdW1lIHdpdGggdHdvIEhDNjUwIGRyaXZlcy4gQWZ0ZXIg
dGhlIGVycm9yDQo+IGFwcGVhcmVkLCBJIGF0dGVtcHRlZCB0byB1bm1vdW50IHRoZSB2b2x1bWUs
IHdoaWNoIHRyaWdnZXJlZCBhbm90aGVyDQo+IHdhcm5pbmcgYW5kIGxlZnQgdGhlIHVtb3VudCBj
b21tYW5kIGluIGEgRCBzdGF0ZS4gQSBmb3JjZWQgcmVib290DQo+IHJlc3VsdGVkIGluIHRoZSBz
YW1lIGJhbGFuY2UgZXJyb3IgYW5kIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPiBpbW1lZGlh
dGVseSB1cG9uIHRoZSBhdXRvbWF0aWMgcmVzdW1wdGlvbiBvZiB0aGUgYmFsYW5jZSBvcGVyYXRp
b24uDQo+IA0KPiBUbyByZXN0b3JlIHRoZSB2b2x1bWUgdG8gYSBmdW5jdGlvbmFsIHN0YXRlLCBJ
IHVzZWQgc2tpcF9iYWxhbmNlIHRvDQo+IGNhbmNlbCB0aGUgYmFsYW5jZSBvcGVyYXRpb24gYW5k
IHJldmVydGVkIHRoZSBtZXRhZGF0YSBwcm9maWxlIGJhY2sgdG8NCj4gRFVQLiBIb3dldmVyLCB0
aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHN1Z2dlc3RzIGEgcG90ZW50aWFsIGJ1ZyBpbg0K
PiBCdHJmcy9ab25lZC4NCj4gDQo+IFRoZSBmdWxsIGRtZXNnIGxvZ3MgZm9yIHRoZSAyIGJvb3Rz
IGFyZSBhdmFpbGFibGUgaGVyZToNCj4gaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20va2FydWJvbmly
dS8zYzljMTJiMDZjMDM5ZTc3YWVlM2QxYTgxOGY3YmNhMA0KDQpBcyBmYXIgYXMgSSBzZWUgdGhp
cyBpcyBhIHN0b2NrIEZlZG9yYSA0MSBrZXJuZWwsIGlzIGl0Pw0KDQo+IA0KPiBTeXN0ZW0gZGV0
YWlsczoNCj4gS2VybmVsOiA2LjEzLjUtMjAwLmZjNDEueDg2XzY0DQo+IE91dC1vZi10cmVlIG1v
ZHVsZXM6IG52aWRpYS1vcGVuIChvdXQtb2YtdHJlZSkNCj4gDQo+IFBsZWFzZSBsZXQgbWUga25v
dyBpZiBhbnkgZnVydGhlciBpbmZvcm1hdGlvbiBpcyBuZWVkZWQgdG8gZGlhZ25vc2UgdGhpcyBp
c3N1ZS4NCj4gDQo+IEJlc3QsDQo+IFFpeXUNCj4gDQoNCg==

