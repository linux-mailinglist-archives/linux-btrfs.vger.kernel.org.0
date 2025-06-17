Return-Path: <linux-btrfs+bounces-14709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D08EADC2C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38503AFB40
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854A28BAAD;
	Tue, 17 Jun 2025 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EtNA5Ul9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vXpxw2Ej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B362F22
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143780; cv=fail; b=rwgodFe6qUbt6vEHcSgUHa91sReWHZ0xt53RO+cm23mN7nFV+xXgeCMMoiom8hFQEJG5IViMYs7soOjYWKUG3JpKZYFjwpLwvzJEUdbMb0FRQ7jCub9EQmZSmsn8TO9beXlXtYxEAZfiCNZklU39qu0d5LD7hwRuzgyPVTKViYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143780; c=relaxed/simple;
	bh=RiW+ztdO25YfhyBMZ9N8w5ZnG7IE7WWwl+KxXy7W228=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tf2W2A9BZcoA5Q33M39+7DbB45F7EjBKCN/etcgp2ArA88jiJQ5e+/n5YNZ3hy0wTKaBzFcEh0xXVreQGBJettCiYTdQz9moXnShC/c0WqmusqK5nQWoSsPDCyagVL+STbqwM8zkCEo0K2f4gOkoVatFFF6NMfxeI3kHddGEuRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EtNA5Ul9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vXpxw2Ej; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750143778; x=1781679778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RiW+ztdO25YfhyBMZ9N8w5ZnG7IE7WWwl+KxXy7W228=;
  b=EtNA5Ul9m8c3nhtHctgxKlP3L4qpQMVlszH1OPcd8ihSXoRPvk6w/zk6
   oMvEa5BBHm+j4ZT3OpXJQkxavk5dKYL6p62ci0flG05KGwpDVeg6GznW6
   gl+RLmNmYYk3eeujyEAdc/iZpByB+MyTXeBDbM6h+HNFK4nsY7cAW2ZKG
   hRmF5iDpxXFjnBbmwvsf8L2S8oO5ZtnjA3v13+1tkuFUQNn3M6lXVjQdc
   sOYxoEE7voiGqUPybyTXv6IXIyJqX5r8cNqdodsATU5Ee9vTAmn9Gk9cH
   U1maJq0DhhPoHOMROxBWPppFZMIP4bx7IBN2E1Kc/EJbfUswUxtUGEqyj
   A==;
X-CSE-ConnectionGUID: eZeYRxwsSmCxLyiDwpWoyQ==
X-CSE-MsgGUID: kz0L7nDIT3aeF5etjhaE6A==
X-IronPort-AV: E=Sophos;i="6.16,242,1744041600"; 
   d="scan'208";a="84185623"
Received: from mail-northcentralusazon11013034.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.34])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2025 15:01:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LumIsCiNNwQQvlPV+qMJWO4pWLB1uXV4trOoCNyIluRG+8F6/5NtcTRjqtwNnLtwQmOSjeQRrMwqHB6ScuRH0906/EavcUXgcJqXANUIYxaO6y5QOJnBAz7+8tsEkXhSq/ZRUyjxqd6TO52WzrGhVjLLTuglvgyAWXd5xMQpeYZ34MXv7gIODDYFPxGPG2nLsmHYNEtu0NWb8skK/Xz0Dw5XzftH8TYOw1YlXbd08G7WtuHtjxJTrRSJ9JzqfImS/0UcLEB/sV9AlYgG8PdVn8XZKz+29sGc/dbQQVO9dOwKkDzguEF7KOL6oI55NiwSSPVs+YubNjXnerLG6JJy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiW+ztdO25YfhyBMZ9N8w5ZnG7IE7WWwl+KxXy7W228=;
 b=r0eLjbtzyDi3FPazHGLbvtck/flTB6hID/SZ5xyB2Q4ihrQ5KO0QNtdRLIeqOzEjs8ACeFBRR4XK5uciosDsNoTwdRNhs9Ao6yXOUB8PH5+08hOM3fxUHUk7z9w92QsQSy27/gtYQ9r5LMKUTkHEeGsbyrn9a/PWtK6IDJnGXwo8SUyrUuwm67kM7Jb7qtGcXaiY/fRCWPvpOVRQ+SACuBQzt6WYeQNT3jEtU1diSTNZX5OonZHYPqB1Ayqx6OFYYsfB5pz8yuCaY9Fa2MgFCtca2LaDRumf8tQcLuy57Ws1qMKmEXWDb4t8gKKuZtXLKtmF0r/89jGvyJhcI+nteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiW+ztdO25YfhyBMZ9N8w5ZnG7IE7WWwl+KxXy7W228=;
 b=vXpxw2EjVKrt2IlzBIcU9BfLA+b0S4OrP701TC+0ZKL56l4wXwoU3zNO18U+O6AqFFRqG5v+AwiqNJuYGQhc58SnC6eBS+XnEaghEUaqPINWa1dot5saa7Lgm4Q2pwi/guW9WOMxlxdLdIOr325B+VHZbz6/PTvFsjrvtHXsHU0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8740.namprd04.prod.outlook.com (2603:10b6:806:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 07:01:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8857.016; Tue, 17 Jun 2025
 07:01:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: hch <hch@lst.de>
Subject: Re: [PATCH v3 3/6] btrfs: call btrfs_close_devices from ->kill_sb
Thread-Topic: [PATCH v3 3/6] btrfs: call btrfs_close_devices from ->kill_sb
Thread-Index: AQHb30eDz/XKvdJjTUK+SAfDib4ZPLQG7LcA
Date: Tue, 17 Jun 2025 07:01:25 +0000
Message-ID: <082a1df9-a6a3-4b2f-854e-99a6d6fde3b2@wdc.com>
References: <cover.1750137547.git.wqu@suse.com>
 <b9f99472e5388fdae1da21976a32ea720606ad73.1750137547.git.wqu@suse.com>
In-Reply-To:
 <b9f99472e5388fdae1da21976a32ea720606ad73.1750137547.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8740:EE_
x-ms-office365-filtering-correlation-id: 40d7fd42-f858-435c-04fb-08ddad6cc644
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnI0Vm5JRkllYy8vZHVSOThDemUreTJxTklNeWRueWpRRS9nY3A5aW4zTkFu?=
 =?utf-8?B?bWNiNmZmUnFORHdKQ0NBcUppSzRrTkc1akNmWGdFYjBIVHNCSlNPQkFTWWhT?=
 =?utf-8?B?MkdMengvZ0czemZlMkNNVy9MUUlsQWowRTlwNnpSUDdFYkdwQVNRRTQ1YVFL?=
 =?utf-8?B?QXBJRFN0VTUyVllKRjd5SVl6Z2JSbm9JWWYxYVNpSG1RUlFxMEtaS0R5cHhi?=
 =?utf-8?B?ZmpmUWN0YjMxd0U1b1YwZ1JJUGU3K2JNb3NwWk9uZU00MmNGSHJkMzJ4U0pu?=
 =?utf-8?B?WGRrdWFSMEZYVXpiR3Bja0VuRi8xWDFOdmZDTkdXcnNaQXFTaFRuVjNia3Zj?=
 =?utf-8?B?YzRqV3V5RnhqMjdPSS9oL2loN3JNZlJ4VG9YK002UzJIbG90dDdSZ0N6R0o1?=
 =?utf-8?B?SDhOMndYb291UGtaVXJkK0NYaXpvY1VlSmR2VDkzcWxsZUJneHQvaU11T2Rm?=
 =?utf-8?B?RnZCbkFLMzhuWGFhdzRpUkVyemNkeTlrQlhhd1gwaCtlbVFvY3ROcytzeWNm?=
 =?utf-8?B?aXJPVnIyRWtQV2wyTE5LdVFtRWQyN2J0SWxjSW5hSnRUcFcrK0ozaDg0Lzgr?=
 =?utf-8?B?WVdTNHZ2WVY2WVV6eUJxaXcxSnpEWnVWMWQ1NksyNThicW1WN1FCYTM2SmQ3?=
 =?utf-8?B?d3AyK1NWWnJlY1QvVWVVVXYrTzVsV0dkcm1GSW44dDB6dTNpOGFtdUdQS3d1?=
 =?utf-8?B?WGRBRThyckV1bDJJRGk3TmZrZ3lDVFN1ZlFnUEUrKzlVQ2ZFdGlsSE5MNHAv?=
 =?utf-8?B?bHRCYkFvcHZkanhUaGtvV2M5aDUwVWxVNWxRZUUxSDJQRUZ0R2d4bkJkcTVK?=
 =?utf-8?B?ZzRLQ3gzKzlxZ09ITy8vWElNcU4yWW8ycHlxaktjN2ZnVlJCeGlhTVNsVHps?=
 =?utf-8?B?WWltM1ZhQ1RMdDFlMXFpcnZubTFVd29RcGRFdTZoY0RpSGFZL2RxMkJLamFv?=
 =?utf-8?B?ZlFWYXFQdFN5S1pxNzJHSDhoY1kxSmQ3QlpwL21BZXBnV2FNeFBRWVY1N1dN?=
 =?utf-8?B?YWRzSFVGK00zR2c2bFdoa2crNkM4Rk1ZWTdOOUxZNGNRRXBXZXBrdHJDVVRj?=
 =?utf-8?B?QVZ0WWlySjJFZmZWaGtxenlnbUtGa1ZURUpmMFN5d29QRmpLM01YY25PSHZK?=
 =?utf-8?B?MlAzc1lZdVZjeklpbGo2bW1RN2R3Qmg5Sk5LZTl2dE5RbnVsbzRobmxwS21N?=
 =?utf-8?B?cVFIMFYwSkFKR09GZmtmNjJlSlpteDhnVmdVUzNTcVpKVUF6WlZGYzJucEli?=
 =?utf-8?B?VVNxYytKcTQxMmdPZmUrcDZYd2hWQVNsSE1jVVA0Zk8rSE13Y096WEczRFBJ?=
 =?utf-8?B?N2FrTktJOHFwN2JUL1k3K3BhY0FnN2haaysxVU05Y2NUK2cya1hOVjMwOStO?=
 =?utf-8?B?eFFOZ1VrSzY3OCtNQU9wclFERlkzN2luN0ZhVlBNQjcxbmJZMmJpQlJ5MkYv?=
 =?utf-8?B?ZlJiVzBCdnZoeTJNY1ByOVRwNkdqa05NKzFTVDdXR0wxQzdNeFhzdHBPK05k?=
 =?utf-8?B?WmhuU2REc1UrWUpjZFVjeUxodWFFYjVnY1FnU2R5NitHd25IbDFjTXZQb2VV?=
 =?utf-8?B?cm4wMXk4Wm5vVnVPNmZSVU1pQ1NTWm5qZ2hvNHZzYW4zUi9qekJySjZHNmc1?=
 =?utf-8?B?QUxsTlp2aFRYRXR3U2ZqMDlmOURET1ArczB5eWJVSGx3NFpUK2lVL1c3eVBW?=
 =?utf-8?B?UXo5aE5kdEgxM2lXQlpPSXpYTjRaTGJ5QldMb3NDYks5NDRDUEEyZE12Ulk0?=
 =?utf-8?B?RkFIYThtRFdBMFAxSmZTbkhaQ0JKeHVvc1krdEVYSjh5YWI4cGNKdWthTUhi?=
 =?utf-8?B?SGU1b09iMXFFeGY0ZHdScmVHOU5iOVlJcE81VDF6c1JKQmNjc2JJeHZ3dWlh?=
 =?utf-8?B?TzRiQ2wwSHJGVXBjTkcyNm9HZ2Z5OXJ3NDVqaUZVN3NzdDlRODVzMytnbDRI?=
 =?utf-8?B?OUdPSFQ3Zy92N3VlMEFxUG53ckoyaXJiUlI2Njg5c2NuL0I4ajhNUk9UOE9a?=
 =?utf-8?Q?NCbk628Z1zLFEU9SACrayiFhmkCMhw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnZWa3pramVQYnNCMnZBYzAwY2lObHNLOGxENlU1ZUNVdTlTNGNjb25acUh3?=
 =?utf-8?B?RXE2NnZZTmJnd3hzVWg0aVBpK0U3cEZPREM4amdUQWIvWEdWaHpVQ05Wdkhv?=
 =?utf-8?B?TXRFd2c2RHIrNnMyMmw0aGJZeWNmSm5IZzlzWVhpelVvYTZMQitiZnQ2cVph?=
 =?utf-8?B?NHNjVGdyMDNjSE1CMCtwbzVZREc3UlRwVWNjLzlLUmhrSUZnS2o2VGZFbllC?=
 =?utf-8?B?Y01iTTlhVlp4OEM5amdlQzVrRkZ2UmFCVDVFdk9BeFREODY2SFF2RWxITVVi?=
 =?utf-8?B?eFZCZ3lqUmU4RnhlQkkrZlpEaGlxdU1WbzQ3MkNTTmduS1VVNWE2YWMxODI5?=
 =?utf-8?B?emlyUzZaZ0FiSmN1UkV2dUlIaXVoUmlodm03WEdSZHAyeWlBQXpadXBPc2VY?=
 =?utf-8?B?ams1ejF0OGlUeVB5Rk5BazFqTzJjWSthQzRKOE5SejA5WktEQnFXdWVNTUhP?=
 =?utf-8?B?SEh3Q2VLK25wTk9VS0NodnNPUXBDUityYkRvMFdpUzRwbktYb2FidkpsVzVW?=
 =?utf-8?B?d0hvWWtxaTZTZDBsUWJtZk1xQmJEOERZbUtuOHJhemhrRUVkOHdOb3FydCtY?=
 =?utf-8?B?QktkajZuSGQwZjUzTGlHc1JzcXVOSFJHbFNyMGQ3YzAwWGhlYTZUaG1EeFFw?=
 =?utf-8?B?ZVRtSWV6amZoWU1oSjU1S2JUZ2Nrem5DeDliSWpGNnZpSFZBOUdLc2I2UEM1?=
 =?utf-8?B?bEtkbkRjNUFBeVp3MjJlTzV2L3ZHZ0N5UWR0c2hUS0ZaM3IzdXVUN2g2ZFNx?=
 =?utf-8?B?QW54Z2dMSTJoTXpERUQvb3NyWkNCdEp6WHl4Q3E1cDc0Snh2L3VnRmc0eHBQ?=
 =?utf-8?B?UjVVS2lqdlIraU54T3Z3YjlHYmdXZVZYWG44VUV5d3A1TDhsQ2tnZmFYOXpT?=
 =?utf-8?B?TEMrZ2t2S3V1WHNGYSthYzR5QkFoOHczblpxaXByeHdFeEkvY012bG1VR1Uw?=
 =?utf-8?B?dmZBVDhOY1VwZUFTQlZvM01QMm12S2NXaThqNEc0dmlkMTR2eDNyM245YlJQ?=
 =?utf-8?B?VDBzMFlydWFkZjdtUXpmZmM4K2svVGN3V1g1emV1RE80a1F4MWU2a1BVZGdp?=
 =?utf-8?B?WkhGK3UrQzJDWXljais5MjBHc3lNUFlsa0Mzb0ZTUFFOVFlrK0l2ZDlkN3Bh?=
 =?utf-8?B?MkV4TWJYOS9LL1VRb0h3eWRRR3hSTm1YL2pzNDR1OEZpamc1VlVIL1NDL25D?=
 =?utf-8?B?U0I1eFpCSFVmUUtXaWt1UVN3Slp1c0FYMUVlTk5ZY3hXbDY3WTVTN0JEdnNQ?=
 =?utf-8?B?c0xqRkkwUzRBeWhQTmgyWC90djB1Mmt1S3FmOUlOdmhIelA0TVhJdGVQNzZ5?=
 =?utf-8?B?Y3Fxa1VYaE9VZTRrY09mb3JOdVMyNkpCT1E0eXJoUXpjUFYvWUpkblFHY0gy?=
 =?utf-8?B?UEM3QVl3ZW1KSk03c0tzT0kxYTA0R1J3amxoL1FtMGQ4UlpmOHR0T0dRQnBq?=
 =?utf-8?B?ZmxEejFFeHFtbmpuOTVET25icTVySmpVd0RHZUJKZzZDM2IrUEpGWW5KTFc2?=
 =?utf-8?B?ZXlxWlhQT3VyZ1lsUTBnVkcwbzkyVHZkQWk3TkoyaFZVbVBjMmQ0OEpVQndS?=
 =?utf-8?B?N2tnQzgxbE5sR3FQRFd5WndEOUUveHU5bkd2TDJham5hY00xeTAwTkxyNXR5?=
 =?utf-8?B?RDNNZTlMK1p4MldoWnIxUVpsNlNKSG9uRjdNZUV2S05NUnRXK2RHL0E2TFdF?=
 =?utf-8?B?QUpjYWFrU3I1VFhBMzVuNWhXNHIzVFpuRzZObXdTZ3lROHJabjR0TGlkYnIy?=
 =?utf-8?B?MkVjeTQ3UWVOU2NNMExpNTZUWmhFSWVjR1BNVWFTTnRNdmRYT3pRcU9SOFBF?=
 =?utf-8?B?bFJxZmJRZkJhZG9lbXEwZnNtcWRhY09qT2toT3B5MGYzMC9pM0dIMVR4QUp0?=
 =?utf-8?B?ZVRWeEorU280SGw1dTZpSkJwVWcrcmc1cG5SaFZ5L1Y4d1IrTURDUUx1VVZp?=
 =?utf-8?B?OE9RNjVIRTk2Ky90UmEvRnYrY3Y4bWxOYmRGblh1SEUyT2hpVm9kcTFQR29I?=
 =?utf-8?B?RThobHhYQllWSUFrUS9NYjdJSHNNWGtDSUJEVEhzdnpDaDNPTERBekVlTzMz?=
 =?utf-8?B?Uk44RjJtWVpSc0VMWVp0L3hQSlVLMy9LUlNqY0hSMTd1QTVlRzdyMXNRZng4?=
 =?utf-8?B?SFdKTGxmNDBCa2JSeWlqb1pFemh1c2V3dnNMZjZMV2dqdWNUK2o5Rnk3d1Fl?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82341354A53E254E90FDE161229CAAC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3gks0ag9PSRqcm2a3GuF6aE3zS3sMyJrzRXNCP3hJ4hupeXkfCIVhOhe4oiOoE0gTIGhg3aA3Ckaib7hrEtd0pK6SzeH/W06r/QPTblMajCL2yT0WErDTMRtR7g+E/0pJ8CA5eQzom+Bp925+hXjz6lfdi8NQq9NFLs+0Z2QPcFcuWlYfF/BkxTG+YDmFFMnfQb2W7bFS+hzaCGdS2vBqkcJO4QpCw6DP5nZEDs/QW7sCwsM9Hcvg1HjU0ZLb0tYlXfRcQgV6jq8g/Aji92DUmN5Ep39YsOuVz09cU/nXGI5wdKIGuTKqXVX67T70AXJBD0D7Rm1UsGetLZl82IhAWeua0BW3XAhNion5qBr2mqLdUrlPFwx+ZtTe956Mpp+YxOS4HP6fcR9OHkYt6EyjBB39lxwtLGO6VE8fQnAKW2PfOg4YpWptRovo6TxiEGziXncU6MLwbAcDdIxEZvGZ0qJRiQzrc3B7s7wQvA0n+WeAWHlw6oFcQgzfpWoPN5HhpQc0LdCRQd4QWBpZsnFQ5TqrxL94LWrHReynTMUohRdpgK1jPxg4IZNRaZNjKK4B61zHuQMz4GYbKyrE4V6sYJiQj+32ESRLy4NMh0mBbl+0l8ve2k66L4lHOOYvRU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7fd42-f858-435c-04fb-08ddad6cc644
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 07:01:25.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuVRNi432UfAxSTiHWrXFAavDON6dPr+zSjDxDc3om6zzbSE2OuFZ4vnSSBAVIeXrHy+GibGPi9eSVDqGDdW7kfagt8qZWlFLKfkuaO3w/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8740

T24gMTcuMDYuMjUgMDc6MjAsIFF1IFdlbnJ1byB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1
bXNoaXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBRdSBX
ZW5ydW88d3F1QHN1c2UuY29tPg0KDQpJIHRoaW5rIHlvdSBjYW4gZHJvcCBteSBTLW8tYiBoZXJl
LCBhcyBJIG9ubHkgZGlkIHRoYXQgYmVjYXVzZSBJIHdhcyANCnJlLXNlbmRpbmcgdGhlc2UgcGF0
Y2hlcy4gTm93IHRoYXQgeW91J3JlIGNvbnRpbnVpbmcsIG15IFMtby1iIGRvZXNuJ3QgDQpyZWFs
bHkgYXBwbHkgYW55bW9yZS4NCg==

