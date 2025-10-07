Return-Path: <linux-btrfs+bounces-17506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0BBC11E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E540F4F4922
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD32DA75C;
	Tue,  7 Oct 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jz/fO9YV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jTNQUa1t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932562DA744
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835778; cv=fail; b=bowkYkQn3Y+6CpILNmGTDxGmMB5HQH5RIbzfaqVRLOYFPtfmWvSfSZyfEGf71TpVW05ZtmVTrrRxRzt0qnJQkHlrDFd/RruihcnXxRV2guZvz5JNXvuZfzPZLCZ+BdQhYwTIRBN5zSCaONUi7kXvFoD/5bCzR/M2M7lCIe5IoS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835778; c=relaxed/simple;
	bh=F9bTdJN+6mguhN6/RreKQ9YMM0yhJdJWns/RxjIPhL8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eUGzmtNTpLhs8/5T6IUu6KTKe9UYP273vK6m9VptFCyLe3B32GPlMRUszBg2ozWhkX/lr8sVpm1rEz70lAUKQ+cdfcAg10Wif69zxqptK78K7yn0KrvOTGVFCqR4W+CnEVQxjWTfXmcIvEgzOf6KTjkXs6iplCymvA3dNIfQpNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Jz/fO9YV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jTNQUa1t; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759835776; x=1791371776;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=F9bTdJN+6mguhN6/RreKQ9YMM0yhJdJWns/RxjIPhL8=;
  b=Jz/fO9YV3b2pW1muHTLWPLhGtlAjm+k1pkcDJGAKQ6fCD1UqVA7uOGci
   y0rV9fzeMDC6F1tlz0u+gTM4U3xo/S1Seuh9qrYq85CnWZaGFInLPSNiN
   mlXWjQQSjCViD96wxOKHXBnOY+CjO6Z12oCcJ2ExIywJSKZKrabkbICyK
   E6e5T+qSJuMaS1lsz6Yn5+hI1vsrHLH+FaJmvBaGqeCRGFMtBjxS4WRr/
   +ZJNY0wiZooiVYPfw/FRIOhexlozOzFgbF6XeT2gNcmcM0goxo24cmIwG
   ybaJoLcS4k/RfB13s0wAyE9Bf3A6LBuNimpYdoVmcVGxwPcNWnkRF4yKT
   g==;
X-CSE-ConnectionGUID: QcxCr6xCQoGb2sJAmqYS/Q==
X-CSE-MsgGUID: 0tG4xC2BQcigHnApeQ9iYA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132613255"
Received: from mail-centralusazon11010050.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 19:16:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwvZ7SCri/QhFarwaN4HWwfRQYbRz6tEQBCfGgj/Wt+P51dkYOG9/BBfwAo3xJNgxidqIET843t8wxWP4FYH7O1fUvM5WBKt/LTA0QVhSJBI/AlDqP83PyYSAxt08jBeRpqYiJrL0+qE080m6ODd+43Ibge4gCKwq9OhcxRsgXldFFJLgqCq07cB4QyRrzm4DlBn3IIQ/dQyIl7MokvMUns7xhs3y2itHewBPlZetYV3Z+unilaNP1pGF3RSAgTamfp07l7CbFlTmKTw04i5kNr8slh4mDvxTzKCyCKtrR8V4dMAFtynSXhwyUMjIVZe8ibwxLcUiT7EiHOd2FRXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9bTdJN+6mguhN6/RreKQ9YMM0yhJdJWns/RxjIPhL8=;
 b=DPyB1kmSkwLn2WT1568N4WRYIa5FAvr4mMItHotf6hVgulpuVknkh8JNFsPbprxtEagSk5gclvorijRrjhBH71O5x+J3jVZn4E8oPVt3HmEbMDE5iGksJkljuVeEVv6OJVv3spnYCZ493b6aaZf9NP1Jtl+iofSsfL2a2FlIpcTlJa4e6uNq+kBYcY0iU/iEif0zLHefPlDiivD53D6Guy2ecI9GiGg1BKoBpsnlPSnZCVnSrufxqHGaXWkFqdksFO/NYxF3emQMTET5rqxuPJ3USSjlhXqQhiV5Z0O1aD4xcdY46+iHFsmqyKbZ1SFQ3WXJ/3HCtT9UT5azVIENHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9bTdJN+6mguhN6/RreKQ9YMM0yhJdJWns/RxjIPhL8=;
 b=jTNQUa1tw+5WZVSBfgAN9x6rM7jayl2iXkKWLgFdaEE6SIaULLD6/1gE74u8EN/78h4++hKcSuHWgbeiGsuJ7qmNgO9U4IE2RCo5HkjS11GOEAHVZPcWZk0lM+te4MGCPU1LKhcyWlFef+HBMcHfgA2sGQTbvgufgYcaSY9jLiY=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by LV8PR04MB9266.namprd04.prod.outlook.com (2603:10b6:408:259::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 11:16:08 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 11:16:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Topic: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Thread-Index: AQHcN1KuGCX0HNOhIkayN1jmYD5sCrS2iOkA
Date: Tue, 7 Oct 2025 11:16:08 +0000
Message-ID: <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
References: <aOSxbkdrEFMSMn5O@infradead.org>
In-Reply-To: <aOSxbkdrEFMSMn5O@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|LV8PR04MB9266:EE_
x-ms-office365-filtering-correlation-id: ffc019a6-58ec-4f16-c2bd-08de0592ea25
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFUrWnZhRVBHYW5pRTd3QmxxemNRSEI1allpNUNnY0FYR1BrRDZHcHdad3hZ?=
 =?utf-8?B?UHR3bENLOGhPendlVmNBMER5QVRCVnFsdHBHaWpROW1WWVhpTlk4TXdXMzRs?=
 =?utf-8?B?RHJhd0RhcUk1SC9zWHArV05hTlRnWlhLRGd4U3hBUmVaZjZqUW1FZ2RlV2hO?=
 =?utf-8?B?aVVKZFU2ekZCeDB2UWQxVnZuSWJ4enVoclIzTW5JcEZ4akF0My82UG11WXhi?=
 =?utf-8?B?N0dTdE45S3VzWWJ0VGtqbngyc2xEUU1Gb09hc29Vd2tjMXBJMTFmcEdJaFFm?=
 =?utf-8?B?bUdSU1RNVDM3N3pLMjVIaXV1enY4T0Vsbk5FRWMrektjd3RFdytaYmtNRGcx?=
 =?utf-8?B?SlRBVXd5a1gyR252aEdZS01KK1E3dVJPQmNabzllSlI2RmcwVnZQWEYyYVJ0?=
 =?utf-8?B?UGpXRWY2aFhzaGJaRnhzKzczMWFENi84bjJGY3hEQUtmK0kwcTNEaXNxRkpt?=
 =?utf-8?B?cDhXVHlwbTRqVXgwVGRZaktQb2NGazh0Y0htTVhCZXNpeEJ6cnBjVlBvTFJZ?=
 =?utf-8?B?eTFYWSt1K0NjQkVQb2RoSzY5NUhZVEJSTzRuT00xbDY0ZGtCUjlwMzFmNjNm?=
 =?utf-8?B?L2tqYnhoQ0pySFl4dWNqaXVPU1lzUEliU05aajBqcnBVL2lYRUZnSWtXMUZY?=
 =?utf-8?B?WFRpRTdtak5iMnRjYWFSOFlYSUdNRk85NXEvdU9CU0Uvc3JBZWdoVFBsTWhK?=
 =?utf-8?B?bTMrWEdWZXRxbXFVd2RnOE5XWFEwWTdjK091TC8vTXhadjdpQ2FxanBqVmVC?=
 =?utf-8?B?ajlTRzlveVVJT3RFZHFGUFcxVVlqTUpHUzQvcDN5RTg3VmdnWWlTWkRjSzIx?=
 =?utf-8?B?VzFVYjM4cTkvTGVMMGNMZ3l3am4ybHJFeVlza2YrU0lVYitPeHpNMDdRS2Ry?=
 =?utf-8?B?YVE5akRIaFozSTJDL0N0bURWN2ozaG1IWHB2bmFFNDVDSkROWlh6RTc4QlRk?=
 =?utf-8?B?QzM3QVlwSVFRRGtCU05GQk02bUNZUlpQb2ZBUk1kSW0rOEZIa3VTd1NnSVFX?=
 =?utf-8?B?R1JXVkJ0N3JwRlRDdk5PNkY0YURvWGNyRkdRbTBwL25Yc3YrZ055SXBMWjFO?=
 =?utf-8?B?Q1hMTVVWeE9IVmdsMG04WlRIdHJvbk9ZL0k3MmJHODdyYkJNT0VJeGJkdyth?=
 =?utf-8?B?QVVRbGFPTCtYZjFid1haVm1iZ0IzZm8rQ3V3a3ZXb0hvODBnSndRL2Noek9i?=
 =?utf-8?B?K21hczNiS1VlYnNReW1lcXRPMFo0Rm8xSU5ldUNlb09wNnhhU3dyOE5KMWxs?=
 =?utf-8?B?QnhOYllLNHJnSmltYkRMdExaYVFseTVLYnVLTXdTRkVFN2xSeUpUekIzczZ6?=
 =?utf-8?B?UU4wWllDelF6ZXViaExpY2JRU3RDdGZ6RTBxMFh3NHdwcHhYeVdaazNuOFBM?=
 =?utf-8?B?MHVGSGZnb2JGV08rRFh6ZUcxZnQwQ0hhRFV5Y0dGd3dDaDloRzZpSXhWVFUz?=
 =?utf-8?B?TTdwY1JNSUdEWXBHcmNYZjN3UkNDRVIwUFphRUxDODdDNCtJbE1CZjhwdUZL?=
 =?utf-8?B?eWowb2tCcEEzSyt1WHFabkJUMlFFWlhGQ0F2VnZTdStrRGtRMmJHblpCQ09a?=
 =?utf-8?B?RFVxTS9SR0R6Wm0vQjQ1K3c2Rms5VklvMzhwRGswcXlUQXV3dCtRNUZkYlpE?=
 =?utf-8?B?cUFLVVZSWXIrT3ptZG9YeFV4bHNUR2FabnJ0SWtHb1I1NHBkc1FyRDg0QlRF?=
 =?utf-8?B?Y2UxbkM0L3A1S2krYjBVOWI3N0ZTNytwWG9RUmc3empvSThvY3dzc0JWVUl1?=
 =?utf-8?B?SVpCSU1KVEY2ZlV1WEIwT2lJRTNTY0FzL1dhS3V1UHNrNzBpRmFUbXlyZlVL?=
 =?utf-8?B?TWxiOEw1ODIxNWN2Z2M5THZTUUN0SDNPYzlBWDFMWTVSZ2txOUlrQ0t2Z3Fj?=
 =?utf-8?B?MmpjdEVWeDR2SXM0UUYrMTJodzJtN3RTTERDeE9jT2dwRC9BMXZuRENHeXhn?=
 =?utf-8?B?S01jNTNHemVWMkREU1lkT1J1bGZKOW1CK2NsWUR0WmNKM29RNVBrR2dJYXkz?=
 =?utf-8?B?Y0dzYlk2WmV1M2gyQ0ttaUtYbWxpZTY4MVFZM2VxMmhnR2NHWlg5cmRjUFk0?=
 =?utf-8?Q?qn25uZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHd2cjkvRlJVMzlWbVFWTTl2dzV3eGpqRFpDNDh5amR5SHBxVVFzMldkSGhZ?=
 =?utf-8?B?czZ1V0F6dzZOODR6cUJwZE94Y1RjaDNaZVVwc1o1Nk1zUVRSTFdzamVYWjZi?=
 =?utf-8?B?RVpiY1B5eXB4cFRSR2dSUkU0SUdhcERSaDY4N0ZBMytsUzkwZllZUFdYbHNz?=
 =?utf-8?B?cXBsMm9ydk81OXJpSkVsUzdKQ21XdlVaWlVPKzdVbzNFWlVSQ1BzSUk0cFBR?=
 =?utf-8?B?b2s1TmxQd1l6WmhFY05HRDhNbHdsenpLWG83dmIzbjd5UkZJYmdrdElCVjR1?=
 =?utf-8?B?SnRpOUh3bmVlYUdJeHlSWUErMXFMZnliVmN6dVVuaXVPNkJKbmE4RHR2VER5?=
 =?utf-8?B?ajg5M1lRU2ZqM2ZpMUJXWEQvZkhnMkVJMmxQbitRS1EwU3JxekprZWM2NUxN?=
 =?utf-8?B?QUNjUTVaZ203QWVkMmQ3V0xoam13MzVDTkk2c0Rpbi9iTGlGQllaNTJyUVJk?=
 =?utf-8?B?YmVZU3FKQWx2bzQ4TzZyQnNRVHF2RXhhWW9VVGtvaWZ6Ty9rQTl2alRsVC9S?=
 =?utf-8?B?dlBhNThjQkthMjZDeU5NNTdrK1VxOXNXemNJMDJOT3NwR0JLSW9lS1NOK3lT?=
 =?utf-8?B?TkFJb00wVGR6ak5tNHM2cHh1ZVhrOXF1b01xTjFXVk1CTytCOWZtcFZDWGJY?=
 =?utf-8?B?azdXRGxUQlNxWWFzNTBTR1dCSkJMTmRNUE5adDNBSDZNenFoOGRsa2tscWw5?=
 =?utf-8?B?SUV4c29HWXBNaU5naGtHenowb3Q3eFl4aU1SUUNRclZqbFExN0wzNHF4dWR2?=
 =?utf-8?B?NisxbnBxSlJCMXpGN1lQZ2krUktPanU5T1RDVC9FUk5QU1NqTk43NlVVNUtu?=
 =?utf-8?B?TktEZi9YVVZycW4xVWt0SlBtRW9MUHl4WVpBRGR6cVFhTjZmYlhXQ0lMa0dT?=
 =?utf-8?B?b0ZHMEZxSHBOeXk0dEhscTMwWXhGT0I0dmFnL0UxK1p1TnlFM0g4ZVVkUlor?=
 =?utf-8?B?VXhmTFkyN0Z6VDhpWjNCUjFJaDc1bE0xcTd0eEF6Ym0xWURPbk1adlZRSStJ?=
 =?utf-8?B?SGRsYTNpUnlodzM4MHppLzcycVdFaUcvUGw2TXF0ZDJLL29FdFBmcjFOR2wz?=
 =?utf-8?B?ejN3SlN0dkI3bEFNQTdCR21NMFJ5VFFLdzQ3QnBBSkllb2UxTGpPWFJ2dkhz?=
 =?utf-8?B?NHpDVkZCNkdrU0lsR2RtdHBqdkVpaU0xL1NFZ1BLOUNTdnFGYmpzeGFCNGtS?=
 =?utf-8?B?YmZDdlRweURHVDFFaHFoakdBcmF6ZzIwV2k3WWlYZkEwcEVCNlZCa0huZXd6?=
 =?utf-8?B?WWlvNVJoMktBUXFsZWtoUGZTb0JKM1lXSjRSY2VWNHEydnRSN09mYXhWdjFJ?=
 =?utf-8?B?U3VHeHd6RGhRWGc1MmJwRk5mVEQrVS9rZWtyVDNOUEk2M0VUSEJRbEs4aGxZ?=
 =?utf-8?B?NHdVdVNSWmtSbFcySFRNeUxnYjh5cGx5bzVxSWYvVFZ5dmI4REhqZ1JkSUtI?=
 =?utf-8?B?dGVKRmxDU2dnc2M2c3RhU1hLcWZDS3NOd1o5cisvZ0dydTIvTk12aEppTG9C?=
 =?utf-8?B?TWNGbVhMVzZSVnVHN1ZiU2lOc3BiUlMrZDlsMC9rd09nYWZJSDZlVmxmc0Na?=
 =?utf-8?B?TC8wNzVTb2xQS1N3ajU3b2ZLM3QxS09CYXorem9lVXhtY2twcjVpMFdqY1or?=
 =?utf-8?B?R0hjYlJUNTdOU1lRSnhGZnR6ZW9PTFhqZFhwZ01uNXRvT0pRS0o0bUFxTDFp?=
 =?utf-8?B?b0pVc1JBaXdTVFJJRmc5VW5tUmNNUFJZMWxFSXA0c1lOWEVucW5jaHdSeGZ2?=
 =?utf-8?B?WUlWOVpWTVh0N2RNNytQbyt2bDRCc0ZLYjFlaGpIekxHUVNTd0x3b0E5NUpO?=
 =?utf-8?B?aisrVGE0UHE2S05IN0V6TkZuQlM3TlVmb09YaW4zdlE5TytQV3BaQTNYNVJH?=
 =?utf-8?B?UC9YYTdCT3R5c0U4aVd0WFNXNW1mT1UvNXJlWkFPUXg2cEQrTmViU2YvWmta?=
 =?utf-8?B?VlJvZUhQbzNkZmFFRlllMnVOY281dldHaXZZdzRNcGFTQklwdHh2WXppUnBy?=
 =?utf-8?B?c0oxQVJPTGgxYWxKN3M2MXNjWFhkeUhHWnQwZlBOOXhVbnkwZmU0eWM5U1Fn?=
 =?utf-8?B?cDh2RWVVWlJ1Qmt6eEphMnF4aXh5KytpRWxha0J3am4yQ3VnTUlvN3hNdFFl?=
 =?utf-8?B?UG9tUnhocVNTZFZhaDRPWEpHRllESUhHMVdwdVJCM0QxODNjVWdOckZsbUZG?=
 =?utf-8?B?SXRGSUMwcndJeVF1a1ZRSWFUaXUxdlFVdlg0bTNBSE1seHlxSlNMcmwwclJE?=
 =?utf-8?B?RlVQNHRoREF4Y01vMUJtenppbUhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D707574F47998846BF21830FE8EE43CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9WHMNbXKS1XKOfTjILRgOEdaV6XSIJbmNmGR79IBZWfemXzTF+IJnZCnki2gR/vjRKit+gpu9mwWv31efnemLzOuc0th7pL3as+X73JIDq5C3NQVSPhS01rS45CEx5sJacVd5Zj64/7kxnHTwA2VcfAnztxOXV+5QVly3VLwMK3H4vs6XccBPXk2hDlN3Ub9cV3AuG6TMcpVxyb9GBufrWWAjUOKPtYunxsn7OWkagyWw3tVZ1yjcYOGD7uB5UpJPmYUyKiyPQTAkTvm4s+a515N3azYt8dGOi9rsfAN4yPBnpYQm4nD1EH3GrFaGeUyjMOMAX5jsxsdvP6NnKklLKBCeydCc6qu+mJuchlbdSz8hYixGTyswur8X64TYFNda2ReVXp95sClRROwWS/opfthPgSmQj5ov/j9FgEL7KMXpEl+o4VjO9mHm74YGobJNc4fPeKBe9BDDbRrYS9aStYOuswbwNFSDNlYH6HOldmLdm2yByDB2sSOGLK7ZzfH0y6Sx4Hp63mUYHQhpPvLvb/jMfozf2BWX9CmGPnXnhDDcpU/WZJgpuTZSpvoGXpIEzGCV84p2UqY00uPzOJjp/GTjlDE41lA6H64BpZMJi8KT89IJex+mPNNreOHAveI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc019a6-58ec-4f16-c2bd-08de0592ea25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 11:16:08.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0axRdYV2UeUTxD9dwQLXFOLVBsOqXiZeNRmmpnwPX94YGizsCNmlI/Moe6KXgN4vc4cE9HrQkQQGos0QKp3dXUkkatJNhrUDyghpFtxP88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9266

T24gMTAvNy8yNSA4OjIxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQXQgbGVhc3Qg
aW4gbXkgdXN1YWwgeDg2XzY0IHRlc3QgVk06DQo+DQo+IHpiZC8wMDkgKHRlc3QgZ2FwIHpvbmUg
c3VwcG9ydCB3aXRoIEJUUkZTKQ0KPiBbICAgMjEuMTAyMzI0XSBydW4gYmxrdGVzdHMgemJkLzAw
OSBhdCAyMDI1LTEwLTA3IDA2OjEwOjQ0DQo+IFsgICAyMS4yNTE1MDBdIHNkIDM6MDowOjA6IFtz
ZGFdIFN5bmNocm9uaXppbmcgU0NTSSBjYWNoZQ0KPiBbICAgMjEuNDEzNjM0XSBzY3NpX2RlYnVn
OnNkZWJ1Z19kcml2ZXJfcHJvYmU6IHNjc2lfZGVidWc6IHRyaW0gcG9sbF9xdWV1ZXMgdG8gMC4g
cG9sbF9xL25yX2h3ICkNCj4gWyAgIDIxLjQxNDA1Nl0gc2NzaSBob3N0Mzogc2NzaV9kZWJ1Zzog
dmVyc2lvbiAwMTkxIFsyMDIxMDUyMF0NCj4gWyAgIDIxLjQxNDA1Nl0gICBkZXZfc2l6ZV9tYj0x
MDI0LCBvcHRzPTB4MCwgc3VibWl0X3F1ZXVlcz0xLCBzdGF0aXN0aWNzPTANCj4gWyAgIDIxLjQx
NTMwN10gc2NzaSAzOjA6MDowOiBEaXJlY3QtQWNjZXNzLVpCQyBMaW51eCAgICBzY3NpX2RlYnVn
IDAxOTEgUFE6IDAgQU5TSTogNw0KPiBbICAgMjEuNDE2Mzg0XSBzY3NpIDM6MDowOjA6IFBvd2Vy
LW9uIG9yIGRldmljZSByZXNldCBvY2N1cnJlZA0KPiBbICAgMjEuNDE2OTgxXSBzZCAzOjA6MDow
OiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cxIHR5cGUgMjANCj4gWyAgIDIxLjQxNzUzM10gc2Qg
MzowOjA6MDogW3NkYV0gSG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZQ0KPiBbICAgMjEu
NDE4MTUzXSBzZCAzOjA6MDowOiBbc2RhXSAyNjIxNDQgNDA5Ni1ieXRlIGxvZ2ljYWwgYmxvY2tz
OiAoMS4wNyBHQi8xLjAwIEdpQikNCj4gWyAgIDIxLjQxODY3Nl0gc2QgMzowOjA6MDogW3NkYV0g
V3JpdGUgUHJvdGVjdCBpcyBvZmYNCj4gWyAgIDIxLjQxOTAxN10gc2QgMzowOjA6MDogW3NkYV0g
V3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIHN1cHBvcnRzIERQTyBh
bmQgRlVBDQo+IFsgICAyMS40MTk2ODVdIHNkIDM6MDowOjA6IFtzZGFdIHBlcm1hbmVudCBzdHJl
YW0gY291bnQgPSA1DQo+IFsgICAyMS40MjAxNThdIHNkIDM6MDowOjA6IFtzZGFdIFByZWZlcnJl
ZCBtaW5pbXVtIEkvTyBzaXplIDQwOTYgYnl0ZXMNCj4gWyAgIDIxLjQyMDU5M10gc2QgMzowOjA6
MDogW3NkYV0gT3B0aW1hbCB0cmFuc2ZlciBzaXplIDQxOTQzMDQgYnl0ZXMNCj4gWyAgIDIxLjQy
MTI2MV0gc2QgMzowOjA6MDogW3NkYV0gMjU2IHpvbmVzIG9mIDEwMjQgbG9naWNhbCBibG9ja3MN
Cj4gWyAgIDIxLjQ1NjcwMF0gc2QgMzowOjA6MDogW3NkYV0gQXR0YWNoZWQgU0NTSSBkaXNrDQo+
IFsgICAyMS41MjM4NDVdIEJUUkZTOiBkZXZpY2UgZnNpZCA5YmNkNmY0Yy1kYjJlLTQ0ZDctODU5
Ny00ZWI1Nzc0YzE0NjAgZGV2aWQgMSB0cmFuc2lkIDYgL2Rldi9zKQ0KPiBbICAgMjEuNTI4MjEx
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbSA5YmNk
NmY0Yy1kYjJlLTQ0ZDctODU5Ny00ZWI1NzANCj4gWyAgIDIxLjUyODYyM10gQlRSRlMgaW5mbyAo
ZGV2aWNlIHNkYSk6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWxpYikgY2hlY2tzdW0gYWxnb3JpdGht
DQo+IFsgICAyMS41MzAyMDZdIEJUUkZTIGluZm8gKGRldmljZSBzZGEpOiBob3N0LW1hbmFnZWQg
em9uZWQgYmxvY2sgZGV2aWNlIC9kZXYvc2RhLCAyNTYgem9uZXMgb2Ygcw0KPiBbICAgMjEuNTMw
NjYzXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhKTogem9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9u
ZSBzaXplIDQxOTQzMDQNCj4gWyAgIDIxLjUzMjYwMV0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYSk6
IGNoZWNraW5nIFVVSUQgdHJlZQ0KPiBbICAgMjEuNTMyOTA5XSBCVFJGUyBpbmZvIChkZXZpY2Ug
c2RhKTogZW5hYmxpbmcgc3NkIG9wdGltaXphdGlvbnMNCj4gWyAgIDIxLjUzMzE0NV0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYSk6IGVuYWJsaW5nIGZyZWUgc3BhY2UgdHJlZQ0KPg0KPiBbICAyNDIu
Nzk1NDU3XSBJTkZPOiB0YXNrIGt3b3JrZXIvdTg6NDo4NTkgYmxvY2tlZCBmb3IgbW9yZSB0aGFu
IDEyMCBzZWNvbmRzLg0KPiBbICAyNDIuNzk2MDI4XSAgICAgICBUYWludGVkOiBHICAgICAgICAg
ICAgICAgICBOICA2LjE3LjArICM0MDQ3DQo+IFsgIDI0Mi43OTY0MjZdICJlY2hvIDAgPiAvcHJv
Yy9zeXMva2VybmVsL2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2Fn
ZS4NCj4gWyAgMjQyLjc5Njk0MV0gdGFzazprd29ya2VyL3U4OjQgICAgc3RhdGU6RCBzdGFjazow
ICAgICBwaWQ6ODU5IHRnaWQ6ODU5ICAgcHBpZDoyICAgICAgdGFza19mMA0KPiBbICAyNDIuNzk3
NjY3XSBXb3JrcXVldWU6IHdyaXRlYmFjayB3Yl93b3JrZm4gKGZsdXNoLWJ0cmZzLTIpDQo+IFsg
IDI0Mi43OTgwNjVdIENhbGwgVHJhY2U6DQo+IFsgIDI0Mi43OTgyMjddICA8VEFTSz4NCj4gWyAg
MjQyLjc5ODM2OV0gIF9fc2NoZWR1bGUrMHg1MjQvMHhiNjANCj4gWyAgMjQyLjc5ODYwMV0gIHNj
aGVkdWxlKzB4MjkvMHhlMA0KPiBbICAyNDIuNzk4ODA0XSAgaW9fc2NoZWR1bGUrMHg0Yi8weDcw
DQo+IFsgIDI0Mi43OTkwMjRdICBmb2xpb193YWl0X2JpdF9jb21tb24rMHgxMjYvMHgzOTANCj4g
WyAgMjQyLjc5OTMwMF0gID8gZmlsZW1hcF9nZXRfZm9saW9zX3RhZysweDI0Ny8weDJhMA0KPiBb
ICAyNDIuODAwMDU0XSAgPyBfX3BmeF93YWtlX3BhZ2VfZnVuY3Rpb24rMHgxMC8weDEwDQo+IFsg
IDI0Mi44MDAzNTRdICBleHRlbnRfd3JpdGVfY2FjaGVfcGFnZXMrMHg1YzYvMHg5YzANCj4gWyAg
MjQyLjgwMDYzMV0gID8gc3RhY2tfZGVwb3Rfc2F2ZV9mbGFncysweDI5LzB4ODcwDQo+IFsgIDI0
Mi44MDA5MDRdICA/IHNldF90cmFja19wcmVwYXJlKzB4NDUvMHg3MA0KPiBbICAyNDIuODAxMTQ1
XSAgPyBfX2ttYWxsb2Nfbm9wcm9mKzB4M2E3LzB4NGUwDQo+IFsgIDI0Mi44MDEzOTFdICA/IHZp
cnRxdWV1ZV9hZGRfc2dzKzB4MzA4LzB4NzIwDQo+IFsgIDI0Mi44MDE2NDRdICA/IHZpcnRibGtf
YWRkX3JlcSsweDgxLzB4ZTANCj4gWyAgMjQyLjgwMTg3NV0gID8gdmlydGJsa19hZGRfcmVxX2Jh
dGNoKzB4NGIvMHgxMDANCj4gWyAgMjQyLjgwMjE0MF0gID8gdmlydGlvX3F1ZXVlX3JxcysweDEz
My8weDE4MA0KPiBbICAyNDIuODAyMzg1XSAgPyBibGtfbXFfZGlzcGF0Y2hfcXVldWVfcmVxdWVz
dHMrMHgxNTUvMHgxODANCj4gWyAgMjQyLjgwMjY5N10gID8gYmxrX21xX2ZsdXNoX3BsdWdfbGlz
dCsweDczLzB4MTYwDQo+IFsgIDI0Mi44MDI5NjddICA/IHByZWVtcHRfY291bnRfYWRkKzB4NGQv
MHhiMA0KPiBbICAyNDIuODAzMjEwXSAgYnRyZnNfd3JpdGVwYWdlcysweDcwLzB4MTIwDQo+IFsg
IDI0Mi44MDM2MzZdICBkb193cml0ZXBhZ2VzKzB4YzUvMHgxNjANCj4gWyAgMjQyLjgwMzg3MF0g
IF9fd3JpdGViYWNrX3NpbmdsZV9pbm9kZSsweDNjLzB4MzMwDQo+IFsgIDI0Mi44MDQxNTRdICB3
cml0ZWJhY2tfc2JfaW5vZGVzKzB4MjFhLzB4NGQwDQo+IFsgIDI0Mi44MDQ0MzZdICBfX3dyaXRl
YmFja19pbm9kZXNfd2IrMHg0Ny8weGUwDQo+IFsgIDI0Mi44MDQ3NThdICB3Yl93cml0ZWJhY2sr
MHgxOWEvMHgzMTANCj4gWyAgMjQyLjgwNTAyOV0gIHdiX3dvcmtmbisweDM0OC8weDQ0MA0KPiBb
ICAyNDIuODA1MjQ4XSAgcHJvY2Vzc19vbmVfd29yaysweDE2OS8weDMyMA0KPiBbICAyNDIuODA1
NDg3XSAgd29ya2VyX3RocmVhZCsweDI0Ni8weDM5MA0KPiBbICAyNDIuODA1NzExXSAgPyBfcmF3
X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHgxZC8weDQwDQo+IFsgIDI0Mi44MDYwMDNdICA/IF9f
cGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+IFsgIDI0Mi44MDYyNTNdICBrdGhyZWFkKzB4
MTA2LzB4MjIwDQo+IFsgIDI0Mi44MDY0NTRdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+
IFsgIDI0Mi44MDY2ODNdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+IFsgIDI0Mi44MDY5
MTVdICByZXRfZnJvbV9mb3JrKzB4MTFkLzB4MTYwDQo+IFsgIDI0Mi44MDcxNDVdICA/IF9fcGZ4
X2t0aHJlYWQrMHgxMC8weDEwDQo+IFsgIDI0Mi44MDc2NDZdICByZXRfZnJvbV9mb3JrX2FzbSsw
eDFhLzB4MzANCj4gWyAgMjQyLjgwNzkwNF0gIDwvVEFTSz4NCj4NCj4NCj4NCmhtbSBob3cgcmVw
cm9kdWNpYmxlIGlzIGl0IG9uIHlvdXIgc2lkZT8gSSBjYW5ub3QgcmVwcm9kdWNlIGl0ICh5ZXQp
DQoNCnpiZC8wMDkgKHRlc3QgZ2FwIHpvbmUgc3VwcG9ydCB3aXRoIEJUUkZTKSDCoFtwYXNzZWRd
DQogwqAgwqAgcnVudGltZcKgIMKgIC4uLsKgIDEyLjUxNnMNCg0KV2lsbCBydW4gdGhlIHRlc3Qg
aW4gYSBsb29wIChub3RlIEkndmUgdGVzdGVkIGJvdGggdG9kYXkncyB0cmVlIGZyb20gDQpMaW51
cyBhcyB3ZWxsIGFzIGJ0cmZzL2Zvci1uZXh0IGZyb20gdG9kYXkpDQoNCg==

