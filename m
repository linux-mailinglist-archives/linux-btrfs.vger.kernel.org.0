Return-Path: <linux-btrfs+bounces-20501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05222D1E582
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37D130161C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D3387379;
	Wed, 14 Jan 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X8dxXNkQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E97jfA8x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA50350A22
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389398; cv=fail; b=AR/uJKBgtupMIA5AEQXyuurkQYgcNoSaEPpJ4enfkkxPW39aoBsDEFsvyl5weKaK8mZdV2VK+is1xDETPk/KnqCOux/G/6nZN11zQvnWW4RFrJfx58dWVmEMMp0EpuQHSJkeAp4ysmAV504+7v5Pvp2wThnd5e5Nq/zidHZKdiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389398; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oN6Zvq0SXzXoXnUBfwBRR6V0u67VgQKSHZn0wuQQEIkopWRchMPuzxFK7u9Imxk5Ga7ljibaCshHyVhO5c9cQ57lneS40+3EKr9BcPe0uZokeRAk2ru16cuSn2bpkc5jfclO6LO7iVJfSngIH+a53fIUT6SKE1u21Dzqn7QYAkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X8dxXNkQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=E97jfA8x; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768389397; x=1799925397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=X8dxXNkQ5w3yGZygu0BkcOcgZPqEqdKLw/tXVMK3qmcVDRoZ+g+Mu1jg
   bH7tAf+h1CSLKIXFIbCghnBRJOZGMx0l5tNMaEMXFLoEU5fOLNEGnu9p1
   XmgrnEj/XJ768h4JHWAzH1GTJxhFA1oUp+CfHD/eDZFaG4bwN+jQIzns6
   IJqIXT+07Kr8OmV2gEKz59hcTo5NGpsF2tMuavT4uZuE6DJLPYqtD6Kad
   kIUZStgb1VEE6CjreBhbtGQO0kw/K9oPAfnc4V9icyXHC275vN5D0rBuy
   Da9T4ALMMwvFr+CU0npZtHcWSblAeg+hz8pBjxSTi15xG+rgL6NYMjdx9
   w==;
X-CSE-ConnectionGUID: 9kE6sNB8SUq9IXd5SJml9A==
X-CSE-MsgGUID: mMW2cRVARSuE+MFfTLcp/w==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="138054867"
Received: from mail-westus3azon11011001.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 19:16:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKTe6MSk/WD96+tyxRXvAwHSIe5wF5DwJUNGGWMwE4Dctwa0xPx3UGKCXdHA9SJaU7QdmAmQXrepCazbCmuw6EJz3Obz2zrP82EkqAiKuLv0RlHtaBffOxj0GNQEVQBqHRAhT5hD9oWr0ai0ZfrMBUK05d3Y/fFNkmxoFpAqNaa0gxdEQvGCfj1b4CzaPP6s21zrOksZXNMHR2YtuocgsYBGHxk9dK2mZlwoz83KAtF1Iv1mFYYh/M68GYyqNnzJX0xs2+FQXNxAGks2GUPlhCKXuAqnBzyqMqD9+o1mZ4GINiONYFGKAteaeQRT+dLjaYXmfGl6JzYK5OeI2jPgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=FRojG8hXHg1asA9TkaJVUnVrJmUu7IN0QS2VRBk8gPq4yj1XbTpd+IHTQAMkgio85f34w8SxFy0Imrky2krpiOvvXwF7AEBEq1SMwHH9m2wJu6f1lDEzYcC1S7QDxzAe0WQzEoIla177qcvAMsw6M1JY/GGceH+9SknMiFfT7SEXkcHinx0ND9cY09pck50//knrJtn35DJ/VeNi/+CZbiiyWUbWdb6CGTA6/+QONGE3U5ecQMphrDsqB+YOsU6mfGI7PpwKgKECiU5n+2KbWoqMrEW4bsePfRNiVmIOyiA0/HDVfVRCf1GEpaMHeEVm1477rmgsvxlY2LhWnE76Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=E97jfA8xy5x8jJDRYlBlg6y0P9ZO7eDr5Ao5gebxeUM4N6qGFg5dQgztsS8BufHQjrXqPEJmLBQG59HbcpNf+4qR6GFkwiaHi6QJ9MRN5lM9vCI+kJGlgAKn5X8MWkIuvNDdEcEAvEpzsPp69jtbocMEu9rhijpsK9cDXUzQ4bQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH2PR04MB6774.namprd04.prod.outlook.com (2603:10b6:610:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 11:16:27 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 11:16:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun Yangkai <sunk67188@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v4 2/2] btrfs: consolidate reclaim readiness checks in
 btrfs_should_reclaim()
Thread-Topic: [PATCH v4 2/2] btrfs: consolidate reclaim readiness checks in
 btrfs_should_reclaim()
Thread-Index: AQHchQkp7/rGnAAC4U+RDN6FQ8ktPrVRhF8A
Date: Wed, 14 Jan 2026 11:16:27 +0000
Message-ID: <85ba56c6-2b7b-4a7e-ab15-43aeb6afd0b8@wdc.com>
References: <20260114035126.20095-1-sunk67188@gmail.com>
 <20260114035126.20095-3-sunk67188@gmail.com>
In-Reply-To: <20260114035126.20095-3-sunk67188@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH2PR04MB6774:EE_
x-ms-office365-filtering-correlation-id: f86ae60e-5aba-4fb6-07a5-08de535e5c2f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXRrZGJBbU1DdWplQUJ5aStHR3lkSFNxSHZ3S3ZUVzdTYmZiYk1NRjZJQXI4?=
 =?utf-8?B?L3J3TWpVZ3M2RHpRMG1tcWgyN3BROG1jNGVpeVY5THBjaTdaWVg4NXQySnQr?=
 =?utf-8?B?NHBwNU4xQjg1RVhCS2FkNGZmMHh3R1ZoM1I0bjFST0lxSlI1N05keEV4K3R3?=
 =?utf-8?B?bmpucUEvTHNDbXJHekRPVmg3MXJ1UjZPQlpBZ1BrN1hTVXpvSkVFS20zRms4?=
 =?utf-8?B?MGxmL2Rwb1NNQVZNRU0wSkFzaHRCSFJsc1Y3Ym9Xd3YvbU91UXNxREVPQjJy?=
 =?utf-8?B?MFdsYUlIcVByRVphNElWWG9YRm5CRjJ5OGRERk5WN2hZM3VUd1RLcjY5ZVUw?=
 =?utf-8?B?ZldzQTIwZlp0eVU4YndVNk1DR294Q3M2aXI0ZEJueDhyOTZSUCswQTRWblc3?=
 =?utf-8?B?NHZoc2RyL1k1SjVpYlJBYUNhWUFOSjdDbUkxd21TaWwxQXdXMUZsU1FoNWRI?=
 =?utf-8?B?MExubzlYZ0xHdm1zdmNqaVlQK3JTV3ZkMUpsK0V2VWlVeWJRSDR3NlhrSHQz?=
 =?utf-8?B?RzcyYTYwdHN6Q3pac3AzZGpOeFdpYlhVSXFKSGhnYmU5TDgwekU5aGViMXVJ?=
 =?utf-8?B?NnArZTI1WlMzbUs5WjZ2MUxqWlNGc1l3clVnWUltUzVrV2x3NDRMVnZKUTE5?=
 =?utf-8?B?LzVmbVA2TFBtRjZyQXh4bkRTMVNtTVJKYkdEWEpwRVdJR3VhNy9GeW9ERVYy?=
 =?utf-8?B?dEJOU29weEwrYWE2dlZOOE56MWxFcHM4TGpwYXEyWThBd09odjRMY3dNcG9S?=
 =?utf-8?B?eDYzdHdSbnBMNEh5YnVvUU5pVW9aZ2ZIV2I4M3JROFNQZkdoeGZyeWNqcnk0?=
 =?utf-8?B?ZXhTTWZZU1hRZzljTXQxT0tPQ2FEOC9BckRxcFBqZE1VSi9zSHg2cFIweTdu?=
 =?utf-8?B?cGg4WGZ6QzNZeTJ4ZEFZaXhQUWNnL1pDZnh3NTMyOVRFV1htVkJPT1hXZzVO?=
 =?utf-8?B?MUhVbjNiVDl5enU3eGE0UlRxRExCd1YzN2t2dmtpV2ZWRWZ4dmdvYURFbEtk?=
 =?utf-8?B?a0o3RU1McENhK0RraXltT0Vjb1RJMEVPM2Q1SnJjR1dtYllQRGVWazlSd21K?=
 =?utf-8?B?VzBCM0xXWFFOTWlHUHJ5L0lZUVNsQmZEblFJWWJOaU5oN0w2bmNHNXN4V2Vw?=
 =?utf-8?B?RnE0b3hUNmdteEdIM2tsa0xBU3BRbDhrYys2aHhMTTVLZ005citMbHRGYmp4?=
 =?utf-8?B?TzAxOEJCeFpFZHFDUE1jSFg2YlNNZy9ycFI4b1NEV1BOTFZjeitlWEtZbjhR?=
 =?utf-8?B?N25nUmR4OTBmYTAyNTYzOUNtK1dnR1ZOUGZyNkMwQm9WZ3luSnk0NlJrTTRB?=
 =?utf-8?B?TndnSThRTzdsOUVTanF2S09oNEhYVkEzOGp0SktpSW95WHQ0YzNpQW9uNkZ4?=
 =?utf-8?B?Wk1VbEhjUmNYZHhNN1hTdWFrKzc1VUFLV0hNQ09wN3J3QXRZVnJQWnBtL0k1?=
 =?utf-8?B?dE1CcnB1K29kYUxUekZCUE5qQlg4eWk5cTdjNVNNRzEreGdpRlhIa1RkRzZv?=
 =?utf-8?B?eGtsTEZ3U2VRcXVrajNHellHYnc4MExzcURjb2RZRjlFZjdrdmE2NWUzRUxD?=
 =?utf-8?B?VlhqUnhZWXVOemRDMmlSVnUwN3d1dlY2MWNDWTFzRjl5T1pnWVZFWGRUeEdB?=
 =?utf-8?B?NXBnWTRNZTJhWlNHaVdmUXJQU0EvbzUyVVMzVkJITDUyYzJ1amtaUGRjWjFM?=
 =?utf-8?B?QklncnpHR0Vyb3BKdEJidWp2T2g1SEIrS0QyS3VxaDIxdXNwcDNwUW90cDFS?=
 =?utf-8?B?dURxQlAycnBBa2dYUlQreElqSXZkc3h1RUdGREdhTGFueHNraGpwNWdUSUh5?=
 =?utf-8?B?dzhQaGFUelN3N0x1Nys0NXV4a2hHbXBUSC9NelNRREUwMVNwZDROVDNPZnNO?=
 =?utf-8?B?azhaWlNqeU4wNmRuNU9QbE5hZTZDUTAzM0lPTndRZ1ZVR21leXIwWWJ5OXlW?=
 =?utf-8?B?RUw3OGdLUStrSFVxdHVzL004cnV4aElRblpVZ2tRQXlRVDk1c1AzMXZDWXZx?=
 =?utf-8?B?c2c1SXBFMGNWTmFRNDZETG1tRmt3TnVDTWRqc2xQUkxTSGJ6bURpclNYNGk4?=
 =?utf-8?B?M1pPZ2RLd0NQSU0vb1Axd0pUcmV2NG9nVXY4VmdJdit3aXZiZ3Bxb255MFlh?=
 =?utf-8?B?eTRwZkFqOWNQZmR3aFJIYzlPbTI3Zi9kd0pXam1zekJzNklNbWM4NGFBR3JQ?=
 =?utf-8?Q?H1ooM7u3+v14KtjAAS0Sl9Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmllaVdXY21WNnJORTlFREM0OHZ6QWh1ZUthQzlyWE14RFd2STNlMkZvVVdF?=
 =?utf-8?B?OHBtM0pKc2xQSmlCWHkxMU1yMld2aVBxTW1yZm9IbnZQdFRLbFlPMTkrbmNk?=
 =?utf-8?B?TDZ5OVRyb3ZhTlFnUmpNSXc3aU0rN3ZVTm1uVVJFdXRsY1JUTlVuZ2lueXBO?=
 =?utf-8?B?a096QmlrRGtDaCswdXQyWlNyd01STksra0J6a2d0VEVLWk15OFhRUE5uR0Qx?=
 =?utf-8?B?eG1TSGZQYzlPemlTeU9DWnFKT1gxbUUyVWJ5SnJVMFNFa2x1Y1ZuL0FXUzIw?=
 =?utf-8?B?cHgwSlBTWGtNNlpMYTNJRDNwK3R6TzhvNVNyenFHMzBZOU14MGJjWTlCODlv?=
 =?utf-8?B?dWd6Rk9sc3d2eTI4cytpMlFUeUQzKzRzSDMvd2RCUEl1dVRkTGp1WUhqR0tY?=
 =?utf-8?B?a1pFMjRzNnB6UDh2QnUwYzExaUpmN2F6ZGZFMUluTzVLYjIrRm1pVktHVm9D?=
 =?utf-8?B?K1Z5b05NblNQTmhSVnFBc3hpRUZvWndZWjM2Y09WU0VhTmFCeFZYTEJVcjlQ?=
 =?utf-8?B?bDZTQzVpUVVGdXBPOW5Dd05uZG1scS9Wem15SnlKdXZMTHgya2kxNG9NTXdQ?=
 =?utf-8?B?TjkyY2JKNzd5QVNBZFc5K3d0ZjVKdkQ4NVN4TWFLUGo1bE44OU8wSTlVV1B1?=
 =?utf-8?B?djVMZkZsNENzNG4xYThBTmtFVFpGUjdkNTZiQ1ozSUJ4MVpRK0NmRVZUWnFu?=
 =?utf-8?B?OVhHemZsZno5ZmpJbmZaUXpVS002VTFkeWF4Umw4aGVJcXA5Snh1eTc1V3Bk?=
 =?utf-8?B?VmJOZERIVWFnSDFIU1l4VnZzdTA0MWRjMHQzMGJnVTVhdFdCZ1RNQnNRalFz?=
 =?utf-8?B?YlQ1L1pPc3hsT3JHenNSMlhidjZYR0IzckZnaS85Z0hyMjVFbXJiakY5clFz?=
 =?utf-8?B?dEpjVmNVMlI1c2ljaVFRVld2NEJwRDF4LzcyYVIwcHg1ejB0R3lBMElaZ2gy?=
 =?utf-8?B?ekdsWEw0UEY5eU50WUpld3RsM2h2UkZBVnRqa0huYVZ4UkxvNVB6Qk1nUng3?=
 =?utf-8?B?R2NTVFRCdUlkYlo3dk1UOTVuWmNFTjNnOTU2amxWSm5yMEtNSWlCc0YvWUk3?=
 =?utf-8?B?NTlyNytkbnFWSlI5OEVzVnhwNWdXbWs2RkJkRTlXTTVsWklzSVp4cWloTzFo?=
 =?utf-8?B?NnorS1hnbUpFem1lcGtrMVA0bWNYUitmQWdEWjRyUmxvS2FwN0lLd3FUc0x6?=
 =?utf-8?B?bnZCWitvdEsyR3BvWFFjeTA4UTdlaCtDTC9YTDQ3VXcya2pYR0VHbHlNamJ0?=
 =?utf-8?B?YnlSVnJreGkxU05BTVhsaE9vcjhjR3BYRDlMeFpvMjV2TjN0cnhGZGg2S2tR?=
 =?utf-8?B?Y2ltcDgzUFhsNDZsMS8rLzd4NlVHb21ITDJmdXM3KytSd25xcmpSa05qU1gr?=
 =?utf-8?B?UFIrRnZzeHZFMXE3d1lYUy9xekk2REhlOHZUVlEwY1NPZFFHY2lVS2RhclFJ?=
 =?utf-8?B?c3N3SHlKR280MGRwNDYvb3RWQWd1STBKRjNmN0Z6b2ZOeXJ4dm9STUg1T2RY?=
 =?utf-8?B?bGJuOWFodVo2UXBaVnhSNjJsM3ZlSW1kWTA5ZU9lRUZ5Rm1XUHlnL0ZtRGNx?=
 =?utf-8?B?T0xDcTcvY0NGSisyZVVWUXVjczljMWR6ZU0vZWNob0h0b3dPSHgwZUJLUzRs?=
 =?utf-8?B?THVQVGlwMytZSVZuZy9TVHlDY1dycGVmc2ZiOGVoVGd0SmFCdGx6cXl1cEFw?=
 =?utf-8?B?S0t6eFFYOWRnNnFhL1ppZkVPL0lTNEpNM2JsVTFTT3h2cUs5dWc0UjUvM05K?=
 =?utf-8?B?TGVyV01hOGJqa1E3YlplcmpscGxvTHBna0hQT280MVN0UlpCYUxmUnp1OHhn?=
 =?utf-8?B?TjFkeVd4aVFubEY3bUxpUURRclpPU21qczM3b0VFYm1McVEvMDNHREE2SEdu?=
 =?utf-8?B?OW9xM2wzbVlBWjRUN2dwdHlDVWh5TmVHdGZnZmlxUDBXVmtLVWY4Ry9iN05E?=
 =?utf-8?B?RUU2eEFSMWNPNzBDbHBhVE1CK3YyaVV0VXllUC9ETXZWV3BhbTZEKzVBN2Vx?=
 =?utf-8?B?OC92T2UzbCswTW1VamVkZWNzVXpORzA3SGowRzhTRHhoSFBTRWIxZGtoN0ZM?=
 =?utf-8?B?SWlOUHAxVmo5NXk1azZsK0NrRzZlci9lcTJWN1F0aHZoNWtmVFdNZUlEODRo?=
 =?utf-8?B?TURjSDV6VnRleHlhM3BsUmZmR0Z1emk4cnc2dFVXM3BsMUJlRllMNUx1RnpQ?=
 =?utf-8?B?N2Jrd1RyRmlRalRVWWV6SHdZMmtCVG14Q1lSMW0ybXloT290UWkzb0hmRm04?=
 =?utf-8?B?N21mRERrNzZpK3Nya3BmWW1vaTBOYTFjOUxtWjBCUERFek85QW9LOEdDMWE3?=
 =?utf-8?B?aEFvYzVqUG5LNUI5OWZXYnVJRU43QVlvVWE4aWpLZjB2RHpiZ2czb2h0ZFd5?=
 =?utf-8?Q?ter6MYipG06SzVdzN8VhWhX/zw6hnelfxaYoPh/XmipIC?=
x-ms-exchange-antispam-messagedata-1: R1+pCa/6kTzvRMUJjO/Csc+sVPcL5SUYSNk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC62247481DC484281357DF2B4D9A0C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CKDE9b8oIyguswQh9VZLdX4fvKmgfAtfCTdlqtwmdJbvO0Is0Bc40qgb48RBcNMbCzwFGWt2IWBHh4mO9swOT5j8lyL0e/DzfPb84mH9iDXEVix5toYHwEIZSjvPao76KN7QXYY6dRnn2R4o6E7SxPeSyWl3QpKaDKQNt91leLuFWOSFoyswJaFB+dwrOXhObxZDIdrQH7lHdDgS1Z3qfGHSjuLYd491pTJSZSdSJnvfGlkKVy4JCLW7czHrPgx2hDKSeKt2fv3qF1MVylqVxOzBF5Xv8KqGoatSzFN/RhUELXW1wf/08SS4X1Pogeot6Knqh0LyO8em8B6nQJBkLR5AHVbkE8jtOasC/TekvSW2ElQzXk1eIgnAuWZ/sP7l2jfV50NumTzPcT6qGIjZjBs+yEjreoyZQcoVKqXOAa1KwhQ9PObFFCBPVyfjXKILHBoWsF5OTeoLfLfzaVcry5JPddssd1KGdsovS9P0w7PbjhEoYFbBPAD/5S8BMyaT3OOuCIrzXmEzdTDL7pU5qE8NhSIK0hX+ffT+nhj2AW28W1AQUlRF6HJBfqTdvhHajkZoplRi+1xxn7AFWfsb1KXkYhfS9/jzZuc0YPkM/T+FffQFTYr7gwsE7BAJerxN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86ae60e-5aba-4fb6-07a5-08de535e5c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 11:16:27.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sLI3rPe0AgXlVTpnV0CvoHFXXRQ28jrR++6LE+lYBgk2/mOxbmwYz9aJeRnnvfysC5e7+0dEQAU3M6KV3CcWAU4t0d++xucBuEsNOeZJ1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6774

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

