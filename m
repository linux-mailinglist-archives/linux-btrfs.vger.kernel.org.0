Return-Path: <linux-btrfs+bounces-15087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A13AED480
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 08:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4057A1894AEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75D1F463E;
	Mon, 30 Jun 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U/h0m/vA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L+g/NjVL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECD1F3FE2
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264810; cv=fail; b=qyiA7xkvtQsCL4g056mGi0xC0zaVolZPDY49vJmwIzNYGNcx68tpjUjNeGdwAp/vt97IjzbuQy86p68GXpqU9CpkRLAEJxaDg8bo8AZs6w9lX2y9VGsVDkl+2rGqAvFd3rYWS7J1o4hR1AW38nhncMZ1ntJvxAHr+eJTCB9yio4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264810; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N3o8U5hiopUkLvKA/6NMx0qT8/Q7tk4OQuBP+XRe068rZ0tsX6Rqz3j1TSZPSLdnZ4J6cQwpDA39BoKfx5ZVxVn9Q852gKKWJy6gZc0YeEr0aYDWRpJjMI1zRek+pmLu8VXdNhlZvpmUF708zTXyRykGGNC6l0GxlSmSwY8whgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U/h0m/vA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=L+g/NjVL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751264809; x=1782800809;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=U/h0m/vA1imaabM18O0zGiYX0VrFMhAArAML9f+dpl2+F4YmZs5vanqp
   C9bETdD2PoRKSjYkW+w/MJD52XLGXAhb2d0gBzLQAoHdmmLuHbj/zGh4m
   uWuuqmik+wRHW+WRcN7ifsZm8uv9yOGC6VwWe1PzSN3y2oc/BfwUSa2oG
   S2XrxA6mtejeZUu/IOdokqcXX/N4ZKlgJhzmby11UL+3TDxPgmToMO4Ow
   sldlSWleTsPkZ0uSdpMTwV3Oa7vlG1Hqpies5lIRJk0P4R8jCW9quQt3T
   +kurUPqdWDjbpW0uDcahKPkB2Z2tz0cX8vqLs/VriRnlGD7S9g2BQbPst
   Q==;
X-CSE-ConnectionGUID: 3qhaOaN0QImsmIvGU+AB+g==
X-CSE-MsgGUID: v2lWyLmQRgieFCBPG4w2bg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="86218835"
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.89])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 14:26:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRuv+vzXRf5PxmuDWtlaYjDQ6sKEctUIn3f2l/t/jozJ4UkTBcq8gjRjFgtA0XHNR7/ajQQHJ++mCTtVrW2oJtYxu359TPybM7U6nzOeJ2JDqcyLOe/0wZOztp+3EucUFdQjex2c/RXOyrLNe6DA94+P5sJ9LaTzZ6naQOZlpfBzqLbbDCex4Umtr9UZaThwmzTd9UlneBwfrZNGFo9eSwSwmFZD5ECs1VWoRvXlT7SkahjTZUcDPYao5LIgFu+3jAHlzmYglrqil15K5y1/KQM4WuGP+SROACoQieJdkKZhHbQ2sR61UT6CVRho5jNhNCODU1xYU8CY+/uFHXpzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YOwteoEoyLO/JY9SgVYu+zq0TSxed3ehKZyBt7MMFfp8lWuW+PLoVxlRMqS4/y5w2uVBQ28ywVg4MJ6aZKdR8oHdAbx6UL3ij5CRys3ZaUFarWw7IXYyEU0BxfPYBf3W2ZOqt6D41GJd6lCSvyTPPQZtUwBgMN1/4cP2zPEn7oULGVJKuhlGIwA7ICqLwihpc8Cr8OhpAV3lNbg12+an2LfDPw11BX1X7j7t+4v8hO+EQFIIyDpQhMVo1xu2k67coThrlGhf1y/HZ+O0tD4dOZ957VzAqKTlUNPZFjGLW9P1Xa/WGyyJDDXLC8b1xaOwv5MDhZ0VwnljRX1cBnWzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=L+g/NjVLcDbAVTCYrlwgo2d5C3/KYbFifv6HM0RNIT9L3sHaZMd2rdN89QVAqfWblmLqU73mWtUSf0d7gDch+CuMRjjzv/ZKYnHNFjts5hfUD68W4T2r7qEVD8lzZa5ZExbJvWYjqJOkjzXhRntoH0gP0D8bePiQKvrrkBGDj2I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8757.namprd04.prod.outlook.com (2603:10b6:510:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 06:26:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 06:26:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: remove btrfs_map_token structure
Thread-Topic: [PATCH] btrfs-progs: remove btrfs_map_token structure
Thread-Index: AQHb6KSa/z2WNo22HEWLSZdevJ3SNbQbPpuA
Date: Mon, 30 Jun 2025 06:26:44 +0000
Message-ID: <f8684adf-94e0-4fb9-9b1d-5c92822a96a5@wdc.com>
References:
 <15273755597bab9aaa50ff3bbfec37b3073c1d71.1751167109.git.wqu@suse.com>
In-Reply-To:
 <15273755597bab9aaa50ff3bbfec37b3073c1d71.1751167109.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8757:EE_
x-ms-office365-filtering-correlation-id: 0e6cab16-257c-417c-f4a0-08ddb79f1589
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WEhwYVZpUC84eXZwOXlUOE1LdFFDdnNKaS9JS1hJalEzL3NwNldaUFVRVE5X?=
 =?utf-8?B?M2N4TmptWUhTRFM5TVlBNTRUcS84NDVtYmhOVHBDSmNLdFJyZ0hDa0JnMVBX?=
 =?utf-8?B?RTFVdWVXNFpDbTVoSDdEWHlhYmJ5OVRwUWpLSEpsdU1BU3FYcDRoWTc2QzVx?=
 =?utf-8?B?OVNNZzhXaDJZYVBCdXdpaGx1WGorUThxRTVZVC9DMk1EbUxzaUxrb2tJNDhP?=
 =?utf-8?B?andwYVlWamcxZ05lNVVFeXd6WkxkMGhOTENnTGRMZ3pDa01LcEpIZGpkcTJB?=
 =?utf-8?B?UENrRW4yODFQR1RMUnU1MzFNbUtVcTVJdHlXL1V6S09KZ3lFZGJKS2IzdGVv?=
 =?utf-8?B?M0RIK3NIYWtVdUYrNDEvTXAxVmVWRWtSMmhmQnE0Y2tmSTBZcTBZYnpSMVcr?=
 =?utf-8?B?NkhkeUhCM29jN1RkYmFJMC9Xam5UcTFZWUpUYURFbFV5WlFSZ0FGMnFVdVVK?=
 =?utf-8?B?VzdiYlFoSFJWUmJGeUtZa3ZrdVNJRjBwZTZNRDVLeWV6YWh4eDkvek1Zc1NF?=
 =?utf-8?B?OW1CbEg0V0FpVXQrTFBObWhSL3FCY0lXd1ZXRGtQeGVIK0xCeFhCc2lGd0JN?=
 =?utf-8?B?VWZtcnNtWGh1MnJ2RlgyS3RUYWNRaXhraFVyM0RkOGo1Y3d6VTk5d2xzT2pR?=
 =?utf-8?B?ZmZ2TmVJZTNTVG5ySEtoVThFN01UZjhEZXEzdy9Obmtrd1VHY3A5Tk85ZTZn?=
 =?utf-8?B?UEZFSWpsS3BjeEJ6SFBYYUpEbzJLY0xPNDZyL2RiTTJJT3JwaVFKMmNCWTdl?=
 =?utf-8?B?OEhPOTlTNU5yczBqTUhkeVE5bm8xVmhiZEdlRCtTNzV3U3hrKzBSYkVObHpw?=
 =?utf-8?B?UldPVkJwQjFjK2pUb3dyVmZkYnJpSEtTejQ1TkcyeSt3cEVtSGZua2hPZHht?=
 =?utf-8?B?b1l4Z2VpeFdkaUxIU1V4alVnS3lqUXlYYnpaelpwMTdBZEhlL1ZKZ05hM3hS?=
 =?utf-8?B?RFc2d09zcFBqb0NpMHRCMlBQdS9YMnVVSkRNOXBxMGFoZEZmUjB1UlpzcENH?=
 =?utf-8?B?bEZIMndFcGFVaWppOXA5UGo2N3pUYzV1Q05ldTBOSkVCQXRrSXNzL0VEaEk3?=
 =?utf-8?B?dlZuY3hOUVJYYk1jT0IrbzBDNzErWVNtZldtdXpDdTNFaHNhbGJYSzV1amlE?=
 =?utf-8?B?THlNZ2FhR3pUQnJLUUhaVnhvUytLekxmTXlHQjBXMU1LRlNBWDFmcVFHYXlP?=
 =?utf-8?B?NG8rQUhpa0YzbEJZRklTd2x6V2JId2d4WlJjd1UwK0dJS2kxQXkvR1V3SzYx?=
 =?utf-8?B?THl3SDhCa1BMRVpTblcrR2FLandLc3Y4V1paOHBDMnB1amRvZmhpcFd5SEZj?=
 =?utf-8?B?R1VaaUZCUWtNRjVXRVk4ZlpHZENXZTNQL1JrcDM3dldQVUliQUVXUC83dzUr?=
 =?utf-8?B?emN4d2k4dmJVTHozSldNR3F1azBIcmxlc2UrdWUzdmVFSG1aMFVBT3ZGNndG?=
 =?utf-8?B?Z0xjRGdlanVmeUdGWUdvd1hTbVVJcTlxVWRhd3VVUDNoODZWeGR5WGQ4Skli?=
 =?utf-8?B?NElFWnRENU83cW01SU9XUzFIZ1E5T0VtaXovV1kvU1kvc3A0MHdtZzZtQ2kv?=
 =?utf-8?B?bmRmT1R0M0x4K3o5ek0vTW1zbE9KVXNVOENPZ1IxTjg2SlpTeVp3R3FxNk1K?=
 =?utf-8?B?WkFrTXZPeFpRbVowR09QQlNWQ2NzTlV3OTFiaTlsREZLb0tGblk4MHl1VXQ4?=
 =?utf-8?B?NU44RU8yNWx0M3MrKzBNV1ZxMTNNOXJXOFlScDZnNkhCMzNWcGpqUDZtc1Mr?=
 =?utf-8?B?OGNMMEM3Z1VNN3RUekt1cjl5blNCWlNpQTg4dUZ4Zm1XT3QvZTJYc3VjUDFl?=
 =?utf-8?B?Z0x6bmEyUldIdk81Njd2MTY3WjFDYXdqQzJrK1A4TnpYOEY2S3ltNDkvdnZI?=
 =?utf-8?B?WHZwWGpkQ2sxT2l6dkkweDVBNU92TFo0ek5OU3hvWmpBdVNMeVZaa1JsSHZ4?=
 =?utf-8?B?SHlEYUpkRG54bldBMXVsTFgvOS9seGtlTGNTSWxZeGg3MDd1R09KUUpRRkxm?=
 =?utf-8?B?YjREcERqaWJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0Z5TlJ6NmV2ZUpCVk9GbTAyL0dZSG9VbEV3YVdGZnNaN1cxNitoTDFQTHMx?=
 =?utf-8?B?NWIxTWQzNnFRVXBzL3B3ZmRwK2xGWDZ1TEJsTmU1WG5XOTg4MGE5WE5vMTUw?=
 =?utf-8?B?VkFVWHZMZXE1MDVGK1RkQUprN3gyanlnSUN3MTl2d3hlY0ZBTGY1eTR1aGZx?=
 =?utf-8?B?QmVGdUZDdXdNNU9tZ2k0VGVMVWphOVhnNElISEtSVGFxZEIrRzJqQmZieFho?=
 =?utf-8?B?cXFLdHhxeXEwcVNOU2piekZMTnc5NWE2cFZqS1VlbElwTmxkcW9GNXhRWnda?=
 =?utf-8?B?V1ZTd1ZhUnJrWnQ1VVIzbGQyVm54QkNYbDlIc0JQbWlqL3NoMml4SGZDOXU5?=
 =?utf-8?B?aWxnN1BsT09IbXE4SVJuZ201aGVjNXpvSDJVaHRPWHY2c3EyUEZ0U3o3Z1Y2?=
 =?utf-8?B?YTFyM2p0RFFxTDZKZXFsWmltWm5jbU9tV0EwSWNIV05aKzkwUUFKOG40N2RD?=
 =?utf-8?B?QXRibHMzeXJrWVd6ZzJkT1cxQk5iUmc4QWtUNlJWU0tMYTVsb3BJT0wrNlJU?=
 =?utf-8?B?Q2F0eGZsUzZUc2dUQWszSWt6RkswRzV4K1Z1SWRFTSthKzBPcmpGbGxmTWdw?=
 =?utf-8?B?Z2xORFkvWExpWUI1RXZWTE1iMDFUUE4reGFaYjlIZVUzL2NqMEdaMVdyUHdH?=
 =?utf-8?B?YWRubWVNUUJuS2FBaW9DYXI5a3hwWEhla242ZjRLV2ZYRjhFTzZtSmRwU0dv?=
 =?utf-8?B?RTZHTmQ5TnI5MGFGL1VPNTVqdFZiYmM1UGJPR0tHb3VEaUthTXFmeWl5ZFVt?=
 =?utf-8?B?YThrcXNrSzR5UmNDNnplUTczcEZybGlBWGozdlBXdHFKbGVJaGlLNk9ZUWcv?=
 =?utf-8?B?RmtGVzZXVFlZRmZqd1RiYlhGQ21HWEJmODEyU1lPYjVEZVFlckloejA4WDBp?=
 =?utf-8?B?MGZXV2xzalNsaDRldHhGaFExT1BJRDQ2ekd0Y0UrUVFqbkdOTkdOWmFDcEwz?=
 =?utf-8?B?OFYwZGNNdWNyR1JIVjZsNmVlelphUWs3L2xkbGsyODFTMFAvQ2FkWHpVTG5M?=
 =?utf-8?B?c1d6dml6d0docEJxRmlmNCtYYlFFUXZndDUwUTgyQnRZV2oyWERVeGxjZUFh?=
 =?utf-8?B?U1VyWEU2WmIwVk5MaGk0RTJlVEVmdUZLNGgxeVBLYmxoZzgremNiU2R5M1dL?=
 =?utf-8?B?NVlEbFBHdmZHMDhNcFlYdHpVRFhCcU9Ia0haYUJGejR1MWZadlUwTEtyUVZj?=
 =?utf-8?B?VFVIZ3IzNUtSYWdJNEZaSWh4M214TzVacS9Raklzc3dNVHRBT2t4dFAyZ0pZ?=
 =?utf-8?B?d3JxeVFFd1NpclUwUGxvdktESkp3N2VVUjV0a0hTMk1POUxBUkFYMlNiZ1R5?=
 =?utf-8?B?OFZleXpqekM5eWhzS3JHN0RlendBcWdNTTk1b0FHekl4SHVYZ1VVWjdDUzFp?=
 =?utf-8?B?dlZvRjBtSzJHMHJlUHlMQ3RwdGZDNDQvN05GdXVCOXcxbWI2NEVPQ1d4bVBI?=
 =?utf-8?B?eUpqZWZVNXRoMjdWVXllRUVmcmFzdTVzOFRydEtvSjBZNU1KcVUzRVRKMy9C?=
 =?utf-8?B?WlJxL29RanRKUG5wL0ozVDJEcndVZ3JJalFXd3Q3WVZ2MFB1aUM1VkY5SWcw?=
 =?utf-8?B?UUw5NlQyZlh6c0JvbzNSd0s5dm10RlkzOWdBbmtHNk1KZ05YVUdOVlRDYjFG?=
 =?utf-8?B?OVozdngwVFFtMFRPZCt3U2FicXQwZmtiZEJNaGtVZ01EenA1Mlk5QzAxWHZ2?=
 =?utf-8?B?R1F2YTRDRGdSZHdLeVlrazMxRHVCSDVsQjd2VWZwTkhZZlczeXRzcTI2YUVI?=
 =?utf-8?B?SGJwcHVmN3kreHdWZmhMZ2oxQVVmeXdJYURHMEtXd0VtNXBrN1Q3VHdaVFN4?=
 =?utf-8?B?Z3B4Vmp1eURRZFI3Y1BRTkhnWFFMalp1WXJFd00rQ1lteXJncjA1Ni9walRP?=
 =?utf-8?B?SnBST0ZnSVJxWFNrUFM5WWovNDVCNWswc2JnMFFLWENsNXZJT1I1ZmRSOWln?=
 =?utf-8?B?S0dCMjlLZXVzQ0ZVcS9zeG9jK0o2Sjd4NHNYVnUyNmFjWXlqUmFTOUVtOFNa?=
 =?utf-8?B?QUREcFp0QmZBM3lPamxrNDhxYldFbHU5bDczMHk0bTBvczlmbzh2bDVnTG8v?=
 =?utf-8?B?TkhhTk04TXpScUR4Q1ZrQUV5dmNjNG1pTTJFRmhtVmNBY0hsZSt3bHNOUnYr?=
 =?utf-8?B?NXFCdXZLeEhwRkJIM2d4ZFR6cVZFd1oyZUZVOGV6SUlXODRHbkJlTmdZZnlQ?=
 =?utf-8?B?YUdlMEM3T2pRbjlKdENMWVhsT0htZmpjbE1RVGM0ZktJNkFPdENaK2ZHVFox?=
 =?utf-8?B?VmpKZ3dtVTAwaUZsUWl5eEc2ZHhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C9C79F612E1A48AF65A48F2D4E544C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XJEIBYpTxlAmsubfoTlDNGm0JM7t7AVWJDuOe9uNN2SEEHPNcjyFXukutWwWMSNj6uWcTkpJhYwejhFg1V1580jDpF/GSWiZA3GKtdLbMYHR5FBoYPeCi8H/53TtfCp/jIEBI+PcfuyuSZ5nU+MW5kfLLOQog1ZH5d7XTkJRXLLJktyE81rS0weGZMZgd5o+rN7kvb9tXv9YnQ5+hl1DXg7hxRDUwR2d6mX6xYSgxpIom+yuF4wWVggAU4gr+Mk7QC539DpU8DoQh2+2RJAa3clRCncF8HotAYMf9GE4SJKjI20q4emGQZubELdKFye69dSPF+kCMU30wtHpOm2sD/vfIg1/AOpr49iIIa4PWzTRKNQBEKpCp7uFVH+gb5yQpEh8hO2obWWWxustdaYKVJ8qqJBQPaeLgQodGc8aix549sV7Fr216InvoHmv86Ac48WZVuc5g/WsHt4EqgyWaoqJEoZp0O6ZxueWT/xyJoiOBfxZS1paRuPFmvC12g35npEDk7B6mxsBwBvH9FLisezWk8KQU49ce2TcStcHSRDI9yo08md5rvWouy6/o6fyTQMpDtjLOE325JSPnYCoe79EOXXjmfL9uDMSkbD3Kiq41q2ZNyNXM07t94CrHSlQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6cab16-257c-417c-f4a0-08ddb79f1589
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:26:44.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONo6pgjbEac/jkzMxGKFqMdhm39sSC8bjQddLpyx1a5/aitVAx/VKXO4JPYkByLZNThdeNfBKoc0m8rQUMSopurISazZ0B9g8R2GqcNm02c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8757

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

