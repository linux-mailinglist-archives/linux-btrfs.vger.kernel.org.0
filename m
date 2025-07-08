Return-Path: <linux-btrfs+bounces-15332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A3AFCEA4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C7426DA7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367502BE020;
	Tue,  8 Jul 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ztfn9Hro";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RsV0OIZd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91242DFA4C
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987436; cv=fail; b=XyuYhbh0OMvEVtPmMlBiF+R2UHDNfg/fZrpPwnMg3SGG3HIg/aT83sYiayXzr4piywOipK+CRdXBrVjYa7tu/yLtlFAabMyGYxltML79YbJ40q7Py6hK3OlQmTbrRqCxIPB0DF/+eUVjsvAuTabWzwk1FqhBpHAuEcU7AfKutNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987436; c=relaxed/simple;
	bh=S+ZrHAmpTlpNIUvr6/0L0IR7xLLuYo5wRegG/X7xJEE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TaBqfugLgoKADObiiD0PZO7P/N1XZnsjQvwHaoXx5/mwx447BgBd6qE5luo1WbHsWekcsVVkOeHwP7+a1iuvzwNw9Nuy+wzwpwjAYFAsSW4OF9+dLy5l5lvdF/nlAN3C4GvtxG6fSdjtF8IS+F/ZRdRbJM5pIE5kvfgylyAppE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ztfn9Hro; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RsV0OIZd; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751987434; x=1783523434;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=S+ZrHAmpTlpNIUvr6/0L0IR7xLLuYo5wRegG/X7xJEE=;
  b=Ztfn9HrogMpEJCq5EjD1+2YZ5ma2A3RKyQheDKLaYPUFCeWz1O2X1Xxe
   w7lAqmXzhUOqnMjux6DEBUI8d0kjHRgMK9xNd+HbPsiwoDuZoyghXKHux
   S3bwS4SJmM+7xiaUxoYMb2XIM5GmNGuQxB3wFqH9eCtFUCgufdRDZuexj
   v+PSE0ZJwe+F8Cv/eSU0hEKSorh10ZeiPOcow1+dM4NO+xc5UwrUB/Kw8
   43aY26ih6IvbiuGj3RbQ9l4bbPJYkG236C2wsyGyvF4QjaCLQL9zv8jJ8
   lGoG71BSnI+wy+ZLrZb1gtqqRxi6J3GQWuGhW+dBTKf+/giTmwZHnr+5H
   g==;
X-CSE-ConnectionGUID: Z+MGyyAxSy2nMnu/vSS4VA==
X-CSE-MsgGUID: T7o8dRzMThyQcZryQSZcQg==
X-IronPort-AV: E=Sophos;i="6.16,297,1744041600"; 
   d="scan'208";a="90919530"
Received: from mail-sn1nam02on2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.59])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 23:10:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2aLYOYgQexch3fYs/uXTtL58x5Pb7w3/eVWFOoOVu/TRwBKbJIznj56kZqurEJefQi1T0Cr+AYJZHczpFtl72QzwTDTTpyiTdoc9I8wtqwpL27kv+fCpJb+lwjbZ22Pvmbh72DsnITh+hoNklNh/AJSAqW2tPsacrHpIifT2JKX1gHJGwRH/acs9S1UPeYBxVUOTFyv60sETK+KSazWEufAdY3phbMhKhYgaDEN4idt93bqTGF8jwt2AeJ8HiPB4xy3+eVIk02ZU7zYBw2/ERq94aj3iRroD9zoSaD0UP/w4BpX4EGG6yx0Z/yRw08tCc2J/RPwgSUlgt9f+wKkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+ZrHAmpTlpNIUvr6/0L0IR7xLLuYo5wRegG/X7xJEE=;
 b=qmI8CY5Owt5YNoTfnJltMfR+PKZGAHYDUrt8tdTQY3GN5QwPQreVmRwp6bin2XrEGZ6UP+OAoJsaDJmXWK6V04dJZCaQaSxkrhyeLN9qZAgDAR7DqoM8oHw1fLE0dYgE1lwc7uRsEsrSdjBSkZO+JKJ4m6pqyE6svFRKJVIY+vRNATC6lLNotr+f3fDNGt84tHDVJpVg/oFBifxudnbfOc2pSarwBWWc/i3LvxsORf3n4ke/6RjMRoe5LFun9qYZFY+d+K2w+P9BNj79se8JDAv4WAm5+6MUm5PH8ILBNBnBUlmfu1ivx5/WAX6edA4y+iep9WvkNGgBD+FoS3K8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+ZrHAmpTlpNIUvr6/0L0IR7xLLuYo5wRegG/X7xJEE=;
 b=RsV0OIZdp//sPkLOSjB2w+5KMpHk/H562CAUEQB8Dv8vljMT0UBIWkI40+YfleSfgcWfGDPf9WUMPCSpoySETcjIJZozRCHn7pIWId5OteHc3kySRl3NaCjJv4F5qMxwTXjw0f8FI5oL9vvEH7xeP/UN1M0NnBKW93stez//jnQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9178.namprd04.prod.outlook.com (2603:10b6:610:22f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 15:10:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:10:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use clear_and_wake_up_bit() where open coded
Thread-Topic: [PATCH] btrfs: use clear_and_wake_up_bit() where open coded
Thread-Index: AQHb8Bh9/NVRydz3h0e+surLc2QjYrQoVLCA
Date: Tue, 8 Jul 2025 15:10:30 +0000
Message-ID: <3bb63b01-ea20-46bd-8d1f-4e2165cfaed0@wdc.com>
References: <20250708145613.20769-1-dsterba@suse.com>
In-Reply-To: <20250708145613.20769-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9178:EE_
x-ms-office365-filtering-correlation-id: 428f57c4-b1b1-4192-bb09-08ddbe3193ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXBiRkN3REtzUTA0Nk8vRkhPSmZqRUlrOXNKOEc1azNoMEhLUFRNZW5zY0VM?=
 =?utf-8?B?bE5PVjNjeGhXTWFCR2RDWk9iOEVyMTZaSklqUXhFcm4wT1NZK2l6MDQyZjVs?=
 =?utf-8?B?TWNkUndhRnRjakJoaWZUN1B1MlNrTFFBM2hpd0poVVBWOUN3d09rRi9aUzBt?=
 =?utf-8?B?ZVAzM1AxdkRHK1c4WkQremRuemlXL2hwTlB4eWExeGkxMU5pdkNpUWY2Tk9n?=
 =?utf-8?B?d3dJS1JYTjB1T1o5S1lwOTdtd0Z2L1JwU1FielhZZktlOEFhRVFtMTdXcHVK?=
 =?utf-8?B?RGFQYndkUUxFQzFWRWpzNXc1b3JHUW5jWWN2N2FMNnVZQVA0K0FrbG1mZnV4?=
 =?utf-8?B?T01vcTNwMVBrUzFRVHRCd2tpQ3BWQUhVRXVCblY0dTdSclNIaTZZR0dydmx1?=
 =?utf-8?B?TmlZN2tZck13ejQ2cHAwb3JMbW9NRFF5SzZLeGxnQnhBdFpLeUhsOThqeUxY?=
 =?utf-8?B?d2RlUFMwdGdtZG8vZjlGNy9oV0VqY1U4R1VmcWxRTkc5a3RQcU1wK3NLUk5Q?=
 =?utf-8?B?Z0UxTHpTdG9hZUJTK291Y0x1blAvWitCaXpJdmcrL3ZFZmE0engrNEtVTExU?=
 =?utf-8?B?NWZqbldYUnVCeERKYmVjK0NnSWZPSWxYdi9HL0ZUN2x3QzFlaVZTRFA5TFMw?=
 =?utf-8?B?UTI1eXFMZ1dIbE54SFgrcFZNRlF6azUyN3VralNGMTlETWs2VjZVRDU2Mm42?=
 =?utf-8?B?RFJXd2NTdGRCZ1NncTUzN3dRR3gzWCtVQ2lCNWdLemFJRmMwcVBFcWdGSzJY?=
 =?utf-8?B?WHhTRTJFTThCRDVlcWRKOHNtdDI2djl6OFFKbUFZMVFoODhvNDFDalozMDRX?=
 =?utf-8?B?RGtORXVtdmRjWlIyYm9ZaU5YNDM3VjFRUDdGZkxya3Jicm82VEgzdFNxVGF6?=
 =?utf-8?B?dndwazh2a0lNcFRWbWJlZ0xsTERYcEswWTVubHZtNi9uUDYzRkFlUjN5OURx?=
 =?utf-8?B?emh3QXlXenF0WDV1V2x0VHB2aHlOSjlxRzJyb3h1a3RqczdiTHl4d3hvdXRv?=
 =?utf-8?B?dTZMWGxWUm5EN1Y0N3BmdzZwc1RVSUdTekhPRTFFTzRuVjZRUmNXaEpTZUEr?=
 =?utf-8?B?cGw5enI4d2pRa3JkOXhUemVjc0I2M1BKenJhUlpLbERTV1ZtMnB2MDNnQTk0?=
 =?utf-8?B?QjFGQi9IUUlxVzZSV2FRU0tSblFBUjBsd2lwcnpIU1Zob09mdWFjOEM1QTM5?=
 =?utf-8?B?YmZ5bG5iUXRuQ0VaN1pZMDNWUEZIYUFhdTB1bWpTUnNLcE1KL2duRFNUa3E5?=
 =?utf-8?B?YkRJeEVVVTZ3RngreUJzbEMzei91VklXdVdoKy9TQ1dTekpwL3BOV1VCbnJu?=
 =?utf-8?B?UER1TUNzUXdVWkVQYm1XWnFJU3NRZW9OUGlPSGhncGxpVk1leVlJdERQQTdo?=
 =?utf-8?B?Qld6WkxwM2ViaWZUaU45NU5mTGtQaml6MDBVM2dlZlVJOHJSbSs0SmdrNG1y?=
 =?utf-8?B?QjNiRTh2ajJPY3FkT1NQNThIb1pFZkZ4ZlFSeEN0ZE1YbHNpV0s2YUhEaTVP?=
 =?utf-8?B?UEkvei9OSDMzcWVPOVJTeU8zM0hDcVZvMmIyaHorQUphZWdUTG1JT2ZocFFX?=
 =?utf-8?B?UlpyRnZSOWZjY2EzMzlnNEVSSDRHZ1dtRVhYN2dkaUQwRjZFOHRvbjl6K0x4?=
 =?utf-8?B?QmhwWkJZdW1Oc21JSHJiMk5BdzI3NmE2ZnV2eHlnZmZXbGxCMGdja1VnT1Vj?=
 =?utf-8?B?QURTUWtHYjhNSUM2TEN5eDg5ajNvWlk4aUxkTGV5WExBRFhFaXY4WHBxdGM3?=
 =?utf-8?B?TGU2UXpZZVRaaGd0WFNJejVnMzNJMlFlUWJnRDN2RDd0NXROQ0xmRzFsSDBW?=
 =?utf-8?B?OXY4aUxXd09zK0dzeWRjcDErM25JNk93cmI5SjdwNkVweFVVdklIVndhaWtT?=
 =?utf-8?B?THVYUCszNTBwNi9YNE1PaXRoUjBCTTREalBpcUVrSTFBODl1dmRMV2JmN0xt?=
 =?utf-8?B?RUdRUGlHTHhxY0JMdGFkZVRsSWRrOGs4d1c3Qlh0Umg1YUx0MkFrNi9WOHRh?=
 =?utf-8?B?bmVvM3Z1SDFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDJYU2ZuWnZDSzVvVW1FcXN5Slh3c2RvRkJ1VDEyV1p2TXhCK1hlWFdFN3R2?=
 =?utf-8?B?NFdoTWZtaXZJM1BnOVRyOHZ4Z0cxcFlzZzkzWVROQndHV25sZ2piL0ZUekhl?=
 =?utf-8?B?aUhBbi9qS3pFVnQyS3MxekNoeFNtUlY4RGxrVVJCVzROWHlBV1dDQUhPUU5F?=
 =?utf-8?B?eGRHSWtqSFZ4cnErN0xBakRuN2lFZ1NqQnBNbWxEdm5RN2xwd0FOaTlWOGtN?=
 =?utf-8?B?WnM5N1RiVGVrN3l2WlBQQ2F3RlRaTThlcTFEemhVci92VUdjVnlEa0NrRnR1?=
 =?utf-8?B?cWxTblFzZlc4VzVPTnVjSjFaOTdMTVFQNVlHN3Z1RWlOQ2dRbXVCZDlEb0x4?=
 =?utf-8?B?UGpJUkJNSmNDeC8yUlNUejEzS2pBWS82ZEtVa2JQNTRaOW15UzJhN042b3hP?=
 =?utf-8?B?YUF1aGh3OHQ1bkdOanMxaWlPMkhmd2c1aDl4T0ZkMU8zQm0xWGVTYXJ3QVJF?=
 =?utf-8?B?K2lhYVkxMVRCakhrb1Q2K1V2VlQ5OFZTWjl6WE9MSjRLVUlCUGJhWGYybGR5?=
 =?utf-8?B?em9GQmh4YlpIWE5zU1RrM0ZzTFo0eElQbSs0Y2UrRXk0SnozL1kzY0FveEUw?=
 =?utf-8?B?N0V1a0VOUW1xZmZKOFVhdWVVTzVRNXAwcHlDSi8yWUhRaVV2akhBaTVNSlBX?=
 =?utf-8?B?ZERKdTlDZzZhamJ5RlJmQld5R2Vaei8yNDc0Z3ZaV3cvclo2NGtjUUxpTmV4?=
 =?utf-8?B?MVNkMUNOUTh0U2ovQkgrVyt2eFVxUnhmUnJQbzh0WTFXcUpsamc4UTlCdzE2?=
 =?utf-8?B?bEd5U3U3V1QwTThIMGJuQ0RQYmxrS3NQaFJvRHVHMlBENlhKWjhyb0RGSGE0?=
 =?utf-8?B?QkoraTgrZXROb05TczA5eGhTVVh5RTJZNk5LZ25nT3VMSDNoWG9Hc1dlam5j?=
 =?utf-8?B?UzdyQktJMW9peWhmNldpUEhmc242WWNVM09tVG1KZnlTZENhdGJiQU05RkFp?=
 =?utf-8?B?eTZWS25teWlTb20rQzB1cUJBRFRFcTNVSDVFUThHSWN6SGpxOVU3TDdzaEY0?=
 =?utf-8?B?VlphUllrZWFVMzhhdWhkRVM0SjM1MWMrN0dtYnkvY1FpTWczV0FtSXRWMFRy?=
 =?utf-8?B?bDh2clJoeThTQ2pIVEkxWmliUlNlbjVWekloc29DMjV2ekw5YzJKSjZQTVRu?=
 =?utf-8?B?azUzR1poRVBMb1lGRE42bTIwUWZmMEtEOUIyOS93Q2JuaFZ0TWlBaW5wLzBG?=
 =?utf-8?B?dkZOazM2UHBuNFZtbmlzaU1tYVRqMk45bEFrNWZ1N1VjMzhYUk1INUJxeDNv?=
 =?utf-8?B?c2N2TEV2Zk9GNndmVmtSU0d5WTFONCtGVGpQUS9xdUtRYkpnb3hVM084ZmJU?=
 =?utf-8?B?TUJweklKRkJVaG9FYStyRmkzTStuR3BvZFBKbTJZcVdjaHF3TlR0VmV4a3FY?=
 =?utf-8?B?SjJDbHlpZ0dmdVA1b3FoMlB4OGx5VWpwdzRmMThpS3hDOG1taWdTbzVPWXRT?=
 =?utf-8?B?M0pBa0JLSS8xREVTTk1mWW1jOXFHQ2YvTXRDVEt1QmIzV3ZqQVBTRzA0aE13?=
 =?utf-8?B?a21ETGw4RkVLOHhIWVBwSStKV1BDdjF0aGVUdEZBUlNNWkhqYmk4ZFV5SWNh?=
 =?utf-8?B?WUZ2WlJQVG9QVVVUSitXVjBhL1N3Mlo1NFlPU2VQU09EWDMwZDV3eVc0WEN2?=
 =?utf-8?B?bkprVWxsNCtSS001Z016VXpVWWxEK2l6TDdYR2xOZTZLQlJ2clRwMnk2MkFJ?=
 =?utf-8?B?VDlySFgzMGQyNTZtZHFMQnNYZWRLT1gxd3hsWGZBRjA0cG9KbWIyRGtoeExQ?=
 =?utf-8?B?dlREYlRVV1VyMWxhaWF3WG9CVGRLVm9RVmtvTnRHb3ZGVW1RMllseWlMU3Uv?=
 =?utf-8?B?NGNvMDlzbDVhUGN5dVpRU3g0WFVaQmxRVXQ1MjdCNDdmRjlkVXdoZklLTEJ0?=
 =?utf-8?B?dEFHclY5SHNMdlpBOWNFNUtmdDNxa1RQekZGZ2RnYytoV0pjeVRkc1FGQWVX?=
 =?utf-8?B?QTk5SFJ1SG4wbkV4OTlKeTdJc0I2b0x2WEhTL2gzbVNVR08wbmNJTEZ3cDVO?=
 =?utf-8?B?a2tXMEc4YWZIUWdMMlVPaWsxY2VIOTFXU2dxcEZGWnplOFBGMEU1WFhkWHRE?=
 =?utf-8?B?ekM2ejhjM0pBeG5sY3RjSzEybjlMUElzQVBiVFNqN0FodzlSTzNyNVhkUWt0?=
 =?utf-8?B?N0RrS3VCQ1hRRTd3VXRjSDBmSmt0ZGIzSnlXdWRsbzBoTjFBZjU0dE5qWnRQ?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B559EEDA511B34E8511614FD69E06B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yk7hB3I0Zw35aXc5tp/u5z0tBuUmJFjRC64BUXBO3CrHP8PvN5kU6kk9POXkOoU+Ns2L5n4aCVdT7obbYLVk0vEUL6ugmlonyoK0b4//oAvZZvT6BaRTZTN1CAMvlhV2nxZdRZfFtyq1ufobQH2k7XcBnZezYuGlgsNA0W+l3Cujp/lyrFkNddpK0GJvmlXUNN23L9sLlzK69fYePnmbFb+0hf2po9E6tQRK/um5PbBpBxQUlFfm7FGa5pLYyLoXirJPOdMmAwFp8gSJhLIDbFKgZt68nxyqyn0syS448TVCq2CvXHLissRHYx0iZM8dqNVqNv9sInL+H/5SyTiox4+x6KXMOx+5WfhCEIaRYYmxDg+iuNFCAgRLQK5z/Wf1JaEA3FfqdDc0xYu43iV6eW68xzBepQcfO/0QEMxzwwYRyV3A30oE3DjuIH1mp/kpMn3ZmbS1QDfvmnhXBJwL9z6BrQw7q5uWGJkfEbpJag/V6YHKjduEU04urzM7fn8SVkIkB9WgDxhf8V5xBKmCt11rX8Dwd1SsOtsZMnaJqH/jjdrcBAdPaMaZZWNkcWmBumwVozQy2KQQ/qXvxr9Q+vz4d09cvRdPltR8Qr3Dgh11N0bz1oCcz3xPcUTwNJxn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428f57c4-b1b1-4192-bb09-08ddbe3193ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 15:10:30.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2te8pazgKmvbuXPZeW/pqraJ1XhyMDfXMLxl1Lmg+jaEQfOXM0AceOC2ixZmkCZoGb7VKDQkULUyctrgciUKz0D9L3ZSiwDPTuKmaQKXnfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9178

QSBxdWljayBncmVwIHNob3dlZCBubyBtb3JlIHB1cmUgd2FrZV91cF9iaXQoKSBjYWxscyBqdXN0
IA0KY2xlYXJfYW5kX3dha2VfdXBfYml0KCkgaW4gYnRyZnMuDQoNCkxvb2tzIGdvb2QsDQpSZXZp
ZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4N
Cg==

