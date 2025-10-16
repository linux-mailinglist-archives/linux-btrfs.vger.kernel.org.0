Return-Path: <linux-btrfs+bounces-17896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A29BE45A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18FFC34AE54
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11334AAF8;
	Thu, 16 Oct 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DBpSvJ8U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MOGVECSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74D1FC110;
	Thu, 16 Oct 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629841; cv=fail; b=n2MOoYTfDqy7XFheEu65a8xuuk8t33cmZ+qyq65qItFnwGFPhNgcaoxS5Ld03z15FbBIWN8Ag/eDU+RK5IDwlWPzpTwtfXjSZv5d5LDXbXWLHDymSbp4yc7oMm61w2WC4pBCMV8VyxY3T/gFBQw3SrS4vqAd8ACW112pqCkFtBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629841; c=relaxed/simple;
	bh=gsYgJs2zYslEekqLhdNtAiUEgzrrcx/tFn1qx7sTnX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuyLyI6qwu9M2nZ9HX1V65iiTW49Y6uwBQsh1vvVVfw4EGRpCqMV85jNe9tUdhhq3qd3baaiAym7hF/JLN1Kd9q7HiA5PRtZ0xqhXFRlxwgfd191rHt5nGZy1QO6jLclyqXtaC60/VJAUSi43SPg7uuzaOJLLjJavhpXETtWS7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DBpSvJ8U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MOGVECSD; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760629840; x=1792165840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gsYgJs2zYslEekqLhdNtAiUEgzrrcx/tFn1qx7sTnX8=;
  b=DBpSvJ8UZSac7ywC09mQcrynTSE8VLN1IcQhXQpsWWN4hAtlsw70oijO
   su6kHqQShxLmMFpFyNAh74XU78LPpAmcAXwRoYUsttgqP7ePudiKAGP/c
   /sSMgRTxUZUl7jf68z7BcaL3V+fC07AX3GZaT4BQzYBj20+XjaGlfdQic
   1JiS+ef7ZVwfkg0zIZEjcvoO4mNw5Pb/QkapReijfPahWXl7tbIx/+gFg
   7jpIP4vGf//BkQyzdz/tiOT1ZTSS7E3W+OivCgwaNUuju8oxn3iy9LOgo
   XRS+o+RVFhLDBNQ32q60AfypaWGObLBBwzxUiyRr5nHa8n64B6Tt/szaW
   w==;
X-CSE-ConnectionGUID: 6rWfFS9VShS3NNYqv3Pr0Q==
X-CSE-MsgGUID: sLPZMPEGTzSafqKWezpLuw==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134591688"
Received: from mail-centralusazon11011067.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.67])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4oTMo5r6uTKVGEOD1pzAsL6ZymJOZQShLKvTQFnaGFVWXIxemj2tOKuTYN+SzsFzQDqK5XgrW+6n5OSDlCpPqikk8NjI40Jnt+0yyqY+EFEY5sodr5KseF8XRg4h+oDE/FUxDBlxqCsClVXKfSNbdBgaxpCawr7/BxUg2Ee5WuYX7m6ALLFMfN74y7H9HyKc80fYdqLnhCS4C9WBYacTNijTlxZgQa6rXSJEVepRg6kSNvL9Lu+Hue/c0Sj7AvZAPSUehwKSlBJkfSjZ5brNiIs/DCb+xM8eXLdJ9sCYv+VMU19laDJjDKdMvDSh6BN8Uc3D7bqUn1mMCLtzwlCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsYgJs2zYslEekqLhdNtAiUEgzrrcx/tFn1qx7sTnX8=;
 b=VCePjfS6nMVEO+GmR1MIpn/cdHx2bVcx3ecpMXGH9GnGzsqRTzvCVDIiamPEGpP46PgjPv/4qJKS6yIMf2LBKtBtO0USRqQy3qlGHt92c2EhxQz24gu6N+VpRqtmRgGpmf0Ei2yT0gR9zoRYKOnQ35rGqAH6iXl686vHowZhqqFZ3XdYJza+lrhnUeTE1B42V3DLJt5E6HDv9DBHFG60t3PubRDziIswlf9LsGYo8YQC+dlzR5zGaJF11cARDOSBE/4xfBaQeEIl6B04vAqmD/k1nBhaK0KDGQi/+v8+VnXA5jvG+ND9QBWje8TpbfMKyn04JDlrPYNdyrdyccFeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsYgJs2zYslEekqLhdNtAiUEgzrrcx/tFn1qx7sTnX8=;
 b=MOGVECSDM7TmGpD3hMTGpzz8ZRUcWf/pVslTI2xUHeC+xcpv3eRQUpgdqprkofXdbx6PIh98RBkv8zQnfrv/tdsOEVL+XTMJnBph9IRmCUfABGl/kcHS4/mZMjxqPNx7MxjyDGFMjgj6jU0Ok391f6h34tTFH57UZ6d34uqxpxk=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB9832.namprd04.prod.outlook.com (2603:10b6:510:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 15:50:36 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:50:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Thread-Topic: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Thread-Index: AQHcPrB3YMElCouJg0CK3DIndwQnD7TE60cAgAAAkQA=
Date: Thu, 16 Oct 2025 15:50:36 +0000
Message-ID: <05b2e86b-bdc5-4298-afb2-9ca9cf702c42@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
 <20251016154834.GN2591640@frogsfrogsfrogs>
In-Reply-To: <20251016154834.GN2591640@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB9832:EE_
x-ms-office365-filtering-correlation-id: c1c6f7cb-fae8-4c01-9b2f-08de0ccbbf77
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bElPakJKTTBJSVUrUFNlTzBYeEFtcEFuVFZuM3czRDZqTi8zaXJDOXhMT3p5?=
 =?utf-8?B?c25zbUN5VzdZRzV0QlhaQjVOWFZwWW5xRG82bUhtblZsZkYwUGJTUnNsNlc4?=
 =?utf-8?B?akRXdHZHMThrdWlwd3d5RUNsZGVpeUY5MUxzbFdkQ0hqUkltaVFqOEp6a3Bz?=
 =?utf-8?B?YlJLRFR6clNYSUZSN2FhbzZJMGZpZ0Z3a2JYYW41MUdtSmFSNW1vYm1CMHNt?=
 =?utf-8?B?cjAyYVJIalpsUUczd29QbmlNYnk1amJFUFEwdU55Zi93MFRGaU5UNU9OT3BX?=
 =?utf-8?B?WkthOE8rMXFrOXNmTEtUVXFYZ1prWmZ2ZWcxQ2FUelpOeTQ5N1RLVTVUZ0My?=
 =?utf-8?B?ZTNpeW41VEl3aUdTQnQyS2IvQ3NvbUcrU1AveUJhSG1YMjRLTmtGb3E0TStl?=
 =?utf-8?B?YUdqaVpmSkpDa3ZUd3lkRHUyem9YSm55Y2VFRXE4TzdINy9vbEp5alZMOGw0?=
 =?utf-8?B?SEtVMEVqeHJoREhtcGRpODhiNVIzaHh0MDVZak5pQ1NOSXRSUFhqSkdHN2pj?=
 =?utf-8?B?VXoyVytzS2tBSWVsaXQxenIzZHN1MVRDU1R6RGtRcmpLM1hpK05xd21YazZX?=
 =?utf-8?B?YTVLSTB6YktqNDNacHFMd3dkZmxTb1NGaTFPT3hwbFV6TU5rb0M1N05VWWZY?=
 =?utf-8?B?UTJPT3dZTWladWIyR3B2YmxocjBPbzEvUU5GaHVRenMrTHZrQm1uUFp2QVE1?=
 =?utf-8?B?bWNublh2SUdjUllSVU9MSFBIbkYwem56V3ZYVTBaM3BCYnJXQU5vbVpnazZv?=
 =?utf-8?B?NkRWUlBKbVo0a0UxL3k5ZmMwWmx1V2dDT3F6bWgvT2UyWkN3S2hBdHg0UTV6?=
 =?utf-8?B?RVRIYzFUYUxDdmpqQWQrd1V0bHp1QXY3dXhlc3RCdUpGRmZUeW1jZTM4OWg5?=
 =?utf-8?B?VG5nc1JLdTFDMm1tcTlLQVZGT2l6QnBGenpuVDRrc092Mm1tcjk5UzV5R2hQ?=
 =?utf-8?B?cVRIYmJGbkUwR1ZHZlZ0S3hNZnFCczRQczZpL1NkNUJ1SDRyVGRXOEJ1Sklz?=
 =?utf-8?B?dTBaejRnWm01V3lwWWVTTE5neHl5MStmUkxDS3dWOFh6NXhySXhtMEk0YlFQ?=
 =?utf-8?B?V01jNUwrYWJyTmZRUm9EeURaS3JWS2ZlWmRkOXJheWR2dnVURzZRUG05VUZW?=
 =?utf-8?B?Y0RrN0tzTnZtNWdwZkNkOU9jNXdQOHlNWFprM1Y4TThmTWVxclJoYkJuWTlG?=
 =?utf-8?B?VXhPOE51Tjl4aFBtT3RWd1QvWWFPaXgyNHZxK2UzdHhabk9uRWJiZ21HWWJ2?=
 =?utf-8?B?UVlPdHVRQkpycGhac1FIcWp2UHk2bDc0WVU1bjZjWTVtTVpIbTVMOHVyYnh6?=
 =?utf-8?B?VklOR0pjMnVCaVNtK0gzRkUyMnEyK2dCV1dTcjEwTm1xZnpSdHlkSmhweXRI?=
 =?utf-8?B?aFMzWGtMMWpuT3pUc1M5NHloMUFJc3dDYkplamtNdXJxVVlqOHdVNVhCdjBM?=
 =?utf-8?B?N01ZTHN5K05DV1NoYkEzem8zYTcydlhEL3p0L05iSTM1OCszNDRsSWRLTDdp?=
 =?utf-8?B?NVRRMWlrWjJBTjVRenUrMnlZOXNmaERXTDJUSGxjRmRzUGlZK090YWRzWWor?=
 =?utf-8?B?cG0zYzVkY1lJZ0drOHA1Q2VwekJCZmNBSzdSamhPSXVpUnYxVjRBNG5Xc1Z2?=
 =?utf-8?B?NXZYeWNQRnJlL2pHNU53WDV6K1kyRnlGWlMxano3dkVoTXUwem9GQ2tFazhV?=
 =?utf-8?B?UDUrbHdRTk8xeldCclNiUTJWVXNqMUhGNXF0NmI4djRaMytRSSs3emtCVE9F?=
 =?utf-8?B?Ykt4emkvRlBXbnZrWllpTEgwR2pvNGREbzNYOS81WjVyd1h2clNQcXVObVY1?=
 =?utf-8?B?SVF4aEV2a1FDR3lwU2xQRWY1ODZ4a0Y2MVZON1dXZUNpK0hBQlo0YjhNbVpH?=
 =?utf-8?B?WUFxbGZxdEt2TGVoc1BMaU1kQkx3dDFKSlpaQ0Yzb2diakpsR1lLWWRoejFo?=
 =?utf-8?B?MHlMUytWcnBQRTl2OWN4bmpMcS9WRExCZExuQlJPMjluN21GWFh6Z3VNU0ZP?=
 =?utf-8?B?S2s2akc5SGp1ZWlYdXFFb0tYbFMvenNERDhNbHBUZThtNS9tV2dCWklTbVNS?=
 =?utf-8?Q?BBomkA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qk5oVnZaVGdVd0UwQ0FtZjl3M1RBT2NYdGpQN0xpQ0syMFZuQmRaaTFFc3A2?=
 =?utf-8?B?Si9YeXNMY0R1Wlc5Mnp2RnUrakMrUWdXL1NkeWd2ZytDVW1rQ2hFcnh5T3BY?=
 =?utf-8?B?YlgwVSsrWmZXa3VjY1RNNjQ0Y3RJMWgvYi9PVzdNOEpDeEZQZmRwQnN3ckg5?=
 =?utf-8?B?UlhLaDR3ZXRlY3dqcElLWlM0SG54RUJoampLdzd2eWk0YzNwOVpWSXQ2U2hE?=
 =?utf-8?B?TWFNRUMrbmpFSm01UWNKL0w0STk2ZTVvbnZGZjdPTDlTdEJSUkFmMW5Tcm5m?=
 =?utf-8?B?UkJtZStxY2N4clkzaXE3Q2ZCaTBnN1JHVS9FbjdDdDZJelZ1RS9Va0lGbFFN?=
 =?utf-8?B?eFNZc2VIcnhjdTFQVUc4dGlFeXBTWFNZQ1R6K3VoOTkyYnpCdmxpMW13Ylls?=
 =?utf-8?B?dXY0ZjVLYS9kR1NnREhIUktiQlUzZ2xjU3krcmZJR096RXh1Nk9HUy9QYkVZ?=
 =?utf-8?B?WFJXekpvL3p0RjUzczUyMDZYQ0N1bzgzNWs2OHhsQ3h2bVdqaEdEaDdMcDkw?=
 =?utf-8?B?RElHdSsxSTlqcVBzUVUvK1YzWC85ZHRTL09jVkF0Uzh4cm5sQ291a0h5NUVU?=
 =?utf-8?B?RStaWTZ1NXR6aTRtcVoxT1ZSNzBac2FrWlBuZXRrdjlRWlFhczBkQ2ZJZjZZ?=
 =?utf-8?B?SFJTZDc3OHIvOEhiUU5IQmlzMkR5LzE3UGlmWGEwY3JiS29tcDIzMTBZZ0Vt?=
 =?utf-8?B?VktVeTlWSDRoNjlBODY0WlBIbUhJUWd2T09IeXVmbWo4L1VVaW1jMG5MSGpu?=
 =?utf-8?B?TThEV0xMejhDVnBNaFBhbnZkc3h1VUQyeWE4elFsckdsSUs1TkFNdDRhN0dZ?=
 =?utf-8?B?djNHZ2cwU0REckRVK0poUnBIVTVqNm9KeGUrMlI4dG5WMG9ROGZkdTh1L0k3?=
 =?utf-8?B?bmZWMnQ0YTQwRDh0OXVqOGhleHVSTlVJYitlMlQrd3hHRjNhUis1endRcDBi?=
 =?utf-8?B?cVBGYUl4clZ6U3BtVm1USVdXdWJoeTlMcHcwYzNJUm1RVWlpeW1vOVlTZWE0?=
 =?utf-8?B?a3hOelNuRVdnc0V2ZlcvV3hpNnROTFc5TnYrN2VIVTFkdnNHelFmdSt0Q2RC?=
 =?utf-8?B?bFBEWU1NOU9WM1NqcmVZNmpjaFp0RTIvRTR5RzNsVm9IemYyVEdxclBZTXN1?=
 =?utf-8?B?alR5TTVmOVNzYmpacXo4ay9NT2xOTnZ5aSsxcVBuRlZYTG81NFd0akd4ckRW?=
 =?utf-8?B?RVk0dlJCamRUZENoQ21CcnE1b1VHSU4wV01vUWVuSk9UcStQVVBCYlhKVmRo?=
 =?utf-8?B?M2QyMDYrVFNOQndvRkZNTkZZTGQxd2JWN0lWOWd5ZkFQcjRLVE8xNGZVdm0y?=
 =?utf-8?B?a080MXJ4R3Z6YXFrYVE4Q3pLbDZmUmg2VzE5VU1Yd3drUGNMTWROa0x1SWZ4?=
 =?utf-8?B?bHdmamdYbVJYU1hFWVVOL1dBRTkvSkgwLytuVkViZXNLbnQ5NXN0ZWNqbmVL?=
 =?utf-8?B?U0tadHZ4dzNTbFdEVkU3alpqYm81UjRJRnAyNWVKcFZteFkwZUpGYTVFMlZV?=
 =?utf-8?B?UlRzMkdRL2puSjBNc2R5WlZ1U0JZNHJ2eXIrUGRiT3ptMG9sSGxpRTZhb3hk?=
 =?utf-8?B?ZFdGdkhlMGV2WTBsTjA1SnVBc1VtVTI3dnNIcTFQMkpZV2FGczNJNTl6WU9w?=
 =?utf-8?B?VFZWdXBOQkxuOG1KVC9SRzVrcE4yUllFK2MvOWF1Z3E0Q0o2a1U4cHhLUVhu?=
 =?utf-8?B?eTNjMjhCemowRUowRFcyNW44OEl2OXJIWk5SWTVxOGdjZEFJQmtxbUMwMU4w?=
 =?utf-8?B?d25PYWJOOGt6aXppd2lnR0YxbmhicmhCM1BiUlZ3cENoUWpvbkNVY1pyRnZ5?=
 =?utf-8?B?NU5FWUROeVU4N1N1MmpFL3R1VHdDYmRVSmRTUEtWRUMveDJKdCtmUG5uamov?=
 =?utf-8?B?RkVDSThDQjdrb2ZzYzN4bDFROFE1REdhTTl0UUt2US9aT3ZVMUdnQ3pnRzVa?=
 =?utf-8?B?aFpPcjVpaWU5c2IxM2hVRUJDeHVKM3g4aks4cTd1T0lJcjBDU1BqUmdXeGV0?=
 =?utf-8?B?azJCMXJOdS90T1ZoallBOHlqZ1pqbThGeGpTT2dpR3lGT0xsdExiRnhKUnda?=
 =?utf-8?B?dUU4RlFwZUVGZjhST3dDcHZYSlNYdXo5Y1lDZGlTU3YzYUliZGd2cHlQczNs?=
 =?utf-8?B?bHpTZys1N3FzTlRmQXV5WUkzclVPdzdXeGppSERadXpwaWtPZFRmd2JpV0NK?=
 =?utf-8?B?TVRYSkVhQUxXZEt4T3QvVU1NYWdFRHJuaXF5dWxWdUgwdURYTVN2NnQzZHVr?=
 =?utf-8?B?QjZ2VEk5VWE2MGJxZFVWWURzT0RRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D72AC63D37254DA472010748A7B106@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVelEWrVHOMBsnChRObht12kUHZd0Nis2kZyPsxfzMQ7bpbjiXaNx6SoTeDQN+RTfhuf6QnMFURyL3O+gjfPTAl4nsoSwJNfr0FcbpKLIUHI8JHQetD81/A5xCkigV8rgt6htWPCnK19TU5sqzGEPpLMCnpEZvp9410CZMjJdj6yAp0RDLPC15cm6xwZXGHLUie9T2S9gb3yb5TV91Gw169J9+Mv0Lk/ADnf45/cND2NzlWmZxV5lZmqHF5yE0wwkGJPhvvUW6zXI5isQ0ER27i0Rl2pF1BB8SvoFIufeMgs/rzV76SyweDCcu+Mgf/qTbB2Z8WRSVwe2b16vOw8ebdQC5IJ7ehkgnzODUoo+C1SsYalI5G+jFYUfZYV9vVuvmdTE6GfGilI/GqK9+IQk2aI9ORQ6e2FKm30mNmRn2BPGM9AD3CfPuMUfaky1ApTnPkMrBV0nxKR+rL3tYr2paJnSWdRE7FVOqFya+lc502H0mwm7c3hv6bTLzUB01CqiY9IohIm2lY5CL6ax4MzFGh/deS22eaD3ZC/2t2Dcz8FyAeFbDJc01F9B+uovxCD+Jsp95KQAoVJCyezGxt1hQEtUWV7N08ioOjlp/9PMago+tIUD3KuNWxYSEgqaBq+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c6f7cb-fae8-4c01-9b2f-08de0ccbbf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 15:50:36.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRi0+NYLS3vAzOVNqXUw9UXBTISCKcrh0EY48h2MmtE8OxPaAWLAsLRXdxCqpgwYKw8E0zKii4wjZqAFR+/PcBW1HIGGDP2SN6m9B/Yg6iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB9832

T24gMTAvMTYvMjUgNTo0OCBQTSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBTYW1lIHF1ZXN0
aW9uIGFzIGxhc3QgdGltZTogc2hvdWxkbid0IHdlIG9ubHkgZWNobyB0aGlzIGlmIHRoZQ0KPiB6
bG9vcC1jb250cm9sIHdyaXRlIHN1Y2NlZWRzPw0KDQpEYW1uLCBJIHRob3VnaHQgSSd2ZSBkaWQg
dGhhdC4NCg0K

