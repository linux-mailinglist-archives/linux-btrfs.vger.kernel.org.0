Return-Path: <linux-btrfs+bounces-18768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE115C39DF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 633BE35084B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F44219A8A;
	Thu,  6 Nov 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iTEtd6V6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P/J9d8DH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421423B605
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422305; cv=fail; b=daDhj0ZN7Bis9xKVyLB+XEbqz4tHLDlvMiREmzw/Avi75CGpCastKLJI3bQg4nuCXBKuKaRkbRpzwEr/QiPxitnV72WFRmbkEldvDb2Pxrxi9exiGLPD2WQaP/uxklEkcHVukM6rqn7eTSVsvd1h+x7Pwf/SVnceQMinJyDIG5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422305; c=relaxed/simple;
	bh=Z9sV0MtFb26nPMSXr2ZaoALqcjoVeis6lFZogAy5buY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1tThwj8QpAMnAr/FdW3F2DXVhi61ozOWL7ADz7B1tBh5m9d+5Kq3el6jnhdcgCPwC/MAMuherhLdY5BjamtmXp1ejEdn4IuwyRY3nEJiNqBbtxM+PXn3yh7Z7T09Boeuj36Jr0LjmVLie7lXZMU8ALzWM36ktt5KRsFjLW0Wco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iTEtd6V6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P/J9d8DH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762422303; x=1793958303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z9sV0MtFb26nPMSXr2ZaoALqcjoVeis6lFZogAy5buY=;
  b=iTEtd6V6CRF8DTsYNjY4+FkCJpotztQlXi9Gwat90J7gPrUvJDLo063N
   VtEDdRleXsVUNrTrq9V8NfJZU7Laz3Oue3z4xKQouKksnoJJ4kFzjr9cQ
   SBNBxl+R5gI86JeiCrrBm88nd6xpDWsCJD9zEI9UqbPeOkj/ye80K/B1N
   DgVl6ANo9R7dlJMaNiCabXVkVX/HzdWrcu6XlFxJBUzzp8+oaKhvQfD98
   PVb6hQQeOJYjra1u+5IP4ovxuKa1XrVUQALeZrBIc/eqNNP0k/ZFcKXS6
   ivHRObV0Pbcpi5MC0XW6e234VgN6qP/mUV8lqmtu8VpI8dB6JBreGkXov
   w==;
X-CSE-ConnectionGUID: Zkves7RYRXS6ONSHRG2pmw==
X-CSE-MsgGUID: hnFHmVNDQqqqBajF9Tfm9w==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="135897976"
Received: from mail-southcentralusazon11011021.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.21])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 17:43:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irTRU38KLrhdg8qXpQ+/Ifiat2wCcWluQ7cLih6yk8dS95Kjnu67TdyxOkru+LAAYM+Unib8AEvoMCo0nXpx77PDopetIuuS7v4Vf1JRFphpVW20lRjHfJ95pj5g3NLzn70u5U/35gtAg6XxDlW2o7yYmfnzm/aMPAAI44HZeAKZTr6GNMIrM0Vm5a2p9NoWEPcGL8ugeiGnYg2W5kZ5E9U0EburetWIKl3Nf2u2nn+Q9J6SUkRh0XHHiL0K/puMZFcvG+M/Lz4hpdTtHlHLWjY/WaCQSaBhXijekFMnYpHV+wA994skD1yg4hBjSBbZPCwVUYj0lDoLWwgnOuvP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9sV0MtFb26nPMSXr2ZaoALqcjoVeis6lFZogAy5buY=;
 b=Zuhte1QiVFwqYtjMFH7hnCTYCUkFPGhGA0Svw8c73N3t513wgRaeiU/mZe880Xx2+rLyx4wvrW1u2tn6ScFrtRaMtI1oI8Te6SOtT/JLz/qUbBwcu74PJ9iiM0YvnbCN18Iuz4hsFRl80pmBmAyLA40seV0zQjXK39cyz7/UzgciSS7M/QBWlhqt/aAx39rjhRvHgiI2/zPWaukek0hZ6KIgOKwd0oXrHWBuW525+Onb64QxOUWeRKH8n0abH8SzXnsr7douZ2ymYctGrgHM3L1PNGO584l3gwmBvJTBM91/gA+x3fjoKOQ/a94mZ4eo6lvJBUhRtALzTlYH3HeRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9sV0MtFb26nPMSXr2ZaoALqcjoVeis6lFZogAy5buY=;
 b=P/J9d8DHy5em57zHb8vi8wifYW6CqRRHEF5JaF6TUYFvDBZIa8QKXL7vhCqpwp27mOZd3bRmZ/gb4XB9prKQLMwSaU0pbzyuk5jBh8gQvldVxppaEZ1fgVsW051Jqz5bqV4t7F9EYpK9/XlxSFhlen/L7Pfdj/s+zJGDur4/6vE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL0PR04MB6530.namprd04.prod.outlook.com (2603:10b6:208:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 09:43:53 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 09:43:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Calvin Owens <calvin@wbinvd.org>
Subject: Re: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Thread-Topic: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Thread-Index: AQHcTp5ADr7g/ZAQWkeNSBWn12KoprTlWqaAgAAF6QCAAAXsAA==
Date: Thu, 6 Nov 2025 09:43:52 +0000
Message-ID: <01e6d2de-7d76-4d76-be18-3cb5aa94d852@wdc.com>
References:
 <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
 <f8425395-311d-4e27-a7da-46cc0ef35ccb@wdc.com>
 <51f19b05-701d-4740-81ae-83e7afa40bb7@suse.com>
In-Reply-To: <51f19b05-701d-4740-81ae-83e7afa40bb7@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL0PR04MB6530:EE_
x-ms-office365-filtering-correlation-id: 49fb6d99-1d1e-4706-92f1-08de1d18ff27
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmZza0pnQ21KN1NrVmFXVTlJUzBsQ0c1SzVBeTZHTGFNNFBBUFBLSTdrd2sz?=
 =?utf-8?B?VVFLYkQ0c1NWaE9nTUtnNnVKR1hzTm5sTDVHNjUvMjRPTEUxb05ScGVJVkRk?=
 =?utf-8?B?a2VOVVhady9BZFV0S2ZhMlRTSHJQQUQ1OGdIajByZWd3ekhGMExUWWlXd3Rj?=
 =?utf-8?B?Smd1cGxpdXhyUS9oTnc0Q3h2WnFUM2ZWTWpJaG9UNXAvUFU5WVNkclNOYXNx?=
 =?utf-8?B?Y2dmcVdJSE5wMUVVS213NXhaQmJuY0NVbmErREd5MUtSOHlFd1VSdWxuWFVU?=
 =?utf-8?B?ODNqUktYNTJPSCtGdUgrTjBNYStHWDQ4OTh0RUZ1eGtmdXpuY0NSVGc5WS93?=
 =?utf-8?B?RXBMZmVBN3A3Rk91RjBjQXJYZHVRblFGTnpKcHZ3U2JpOE8yZVdHY1ExSkdD?=
 =?utf-8?B?VzN5Z2tlTFNhMGFmYW1hVEo1WStoUjk1YURwMkJpbE5FUE1sOHZ5aDFsZ3RK?=
 =?utf-8?B?UEdqSlpSWUdwa0NQMGRHQlRJQ3Vwem44TzZzSFpHZkZXMlBxZk1od1ZjSGR1?=
 =?utf-8?B?TFlGZzJwUGNUNXcreHZwSG9ROVRjZTk2TGVuWXNHUUxHaUJPa3RwczhhYndo?=
 =?utf-8?B?TG1SdXljcnhuOXU0U1Ewc1hyK3VXbFM4a1NidTdiSUxXcnNpUFNkaWduYnN6?=
 =?utf-8?B?OUVUN1lrTjQyU0FDVmtOMzFwaVpURjBacWx3Vzg2NVY2MDlFOHU1S01tTFRR?=
 =?utf-8?B?U0tXTkR0dDRTd0w2TTAyaUZURlEza05Ob3Fyc3dxRG15bVdhKzBKeStKeFUz?=
 =?utf-8?B?RnovWkpOL0NBYkU2Vjg4MitPRVdiR01xbENhbVI0TUhqbjd6S1dXdVAzQ1V4?=
 =?utf-8?B?Mit4M05ObDNDSFdKcnFxUHJ3bk8xYVBmUENpaml6amNZMzh6cGRHQXJmN3BF?=
 =?utf-8?B?ZURDSVFuNFVqMDJjMmx0dUJNMW5xVWFaUllCMDdXdE9CNVFlcDJZZ1hnNm81?=
 =?utf-8?B?OGNoSXJIMGw2ZUVQcHNXMzhMRWd2K2pwemtQeUJkbGp2UVFPNGpldTdWMU1j?=
 =?utf-8?B?clYyNUlJZ0VWYWhPRnlnQlBJemdsaW5qVnI3cnFmSEp5S1hpbFRqS3pTVit3?=
 =?utf-8?B?aURiUStod1BFRFEzZlo0T1VSSm8xN2FMYmJxU0RNOG1tcDRTM0dkajJMSEkz?=
 =?utf-8?B?Q1ZDQ1ZvZ2xrbUEydGphTlArb21qRjFvdG84WmF5NGhScm5Bc1BRdnZRWC9Y?=
 =?utf-8?B?OWpqMFR6QXZMbWlOVGs0YlhnUVp5cmhpUU9yL3BSblN2eFV6ZkUvaDE5bDE4?=
 =?utf-8?B?WWl2NlZKQThQZUV5c01MSzA0bTcyL29hOUVTREg4bXpVaSs5RUUxakJmem93?=
 =?utf-8?B?ZE5WY1Nwb0grYURneGlvZmtLQ3A0SmRkU09zZnpwMzdvR0VENnVlakxtY3RP?=
 =?utf-8?B?aCtqNkc2WTBGbWJQT2lld0pmTE1vc3NsSkVEclVOa2FYdU9kK3NGRmFRM2JV?=
 =?utf-8?B?blM5NDZ6bWJ0WUZUUlhrUXVnQmpXM1V6Ly93bU9WSldDdXk2ZmpHZ3ZaQktO?=
 =?utf-8?B?LytQbklKYll0UmJQTHF6NERZdnZ2TXpRS2JpRGJ6bHhNanljaitCNzNRUHN0?=
 =?utf-8?B?V1h3bkVVWHU2SDBxVWRSeUtCSkUyME1LOVdHaS9jYWxNdWVTVDVLRmhxcmQv?=
 =?utf-8?B?QlJrR0NWb1ZnUk9WQ05hamFGdmsvTG1leU1haFFjNzJLNGx2NXdUbHh3V3Ja?=
 =?utf-8?B?bm1uamJ6Q1JaSWRTaDFJQzZHR0gzYWl4LzN4YWxwNHZTT3pRQXBTWUVOTngy?=
 =?utf-8?B?bzg4bWVqTE1SZmllZHpJZ3FQcGhBQmYxMDRIaHlObmlyV2tHUHkxNW50ckQ3?=
 =?utf-8?B?djEvM1l0L2NSMExMdHFGNW1ORzlJUXdIdERtbXAyeTlKS2xIMlVyUnF3bVYw?=
 =?utf-8?B?NXdoTG1WL21vYUdzd2tZNnZaQ0pnQVBReTNpTWpZdUtTS3FpVEZQWjJQd01s?=
 =?utf-8?B?QVVtS2VRZE16MDkzTGNuajZJNHBFUVlJdnZWMGU2NGZoVjI3T21SeVhXdEo5?=
 =?utf-8?B?UUpzeURkbnlrMS9zcWdpb3dqOHhxbEMyRUE3U2lEVTk0Rm1CRDQrT3RadCs3?=
 =?utf-8?Q?2VYljA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlZRWXZ2YVBMWHVDMllqZUtxQXgwZ05XV0huSTFsaU84Nk96cXZ2bkZtTTlT?=
 =?utf-8?B?SGdOL2M0dHVaMFFhOXVNWjVqSTlndmxXUUVIWURXbVNxcUVaQzREV1N2RVIz?=
 =?utf-8?B?ZU9rWGRMSzBrcUI5VjMvcnIzQ1hRUlVSY3NPRHNtb0pScVlPd0poVFM1Zy8w?=
 =?utf-8?B?Z0pId29DcDQ4cVVBM0RGTjdyUmhZZmViYWQwNW44WnZCczAySlZqOUlFVnd4?=
 =?utf-8?B?OFRLWkRuVm04eDR6OWp2NzVNMDhqeHA4N1dJZFFGRk9wOVVKUzBsdGtySW1v?=
 =?utf-8?B?bXFyVlRCUVhES05URUYxRTVsZFNYVHNuV2FjTGdGREhBazZmRVdrbXV1YnpD?=
 =?utf-8?B?TzN3U0lSN2cwMWRwbHhxK0ZCT3Nmd29sY2w2ZEFlOW9leXRrK0ovNzNvTXZ3?=
 =?utf-8?B?aTAvNytJc2Z4czg5R3lOWDZ5L2hJSjlWanZaRnFKT045YzNBRlRlbXM5ZFhP?=
 =?utf-8?B?WUF0UTNMVXIyU0M4VFlwdU0vMHo2c1VoaUdDWFZDOTdEM0RPdThrVktEeHVa?=
 =?utf-8?B?R0ZJVkRyUTIxbEVTUGprU1c3bDIvTklmbE1mK3ByNjBhbFQrU3M2WGxEeC9q?=
 =?utf-8?B?S3pVY2NQN2ttODJDYlcxK3FWQzFKekVjL1NtckNQMmJWcm5MYnBTZXNxc0NQ?=
 =?utf-8?B?c2JKZlYzMGdYTkR6eFlqNjlIcURhNEZ6enByWGNTRy8wMEZHRmF3QzlkN3Bv?=
 =?utf-8?B?VXowQnhpaWZ1YUZlQVVRVzkyT2o1ZjlLL016NGcybzlTSWtQSy9NNkdRVDJK?=
 =?utf-8?B?SzRMRmFpY1YwcTYyTW9GREc4SnFWK25GdWxwTUR2WG1TRStPN3g0Z1J5RmJ4?=
 =?utf-8?B?SjFjakM4ZTZFL3FvOFdtcU4zb21XTmV4RjZEMzIzRHlRQjlmcVBrQ0g3UHNC?=
 =?utf-8?B?bEx2SkpkLzd3RDhYMmJoQzRudlJhd0xOZklMTlhmOEtzSTFCc1dzSTNOZzRs?=
 =?utf-8?B?ODBiQjg1eFdyRC9sYko2VytwV0twenBUbjY2VUE3Smh6YWtOYUplcVNpZCtP?=
 =?utf-8?B?aFd3a0t6VmdJVUNLSURQYVFieHVmZjNUTUxPem9vNjQvZnE3SjZMVVFWcmo5?=
 =?utf-8?B?eXovb1k1WGQyM0JNd0dNdytSRVQrTnkvNXRUYUFXeHFYOXIwWVlET25XcVBB?=
 =?utf-8?B?RmtjT09oMU9BelpxSVVyLzFnc2VzZUlwcHlSSTFIMUJzVVFNajhYNEZPNldB?=
 =?utf-8?B?ZTJDdU1zblRRdmxtR2pYd1FqQ05WT3ZsNlQ3Mk1GSndvZ0dHNWt0dHRKRHVo?=
 =?utf-8?B?RWk5U1FtbXAzNkRYcXhIR1FNTE83V2RITm1DL1dDakRBRmRPZmRKYmpzdEVn?=
 =?utf-8?B?Q2M4eGpSTTB4R0UrdDlZb2d6Uzk5WEdUVEc3QTNoTWdCQXY0SEVUeTFxakdX?=
 =?utf-8?B?RXVVQStWUHo1d2xrWGdQbEFVcmNDb25ad2hwUXRHaXM4VDhPa1o2bHdsRW92?=
 =?utf-8?B?eW5SWE4wTGk0ZmI0dHVNcXVhMHRPK0E2dFhrVmhZR2VyZlpyMDlqdG5xd0R6?=
 =?utf-8?B?b1kyK3pxbUxBc1pwRDhKS3oyR0lrdjFzd1p0Ym83YVZBdTcyRU0wSXo0dm45?=
 =?utf-8?B?dzBCSTI2ZFMxVVIyaHF4VGRGU0Fha00zalN2RkZUc1A1SnkvbytuYWZZdnNa?=
 =?utf-8?B?UlhSTWpoK0ZyRFhhRGJtZ1F0cHkxa0gxbnkwK09wYmJ0TnVYRExVektFUWNZ?=
 =?utf-8?B?Y3dpL0hBcUVVeERqWlYxRVk2dG5GQ3oyQU04dWhKby94dWd1WXNjRkE3cTJp?=
 =?utf-8?B?a2VOZmEzb2VpVTVEek5vaGR6ZnN6VVJNNTEzdGZCYWdNUkIwamZHQ3laRFpo?=
 =?utf-8?B?V2RpV0gwT1NzeHFBT29MbDFkeWY0QUlpODZCRGVFNGxCZ2VKZVladGRrbmta?=
 =?utf-8?B?eWRzN3E5WXZKclRjMS95WTJFRDdiVnFPMVJuOXduV0VwM1NiR29QbWxQUjdB?=
 =?utf-8?B?N2Z5NjN5MjhuWm95TElEby9SOFFsOFRJaVpUaGtEam5lYWM0YS9xRnJlNzhh?=
 =?utf-8?B?SmQ5M2NvRlVqalQ2d3FYSzB0Nldnc1Fmbk5HWGVyZ1hvQzJ6cWF2dWVJNldZ?=
 =?utf-8?B?TXpoZVRabGZ4OXVCTGJ4MFRRWEszN2IvalZFWnI1b2ZXZk5zaGRPZDgvUDlX?=
 =?utf-8?B?V3RDRzlJellOTVV5TmpqKzc4MTBOVm9UMjhuQURqY3ZSWE9RNmNBZ2NLN1Bp?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <846319453396A3469AA7882C7662F344@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YSH8NF3vj2TpWlPQQR1CzssZ+y5aBMeUHwYBJQaaHT2Q2xgz/WedOL7wvsfeBPBeWRMRU1a/tWgfneBMLg0K3rPUVeN+WxvEYsGBG289QzpbL+f0KjrwElZrmrwBk5cPXTliHOZrfi75AwaSuybJ81f3mBDDV+Afyl1Ssbj1KRPCBOyj4sqQLcV0aN2wTHcruz2K8W9dH2Cbuo9bpugRJxhZPjSdcQaycdC/31mrEKpwt6u4fScAqxkutwy4mS30eX3IJgAlH9qaRNi0Pg1KnF0FMnd8jO+TfRjdAyvUKioz5o5JFuDiJNXRKhRE6h04OB4Tgqg546wtiJCC76WovHC4XVhKgoU6c+Sc1DFFr+Wmo2daBDSetWqkThBF49u22DuQXfOS9d+glCzWNs5YQKv5mpk7A3CtbIrdfcKSfq90m2TrfDkmEAC781jZQ9wRoctdUiC1czAw5mj//52xThFIdU4lN3mWg9ShJ4qud0EWhAFiI7Hdr/MAQDs6AnzzC94o0x54qfNlqVdHaAHvXqFgfaGbp2rEbWFFpPiS7ru7XBecDgdncGpDG4IUWw3CS7AqHPNLpvT6rp7pAI9koPZctTaEtsbTmW9wdkoIPFfOuzyuGwJI2+M8+bsJD/jf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fb6d99-1d1e-4706-92f1-08de1d18ff27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 09:43:52.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3MCQrKOqG3jaasz5d1kGC1+6ZFEyhGFjT/WlV9J+HoQcsv9sk/1b902cO1G+4pe0C+5cjGSdjvVNyEnPxUFoa2d4QVWh80kAXuIuLAlEnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6530

T24gMTEvNi8yNSAxMDoyMyBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPg0KPiDlnKggMjAyNS8xMS82
IDE5OjMxLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gT24gMTEvNS8yNSAxMDo1MCBQ
TSwgUXUgV2VucnVvIHdyb3RlOg0KPj4+ICAgICAJaWYgKG5ibG9ja3MgKiBjc3VtX3NpemUgPiBC
VFJGU19CSU9fSU5MSU5FX0NTVU1fU0laRSkgew0KPj4+IC0JCWJiaW8tPmNzdW0gPSBrbWFsbG9j
X2FycmF5KG5ibG9ja3MsIGNzdW1fc2l6ZSwgR0ZQX05PRlMpOw0KPj4+ICsJCWJiaW8tPmNzdW0g
PSBrdm1hbGxvYyhuYmxvY2tzICogY3N1bV9zaXplLCBHRlBfTk9GUyk7DQo+Pj4gICAgIAkJaWYg
KCFiYmlvLT5jc3VtKQ0KPj4+ICAgICAJCQlyZXR1cm4gLUVOT01FTTsNCj4+PiAgICAgCX0gZWxz
ZSB7DQo+PiBDYW4gd2UgcGxlYXNlIHVzZSBrdmNhbGxvYygpIGhlcmU/IE90aGVyd2lzZSBzb21l
IHdoaXpraWQgd2lsbCBjbGVhbiBpdA0KPj4gdXAgYWZ0ZXJ3YXJkcyBjbGFpbWluZyB0aGlzIGNh
biBvdmVyZmxvdy4NCj4+DQo+IERvbmUsIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuDQoN
ClRoYW5rcw0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4NCg0K

