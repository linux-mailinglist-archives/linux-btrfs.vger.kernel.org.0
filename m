Return-Path: <linux-btrfs+bounces-10188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F29EA951
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 08:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE75216A607
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12A22CBE7;
	Tue, 10 Dec 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IvdfleXX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebPmDFYD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5357DA6C;
	Tue, 10 Dec 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814718; cv=fail; b=CrLpxphbxBXYGwDyV0bF8zUtFi+Xbwf2dpeYhtNbrixMRKQwSFwVU5XaWrb0kbJIubm+oGZ15MvIEEDiY0Ezv9JhkKmnWlj8ocMQLu704peExJiZZZq0JVYto1PShop8+/Ao7439+tqYmZHkFYjBzZHFEBbJ8FeumICtcDqIeeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814718; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UwT5VO/g93aLlIJDH9PaJHdKe14z43sVbOVO2Y0etLnS1cYWvzHLGiZ+zBkmUCvy0XFr6ao+JzMD0PHuTAfLOxyeFZt3XWaAd31bDE5FjlsiiISq6jkNN6ojJSoCDrzIgbHVDO6yEiUr+TNu8uDPGL2ryQXTJ7A30q+eDzMiUpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IvdfleXX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ebPmDFYD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733814717; x=1765350717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IvdfleXX+RHUP2JSPIsCWNp38JsBHSa9tDkBMPRwG8yvD1MBCuxRCTai
   ZXHPwHjt/tCIDbcmWHHE0wNZDKuTa4unQLPDbzopyEV9r9BsWZFGqCRFe
   P8H5GVqzwRiIihM/I+Uj0PpxyxWrAHQOI7gT4sD2oBjs2K/e+XuzFE37J
   QRm5fjgdsFD0IIpdAo9POoPgVSSqmVo8LsqcTcIFJ6KgsMyc8GdYZ7Xs2
   S3dxuRzRu5z44b8SSY8w7k598Kskxijtz+LrhtoqwORPqh6ENCiod2mA8
   ODydhHU8/cf1+RDMC9H4UZfTLMxpuJPMRJwjSPo2tXG2zAPHqQYhrr6nI
   w==;
X-CSE-ConnectionGUID: J2KjCnmWT7a6PpdlrV7JeQ==
X-CSE-MsgGUID: 4DTYUDLRQRmvkcEuyx9dtw==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="32790250"
Received: from mail-eastusazlp17010004.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.4])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 15:10:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2tzzApAh4Kt8yIOgUSnRn43q/t9AQxAxUA3ZsRP45E6F7zvBz3fv8VFo5ra5pyAOvqXw/yKX5QXUZiLL5fXrVhpSaWAHUqdue6h3swvEOl7tmGgex6I6KCd89eDJt+Yc+QMF8wteYcacpfB0xi9FZBkmEShFDcenXWnHMDOBAFeijsusSLGUfuE5Gh26uY99bywSF4uHnI4OQF7p+/r1H68LXFdzWwzRRKGzLRVM6tMUtBTNhNvg2fabnFggFwpFTHAlrFfVJwQUCnEkOfWoWPQDWYrbibo5g6bvCFNrPYaryEaKPE4RsWbEgh4Fg1ciB8IUE/9IqqxIKrWZaaQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=l+aFHPF39ovuOxt5WQK4uUmPnly2wB95DmO2HxJzRZacc3RBNSckJGC25yuSpzWGQYUWLpXmFONWmnX5WZ7ivMjc6XWodkf3WyHH3bOHZCr0Y7MiR0hNLQG5jApI1qMYWaib4g1Ds9CY2gbxzq094Isa7K65EMxFaf+pHv0k7l6Q+ZcKxmLMl3UmcjYLbAIu7kqEQQoWQ4ScOKn0jANW0G3EAUTxlc89PMqHHYscuVUqJPiHXp2kSbcrDZw+Y7IPUY1KK35CM5hdC95r0jBl+r7dd87B2fkcMIK4DeFLfHM6e+DIw9EfcSeCOSOD4mlWrGh5KXOmSemY8b9jPw1G7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ebPmDFYDYM4MO0PTlzGmDctGxNFW/7c0aIykX5RWMSY5uepgmuZTVcdH5gpinuD8TSXpJu1cRh21ASYg9kSG8aYEOh/Yj5LlVN9HRvVj783vrTXLRpdQPmfBLH5TUhuUdav80YZr+SYnloz84nixfxsShz6rPlfFBPrCxyT3xzY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8102.namprd04.prod.outlook.com (2603:10b6:5:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 07:10:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 07:10:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Zorro Lang <zlang@kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] common: loop device work on zoned file systems
Thread-Topic: [PATCH] common: loop device work on zoned file systems
Thread-Index: AQHbStGd2sR5AKNeZ06UUGwAaj+XLbLfD54A
Date: Tue, 10 Dec 2024 07:10:45 +0000
Message-ID: <c2926f10-b410-4ff5-bd09-2e81bf5535a9@wdc.com>
References: <20241210070314.1235636-1-hch@lst.de>
 <20241210070314.1235636-2-hch@lst.de>
In-Reply-To: <20241210070314.1235636-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8102:EE_
x-ms-office365-filtering-correlation-id: 59509e11-d507-451e-22ca-08dd18e9c436
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y29OWjFBajV5YjhxL05ENjJVWmtVUjlGZ08xTnNSUU9MQjBqWFdBTmRBTDZw?=
 =?utf-8?B?UzJqb1hCSS9yYXpHd2YwbjBFRWJUYS82TS9WT1hqSFExSjRXSkFmbFJQMzEy?=
 =?utf-8?B?bTR0MVl2SHo0Z2FDMXVZRUpKWStBRmlqalNWNlhvbVFvTysrVTZXN1BtRXo4?=
 =?utf-8?B?RTVJdURNRnUvZzVGL2o2YXpJTUowOXhIS3c3N0FEb3lDL0N2T2s5R2toTHM4?=
 =?utf-8?B?SEVsQmZUYmxkY3RETU1jcGVDNDliMWFkSzJ4dzhEdUdZNVNmd1JWbUR4ZG5S?=
 =?utf-8?B?NzJZeVJmUUVQQlhPQ0hHaTM4WUwzeGdNZS9neXpPb3RMSlNTSzkxZGU1TjN0?=
 =?utf-8?B?cWFxaWhvRnVGdXFvbjladjZkNzZpQ0ZmMTB0c1I4MGV0Z081blZSTmhXWGtP?=
 =?utf-8?B?RUJ4YWtMN2NRS3lVYWJMQzMvK2Fxc1pLSlZpWVVaNDR1WWNUNHNyVEx6am4r?=
 =?utf-8?B?NkxBZWh6a2VvamFRMmxQSUFSakFpbzRiSENITForeGpsaUszdDUzV3N4a2Ir?=
 =?utf-8?B?ajNOM3VpUjM0S1pDL2Z4bGFyZUZLbXA0OU5WdDhvY25ITldVaEl2UGs3YW8y?=
 =?utf-8?B?RFVFUVhLdFJCeS9KcVRhUnFSNEdiSUxDVTZVV2ZGSkFISXhTSGZWOFhLSEdI?=
 =?utf-8?B?R2lac3hNVndwVXJyamU3VDRPMEVpU1dKNUNUZk92YXJYcDFOTEdxeTJwZDJQ?=
 =?utf-8?B?ajErbEY0SmROYTFyY05KSS9CR3ZLeWFMMHlsbkdZemRoL1MyZmNzWXc0QzdX?=
 =?utf-8?B?Yzd1Y0JCdjlYOUkvaGI4UTJZZ0tkcFdnb0w4SkV4TUU2VkI3ZFRlQWRqSlRI?=
 =?utf-8?B?cllFcllOK0htK2ZSVWtqSVZLWFBiVzNTRk9VTmlrenBPVDViM05uNVdrdEND?=
 =?utf-8?B?OGhtSWVaS1JBSnFQTG9oOXRkUmUweXQ1ZWtORS9CTExFTWJ2YndPcng5MmF0?=
 =?utf-8?B?Mk1KSVF6d0NkWHV0MFpHall4RWhkZ1FnZVE0d1BydjhQaDVUWTlDczlLR3Az?=
 =?utf-8?B?K1NsVUtMY01MNmFlY2dYTERjeHI1RjBVNE40ZEI3cURMbjBEQWVNd215MGN3?=
 =?utf-8?B?andlV0V6N0dnU1pieFpEVWJ4M2YvWGNXT0RCSlVGbEhad2dGWWhSbjFFSmlB?=
 =?utf-8?B?V0M4MUh2NkJyUjYxSVUrUUNFaDl4cTJBS1N3OC9aTTg2dUh5MGROZ1ZXek5s?=
 =?utf-8?B?UkhRT2gwYnNUWWpNWVA4eWFMNGFQam9CakN3N0ZnZW5sYTFoTnYvYTBSMTJt?=
 =?utf-8?B?TzJYNE0xWnB0WWJuTHUvOTRmK0FYdUFoRWM5YmdqbFB5UVE3U0tkWE44YmRM?=
 =?utf-8?B?RjRkeGNFUCt5M05iQWg2dlVLcFZCbFg2cW41cWhRdGNaWGpxNnZSUHJhVDJo?=
 =?utf-8?B?SHpWRThSUDM3NzFYY2xpcG1pYXVVQWFTdXlXRzhNR2dSL3FEc2pjU3ZvLzYr?=
 =?utf-8?B?THJ5WFhwM29qQkZEbkprc2Z2QndyU2c1WUlzV3BCUndmRjJMT0haQ0ZXREg4?=
 =?utf-8?B?bFJlWVA0ZWErQmJXY3oyK3hRbng2WWh1NUFQNVJVN05SRXpsN2J1bGo2TkxW?=
 =?utf-8?B?enhqR2dHSFYydGxRQktjWUV3R1Q3QUtuVzB2YlVWZ1ZzZktaNkswNVYxOXBk?=
 =?utf-8?B?UmZHWERRWi9ZQlNDYTVMb096ZWhrZ1NhcURxRnI5RG9Hb1p5WnRJbm1Dc3E1?=
 =?utf-8?B?QUVqaTJ4RDlrV3JzMGZPTzNTajIyamIvZ0NjVlFGOU1lTThaMEZTSS8xUmt4?=
 =?utf-8?B?QlV1NEgxRi9acmYrdGNYcWJnbEhBTlBKekhxRkcweEo0ZUg2ZW9ad1oycEFQ?=
 =?utf-8?B?RC9xcUY5RzAybEZxczRZL0ZuRVdCQ2NaNnBhcnJ0RllicWFnbHY1dVZwdmxz?=
 =?utf-8?B?SThUZG5lSWxEUUs2UTBMakpBUnhhV1pnR2tVc0JSU2lHNXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2lrdTZSSE9ON2laVTlVMzE0TXlIcm1LL05BRUlOdUIyYlNTVHUwcFN2QWE1?=
 =?utf-8?B?eGhjQXhTSTdXbG9EaFJGODNaN1N5NWNFNWNCYzJ0UXVJRlBtZVBXNTdKRnU4?=
 =?utf-8?B?cmthK2xkV1ZRRkVJSlk3M3JVMFlrcXgydndSSCt6YjlEL2xCN1JHV2V3WEtX?=
 =?utf-8?B?TVI3aFJEZU9KMFp5WWRTeHR6WFNPaEpxUXVBTHZUbHoreldzSmMyck1OeHNK?=
 =?utf-8?B?aUJEVy9mU0hNcXJJNHAzNzQwQ0NDU0pNd3kyUWZOeXVZU0JESXo4eUVtNGlp?=
 =?utf-8?B?Z1NGRThmNzJidVA2QmI4R2ZNRFJkZlFKWGJFWUlsc0xsR3MwWTZOa0J1Ni9W?=
 =?utf-8?B?WFE0aWRHNUViVE1Rc0ZFQkc2YmR0eDJvajFwY2hOOTJwTXBGcVM4Ulk1RTRB?=
 =?utf-8?B?R2IrbTVlZWhLa0N3SHpVUjM5QXNFenc3b2xwazYrMzRhQmJuTk5JOU1xK1I1?=
 =?utf-8?B?QkVaczhkd3FyellrZ0Z1RitxQ0w2Mk1QWXZubUR3VjRYM3VnNDF2M2hsTzJE?=
 =?utf-8?B?RHJmSmlNNWNXSzNZQ1NWNERoY00xOU0wd3hlYWdpMFJlb3EyWVFsb2FiR1Ft?=
 =?utf-8?B?Mi9QRlpEL2MwYWRwNDcwS3JvVzF5citEd20yR29aV3NwRklhckdVRzByZFQr?=
 =?utf-8?B?K1RoUk5pU21MVEIrRS9ka0RqbDgvUXI1TmZDNWFtT0hlNlYxNm50NitlNXlS?=
 =?utf-8?B?NnJqdVQwMmMzOFV1ck8vUWl6TGRRYis4S3J4aGd1MlB2d3lnYVd3VEZRVC9q?=
 =?utf-8?B?WDIxNC9zUzJZNlhTbTVwYVM5MGUwM1VrQTRWSjNhcXVJZUxkNUlnV2prQWR1?=
 =?utf-8?B?ampRS2h4Q3BTMUp6OWJYZkZHVlExVjd4bTlnQ3FUUFUySml2SHdBaU42ZTBz?=
 =?utf-8?B?SWh6TFltQ0kwVGNiQ3ozcXoyVlNPQ0t0emIrNFFVN1psWW0vWWxxazVzS1I2?=
 =?utf-8?B?cktlVU5MZVJGaVlUcDdIc2lZS0h4MlR2SGlFckpjS3dFL0o4VGN5TDJ5YzE1?=
 =?utf-8?B?dHg0THp6M3VtMUJHZ3VXTmNIWjcrTis2bHc0a21xM2M1UmpzRXYvUUpUbUlW?=
 =?utf-8?B?ZjlZT0xSYkMzd2YrbXJRNE50TUl0S09SZWhWOHpWRkcvMm9zMFZwMUZYV3dQ?=
 =?utf-8?B?ejk3MERqN1djYUhOVE1nSExHeVZzU3dMdWw3SGs2UGkyNWsrQjFXY2k0cXpO?=
 =?utf-8?B?S3M5QzIyRFB5ZENnY3UrLzlPRlRTUjUwekRacHc1QXRISEppcjIvTFppMzd2?=
 =?utf-8?B?dkFYdkpWZUw0aFNrNVJHcnJhZC9oTk13am85QzVwSENLTkIzWjVjUHlWRlh5?=
 =?utf-8?B?bUVqN3Y2QXEzaFJkbjFtN3ArSFlPRWxMRGRlWUxpWW9zSjJ5NDJCWTd0SVNJ?=
 =?utf-8?B?QmJOVUxMRVdCY2V1eXZsWmpPa1ZpNnhYUUpaZTZiNVptRDRuZGpuN2xDQVBl?=
 =?utf-8?B?Sjg1TEIycmNVa2FReDB3T2g2OVl2OVhEdGpWeUZ6NVMraEdWcWNHR3dEWVYx?=
 =?utf-8?B?WXhNSU93bjl4TjhHZWRjMU0wcDV1WVQ0TEVXMk5SVjJId2tBN3M5K1pNL0Z1?=
 =?utf-8?B?SnpkL0JENjN4WXpXTExtc2VNeCs3YXgvdHJKK1lHL1dEcjFUUk9DNHQySjlF?=
 =?utf-8?B?WUVYeDZOVUNMeVVZZDJza3B1YXY2Wks5eFNoc0t6Rm01QjZ5RVJwalJNTWRL?=
 =?utf-8?B?ekJvcTNCTG9hTUFRSDRQajFvVXpjbUtKb1Jjb0VrOFR6VVZlRnZscHF1RlBM?=
 =?utf-8?B?S2ZzWXVuakViV1Y2VTdhRklTMVo2MmZ2OEMxVE0zU2ZPODA5cGd5ako3a1Y4?=
 =?utf-8?B?aXFneEZkb1dOTklTSElmNjQraHAzNStEVEEzbnpqQ1pZdmN4bU15RFRXMENE?=
 =?utf-8?B?MGZtdFpGaEJQWklNdTI3aytBWjZCTEVBUCtTckZsamlxWDRQTWhqaXozVnFY?=
 =?utf-8?B?WkRtbDJWOEhsZGJPR1lzWlhnKzdoc2NJbmx5ZmlSOTFvYVFaQlA4aER3c3Ez?=
 =?utf-8?B?aVQraGZaWGFiZFRZQWovR3FSd0RLNmJVVjJqYndJb2pFdWFyWUpSMWFXT0ox?=
 =?utf-8?B?TUNmRUZYZ1ZJUFR2SklaNjFCbmtoMktSanR3TUNYdkI4K0tIWk9ubHlTVzgy?=
 =?utf-8?B?NlRaakFRcDdrUkV2cUhlaTFwd2s2c1B0WGN1SC9YYjNoeG50TGNpc21OYUVN?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99ECF7B746A3814287AB7EDA7646A919@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bYkxigdZZtg6iidegi+FRlE1LPRfjqlzuv12pKRDOZ5xgqH55+gibhz7sBjD6h2oOi6iLGQLHBADVzY63QXRCeWRjTnVBtJa6cZ5RiWquItfRq10QqInVjwrhV4Q6qzWsqZq2gamp2a8eUi+0w1pCNV1XNnhP21DPGq2CZohWJQkhWW1OhH4QHwi0wzwIXtpew6k3G1CurcLZ7STnwu1yqXC9PIh6pUQNOrurX1zPxtC+xsLoQ1SPGRTSJ7MizXXPykcGkoPC+VNGBJjop47ISUbuGsi+gY4IpxrYrVGZk5j4/tMCglGYDO4fMUDXI3OUIwgBZIBrrU12FEjCOUpS0zh6HO8bOehwID6CP6QpdRtUG6K8bNc4W2Gpl0RmXL003YCZ06SMV71dH09Wcg+CQtCLxXd/5k6IRq/DlEsdId+yl6V3IwozSD93KI8dslpFzf0M85tZzsjj9Dz5azs5wNDFFATiHxUs9qdVyhFHYbcHjH93s83MTtybwEL7oDBgSZt7uqWPz8zGuw0tQzaoO2kts382M4ldYw6S3w6yWpDlSR0o6jSuV6CF6g1PfcQCFo/cM7o91oYHFl+rZKrn2H6Xk7avgRjd5DfhBfL+boOPt6UMBcg4wVb7k1eKSba
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59509e11-d507-451e-22ca-08dd18e9c436
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 07:10:45.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKJpIdnW8qEfAdrSdckZ0VTJa3qPhRA3hTcfIs9P3hlV9R6Y2gprq2LT2Dhu4+HftV9NO4B923TudbZOYpFPj29QIzQMEqgJZ+ntGWbherc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8102

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

