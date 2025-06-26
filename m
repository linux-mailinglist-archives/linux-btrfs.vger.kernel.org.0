Return-Path: <linux-btrfs+bounces-14974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8912AE94AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 05:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB871C42D45
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 03:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BF20C48C;
	Thu, 26 Jun 2025 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JwATBaUV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z1tEyKk5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA81C54AF;
	Thu, 26 Jun 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909449; cv=fail; b=c860raaWhiJ2djx7ZzX2B6gDNLNKElD7GS4PTgzIORxnoKGLd15p7o5fgqRhPbbxbHTSTXJX2wogfyEE0v3sZ0iGQk5hWak3zzN1Eay1WzmrQ0b8Wm2QnJVr+Z43k2TPEtHBFZvyHHBkA4TIX5ax/ksg2ft4Jd8zjtaazWEHQws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909449; c=relaxed/simple;
	bh=rV05+IIYj7bhYo8Mczm8TGwXysUOhDQrxN9r0TgdeO8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuY4CRyggbBeE9zZzgeb5vLizf4/NvC12zP2fXK+jNIHwGuyCCwco6ijHOKDOusk9fYvkJz0rw1bIzstRewAA+ujr4YGAfkUvQAoXsooGc7yJ5nk0kDxG23YkrTZYWTTeuw5v6Ztijw1fbBwHBgiLHW+oINqEzPBlu4dFBwWbGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JwATBaUV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z1tEyKk5; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750909446; x=1782445446;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=rV05+IIYj7bhYo8Mczm8TGwXysUOhDQrxN9r0TgdeO8=;
  b=JwATBaUVXkHQXKlpJYxgjumELVy2NKEIEBQvt78F7u1ur/WCIiNeayvh
   h0V5vOy4b9mb7nHNJxUFykBU+q4e9OczlzG28CUy/vGf3ryEhu1iZe+V4
   umS2qlRKEi1/KxEc9w0+x847jIbbigpKZQsekr70SJ9BRz6MTSsSQIVmV
   4U2QqiMfnpLAGeUh7cQjWJ+MPe/TgBJkZbMwV9rb3/v7gg9IBJTpAoTRA
   K9GmuU+BwfATdLpRojAjMPrkaOGCn5RARbtbeAWjuzIjmjkh70L1X5Oa0
   BmIq6uvpPU0uT3BqaATENIzKuO6IOVDFaN/cXW7NAmGq/xnn4c2D8EXfV
   Q==;
X-CSE-ConnectionGUID: qV/vWJ93RVm2bQi+qZnlTA==
X-CSE-MsgGUID: rjqYQj4+SL60P/y4sdq4Ew==
X-IronPort-AV: E=Sophos;i="6.16,266,1744041600"; 
   d="scan'208";a="86001353"
Received: from mail-co1nam11on2070.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.70])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2025 11:44:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVn7dAupUHC/Rpfix/DrWu+C0IncrrIVQDH+LJS546wOmTw6DXAQ9NC8+8wQVKn0Vx/uPQHiWCI4V1wxvOJJT3U4vmlbuTuuJKcO3kq8dKdpKEaoW2kLh12R+EGgh5D6W0BvM7345letuCUlqFZh6oy6ujS4bcIMUa8JT2OFs2OomB3knKPmj0Pg/J1vFQbrUVVCKgjCEJdA5p4eSR+hXkXFLaERthWa4BKoLnSjpIkwWqLUIVbNpWUYK2sfTSVp09+muveYGGMmA076OSoh9lMuCMqZkTti9Mz6Dv135zSWF/QsVm8gAJVtQ+B2FiJ+ELp3SKBx8Rx0o/ctJ8oVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV05+IIYj7bhYo8Mczm8TGwXysUOhDQrxN9r0TgdeO8=;
 b=XLKrZ9GmJ9yV6j5YtiHtrfbnjLh/iUkFmqomZg1v3V8vlLygKTHSSJBWOuO6ogFJpQWso3x/Lw48Qkh/GYaJSUY7Jx09nV66JLhiy/QWFsYoRjS/+vMQe/20xaUBaLYbeEw33AoxUtPs148/K2MzhX/TO5E+pOHxz2wnFE89ozouIFuUdlXj9u2lmeaFpVV0PRYpBQRWfrBjc/8S1QEB9+9sVVR798b6446lgA1vm1UdXbh+MfOZxRDnwjTt+rVU9pv2fd/65DvGs891Rf2p1bwJQ6TpvzjunjiX8YDorE6etARbubcKq8CpnVh8vgUlYSkd6HKldNWEkdeXqTM6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV05+IIYj7bhYo8Mczm8TGwXysUOhDQrxN9r0TgdeO8=;
 b=Z1tEyKk5py4fDLa9Om9gJi7zP6uaQo8YE8VkPx9cmoJJ8qD4jrStMZjmD6I09FiK5QHZoBU2igw5/8pKkXrK6UIiK3rliKnlYADW1N4G/dddzrwkPUmTyiGjvNKQH/kgiyW1eTWtCm6bqHJwEdapAPmvi9ZMgHCKFNS39c1cehg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 03:44:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8857.016; Thu, 26 Jun 2025
 03:44:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: add btrfs support for _small_fs_size_mb()
Thread-Topic: [PATCH] common/rc: add btrfs support for _small_fs_size_mb()
Thread-Index: AQHb5ilqpAuHI6PnFUKGQX15/w2e9bQUzMiA
Date: Thu, 26 Jun 2025 03:44:03 +0000
Message-ID: <DAW5LH8IQXNO.YZNJLR2HIF1J@wdc.com>
References: <20250625232021.69787-1-wqu@suse.com>
In-Reply-To: <20250625232021.69787-1-wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6899:EE_
x-ms-office365-filtering-correlation-id: b49473ce-8d62-490c-6fe8-08ddb463b1da
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDFhVzBUSmdCcEVyQWxCN3NIdG1QN1JVdkE3cTEvck5xeFk0UnMwL3NPckdq?=
 =?utf-8?B?VHNBVXNjUXlPN1dtM09MV0lTUnhscnA3Y2hMdDVjYzlIa1A3WE1HWjZMV1Vi?=
 =?utf-8?B?V094NXhLQVdIbzVPRXBDRGhLendBZDNpZjBOZkZRNElBS3grcm84eUVLeit4?=
 =?utf-8?B?SkFuK2xDMHpIbUVPVDh6cEE4S0lMc1pVallHd2tVOGM5T09JbUJ1dERQVEZD?=
 =?utf-8?B?Ty85d1JTWDcxSld3Z0JyRmdOOHRDaEFWRlJITUUycUd0K2kxN3k2TnVTNkMz?=
 =?utf-8?B?ekcwc0crUHphMDBBVno0RDFvSGxJMGROTFMxb3BMZTEwMk1OdlA1eGJtSmti?=
 =?utf-8?B?TDlWRUQ0TVhzYUp0NFByYUZFUEdZSEFaQk9UZ21pdHFEZXdLWHpHQkcvZTFi?=
 =?utf-8?B?UzFCY0RlMldRM1pRakVpVGZnblI4TUxjcUtITitKYS9Kc1pyUDYvMmRqNXoz?=
 =?utf-8?B?YklYTDYyOFluakFGcnFRdlVLNlpVU1hIVGlqQ2lkaXdrRzdEZE95emVIeVRI?=
 =?utf-8?B?WGNCZnIzVkQ1MmJ1enRoTXpneWZYc2tMSVdXR05DMnpVbzJjMDA3SXUycGlk?=
 =?utf-8?B?anpTRjdmNHk2YXNmcG9ZbU9ybDQ4SnFHR1hqUVpHWm5LdThRRU5zSzZ4WUlV?=
 =?utf-8?B?ZTRsaDhoNFFKbEV5cE1pb2lqandrVEtKYjZHOEszNE16Rk5zMW5HNHUwMDda?=
 =?utf-8?B?SCtXby9rUzRuMUF4bEl5d2JCc1VnNWNQdHlGcERBajA1Nko4NkNaSWJIRkxz?=
 =?utf-8?B?NkhLbW4vR0NFcGZVTXFKNFhXY3h4a3MvZUxWRXF4bXFhMm5VUGRsREFRZVVu?=
 =?utf-8?B?RFJlSzF0cHFCWnh2NzBiajhYMDN4UmJiWEFZZWRuTDdvbjFlVS8vSUVGQlZU?=
 =?utf-8?B?bmhhcjdPaG9JalVKQWhkdHV6S1h5cVdHVHMyY1U0MldKbWZwZjhGMEc2NVlu?=
 =?utf-8?B?NXNVditVc0ljUDc0RGFVYmNzRWNMc0FSdEs4TDhQYW94ZzJDbmRVeWxib3VE?=
 =?utf-8?B?Qk9GNlh1eW96S2NlVEtBN1NPcHZyNk4vZHJMdVpmYU1xd0xDVTllMFEvZTkr?=
 =?utf-8?B?TUNIM29PSWdXbGNCWUh0U1o0ZE5DQ0lHMXE5SUhIM0tYZzduMGNhNTZvT3I2?=
 =?utf-8?B?aVlUdFk1WVhPU1RhZmN6bWtBYS9MZCs3Y1ZJSkcvVWtuak9RVjljS3RzWklE?=
 =?utf-8?B?emREL3lDbHZxRDJVeG8rRTVJeER2RjF6KzdSeHRGMWtuanRsbGJhU0x3L2R4?=
 =?utf-8?B?OUFuU2d3Wko0dnUwMjBMdVIrTkdwaUk2NWx6eWptd05jbzF6YjhUOGt0MDNE?=
 =?utf-8?B?TVFoT01pQzI1Sy9BWnlaSk1DNkxGdXc0bm4vdGs1S2kxb2FtNmpwMFZSd01k?=
 =?utf-8?B?VXJaUTl1WXc3eVY2blNiQ1h2RFdQK3hmZ0I0RUt0ckRmNXE1QXZ4ZUJpRHJY?=
 =?utf-8?B?WTV1RDJJejh0VWJZOGxRWVZuSzJHWUczKzhHQW81Vit5Z3cxdWlVWHZmbjU0?=
 =?utf-8?B?Z245amFUWmtRcFRFRExyTmQ1dUc5WGVsQ3BxMkFGejg5bUYwMTlFaTZ0RTJX?=
 =?utf-8?B?MFBORThmOFd1L3lzRE44TElKaHFOTjhKV0RramprcFVIL2FBYUFFR2hHUENy?=
 =?utf-8?B?VEtBMklFQ3FVVzg5RU94SGtOWExzMmpsbFBvZi9HMm9kemRGN0tnWUg3TDAy?=
 =?utf-8?B?b2RRQldaaWpqNzVxb1FNZWQ1ak1xbTY2SWlvZkZFWTB3S2F4VzJiaVpVYTJz?=
 =?utf-8?B?ZTdhQzZtQ3RyMUNDc00xMWU3YndQNGtBQ09OVzZuZE5QcTJWZ0hoejluZW01?=
 =?utf-8?B?dGk1ZEZ5N2hKSmQ5ejZCejAxc2N1MDhOZFljbFNTd0dqbzBPNXQ0SlBkN1Vm?=
 =?utf-8?B?SVdtZm1ZeHo3NnJRRXVneWxMRDJTMUFVTXJZUHZjTFcvdDY4WCtWWUNGYmR5?=
 =?utf-8?B?MXRmMGt3eUVrcU52NU5pd1lwL3NoKzhXdE1sUlRtdU4yOFNRNXI4MkRQMndV?=
 =?utf-8?B?NktFZTZNaDR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3h5bDFpVHNoaTljbEFyOGFwN1JtbVJmenhxQTNIS1dYYkpCK1V5REVCNEdj?=
 =?utf-8?B?Nm1CUklldktibnBnNkhQdmRPeVZHNjhZRXRtdkQzdzcrS1F3SG9yN0Q2Ymt0?=
 =?utf-8?B?VTlacWZXc29LSHFVY2puUllUVEZsNmZidTZ1QmlTYUdFVERIYUN3R0JnWFdT?=
 =?utf-8?B?cGx1TWxwUWtSd0VTSXlxTFd0SWxBb0Q2WDJDeC9ja0gvOExaaWxNczhBN3RH?=
 =?utf-8?B?WnBsRFc2eFdmVUtNR1JqcTRlVFZtLzhOWDgvTjBvZ1phQ2RaSHVRcC9pY0Iw?=
 =?utf-8?B?L2lhR09XUFo2YWs2NmRyMFdCZUFTNldaNU1hZDBNMXdnU2lpd1AyeURST0xR?=
 =?utf-8?B?YlkrdVZzOURDbEFRQ2JhWHFJa1pnMjFSSzR4VnVGUVExcVpBb1RYbFRZbXNL?=
 =?utf-8?B?cnJKT0F5VWFKNWRBdVIvUy9oT2paVkduUXkyNFI5eTMrUzNZR1o1RzlCdXMv?=
 =?utf-8?B?eVJHWEMwQXorKzNjY1Ftc05QRTR1TDhZSnR6amZGeFhNa2FjdHlPS2xGMTg1?=
 =?utf-8?B?ZGRxc29xWFRQejEzVnVlMTlmdUFXU0JHZUxYYUF4WEowdGZOZTdsWUdWcG40?=
 =?utf-8?B?ZXFpSkhHZU5GOWVrRGN5WC9WRmhZTmJJT3NRR2hka3JTV2E0Y0JUQlRFd2F1?=
 =?utf-8?B?aEZjdHNBTjRsb0xxNTNQZFk1SThPZXhEMGRzSFhPbmI4ZGpBanBaaWF2dUZo?=
 =?utf-8?B?TnJxRHo1bEszVS8wMHVhV1piL3g5REFCMElJTzRRcjhtY2tuTFdjT0NOamJU?=
 =?utf-8?B?NmNLai82Y25hY0tvUks4M0F3c0ZWaFoydmY0L3Izb3o4YnZYR3FNdTUrMGhF?=
 =?utf-8?B?eE1CcUFjazEvYzltSjRXSU5YVGNIVEVyNTYwTk1Ya2ZKYmNwQ21NY2JYeVQx?=
 =?utf-8?B?ek8yTlhDZlQ1Unkyd2tqRE1HRmZPczJKcGpsTjlaS2hTWGF1ZEhNL21hT2Zy?=
 =?utf-8?B?aVBPaW4zS29zak1OVXJpVU80clU4cGt5clFRSzA3eDk1UjJwQUpVR1NQc3hM?=
 =?utf-8?B?NDFRWGw5M3pnVFhGU21UZVp4TURUbHR1NCtoT1QvSzkyU3l1MGhGemxPNUhi?=
 =?utf-8?B?U0VrU1VQWWZ2SHBpeFZkWWJyWWgzUTRxdnlWNlYycGRsS21ocGdvNUlNSENv?=
 =?utf-8?B?emVuVytQZ1NRVjRFdlJMWFNBSWM0R3EvTFZxU2l1YmdMRStwbGYxNGZGdlRi?=
 =?utf-8?B?WFBock9ZMDlTVDFnSzhUMEJyNDN2OHloWGUxOVdsMUg5RmdyYURsQ3lZSHZ2?=
 =?utf-8?B?a3J0c1BBeitsZWcrNWZLMlpWOHhhc3FnK0oyZ3VhaUQ5enpUbXhST1lGK1lS?=
 =?utf-8?B?WjJaRm1pdWdDRXVjN3REZzBuZDRNdGJFdndyeUJhZlFUUFRITC9KVnNXVHdX?=
 =?utf-8?B?Rk03MHczTS9OU2hqS0xjcmcwcE53N1pBclpxblBqSkJ1SkZuUlRRWVF1ZWVK?=
 =?utf-8?B?TkNWdlF4eDdqVHNBK0NqeXcrYjA0ZTVzMTdnYnNvYUtPNGNxSTUyMWNoZVhY?=
 =?utf-8?B?QS85T1ZkRk5WcnczRUE3WnYrR1pOcklubjQxamhod1hSeHI3azU5SGgwUHNZ?=
 =?utf-8?B?cmZmdCtpQk4wcHVvNURxRytQQjNJb0pEY2lYTVRkc2JuQ2pNaGd1RHpaY0Zl?=
 =?utf-8?B?eGcxZE05ZmZYZnVTQkUvdDdMNkJobVpOdGd6Q3VBQ3l5VHpURDVHdDlaM1BE?=
 =?utf-8?B?dWlpSHBiUG1XM0NFV0pxQzJoWWRIdkZmYnc1MG1DVmwrSmN2UTFUNmV4Z3c4?=
 =?utf-8?B?VVIzYUZhN2pKS0x5d2FldEhmWkora0ZZWGM3RGFVNVFyNmxIbVc2WVRFdGNq?=
 =?utf-8?B?aHlTUElrNXpPVXl0cXBlTmhkelo4eldFQmR4MFh0dzBoZHEweFZFWXgxbUJF?=
 =?utf-8?B?cEhhK1hYcjd1YnRtMTVGODc2RUEzWVllQ3hBNElqSVcwU0syck5Zc09nYmh3?=
 =?utf-8?B?N3BnMElGMnd2MFpvTXM3YTc3aXcvc0ZwaHQzTklPb2dYSFYxSE0yM0E3b3Bx?=
 =?utf-8?B?d0JwNFZyT0ppT25iaUtwVFVRRzBaK0VVREdEdkJxYjEwZDJCeEpZUWgycWMv?=
 =?utf-8?B?RXJlVXVvakRyd0JOYWNEVzdsS2lOOUJNbXNrSkdFdTRkanh3MzI4K0FwL3BW?=
 =?utf-8?B?cDBEOEFnTmU5YU1OQlJNcVkza2d4VFVpZEhaVmgwd3l1VVZvb0F6ZVplMk1G?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9728E4A7698B9469848336D71BB67D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fb+thMW9lW2pf/d+mc5farU++OzHoiUzwLes7yuaYODfubxEINVsxibIJFvMEdIX21ynzVDFoTBaYb9Ku1UbGNsAGEUH8WfPFzFT+AXXYgdj8cy/v1GbJxFEMwhLDdYUsjkimhl9Fs2yDZTP7PQU7AVPpWlGcCuTkCclHhjStcz7izrLCQA8sDZUeYtV82pQaDnikXVx3TvrBAP5yfe4z14XHjw+OPxk7+K9NzMzgp/6sYclC7mHR6OT4DM6ccdv9hvIYdYYY5VOHsMnBbkrCOgNl2j7aNOkgD+bm9EGRnQD2nuiu5jCMxNipTkF2Uu4OaUdVFqo2xiyzCpuQpWSG2KV3AlYjvJJXm2O1gIhZMd5eFLByMtuhrrXGmWrv6WrpktMU+eipxSBj+5sgV1b4+e4ijImRe1L5mtb/I/H98gG1MKSs8BEP0gvYqpsPwXLEd+2ekKkHiWIGpChK7DYSvq4vIzruWNGls7grfDEKGdRlb19fN4jl8HpEHqHFPvOFXex2Jid0E6CbBFkY35VR1sM8TSf3Okn14dwh3UDCEUqSr3Rnn8t6FDR31Z2WrT/kHTsTFB1qojQmEPnsyl0mOLH4rutcOYmFqvl+o2xTc+tY98gEHCZj3dS0fGe4fZZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49473ce-8d62-490c-6fe8-08ddb463b1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 03:44:03.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XukcvDDEhPOZWroFa3IO7sVheo6d/KCQIA+VITWgKiplBupeNoEygVTgac3SPPCzUvgKdedVbe4gESxomvgeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899

T24gVGh1IEp1biAyNiwgMjAyNSBhdCA4OjIwIEFNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPiBb
RkFJTFVSRV0NCj4gV2l0aCB0aGUgaW5jb21pbmcgc2h1dGRvd24gaW9jdGwgYW5kIHJlbW92ZV9i
ZGV2IGNhbGxiYWNrIHN1cHBvcnQsIGJ0cmZzDQo+IGlzIGFibGUgdG8gcnVuIHRoZSBzaHV0ZG93
biBncm91cC4NCj4NCj4gSG93ZXZlciB0ZXN0IGNhc2UgbGlrZSBnZW5lcmljLzA0MiBmYWlscyBv
biBidHJmczoNCj4NCj4gZ2VuZXJpYy8wNDIgOXMgLi4uIFtmYWlsZWQsIGV4aXQgc3RhdHVzIDFd
LSBvdXRwdXQgbWlzbWF0Y2ggKHNlZSAvaG9tZS9hZGFtL3hmc3Rlc3RzL3Jlc3VsdHMvL2dlbmVy
aWMvMDQyLm91dC5iYWQpDQo+ICAgICAtLS0gdGVzdHMvZ2VuZXJpYy8wNDIub3V0CTIwMjItMDUt
MTEgMTE6MjU6MzAuNzYzMzMzMzMxICswOTMwDQo+ICAgICArKysgL2hvbWUvYWRhbS94ZnN0ZXN0
cy9yZXN1bHRzLy9nZW5lcmljLzA0Mi5vdXQuYmFkCTIwMjUtMDYtMjYgMDg6NDM6NTYuMDc4NTA5
NDUyICswOTMwDQo+ICAgICBAQCAtMSwxMCArMSBAQA0KPiAgICAgIFFBIG91dHB1dCBjcmVhdGVk
IGJ5IDA0Mg0KPiAgICAgLWZhbGxvYyAtaw0KPiAgICAgLXdyb3RlIDY1NTM2LzY1NTM2IGJ5dGVz
IGF0IG9mZnNldCAwDQo+ICAgICAtWFhYIEJ5dGVzLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZ
WS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KPiAgICAgLWZwdW5jaA0KPiAgICAgLXdyb3RlIDY1NTM2
LzY1NTM2IGJ5dGVzIGF0IG9mZnNldCAwDQo+ICAgICAtWFhYIEJ5dGVzLCBYIG9wczsgWFg6WFg6
WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KPiAgICAgLi4uDQo+ICAgICAoUnVu
ICdkaWZmIC11IC9ob21lL2FkYW0veGZzdGVzdHMvdGVzdHMvZ2VuZXJpYy8wNDIub3V0IC9ob21l
L2FkYW0veGZzdGVzdHMvcmVzdWx0cy8vZ2VuZXJpYy8wNDIub3V0LmJhZCcgIHRvIHNlZSB0aGUg
ZW50aXJlIGRpZmYpDQo+IFJhbjogZ2VuZXJpYy8wNDINCj4gRmFpbHVyZXM6IGdlbmVyaWMvMDQy
DQo+IEZhaWxlZCAxIG9mIDEgdGVzdHMNCj4NCj4gW0NBVVNFXQ0KPiBUaGUgZnVsbCBvdXRwdXQg
c2hvd3MgdGhlIHJlYXNvbiBkaXJlY3RseToNCj4NCj4gICBFUlJPUjogJy9tbnQvc2NyYXRjaC8w
NDIuaW1nJyBpcyB0b28gc21hbGwgdG8gbWFrZSBhIHVzYWJsZSBmaWxlc3lzdGVtDQo+ICAgRVJS
T1I6IG1pbmltdW0gc2l6ZSBmb3IgZWFjaCBidHJmcyBkZXZpY2UgaXMgMTE0Mjk0Nzg0DQo+DQo+
IEFuZCB0aGUgaGVscGVyIF9zbWFsbF9mc19zaXplX21iKCkgZG9lc24ndCBzdXBwb3J0IGJ0cmZz
LCB0aHVzIHRoZSBzbWFsbA0KPiAyNU0gZmlsZSBpcyBub3QgbGFyZ2UgZW5vdWdoIHRvIHN1cHBv
cnQgYSBidHJmcy4NCj4NCj4gW0ZJWF0NCj4gRml4IHRoZSBmYWxzZSBhbGVydCBieSBhZGRpbmcg
YnRyZnMgc3VwcG9ydCBpbiBfc21hbGxfZnNfc2l6ZV9tYigpLg0KPg0KPiBUaGUgYnRyZnMgbWlu
aW1hbCBzaXplIGlzIGRlcGVuZGluZyBvbiB0aGUgcHJvZmlsZXMgZXZlbiBvbiBhIHNpbmdsZQ0K
PiBkZXZpY2UsIGUuZy4gRFVQIGRhdGEgd2lsbCBjb3N0IGV4dHJhIHNwYWNlLg0KPg0KPiBTbyBo
ZXJlIHdlIGdvIHNhZmUgYnkgdXNpbmcgNTEyTWlCIGFzIHRoZSBtaW5pbWFsIHNpemUgZm9yIGJ0
cmZzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gLS0t
DQo+ICBjb21tb24vcmMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8u
YW90YUB3ZGMuY29tPg0KDQo+DQo+IGRpZmYgLS1naXQgYS9jb21tb24vcmMgYi9jb21tb24vcmMN
Cj4gaW5kZXggZDhlZTgzMjguLjJkOGU3MTY3IDEwMDY0NA0KPiAtLS0gYS9jb21tb24vcmMNCj4g
KysrIGIvY29tbW9uL3JjDQo+IEBAIC0xMTk1LDYgKzExOTUsMTEgQEAgX3NtYWxsX2ZzX3NpemVf
bWIoKQ0KPiAgCQkjIGl0IHdpbGwgY2hhbmdlIGFnYWluLiBTbyBqdXN0IHNldCBpdCAxMjhNLg0K
PiAgCQlmc19taW5fc2l6ZT0xMjgNCj4gIAkJOzsNCj4gKwlidHJmcykNCj4gKwkJIyBNaW5pbWFs
IGJ0cmZzIHNpemUgZGVwZW5kcyBvbiB0aGUgcHJvZmlsZXMsIGZvciBzaW5nbGUgZGV2aWNlDQo+
ICsJCSMgY2FzZSwgNTEyTSBzaG91bGQgYmUgZW5vdWdoLg0KPiArCQlmc19taW5fc2l6ZT01MTIN
Cj4gKwkJOzsNCj4gIAllc2FjDQo+ICAJKCggc2l6ZSA8IGZzX21pbl9zaXplICkpICYmIHNpemU9
IiRmc19taW5fc2l6ZSINCj4gIA0K

