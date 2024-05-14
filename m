Return-Path: <linux-btrfs+bounces-4954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B5C8C4B40
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 04:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25E71C2133E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16866B657;
	Tue, 14 May 2024 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IScnx4Wo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3725628;
	Tue, 14 May 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654529; cv=fail; b=CPyJgJErCkjt71PPKizsLzMH/MiDeMAB/t/M4wOixN/Tjaqx7wcPAFuxoI5vVaDyXcZ4usy/GvcghdZIEatvApl7/DPV8hMscUdyAACqnk4NdsY09yK3/JbcWX7hZIeJlu8a55WjT+O3AqoFukHsYBBoe2DlC9pPuwZoNBu8Vq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654529; c=relaxed/simple;
	bh=kFskBzRMg2k5QCkYVfJ69UeChn6owfkskl7XHfvkiZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGog0SJvGRQPPl5uU7BWSYiUBEuCIL+Tx2IY+rZHsMThNAmaZey8gEzYPA0bE2Mm8ZlNTp8MCvQQBgpOVLFdM+D13AIs83INAyzE2vMTmEBTPQq6oTKdXFKItunMMPnzH1d0tWbFUmaP7WQxrcdBEBEmsVopwsRKo0BZnfZuXLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IScnx4Wo; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715654526; x=1747190526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kFskBzRMg2k5QCkYVfJ69UeChn6owfkskl7XHfvkiZM=;
  b=IScnx4WoAqrl8S2yd63Qmou9U1YGv0B9a+nYG9N0N8LFWpNlS60iUMKE
   VIW8NxT0J9B9SuFY7vs04abC3dEd/FkacJs9rw5/yQZxRLDWgs/XAUNGg
   VmRUM1MZ+dv3VIZr4EvhEda7JF/qBlTI8v0OlyTkCEW3fFg7kFbbn4xXl
   UtBx0c9qZI5HBwfoWrvx+KunHzQhzFE2SZJ2L4fWkqxwMtYY9JCrMnMoE
   aiJorBcWNk0lf0/L5JoIRBYZFrzjDkO6dz0fMY/ZWrqSXO6KDizG5SEZ1
   355O5g+GZNaPx92VhJ58YVUsnXQAzal9W07CZFrenwWgtmrkvNWiiKzL0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="119238479"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; 
   d="scan'208";a="119238479"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:40:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtMh3FBvY6ljobX1osgCeNi6X1TkSM5NHk+PUGZyrGh7+6PW2TvIAxsYcRYKD5gmq2apqCn0E8kSKLZdijUT2EXiyYQLPxfbQzXW/t89UgrRfGIP939dTJTRf3hrM1IINRgm76CdMY6sFDQ53G8OMWvj2bl849f09J5v7k4XwqknNBSmhpDUJmwWyAnD3TUhCzlTkvnu0/tY+kTm1I1dlwhqLjVIGWUsgNw7TZrzusOIyqo/hNkZzJg+i0EGrA3vYf0sct2H+Jrd7dLxbuwR7G/P9Y3QIu/lSRyucNlXnESMtXR3EDM3i+f/W9IpjeXSMG6DZu/7YenHW2NY6edXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFskBzRMg2k5QCkYVfJ69UeChn6owfkskl7XHfvkiZM=;
 b=G8K83MrYW6WjanzBg9Nup8SpbdXxROx67vojLk1DTA7lc3ioLDSteEvvCc0BLa6cvY1jRBGstslmsBD6Vb5XNKgpCvMzIOb7V88yeBh9F9VogRE7lNMkeukMHFFAMUJtUutwn4tktW8nMcbwyORyEvQd13mzUgI31vDWyAOwN6jdcJzBn/id5BSo1s5jnxVvWuqjQ0inUEa95yfpGuuvAfnNEBKxwzQ4/zEaz93fgVPFEfZllZucwWOxxIcsCecrKfFgg8gI8ULPHobxJ3ocz2Ucdo2eHloObaiMJGfqjnGtBhMTzQblkQdNH9mUZZat1nyAoA7NheQXUKHm0HLB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:40:47 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:40:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "ira.weiny@intel.com" <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/26] cxl/region: Add dynamic capacity decoder and region
 modes
Thread-Topic: [PATCH 04/26] cxl/region: Add dynamic capacity decoder and
 region modes
Thread-Index: AQHafmelyG7ZI2N/WUGUutu20kdUILGWU20A
Date: Tue, 14 May 2024 02:40:47 +0000
Message-ID: <a70bfe29-292d-40f5-b963-ea2637b5f07a@fujitsu.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB10090:EE_
x-ms-office365-filtering-correlation-id: e713d35d-e4c1-4724-fb8d-08dc73bf4288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVU4WWlSeUJYYTlNTmpHZXMrM3RnQm9aNmduTUE2L0I4R2txMStMZ05SVUwx?=
 =?utf-8?B?R0xLbm5CVi9uSlBEYVFaZ2M0VzJkdWsxQlh3S3hoYTBqUkg5L1ZNbG12elpP?=
 =?utf-8?B?VGx0NmhlOTBCV0VDd0lZZ3VQZUYxN25aVE4wSU80b20zbGdRRnNtcWU5YlBj?=
 =?utf-8?B?UUVlekFreURjakFKUzVHSlVWRFphTk5OazBPY1VnK3NhMUt6SW5tMGJTdkZo?=
 =?utf-8?B?amZBYkhtOGtkUC9nRmdaMkM4ZFZhaDhiUDRQOUJpSUJDVlBMbXFjVWtUVE9U?=
 =?utf-8?B?Sld2RTJJRGVlZEgrRDVUaXo4Z2ZiWjZUbTlvSk1VOUl1QS9UVGhCRi9YemJq?=
 =?utf-8?B?akM1bHVna0RDTGRxOVJ4Zld0NEVweVpCekR6Z0JXSGhTaTRMaVE5SlBGalQz?=
 =?utf-8?B?ZmxQdGtadm1GZ01aZ2NXNFR2d2lUZkozR1hmd3p5WXhLNFEyZG9WcExieUt5?=
 =?utf-8?B?ZDlmRFZHdGR3bTg2OGZPZFZHYlVJcThqTXFiVXgySTNXbHNrSys3NGFUeWl2?=
 =?utf-8?B?ZFh4eEVyRWFJM2c4NFhIS3hwb3NudkJFTnRaNzZ0clJWWHBsZnBIUVJSYW40?=
 =?utf-8?B?b2o3aTZ5amY5V2o4R3NqRlNnZTVnNTVjcmUvR3phQ21uTXRHUUlHa2JRN3lY?=
 =?utf-8?B?RldUZ0pDK2RnclZjZzVhWGFzY3BCQzJwN2hNUzRVcFQzU0JLYVZGSEhtMmxN?=
 =?utf-8?B?ZXpISkdCbzBWVWxONkp3OWxPald3NHlIK3VQWi90a2cyWUtyaERRZUIrWjVk?=
 =?utf-8?B?NGdocXhEcUh4V2ZZZlloZHozM09KUWFhNjc1Q1h5QUlUSlRXc0I4c3dNRCtz?=
 =?utf-8?B?UUhoblFBbGFvRjJyQ1VUblZReDc4TWhtcTFUb1NHclN6SWQ3a1dIZzNGdjJX?=
 =?utf-8?B?Q1dsaFh3U1hmV2hUc240aUpQQ0N0RkRLWnc0aVN6Y1A5NlVRZE9zQmVqa2R5?=
 =?utf-8?B?c2x4QTlWbzg5OEdBaE9qV0VZZEU4dTdvY0lMS1kwMWxNUlJ2NXF2MXAxMG54?=
 =?utf-8?B?UlRhSURIVWJpOGlUYmV1QWRMT1hWcVBSaVFHTWRScWZ3RVRxTTc4dERVZXVk?=
 =?utf-8?B?aWZlaEZFZTlaSHJYTkQwRFN2VjZDK25Nek1PcGp4ZmIzU1F1OWoyNVV5bEVh?=
 =?utf-8?B?MktVblJZd3ZyMklTam1XNmNrbklSUGRUUngwRElON20ya3E1UDhva3gzNjRa?=
 =?utf-8?B?UFNPU3ZMOFhhbnRLSkFZdzBaaGpFMVdTUjdBNVRFVHFvekNrdWt6ZlpIbDVL?=
 =?utf-8?B?SW1abkN2T2xZY1g3MUE3bk9qNmc2VTd3TG1DdjcvdUcwR3RIT0s4K3gwK2F1?=
 =?utf-8?B?SjZic0swZmhBMW1jbFVrT051RklQNHByVHErY0tMSSttZDQzZVYxYlRhQ0pD?=
 =?utf-8?B?NDRITEs1bHlKSDdUMCtkMk92dXZ5YkF3K0hnQVM3SFZ1aTlSdTNYc2txR2J5?=
 =?utf-8?B?QlRlaWp0YUZZSWM0TUJHcHduVDQyc1BZM2EveW9KM1NoNEFpUmhFWHVldzdy?=
 =?utf-8?B?alZXQmQxZ0RMdWFCMjlDSVdTK3ZUNndDSXFja0ZHNFBrRzZGejlpWjN0OC9M?=
 =?utf-8?B?ZGVxMlFQaWNONUJncy9sVFF6YS9xdk9XT3k2ekJXTENCV2JqNWdBckJOcVd4?=
 =?utf-8?B?WW5aVVBZNnAyUHh3cVNEVlZYeFd4UHJFeU16TDJ6WnZpdUtZd1lTcFlBWktr?=
 =?utf-8?B?NkFpWDlsdUJad1Vta0oyTUZKWDNiV0l6Y0pCY2l0cllBMWM4Qk1SNzNGY090?=
 =?utf-8?B?Q0xXVmpLYThsdUtYcGtSTTFJeGdtWFJwQ0gyYnlEYkR3aW9STWxZV1JlaHNu?=
 =?utf-8?Q?LTky5xcp6aJ/CS4c8TyYfEXAikaCDbmccS2Js=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUF0NGM0OSsrSktQRGQ4MEpYQ01PWmlUTy9GTDY5aE8rSkUwdzVPYSs3QlBv?=
 =?utf-8?B?dkZ2SG5xcjhvQ3c5ZFpvRTF6bkJkZHozc052TnNxclhIVWc3M1pBWEp0VmQ2?=
 =?utf-8?B?eFB1N0VFY2h2MXg5OSt6Y1NrTmt1V3ZLb0hZZHBzbmZoM1paOWM3T3dlcktB?=
 =?utf-8?B?Z01IVFRqKzl4Q3lQUFFzQ2tydy8rZmgybzBjNXphanF6Uk1qVGN4bDBRb1Rx?=
 =?utf-8?B?WWNjdXpRbkhGcVNlUDViaDFnaS96RVpXenZTYUxTcmxiY0dOSndwUDI0cU9T?=
 =?utf-8?B?TEFKUE94U1lFWjdrL1NzeUZYOHBXNDhwSFFMd2V1M0J2eDRGZGsxR29Ndjhr?=
 =?utf-8?B?eE9ibTJkeGw1YXVHZC9jWXlMLzU1eDhwaGVyYmRBTC8rdmhZaHJJVG1DSjNr?=
 =?utf-8?B?UGEyMUQybUhMT1Zoc2FsMHR3YW01Ry9FWUxZUDlpb2QyeU1mdWJEbXR3a3Az?=
 =?utf-8?B?Mk1SNi91dGU3UGJkR0F4dXliUEZaTnRVTWhGRWxtbW01eVN2ZnY5eHVMT0pB?=
 =?utf-8?B?dXdXKzBzU3o3ZUhJd3BtNlkvRCtiMFVkQnJvS0dCVmRBcUFtY0cvcDVhOUxs?=
 =?utf-8?B?ZTYzb0wwZ2Y2MFhoc3pOTW1DdGtxRVVnWDdEMHJmUjFkNjZURWJDQnM1UzhJ?=
 =?utf-8?B?aXEySGtoQXZOUjJYeWZjTktWOWRBMW03L0dpUy95WlVXbHBFOHBzS1VScUsw?=
 =?utf-8?B?M0duR0F6cUEwUEJwclJ6NG1LZmpzRFZTU2J1SENXNFRTbWc1ZXI5UVQ5YTcr?=
 =?utf-8?B?Q0NNZXRlNDBmYWdSdTE3bjczVTM5WUdYZ0Vld1owcjFXdDcwZitWWDNVODAw?=
 =?utf-8?B?RGM0TlVHRStoZkgyaGZ5SzdRbDJjSHVabkFHTVk4S2xZVFBnV3dQTFJ3N2V6?=
 =?utf-8?B?b3VERlBhME5LYjVFcjl5L3NNM0JHZk5OcUlmcGNMWXJxemRYTXZNWkFBbi90?=
 =?utf-8?B?MnhnM1ZxTVh4dnpJcERVWTAzTjdxa2ExZUhvVmdQWE1tUjZscmpNR1NJREM1?=
 =?utf-8?B?M01IQkZNbWVwcEFEcVNONmtqb2NGcVFwQzkxc2V2TnRtVEU4R2xMREhCdDM3?=
 =?utf-8?B?dWFVTXVQL3NhRWZUeEpabmNhaDB0Q3J2VkVVemVnY2dmempPUlpjM1VSMDZk?=
 =?utf-8?B?Zmd6WFpRemM1aFppVUhxSzl3clY5ZE44UEVucTkwQTdqS3ZsTUZzWEMxaDRs?=
 =?utf-8?B?V3JHZzRZT0NEMVNLcHFOdnhpMFlGQllsY3NuUktOeFZseUovZkx4S091WDJs?=
 =?utf-8?B?Q0xOa2NJcXhpa3RjamVaOTkwL2NJS2ZjNGFNck15NmE0NXhtVEFDMWFzK0JZ?=
 =?utf-8?B?OUpxYXpJWU50Tk5NM1NYRFdFQXUvNGx4SjFGYUNWY0NHMGlCSVp1TWVMMElZ?=
 =?utf-8?B?VGdlQThBdHlZN0srbVhIckhCYnQ5MVRWMi8rQ1d0TXlSaWJpT1ZDTVVYRUhI?=
 =?utf-8?B?cE1sdDRHb1N4blJlaGxEUC8rQnNtNVVCMnNRNTZYTG9VYkJ0RXU2R3cyMEoz?=
 =?utf-8?B?OEhxUlEyR0tjck8wR0JXdk5jLy8xSnc1dFJidEVZMHB4M0gzRGxMQXdwYUxk?=
 =?utf-8?B?cDZpcGpSWjBmandEL3MwT3hlU01FL3lMTGRsOHozcC85b2FINTgxYWwxVnd5?=
 =?utf-8?B?SG43WU96VldHamdHU2l6Y2tvd0F0MVQzN3c4RjVPOUNhVW41Yi9DK1JRNU1T?=
 =?utf-8?B?d1JWZHNvc201eXpaaGxFK3cxN0VKcU50OWpPRWRMZmdHRExjaWxUT2JYaXRW?=
 =?utf-8?B?M05ZU0FjWmZmSjNDbzQ0d3lrTVl5SDA0b0NlR1FsWFR3WENXeHNBVFNwNTlZ?=
 =?utf-8?B?U0QwOHNyTW1jWXpQYlFGM1FtUm1HWDFCR3VFU1N2WlVBSTNFNTNHOVZwWVFo?=
 =?utf-8?B?QmFaVWRlUCtsWUtUbUsycGtkNDVaT0dsclBUZFJlSXkwZHFCNU5OcUdXZGdZ?=
 =?utf-8?B?dE14clgwNjlGZGhPK2tRYkVBRmNSaEVpS1NjdkZ4dWZZeXpoZHE1aFFmMTRy?=
 =?utf-8?B?MVBxMThaSlZMb281NVBGYlpua2FaUGZSZ2JRNjNoYkZ0OVNUd3hSelV2dU1H?=
 =?utf-8?B?d0ZUUGhuWXRPZTVFWHVoZnNielJpSXAvRjBSQ2lXOVNrWkphOGErbGdIOEZ6?=
 =?utf-8?B?T0JSekxSbTF1VkR6dEFiK1FEK2xrYWZOQlErTkhSK21oY2dBRVN0RSs3Q2hZ?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <157AAB5DA2C1CF41B8A52FD00004CAFA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	434FGgPKm0ZJtc5O3P39OA7q/NmCCc4oSrocKukWByJKitTjyXkgIkF9AvCOKX9Nr3setBu6k12ypO4F/pdkr1wnwgG0PqANLpU+hfc9uK1oxeRtvBaMjcY8phXMkSnRA56nCj7dtPKAfYpmO33m3PeutAHtbE8Ok3nqhdQWX3p0MoHtzc3Z2s0Ij4GwmDHqmFg+YThRGdrnqrYYni7gKxEvRn5UMfKsDJQ17vU1Y8JWBU0C4IxngrpVkGELncwM24dxApsVxvCchilVB6Y228MtU3jAmD9f3AgqwRcykNm704R9U3txyqCdNLbdI0WVgTUtlcS3BqnzksheJegXBUCW9KCseyBv/QW+rWPehVIeW7ujMO6KuC7fHVb226Y9VDhpo2hBMb06sMSllk0yTUgq5LhkN0Pv2e7QfujGsLOuyM91JM7xig+cJne8CCIi3T2W81KJWxAY6EFWnnsn8fRUObAAbiX4vPGQ0fKNkBZx/YVdtiEnmmK2SHocsbjKzpPZkVGK7DXZzwpJtGJckBhXMztIKcd5FyiNjXrCW+gXIhG4vqLDiqAUD29WBm+JyAk2CduXY84RFubUQR1NGEb4h6OjL2c1joC1IJtCbgd4z7u0iFjYRjW1jbTggGIE
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e713d35d-e4c1-4724-fb8d-08dc73bf4288
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:40:47.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5Euq4dTsonk/4hDHVRMguOi4FlB0LwwPRTOPkXGB6o826qX2ueRUVroZue3FwCuvqifeSAVcPObonyUymevhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090

DQpUaGUgZm9sbG93aW5nIGNoYW5nZSBpcyBwcmVmZXJyZWQgdG8gc2hvdyB0aGUgY29ycmVjdCBt
b2RlIG5hbWUuDQoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvaGRtLmMgYi9kcml2
ZXJzL2N4bC9jb3JlL2hkbS5jDQppbmRleCAzNWVlNTY1ZTI3YzkuLjcyOTAwNmNhNDk5NyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvaGRtLmMNCisrKyBiL2RyaXZlcnMvY3hsL2NvcmUv
aGRtLmMNCkBAIC02ODQsNyArNjg0LDcgQEAgaW50IGN4bF9kcGFfYWxsb2Moc3RydWN0IGN4bF9l
bmRwb2ludF9kZWNvZGVyICpjeGxlZCwgdW5zaWduZWQgbG9uZyBsb25nIHNpemUpDQogIA0KICAg
ICAgICAgaWYgKHNpemUgPiBhdmFpbCkgew0KICAgICAgICAgICAgICAgICBkZXZfZGJnKGRldiwg
IiVwYSBleGNlZWRzIGF2YWlsYWJsZSAlcyBjYXBhY2l0eTogJXBhXG4iLCAmc2l6ZSwNCi0gICAg
ICAgICAgICAgICAgICAgICAgIGN4bGVkLT5tb2RlID09IENYTF9ERUNPREVSX1JBTSA/ICJyYW0i
IDogInBtZW0iLA0KKyAgICAgICAgICAgICAgICAgICAgICAgY3hsX2RlY29kZXJfbW9kZV9uYW1l
KGN4bGVkLT5tb2RlKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAmYXZhaWwpOw0KICAgICAg
ICAgICAgICAgICByYyA9IC1FTk9TUEM7DQogICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KDQoN
Cg0KT24gMjUvMDMvMjAyNCAwNzoxOCwgaXJhLndlaW55QGludGVsLmNvbSB3cm90ZToNCj4gRnJv
bTogTmF2bmVldCBTaW5naCA8bmF2bmVldC5zaW5naEBpbnRlbC5jb20+DQo+IA0KPiBSZWdpb24g
bW9kZSBtdXN0IHJlZmxlY3QgYSBnZW5lcmFsIGR5bmFtaWMgY2FwYWNpdHkgdHlwZSB3aGljaCBp
cw0KPiBhc3NvY2lhdGVkIHdpdGggYSBzcGVjaWZpYyBEeW5hbWljIENhcGFjaXR5IChEQykgcGFy
dGl0aW9ucyBpbiBlYWNoDQo+IGRldmljZSBkZWNvZGVyIHdpdGhpbiB0aGUgcmVnaW9uLiAgREMg
cGFydGl0aW9ucyBhcmUgYWxzbyBrbm93IGFzIERDDQo+IHJlZ2lvbnMgcGVyIENYTCAzLjEuDQo+
IA0KPiBEZWNvZGVyIG1vZGUgcmVmbGVjdHMgYSBzcGVjaWZpYyBEQyBwYXJ0aXRpb24uDQo+IA0K
PiBEZWZpbmUgdGhlIG5ldyBtb2RlcyB0byB1c2UgaW4gc3Vic2VxdWVudCBwYXRjaGVzIGFuZCB0
aGUgaGVscGVyDQo+IGZ1bmN0aW9ucyByZXF1aXJlZCB0byBtYWtlIHRoZSBhc3NvY2lhdGlvbiBi
ZXR3ZWVuIHRoZXNlIG5ldyBtb2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hdm5lZXQgU2lu
Z2ggPG5hdm5lZXQuc2luZ2hAaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IElyYSBXZWlu
eSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSXJhIFdlaW55IDxpcmEu
d2VpbnlAaW50ZWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjENCj4gW2l3ZWlueTogc3Bs
aXQgb3V0IGZyb206IEFkZCBkeW5hbWljIGNhcGFjaXR5IGN4bCByZWdpb24gc3VwcG9ydC5dDQo+
IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCAgNCArKysrDQo+ICAgZHJpdmVy
cy9jeGwvY3hsLmggICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gaW5kZXgg
MTcyM2QxN2YxMjFlLi5lYzNiOGM2OTQ4ZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2Nv
cmUvcmVnaW9uLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiBAQCAtMTY5
MCw2ICsxNjkwLDggQEAgc3RhdGljIGJvb2wgY3hsX21vZGVzX2NvbXBhdGlibGUoZW51bSBjeGxf
cmVnaW9uX21vZGUgcm1vZGUsDQo+ICAgCQlyZXR1cm4gdHJ1ZTsNCj4gICAJaWYgKHJtb2RlID09
IENYTF9SRUdJT05fUE1FTSAmJiBkbW9kZSA9PSBDWExfREVDT0RFUl9QTUVNKQ0KPiAgIAkJcmV0
dXJuIHRydWU7DQo+ICsJaWYgKHJtb2RlID09IENYTF9SRUdJT05fREMgJiYgY3hsX2RlY29kZXJf
bW9kZV9pc19kYyhkbW9kZSkpDQo+ICsJCXJldHVybiB0cnVlOw0KPiAgIA0KPiAgIAlyZXR1cm4g
ZmFsc2U7DQo+ICAgfQ0KPiBAQCAtMjgyNCw2ICsyODI2LDggQEAgY3hsX2RlY29kZXJfdG9fcmVn
aW9uX21vZGUoZW51bSBjeGxfZGVjb2Rlcl9tb2RlIG1vZGUpDQo+ICAgCQlyZXR1cm4gQ1hMX1JF
R0lPTl9SQU07DQo+ICAgCWNhc2UgQ1hMX0RFQ09ERVJfUE1FTToNCj4gICAJCXJldHVybiBDWExf
UkVHSU9OX1BNRU07DQo+ICsJY2FzZSBDWExfREVDT0RFUl9EQzAgLi4uIENYTF9ERUNPREVSX0RD
NzoNCj4gKwkJcmV0dXJuIENYTF9SRUdJT05fREM7DQo+ICAgCWNhc2UgQ1hMX0RFQ09ERVJfTUlY
RUQ6DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1cm4gQ1hMX1JFR0lPTl9NSVhFRDsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bC5oIGIvZHJpdmVycy9jeGwvY3hsLmgNCj4gaW5kZXgg
OWEwY2NlMWU2ZmNhLi4zYjg5MzUwODljMGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2N4
bC5oDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2N4bC5oDQo+IEBAIC0zNjUsNiArMzY1LDE0IEBAIGVu
dW0gY3hsX2RlY29kZXJfbW9kZSB7DQo+ICAgCUNYTF9ERUNPREVSX05PTkUsDQo+ICAgCUNYTF9E
RUNPREVSX1JBTSwNCj4gICAJQ1hMX0RFQ09ERVJfUE1FTSwNCj4gKwlDWExfREVDT0RFUl9EQzAs
DQo+ICsJQ1hMX0RFQ09ERVJfREMxLA0KPiArCUNYTF9ERUNPREVSX0RDMiwNCj4gKwlDWExfREVD
T0RFUl9EQzMsDQo+ICsJQ1hMX0RFQ09ERVJfREM0LA0KPiArCUNYTF9ERUNPREVSX0RDNSwNCj4g
KwlDWExfREVDT0RFUl9EQzYsDQo+ICsJQ1hMX0RFQ09ERVJfREM3LA0KPiAgIAlDWExfREVDT0RF
Ul9NSVhFRCwNCj4gICAJQ1hMX0RFQ09ERVJfREVBRCwNCj4gICB9Ow0KPiBAQCAtMzc1LDYgKzM4
MywxNCBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKmN4bF9kZWNvZGVyX21vZGVfbmFtZShl
bnVtIGN4bF9kZWNvZGVyX21vZGUgbW9kZSkNCj4gICAJCVtDWExfREVDT0RFUl9OT05FXSA9ICJu
b25lIiwNCj4gICAJCVtDWExfREVDT0RFUl9SQU1dID0gInJhbSIsDQo+ICAgCQlbQ1hMX0RFQ09E
RVJfUE1FTV0gPSAicG1lbSIsDQo+ICsJCVtDWExfREVDT0RFUl9EQzBdID0gImRjMCIsDQo+ICsJ
CVtDWExfREVDT0RFUl9EQzFdID0gImRjMSIsDQo+ICsJCVtDWExfREVDT0RFUl9EQzJdID0gImRj
MiIsDQo+ICsJCVtDWExfREVDT0RFUl9EQzNdID0gImRjMyIsDQo+ICsJCVtDWExfREVDT0RFUl9E
QzRdID0gImRjNCIsDQo+ICsJCVtDWExfREVDT0RFUl9EQzVdID0gImRjNSIsDQo+ICsJCVtDWExf
REVDT0RFUl9EQzZdID0gImRjNiIsDQo+ICsJCVtDWExfREVDT0RFUl9EQzddID0gImRjNyIsDQo+
ICAgCQlbQ1hMX0RFQ09ERVJfTUlYRURdID0gIm1peGVkIiwNCj4gICAJfTsNCj4gICANCj4gQEAg
LTM4MywxMCArMzk5LDE2IEBAIHN0YXRpYyBpbmxpbmUgY29uc3QgY2hhciAqY3hsX2RlY29kZXJf
bW9kZV9uYW1lKGVudW0gY3hsX2RlY29kZXJfbW9kZSBtb2RlKQ0KPiAgIAlyZXR1cm4gIm1peGVk
IjsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgY3hsX2RlY29kZXJfbW9kZV9p
c19kYyhlbnVtIGN4bF9kZWNvZGVyX21vZGUgbW9kZSkNCj4gK3sNCj4gKwlyZXR1cm4gKG1vZGUg
Pj0gQ1hMX0RFQ09ERVJfREMwICYmIG1vZGUgPD0gQ1hMX0RFQ09ERVJfREM3KTsNCj4gK30NCj4g
Kw0KPiAgIGVudW0gY3hsX3JlZ2lvbl9tb2RlIHsNCj4gICAJQ1hMX1JFR0lPTl9OT05FLA0KPiAg
IAlDWExfUkVHSU9OX1JBTSwNCj4gICAJQ1hMX1JFR0lPTl9QTUVNLA0KPiArCUNYTF9SRUdJT05f
REMsDQo+ICAgCUNYTF9SRUdJT05fTUlYRUQsDQo+ICAgfTsNCj4gICANCj4gQEAgLTM5Niw2ICs0
MTgsNyBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKmN4bF9yZWdpb25fbW9kZV9uYW1lKGVu
dW0gY3hsX3JlZ2lvbl9tb2RlIG1vZGUpDQo+ICAgCQlbQ1hMX1JFR0lPTl9OT05FXSA9ICJub25l
IiwNCj4gICAJCVtDWExfUkVHSU9OX1JBTV0gPSAicmFtIiwNCj4gICAJCVtDWExfUkVHSU9OX1BN
RU1dID0gInBtZW0iLA0KPiArCQlbQ1hMX1JFR0lPTl9EQ10gPSAiZGMiLA0KPiAgIAkJW0NYTF9S
RUdJT05fTUlYRURdID0gIm1peGVkIiwNCj4gICAJfTsNCj4gICANCj4g

