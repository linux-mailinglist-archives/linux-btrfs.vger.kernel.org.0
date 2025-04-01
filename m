Return-Path: <linux-btrfs+bounces-12707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30419A77414
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 07:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5E51686F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 05:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478A01D63F8;
	Tue,  1 Apr 2025 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DT+JwJhJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qBQVC8Go"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E080B
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743486462; cv=fail; b=FPJVssh5LEtGKYvEe18u0+Gc4KmPB6+GCA2eUU96Y2K5DIWZeGZbyeqChIJsH6GoB3HQuiUIBVgvPTXkB6FTwDZJ7fncfNJD++8BNWVs1bItDnoJe0C1KZkJ67w2rp4/jK0rkpZVVFZXnraVLmf90sayxjXPdNqrNOOu3UjQ2PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743486462; c=relaxed/simple;
	bh=yStSFv094CI7xPrJSDLoct1Z2mfWWAlayaqhPfyUF4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFaunWUxA75NUaa7eOHz7TtuVaVunHsBsjlc8Pc3zF4Kk99XN2+9xUYJBPZhYpITWrLL01EOj/ljXrX+9wnsXByW2g3N47YU+G8TvRwRejVSjqhAkfIj2dkcWcH5gtGxcZ6/A642ub/lL5kj0kYsnEzbX/KOVaN0nqixbCRGDYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DT+JwJhJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qBQVC8Go; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743486461; x=1775022461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yStSFv094CI7xPrJSDLoct1Z2mfWWAlayaqhPfyUF4w=;
  b=DT+JwJhJNijHZNUM6MRlJKAHOo1oOrD3XG7TsmtzeOFsMp7gd0ZAEYKD
   4H2k/q4kW24Q8oGaIu/+bcz9xbPk604cRHYNQCDsTrpMH7G8cboqVhs7A
   NZLZ4JCPkfcGtFCpzWblMDti8G/Ry6oYdbGj0TqS0cr6KUMMuwUL66igY
   ELJdnXesxsfjiIZgW8EVeUf3ZfTpuXcQVLs+SdC+QteHi3l8OM1/4jy2G
   +HA31auz+7HvS0s0/2LZfyonvOrVkjmQ4fTT/ZpIEqKShRhpcjbWjO39G
   C+NcvEuCuPSXyNibA6DWoh5IBCGj5IsiYPsTYK/2Gmrhho8wDH6amkOoQ
   g==;
X-CSE-ConnectionGUID: w9uFXzazTJeodkeQakK/MQ==
X-CSE-MsgGUID: JBE0dQ54T1qO2lM1NtLCJg==
X-IronPort-AV: E=Sophos;i="6.14,292,1736784000"; 
   d="scan'208";a="66718417"
Received: from mail-northcentralusazlp17013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.62])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2025 13:47:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhjokZafZ+s8CcChuLM25JLe3hVzEjf0eY5x18TfN4jPpzAVZbtV56aOfRzhSgCt0/CzhN0LR4RnpInf3Khb9uGhFM9+i8AapjuTFNdL5mIkikUeIkPVt/sQ4t/jAF6MVkxUbujBFSv+oeOXw3RWKfK4TOTShCpig5+beOTfsnzi8FJd+4Y3RPclMrR80C5K1zA/Jn7I3XAJFd1CxWDzP+ESSaIRrIw0jHro/S2UMBBCo5boU0ku4YKflHyIYsv0ucu8OnMUfILzQ7IvUuTSYfHDiz6hGvg57izui0MVBKFBYHHSWYdb+8Yc88xCAhF5N9qvZ8XVNBQaEZkNy79gyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yStSFv094CI7xPrJSDLoct1Z2mfWWAlayaqhPfyUF4w=;
 b=wKQIvpd+rMFHPptRRGXtzQ8E9WkOiT9xglnGG29w77Sq+lxmAPg3e4My9UajHE6Cu5OqYklAGz3U8/IKb/4KHl/hN3WeDQbm6rhcglO4XJHw9+k8Nzq1uhZp3Fey2oKuKmck8AtAlT2wxWR6DGHcFnjTOdBz4nh5jYzQTRDyAI6/G56tuGrZGHC52tGCOeMoZfYaa/tR2XHNCXQj7gKjJFcQuRSCXnQFVxByA4YAqjjB3l8EhLa4KTHGja4Y++HKGKf92i2OHIBJfPlPm/2+qYccrKZx3LfnsMiNI8Pdd9AQQHFFLCyV+c/0xCX3vTRsGcqPsPHd+k2GTkSabuzg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yStSFv094CI7xPrJSDLoct1Z2mfWWAlayaqhPfyUF4w=;
 b=qBQVC8GoYov5tKDzCwqs9tVfeYipsXVDeHC884OgCnTw0ZMHGCYnxuJfSMMp/TyBpxPGnAJ+IipTVpLYtFSjnsw+HaTISMa5XaUaXJ/b0vELqpxfzrAPFHhh9uMI/YY8dTMS6jGNi1Aqi22MKvlAwQkIB0Vsf0Ts4MA8bQwY6oM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 05:47:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 05:47:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use rb_entry_safe() where possible to simplify
 code
Thread-Topic: [PATCH] btrfs: use rb_entry_safe() where possible to simplify
 code
Thread-Index: AQHbnzQOj+drIlLSaEGBsKX389DMYLONZt6AgABdboCAAJBaAA==
Date: Tue, 1 Apr 2025 05:47:19 +0000
Message-ID: <c6658881-7615-4780-b9ac-765d374a7cab@wdc.com>
References: <20250327161918.1406913-1-dsterba@suse.com>
 <55112570-95ed-4a63-9f30-7d041cd8e72c@wdc.com>
 <20250331211039.GK32661@twin.jikos.cz>
In-Reply-To: <20250331211039.GK32661@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6446:EE_
x-ms-office365-filtering-correlation-id: c03cbbda-c631-4ab3-bdbe-08dd70e0aaa0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzUwcHNCZUg2Z0VZdEZZWGt2ekVsZ0RsMVZMV3NoS1paeWRORGJmWTVOa1NP?=
 =?utf-8?B?RWdxVDY4U0VMWHNPSzRWRWxEcWtPY01ucVZ6UTZRRHg4ZnNsYXFlQkZkc0U4?=
 =?utf-8?B?U1YxNlpSQUlEaFRxZUtpQm5uUWJkYmVHaHI2b2UvY3BRa0JoMzFmYlZMNlpI?=
 =?utf-8?B?QjQ3L1UxOTJZOHdJcXVwTnZRMnlkL0VocmY0eENCTUlQUXVISmJOS3M0VEFu?=
 =?utf-8?B?cHFiN0xtekE1N3M1NXI5bWthaXF0V3NKalBGTXV6ZllvcnNsakhGRHY2Nkdt?=
 =?utf-8?B?NDhVM3JKOFFLcm8venB5VWhqUE1sYlFhSTA3ejhxSmVMMlVTb0ZDZm1Wb2Mx?=
 =?utf-8?B?N29KUGprVFp4d1V3QTRMcGFHbWZWckdkdnBJV01KSElhdldYZ1l3cWdBenJN?=
 =?utf-8?B?Q1hobkpXNGlrSThHcURJSEM1SEp2RVV3N0t4Z0Zoa3FoV3pjYXVGR2tkNDRp?=
 =?utf-8?B?dXBXWmthUldoNGprNFRtd3BTaFd2NmRnMG5LQTlHRVJxbFFXWTBCWnQ2L1c5?=
 =?utf-8?B?aU8yeW9mb29TYnkvTTIyYmFEVjd2Z1RGRktpdDg5bXVXdTE1OFgzYjZ2eTg4?=
 =?utf-8?B?V1lLclZ3cVk4aHpheTFkWDA0ZVRpM2RrQU9DS21NaXIvN0wvV08yNzJENDVq?=
 =?utf-8?B?dllpRWZobDh1VkNKaHFqQVorZk8zMjJTVlVIcTN1cU1GbFA5Rmx4MWtGMkhu?=
 =?utf-8?B?ZFdjUmFqSTFuMUEzVVBVbUxDVlphYjRxdERJVWtvWjhhN3BHN2lrbGJMN0E1?=
 =?utf-8?B?M2MrRWlrTFBobFFuMnJFdEVVcXVrZ2JNbG0vRVpQcWFBQ2pXZ1dXMys4TlI2?=
 =?utf-8?B?SGk5ZUdlTDI4dC8wbGhIS0ZKWTlSVDRDV3lWRjZad1hwaXFNSHpaVW5pbm9k?=
 =?utf-8?B?T3BHSFlxSmtwbllsd3V2MExoUDg1UDV4dElCektkZHBDK1l1ODRZQkVjN1dW?=
 =?utf-8?B?NnlrL3FPa1ZQYi92TEU1UkthK3hGVzhJZ3g1bUdNN00zYlFYNzh4VlF2UE9F?=
 =?utf-8?B?ZHEzcmJrSlBqUHVocGNBYllzWDFlcGtzTDZjTXFNYUFuMlo3Vm5FdW85Q0Z4?=
 =?utf-8?B?TjZYWWludVVWbkFPbURBSWdtUmpJd2pPRlVTWk5zTWNsVFp5eXJQNHNkN1NO?=
 =?utf-8?B?WlAwZCt6U0h0Q2NidWdnY0ZDR1ZweG00bE50ejhRZ1BoMnhJcTlBS0FCWHll?=
 =?utf-8?B?SXRKclVGUnBOVVZHbVF5UlJuT28wY1lkQVcxYzYyclF2MDBRK2JPd09waWZ6?=
 =?utf-8?B?bkk1eGhZOFZSVS8xVGRhZlU5bXRqZUhNRk1GcUZxZzJqZVV5LzFNMlR6QU9R?=
 =?utf-8?B?bWVVZ0Npa0duOCt0elV5dDltcHN4Q0JHbHIyV2pxeFk0TldyTGV4K2tjYmlS?=
 =?utf-8?B?QUlhT0JmaVJvTFBuSEloN05zaTZPTHozcXlLS29QSStkdDBTL3FpNW9VZk1G?=
 =?utf-8?B?ZW9HU0dkWlhZTnNFVVlMSk96RGlzN3djQ3k4emVHQVN5aUJzalRLRXcrbnZz?=
 =?utf-8?B?SVB5OExsMlJhZG1pYkwrY25ialVaeStQZjdVYW1jK1hMRFJZME9lbkJtNStE?=
 =?utf-8?B?cTJQa2RJdmxUZVE0QnFnbThVYkZRUFZCRDFtWXQ2TDAxamo3d1ZDR2RqWWxQ?=
 =?utf-8?B?T010ZEJnZGJFMVJxdUdybTBOYUNVVVFLZFBVejQvazhRSnZCbm1sTHdNYTdP?=
 =?utf-8?B?YndRS2Jhelh6VVZoVDNKVXp3M1RFRGJsWXllcEZDbU1JeHMyNXh5NGNaaURJ?=
 =?utf-8?B?MWtxbjlPMHFWRTVKVWNFVEpZazNnSkZnRCsvK0gwNldDdlorbHJyZGEwTWpR?=
 =?utf-8?B?dW84ZGwzaFBLdkJ0TUh2UW5rTXAyUTVmYWdCbGZvb3oyYWlyTzhKUVdvWWNr?=
 =?utf-8?B?R25wR1J6a2xFc2NTamMxNUU0NS9ZZWY5bXV2NmV2cVlNVDF3dEJlVFBIYVlm?=
 =?utf-8?B?cE00RzlNeTZCUnR4V0RuVHNSaDVOQnVhbUNSdmR5ZHcxbUFSdmh0NkVMeENU?=
 =?utf-8?B?Z2lNdVVFZlFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N05TRjhqa1lQanhLbGs1dktMclk4c3ArZkpwYzZqdDJTTnhWVlNHcmdqWXNM?=
 =?utf-8?B?dnluWC9QZ0hUdlRUUjZjUXkyQU1mL2FhdXJ2b2NLUzNtd2NTSnZnVVlNbTg1?=
 =?utf-8?B?RmUzckdMQmQraTZzb0dZYmpHY3RaWlk3cHRPVEFGRk1CQmtVRy80MjgyVW1I?=
 =?utf-8?B?MVpENWxvM0dSbmxrYVkzcjZZdElLRHAvR3RIeGpyWGNXbmh5cjYrYXdZY3Fr?=
 =?utf-8?B?aHVwMlRTeWN4VlBYSm5Sa0dwTW1pVUl1NGFCTlkzbEVmMXowNW9mcGxlWmNS?=
 =?utf-8?B?RmwvbEM3Vlh1WFFNTmlzS1daa1NueFoyc2Z2TmtQQS83VnN5QjdMdVhITjVR?=
 =?utf-8?B?S3hTazN0NmhXdnp0SUErbXI4YkxUU3pJQnZPSmU1c2hZS0xqbDhqS01FQ3hv?=
 =?utf-8?B?QmM5RVExb1lhVUpSSitGNi9CMkxmcFFxbkFzaldlaGFQUkxlOS9Ka2o5a0Z5?=
 =?utf-8?B?Y09TYmZ5TDVUbkQ3WFYyY2hZUUwrZDRpZGtOYnVEc2J0V2h2REZBOXdRZlhn?=
 =?utf-8?B?S1hhRXptRE00OG5sQ2NwUGovZkVWTkRoa0Y0QTFhenA4R3VsQXNsSVJrUGV3?=
 =?utf-8?B?ZkJGRE1ORnUrU3ZmcFBPSEtqN1pablN6NE9Bdlh1dWFpdXJXRzhZdXgwaEYr?=
 =?utf-8?B?TFZid1lSM1QyUEduVjBiRGtQeUhwVm1mSmhUUjZ6WDBYMlNlblhHVE9NRjEy?=
 =?utf-8?B?QnhYRTVvQ0NtemxhSllDSFo0TnBROUFiekpaVG1Ob1pyWUJOcmNHQ1ZJU2xJ?=
 =?utf-8?B?WFRVWTl5MTBFN3ZXdGp5Mk1EcUdDYmtZKzZaNk1OUkJYUjhyUkg1U0xJbk14?=
 =?utf-8?B?bjdPYW1DOUUzbzhVTEx5bDhUM2o1clpSdXBOU2hjSzBEM25YVUMwcVh0NTc0?=
 =?utf-8?B?L0o3aTd0blVLZkpWdmZFV0pUaTlRRXRSOHh6dWwrbnlYdXhzWlhIM0xvZ1Aw?=
 =?utf-8?B?Uzc2Mkt2bDlrMlJBejFjNGpucVdHYy9BRWRsRXk2VUJlT0VxcGVGMlRWaDFU?=
 =?utf-8?B?ZFhBMDc1Sy9xUzJEMHM5bXJnVmxYek1GZThzSHFJTUh3Y2tHeEllc2JOVDkv?=
 =?utf-8?B?U2M4VENVb29KRkpVUUFpajM4bFNlOWhrS2lxZkh0aEt1MWtwRVpETW5mT211?=
 =?utf-8?B?Nk5NbU1xNzBwUFJmdDlpRUdYYitKWDNpNHQxWDR6TTM3UkJVb2dicUZoNG1j?=
 =?utf-8?B?ZW93Q1dmYzc2bVFuRm1TcmhrcDJJL1hkeUxaQ1lFUnl2bUxSZTl0UGZlaHZY?=
 =?utf-8?B?UXBwNTJucVhFVDhKWnNDRXNEL3l5MlNiMFpYd0VFN1E1bU45RTUxemdtZ3Jo?=
 =?utf-8?B?eE9KdjYwRXcxbmR0anJjZVBpNWEzcnMvYmdLbVNqRzBqT2RIVlY5S2E0bjJw?=
 =?utf-8?B?REIxN2ljR2pwYnkxdGlJWHliUTB5eWRjYkk0a0xRQVErdjEzVWZWcjZCNUM4?=
 =?utf-8?B?ditnQStQNndXRkZRQzRWcjNhcFR4clBiU2JJV3BqOC9UUXpQaE9YR0s3YXVR?=
 =?utf-8?B?RlQwSUErelpvaUZuMW9mems5ODRFL0w5a2w4dGEyc2lQcFJTWExiSm5Qd2NO?=
 =?utf-8?B?VFlKbGVsaEFhMHZlQUNGYUpQcm5Hb0w2UWtna0c2LzRHODJMclVnTTRma3Iw?=
 =?utf-8?B?ZERCTHVoanI0SjdvbjFCQ1E2Z0VmWnNUNGpiS0xXL2ZLbUw2bjZxeTlVZkNO?=
 =?utf-8?B?bzdKTWQxTllZajR3SXZGT1hDWXNxc3BBN0VpOVIvWFZrUEdoNFdZa3NmdWx0?=
 =?utf-8?B?eVVBNmJCNFAyRzRSN3RqbzBEOGhaOW5oNzJSd05wL1ZwZVdwcmVJRUQrcFdP?=
 =?utf-8?B?MmxKdG1rdFlmcEpZajJDemVnR29RcVpOQUYxRXZZTmRxMWM2dlAvZGdnUG50?=
 =?utf-8?B?KytDNnlzNGZCMjFhMHNoUFp0djdCcU9BOENWbW9QNnhxNWY2aHU4YVk1QUtB?=
 =?utf-8?B?U0QxVVhlVHJaL1BGVFBvS0liNHNrc1lydUpacDZ5bkhLdXZnYnQ2bTI4WVZi?=
 =?utf-8?B?VHNEUFg0RktjTmpmNnJZeEFORkxnaGhHTDhJbFlKNEFsSTFhUXdWNlFMNEU4?=
 =?utf-8?B?QnRSbTVlTHVqUkFQNFVuQUFTczNINnh6U0VGUS9NQVpWTUpHNlU4eGxsRkZy?=
 =?utf-8?B?VUFsZVR2N04wZnlpZkttWkI3bnFVVDR1NDZlUStYQkpYdDFPWjlBYUsyMGov?=
 =?utf-8?B?WDBFdDRkcjZHUXFuUnBpWnhHTDZ2T1FCU1NEeTRUamMyY3RZeGZ3SGczM2RB?=
 =?utf-8?B?WDBLMG5oai9VS0ZFL0NYSk4zc1hBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E971F168568F8840ACA8FA2F17FF195E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VzsHh9vQ8QUASrZ5OIUdu5sg+/z7moEgsK+tRZ5I6O8PNes21dfNc0PvMGu1kkrXDda2T4BfMN1qJgmrLikIB3KhnefSH0B36sT8C+SmtGgzHnkFBFWCyIXM+VaSeRy9/B6Yyy27Y0Om9ZGsQKcUZJfTiGa8kQ7ubs7Vzk28eyC0RyyicrrxOyTlf9wnNqV/Up7vx8+hAvEAMSyxWm0EVk91/ZBJhydZr1mJnI78i3dadKRZHF8FzKwm7wWdK6hnsKJnP4CFN4AQdMta9B27pqZe3t+VrS/4GVOVFOwOMfrAegpEoGbexXYhNl0TkH59A9rk5Qv+sO2sFyjCy4nYH3X1k3c8Mcp4WOYWpRzkyppdELXCjtPq0uAlgoFWyCSLA/eSKF5HlhYA6ezDpHkDU2xdFsMYtG0Owgvhw3P2m5A6FHnhbsLkgRjdSUqoXUID+qkCa+BjfMyxb0O45pkuDbE2VVXQWyveOJs5PcRZ0vDqXNfnMuqKy0W9eoJWr4XR1mmr5BAPLDT0Pt45B9DtyI7yiABuwk3n1jUHWjdVSp1JaZ8QPd34Ff+ODPFUo1hMsreBZu8Ci1ElyOoUh2j4RbgpiNvgDHNNmUhQ2S6u9Km0/QIs3wqSqiNkwuFibG7q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03cbbda-c631-4ab3-bdbe-08dd70e0aaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 05:47:19.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRq7HGADPNPJX7l3QKqIXoSRZHW03Tz98iiF2+uGMe6/lXcFMQW65wd330+owGckPyHAVXSRdPrWvI8ItC4tunWjtUs4EBGxri4rGskDR3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446

T24gMzEuMDMuMjUgMjM6MTAsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gTW9uLCBNYXIgMzEs
IDIwMjUgYXQgMDM6MzY6MTVQTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMjcuMDMuMjUgMTc6MTksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvZXh0ZW50X21hcC5jIGIvZnMvYnRyZnMvZXh0ZW50X21hcC5jDQo+Pj4gaW5kZXgg
N2Y0NmFiYmQ2MzExYjIuLmQ2MmMzNmEwYjdiYTQxIDEwMDY0NA0KPj4+IC0tLSBhL2ZzL2J0cmZz
L2V4dGVudF9tYXAuYw0KPj4+ICsrKyBiL2ZzL2J0cmZzL2V4dGVudF9tYXAuYw0KPj4+IEBAIC0z
NjEsOCArMzYxLDggQEAgc3RhdGljIHZvaWQgdHJ5X21lcmdlX21hcChzdHJ1Y3QgYnRyZnNfaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZXh0ZW50X21hcCAqZW0pDQo+Pj4gICAgDQo+Pj4gICAgCWlmIChl
bS0+c3RhcnQgIT0gMCkgew0KPj4+ICAgIAkJcmIgPSByYl9wcmV2KCZlbS0+cmJfbm9kZSk7DQo+
Pj4gLQkJaWYgKHJiKQ0KPj4+IC0JCQltZXJnZSA9IHJiX2VudHJ5KHJiLCBzdHJ1Y3QgZXh0ZW50
X21hcCwgcmJfbm9kZSk7DQo+Pj4gKwkJbWVyZ2UgPSByYl9lbnRyeV9zYWZlKHJiLCBzdHJ1Y3Qg
ZXh0ZW50X21hcCwgcmJfbm9kZSk7DQo+Pj4gKw0KPj4+ICAgIAkJaWYgKHJiICYmIGNhbl9tZXJn
ZV9leHRlbnRfbWFwKG1lcmdlKSAmJiBtZXJnZWFibGVfbWFwcyhtZXJnZSwgZW0pKSB7DQo+Pj4g
ICAgCQkJZW0tPnN0YXJ0ID0gbWVyZ2UtPnN0YXJ0Ow0KPj4+ICAgIAkJCWVtLT5sZW4gKz0gbWVy
Z2UtPmxlbjsNCj4+PiBAQCAtMzc5LDggKzM3OSw4IEBAIHN0YXRpYyB2b2lkIHRyeV9tZXJnZV9t
YXAoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwgc3RydWN0IGV4dGVudF9tYXAgKmVtKQ0KPj4+
ICAgIAl9DQo+Pj4gICAgDQo+Pj4gICAgCXJiID0gcmJfbmV4dCgmZW0tPnJiX25vZGUpOw0KPj4+
IC0JaWYgKHJiKQ0KPj4+IC0JCW1lcmdlID0gcmJfZW50cnkocmIsIHN0cnVjdCBleHRlbnRfbWFw
LCByYl9ub2RlKTsNCj4+PiArCW1lcmdlID0gcmJfZW50cnlfc2FmZShyYiwgc3RydWN0IGV4dGVu
dF9tYXAsIHJiX25vZGUpOw0KPj4+ICsNCj4+PiAgICAJaWYgKHJiICYmIGNhbl9tZXJnZV9leHRl
bnRfbWFwKG1lcmdlKSAmJiBtZXJnZWFibGVfbWFwcyhlbSwgbWVyZ2UpKSB7DQo+Pj4gICAgCQll
bS0+bGVuICs9IG1lcmdlLT5sZW47DQo+Pj4gICAgCQlpZiAoZW0tPmRpc2tfYnl0ZW5yIDwgRVhU
RU5UX01BUF9MQVNUX0JZVEUpDQo+Pg0KPj4NCj4+IE5vdGhpbmcgdG8gZG8gd2l0aCB5b3VyIHBh
dGNoLCBidXQgaG93IGRvZXMgdGhpcyBldmVuIHdvcms/IElmICdtZXJnZScNCj4+IGlzIE5VTEwg
d2UgcGFzcyBpdCBpbnRvIGNhbl9tZXJnZV9leHRlbnRfbWFwKCkgd2hpY2ggZG9lcyBub3QgY2hl
Y2sgaWYNCj4+IGl0IGlzIE5VTEwgYW5kIGdvZXMgYWhlYWQgYW5kIGRlcmVmZXJlbmNlcyAtPmZs
YWdzIHJpZ2h0IGluIHRoZSBiZWdpbm5pbmcuDQo+IA0KPiBJZiBtZXJnZSBpcyBOVUxMIHRoZW4g
cmIgd2FzIE5VTEwgYW5kIGlzIGNoZWNrZWQgaW4gdGhlICdpZicgYmVmb3JlDQo+IHBhc3Npbmcg
aXQgdG8gY2FuX21lcmdlX2V4dGVudF9tYXAoKS4NCj4gDQoNClJpZ2h0LCBteSBiYWQgKmZhY2Vw
YWxtKg0KDQpMb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

