Return-Path: <linux-btrfs+bounces-9361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231E9BE537
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66DF1F226A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F91DE4C5;
	Wed,  6 Nov 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B6MMxxDs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xswYO827"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD918C00E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891227; cv=fail; b=f2cbwl6mCP/EgDyKU5uCnW50OM7XTWG+mD4h0ZnbeN0dffLFXvCXHJpIdvXdLlZ6I5J/sAuhTCOJsOMMPdL9VNbG02/lcZj1rqCj4tLnaBuQFJZQl8IW93rq4a4/DhuFWUuMDGUDC4JVUaMsT0qVloSD4inoCExYzX7i6aoFGTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891227; c=relaxed/simple;
	bh=AbbPUrfgINLh7bAleO++y1l3OVnCo9WRDZFjmwUJAKQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HAvYQjoJ5hQnZbgMv4WbVeT8chiETps+xM6IA2OOca9XRGvJdi4k8moFskSh9hzQLWGLfyQySK2moC+g4LgTszvY3K3MZrlcXyRDXkR0y4qYwFg1ufQRPJpKfQHOAAOK9rr/0bjLRB9SQuxhVjmUGn+nm/yrKZd3UEKejqPVu8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B6MMxxDs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xswYO827; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730891225; x=1762427225;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AbbPUrfgINLh7bAleO++y1l3OVnCo9WRDZFjmwUJAKQ=;
  b=B6MMxxDsASIjU8rjwj3e7Ugn5e2WxYQXiIKMr4xlkvoIXYHovyg2IFka
   pSYpCiyC6/Lrr8wX+411/v0qkDisnKDJ54G3R4kb+BKc9EIZ2NDYccIPr
   10nXq42cCFuTwPQES0u0mS4fW0mr2KRiF6VUNTIDywPPwdyzUHnfwtogY
   Q6IlIfSvs2DTVa1vBmNajtcj91CIGBRGghDKUtlh1yGiUwynuPnKyF2i7
   gd2/oM1Lz6mMGHW/YANHkPKTeqQGKvHTUfjcQIa/eWqYxBJJqZCZNoNRb
   RaqTQGcgvodep2YsBYiRuzrbT9abT4hRzpmtCj3JAGpKx7lVACkPVTOef
   g==;
X-CSE-ConnectionGUID: 5zwP0x3wTY+s29TPbP9LIw==
X-CSE-MsgGUID: QMt4tnCYTN6BeXsErthijg==
X-IronPort-AV: E=Sophos;i="6.11,262,1725292800"; 
   d="scan'208";a="31885882"
Received: from mail-sn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2024 19:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klXRedLrdrLDBgv/4SsbTWtY6LBnUQceZkRjyTlv4mVuCS8NmzHBna/q0f/7hifgStjJ31jVqbNOtAyuBziumesC3xNPraiT20Obr/2r3SA6PfVYPP87n0I2SGwbUxZTxKqdZWCmu2MRdweTC26j8oFtEwQsJ/yiTPNhV0JH2tspkBuKi8QMg1UQArT16psv5vpm5r9nJkhKOLlH4moUUavoWVOgPpjhUYxmI/eZYAMWHl/Kj8x53vwcQtfbkHCRVnjqQf4AYFLwGWc90g7a/kB40PprycZCc3DJVfmPJ0SrWHi4foM6pzhDsu3gtBk29OqZA4+5/+wMlebn7wmS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbbPUrfgINLh7bAleO++y1l3OVnCo9WRDZFjmwUJAKQ=;
 b=WNwReoi5igL/azfNcVF/6Wg+sbIRhgpV7ak47Bq7uHJP+HrxpHwEY/U7DgFRfuk4MYcgyMfMmxEDrhi3w2WkJaMYQg927VEPJRNboXGRz4v7aMWLBE3NULnc11afoazBHHytxZb+Dg0YpT5yNEQwVH/nKPaZ4WGOyX6N1Rt6PW8c1wNkvElFD8T/d0xjMfEkb02oCTiD6qYyAOhlZH73aPypacZI5mhFe/MbvLU0a/ASXg+doeV1H/WAYNbkuQTw23lmdyYwsGq5ffKrdbPXKZlkn9qvCRECpPGKruHq58upe1yW3GbvXEaDCGr0eIpUO2bfBAriDQb4D9aBaRyvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbbPUrfgINLh7bAleO++y1l3OVnCo9WRDZFjmwUJAKQ=;
 b=xswYO827Y4iCN9bOxaASR/8QcRimduIwJ1HE5gXjEmB3qFh30HOeNVYgDyK0qj6ui1uxVHmTPAC7qNoGlICZX14c1qGwLJABL08VxnLTU/29lTU8dGKf5oparrhCezpV8wZnoF3OY0096WnmNwhv68aIgSlWHJRpsR9CkK3s42c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6590.namprd04.prod.outlook.com (2603:10b6:5:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 11:06:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 11:06:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reinitialize delayed ref list after deleting it
 from the list
Thread-Topic: [PATCH] btrfs: reinitialize delayed ref list after deleting it
 from the list
Thread-Index: AQHbLtAiePPeJhd6VkWxHZLVTthedbKqGlyA
Date: Wed, 6 Nov 2024 11:06:57 +0000
Message-ID: <28859d4a-0680-40b7-bde3-506a72b8cb89@wdc.com>
References:
 <6bcfd46957685e044fbeab230ca13cbf6f469de3.1730734807.git.fdmanana@suse.com>
In-Reply-To:
 <6bcfd46957685e044fbeab230ca13cbf6f469de3.1730734807.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6590:EE_
x-ms-office365-filtering-correlation-id: 062694aa-b3f9-47ac-c6d3-08dcfe532162
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUZ0ZDF0aE5FM2FTYnNWTThubXNMTzNXMTZMZ3U3aXRvWEFuSWpuSitlbXRo?=
 =?utf-8?B?ckVodkxrNGpPd2kzbGlzT3FtZUN0LzludnRPbGZIaU05Q1FtN1U1aXk2RFFT?=
 =?utf-8?B?UXYvNmxtS2RTQlZyN1FCc2JBMXdRRWNCWE5NSFJOUUtyOUdCb05McmlmNHhv?=
 =?utf-8?B?L1NhVjAwaDk2akZqWkNHWi9JYTl6dUtBdXh1MHJ4RE84bjNQT3JhNCtWN2Uw?=
 =?utf-8?B?NmRDdmppcnl4cGU5RGRRQllkVG9vV2V2d01mMVFVWCtVVk44ZlRzbkgzNjBR?=
 =?utf-8?B?WXQzeUF6TlJsL0VSYnRXZEhMWFQrZnJhRjdQVVVXV1RIYnl6STVMUlhYVzZa?=
 =?utf-8?B?WmpFYXVMVHdPQVczdlhXR0ZQeStObFEzK2N4bzJweFh4eHQzZ0JRR3FtbVJ4?=
 =?utf-8?B?R1huU1lGeG5NYXRUUXFHV1dwTENHUTljNVN5bi9QalByM3BoZTJnay9QMFpp?=
 =?utf-8?B?Wll4a0pVRjl6WFd6RHVVb3Z0VHUvMGp1UUg4MnFxVEhwM3BLeWpJc0l4anJv?=
 =?utf-8?B?Z2ZhNThMU2UrL09CTHBQOVJmUXpkYWtOQTliQVdXU3BCc1R2SFZZeUYyOGJV?=
 =?utf-8?B?SytFN3R2cWtEL2VVQnN5UUpDUEpDVzUxdUhEanJHek1aQVlUNUpSaGdSc1dK?=
 =?utf-8?B?V1Bibkk1V3d0eEM4NjhPVU5OL1RYcnZrcnhubXdKU3lUSVZaeFhYTUhHeDhp?=
 =?utf-8?B?NUc0LzNNWlVMeldCQzlsYjE1MVZUdWwrZVh3US9ZSkk1NC96YmpxSm82WVJk?=
 =?utf-8?B?YTQxV1lKK3hPUkcvVW42ZnhMN0M1RkpMbVJ3czlCaW5yZHVQNUFrbStST0wv?=
 =?utf-8?B?VjZhWjQvSWp1Z3VPRFNGdkdWZlM1Z0o4d1dkem1BWDdzbFpvbGVCclQ5STQ5?=
 =?utf-8?B?bEpPWWdkMmdJRjRQbHZQRFBIcmpGNk0rQ3NQektyRGpVa3JiaG44ellXWDhM?=
 =?utf-8?B?MXBId08xcGhpSkN6TndZNXJ3cFkrTE5EWXdRNTVlYWJsMTdFWjgxK1Vtckww?=
 =?utf-8?B?NmNTSGtKZFJYcCthSGM2K2R5bjZNWnFUbmc2RUl5Z2pNOG5GTWJFcnVUVS9h?=
 =?utf-8?B?RHFsRnB3ZlRFSVkrU0k5UVNYWklURUtiV0NjcGcrNTA4dENRN3lQbXQvZ0V1?=
 =?utf-8?B?UjZRMW5XVmtOYi9MVTVvd1pQQkxVUFZrK3lSNFlFek9nWHBnTUMyNFk1clVK?=
 =?utf-8?B?bktyVWN1RzVFNkZRc3RlN1pQMUJMb0UrY3RaeTRjeUV5akQvaHA2Mnk3dGtK?=
 =?utf-8?B?NERxMHZHK2M5V3RFSUNQZjBFSUd3MVZNNHZJc1lrSnM1T3VPMG9rQi9ocWYv?=
 =?utf-8?B?bEp1ZW83Sm9UWWIzSmlvQytNbzFGWm85MTNITU0zRlEyTE50YXlVNEZmS0pD?=
 =?utf-8?B?S0thNVE3dThWSzdzbXNxWTd0aENUUldaQzNObG5RUHRPM0pvVWxvQjNiMlpX?=
 =?utf-8?B?MnowSk9BeGxralYzaXdXbEoraTVNcnJoWDBnbFZyZUNRYXY4K3lXcUplWFBN?=
 =?utf-8?B?Y0E3bmVlVkF0by9KakVPYThrQVNXVEVjN0dUaGxxbWxtbjk2NTFkRzUxN2ow?=
 =?utf-8?B?MUZ5akg2VDQrZGxXbDRzUjZVSGwzYnIvbGM3N0hDL3JDaHpsTXlLUWo1R3JV?=
 =?utf-8?B?d1k3STN4YXJxY09Zd0VSWXlaVDlORkhoMXFGMCs5M3BzSGtRR3RvMjd2ZDBv?=
 =?utf-8?B?NVpzSFdGWjJoTmxzY055Slk2R1k0NUY2dVRpSWQ0UEl4RlQvZFRWZXJBaS8z?=
 =?utf-8?B?Mk9TV3E5cFFRUWd1VERzODYzTUUxUXRpTzdyMXF1VG9JK3BTUjltRXg1ZjdF?=
 =?utf-8?Q?YF7PwEY9HkaeqM8+Tg+1lmRp9aIDHN/usz1ds=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW9GVWpjVk5kKzdGS0s4eWZNM3BOSytCU21wekJuVkQwblpaVzlHZkt0UU5D?=
 =?utf-8?B?ZktlcXRad0szSW9BU1h1U2JiaVJNRW0yY0Y1czkzeXZlOTdKd0JMWHBsd2NS?=
 =?utf-8?B?bnR3RW8yQi94QnZ1eDlLT283d2hQU1ZVN05Ia0N4bGNWcUpGQVNxTGcvVFcx?=
 =?utf-8?B?dmV5T3J6QWp2aVB2YUdNTkhEakVyc1VleFYrakJwb1Q4WXJRdnhqT2hBMGpp?=
 =?utf-8?B?RlFzNEhvZW1GZUo3MENjbDZ0NGtFQ0Fsd1YvVm9XcTJhOG9UM3dIL0lnR1Vp?=
 =?utf-8?B?aWVySHNsWklNS1BmYW9ZV21lN095ODZmTDB2RnBaK01VMFBScDZzMkVYMXgy?=
 =?utf-8?B?YVlhU2FDcHp3ampwU3FDS2E4SkJZODVHOW5YU0d4ekt0aUh4ZGVDRDBpV3RF?=
 =?utf-8?B?WWpxbTJseGViRzhlNlpuaDBvOU1raVFtVnltVG96SE5JVG4wY3hkVkFtVjBn?=
 =?utf-8?B?UGFTTHQ2ZjVUQ3M5UGJucGdiVy8yQ3FoVjRBUWczY3Y0Y1lwVjQzSkNrOCtK?=
 =?utf-8?B?aHJGUWZoZW9oYi9IQWdrQlc5cVk0WUtDOGVlZ1FBd3E0Z2pKSGZRZnpBTkJ2?=
 =?utf-8?B?MElCNytvbXQyZjdUckYxc1V5cFNaRkFNODcrdTBjY3FLWjBLZ2gwbWRHSHk2?=
 =?utf-8?B?RmN3M0lQS3BmV2lrelhXQ3hQbWs2aFRScDd6UDlZb2djSFNBWWd5VVJsU3Rh?=
 =?utf-8?B?NUhITGdZMUZ5cys4TDBLMEZvZnVTRDdFNklYdXpjbDZCSSs0d0hHRUk5QWJw?=
 =?utf-8?B?R0p4V21SaFp3WmpMYXBxak9sMDJuK0R0bi9CWEM0ZTBzaWNqblp2VnFEREdV?=
 =?utf-8?B?amlMSjFjLzVKUjF5cGp5TTkxclZaWE5vbkxNa1FrNGxaVS82dmlGVUplS3hF?=
 =?utf-8?B?M3NkOWI5RXovV2F4WVpuZFhEdGNhaStubE5pQTJmTjVTSW9hZ3JMOG9vUW5u?=
 =?utf-8?B?Q01xRHkzZGJ1cFN1L21wUVFYWGtGTU1GVW01ZEtxem9mUkNPb2lWclRxTmVW?=
 =?utf-8?B?MldxUjlKM1FiM3BzUjBwWWl1VlNsZWFEZDcwMEtpU2g3TEd4NDFrMGE3RXFD?=
 =?utf-8?B?bmRzeWV5YitYM2JNR01hU0s0WXdLKzhwSjFtOGQ3V3ZUclg0U09EZ1VHbnd3?=
 =?utf-8?B?Tk4xaXZZV3EvMXl3MktZWEc5UVA1RkxBQ2Zac3V2RytpTHNpblZYZFlFSWQr?=
 =?utf-8?B?V09BZDRWcXdKZUNPRGpKU3NzeVhkRHFvMlJ4dkJHZ2k5ZHpvZTltQnBJaEFT?=
 =?utf-8?B?Mm1MbmtJTUNVK2ZYNHhKZWw4NGp3TDdSWmR1dmszNFRCVENReFZnN3Z4K1FQ?=
 =?utf-8?B?YUNrbDB0YjhLS2NCYzlCdjByK0QzSDRSVDFRdkhubmpveTVPOGFMNk9IZko3?=
 =?utf-8?B?WkY1TlNUUVlndVFJNHJURlRDUCt2TzRYdG9KWXlYekRWTm9Gd3pFTU1TN1JF?=
 =?utf-8?B?alhuNm1KeWU2dVNRa1hQWWlVZktGai9oajYxNDlFdExkeWk3SzRNREQ0b1NU?=
 =?utf-8?B?QlltTktGZW5pbTl5dEpsdHZLUlkrV1JRMzlCWmVtc0MzaG5MSVhIZXFVR3No?=
 =?utf-8?B?SFZFUlpUbTVaL1VCdzkwelhuaHlTSTBZVzVEcU1iTG5jVFNUenFCR01oalZL?=
 =?utf-8?B?UTNSVys5b3FCbmszUjhIUHBmbnk3Q2paUDhpY1pZYS9iV2dCVFNScFN5WTNJ?=
 =?utf-8?B?OFVwTlZxbHYrSysyYVR4MGpLM3IrUmcvdktRT1hKSjgxcjFkTGNkTjFyeWtu?=
 =?utf-8?B?MnlBOTh6OGtvVzd0NndXTjcrMWFPQjFCbHN1cE5yb3N1d05mWFNnYlYxZS9S?=
 =?utf-8?B?R1JjdTEzcy9aUnB5NzdKd3hTcUppNW5WVTZKb2dEdEQwYWtibWNuTmV0aWRv?=
 =?utf-8?B?Rk9QZFpkRHMwUEdsWTV0dFI1RTJhNE90OVpXdXZVUkJzNmhUbWpuM1p1TnVE?=
 =?utf-8?B?NTcraTBvc0ZwdFRxRjg3dHJYUUxmUWk3Qy9vSnFLektaNHVJU1E2c2FhM0sz?=
 =?utf-8?B?ay9samJLbGNwV1pMOTFxY0NDZEUxZ3Y5N3I2NDE0NFB1aUdPUGtxODI4alYv?=
 =?utf-8?B?c3NqMmdYTFhVSTBxdFN0cTVTOXMxSVZmLzRiL0NEVURKSW9GTU9wOVJ1bUZR?=
 =?utf-8?B?dHEzQithaEdiWWVESThmK3dzUmhTMVJ1bmp4b0FRc1BtUDhrSDBGQlIxSXYy?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AD73F28D99BD54CAC5BA9A3E894E349@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tu+So9Y1X6jG+f0WSOiOZXYLj4sA1coBahcOl4VbyKcV00qrO156pfYtTYNj3iLFU45O8Agagi/yD1+jXb2VBByrXp5LvYvt8OXBzgiUD8KvD3L+kbST9rBN7mT35WR1jkvkJmUqqazlnaN3BGF8IKT6kUCOcEog6dUCESCbcROw9O7+ar3OB2+HVXnE/0OHZZar66ZP6pqdYQ5rL588vE8xAMofVZQ5o4tip2RvWq2y8SLTQxdS5dYmlMERRlEZvVI2yifEuiXzi6bVYGPfsza6f1R1ud9qRY+DyTZ1BHDwUz2msjLQ/9BSwRFXwHXNwBI/pXAW0NR2rpFcQUm6jQWyFimbYA6qj7Kr+xe7dV5VB8rGTDep0nUdrM2yFL2QQH09H5pDR30cBKo9muUPHj8y3RIFbuuXq9neRcIQ2FQbhhSuh05mK4r0RTJNqZv+ZJil380BCO2Lsfk7CrdYw1Y+uIRTHdQ/5CrMpQQcQQDsNlmN/CFObBIlO0rR30eemBN0eKR0T61zB3DYxcWm7myps2OffvWr43OaIplQaIf+XoThbHifSm3bkYO4JFJLf6Z43vryB+1TB4Yg1sNFRvucZ33soZ7VHm0FJfPBgJfy5s1m1K4F7MKow6Dry+g9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062694aa-b3f9-47ac-c6d3-08dcfe532162
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 11:06:57.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANv5CEob/ZvtfZ4+M/4J8l3BHXSJY/J1+1q5IlNeyPv7wmoStsDGKyiJjGhac4ab6J7eE0RlUTI0hUb/j/a7NRTyyE8/lnK/jABpDDSnVJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6590

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQo=

