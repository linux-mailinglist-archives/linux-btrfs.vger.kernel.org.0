Return-Path: <linux-btrfs+bounces-15086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F455AED478
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 08:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E596217224A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C061F03C7;
	Mon, 30 Jun 2025 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FTw1wMMj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0DpgUAvH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECD125D6
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264713; cv=fail; b=tT70Ov6D/RN8jkg8qmLokvCa0Y/wbuUxL2nNRauDremoopuaYVleuoRRpaKRb2GsgKp8dy+jiwW54TUgzxtvOJpKj/T2GUrXgEpU6DS833PuUslTJrpcb+D5onvAyHqH0uPB9HX9J2inY2ONHuQokheF2VPcdlJpJaS37zcw8Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264713; c=relaxed/simple;
	bh=Fm4/AlQYAc8vdCPl+oIA/ABx1mcUX2H9RKx/KVXeDzE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHi5oXpkSjxXU6Q0J+oLHaYzKa3ug4eHZbTG39OtJA8eOY04OXpKNEP5Ge4S9O8yvONSUg4V36NZ3WOGwckpRAp7s/+CyWB0oH4PB6qf+hC9EUJcrHsPi2ihSxoaM4t3/xS6/SzIRhBZEJ7nPAqMJl3UDcXtpH/b7fgmvw8A5g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FTw1wMMj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0DpgUAvH; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751264711; x=1782800711;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Fm4/AlQYAc8vdCPl+oIA/ABx1mcUX2H9RKx/KVXeDzE=;
  b=FTw1wMMjVhMML97mkcrgPSKUD8UG+70CGlZIWAgcPwced6CeYlXWV0Ig
   Omvs6wvz8yklAyJce40+7kobuhYmoT30MQwDj/607E87iLUDBMNRvf7mq
   X53vaLAhUywFnsOeCt4nccNqGvhKfeACyyhr/pfvtvzdhpsALEtnf5BNW
   5uMp/ecHhnL0CmbOCysfepAUJ3IsosPBgHRsz/Iq0DM4nCuuXN0oyA03q
   Ccaici4VzfYrzHGYuVL+PL3ElnfTwOkUQjdvbrkrhI3kfKHD1zi5dDtxZ
   GEJb2DHBEo+PjZw7BNpbQpePJ8bRfrFOneOeJq3edd2IZkfz0ZfIKbIPm
   Q==;
X-CSE-ConnectionGUID: ua6ZwV2HQMiYxsigGCcT+g==
X-CSE-MsgGUID: 0EpfpGo7S02VVMZHlUF4pA==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="86218772"
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.75])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 14:25:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU8l3iwuqhYcs8zb9bjUNbPbBAJwr0rNFiMJfgdAV/S19LXcgXWuutxBocLxVsmXzOkzQorQTcUnmyDmsqV4BI6Xaw2LJFUj9EzgliF5s2EbbZIFR51OErePuz2+A/1/Yh/vcV68ew1mLyDyM02rzlB2WUiN2ZaKUAvde/vsxYi+WUcaWT+WgVs3gl3CANCy5PwwJB82SiONbcjEZ4CmruYXWGjkfz/YY/ZKCtv40WmVOMIeIZCwOMsm+gH6Shjk3aLLgM+oxwuef+PgtlwlpaTnLc8/Bvc2wZN6620UZoorgvD/faS4w/1qJnv4mp+i4P2kGADZDRR7LEXQVGEHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm4/AlQYAc8vdCPl+oIA/ABx1mcUX2H9RKx/KVXeDzE=;
 b=yaQiKwG5Ln+1Z/uLRx2zYNjVEdBpIQyKrDJV7bmlYe4bM3wdQyyydRyvbYogi/CwVgoyiZrBvIP2717C1R8OvAttGHrAqJm3OwbUGk1PCef9wM29qqCClLdVrYc9lMm3U4kq6/OsSefFTJGCGV+UjDSsObAkPB8iEgVEdmvNneQM4bgkuIklgwpHmiyvuIbo+3kClhFJDzzNJykcKJUwlcaZgsJVl1Wup9Dhv/kzwZyDDoP98z8+7QcXx4HgrQDa/x+v9MLKUPBewstNamBYConLf/NPz3zzisd/LQbhGtQ994D9AOswtf99v8DoLxteeGTCrBXZyuf0q9jrHzMKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm4/AlQYAc8vdCPl+oIA/ABx1mcUX2H9RKx/KVXeDzE=;
 b=0DpgUAvHoTIEFo5v0qAZFO/48i1J8MHnSclPQ9FtYIISe7e6QLN3N2nZxv5ZO/Xa9Xi5QBAZbxcuiS3jIzSgyQjuBXvJgWQfQ2C6jTDtenyqvZbAlYJ1R2GFvlsR4XYm6BNETY0gL9tHAlS2SCg/9H/OvYGWwQ9oZFaT6rQiiJs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8757.namprd04.prod.outlook.com (2603:10b6:510:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 06:25:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 06:25:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Set/get accessor cleanups
Thread-Topic: [PATCH 0/4] Set/get accessor cleanups
Thread-Index: AQHb52xXF1+1GAYkDEuYeoBDK6u5ILQbQJmA
Date: Mon, 30 Jun 2025 06:25:07 +0000
Message-ID: <15600cdf-075e-406b-aae7-e1fafb09fc30@wdc.com>
References: <cover.1751032655.git.dsterba@suse.com>
In-Reply-To: <cover.1751032655.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8757:EE_
x-ms-office365-filtering-correlation-id: 3921a6dd-32d3-4143-8c5f-08ddb79edbcf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjVHL01aZ05XcDNQVE1GT0hub3l1RDh4TWFzUjNBbkppdU1ENExUcks2YVlO?=
 =?utf-8?B?dlNmWkg3d1pES1YxNjJjdmVIekhMREZiNEpNWThpNXhvNEZXTE1CaDlacXdi?=
 =?utf-8?B?TUR0dVByRGt5a0RTUlV2NnlKR3N0blJhcjRSYmErcDNTVmZxbEl0dkF5MjJ1?=
 =?utf-8?B?T3VoV2R5bUtXY1IzTXBiMHdPQ053SXJJM21KcWN3bFFZY2xtaS9KLzNzelM5?=
 =?utf-8?B?cTFuZW0zV1JHclNTVFp6NWx6elcxdG1FbDVtMDdrL3o2eWVvRndrL2lQUUlR?=
 =?utf-8?B?Tk90eHdMYlMrNXlwWGxxdFZWWG40OHE4bGZEYWcrNkorWVUzc1VNRGlnR0Ez?=
 =?utf-8?B?bFdkcWhQT0lTVlVkZW96UkRwNzVxclRDaVhWRUYwMDBmeFgyYTNjZDNoZ3d1?=
 =?utf-8?B?bkFydDdteFRCcWlEVFpKNCtXY0xRa091YXpWK2VQei96TEJXRlMzRFdPZldO?=
 =?utf-8?B?R2ZpYlIvS2NaOWxYaWEzbUh5TVJiTEJLZ21UekxOOWlNYnowRzVvakdtaGEz?=
 =?utf-8?B?elIxSTFhSHRSZHc2UEtrVVpuY0lZRW5HazArUFdQaUNDNWlpWUFxQ2hQNjBy?=
 =?utf-8?B?aEVBaWgzQW8rZ05FL21YaHRKaWZPZWU4ZzAvcUQ4aUlLdTlTVVQwNU5wSHZt?=
 =?utf-8?B?RmVIaVRWM2dPTlhXbEprS080c2Fndm5GSmlZWjI1SUxXakNBVzIzOU9hT084?=
 =?utf-8?B?SHpERDdjdElJVzFIWm1iWDdtN2sxUmFGKy9RTFkzR2ljMHhxL25TVnhwQml4?=
 =?utf-8?B?OW54cDVIc2R5b2Rrd3RnNnFHd2VwQTZ0QWVTT3dhSDBFUldGYkhPTWdRazZX?=
 =?utf-8?B?anRUTVFaOWVWaUdBR1RoMXBjMUo4cEtnMmVyY1Y3Q3o4RjFTR25DWnE3N2pj?=
 =?utf-8?B?eWpXNldicUZSK1ZLVTl0QWY4S3NxV0ZvcEV5TVBmdzhhN3RrNFppbGUzSGh1?=
 =?utf-8?B?K0N4NmkyZHFWRWdLalJmdjN1MHdleTYxMmc4OHZCVXNmUTlFSm50MUdmTW90?=
 =?utf-8?B?eUxRZFlydlBVMXhrMTAzVXVUelVqSFQ2cFpiQ0RNV2hWZnIwSkJmQW9QZytM?=
 =?utf-8?B?UjFoZW5tblNFVUJKM0UvcjVqcUY4NEtrY3I0akUxM1pYRjJadExkYWJjTWJP?=
 =?utf-8?B?bkpaZmJObHNZUytjc2N6OFJCbUtqTFVsZ3JjTURmczk3UHFpRFVtY3pvQWhF?=
 =?utf-8?B?WU1MRGoybG9ycGVsVlVXVkhkc2grcCsrUVBWMGxnS3BUVjRORVVCNDJ3NWho?=
 =?utf-8?B?M0l3ZTB4S0dhd3BUWWVhcUdHUkM0KzY1eTNCV3lFeTB1SlZsRFZISFpJdUps?=
 =?utf-8?B?ZGR1N0VrN3pTUlBiTGFmLzlrbSt3YTFqTENMQmRrQ05COERaWS9KUEJ1a0FH?=
 =?utf-8?B?aTFLV0NNajNUTksyd2gvNGRkcTdwY1FZekpkS2xhaEk2a2s1Q3NHalRsT0hW?=
 =?utf-8?B?dmFVL2p0a25NWWlndm04MjRLcWhoa1gzdFNJeE5PODFUZ1VPRlpaNDFxa2FY?=
 =?utf-8?B?R1lFTG0rc3R1MTl0dHRTZjlpTVJtWmVvdjM1Q2dkcW1jU3AycDlhN3BHa2M1?=
 =?utf-8?B?dmVIWWxBc21lTk1seGFRNnZlRnhpaUNDWUNXaEcraVZ0WmdDaU13Wm5wbE5S?=
 =?utf-8?B?Wi9pOVkxUExYTzdrUG1DVTY2eXZqZ1h2MmJHR1VGeFlvcGVodHdNWkZ5ZTF2?=
 =?utf-8?B?TlVnM3R6NUhKelBWNW0yeFFDa1NrTjRrL0o0aFlUREU1VWtnK3R0SUJGUTV6?=
 =?utf-8?B?YUFuV3hnZDhqcEtOZkRkbEoxZ2JMZktNUjExNjAza2JiSERZTjlVRWdwL3JF?=
 =?utf-8?B?U1FRSE41OHI1S29jWE9iVVUySUkrQlBRY21OVisxWlNBYjlseVhOZjF6dGFn?=
 =?utf-8?B?WE1qRThWZ25xTG1Bem9VZnRabFJ3K2ZGVkp1VitQTmdNNDVCUlQwaTN5dDhp?=
 =?utf-8?B?a0owN0NvaWQ3R2k5dUxLcDlReFlLWEFGVGJYOGtLbVNtWjZqQWIwM09KTVpp?=
 =?utf-8?B?bXF2b3A4Z1dnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1dVeWVDN3g3VGc5SWVjeXVObVY0ZHpVdndEUGRRZXdNR1JIL1UwcHFGdHBj?=
 =?utf-8?B?c1owVldGcFF4dWZ6OVc2SmZNcXlqZTBlRXh2TTA4WjBYM0htaW4wNE1HVzJR?=
 =?utf-8?B?Nnh3UnJlTzdQQ08vVkhuM0M5V1JiZ3FuVnNmcGdHYnBDN1ErZzFBVzBwQm9E?=
 =?utf-8?B?TDk0VGx0Ukd0aVRiK215cmUvc0Z5ZWJCeHduWmhQVndFOXp2YlZUSjNvMEFZ?=
 =?utf-8?B?c2lZMUpCdFZTSHZVYTN2eXlVWE9NNWF4MDN2dnZ1WEZvZHBrMjdlbEdIZjZS?=
 =?utf-8?B?T0ZybjJJbzZqc054cDZ6bkpKeUdLNno2MzAzQ3VXTnpUMXBwSVk4T3dKelZD?=
 =?utf-8?B?ckhtYUpDSWtaOHdMN2dKZVBxcEZKWlV1RzQ2M1pabGQwSlhPN1IxZWhFNzgr?=
 =?utf-8?B?RjI5ZEdZZ1F1TnpJS0wydlpRT0hoVnFIMllwdkhhbTczRGVONFBPU3RDNmNu?=
 =?utf-8?B?ZUkzOFR2TEVZYVQwYlVLRm1Beno2dnVmUEZ2TkxnT00vaVc3aHkwT3AyRmVn?=
 =?utf-8?B?eTRuVi9Pc0U2bnV6VXRtSHp3Mlc5Mnh5cS9HWnl0TjdGTi9qWW40R0RlaFlF?=
 =?utf-8?B?NzMwUklyNjBwV1FaYXFTNFJlNUJQSC84bFRmV1RzdEo0YU9PWHBHeWVXZGgv?=
 =?utf-8?B?aGluM3RhYnNKb2dvVDV0RkNiM0lWTExGYkFpTHNEcXl5V2RycENnMnVGUm0x?=
 =?utf-8?B?bHp1N2Nlc1RBUHpyYkE1TjQyU3Q1REVXdXRTQU1SUW12MzdvaWxXK3o5TStI?=
 =?utf-8?B?a3dHU3FUTUJkYzh2RHI4Skc4UVNmM0hCZndOQk1zVVJaS3lZNXJpOVp5MXRU?=
 =?utf-8?B?ZzNEblNaK09ZdExEZ0ZHSWdWTCt0YjJKSnE2NVNGZGd4a0RCTlZOM29PQzB4?=
 =?utf-8?B?YlpIdHRKeE5QWThIN3hNOW1oSHRmVEVpYUhlWHliYUJCMG83THU0bjZFUGpn?=
 =?utf-8?B?WjdaWmZodzhvREtUaVdpL1FXR0VnQnhlNWNlL3BnVDJHZndNZFVEb0ZFN1ZG?=
 =?utf-8?B?SlhXQ2tjdjFCbzFtYjVQZXh6Yjk0UGNuQ0FGbzdjalREMitoOUN6dmY0Z01U?=
 =?utf-8?B?T1dPODFGSUtnVFNiZHFPQTUwbDQrOThDQ1ZLM05RK205VWw2aXNsT1Brbm8w?=
 =?utf-8?B?citPQ0E5aDgvc1J5L0JmbVJwVWl5WEtzMWZUQU41Mjd6WS9rUEo1bmR2MXR6?=
 =?utf-8?B?TDluR1U4VHpUbmxyOVRtSXMwZnBMbklxVG1BbTFpakFXWFNrK3pWR1FDK0Ry?=
 =?utf-8?B?c2VYOUlJcERTSFp5MEdXSC9QN01ZVkkzZFpZUHMxMjlCWDdURUxzeW9CdjlG?=
 =?utf-8?B?VTdNR3hYckNxaWp5ZUF1NVR4NklKZmRFMStOdDFpb1ptVURFYzdQMTE1bmxQ?=
 =?utf-8?B?d2dJRVd5eWNwSXVtZWFBWmNSS0s5bFdtU2wreTJMMkFPdDdaZ2JvalF2bkRT?=
 =?utf-8?B?bFAyWG1VaW96U2JjbVFWSTVPK2orWFRUL2plOGdtazNwL2hpWGVReUZVSEIz?=
 =?utf-8?B?UHhpUm55Z0dRVWkrR1k2cll4MlgvRk1ZRTVheHoxQUE5b3F3VTBuT0xwQ084?=
 =?utf-8?B?SjA1MXRvN1o1OUxobVBMRHZvbFNmQmx4bk1McXZFSCsxSTNRRVhQYUQwQnRW?=
 =?utf-8?B?c0luOHFCUkJrVTRmRHdBaW9CSXc3YlQ0eGhHRnNaOWQ5a1AxdjFwTlhWUU9M?=
 =?utf-8?B?OThzTFFtbUhCcUIrK1dLZnM0NERiSFFUTEhlbnlxTCtxNUJVMHZMUmpPNzg0?=
 =?utf-8?B?bW1tS01NOTB0SEFYR0FTQWFyV3RqNU02dlArbTJQdHdRUkcrK3lRdTViNGVo?=
 =?utf-8?B?b0pzbFVlNlpMUGIxdW91RjBiZWRqRzM4MzVBSG8zc1U0dGsvak55ZjBMcHFF?=
 =?utf-8?B?ZkhiWG1kZTEyaVd2a3ZYQ1VsNWhVOERaaXhJZDc0V250THFqUHpwVVBPUncw?=
 =?utf-8?B?L3I3ZXdBZnJLc2VSZEpPMFJUZjNCNlpOQ3pPRzErM0RvVlRkdm1hcXlZZmlK?=
 =?utf-8?B?ODBwZ0NiU2J0TmFUd1dyTDZDRjhKK0ZDUVBWZlNHdnlGRklWcEpKNmg0MURX?=
 =?utf-8?B?RHNJUVFzT0dCODRxY2tuMWRpN0MwYzZGUjViUWd2RzYrblVXdGVHODdLTlIv?=
 =?utf-8?B?VXVHQ1JLSTljK0x1eXkvWjMzdktDTXc0a1dmOFozV3A3Unl0NGozYUc1R0hz?=
 =?utf-8?B?RkhiVWRycHlWT3FBNlZSUTRGY3NGMDdHTmd4bmhOMUpuODNHZUhkU3EvQWZF?=
 =?utf-8?B?NnBWb1RtS0Uxd09SeU5LT1dUNlFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80B57B842F73904F825E85CB525D8821@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bYGJO1CVVL3hh57SeCAyNwRUXp0U4BEb8GvQ2secV00LN4JVFY17GthYWDQtpV886cJ4NV94JsyictaGdJhPASoqbTw6gLN3A1Bh7xCOXGWeeoiwuf69+bzAiWW/f59J0iyffdtcZqWfptGag64vW7wYmaSDRzW6xy1k/hK7wislpJA6I2XnBpMQThrVpsxINWAi7waNu6YP2s+gpOmiofK52W/snuqCzx1Qm/F/BpcWMQA+eYVrQZSPKpWi2rHV0j0GhuGpPZNX+cu6yJCvjiElJi8lgK/4sbNnmdtAz6Vwnu7QMBiBAIrw1QCbEiwsJoX6/+dqdcWjAi9L/nA9xl56EfV47KdFcq0eSWkadGVlmKUsTDzPBqDc7QhokWxFCJQb6Emc2FIVyzhmwkkWqGB5Uauqszre3ZTRnVMXbItRQ5uCcnzooAgpHN+r8yj11BZuLtjpl1dvFONJXoljcTuHr9Mrp+GueXV8tnpZSbAueHfKBVn4UbY/3K5zsZr1h8oxXyOMQAxsxpPT9WNLBqLovU16Z6PxAqssjTOEaHVQgkdZSkzKAqgyT7qqdKvt149Qzle6YGh+wzWEPEn4J1kmTYeVleqOVaB980iYpCzI9zsFNW45himJp4uIyv8D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3921a6dd-32d3-4143-8c5f-08ddb79edbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:25:07.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/hbTwEivA0zI4vIp1yoygNOPt3d126vJvIJvIItguGCTE2eHnQMWv6BUzxF1QPEMEXzEEpAPSe3+Zn1NarkXnVUT+RG37nxjESk52gBjpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8757

TmljZSB3b3JrLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo=

