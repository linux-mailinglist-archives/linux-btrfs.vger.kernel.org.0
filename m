Return-Path: <linux-btrfs+bounces-14937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C9AE7F99
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046C23A6DEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9728935E;
	Wed, 25 Jun 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WiZXNT9H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qgepPgFU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135129E111
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847650; cv=fail; b=NQqGW5vypWkK14AS5U99GZYQIFQ8IfO3wl7BgYlKagRSQx/Mpa3B9wQpmcdsqBLiR1cDfP2iM8E247vhmxhKzrDVJYBu1hD9S4lOsq6K5UfSCmBre8PnHLhUE1EoJ6HcsRinYyOnjt1PxQoRlDk1KyJSIBnRdXulR6lcOC7JKEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847650; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETMyyTELHnddHisk06V2i5ZN2jb6hmTs005U0srakV3kN9E6ibd8ehHzCWWSgdm+crMbjNx92ho2lxnVnQjD5XcmFpL2YV0XD5AHRYWACQMqRF1Tcf6plUw4JILMK7yCcEG23RhAzXXSJ7E4qLnWIdCf80Ycinr3LiwbfsNTK5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WiZXNT9H; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qgepPgFU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750847648; x=1782383648;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=WiZXNT9HHHluw3rN/1w1XthDM1yUdNoOh9un7l4TdYh6TdIi7ewX9xQK
   gij1AfHX9zdAkyIh5zpNtTFpCKnCrzWdmEbTHsqQnGObypzSPA0cUIrSF
   2htzyiPvg2P6SbyxHCear4T+LK2l7bngkbt6BgFLOhXyvB8QdREkdftSF
   gSEX1TyghMbWXLPWNMI205+tQcF5JJI8wqBdNwwZ7CEAz2h1EomrOWRvj
   iLayaS7duCkWz+5i6rF4zrbmHC/fh+TP15jJHd+5hshGSxwGO1jkdvvI4
   u6bgiH1HKk3HU39MKzhX2UMs7Abn7a3LaGL0tAC0L5L7BSuXvNG9Rx28y
   w==;
X-CSE-ConnectionGUID: yYfYl9YdQLmKJdGyf+TJBQ==
X-CSE-MsgGUID: kcEBbynuSteRdGOKytIHVg==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85204369"
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.52])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:34:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PACFvfjryaFbqMTF1h2c6ul98UTCIPT9O8T/AAKhU9a3tAKWv2V/EZs1BwBy+Et8m00q9+sfj2wxqZakYoa9a1Ytdw88kIX/ly6DnDqTZsOZMoj65Oc2uPzgvsYu+E/KUTopFJNFxlRS7ARZ0jRiv2xAf7Qb7ZP2Z2LjXGth619wkvtzy7focoHvujsV8/14bbyjR7SGSSSIgg2+Y35pp3arH7xNHd9vU1g/cxiP/aFlGoDmnUogUEQRsvu4gKfVPRhVlsua9F7nXP1uXGH28z6YTgu8UNh402I2Aopwj6ahdt56Y/bA/VI/CfGk6eQWvHtrWgOA3q3sST+Axby6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oRmCOWLf2Vy7hYf9vsMi7AvXhoS9TgDe5SAT1ni3RttVOIPXDnFUkZd/G/7X+7Qz8wQ+ft3hJXoJrrAeUH+TvdMW8bzCCZ6xAY9jNh4hSjLmlhQCmudsdMOJ20BXxS3vZ1XXyXXHciRy7ODbIF3wSyxk1SDPKvfOSZ2wCit/OchaRsbavsLs/V77hRmuN25TpiRWuouiwQP+nh0SgGSv3j/dRf9W9FuDFwDKgpd2QO8kbywTFv8ez3PPr9nZxWRZdO+t6TiKcyJfMujp/bvkwjU9m6h7QU1ygrgQn5dy3e846Nvjb4gf3SDOeIg4W62ZhJy0vASNvVrzjlad/wLdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qgepPgFU4sWAqg9kJRuZjBhHMoNZzIELl5c425iAnPK8Nqb8cjrXA9N+5SsXcqV0i0hN/jikDECe39QOVvOdjWsGx2su4BrlK0wNz6gNocYz/E3TYMEdqaoouuCuTWIqZb32nDDwOzix7c9HdED9HDgWzP7Bq/v1lVHOjG3xsq4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9132.namprd04.prod.outlook.com (2603:10b6:610:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:34:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:34:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/12] btrfs: fix inode lookup error handling during log
 replay
Thread-Topic: [PATCH 03/12] btrfs: fix inode lookup error handling during log
 replay
Thread-Index: AQHb5RgDGelhP06eckuimbT5tYyNw7QTrymA
Date: Wed, 25 Jun 2025 10:34:06 +0000
Message-ID: <f3425193-147d-4348-851b-d83e98ed7fec@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <7d2c038230b7e735fede659385bbad19f85a533d.1750709410.git.fdmanana@suse.com>
In-Reply-To:
 <7d2c038230b7e735fede659385bbad19f85a533d.1750709410.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9132:EE_
x-ms-office365-filtering-correlation-id: de123fbd-878e-4e26-8ce1-08ddb3d3cfaf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHcyb2JuTit1bXlzcXFGdWFtQk9BYWZBTXNsZkhnK1NiSHlvWldQYWRVV1Fq?=
 =?utf-8?B?bi96WVRTc25Vbk1ReGtQQnptTEYyZWJvNlE5cVMvSGgyakk0YmRacTdQUzkx?=
 =?utf-8?B?MzV5aEx2ZW0zOHNESURtbmlsTkRqZUlDakpXUEdlNDFERzhGeXUybjlqU3pa?=
 =?utf-8?B?R3FmYUpFMGZYajBqOU9aOS91S3dCOXFXOUNQeUV3YkdPSXVYa2hsY1BIL05H?=
 =?utf-8?B?UWQ2U2lxRkdTNXJjUTJyNjMzckF3MGpzZzZvWlo5d3Z3SWZoQWNRcVQwTC8z?=
 =?utf-8?B?WktJWjVNL1JTSUp3ZmhQellRcVpxcDZTQUwzUmwrZytmM05nOVhGRXl4QVRj?=
 =?utf-8?B?S0RHWFZCWWY0bVpOSW9BOGUycGxKV1hCUWFqbWVtODZOMXNEMWVwN2puRE1m?=
 =?utf-8?B?Wk1iS0pCN1ZNVGtOMW5XQ0dtWkJDS04zck94dU8wMlkvdmdJWlFYR2k5UHBm?=
 =?utf-8?B?YTg0eTdLRTRSVzFobzV0TDdiSVJZWFlZUDFjQUg2Snk4VzBwRGNlUFlFWitw?=
 =?utf-8?B?Q3pyT1JTMHAzaGxueXVBZ1g5R203WDVFbVVKY1FqQ0dDMDJHTytMTk53dXNa?=
 =?utf-8?B?S2J5OWJwTTRsOFFZM2hYSE90YUdHUzdxSXFtTzV2ZFVjQTF2eVFPS29BTFc2?=
 =?utf-8?B?NlhOazZRajExOWhlbE53SjZjTzRwQ3Q5d25ONjJFSDNMaU1nVmIzdURlbVFS?=
 =?utf-8?B?QzhZdXk4YkVBRTZYQXJmRm12YkQzSXJ5WFZ6cmkvYTc1WXorekNuZzBxWS9m?=
 =?utf-8?B?R2hUeWtEU01xVmN3eC80WnAyY1ZXUDlHSlB4cU9vNDhHYzM1YTFMVW9nRFVj?=
 =?utf-8?B?bk43SncxSUphaVVCeDZwOSttZURpRU00SXAyOFg4SWd2VEd2Y2tnNmNmcDJI?=
 =?utf-8?B?ZDJKUEREY3RCK2o0WXZyZGhmNU11bVN4Um53ZklJWVA3eGovSGp3U2tXQ1M1?=
 =?utf-8?B?QnFySi9aOTlhVFMvNUlUTWw1bFlHK213OFlyNjVITnVtWkVxTFZFZ1BVZkg1?=
 =?utf-8?B?VXNCcVVyOFZ3NFNkM1JhKzZ1MkV3S0txRlprY0RralNDK3ROL3RLNW5JVjVZ?=
 =?utf-8?B?VE8vTHdwRkpnOXVEeGloVUprek43OFd3VTlwQ3dUM0RtZlplNjZhaTMyaXBa?=
 =?utf-8?B?OE5rRDYreVIyS2hnalJ0NzdZRkV6Q2FFSi9oVzdjY2dMK3lOaTNjVHArckxZ?=
 =?utf-8?B?T2Zzazg2amU0dFV2bEJoMmFrQS9zemJMTm9qdHVBY1lmOG5yRUNTaEZIMzJV?=
 =?utf-8?B?VnB6T1NTM3NOV016UHR0WEk4VXR5TGNnTXpIVmtPbkttNE92OWNTWStBaEd6?=
 =?utf-8?B?UUdRSTBDZ3JJRDZ1c05ML1BQcHVyWEJaY3huMVY3NDJwa2p0RDJyMmhWaWE0?=
 =?utf-8?B?S1Y0QjJqc0ZvRlZkMktraXY1NVlCR3pKUHFCbXN0Ny8yRTkvNXpPdGNTNkQz?=
 =?utf-8?B?S3BqUUJZQ3pnN3VCOTZ3UWpmZVh5ZjlrcU9jd3JySXZieTFRSnFoZWRBMmNw?=
 =?utf-8?B?ZWx0ZlBHaTdna1M5ODdrU2pjcFYrUkwvZm0zOWNFSXp3TVJaeGgyNk9Ec1Zr?=
 =?utf-8?B?aDE5S2dCYmVuRi80bHplV1Rqc1VUbVRrTUVRSWNZMUtnM1ZjVW5EdnFySjJQ?=
 =?utf-8?B?KzBtaXp2Vk9VdXdyM05wc3JsK01Wa0NZZUVWcVdSa25GdXZDb3ZkV0hzS1Ry?=
 =?utf-8?B?V0xBV29Ba0lWWE1wbjVNV3c2cFd2VDFhRmMwVHBSa2FMWjF1NDV3OUxDSndP?=
 =?utf-8?B?YVFSUFozbGhIditOSmRnaU11N1dCOHJQcSs1aEVldy9zMUwwN0Rya2ZNakFC?=
 =?utf-8?B?Ykl3TERNZSszWTdGUk1VVzR1RmlQWW5LbkQzOTB0OXNmUlVSODl0N2RRd2RP?=
 =?utf-8?B?aWVmamJpTGkxLzNOVkY0aDlnWnBnbWo2Z0p2c3JQeW5wNlpTMkMzMWpORHF0?=
 =?utf-8?B?R2x6SzNLUTZ2bmdwcHFvdFhOSkdFOFBlT21RMFJ6L0V6VnEwUkFQbVFodzJN?=
 =?utf-8?Q?l5CVgsiPGskl/8k2r/gWvo9h2uPhVw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGFIbFVjdmpxWm5OZWwxclVRbU1rbEIwQTl2ME5nallRM2s2MjFhMHRTN0RR?=
 =?utf-8?B?ZHNzS2FxNFMzdUlyejNscmUzeTJoeEFGaVgvVjI3L0pjNXlrdkdjOEMzYlkr?=
 =?utf-8?B?QzNDMzZQTU5ieittL0lJWWNXcncvUVJTeXJBSEQ4QUpORXBoVExZUFZJUjJ2?=
 =?utf-8?B?R1JuSzZDczJKNys2UGFaRzFBN1lGeUlYUzB5bDI5U1k4RHFLMDR1c0hKK3VW?=
 =?utf-8?B?eitvWXAyd3VjOC9velFvS0Q5TWhJRW5pN3E2NERxSEpJc0QwSmpjV3BmNktv?=
 =?utf-8?B?RTZFZkxuUnlTWXdEQlBEaGpQazNzUmdPYVpIVXBKZnhCM2FDT05oblB1VXFB?=
 =?utf-8?B?cVF1aWwwWEVuRklrOTFoUjVPbmZJa2s0VjNmblUrMWZzK2o4R2JMZkYxOElk?=
 =?utf-8?B?NHZLN3lNR1BnbFREYjZaVnc2SUZ1TjBuY2luWUk0WTdBSGtTS0d5TlNITkhN?=
 =?utf-8?B?Tk1iWTB3T1Y4QzBMNkpFRnVJMVVVN21BNlU0ZkRLbXpZaXdkWkpmS2dYQmN1?=
 =?utf-8?B?Z2JzWlF2b2NBWGR2WXNXK243Z0g3bk5SYmxMbnRYMzFvOE5qS3Q1eWxDQ21u?=
 =?utf-8?B?SzJnR0UzZVVRcklMU1NiR21wOU5tQUVpdWl0Q0NaRTErcUprclpoSktQZFR5?=
 =?utf-8?B?UjdTUkhUZTBTejhXYmdBRDRROXMyV25COTQwWFBrVlVRbkN0SlRWUlZoc2Fy?=
 =?utf-8?B?KzNndzhjWXd6cmxheDFBbjB0SGRiTzRFNjh1THRiOFFGSEsxajlkWG9id29G?=
 =?utf-8?B?TTFsNERkdnB6bHBwRWhkaDR1UEhKMTJMSVpONDB3S1I1OWxxelg4NEtPbnFI?=
 =?utf-8?B?eWRvRXc4VWlEZzVzT0dZWmxKeWVOQlhJK0hFUThUZktuQjJYdEZIMG9WbGli?=
 =?utf-8?B?QzIxR1hvOW4vTG9uajhTOS8vUDJQdk5YY0N5S0xWdk5sRE5BTEljekErZUtr?=
 =?utf-8?B?RHV0SjRzc0RhNUJxWW9nWVJQclVpWHZLRklIbzZaRWE3cGFzRGtCczYyYTlw?=
 =?utf-8?B?azVtSmhNL2x0UERCMWlzcUVXall6OUFvZ2FXenRMRkNCYnVQMStyVElLcldl?=
 =?utf-8?B?Ty9wQ2hwWWdtdVFXWlgybmdiZTN6Wnd1cGZaSkhZcnZYNVZSdjBMbXF2UnRn?=
 =?utf-8?B?YnFsUGc4MGI1aHBLVmovVEk3V09lM0llQ0V0eFF5NFEzL3RUQjV1eVVGRS9X?=
 =?utf-8?B?VFlxQ24wc0dFd0l6dmJVMHFRYUJaU0wvSkhTeE5xc0ZYZUdneXppWlc3MjYx?=
 =?utf-8?B?TG5iOFN1WUMzSjM1OHVWOEZYTUgzSlZ4WllnK0ljZVA2RlJyanJJSys4dm5i?=
 =?utf-8?B?QldHWlFSVmRIdWdWakZkVlVZL1E4UHNXcFI1Qm1aTFpqbVhsa3VXenE3NWUw?=
 =?utf-8?B?NWdZOGpwNFA2OUNiQmdqSGdXYkN5K0RYU0VVZ05lTzJ5Sk9wZXphaXpaUVp5?=
 =?utf-8?B?YkdTZHZ4ZDNOb0Rhc2ZYUWxoSjdNSFhCR2VvNVk0cWczM1ovSGhGM2NRS05T?=
 =?utf-8?B?aW05OWsrTFZLRW9CeTYzUkc4Nm5aYTBuQWNLVlVudEhhQ20yeG14bld2Z1hm?=
 =?utf-8?B?eUNSOFR4UVcxdXhhTkIrMnFITUZ4OVdWR3d3ZFNVSkhkbEJrYlg1YU1NK1Jy?=
 =?utf-8?B?cm4zVXFzdnZGUzZJdzBXNlpCUDY5ejh6OGJtQzlQamxCMFcrRWx4eTNpQlVF?=
 =?utf-8?B?cU1Ua1VlalpUWk5LbUNjSDhDb0pxWWJkRDJ6R1ZLdi8wWFFoU2lpZHhmcmJ3?=
 =?utf-8?B?UHEzMFQrSFRKOVFBMHlTWitVbDdoTU8yVkZnTkRQdDN6T216YWR4UlRwNVA3?=
 =?utf-8?B?TmpDR3JNdXU1cHk4Y3BHMW9MVDQ4cGkxTk0vNk5PeWZ4R2JJbTVZMFR2WDhr?=
 =?utf-8?B?MWNmYzdkRTMyVUhRc29DU09vcGxRaVRLRkdBYTV0TDJRS0tDbzd0YmxLd3hz?=
 =?utf-8?B?NnNKSUhxb0xRTVVpRUQ1bjFyT2Q5RmpQYk9oYnlGd3NoTS82UWNrdGlyUTY1?=
 =?utf-8?B?TXUvNEZoZTdlR3lqaWxmN0FLTzcrZThsUzJZUEVkZnpjUG9mbklXQmdFL283?=
 =?utf-8?B?OHpVbi93dVhIU0h1SVJ4a0hMLzFCQk80TGlKSGhLL0pmajdlNHJ0aEpLMUI2?=
 =?utf-8?B?R2tISnVQcFhRUjcwRWtMYUloU0tYTGpzZW9IZzNlQ0dEbnZGM1ZrZjNWOXNJ?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DF3B7C0A7DA324881D0999B7CAF3549@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SxY2MfKF3AR5mvv0A2bGGPFk5QT5K33oXDpYEhGD9rAaMW4T1Sxu+1enoLOxHdgq4SR2wiF00+7HSSDTbY0fbOAEkW9cMaDytHPneM+LXClrakF75nBpQKs8DdCtMNHo7cGFWolfO+r5FFSOSuxaYS+zsSmejfvQ05FY+VbEBdGYwMHSffXHxQPqx0v7zQl1j0qoj4hX+Pp2RityyaPjcNWUdHsyo4ezMTSjT2CSJbgX4FULUaFJ9lMBinWiBSq9JzSyE0Sdfk+v/KqUaDmen3VdwH0WhVXDaqi4gSE7rFrgJ2jpBAKZqspYigoxKOXCoauSNYJazO5sI5Oe/RQIN2REDPQzzqBdRh56ZcmoFNTvkMzl6XvWvqwNi38IGRjvvXzQAKF7nUezsRMQfq1cyMLbVKkPT0gRF3mLE6J/9+QfFBk6uUEEJOvqG4HONY6exao63Wy9Cw4yHxIfFgJ+OSqgVqpMSEykQCXRR92dIYjE3ZobiwBqagUNW78Alhq/GYWvIb3WB7sMoYsrj6wOUCB8XyApupsKuOgeE2p4iHWZ50Z9kASxsBP9640SfyZwozVv2t9xXt7f2Q/arfXWZoTAXp4nl7kJQWQ18h320PkWAeJAgLDNgmxRLezHzhKN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de123fbd-878e-4e26-8ce1-08ddb3d3cfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:34:06.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNbuB0weZVGsjMPI3z6CC/I4KucCXqduGMGg1v6P4/xQoo34oh6dosCMGhT5SoZCGGL0qvo3yFkSZLZHKYweQMNghJjJpeFojSd9yIZtxt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9132

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

