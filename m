Return-Path: <linux-btrfs+bounces-15467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE1EB019FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C13B73DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB00288524;
	Fri, 11 Jul 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OhG/bUMg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wKM/nFyv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485F2853F7
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231189; cv=fail; b=CWnUn7y3bTr6ppv0HAzu+1dzjQtxMfwIHiUiPwM7iLXSIypiWR7zYncEqP55G6MSgDBoNJGH+A+iw/my7k71rVgWgSdrBuRRxqsnMWAGHBSuECxL78TNdy8aQs3JATzbrDACklbQZSaltuhlG/DWc4st8V/yGVzwSEwCYU8Ym8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231189; c=relaxed/simple;
	bh=R5tiNDHn2TS82Q1ngMkw7i3Va31ukFNYyGorbLPnc+c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYkk+YSzM1/mhPmFkGR1d/CeXXdNPZ5u0uTi9q1fi2zJ0ihlPVw8B+5igOHxenC5H+7TD0fCQDwtLK5KGay+Yuz18H489ddewQpqaeN3/bduagVZBGgtrpX9PgaL5EWjtVZET9oWQH+b+sTuuPWZKiKn98FlKaEJf8sA5OZyM4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OhG/bUMg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wKM/nFyv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752231187; x=1783767187;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=R5tiNDHn2TS82Q1ngMkw7i3Va31ukFNYyGorbLPnc+c=;
  b=OhG/bUMgFfpFuo6yzAn8T8vGxltjnuVDVv1lWxvTAfQscXRkTfJz0OBD
   GO7iyCSaY6iPLll5GCVnnuJeKw/72JLfgRvcABqS9FWYlEq/ph0YugXlG
   26vfbY2V2yeY7Uoh+9InApFlGKqDywFDb7laFKpibxLPHtkUI8G4+Y35w
   UdUiWg5bhjoW1HwQyC5BD64Gw7RxydBimAi3sV1jMtFauhS/hoREhtPyi
   r/QnaJANbOKtFgJK1Lm62MNqmxVnfG/SSzHOABZuk/tLORhR19jnGLpJL
   +Aap59Jb1gLTtYpiUqjRt+9srXWd4v2kueA9mGXrWl7TQs9kKvvfvJkXa
   w==;
X-CSE-ConnectionGUID: aUWweoSQQ9u9OL4gipZt+w==
X-CSE-MsgGUID: KKowZ+WVShSdxXGuVB4x1Q==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="88688257"
Received: from mail-northcentralusazon11013035.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.35])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 18:53:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h62DHoDigSrz2dcjWk7i7D3Elb12t470YNt3F72TROFXNSS2A6N+bhX3YlquQM4zdkP+L2gkYFpx7S19gf3LC9YprsNJrvtBA/w064sdoriWLOX98YbMP1+pSpBYiM26lZiXGoPlC2zgm9IncAaXEOdQys00dqCXox/HcOzrNv8kZGa1gbatWaML7HA1t7jZuh2pIVLvmCmjsY0BkRKdXZYXVZuWdquAQHPXiB9c2LMoXOE+GIfSVZw4Zv6nE7xBzh/VKgCGummc0gFwXQX8A3qlRP5rxooCOhRzMVUgpFJ13yRIRD0o9xsZJjnDz1EVbzHTsnZ/f4r0dQwv0AFkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5tiNDHn2TS82Q1ngMkw7i3Va31ukFNYyGorbLPnc+c=;
 b=MttvpU+MG/jxTGybBxr5MgLqbd9/TP8WeYVDg2uYNkCZITg0x2Md9BALMIk8BRkDUeHXeV7LQStL7WgczfgN8pRBCUFPpkpn0GzaPGXi2i3fEFpTNPfMDquz/50WOcFPOhe5w/buPiSqtR4dLCCnv7mn2XDxmmfRQSEzWu+7VFUKhI5bvD+JSufWOXwnDV4gmwk4IzlZcSdLHLINh+l4E9OEt8Q6/iCQrxhUaYYVYhleT5CDmWrd0bVW6SEFzrIhuw+3/mugJLOkPAxdqlt7QRDCB7otDnJ/ZIgrOgwRse0WCSObOr/2cWdh9KCM48TG0TU4NFPcEw7EjwpGMhfgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5tiNDHn2TS82Q1ngMkw7i3Va31ukFNYyGorbLPnc+c=;
 b=wKM/nFyvQHif2JxDZrwRKmq9mI5g8TapVAeQI5F5HzcAJv7eC3eYlfJ0sdfmKt5VogmUM2swArabkD0yfUITwDE5D/0H/X4hUEsLA8cuDeEZ4YPZMZSWbVbEsNzhJJ3Xnw7zM2sZlGKh1qXNWQ4fNKLIZ3Kq4v58rtXb7/6mjyo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 10:52:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 10:52:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Index: AQHb8jTaIYS8EMlTRkKQiVLzOTbOBrQsv4KA
Date: Fri, 11 Jul 2025 10:52:57 +0000
Message-ID: <6d2f4c04-c401-41ea-8acb-d633262428f3@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
 <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
In-Reply-To:
 <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: 7af39618-bde6-4eaa-6234-08ddc06918ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUowV0dDZ2xqR2ZWYXRnM2pObExSdE9yT0Ftb0xkM1ljOHJaR3FnQUN5NXY3?=
 =?utf-8?B?QVZNeExsZjFFWXViVnkrbVo1SFFZL205dFFVcWhybFhrSzk4eHg2TEN4VlhC?=
 =?utf-8?B?Z1lPUEpIakRGdGJPOXFPQ29jV2RNdkZrc2s5UmxWeFcycVEvRWdNTmdIQm5u?=
 =?utf-8?B?VUtPYVZIQWcvbVpsVG5DdFhDd1A5YUpSVmZmYlRZRjRySy9GQWRSendsR0xB?=
 =?utf-8?B?RGt3cExkZnpYOXZWemx6Q2hNdFQwNE1qVXFCYzNJb0pUMWJyUE5LTTZLS1h0?=
 =?utf-8?B?c3N2UW1wZnB3VWM5Wlhoa0ZSNWIvUWFVYXlvOFJMWk1KY1BJTFdpeEkyWnUz?=
 =?utf-8?B?U2NuK3VWZlE4RC9qK2Y4NnNzMmNvQzE3aHZsU2JObGhTL1lHYUpYc1doeWxv?=
 =?utf-8?B?L3E0cUthdHhTMUJPUHh3Qk5LRXFKelp0OFA2OXltWkU5UWJhTFltU2puMEt5?=
 =?utf-8?B?THdVaHEwSWw2TDlyMkhCRDFRVTVwY1NXRk1SUWRCdGFGOTYwUkV1anRNMFRn?=
 =?utf-8?B?QVh1eHd2Y3N3NXlWY1EyRlVTY29OeTJ5OXJGMXlaNHNBYlRyQ0tPOFBjOTlN?=
 =?utf-8?B?MjV5dFJyZDdFeUNRTU1HRzhkbXVPVmppNGxvaVRGRXR2S1RTVzNULzdDcVVK?=
 =?utf-8?B?bGJ3RTU2d0lnQWNFc0wxUkxOTGFoaU9KK3BBeXVKc29JUElqaUFhOTdjNEFW?=
 =?utf-8?B?ZS9wWXc4Uk9DUkZkV3ZUd2c4NG5NeEZibmhVaWY5YkcyS0pjYU1yS2tDejhW?=
 =?utf-8?B?OTVBZkhKWXc5S00wdExrcTQ3TnVpU0ZqdWJiVzJWN0lFZG04bzZHd0tHK3lL?=
 =?utf-8?B?VVBjL1UxT0hoWC9Qa3Z0Mjl6UmJSUDZIazBGWTZhTDJ4NFhMdE9HdXZIMy82?=
 =?utf-8?B?Q0Q1WFE5RVJKczdGTGlPWjJWWENOVTU3WmtIS21sRjNYMXY4QTluN3BlL3pV?=
 =?utf-8?B?STdYS1ExUEx4L01Namo0NWdjZE9ELzZ5a3JncEt6SHVKeHVPVkZ2Y2ZvV1k4?=
 =?utf-8?B?S0F0Q2FXbDVibVVIbTEzeFdTeE1hYmd0UjBzb1VqWUhTR2pQdk0wZmRUcWRH?=
 =?utf-8?B?MXNydzhDY0FTSG1VeHpNYWRnbUVocFVpTUt2Q0NDR1pqNHpERy9adlF2cHNv?=
 =?utf-8?B?L0VCckpKTnRSR0EzRkRLa01ES3Qvd0c5N3NrcGs5ZlRQNFhSTDUxbi8xUjJ3?=
 =?utf-8?B?UUNXdnpVa0s4aVVDSkJra1NLZjFMYjF6Z3l4N3poSEMzZTFrRm5zU01yRk5K?=
 =?utf-8?B?MTExT28zaXY3TTVBL3lWbU5oNit1NDQ1YjBlaURzQTRRMktrQzNYN0E4YXlK?=
 =?utf-8?B?dlhwR3dhTWY0UURuU1EyWlpnbWY4OXp1Tm91L0I5T2JtWnlBUElsd2hNYngw?=
 =?utf-8?B?dVArL091bkZNdmhkZk1kMld0OFluNVVGakRyR1lZNjlwK0pEd2VjNHJUUUxy?=
 =?utf-8?B?a2pzR2VlZ3RYRnFHVmNnNzZER0FJZjFUS1FoQmQyRVFEdHMrN3cwOHVzalEv?=
 =?utf-8?B?YVNGVmxLdHlEOEhGYmZ2UGJuWUxCQUZjYmx2RWVCNVNlRnZlaVpUTFFxMG5D?=
 =?utf-8?B?ZGtPaWJsbTJ0V3hGTDNoYmVjdnY0bFd0WkxmdmNwVmNkd1hmdURNdk8zVHRz?=
 =?utf-8?B?djJ2ZVZGTVZrRUZ4cFplWTJja1VZeWlBVWVrZFZTa1MyczZ0eFlnUmJkYk1M?=
 =?utf-8?B?S0JFU1ZoOHlkdGh0ZG1KTWVta2V1RWVTUDY5RTU3My82TGNlY2tienNNL3pk?=
 =?utf-8?B?L1J0SjN2bEZkSXlENFR6NzJtM2NieWpvSGNxejA5V1pkZW5TdFhWM3ZwbEdN?=
 =?utf-8?B?UHUyclVwVEVZTEg2VlI3TmkxRlY4YnVWY253SUdJaGxUZ2xSbG5zSXVlM3lt?=
 =?utf-8?B?VVlpUjJiVEVNQXYzckRBVTZRdjA3S0o5YTkwVWZZUEdVeVNPVGRhZzNQWWV4?=
 =?utf-8?B?Z1VKMzhZVmZKNDNka3JHZkFRSGFvQjJoMmU4SEVMYnMwcTR5WFAvaFN6a3pH?=
 =?utf-8?Q?rF2PwAl+XdxIJgWPu/S5zctWVq3HEk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlE3YjdPOXlqcGdSNjh4UGJROVJpcTc1SStWWlIrSkQwM3dsRjJycXVob2J5?=
 =?utf-8?B?VnZmbHdxY0E4R2VlbWZSSUZVMThWZTR3NFNuQUxyU0dxeFdKTlRtSEZBUDly?=
 =?utf-8?B?M25RR0NPM1JIMDhDQ3pCUDBXbnZuU3VYV0ZZTnhrcVg4SFZ1OWFIcW11cURX?=
 =?utf-8?B?bUtjQUEzVnUrN3hhenRmZ0ZpaTY2NUdmZU5mLzlrQ25xV2pOK3pRNTZrVlM5?=
 =?utf-8?B?ZTZyaEhScm1RUzBHS0Q1eVVqaTlNY1pGL2RWMGlvbFZuUTNlM3BTYWk1TTd2?=
 =?utf-8?B?TWo1VExrZmFoQTdKZGUrNWk3R295NVBwOWo2SUtuY3BvMXBJTklubTV1cFhx?=
 =?utf-8?B?aHZ1bjZUYnlPdE9XWmxZNU1jV3ZzV09GMWZWekVRaWNuZ2xISm1LdTFkZHpp?=
 =?utf-8?B?ZjhyNEFYblpwWmplZjByUkNPY2p0TGlNOUJWZFZPcGo4cDM5bUk4R0NYRTN0?=
 =?utf-8?B?NDh2OTlJbjNTeGx5NHhVR0NaaytXOXBLZzdFMnhFcDFRcHVZWm00U09PcGgw?=
 =?utf-8?B?eXFRSXkxZjd2b2lnMG90Rmo5b3loZnhMRENCRWR6dEtqckE0elkraXpqWkJB?=
 =?utf-8?B?WXQ0UGRGQUcyYXdzUk52M05tZU1ia3pCN2hrbVNPODMwcnRPVlV4N0ZRaWY4?=
 =?utf-8?B?T1hGVmZxOUZ4UFVORmw2OW03K01RMGRhY0dlYTFtMExHeHZhdzFjbmp0d081?=
 =?utf-8?B?eEtteG5STHR0SzVCQ1dSOFJVQjg1WGVpeFFXM29Ta1BINzBBYUJUcVI0ejZz?=
 =?utf-8?B?dS9NY25BNDNtUTR0MGlaV1B1Z3cxT1Vxci9hK1czdHVJS0ZzT2xGWWt1UlZl?=
 =?utf-8?B?MmhFaWdiNmt4amU2YUN1TUFmUVNBQnJuZlpFWFQwSXQ0RERVYWt1Sy91Vy9Q?=
 =?utf-8?B?NUtxdXhaeGhWMXZuRDFZdXBOYjd6YVpBT1FiQ2wzblVHWm5GekpQZTdXVHBV?=
 =?utf-8?B?TmtiVlRXTXB2aGVaSG1LYXB0ZHhRV3hjK0MzV0hBNmdpcFBoVGN1NTl6TXRR?=
 =?utf-8?B?akJMZnZ2Z3gvQ3BLSDdsVlJwRDRLb1Y3NWpaRDI3SU8wTzlydHJseklHdWNv?=
 =?utf-8?B?Rjd3akdmSFJvbjR3Y1A2M1c1MzBZMkM5V2VzY2V0N3lJNEN3WUFzUitFOGd6?=
 =?utf-8?B?a0NLZEJyWEZUVGRpTTBrajhZcjUwYVFBT0Q0VFoxa0Q1d2xXOEhrdG5XR09m?=
 =?utf-8?B?cnVVTmIra0VHTEhFdlp2RC9CL3UvL2MvNE5PdDFQVlpOTURrV2NycGVyL0dS?=
 =?utf-8?B?aXFyWkpwYnhGc1IxOTBFWGNvZ01XRWthN1VUMGU5eHBMQ1FtdzhUZ2FMOE9o?=
 =?utf-8?B?bW4rdThLaXByVVd6Z2FycWFGZnZpK0RQRlV1cjdIVE9vUmlocjl0VW5LSTNB?=
 =?utf-8?B?M0pmS3orWG9sMm1SY1hIVkZ3aVVWNWY4ZTNKTEtGQUZ3NmpmYy9STFpSUFp4?=
 =?utf-8?B?UzFBZ3QzOFltMnQxRnFsK243ZHFvVDJjV3BHY04yNXRCRlNCdzBObnpEcUJv?=
 =?utf-8?B?cllpZGFuMmJJNFdTeVlaNGVweFNQTHBMZkVNb3ZtYkcyKzduaXp2SFlNcXR1?=
 =?utf-8?B?NUVZUEd6SzZQTm1JRzF6UEJyUm9mZkFlelRPaHZxVEtrY2I4dE9COTQ4YlNI?=
 =?utf-8?B?cVU5aEpiblU1WXMyWGtNWExzNTBsRWFvVWpUSHdBdDZNaFduSjBldTNkK1pH?=
 =?utf-8?B?MHVjVE9zd3M4Y2twcEZKRHkxQktGNC9aNDZzVSsrSEdrQjB5eG0xMFZnaGFx?=
 =?utf-8?B?WXFzaVJ0M3QzQXdNYmxKcHU3cGdJK2VNQlJFelpmWVZ1MnVBZ2l4Y3kvbS8y?=
 =?utf-8?B?UWhycTQxMkFVNGR6NjNmaDNRRW1hYkY0R2V6VGVaNnl1d2RianNUTnp4RUJh?=
 =?utf-8?B?djUzNm5CVjNGcWc2UTBLTTFheTFCQ3E1elYwdVlTd283QVc0aGV6dHFaaENR?=
 =?utf-8?B?eW9tS0pBVWRjZ3owdnpZYndNdEFGQnFBWHE2bEwyYTVIM0gxTzZQSzB0Titt?=
 =?utf-8?B?T0oxSVRHelRvNDA5ZmdEaFZKUzQwUFlDK2VUdkZwcmZxam5Yd1kxa0kyUVQy?=
 =?utf-8?B?M29MUWQwN2ZSY09HUWJKZm9iSTV2UytVc1Y3WUxDVGMzcFBiMTZ2ZmRvWnZE?=
 =?utf-8?B?Vk54MXJSUWx2Wk9sRVBmbzNnYnh3UWFPd1FtcDEzOXBRME1XdmsyUSswYWdQ?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87411CB12B6CEC49BB3344FCFBC9CBA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vJJQKlOBstN0t+5TeBkuu9BNFLQX7+lHA6VGi6aqT4/MAD7xG5NBUpKLSHh2IMiJA15N0yPJdy3L84k5Zb8NtEov9wCoaI0AjBv3pqXB7f9/agqM4x1BK+rsQC8OKDOzIc1o5Z6NgMg6EhRc5BBTAiH1LuDv+/chP8cC0EMXCEyX7CofHxOWGygCONx26mS3/Es3ihVaEUpdwTOf/qS2GJUawYvPsD0OiTfOdRDuGKSCK5iRtUtOv0LDHvwqJ/TL+KDHNPqTau/qSRhLgxY1hvK5FzvF9VrXf8JyCFqDhVy38TvIAKbM1uCmrsCjxFdUORPFpqW5kMDxMEhVI+4TCXKCocYYyPmr9OGVDHIw+4d9Je6ua8JlZbIOqe0PZsoj0Bs5NCcwMH2DKzob09hsbklrzxoePIrsf2fX0ssyGgKQZ8VIWity/A25P5wkkX6StfPKX2aE2s7sdYAKQNFPNB6+Ygn2/egaAnbxlgrCfS7IQxv+1IWdwokB3yBzZ4/cgazhRV6UAQ3SmSJ+2rdrJb+HjZdy1NLo4OXC81jbRqY15TmN2S+CWJcebmVmT8OyBtsuSmyBACISsEHtRdwLuvygGLRjaXGwbb2UwoJbIgy6cuNrCm4gpyAWWZNCyBnG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af39618-bde6-4eaa-6234-08ddc06918ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 10:52:57.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lJhUHjaiL0wGQM7vbaJoEY2BSKlJsn9H6K+FrAyq3JAJPT75lfV/qIaKgyt2ZDOj2gSHJEs+MAPfPl68IdiT12DfajtaCkpN6IZ6vyuX8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

T24gMTEuMDcuMjUgMDk6MjQsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gKwlpZiAoYmxvY2tfZ3Jv
dXAtPmZsYWdzICYgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQSkgew0KPiArCQkvKiBUaGUgY2FsbGVy
IHNob3VsZCBjaGVjayBpZiB0aGUgYmxvY2sgZ3JvdXAgaXMgZnVsbC4gKi8NCj4gKwkJaWYgKFdB
Uk5fT05fT05DRShidHJmc196b25lZF9iZ19pc19mdWxsKGJsb2NrX2dyb3VwKSkpIHsNCg0KSSBn
ZXQgdGhhdCBXQVJOX09OKCkgdHJpZ2dlcmluZyB3aGVuIHJ1bm5pbmcgZmlvIGJlbmNobWFya3M6
DQoNCg0KWyAyMDU0LjYzNDgzMV0gUklQOiAwMDEwOmJ0cmZzX3pvbmVfYWN0aXZhdGUrMHgxZTAv
MHgyMjAgW2J0cmZzXQ0KWyAyMDU0LjY2MDQ3N10gUlNQOiAwMDE4OmZmZmZkMjBmMGJkMDM5Yjgg
RUZMQUdTOiAwMDAxMDI0Ng0KWyAyMDU0LjY2NjA2OV0gUkFYOiAwMDAwMDAwMDEwMDAwMDAwIFJC
WDogZmZmZjhiN2Q5ODc0N2MwMCBSQ1g6IGZmZmY4YjdkNDcyOWY1MDgNClsgMjA1NC42NzM1NzZd
IFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAwMDQgUkRJOiBmZmZmOGI3
ZDk4NzQ3YzEwDQpbIDIwNTQuNjgxMDY5XSBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiBmZmZm
OGI3ZDVjMTNiMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KWyAyMDU0LjY4ODU2M10gUjEwOiBm
ZmZmOGI5Yzg4MjM5NDgwIFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmY4YjdkNWMxM2Iw
MDANClsgMjA1NC42OTYwNTBdIFIxMzogZmZmZjhiN2Q1MzE1YjAwMCBSMTQ6IGZmZmY4YjdkNDcz
ODk0MDAgUjE1OiAwMDAwMDAwMDAwMDAxMDAwDQpbIDIwNTQuNzAzNTQ2XSBGUzogIDAwMDA3ZmY0
NWE0YjI4NDAoMDAwMCkgR1M6ZmZmZjhiOWQwMmE3ZTAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwDQpbIDIwNTQuNzExOTg5XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQpbIDIwNTQuNzE4MDkwXSBDUjI6IDAwMDA1NjA1MWE4OGRmNmMgQ1Iz
OiAwMDAwMDAwMzRkYmMwMDAwIENSNDogMDAwMDAwMDAwMDM1MGVmMA0KWyAyMDU0LjcyNTU4MV0g
Q2FsbCBUcmFjZToNClsgMjA1NC43MjgzOTJdICA8VEFTSz4NClsgMjA1NC43MzA4NTRdICA/IHNy
c29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQpbIDIwNTQuNzM1MjMzXSAgPyBidHJmc196b25lZF9y
ZXNlcnZlX2RhdGFfcmVsb2NfYmcrMHg3Ny8weDIzMCBbYnRyZnNdDQpbIDIwNTQuNzQxOTE1XSAg
b3Blbl9jdHJlZSsweDdlOS8weGI0MCBbYnRyZnNdDQoNCkJ1dCBiZWZvcmUgdGhhdCBJIHNlZSB3
cml0ZSB0aW1lIGVycm9yczoNCg0KWyAgMjAzLjIzMDM3N10gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
aCk6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UgL2Rldi9zZGgsIDExMTc2MCB6b25l
cyBvZiAyNjg0MzU0NTYgYnl0ZXMNClsgIDIwMy4yNDA0NjVdIEJUUkZTIGluZm8gKGRldmljZSBz
ZGgpOiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lIHNpemUgMjY4NDM1NDU2DQpbICAyMDMu
MjUxMDY0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RoKTogY2hlY2tpbmcgVVVJRCB0cmVlDQpbIDE5
NTguNjg5OTQ3XSBzZGg6IHpvbmUgMTMyNDogQWJvcnRpbmcgcGx1Z2dlZCBCSU9zDQpbIDE5NTgu
Njk0Njk3XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3Ig
MSwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KWyAxOTU4LjcwMzQyOF0gQlRSRlMg
ZXJyb3IgKGRldmljZSBzZGgpOiBiZGV2IC9kZXYvc2RoIGVycnM6IHdyIDIsIHJkIDAsIGZsdXNo
IDAsIGNvcnJ1cHQgMCwgZ2VuIDANClsgMTk1OC43MTIxNTddIEJUUkZTIGVycm9yIChkZXZpY2Ug
c2RoKTogYmRldiAvZGV2L3NkaCBlcnJzOiB3ciAzLCByZCAwLCBmbHVzaCAwLCBjb3JydXB0IDAs
IGdlbiAwDQpbIDE5NTguNzIwODgxXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rl
di9zZGggZXJyczogd3IgNCwgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAwLCBnZW4gMA0KWyAxOTU4
LjcyOTYxNF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGgpOiBiZGV2IC9kZXYvc2RoIGVycnM6IHdy
IDUsIHJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgMCwgZ2VuIDANClsgMTk1OC43MzgzNDVdIEJUUkZT
IGVycm9yIChkZXZpY2Ugc2RoKTogYmRldiAvZGV2L3NkaCBlcnJzOiB3ciA2LCByZCAwLCBmbHVz
aCAwLCBjb3JydXB0IDAsIGdlbiAwDQpbIDE5NTguNzQ3MDcyXSBCVFJGUyBlcnJvciAoZGV2aWNl
IHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgNywgcmQgMCwgZmx1c2ggMCwgY29ycnVwdCAw
LCBnZW4gMA0KWyAxOTU4Ljc1NTc5OF0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGgpOiBiZGV2IC9k
ZXYvc2RoIGVycnM6IHdyIDgsIHJkIDAsIGZsdXNoIDAsIGNvcnJ1cHQgMCwgZ2VuIDANClsgMTk1
OC43NjQ1MjVdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RoKTogYmRldiAvZGV2L3NkaCBlcnJzOiB3
ciA5LCByZCAwLCBmbHVzaCAwLCBjb3JydXB0IDAsIGdlbiAwDQpbIDE5NTguNzczMjU3XSBCVFJG
UyBlcnJvciAoZGV2aWNlIHNkaCk6IGJkZXYgL2Rldi9zZGggZXJyczogd3IgMTAsIHJkIDAsIGZs
dXNoIDAsIGNvcnJ1cHQgMCwgZ2VuIDANClsgMTk1OS4zMDY5MDhdIEJUUkZTIGVycm9yIChkZXZp
Y2Ugc2RoIHN0YXRlIEEpOiBUcmFuc2FjdGlvbiBhYm9ydGVkIChlcnJvciAtNSkNClsgMTk1OS4z
MTQwMzBdIEJUUkZTOiBlcnJvciAoZGV2aWNlIHNkaCBzdGF0ZSBBKSBpbiBfX2J0cmZzX3VwZGF0
ZV9kZWxheWVkX2lub2RlOjEwMTU6IGVycm5vPS01IElPIGZhaWx1cmUNClsgMTk1OS4zMjM0ODFd
IEJUUkZTIGluZm8gKGRldmljZSBzZGggc3RhdGUgRUEpOiBmb3JjZWQgcmVhZG9ubHkNClsgMTk1
OS41MzY5MzRdIHNkaDogem9uZSAxMzI1OiBBYm9ydGluZyBwbHVnZ2VkIEJJT3MNCg0KDQpUaGlz
IGlzIHdpdGggdG9kYXkncyBmb3ItbmV4dCBhbmQgdGhlIHR3byBwYXRjaCBzZXRzIG9mIHlvdSBh
cHBsaWVkLiBXaWxsIGRpZyBkZWVwZXIuDQo=

