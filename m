Return-Path: <linux-btrfs+bounces-10340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA39F0583
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D3018851E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7476197A9F;
	Fri, 13 Dec 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hbYneYcX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eR1rUi3Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888C3207
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075041; cv=fail; b=n+5Nh/QL23oGiTP4PxjYNSiQP2wPPg0zFqU/eH+935FouWcO1HNsD+XagutQi2CXSKasp/SFVDQT8jGO57mPEsCaj3Ce6p0Qej3ITsnM2IylHYpzqw1kjJQYIFYm+Fd7Ku9BkpuPH97zFxuFTCR7twdfpegRBgNUZEGssJ+N/A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075041; c=relaxed/simple;
	bh=60mcTHd3bl0RCZr0r8DURyw6Gf2Tf2CyDvIwAgeTz8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJXuQE32igv492wl+a7zJ8rRiscu1aMVpbq7oSBRcrrFveB3Qp3Rlh0VD5XvvOa846JnXPA5BVihJ1drCsL2k25v76CBWwOwtKNLULEx5UVBHhvdSj+VeBne87UQvG3a4mSImZ/q+dKx5BA86yPaOmjzTLV3c32HjgzY1JOunuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hbYneYcX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eR1rUi3Y; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734075040; x=1765611040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=60mcTHd3bl0RCZr0r8DURyw6Gf2Tf2CyDvIwAgeTz8c=;
  b=hbYneYcXjuaFsirpvIjxQmiKV7+4BqWII3sDmcYHTc2zK8lDhGc8/GBQ
   3zTxIQ2hqQ+/Vy/kkx6hD0B4Ucp4Srcbwrc939K21oI3Jd5EcHgluoW0E
   JBjRAUqK7dYkAfEz3Z+kHNeUeRoulxvYGdqqus3VbaQn95QvaQIo4F1eQ
   GkL+5VsEFUuRqHgfpn8bVuHeFmBrxhYEUlsTsMSQMokzplSmtVA75svUl
   VI6idHiYwl7neqRXCHYDl8/5C99ix/q/Cx1XV7xlX8gFYZJZAg1bzNJcA
   eqxqgkRrIUB24wEpoXkVIJl8nDS/1VgJtrbJ/LIZXjrz94dIzgDdwH5vE
   A==;
X-CSE-ConnectionGUID: 7Mk0SpecSju0tDFHs45Glw==
X-CSE-MsgGUID: l4+sWJNEQK681wuvoCB/4A==
X-IronPort-AV: E=Sophos;i="6.12,230,1728921600"; 
   d="scan'208";a="33595338"
Received: from mail-northcentralusazlp17010006.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.6])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2024 15:30:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+vKyt5PE/CQFHXY4rEtUoAKaXdp+Ymqze1+6NCBYLSrV91J2vzDn+J+hv1fjqKwj9xF7Y+pXRA/7ELyqjpfZgq/JFyV6+VNiHjy4DIdRMXWp598wujuwB3nrPt4tryZ5bQu7rEYh17qS/l5nyjvFeC3t02FrjAU5TqNb7vNRUVwm4p2RkdRcm0cBdNNGbjN/uM50OaaUnd3MFNy3xQPn6P1uWiZs1TN5zYLqxh2yX677GsNnD9bdjKVQ82dU1VqZL1Vize2zP5DPOR1rVzGEYe8CAiU/ZHRBIe0I3P7YsW/xGz38LDapFZNC8hlkM9bZWPFoHsQ2Vq8rkjhQ1RPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60mcTHd3bl0RCZr0r8DURyw6Gf2Tf2CyDvIwAgeTz8c=;
 b=O6NTDVdjFnFLqbVn0IS+/28/h8tLPhZYzUa61vG7mPyOgYmoCK1vAY9cYD7wNkj8nnKZng8/H0ZwH50UDSjuOI/T8DjwILATlkMVVndUe/g2ZNdsaBP0Mo8WS9rJRThHNt3njhUe7IMwnAIQGrH/oLoT/UGyVQnCCXa3dYvtgUqQkXTDBp3a+o+tIxSEYAgun/0dPu0JRJmzP1SEDQB7yaHNHuTbByOs8sAY3Vg6EROunQWcj0TOgD7HdpGzfVm1JS7W8mc56D7HrkbWu7PFE+8XM5M3L2lIK7BQG+/KKlN/FH6Nms3oKfNaFVIZr4iEvTErKB+sR1YAhE9PclMzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60mcTHd3bl0RCZr0r8DURyw6Gf2Tf2CyDvIwAgeTz8c=;
 b=eR1rUi3YPDOqZujF6hMMQAVduHShruRbqsBhqZ6xKno2NW4MBUW25YKWBshzfmpdH8+Hk2bAx0aAczZRtRztJA+7qdLTJ9KOGYM4S6oMt+vkOcDy9YX1nzXKpk0CJI4wEKTMvhh6E3MWNRFOXHyJBy/JOoYZaHaovZ7AktO1rXU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 07:30:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:30:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "Roger L. Beckermeyer III"
	<beckerlee3@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
Thread-Topic: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
Thread-Index: AQHbTNTcgj6NVUxbZUGDO2hbQy4kObLjtDcAgAAT64A=
Date: Fri, 13 Dec 2024 07:30:35 +0000
Message-ID: <fe2b0dfb-1b3b-4e98-8c81-b4dc98af59cf@wdc.com>
References: <cover.1734033142.git.beckerlee3@gmail.com>
 <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
 <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com>
In-Reply-To: <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6546:EE_
x-ms-office365-filtering-correlation-id: 44289721-ccc2-4f96-9793-08dd1b4808d0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFZQRmRGUGEwQTEzUG1KdEttWWZhdnNIVVluUDVMamI5WDA5ZjFGSUdzNXZC?=
 =?utf-8?B?UUxZVmk1amg5RnpzaW1LVXNaMng1WjZLOEh1MWY3cW5xQ01yN2l1ZVVQOTJL?=
 =?utf-8?B?TjNobkdnbDFFeWpsbmVBSlo0bFhvV3N6WjEwM0RFdDdhSkxDYytSdG02VHVO?=
 =?utf-8?B?dHh0QTRVREpRa3cxMGFHWmowVGFLZko3emNVZU1YQ2tVK1Q1NDArWFlVU0lw?=
 =?utf-8?B?MGpEQmRxOFVGdkVBMXF1cFg4RHFVNkJJVDhOVEdOVVppMzFibzVEUno0UWIy?=
 =?utf-8?B?dlNUclg5Wm83cmYvNmEzOE9RVjdGeURYRyticUtCYmphZkhrbVRXSk5NUGQ5?=
 =?utf-8?B?K3pkYk9VOEhITXM3VjliYUpxWFJrUHRkWEpsY0Q4TlVWeWdCTkNqb0h6eWh3?=
 =?utf-8?B?ZER1NHRSclVsbHdGODBQeTZ1NndRQnZmRmNmYml3OXNhcFprZWgybTZHV1VS?=
 =?utf-8?B?ZWt4ZjJCdEw4dVM5OC9MVCt2bTYwMUxTczdjSTBwR0I3WTJ0VWM0dDcyRXM1?=
 =?utf-8?B?cloyak9LYzhZUEFUeU1BKzlZckdqclBVckh6cFZ0NVZPSFlZeXozMFNiM3Ny?=
 =?utf-8?B?WU1VWC96VDNjMzZJaitmQUdVMnQzUnNIUW1FL3NLd0xRLzR2UUo4QjNiaU1X?=
 =?utf-8?B?dW9DcnNoUkZBajQzb3pMWUtBZ2QwVVJLb29zcS9wbnJLUlpUaEZWMi9HQ0NZ?=
 =?utf-8?B?UGtVZURZUHVQUFlGNmxXRG84b0V4aStZWi9NUjM0MXFYNkFtUTJjV2p1aUNk?=
 =?utf-8?B?cVk2RzlsSUZkWXJZdVU3RlJMYWwwbW13d1J3VTZIdVpCS3M3bERDVDg3a1Zs?=
 =?utf-8?B?STIwaElHalMrcGZJS0UyOWlkZkQvcVBnTCtKUE5CS3BIYWtkbHZSNmtsbEZZ?=
 =?utf-8?B?Y0VKMmtzbWFsWXQ0dk0vdHRHZDROSjZHNENlZ2kvcVd5NmJxOVhBaEpUUDVv?=
 =?utf-8?B?MnVkSzBhZ3dBVmQ4SlNxcmFWbkh2V09GWUJQTlZBMTJRTW5LUUtxeURhVkpW?=
 =?utf-8?B?Q0RqYUg1aXR0TW9SQTZtSG93eFN5emVKbldWTUQvWURWcVBiMnAxWllSN0Qv?=
 =?utf-8?B?L0Nod0RCcmlpbEtHVlMxbVJhTlRoaDQzekN2ZEMyV2kyQTZHZkJSLzljbWFY?=
 =?utf-8?B?akdMS0hQZ1JMWmFYT0h2blNDNjhFQUFWSnMzcE5mTGRpNmhCWTQwVzl4NVZj?=
 =?utf-8?B?cUlrOFFpd2VIcDdyeDJ6NDlzL0owUTlSOVFYSFFpYW5zdVZHaDY0MklENC9q?=
 =?utf-8?B?M3YyWXdxQ0tNYTR2U2U2QUo5b3REQU8vankwSGkrblpodE5oeVpJN002MGZx?=
 =?utf-8?B?czl2bkRxQVpNMFNSVExDT0xKQ3J1eU1FUENIbFowNjVOOTJucmQ2US9hSU9U?=
 =?utf-8?B?cVI3aFBHYW0xMWRqbjJ4dUpQMDk4c08yeHdlS09TMWFnT01sbHMreWZKQ0dI?=
 =?utf-8?B?UzlwM1dQd3RMT0ZydTF2UVgwcXJnVnBxK1VkMURueEFJZGNvMVNrbkplcjEy?=
 =?utf-8?B?Rm9xUVU0YW5WZ3ZBNnFPdGhzZVBMQU1Yb1ZOb3poMUVYb3o5L3VrRGFEcUYw?=
 =?utf-8?B?L1kraUlYWTdvbVRUSEZRbzdQZm9DcFYrVzFCOEFXSm42UVFXQmZtVVJqVmU2?=
 =?utf-8?B?Ukwxd0JPZXpsWDNDN1BOM3ZOOUpqTDJlQmxjSW96WE1FWTg4VEpNUlZNQUs2?=
 =?utf-8?B?dnhkeVkxckJZVGQ0SzF0VXlNYmljRy9oQWpGRHZPM005bXV6eEZsRXdiZ2pz?=
 =?utf-8?B?V3liUTkyeUNON0lrWndET3BVUUhHaUlpT3ZyUWJXTTArMDB2Y3RQRjRjMjdp?=
 =?utf-8?B?Z3FQSnozd1dXNDEzWWwyQkRoL3IvYit6ckpmd1dQTE00VUYwRUJHT3dsUnFT?=
 =?utf-8?B?ZUxxTHZ6VzRVanBQUFBnVlJkelBaZnQ1ZXJpYnJmVCtBY2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THovUGdTWTJ0ZFFzSEtDd05WTElGL09venFXTVFZVmhldnE0MDMwZ3ZqWFE0?=
 =?utf-8?B?aGVNcHlRTGViL3VYZDdGTklDUnpaSk1qMk5LUzBsbndPSHVLR0dlaVIzMXRq?=
 =?utf-8?B?bGNlN0Uxczl1Qm1sNkgwbWZteS9aajZ0RVJreDhadnA3anR2eE12clNIMEdJ?=
 =?utf-8?B?Ky9CeU5KUkdPc2l4MkVsL3pYZmpMQW5BOEp6YWUrbmJDU3BLamdIeFQzWFpQ?=
 =?utf-8?B?eU5qa0FLNDFLcXNPQkZUVFFGay9JdFVBREwrQ1VsNnFvQ2ViNDIyd1UzYlVG?=
 =?utf-8?B?TVNWbElndW9MdE11eE5ySFJsVEx1WExPYmdpcld3VFozb2ppMTFMNlF5YnBK?=
 =?utf-8?B?bzlaRllxc252eDFJcXJDVDlmdHZRd3pvVk80VVlRNVJvYlJSMzNHWkdwcENv?=
 =?utf-8?B?TXVTZ0pSTVVvYlBJVWNZTXloK2RxcWkrYUw1ZkRyOE05SndQdzFqYjNqZnV2?=
 =?utf-8?B?LzA4TWNOQk4xdmpKRnVqZUd6cFY5bUx1SFJhVllOQVE2TWJPWlVIcGROWElU?=
 =?utf-8?B?NkJ0SmQzM1lMZlRaNTNGWGtYQm1ON2lTWEk2UmpRTkJWUHl4N1pJaWJKQ2RM?=
 =?utf-8?B?NzYzSENxaXJwWlB1eDhUSVZBZkhMWERRZ1ZjTzBSZjhMRm9BTFU5NzhBcFF4?=
 =?utf-8?B?aGdpT3RtMFJMYnYzMEUyYmF3SXc3aGQzcWJZNzRtZmpGeG5DS0pweUtKMnNl?=
 =?utf-8?B?RkQyK2dpRS9zSEduTy9DelRQSFhxZFVtSi96RzVSajJDYVNlQ1lYMm5uMUZ2?=
 =?utf-8?B?a1JkWkIwYTExelU0MmM5MG1zNUpONVBUUWVsbFQ5aVZYcXBVQlcrY3djUEJu?=
 =?utf-8?B?Q0lqcUROelZoaWFxK1pQOUlMTXhIcml3aEM2aklybk9JekRUU0RQSXlsQUYw?=
 =?utf-8?B?cHdLSmZXcmIzUUhRQkV5Ti90QWtIdERuL1dMeThZdjN0bWM2c1V5aEs4UWtp?=
 =?utf-8?B?RnNocUJUNGFRaTNxY3FpMzRMcXl6YmZOcXpaUC9xeUtUV3UvS3Vob09hNFQ0?=
 =?utf-8?B?dlIwbXdSdFptdG44VXRQWXE1aW11SFJWeHRRbmttbVoxaTJxMjZEalNQNWxC?=
 =?utf-8?B?alQ5Z0NnSUFqNWNseU5GSGxrRjZuZkFCY2Y5Y2Ewb1hiWU9BUWh3cENlTHpt?=
 =?utf-8?B?ZU1NaldBV0s0NTFMM1EwS0U5SDdkMDhwcTl5UkFFSUZpd3huMGFOd2xsdmMv?=
 =?utf-8?B?QWZMVlRXMUwxMDc3ZFkxR2RUZERmbG9qejBZM0V3ekhmQjBTSzhMaG9OYkRt?=
 =?utf-8?B?SHZvVDJDWjZFK0RaSGMrd2dSNElDYkZDaHYzUnNhQ1prZEdmMXFDTmxSQyt2?=
 =?utf-8?B?SVNvMGJrUzFDNERPV003WmV6L2ZVR0pFaWRlZmY4dkVSU0lsTGdrMXV5enRQ?=
 =?utf-8?B?UjVsUUlNUlNLdDZybHNKdm1ZYXlFTDJjQU9xVW9Ybm54aUdDYjlSaldSL1g1?=
 =?utf-8?B?UzhWdllDSWVvb0UzUG0xZVJRREgweE0yb2JsUmY3aTRzbjhZZFlOVW42S0xh?=
 =?utf-8?B?NDA4Q3lwS2VZRlVmUXY4ZjBrb2JFMCtWbTYvSktYcHlqRGxrNng4WmFEZnlw?=
 =?utf-8?B?OHJoSTExNVNRQ01HSWsyMFpxRjhiUWwwdTRsdyt6ZmpHZVp0b0RBY2pYNU8x?=
 =?utf-8?B?ZXZ0Y2p5Z2RXUGhMQmZQRDBscm8reWdqZXBVWEFZSDhZNjQweWNKL1F6cmIv?=
 =?utf-8?B?UGNrZURPTzNYQ2E4aU54ZjBiTWduWjhieTJLOTEzaFRLbTJoeWlxZFVvWmxo?=
 =?utf-8?B?VmFmUlIvVnNOelM5bXpWYm8xK3ZKTlJhRFBrR3pRRmx2M0RhNjA1TzR5Y3JE?=
 =?utf-8?B?ZUNQQlhpd3lXTzlwNW95Tm9GSU8yR1J5YSt2cThqUTVpSkREdlo3Vk80VDdR?=
 =?utf-8?B?UGVGRlB1Y2U0cWVFTE00eVkvSVBUTmd5dERycVVTOHlVSmxGYm9ETzF6WlZK?=
 =?utf-8?B?ZVBiMWh6ZWxkdE9Wdjd1Q0RSdUhQVTZuSkJoVy9wcHN4cFNHUWFXMHBJUSt4?=
 =?utf-8?B?T2dPZVlpcHNIYWNyZEg1NVI3cndaVVFleDZReEY3aGViZGJEek5rb2NrK0pq?=
 =?utf-8?B?NlZMVEtJbVpFWGhnMlJFN0JZN0pKVVAxMFFYNG51aXkwRWJMSDI3VGQ3dU53?=
 =?utf-8?B?WjVmQlhJRWtTVUhPTlBtUTJhUzdNMjAxSTZmSVJPR1N4S1VYRlROb0tBcGNi?=
 =?utf-8?Q?zOdDcFqq2zGgQZecqPilDgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66945A94A1EEAF4DA52FD4B53EAA3B20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PhE6eLBpd3jQ+wJ13ci4V2Dsmae9jX3Mh4ONlgIUm0vjcQcC5TZTC3VN7C7xw5t20wTVgF/Y8vFiOEJj6kX6fyq12A2eQSDPeFDQBoGLJR2vT/qvT5+qg5ppvTUCOX4ATj+bIXacpJaE3oDOUayixt2wrtlMZh7izZq5G5KFh25+OiunU0SKDMe4qQk6472nn3B/BfMS3tiy5Pmdypj52DuG2Tm2E4ks9jrJWGRDhrZPYF/2QPZuD1gbql+K/1Irdtb3AkZwdKScGWdn9jbrMvOHQC0I441608ZAm38CqUHS2lISv2TbjhYdq1EJoFTFEowj3KwSuo3GCjloUWoNTcn5se4GDGoL2vun0RpwKEKhI2IMoIbz9MoeCI+rEWcEP/To6oXyMoYK2RRLIHaLAIivT8+9mEtnnXCuWxZEcMhNrJNNlld0urw4+txQyGc3kjQN5A40Io1Vq+6V+CH2aVI2pMFJ5C0U8JUDa4XGCUw1up6pDEzMssZN+EUp12kpGCAwf8cGBnnHG4f2Alnt45cs9+XJkxtrSZ1Wn2/5OEg5BU+UoSpp/TnTR6lOM2FZCqfDMQS0Y2BkujWsZKRr0DgY1nszIvXdxI+le8nGGzJt0JtmBT40QDYdDIRUYOui
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44289721-ccc2-4f96-9793-08dd1b4808d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 07:30:35.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUx7kCVGOiKAupYzcQTdK9p3XpUt9Eft1BgwGwBgz4DA7+eJW121Ln2xZV+pPojAJvPUB5F86O1KvU3zA0YCl8/oVDtCWhNX53y15cG/phw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546

T24gMTMuMTIuMjQgMDc6MTksIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC8x
Mi8xMyAwNjo1OSwgUm9nZXIgTC4gQmVja2VybWV5ZXIgSUlJIOWGmemBkzoNCj4+IHVwZGF0ZSB0
cmVlX2luc2VydCgpIHRvIHVzZSByYl9maW5kX2FkZF9jYWNoZWQoKS4NCj4+IGFkZCBjbXBfcmVm
c19ub2RlIGluIHJiX2ZpbmRfYWRkX2NhY2hlZCgpIHRvIGNvbXBhcmUuDQo+Pg0KPj4gbm90ZTog
SSB0aGluayBzb21lIG9mIGNvbXBhcmlzb24gZnVuY3Rpb25zIGNvdWxkIGJlIGZ1cnRoZXIgcmVm
aW5lZC4NCj4+DQo+PiBWMjogaW5jb3Jwb3JhdGVkIGNoYW5nZXMgZnJvbSBGaWxpcGUgTWFuYW5h
DQo+IA0KPiBGaXJzdGx5IGNoYW5nZWxvZyBzaG91bGQgbm90IGJlIHBhcnQgb2YgdGhlIGNvbW1p
dCBtZXNzYWdlLiBJdCBzaG91bGQgYmUNCj4gYWZ0ZXIgdGhlICItLS0iIGxpbmUgc28gdGhhdCBn
aXQtYW0gd2lsbCBkcm9wIGl0IHdoZW4gYXBwbHlpbmcuDQo+IA0KPiBTZWNvbmRseSBpZiB5b3Un
cmUgdXBkYXRpbmcgYSBzZXJpZXMgb2YgcGF0Y2hlcywgcGxlYXNlIHJlc2VuZCB0aGUgd2hvbGUN
Cj4gc2VyaWVzIGFuZCBwdXQgdGhlIGNoYW5nZSBsb2cgaW50byB0aGUgY292ZXIgbGV0dGVyIHRv
IGV4cGxhaW4gYWxsIHRoZQ0KPiBjaGFuZ2VzLg0KPiBVcGRhdGluZyBvbmUgcGF0Y2ggb2YgYSBz
ZXJpZXMgaXMgb25seSBnb2luZyB0byBtYWtlIGl0IG11Y2ggaGFyZGVyIHRvDQo+IGZvbGxvdy9h
cHBseS4NCj4gDQo+IEFuZCBwdXQgYSB2ZXJzaW9uIG51bWJlciBmb3IgdGhlIHdob2xlIHNlcmll
cy4gSXQgY2FuIGJlIGRvbmUgYnkNCj4gZ2l0LWZvcm1hdHBhdGNoIHdpdGggYC0tc3ViamVjdD0i
UEFUQ0ggdjIiYCBvcHRpb24uDQoNCk5pdDogZ2l0IGZvcm1hdC1wYXRjaCAtdiAyIGFsc28gZ2l2
ZXMgeW91IGEgbmljZSB2Mi1YWFgucGF0Y2ggcHJlZml4IGZvciANCnRoZSBmaWxlcyBhcyB3ZWxs
IGFzICJQQVRDSCB2MiIgZm9yIHRoZSBzdWJqZWN0Lg0K

