Return-Path: <linux-btrfs+bounces-12369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191CA66F78
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66C5188A93B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5B206F17;
	Tue, 18 Mar 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mvz1gtKx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kLh3J7Gy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263512066D6;
	Tue, 18 Mar 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289268; cv=fail; b=lT4hWosfeM9Q1dZ7joIZCtklqe0GavukD02tXa7ks2Pyi4xjGi97vdtuJl5reVACV6Tvxr0nxk1n7yBpFMxHD5SmMJygHqa5ZVQ+rMQoM0MKLi7tb402bPQ5n6o8OzEct/Qb3Jaizlj0BBYqWnuNmgEK5bHR1Otd928G81CayXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289268; c=relaxed/simple;
	bh=pa3j02X4IBPAvYJ5L0tzeO607sypR0KK4OeIqFp+YN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhU0FBzcUvWAMGOVXBrvKZztcK6Q8D+vyrBBfHQXc/v8k8mU16hCBBEydtN4pttBsxgYNiIYT7KHEqJfEGBhOQuKrUKpQWiD6Lvvp5JTVXodCSkZPBoQXdju2XFAp5AxPmp+enFwXJmE1zPQHQndXxtz0eYU6UTbG1SqIZuPwWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mvz1gtKx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kLh3J7Gy; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742289263; x=1773825263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pa3j02X4IBPAvYJ5L0tzeO607sypR0KK4OeIqFp+YN0=;
  b=mvz1gtKxH0yXqRCwIHkKl2Nn3KEIvOHmCkPmLLOIVa3bXnJCIeMV3/2M
   WhuhJ9GRs2TKSXbDMB0Eu+ASWC7zE31Hsl7YrKx0jxNluGhFZR72TBEhM
   wOZs2uIB8Q9KYmaJqU22TmqA1UX7mPskt6Ic3GM9bnHAyMxhYSII1n39h
   EaR8h8e6vCs0K95nJ80CLrXzZ8/m5A6IF6bpDUhmFm4gyivdD0jogfKvz
   yorrPinbHYmtpT43TdyeHkxm9N334Bx1XERGUhFMVAompDWVP/a7uyIGQ
   LnVGcHiOSJsBi7LMcnzTszglzeka8PRFJqo1JzGdQ1bGd7GodEaBzHVuK
   g==;
X-CSE-ConnectionGUID: 5QG82+s7QQGPMRoZ2vXOrQ==
X-CSE-MsgGUID: gk0orG+6SO2YMzNaAKP38Q==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="54136573"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 17:14:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+VfPkZmEHVYIRK9/THpLpB0AtGWYHaHUpglJ+y3ipbVhBHnZz/A0IhJgydAkHOLbSpp7uD7I1+0Cq83OSh/2WpCW9ek+zDFAh9FlSk6tYcufacnYXqeT320yoeqz8CiotCBEqkyy1VShMIRT4e5u5p4ZdIrQ7RZ58Dxbe/7mLqraCkoJGypNTdXEof40onZN2a/v1T8eUWNAp+hXnn1VhltdApp1/EG++3FErkWCrRVCZipcjWrwfMVOY1y4OodmsiJb7KeIHRDhlkCxVuh/fRcinUdmAYCMZuikwonz5G+8ZhmXLH/CM0mOyT9+eqjoqu8L7fZo0//rN2o+hGj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3j02X4IBPAvYJ5L0tzeO607sypR0KK4OeIqFp+YN0=;
 b=lIouUfsMjyiLTfcMEiFcS9GUQoJSPaZfoqkLHlxlEqqIeHPIKDwrlpp2NbMPBM9rFb4Q7z1pOeIH8iNv+vJVZp4QnOcltmmJT9PGxjJo7QtGM5sFIrwH+61tgy9bNzHr7Lo71AKYtqbcOA7fZM0vRmpPAW+OkZhs9tLnaYn0bZnF7CH4w84pNS+uXdAMLWWgzuxtjZLpOrApQ98mqHnf/YmrLy6TUZh3v7NOmNgYfCi5fq12FsRciuY7YjsbngETj8akO+kskD7JCsx4cO58MBZDM5dZdOV9Wy0sg5jYjvajBnjhgiOI684iXiV7mOS2XIo+Jb9Bi7k7L+MWNdAs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3j02X4IBPAvYJ5L0tzeO607sypR0KK4OeIqFp+YN0=;
 b=kLh3J7Gy1x7ctZhoC/9ka5pEVvVMpMqn63WCN27lqsnkxrP/9AC4Y6NGp2kpD2Y9EvzQRza9OFBlVhTGpyuVrAu+KCEbN7njfnlRbZk2FxZ3Zm+WzO5A8nnDCL2nrKfcZE35kPwWcg209w8+aoke2D4UCVELMKZ/S82A5laPJEE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9415.namprd04.prod.outlook.com (2603:10b6:8:1f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:14:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 09:14:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Johannes Thumshirn <jth@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Zorro Lang
	<zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Topic: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
Thread-Index: AQHbl04BYPWchuIgeEmgsVMc9mwiQbN4kpqAgAAA0oCAAAioAIAAAZKA
Date: Tue, 18 Mar 2025 09:14:19 +0000
Message-ID: <20c9e5ac-8049-4520-8dbe-3519cd9492fe@wdc.com>
References:
 <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
 <a50388a1-3d10-484d-a5bf-762423d13ee4@oracle.com>
 <27697fa2-8a44-47d6-835e-eafa4bd8242f@wdc.com>
 <016ce442-fa58-4245-a6fa-58b8aae2ef2d@oracle.com>
In-Reply-To: <016ce442-fa58-4245-a6fa-58b8aae2ef2d@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9415:EE_
x-ms-office365-filtering-correlation-id: 772a93cd-eefe-458c-ba1d-08dd65fd43fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2VnbkJDK0s4bXF0TVA1UnBQRW1makxoVkUwSUMrRVFjT2pBUFRNUGZwaURi?=
 =?utf-8?B?eHViV1FTSXdlN3dIb2xzUUV4WEMxQ0E1bU1JZVNvK0puMDlWMFNHWmFudkg1?=
 =?utf-8?B?SDRsUzF5QnQvbG03dm9kZFRSaGVDUzY4d3h2bmtqMFRiOVNOVEh4eHUzWm5D?=
 =?utf-8?B?UkIwZVZvaU1STHhxNmYwVFIvSDhWaytJbDUvMDlVQ0N3VlhySzllcEhqcFA0?=
 =?utf-8?B?cjNzR0lvcmlSU09CZXpjcXg5Q0xWaytObnBOMnBXY3BNMGI4Q255M05FUk4y?=
 =?utf-8?B?UjExK2YwSkx6blVVTFByOVNsOGlqdENwL3p2MVVRZkxISGVjbW1YeWduTW9J?=
 =?utf-8?B?RS8rOUdJUmZUVmprSWtNMnoyZTcvMENXMUZVMkdrS2ZCSjRGZUY5YW0wOWNn?=
 =?utf-8?B?ZmY1QWRDWDUxZTNrN1N0RlNCS29tNUx2bldxN3ZVNGRzYzNsRWh2ZmVOaE0w?=
 =?utf-8?B?YVJ0V2xqUlVmcEpvMWFYT2Nvazc0SkJBYklieGlBK0pQOXFZOHpuUXpyMy83?=
 =?utf-8?B?YVN0a25lR3E1eFZCNjF2RlYweE16YXoyMkl3bjV5N080b3ZGR01LZER4KzJV?=
 =?utf-8?B?UGwwQTBEa3U4dzNKMGpQb1ZINmtxNWRUdGZlZkw0NmpLRm5yWG1acDNWVjkr?=
 =?utf-8?B?S2k0NWpoeXpNQTF6LzlZbERHN2dWNlFOSkhqWW0vbzU1Wm5tMTkyWGJ2Mi9J?=
 =?utf-8?B?TWtldXUwRUV5ZkVvazF1RTlzWmZ3OVpzOWhWbmIyZ0JzUmdTeXZLNEE0K0Nr?=
 =?utf-8?B?UDBsbklRZ2kvU0VlcUhpcEJDVEVlUXJjRlFhbWVGRzcxdjA3SldHcmkyUmk5?=
 =?utf-8?B?anAxcGh1WVp0MGRoeEtEcm05TCtmMWZEQisrbjYwK2psNUhsY3l5Q0JpRnEr?=
 =?utf-8?B?MVYxNUVuZ2tkNzFCZFNnL3hZWkE3OTlreFZ1NVhyWjc1T3lwclJsUkZoYXZE?=
 =?utf-8?B?YVlKaXdtQ2NPaUZKbnpDVm5lbjBPMHlXek9SYkJIODFpU3NoMWI5bkowOVBT?=
 =?utf-8?B?WDV2OGhzcnV4bUttbnJrdUh3R3VnaGQ2VndJQ0tzczRIckd0N0srT2lPbkx3?=
 =?utf-8?B?cEZwUFI4VU1TRXVGUGF3R0hQSXIvV3htUjJja0crcmk4eERZU0VXZFNHZlRh?=
 =?utf-8?B?b2tkdkgyNXR1ZjBhZlNWZkcwRjZTVDhSVGM4Z1pldzJYajlYdi9ET3l5MlZl?=
 =?utf-8?B?bGRGWVdVRlp0NU5oQUoxUmsyU0d4UkMrQ2pDWjE3eGZuM0pnQXlEckVBZm81?=
 =?utf-8?B?Vlo4SWozQkcwZVkzVHFsZ244ajZ3VzZBWEQ3R0trbTNZQXVJRmkwaEFxYU9h?=
 =?utf-8?B?VE02QWJKSkYyaDRkd0hLWWJJUGliQ0JGZEtnMmtRbUhXNGZTNDNCRUlNMnFw?=
 =?utf-8?B?M1F2WDlCR1VDMUdxcjVOMXJNbUpkWFBDTmt6QU5rbFpRWENXRGZIVURaLzlE?=
 =?utf-8?B?bEZxY3pDUlNaOEllNFlRd2Yxc0hPK1FuTXY1WElMdWFlYVYyZ3BsekpaaklX?=
 =?utf-8?B?Tm1kYjlwQU5QT09uZm9EcGZnMXR2ZHNuQmVjZzF6Y2t2U0VsVkVwc0JJdzBk?=
 =?utf-8?B?REppWGQzYkQzWjBVdHdpRU1SSlFzRkFpU09xU2FzYVBHK3RmWFFIQTVKMG12?=
 =?utf-8?B?cDI1aS9tUjBNbHgyZ1dVNnJCSTREamt6Z2VMSGZ2amRSVXNxK0tWN21udTZO?=
 =?utf-8?B?T2VIT3RyQTNOb3UyVGdnSlpoc3NEa1dhN1V3TEYyMklRSUxOQnVWUVptUUUw?=
 =?utf-8?B?QUN2R2RZNVJROU53WWt1Sml5elcwckdPUnRrU3FpTlNYL2gzSlBaRm1ZbElN?=
 =?utf-8?B?c1Q5WklJeEtuTWcxYXVrQmRXT3l0L2F5eW1XQXZnT3pxWkxXVjNDQ3RZUHRt?=
 =?utf-8?B?ajZCK0NBZi9CSmc5RjBISDNiVFVLY2lKZXFBN0xWZ2d1TmZYNGhERHNwUkNy?=
 =?utf-8?Q?82DAHqMCufH3AxB2GbWQedvTv4Gy+jme?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHlQdVpPbFI2V2hvNXVHOTVDZHVENUYyRzBrSG1EaEEwSzg1WTJ2UWdVZENR?=
 =?utf-8?B?QlNTbkJGUndPU3F0UkJiOTBIU2VNOVk0blJtYVo2NTNlWVo4WmUzbHRVdGRS?=
 =?utf-8?B?a2QxSXNOSFhqNjJPcjJhbmllK0RDWmxMVHYydFBqN3N6Y01HRTBOUWdaMWl4?=
 =?utf-8?B?R0pUNmZJa2w1bmVhUGluOWNlUkl1UWsyZytqbVBGMXdJRTM0YUNCT0lhWDl3?=
 =?utf-8?B?VHo4aVRGMUFqZWtZWUZtakhEUHprSzJrZHd1S0tNYzZTbm4yZHBzbXpDUU12?=
 =?utf-8?B?bnpWN2s0Rm5aMWkzY3UxUXlidk9EVVZRWVVqSTBHazArVG4zRGFRc2hIY1Jv?=
 =?utf-8?B?SUhiSDR6RmhoMGI4amQrV2VMclJ2L09qNGhYaXVXNmc2bUtIbU91UUhQckVy?=
 =?utf-8?B?NUVrZVphemd6MnJKclc1bkRqM2YyNlkyM21DUDZaNVROcU01aFYrd0pZRVVx?=
 =?utf-8?B?dDRaWThRZG9ORDVYd2dqc1FNYTJVM3VPeEowWTNmYWJweTN3QktEeDh5MEhC?=
 =?utf-8?B?ZEcxZjBQK251WEhORTB0Y0ZsWHBVMnhuWWRFekVHUHZEMXpTUzJCRnZ2ZUl3?=
 =?utf-8?B?eERxSWx1dGNtcm1ua0ZTdy9xRG5iRjUzZWp0Zjg3eGthcTIybGJmTDFTUnVP?=
 =?utf-8?B?SGxqV1FjMksvRm1ZUy9WZ3RycWthK0xtaVEwWVBqemM4eCtrRGo3ZXAvemE2?=
 =?utf-8?B?V0JSQzhYL29KOUIyeTNGeG1PK1YzSG0xellTckhLWXVNRkJnSEhON1BuSVJx?=
 =?utf-8?B?SkxLa294UU1ROExtSUlRRnhPTFhKSFRXNkd1NGUwWEFIaTZRNHhRdWpwMkw4?=
 =?utf-8?B?UU4wMmlQU2FPT0h5SWxib2pSTXl4cEU0MmNtcWxVVEkraXZSd3FCSWlMVDI1?=
 =?utf-8?B?MGFvdEpLSWtVV0VhTXl3QjIxSFUzc1dma3o1dFN4WnFpYm0rNm5DNFVxTm5T?=
 =?utf-8?B?NTJNREtzQmR4cjd5QVZrRmV2OW5ib0NCMTVOb1pFVUEyeU96a2tXQS9CeU8x?=
 =?utf-8?B?SE93SGs2ZVdDUTJGaDBKckpMb0R3TjNacXVMS1ZrT3hhSmtXNG9aMDA0YnVB?=
 =?utf-8?B?TU8vMFJuS2FoVXlMSG14S0pUK2dleVoxaXE4N0oxSFRmOGpuWmNkVFk3dVIy?=
 =?utf-8?B?NVRkbk1ZK2FBN3RLM0VnZkQyYnRvYjIzekFZWHpSMzNyZjhJTDBKaUV2bGZ6?=
 =?utf-8?B?TDZGbVBYNVU5bG9TTmtaZDRCRDB1SFBIbU5Fbm9HcFRsNmxKeUF0bnBBVFhz?=
 =?utf-8?B?d2MyYVhCTEZrRnBVZ2pETHJ4di81UHhEMkxWTUJzcnR6aDR4V3VHNW5MWmdR?=
 =?utf-8?B?Q0JlZkxZcGxZN2FleW9OY1k4RUMwcXhCZ0htWCtVc0pNekxyeEczLytWZnZO?=
 =?utf-8?B?UHZZT2FKdXpFYnBQcEkxK2tqVno3bzI5dG9SMVBQODNROHRrL09KTGc2YW5t?=
 =?utf-8?B?a3pKZUJIVGNjdk4xQWVOYlRBaHhvTkdqLy9od0thVTBwUzVtdVhRQVlQNVZ0?=
 =?utf-8?B?a3VHRGdGMkdzK01FZnhKTElEMDBDVGNJR0Z5dmwzTjlRbkwwWEl4a2wxdStr?=
 =?utf-8?B?Zmd5ZGZCa2N3TEFiZFpVVnYrR3d6QnM0MC90eEdNK1FpYmUyQVNXeFBHR1lz?=
 =?utf-8?B?QkVXRFNsam9YcGJFeDN0Ry9DTG1pK3lsUkdnRDZ2V0E3YWFMTWlmaUU5MVZO?=
 =?utf-8?B?eU5tSXprZjkrK0tZMU4zbU1Genc2R01Nako3dWV3VkdTWlpZNis1Q3JuWFB0?=
 =?utf-8?B?UlRyYjJkMERmeEJJQWhGQm1tZE9Ka0pqWFdERzJUYkxObW1kclVocHdzWXRR?=
 =?utf-8?B?WG9pRDZyQU1Ud0JWT3JJMWRkS3RMaGFsbUN5dTlXQ3ZENFdidHpzZzZBcUN4?=
 =?utf-8?B?RzZRWXVjczd0emkvSW9tazlidHdudmFYa3NkZUZSWTB2bFJON0NzdGg0M1hi?=
 =?utf-8?B?V2YzNU44cEJycE1JN090TjZQbW52aGtNUDFJaDhEUGRYL29JcldwVXNNYU9i?=
 =?utf-8?B?VXpNZzRZR3JBRkxyc3BqQUxXc3YyWCswcDhZenZYaXp6Qm43TDd4VjI1T2NS?=
 =?utf-8?B?K2x5cUhybW9qVmxWQ2puTjdVeHkvd3ZtOUl1dTJSWEtPK0NSdUYySHZaeHJr?=
 =?utf-8?B?VldPWXl3UE1pTWxWZ1g2R3NtRmV3U1UwN0hVU1ovSlBDZE4zRHpUWWtDc3U4?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <699B7F188BEA98499F0F83691587A588@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7xmcTLrDVnhCW5kbIs9RSghuJRv1LISv0qSicw8dcWcS1qBJoYYiHqJ+TfT+6zKincNys1UT15Jg/EBcWuNZrueQ5YDAqQx9Yj/14SrB3v8CZnFHbguZbtRqmSTM06gg5Ku5LFI3qhWoxEKbf+OjARjxD7rzItOEN9Pycz2wSDjs/ABS9lhbksXhtTUMLR8EaBUoy6wxUpO2gqL+Mv3lQH3owWPoXmIY1c4zXusmry+L1cYnG09kuwtNTAXeguBhcPkpFIBvsaYvtozzRVRZoEWCPbCOLPmywlEQFpLMcvFjvb+NXp03SuETZgI2r4Zzn6Wfb5kgQKutJypOEmY3AFVWhQnTNGvtJe7ms+2Lxah3abEXYxQx6vcpwg4F9eCOitAWGBjF7/Pwp1DpLhXits+l5NEZkzS4X2Kt43MVPFSyCIV5JilVp22N+Dsu3WQC2gvqt5hSH4+dzVKwwLwupDlrvNfAHbDTxoMrRCz3v2V+vcIGFkfgczJdlgrdyFVZLpLagYGmhgk81tHmoV/pi1DOzg2pa8tQhfQIJdSnqecuzEgMlUss+LlT7sh+ZKK9KegAX6AlHLS+MB1d4kl1EKCEXhQxV1T3pkarwoNjCF5/lwNORlCONOf7XT0kPUm9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a93cd-eefe-458c-ba1d-08dd65fd43fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 09:14:19.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl57q/1I/iETXeoszX1Kz2VyKtAbtcmfaHAA7Nak4nh3Y7kKm/xb7rOgIg+4yb3wGIFd77pbzISGJnEzynFM7nz5eImwQeEJNqzG7bzqjL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9415

T24gMTguMDMuMjUgMTA6MDksIEFuYW5kIEphaW4gd3JvdGU6DQo+IA0KPiANCj4gT24gMTgvMy8y
NSAxNjozNywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMTguMDMuMjUgMDk6MzUs
IEFuYW5kIEphaW4gd3JvdGU6DQo+Pj4gT24gMTcvMy8yNSAyMzowNCwgSm9oYW5uZXMgVGh1bXNo
aXJuIHdyb3RlOg0KPj4+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KPj4+Pg0KPj4+PiBSZWNlbnRseSB3ZSBoYWQgYSBidWcgcmVwb3J0IGFi
b3V0IGEga2VybmVsIGNyYXNoIHRoYXQgaGFwcGVuZWQgd2hlbiB0aGUNCj4+Pj4gdXNlciB3YXMg
Y29udmVydGluZyBhIGZpbGVzeXN0ZW0gdG8gdXNlIFJBSUQxIGZvciBtZXRhZGF0YSwgYnV0IGZv
ciBzb21lDQo+Pj4+IHJlYXNvbiB0aGUgZGV2aWNlJ3Mgd3JpdGUgcG9pbnRlcnMgZ290IG91dCBv
ZiBzeW5jLg0KPj4+Pg0KPj4+PiBUZXN0IHRoaXMgc2NlbmFyaW8gYnkgbWFudWFsbHkgaW5qZWN0
aW5nIGRlLXN5bmNocm9uaXplZCB3cml0ZSBwb2ludGVyDQo+Pj4+IHBvc2l0aW9ucyBhbmQgdGhl
biBydW5uaW5nIGNvbnZlcnNpb24gdG8gYSBtZXRhZGF0YSBSQUlEMSBmaWxlc3lzdGVtLg0KPj4+
Pg0KPj4+PiBJbiB0aGUgdGVzdGNhc2UgYWxzbyByZXBhaXIgdGhlIGJyb2tlbiBmaWxlc3lzdGVt
IGFuZCBjaGVjayBpZiBib3RoIHN5c3RlbQ0KPj4+PiBhbmQgbWV0YWRhdGEgYmxvY2sgZ3JvdXBz
IGFyZSBiYWNrIHRvIHRoZSBkZWZhdWx0ICdEVVAnIHByb2ZpbGUNCj4+Pj4gYWZ0ZXJ3YXJkcy4N
Cj4+Pj4NCj4+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvQ0FC
X2I0c0JoRGUzdHNjej1kdVZ5aGM5aE5FK2d1PUI4Q3JnTE8xNTJ1TXlhblI4QkVBQG1haWwuZ21h
aWwuY29tLw0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVz
LnRodW1zaGlybkB3ZGMuY29tPg0KPj4+DQo+Pj4NCj4+PiBsb29rcyBnb29kLg0KPj4+DQo+Pj4g
ICAgICAgIFJldmlld2VkLWJ5OiBBbmFuZCBKYWluIDxhbmFuZC5qYWluQG9yYWNsZS5jb20+DQo+
Pj4NCj4+PiBhZGRlZCB0byBmb3ItbmV4dC4NCj4+DQo+PiBUaGFua3MsIGJ1dCB0aGUga2VybmVs
IGZpeCBmb3IgdGhpcyBpc24ndCBtZXJnZWQgeWV0LiBTbyBydW5uaW5nIHRoaXMNCj4+IHRlc3Rj
YXNlIHdpbGwgY3Jhc2gga2VybmVsJ3Mgd2l0aCB6b25lZCBidHJmcy4NCj4gDQo+IEhtLiBZZXMs
IGlzIHRoYXQgd2h5IHRoaXMgdGVzdCBjYXNlIGlzbid0IGluIGF1dG8/IFlvdSB0aGluayB0aGF0
4oCZcyBub3QNCj4gZW5vdWdoPw0KPiANCg0KWW91J3JlIHJpZ2h0LiBBbmQgdGhlIHRlc3Qgbm90
IGJlaW5nIGluIGF1dG8gd2FzIGEgbWlzdGFrZSwgYWxiZWl0IGEgDQpjb252ZW5pZW50IG9uZSBp
dCBzZWVtcy4NCg==

