Return-Path: <linux-btrfs+bounces-18052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64DBF1374
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4393C3B1CC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8772EC0A9;
	Mon, 20 Oct 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HGJlnhvI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ynryh4lI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4724DCF9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963342; cv=fail; b=CDSRvwqDYJ4z8XVoCe2bngHv/xxmpXoqA6PVPmij8ZomsP2B/dpqhu3iuXJO1V2urIldribQnYkbidwpF/7Hh0cV8PkdroSHovqpMQ90QbJoVEUEU/OaKGHxmhYPf9OnMpEYIokNOCVZ0Qk71F9ibsop4modSePbhhjnBI9H47I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963342; c=relaxed/simple;
	bh=jMHDbx1b84W1+ryek6YjIbXyV0kleH7MShwvWy0ssEU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owy8pr/oMDNOAvQ9IMCJfTtvmEK8OFUdUjxDST8z9ebzp+Iosk40x9uZim0L+ze6sYAGLyr6aHFMdzPPxvfWVf5tus18bloo3p0F6dtSoQ4VgcF4vNbMWwaKeTBlmD6ay2cFukpEAQsAuN7sSb7pr87uez4sHfNktX94GbCZsHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HGJlnhvI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ynryh4lI; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760963340; x=1792499340;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jMHDbx1b84W1+ryek6YjIbXyV0kleH7MShwvWy0ssEU=;
  b=HGJlnhvISdSZWEwqS5G679mWlJXYHey84/3+Le3zf89Vc0k2puBzBLWe
   89lSAtxOBXlAJOJI/Nvjx6IhNmvtqGZr56zlJlgQjyUxoSR7qSNbh+1Bh
   PkFknuSPFZ3G5obTw0pvHb1VdPYrYKsXeENjpau7UnB4fn+sHAdEqn+Jq
   G7yN/gappqr4q+uaO3OwX8Lu2c5mdaKJptLhodWi7f8dufV4sdI0NtB/W
   B807YugLaBwy4oVQ86elD46hOvw0rkyiKJmielya9bUmkknZi7G+BRJnB
   kHNHABHovC84rGpeNf2zJS3yWe6I8ixIRd00GM7n/U5Jvbp+BEZAeT23n
   w==;
X-CSE-ConnectionGUID: psme1xENS0G3iMcPt24sbw==
X-CSE-MsgGUID: Unzed5sRQCK5EX38r9q9ew==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133466968"
Received: from mail-centralusazon11010065.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.65])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 20:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJq1C4uSI4098Vi5mEFOg8qcVwGMIBP0UgkgU6Bbpsl+vSowfW2pleUWf/4czLJXRKbzdYUDPM2kLmHknIgAW24BnyDx3NPmGEyb1RS34wqCn1nPlwCLrtgvRJumRPqr5NeaBpWXM2/UZTNkhyg12PPY7NRxKtU0xjjHK+CT4NHMf58tdYY05T/eqWcxJZQYcU/7tR5U1w84ieHK1XB17qPy5db14E+uUJEMBHFHzJ/y6SI4ntj+T4G2W7ZmzNFU2AECCWD7H3k9rTqYz/DBJ7b28cyIpvvtOI8zO27HEPn5Wlk+Oe77K/aZADR911KMsx35zbwYJemE66XnNoU3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMHDbx1b84W1+ryek6YjIbXyV0kleH7MShwvWy0ssEU=;
 b=gY2K0+WkXOEEKdRprTFFWskls8lJWWtKjIEs0oFfwnt19kVxJObDtEzvQrmQevXUwnh28+gUiwMgnCmfF+9onV/My694hFjDkKV4pD5K21mRPBIxtC0ySoPWnWjOjHKy7M29YpVOnE3oKAhvZQsX0nqTY0H8uJ1WzQCsZqbE7+4+9THbkgoP+h20w5duvXLWWCozll0YWpX0R3fPu96vQnMw6JIQKWCpFUpHvBVL5J2oJnqUaht4OtNh/DBGlrD5YzGnicPtW/bG6gmKK0nlfX8IXdPx98u5xdg8A+dhUao5nynDyrxLVzKI7lUAXgaQsLu4AR0frdd8IXeaQa/7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMHDbx1b84W1+ryek6YjIbXyV0kleH7MShwvWy0ssEU=;
 b=Ynryh4lIcpu6j2xwWIkYJlHrY1RpUwh4g3TPDGePOGJi7SWdSPNj7RDmNZlCLDjb0xR8qQ8t/JjQ1QWvB12XiSuTK3e6ybQrXUzqRZSjPoREF4q9xIkeDiKC4zVNJor6i87xbECs4fzWquFdk/A9djbHzUjtk/xPno6Kjq401QU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7461.namprd04.prod.outlook.com (2603:10b6:510:1f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:28:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:28:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID1 vs RAID10
Thread-Topic: RAID1 vs RAID10
Thread-Index: AQHcQbwVSvrcaHyO6UKsW08sVr/Tq7TK9rwA
Date: Mon, 20 Oct 2025 12:28:56 +0000
Message-ID: <d4ceed41-49d7-48f4-a6f3-a615e798ec37@wdc.com>
References: <20251020122115.GA1461277@tik.uni-stuttgart.de>
In-Reply-To: <20251020122115.GA1461277@tik.uni-stuttgart.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7461:EE_
x-ms-office365-filtering-correlation-id: 1525b708-ba44-4c1a-e1a1-08de0fd43d41
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmJoMXBHYmxVSjk1eVNsQWN2Q1Q1a1c2UWNBUDZ4dzFMZFBLcVdUMWc3d0FV?=
 =?utf-8?B?QWc4TWJlakxIa1RHbGtvam9QOGZ6bWlBUjMvSFNjM241U3Jud1RqMmFIQVVx?=
 =?utf-8?B?a2h4bFZzZ1k2RzRkbjlMT3FubjBQYnI3dENHVnlGbmFnQW9MZnFrbHVSMUtn?=
 =?utf-8?B?K09ySjZSdWpXK1lFTENES29mc0l6NlIyMG56TjMwL0lkZkRReWZXa05VaXdO?=
 =?utf-8?B?Sm9TNUNtNENod0ZhbCszNmJSdmNzU1NFUks0eE5qWXlRTGIyYTNOWmRYdXZa?=
 =?utf-8?B?aXVHTHh3S0pubGpoenorKzBBQXVJLzlhUHpnVnlhZTFjMWQ2RWgyL2JqTk9D?=
 =?utf-8?B?TXVNd1FiTXk3QXB3blc1MVJhZzgyTS8yQ3NKL1FnbVM4OHF0c3R4bFRHUHB1?=
 =?utf-8?B?T04xczg5cVUxWjdYWndOWXk2aUJ3WFVWODlaTzZSTHZ5QVVNc2RhV28rMExh?=
 =?utf-8?B?Q0QzUmQ3cmdkb0lIOWpTaFAxamR5SmM2b2RhMUJQdTZuU1RHTStKcitNNlpw?=
 =?utf-8?B?UHFoQTRONTVyMk8rU3preFpkeFlQd0R6c2h4NlQram10Y0hPSUlDR3VvV3Rs?=
 =?utf-8?B?WmtveFUxMUY0R0hiSkVpTGpYK3loYUtROE5xaWZTbVAwNHY4TVpuRzV3Q1FF?=
 =?utf-8?B?NzYxcnZwQXRHYzM4THVTUWN5bEw3TjdBaTFwY00yZ0NlTnZqallMR0s5TlJj?=
 =?utf-8?B?dkZBaFhUcTNkUEZSaXlyZzVFSENBYXNLS2RQeDM2SHBxZHk4anoyREZYay9v?=
 =?utf-8?B?dHova0VHMkh1d25CM0FEU1o3MGhPdHdscjdOamptb0d2NktLTUJJWEVRdjQw?=
 =?utf-8?B?VHpEMDhlSEl2NThQeDVRNGdVVjA5UnVROE9JRE1pWGI1VFJXVFIreG9Wdk42?=
 =?utf-8?B?LzByWjBsYWlRMmlSMmNCNTBsbDZWOTRVVVNCQ1pKK0p3S2hIQ1RVaTNMRWVC?=
 =?utf-8?B?S2VudCsxZXFQbkZOYWdXd1VFVDJuOFFKcnV4VGxxbWllbDkzTXFwSUt6THFq?=
 =?utf-8?B?elNsdmtjamViVHdkUlRBSENQRmVMWE96bDQzbCs0NUgrNnNIUU4vdkJYaFZw?=
 =?utf-8?B?SnFtclRWaUdPaFFSelRKb2J3S051VzM1WDNpU3NLOWhlU2J5RWFid1ErM1k0?=
 =?utf-8?B?blJDS1pJbmJmYU1EUDBod0x3K2dpY1lXQUZPTEczNmFLek0yQncwdWlXaG1L?=
 =?utf-8?B?SWRRbTJadGJqTnA1c2F1S1BTdkFPR040TmNaVmtPcVhvRldFN2txdFEvcHNP?=
 =?utf-8?B?MlBJdk90bnpMSEFPaUl0bHhTTHd2ZEdYclhXN0l3SElaVEdldjNnYkErN3VK?=
 =?utf-8?B?a1prMzN1L1JxMXIxbmNEY3plckdYdG9SVWNzWklqenptWU9yN1RZajZPa1Vv?=
 =?utf-8?B?dmFKSkxIVzRqTDNJUWNxYnpUSlZXUUQyWHQ1NHFLTURacjVpZmVkalFLWGpj?=
 =?utf-8?B?RFVMODBsSlVtZHJvRWtIdDg1bVVtaVJ3T3h2d3I1SHlLVG4rSjV6ZFh3TXV4?=
 =?utf-8?B?cDBGYUd6L3lja011RmdIak9lZ3E4YXQrazIvY2xWTVRRYkRPeFA2T2VrU3BH?=
 =?utf-8?B?R1NhUUZPbjZxQmdBVWY2WEdqV0cvZFE1WDNGQldVSzM1c3JRZ3RZTW0zdHNm?=
 =?utf-8?B?aDFoUkkySE5Ba3o3RHNRRUtFRDNyaVJ0WTg4RHpGbDhUN1lYRThKczZFRTR4?=
 =?utf-8?B?ZDRlVTc1ZVArOFo2eHlyN2wvMDk5OE9pZjduVGJ4MjdiaExlYjFxL2VNTkdC?=
 =?utf-8?B?ZG01c2VOVkdBZE5RV0VaVE9FNXBRaTFBeHZMZE84cno3cDU0OUN5REUxYWwy?=
 =?utf-8?B?dVJBS1lqWEpEY3UzUjRDV3h2QlV2UDN1U2grWDdQcWswVllOaGxHaC96Z0dy?=
 =?utf-8?B?azBMbEYvemlnYlNuRGRaS1FUUGtqRFZUdlpHYXZwZDg2dGo0U0U0WG9jTzVi?=
 =?utf-8?B?MGlNZHNFbmlSa21aeEl2emtmem1FNGVmelBrOUpPOUJvVmxJTUlwSEVnaHQ1?=
 =?utf-8?B?MDMwWnJ1T0xBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTBsbm9nbkNKRXFzSjFKTFRGL3pqMWF2MWFwZEtNUlJVV0RhaEN3V09RSWsx?=
 =?utf-8?B?ZFoyVkV3b09WUFc3Q3lPTGM0dkdjSXJFbmhFVHNRemxMT1IxR01QNWpabGpk?=
 =?utf-8?B?VHdmandJdExmbEE2M1FCWTZ6NVA5dFhRSGh3V3c2Wjh2dEplOGRIUFY0QTZS?=
 =?utf-8?B?alY1dnFyQk10UzRDeThmRXpCVVJqd0hLc04rMTVXNzM3cmd5V3FZNEF1WFFs?=
 =?utf-8?B?dnFaeHFJS2Nab3Vrb0hxU0I3K0VKb0JvOGtTbHIwakplMkwxR0JyNDl3MUpY?=
 =?utf-8?B?K1Foc0MyZlN5MEdtZTNEK0FxbW84UXlEVFpnbE1LRVlTdUxqK243bWt2THNM?=
 =?utf-8?B?VGhzUzQyL3krY1VQOEhuakNkVk1jYkFsZ1EwcHQvb0orR2JNUEk2cCtUQzJY?=
 =?utf-8?B?SXZEMjdqUmZ5emN0dUtSdlZHV01FbmVZbDZ1eFF2U21jMHpxUnVnSlpnSVFx?=
 =?utf-8?B?TG82OVlVRFM4cSt0d2JMSFFrZXhQQllMOFNNMXpvSzgrNkFLb2ljeWxFWEZv?=
 =?utf-8?B?cHpkckFPa3BaKzdKZFBmc2h4Z3BrK012Q012dnRxSktjR0wyUzRVem5SanVZ?=
 =?utf-8?B?QVpad043K215MDhrcUZBbFpYK1BBMXlxZWhlTjVSZ0hUNlhzdS9OYlNlTzdJ?=
 =?utf-8?B?dk9heTgxUDUrN1VIaVBOeHB3eVdDUW1sWlBYNlZEVGFweFc5cDV5M1dmWTNk?=
 =?utf-8?B?eU5ORHZuYzFIU3pna24yRDNHNTFPNVE4cGRma0pydktDUVRwR21QVTBQRDVE?=
 =?utf-8?B?emtlZkNJbWwvMlBZL3llTjhkMkcxS2srbFBza0ZKaDVGV1FwK1lpSy94U3Ev?=
 =?utf-8?B?LzFwODhZTzd2MkkycjlJaFhTV2VNVitpVEdLalU5VnU4Rnpjb29ua0NLN01R?=
 =?utf-8?B?L1B6NE9yVmN0eStYNUNTVW9zR1lWYWg5cFNsSXFHT04reEJKNXlSdXlVRnhV?=
 =?utf-8?B?VkttM3JvSW0rSDg5N0ZkVm54b1JYWXgwNHZIUEdwbytaWHROMm9CYUZ1blVo?=
 =?utf-8?B?U2E4WVN5aFppalk2Mmd3TmhLTDlKclNKSkZPaGtFeTBGLzkwSlBndVBSK1RL?=
 =?utf-8?B?MURmRy96Q3ZzM0NWSU45b1dQb3MraHpSeDF2RVFucXVVZDRDbElsMmJBSFdi?=
 =?utf-8?B?SEtJRkZraStVUHpoZGRNcktWZnZ2S0FMaGt6SWw4d2YyOHBMTXJtRm9jNEZv?=
 =?utf-8?B?NldVTFVVam0vV0RIei90WEpTMkNPMEROWGNFalVxWTNiaWh5dEhKSjVSZkhv?=
 =?utf-8?B?N3V5YWxJVnBwTDZROHZGWEdYYXJEVzkwU3h1VXhldXBXOTdGWWR3aUJoaGx2?=
 =?utf-8?B?OFhYU2R6VFZ2cmM0MjVCdGl5czNoZC82MCtlUWQzbUQxdU8yTGdFaGlYbUVo?=
 =?utf-8?B?MWM2cjRFVXpHWU4rZWpLWlkrcWxlOTQyTmNnUTBOZHBpSTc4NWlZRWdiY0Y1?=
 =?utf-8?B?cXZLMFpXTHh3aVNUQ2k1R2Rlemg4K0hwUkM3ZWpSQ25wcnFxL3ZwK01LSEs5?=
 =?utf-8?B?N1ZaZHlnOTZ0dUlqcHhONHVkdy9KdGlIVmxoaDdTNnFhZlNRZndOUG8rWDJw?=
 =?utf-8?B?bE9nN1NEblB1RVM0N1dqWkk2eUkrRmJFclQvbDdqUXhacXlaSlkwRWYzNll4?=
 =?utf-8?B?VW5KRXF6WURDTGYwY2pNZUt2anlkcTYyeENXQTh0a3JKdHU0b3ozVUlpU3Ew?=
 =?utf-8?B?akRvdG9jdC85OE5CMWFIanRZYjRGeWpUR1hwcFNtRDZWa2ZrTDd3MklIU1My?=
 =?utf-8?B?QkV0MlYyOGFaeVN0REpKUzc5eklhVGlGcTQ2cDhSajZmRmp3bnJNV2J5cTFw?=
 =?utf-8?B?d29qditRY0k0dDYyYnhROWJqU0lwUGZiMi9BOTliZm1zcHdQWk41dC9RQ21L?=
 =?utf-8?B?c2ZVRVhqQ2NYbDZpQjYwb2FyVy9xZmN0SGkrN3YzMmZudktRUW56Tmh4SUFJ?=
 =?utf-8?B?UHRGeHRBWGw0Q2hIbkwvWWo5cjU4Z3FaY2s0MlhXK1YxYWhjbmhFaVVLNUk1?=
 =?utf-8?B?Q3ZQOG82dmlYTTNjQ1Zsb3dBcktEaWdvVlBzaUZiN0lIV3dOTEZvUE8yTlV1?=
 =?utf-8?B?WFJBVDZlZ0ppUmZUSk9JWUI4S1EzZGtJbk1TWmJ0eks1RDNneGRyc2szZVZC?=
 =?utf-8?B?ZkRhM2QrV1JKOGtkZk04c2hSY2RNWm1FU0xWaE1PZGhRQkprbjFUMzVyVFdV?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95995610E7F79F41AF9E013541BE7B72@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P9DkRx460xLIPmM4N6pYpmsuyq/6LzPCpR+afXR25CYaP5e8ZAR2qhtxwq9w32JzUsqFb+qQ4Q71Ah7ekdsPrLtTvP73LIHz9Yy6VGr4jEJAb/qQA1Kh4qrFTi8LidCD/W68GL7Uho/SmEXmFsxvyUdC6E765UOVX2O6SXgXiZwv9SaSfLo373USL9B0axfAlvuqOw2cK3Qp8tY4tBHFJJuy7D8DIBnTZJtdoCZSl5jKY3qGXmPT/3DSt+yby3BgbEXeR3ewWRHvgLkUXrArrZ/cu/jTKQAS+tYqnU9RvYGYsiDx6bSSO+FRR73lXeHB5cddq87p9UO+cweyhkIiwJxFGWa2Gv9/NPAjazSOafTsRq6nJIf01M3x1XFQ30ZzHxkrKwDwscehhh9PxtmqM3q6xeuN5jtoyoMzedeBIfaZ3uegTuyi4I34Y4/BP/xH0UCxak6BvAf5YEJOCLdTlQB2WmU0M5tdwniG5/U1mIkeZ/Z/otjnH8xqA7SZNOb3hb0+PG3zOG4jXM4koXgB3gPkn3k90Lgbcu3hwF+YlRG4124FWvh8XAUAYq4u6xyNpZ6QVur2YlUwvoTOr9yEmFDhchADZaZOh+LNDYI7wXs6C3qzdKgFLL2g2iYrz0nd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1525b708-ba44-4c1a-e1a1-08de0fd43d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 12:28:56.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBBkfZAB+/gMJJoWTncj+1OCgwCZJHSgQd8kRojVqp9dNVXJ7RAagdt2y7PvEa9YBdl54Ddr5EAyAyJbv5NV2LLtmoJJM8fU/e94sz/kAhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7461

T24gMTAvMjAvMjUgMjoyMSBQTSwgVWxsaSBIb3JsYWNoZXIgd3JvdGU6DQo+IEkgaGF2ZSBqdXN0
IGRpc2NvdmVyZWQsIHRoYXQgUkFJRDEgaXMgcG9zc2libGUgd2l0aCBtb3JlIHRoYW4gMiBkZXZp
Y2VzOg0KPg0KPiBodHRwczovL2J0cmZzLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9ta2ZzLmJ0
cmZzLmh0bWwjcHJvZmlsZXMNCj4NCj4gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZSB0byBSQUlEMTA/
DQo+DQo+IEkgaGF2ZSA0IHggMy44IFRCIFNTRCBhbmQgd2FudCBvbmUgZmlsZXN5c3RlbS4NCg0K
Rm9yIHJlZ3VsYXIgYnRyZnMgUkFJRCwgaWYgeW91IGhhdmUgbW9yZSB0aGFuIDIgZGV2aWNlcywg
YnRyZnMgd2lsbCANCiJkZWNsdXN0ZXIiIHRoZSBkYXRhIG9uIHRoZXNlIGRldmljZXMgKGRlcGVu
ZGluZyBvbiBob3cgbXVjaCBmcmVlIHNwYWNlIA0KaXMgYXZhaWxhYmxlKS4gVGhlbiB0aGVyZSBp
cyB0aGUgbXVsdGkgY29weSBSQUlEMSAoUkFJRDFDMyBhbmQgUkFJRDFDNCkgDQp3aGljaCB3aWxs
IG1ha2UgMiBvciAzIChkZXBlbmRpbmcgb24gdGhlIGxldmVsKSBjb3BpZXMgb2YgdGhlIGRhdGEg
DQppbnN0ZWFkIG9mIDEuDQoNCg0KUkFJRDEwIGlzIHRoZSB1c3VhbCA0IChvciBtb3JlIHNlZSBh
Ym92ZSkgZHJpdmVzLCBjb21iaW5lIDIgaW50byBhIA0Kc3RyaXBlIHNldCBhbmQgbWlycm9yIGlu
c2lkZSB0aGUgc3RyaXBlIHNldC4NCg0KDQpIb3BlIHRoYXQgaGVscHMsDQoNCkpvaGFubmVzDQoN
Cg==

