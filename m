Return-Path: <linux-btrfs+bounces-18102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9825BF5862
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812BC18C1CF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801662E7BD9;
	Tue, 21 Oct 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="US0HqY3h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O2FtKIqp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB9221F0C;
	Tue, 21 Oct 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039198; cv=fail; b=GSPG1uTS0bjCel9uN7kKaHDzwTUVdIa0WaPWvTRlF0kZgGjs+vKWmYgOWwnjNpzz+KhYtUpJOSY3hTCguEoBUvyULRoeFMDmuAnecf9Nx1gbEJYb/ORpw60Sro1lLHzSnt+4GF0AgYNU4bHDoj/WdEEYRxihwo8hymjG6Qoly4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039198; c=relaxed/simple;
	bh=vdhXHBeJDa+xV32eGRSdUbmZccZIKle6+b0ujgQGsl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cmy/8bazjbald6unmRMwHdijes5Dn80b5/SzUhBSzKBbB9iwxbW2ZSp86QziDzRHUd6pQrE6U5mZEX2I3iltuLARwy9x+gXjjiX9EHPz9CoIunW0YBEBWJS/2cexdzWbv8oFeFO5jLN3RLcMKvLzDqU8ufVtW7D/Uoo5drPPTA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=US0HqY3h; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=O2FtKIqp; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761039197; x=1792575197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vdhXHBeJDa+xV32eGRSdUbmZccZIKle6+b0ujgQGsl0=;
  b=US0HqY3hl7yR+XMzwESZoxDTdoFBzqcX/cRVDuV9+STkqjdEyUhZcz9S
   SwOSa+VIoJEUDw1T58juQ8mNU+udxMswf1RIjbApZK3oUGD7IbygLyByc
   d1jVKPW9wIMb1br8r6YwatZ97xExjREA7WnFwWCIeZpFAdQAq30U3HxtI
   qiAoqLXuYk41EALtP+o0G797pbEsGIMupdOL/kFrt2nCu5DDeNxNpRKCA
   /cI7ERsnATI1QxNjtDTcioRU91z/IOM5o8zVNfPdBgu8+JTK7zC5m/RLl
   DWDt2NJvCBpNz4LddHq+yWOB8efY4/xDDU6l6Qbm6oJBky4eNc5zOxN9g
   g==;
X-CSE-ConnectionGUID: nxVV2yaQTZumXnvUSHqlAg==
X-CSE-MsgGUID: HTHNJRI5TNSZLQTiyS5PKg==
X-IronPort-AV: E=Sophos;i="6.19,244,1754928000"; 
   d="scan'208";a="130627105"
Received: from mail-centralusazon11010063.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.63])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2025 17:33:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDVPT7zR1EopMFdDmAIUiqJoVSx31+Jpse3ajQSHhDHOcXycv1R937ZFhTTvhCdLCleVANl/Q/OWFr9j5bVlsj5545xPxmerjN/WfANkJE+BUod0UCZZWtNdvvEeVJX1cDnWQ/dT64PIMTbtsR50gffXShUBYshBJ99geYBD95+pPKJpuS1apJ35Fj80kWYFnXamJpxGKOJIldcIQkcHaKImCqllVoD4HN0k6EJFc7xB9Y5sqSmcO+2friWLvug6x9DB+G4JFLT5H1b52ZcO1TSmN0eNfXXg5zhEUWbjxKdWOktIjQriKjAmSzg+CMY7Ii5H+tdjzk+7UFYbhNReGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdhXHBeJDa+xV32eGRSdUbmZccZIKle6+b0ujgQGsl0=;
 b=P2BPH5/8G8AuJryciN1WHK78DJfmW78tCcn6TxsMq2RQaBEUa3lxS7CLRk/YA7O9po0Lappb455Phl40MFelH2pVA5liQ6Xmmhu+bql79ed1uWhyQUl+ibwZKHFMlhDLc2eg6NsHK17SIMHT0Ov/b3QUXU1T3tFJN+hkkSqWzug11DKfZZZTUdH4HGg1wga+023z8j9bfnY8EO9/Elfp8LaDFM12RUZ2p0sNPMhPnuc5c+NqKK84+y+SoiqW9B5wt2q0bdKFpBao3RwnI0dwF3ArDtY6jImxJMQFYZzM/kuTRwWTXwnsaOBB/wN0Xrz2XZ5RuJzI7uafpufJADCUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdhXHBeJDa+xV32eGRSdUbmZccZIKle6+b0ujgQGsl0=;
 b=O2FtKIqpzSRj9riq9XuQBp3OxwOAC1BfuzLc7vOim8glz1QZxUyTl5aUiSHjw8wn/yTLzgA1dFWFYjWjDoxPI0b6wjkaquV1SHmukgD7nTQQFfkHD/pyUFwXrd76mOZUjxR9fwjxznFhCV7Os/UujcAyc9ucYXwDwV81WobEOkU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7127.namprd04.prod.outlook.com (2603:10b6:610:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 09:33:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 09:33:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index: AQHcPrB98rc0Re5Mwk+pm/9ca/TvXrTGsiGAgAEQ1ACAADAhAIACowWAgAHH64A=
Date: Tue, 21 Oct 2025 09:33:05 +0000
Message-ID: <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
In-Reply-To: <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7127:EE_
x-ms-office365-filtering-correlation-id: 3e0a5bca-4723-402d-92bf-08de1084d6cc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUVnd0xPZ3FFc2NabmxiLytpR0F2SDNvU3NuYTg3UzNkNFkwQXRpTUdJcnlN?=
 =?utf-8?B?S2VneU51MEZRb2pQQUpOOGxTbFEzM1NzQ3p6WjZUVSsyQjNWV1FJbCt0MG5G?=
 =?utf-8?B?VXVZalRTUlBveHNnWkM0WmhFTWsrbm1QSHA2aUwzTENSZS9uRmVtYnVJNVVk?=
 =?utf-8?B?L1ptOENBd3FLaDFrR2xhMWRMM2REZW5vSnBObkpWcW9mZzJuWTBiN3NlaVJB?=
 =?utf-8?B?Mkw4M3ZsN1hhK1RyN2tYVlAwa1A2NzR2Tkl0d1JUd1QxZmNKaDRWY3ZKcnh2?=
 =?utf-8?B?N3ZTc1p6UVpmWjJxYkttVHdHVEJuaFdlV3pXZitJQjhVMzFxOCtNTlRsRHgr?=
 =?utf-8?B?VHJHRUVxVUtTZjVNZEFSQ2tUdm9pRTl1Z2xVTkVRVHFWYmpyQ20xZ3ZqNVZH?=
 =?utf-8?B?RVE0ZEZUS01wQmxUYUdPcmRRYktMUDEyU1VNZXByRkFDd1k5STdoY0JCQ1RO?=
 =?utf-8?B?YzVpU2QwK1ZQZkkzaHFHSkpxTFhDaU9wWlpVU0tqeWZubGJyVXBIQmppZ2I1?=
 =?utf-8?B?V2F4eGFsbi9Wckk5MWlJZmx1eXBnZDJLejBZZHMzWGVZeXo1NFJpYnExYVNr?=
 =?utf-8?B?THNSR29oWWo3cTF4UjZzcXk2MjRZM2FkaURKZ0hoZUozaVQ0dTA4bE1Jb2g5?=
 =?utf-8?B?WjlqVi94M3pudmtVRE9nQ0Fpd0c4SGZQaVdQVHM5M2dkd1RQcFlFanVvbUZY?=
 =?utf-8?B?V1VTTnA5OTdLMm1obGZzaEprTVZlNzdabFFOL0xJTUg1TWtzcERleTlpWVpG?=
 =?utf-8?B?ZEEyVnlsOURmdm1YRWlsSFlXVFNDa1pjcDBSNDFvYm9DR2ZNUE1qa3Vua0VC?=
 =?utf-8?B?bjU5Tm1odVFmNDlvbW5mUEREcDlBZGlhemJXK2xEYzVINFNTZWJ1TWR2by93?=
 =?utf-8?B?YnFwQVR3YzNWZnUzZGtqOGtpeE1rSWkwaXlRa1BzQW9SM2Zwa2twOFNKamtK?=
 =?utf-8?B?b3VhQ0NMSXZneG9HRis2ZHpnMjBlckF2UWxPcXJwbHk5bnBpU1I4bEIxQjEr?=
 =?utf-8?B?bXNoRmdtNUR0eS9nT2E3aWhNUWgrSXZTRzloRE01Vkk3Y1pBUEx4V3NYaG01?=
 =?utf-8?B?NU9FYkpVMWRaSURqWFM5VjQvbmNMY2tENk1Ud1lwSDltZDNkbUYrZ0lwaUN0?=
 =?utf-8?B?aDRnOXhlVmJMQVlpVEdTaVdIeDEycWFKaCsvZlJidDRwQTQrRXd4RUhLSUQw?=
 =?utf-8?B?dERZaG0vVDRrWDVyVUNXM0kxMFpxbEFCR0F2R01YWHYvVG1NK0RpQ3IrWi9S?=
 =?utf-8?B?czBoWUFRQ1MyY3E0TkRaVWZ4ZWZnRUF5L2lGN1hRdzN3Qnh0cXVxNDVSdVl3?=
 =?utf-8?B?aVo1ZWc2L3RSQUp2b1E1dXRjQ1o0U2VOYWJJdzlKSitubFFlL3BERVdUeXEx?=
 =?utf-8?B?UVB0MGlGRnFNcmtiSmdLNEZSZVhvSTFqMEk4Q2hEM1RIQ2pzT0lQSHlFQ3FD?=
 =?utf-8?B?VE0rSUxtR2pIdWMxN1U5aURqaUJ6TTRRMExBbm9lWEowa0diaHJlb2RkOWl4?=
 =?utf-8?B?bjZ6ejNMeitCVFhmbGdiTjN3ZnZJcVpxRXpoaGl4T3BpaEsrQVJZUWg2WVNx?=
 =?utf-8?B?SzFTMy9rV1RwU3hxcXBrcFpYYjQ5VVZWbnNkOTZWSS9wWFVseE1NZDk5QzRk?=
 =?utf-8?B?MjhiVUFtYlBRblVIQWl5VUdlbnQ3WkhnY28rcUJGdnJCTDRDTFd0NnFFVzZI?=
 =?utf-8?B?YnlsYzhxQUxaRndWV2VvNndKcWhFRmNQdVYrUFFKRld1c3M1OGN3M2NaUzJV?=
 =?utf-8?B?OWJTQk4yTUZESTJKcFRTN1NlYUJFaHpjY013S3M2NDRZMVdueXc1QVY5dlBE?=
 =?utf-8?B?TTZjVG1nNitHYkhKTHIxTit3MVIySlM0V1hLQVdvNVNOaG52Ym5XWEhxYnQw?=
 =?utf-8?B?aW82QzZuUUZRU2pvMnBPTDY0bnhEdUZMdlRrZXBRZDRpOFVsWEpKNzlNQkhx?=
 =?utf-8?B?NTRDcXFTeWZBL3JxWXFFZE5hNVpycVFlWkVRTHZVN2ZZZWwreFlqditJOXdM?=
 =?utf-8?B?Ti9xUnNxaHlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGRSZEtqb0JPL3lIUks3QWVDWUhreG0vR0ZhZGg0NU9aby9tY1BlUXpzZ1Jv?=
 =?utf-8?B?TW15T1JreXJ1Q1piTDY2RkhRWFJ4cFRIYk9qUlpoOWZaaWlWenJoQVduUHM3?=
 =?utf-8?B?YVNiYW1xOWR1dzUrVkRrVk1GVUlLYWx6elhmd3NXZEJOWlZKbGVsSmdoTzEy?=
 =?utf-8?B?dVM1MEJqZkdxeE5ocEZPY3ZzbmhWTXc1eGN4YWY4NU5BcTVYVjcyZUNqa0J4?=
 =?utf-8?B?R05vdGQ5R2FYZ3A5dVpRak91T1YrUUtLZU5rUDRaNzBHU2dmZXQ0ZEpVaDAv?=
 =?utf-8?B?NVNLcFd1TGptZ1oxRXFJd3k5SVFPcTN6UlhaWk05VEEzeDEvTStFRTZUT2Nr?=
 =?utf-8?B?aGNsQjFVVzJjQjVCM3h0U2grMUhINmR6RG1rcEVmVFlzRkJ3ZnU4REU2S0U3?=
 =?utf-8?B?d0twcmlmQUZQQm8xZ2FWSHVZcWV4aW8yTjRYdmgxTGdQeG9IL2ozKzl1Umky?=
 =?utf-8?B?TEx2WWx6ODJ1eGVHZlJJbHU1NiswelNHS3hlZGVYK0RSbCtlZmo0TUhCenY3?=
 =?utf-8?B?UjUrajZDd3RIK2hEYjQzcXp3LzY4bXBBZExqUlNYTHVaOStyWnpDUWtCaGo3?=
 =?utf-8?B?WDQvMXJJdzVXRXorcjZlTkY3QThUWVd6TjcxWTBYWXNCN0lZRndMTjhOVFJM?=
 =?utf-8?B?aURnb1pQNTN1Zm90MldFb05DQUFvZWQzL09sZm82eGU1bU9kRVJkVzA5S0pz?=
 =?utf-8?B?ZmNBOG1XQTZwREk0V0NScWR1OXdPaitPY01qS3pWZTBGWmpqaHlOZHQ2U0ZC?=
 =?utf-8?B?TnVOc2NoSXJBZTcvL09lcU5wZ0tPYkU1dGRDaWszRkFhZWp4MWVMUUk3MmdX?=
 =?utf-8?B?NVdUdXJ4ZGpnTTZKRTRjaGJweTRBeW40bDhORy9DcURYb2I1OVlOL2dGWUhK?=
 =?utf-8?B?dExoUkZkR1dlcHV6MTBRcDlYTXlSMFBtbDVTVTRYOUJmMVhWZGlCYnpIelBs?=
 =?utf-8?B?ak9FbVJOTVpkR2cwd3g1dUduLzBFUDNCdTZWSTd3bEM3ZmNlTzlwdm9YVHRD?=
 =?utf-8?B?MU5QTzc4N2s4WmVadmhuMUdFMGsvRGF4cXdoSXNZS0lkdU8wOGU2NGlkWVRs?=
 =?utf-8?B?MVBoR2srK1dQL3NqUWloaDJFaXNkVkFrNWYvdGxzK3I1ejFLbE5ZNE1CWkdX?=
 =?utf-8?B?RXNxc21KQy9SY1VnM2NXdFFibnNwUldLRUEwdzNabWM1cWIzc24yR2xrYjc5?=
 =?utf-8?B?Mno3ODVzWWwxaWgzbDhMeHhUMlRDNkFMYk92OTJlL3MybVRiR3ZXMVE2UVYx?=
 =?utf-8?B?VW5KVGhFeFFULzNyOVhuS1A3M1hvRmttczFON0N3WW45QkdMZDRQOG8yYnZF?=
 =?utf-8?B?SjNNOFNhV09UNXEzSFhYaEUzeUdJTlk3cFU1L2J1ZkpXdzEyN2VLdnBSSUZh?=
 =?utf-8?B?UFR4cGUwUU1rRERCSFVZNUxxUEZpUnRJT1E5clIwNm43YllPaG1aSmlydGdK?=
 =?utf-8?B?RUxNL1BSNXU4TjNCYlhhekx4SyswekdrNCtwaGVhVnFVZTRSeHU2NW9VUkdS?=
 =?utf-8?B?WnBHaXpDZlpuQ28wRVpoRk8yV0pROWlHTWhtSTZ2YTRaMFRDUDFiTTRabGdD?=
 =?utf-8?B?OVpaRW9odERtOTVWR2Y1THYzZkl2Z1R0dXdIQ0ZGVHZnUHA5c1VxTjkzRzdz?=
 =?utf-8?B?eTJsU1N0TVJaS21INUV1eEpuYmoyNlBNYXBTT3lBaGN5b0lKYlkwZkFtVUty?=
 =?utf-8?B?UU1kY2l4K1hucCtoM05kclF5TmFSdmpJQzVhbWNBbnVtSlhaYmY0UW1zL3ZF?=
 =?utf-8?B?WXdhZnlQZVJRTjRVdFkrSXVqRE5BdnNlb2IrZXl1OUdxQjZJbUovSk40NGF4?=
 =?utf-8?B?VlNUeHByMk9nMG4xZG8ybE05YjdGc1V0TUIvNFNYbWxNVFdBMkpzT0NaVWN0?=
 =?utf-8?B?cWJaTW1BeGpZZUxkaWw5ZWhyamU3dmdEUzJuZk9jK2xNbEszT0xnN2pzc3Ba?=
 =?utf-8?B?aUpmZTY3cDUwZE9EcURNc05FdWpTQW54M1lEQjBwT2JaakhkUnJMYkpjRzFl?=
 =?utf-8?B?WmcveWVac1hGTDZMT0ZDcFF6cmNDMCt1RTJmYzN0bmcxTnFNWmlEU0M3TVgz?=
 =?utf-8?B?SisraUpyKzRIMEFJeUtHb0xjMlVLVXEzY085S1VHbmVpNHFKUzFNN1ZSeFlL?=
 =?utf-8?B?Zll1MHoxell3Qk81ck1SWUd0ejlROU1mdmpDdkZFampmT0tCdFk3WDU1UDJD?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <172461827B745A419952F9D5F7FB122D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AN9cOKAXTUJ4cqmpMI+BANjhmgne3rII1+iBBDVaPqtzncLdclJ8UrffdQHPHTaWUELadeJhcJfRgFjZTLuHgGAPXg4fzNp6WT8nZZVzeZ1CcKV2m9P1sKrNPz2T1v01vTemcB5EdeO3FchP4uwPH2Yep03zXEgFEZPyI9E2etXVLRnCcGJGhXlVLCuQAtQe8sAs2aEJH7RqjaKWF0TFqDhl6nUxOC1hPVN3ozAe9RRn2E0AXdWpzIWG9mc3easIF97AszF6LA+wR/rjKUDRoxB6rd2Iy1y/ssCcckbL2SqMpUR7gH09stvuZMq+HFNB6IFtkfaqMZ0gsZqDh7uh6ECnGV2CZxPqwLyyEecXJmzRLbNDjPk0g/mMiP5j8j08HwXamKPgFXz+pf+0dcZkpFvUA5CosXDCGAxpZn/ZZ0SOFKl/QRS6vmWVvBDar1mRjJ83hppWVKkvIbCR7uQrGBygVkwZSAMVI2cO1jSBMssrGN165EzZQth8k8gUVtD5CGC3u3Ru/GnLw35lMXyqYhFCFcQLAyFxGuW5qTrj2LO9iTI+tPK0dj/LC/nCkkbpvoxmUZ6s50KcMlB1gGvFz0ly0QXWnbjsN2gLZL1Z6R558r8CBNfwJmQ77+nE+v0O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0a5bca-4723-402d-92bf-08de1084d6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 09:33:05.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIOxK7DSEbM7uoBJ4eQlG7L316OggleHWQA/XyfylgatndWJUo86mlFAxBNHc9DC+qfDv3ehzYid2lMK4ml/IbKzg5TebvqWFHgghDextRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7127

T24gMTAvMjAvMjUgODoyMSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBPbiAxMC8x
OC8yNSA0OjA1IFBNLCBab3JybyBMYW5nIHdyb3RlOg0KPj4gT24gU2F0LCBPY3QgMTgsIDIwMjUg
YXQgMTE6MTM6MDNBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+IE9uIDEw
LzE3LzI1IDg6NTYgUE0sIFpvcnJvIExhbmcgd3JvdGU6DQo+Pj4+IERvZXMgdGhpcyBtZWFuIHRo
ZSBjdXJyZW50IEZTVFlQIGRvZXNuJ3Qgc3VwcG9ydCB6b25lZD8NCj4+Pj4NCj4+Pj4gQXMgdGhp
cydzIGEgZ2VuZXJpYyB0ZXN0IGNhc2UsIHRoZSBGU1RZUCBjYW4gYmUgYW55IG90aGVyIGZpbGVz
eXN0ZW1zLCBsaWtlcw0KPj4+PiBuZnMsIGNpZnMsIG92ZXJsYXksIGV4ZmF0LCB0bXBmcyBhbmQg
c28gb24sIGNhbiB3ZSBjcmVhdGUgemxvb3Agb24gYW55IG9mIHRoZW0/DQo+Pj4+IElmIG5vdCwg
aG93IGFib3V0IF9ub3RydW4gaWYgY3VycmVudCBGU1RZUCBkb2Vzbid0IHN1cHBvcnQuDQo+Pj4g
SSBkaWQgdGhhdCBpbiB2MSBhbmQgZ290IHRvbGQgdGhhdCBJIHNob3VsZG4ndCBkbyB0aGlzLg0K
Pj4gVGhpcydzIHlvdXIgVjEsIHJpZ2h0Pw0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZnN0
ZXN0cy8yMDI1MTAwNzA0MTMyMS5HQTE1NzI3QGxzdC5kZS9ULyN1DQo+Pg0KPj4gV2hpY2ggbGlu
ZSBpcyAiX25vdHJ1biBpZiBjdXJyZW50IEZTVFlQIGRvZXNuJ3Qgc3VwcG9ydCB6bG9vcCBjcmVh
dGlvbiI/IEFuZCB3aGVyZSBpcw0KPj4gdGhlIG1lc3NhZ2UgdGhhdCB0b2xkIHlvdSBkb24ndCB0
byB0aGF0PyBDb3VsZCB5b3UgcHJvdmlkZXMgbW9yZSBkZXRhaWxzLCBJJ2QgbGlrZQ0KPj4gdG8g
bGVhcm4gYWJvdXQgbW9yZSwgdGhhbmtzIDopDQo+IEFoIHNoKnQsIGl0IHdhcyBhIG5vbiBwdWJs
aWMgMXN0IHZlcnNpb24uIEl0IGhhZCBhIGNoZWNrIGxpa2UgdGhpczoNCj4NCj4NCj4gX3JlcXVp
cmVfem9uZWRfc3VwcG9ydCgpDQo+IHsNCj4gICDCoCDCoCBjYXNlICIkRlNUWVAiDQo+ICAgwqAg
wqAgYnRyZnMpDQo+ICAgwqAgwqAgwqAgwqAgdGVzdCAtZiAvc3lzL2ZzL2J0cmZzL2ZlYXR1cmVz
L3pvbmVkDQo+ICAgwqAgwqAgwqAgwqAgOzsNCj4gICDCoCDCoCBmMmZzKQ0KPiAgIMKgIMKgIMKg
IMKgIHRlc3QgLWYgL3N5cy9mcy9mMmZzL2ZlYXR1cmVzL2Jsa3pvbmVkDQo+ICAgwqAgwqAgwqAg
wqAgOzsNCj4gICDCoCDCoCB4ZnMpDQo+ICAgwqAgwqAgwqAgwqAgdHJ1ZQ0KPiAgIMKgIMKgIMKg
IMKgIDs7DQo+ICAgwqAgwqAgKikNCj4gICDCoCDCoCDCoCDCoCBmYWxzZQ0KPiAgIMKgIMKgIMKg
IMKgIDs7DQo+ICAgwqAgwqAgZXNhYw0KPg0KPiB9DQo+DQo+IEJ1dCBhcyB4ZnMgZG9lc24ndCBo
YXZlIGEgZmVhdHVyZXMgc3lzZnMgZW50cnkgQ2hyaXN0b3BoIHNhaWQsIGl0J2xsIGJlDQo+IGJl
dHRlciB0byBqdXN0IF90cnlfbWtmcyBhbmQgc2VlIGlmIHRoZXJlIGFyZSBhbnkgZXJyb3JzLg0K
Pg0KPg0KWm9ycm8sDQoNClNob3VsZCBJIGJyaW5nIHRoYXQgaGVscGVyIGJhY2sgc28gYWxsIEZT
ZXMgYnV0IGYyZnMsIGJ0cmZzIGFuZCB4ZnMgYXJlIA0Kc2tpcHBlZCBhbmQgdGhlbiBzdGlsbCB1
c2UgX3RyeV9ta2ZzIHNvIHhmcyB3aXRob3V0IHpvbmVkIFJUIHN1cHBvcnQgaXMgDQpza2lwcGVk
Pw0KDQo=

