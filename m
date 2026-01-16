Return-Path: <linux-btrfs+bounces-20643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16926D3849A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 19:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CD33093B3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC134AB19;
	Fri, 16 Jan 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hIwPqJr4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LTHqDkZy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197120FAAB
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589189; cv=fail; b=Sw3CftB20wU3nHQDLfGsJH5YFFpCDN375zrcqAJXp1ZRoizQOnWaE2uJ1RwYtT0u0fhmIcS4SwX+IGSeiqWfHZWJKIw441RBaV4JV/ut0yLJlm9vqOw29gt4E6kIYWTcFiBBKB2emvY2d14lozCgiJncAFuIaGss1MgMwTFmLbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589189; c=relaxed/simple;
	bh=41e5/liqch791S0jQDBV9iaJ2L6exXuNDYzhnAnkHfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2NrsJN+MyxkjCPcguejZ3RekiN6qjZ9nQsbKMD4caoXq7zqa421OoIz0YftG2qWrwdQ3JfrtDU7Y/rfmKkGJRLdu5fWIRwE+7z5vAAhZyfjjuLDOXrKrXpalxHj2KtYNFv4GcUBoWdzkYi/230DSKaX46VWpSdoq33vSRsjvAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hIwPqJr4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LTHqDkZy; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768589188; x=1800125188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=41e5/liqch791S0jQDBV9iaJ2L6exXuNDYzhnAnkHfI=;
  b=hIwPqJr4SJV4+A3qIDhlHdTVMhLtqjlXael0jrRNFd8AVtwwq7Q7dVlO
   RpRU5Ihmq9IzpozF+UUi6FkkC+RHCarL5L8fKC2a9LwKVkEXptzQHOott
   Cq4ZZVN+EH7HjThnat1wzCoYVvtW8KIlk0ZUrmS5rJKJyaSqkacySOHlW
   m6Q6UI0LdZoxKHk0ZG5LulWm+mECrnuznupDKp5LxjAkaxmRqFqV93yen
   ndbksOrcGXQ4l3738w0YYMJaAnWjB4Ak5fuYQZ/cHV2XvIVCEUPKV4pQb
   H6Q2/NUKB+CP+9MuEO7E8oanzyCeM07v3GYzZqYm59kh32y2C/hobr13P
   w==;
X-CSE-ConnectionGUID: hlULK7gnQQaBitFOcEH9Ng==
X-CSE-MsgGUID: b4kdk97vRuiPc+8z98L8Sw==
X-IronPort-AV: E=Sophos;i="6.21,231,1763395200"; 
   d="scan'208";a="138938982"
Received: from mail-northcentralusazon11012043.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.43])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2026 02:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe7e7kJDUjnEoh4XomstSHhwfW7X3GR2sYO5mDjvFGGnrpCaVPo9uAyQW54WEG1bRhUURlhXed2Nh4XjYZTBfQOqeLZXtJBtyS2mzzIbys69XspXvu/Fp1pGw9+I+PL4RrFbig1OCyD3QwGcsv45vaDb27ObuJXlxhTEgadz25nVFjgqPGCczd1gTADTPjCwtDlpmqdSuzqyTHG2iNPeVDK3eJlcv5OhqRLDK9FvUL4y3I/jX15fbNvh/+XkAWpYZaagb/dRXI0cGMOcuLxX9HY94ioWEOBOUWBjrXlEDgLAPyxcEwHAg1UOr5I6M8jxqmq9dGkpHTf5Z8MVYNDW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41e5/liqch791S0jQDBV9iaJ2L6exXuNDYzhnAnkHfI=;
 b=qncPS9pwXIXCEyL/aQ982Je92iaus/aFywaExovQ0EMdCKb77+b7FIjT8YIS4Vu59GPIDwbGkzZ7YsR5ylxbUNcjW4Kr+YZGtr+JnCuiYlfys7yXrCG+F6BMoGb3RHKmuCc0eGJz4r0Qaahs5Jkscpj8OJWecLzYMGWUGGDX0YJtbJvqdKlIZFXfsLT7+ZS8jHZola30ldHbIOziibXDZNjkRCSuAddCpDMV1yDQMlXS9KuL1WrtpPqYFyhKwdYILeMh5QA9Fta+27ZSChdWJ9y0cAEdgTJe3MJVK+W3TGhJc/NLCffqbG6ng4HDlg9Pi/WAauYjmgj4iLLqcUKRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41e5/liqch791S0jQDBV9iaJ2L6exXuNDYzhnAnkHfI=;
 b=LTHqDkZybs1CcbCOqyMsYbZbWPDcFsfedsFPGA0hRWH4lxoWualZilfa638ssJEGlPXbjRKS6NvqGJO96IoVNcoRZ2AvVIrapZc3b6P4GW5N9nBJb4J0IvccGKRlQEEiCyVF0BIlD7PRYf1asPBdkZZjh1JsMR2RT566eHhmQcQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH3PR04MB8863.namprd04.prod.outlook.com (2603:10b6:610:17c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 18:46:24 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 18:46:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, David Sterba <dsterba@suse.com>, WenRuo Qu
	<wqu@suse.com>
Subject: Re: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Thread-Topic: [PATCH RFC 0/1] btrfs: don't allocate data off of conventional
 zones
Thread-Index: AQHchs6WdTS/LlRXy0CW/Vom7BYol7VU4mGAgABA1IA=
Date: Fri, 16 Jan 2026 18:46:23 +0000
Message-ID: <9a37829c-cc94-4d4a-b732-834e1c68cc2c@wdc.com>
References: <20260116095739.44201-1-johannes.thumshirn@wdc.com>
 <20260116145421.GC16842@lst.de>
In-Reply-To: <20260116145421.GC16842@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH3PR04MB8863:EE_
x-ms-office365-filtering-correlation-id: 73acf6a0-c2c2-416d-030a-08de552f8c5c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmszeDJsNzg4QXpQa0JzU1VpeHg0Y3ZTNFduWUZLNnd1K2JyKzBhYTR6YjZ2?=
 =?utf-8?B?OWRYcmYrTDFCTUhvekI2azN0ZlFJdVFNTGc5ZmpBS3hSMkw0allQN1FpUHhw?=
 =?utf-8?B?YkRQcjN3ZGdqZDdzTUJxYWNSZjR2K3dreTdUeVNubjNPQzJDSDBFd3VmcmlE?=
 =?utf-8?B?UU5LYXZVSjZkbnY5elhsSVYyQ2VmdFZZdEM0V3dhUERtTWh1Tk9GMHhQN05o?=
 =?utf-8?B?ZDVmaSs0V2xsZnlzYUtFWU5ZZ2IxRm11bUEreUczZUVyaTY0Wm84SEJ6d24x?=
 =?utf-8?B?ZnZTSGdNQXM2TEhlYmoyZllWbE9rRjBKTzN6aW11MjJKOWE3QnhaYUZ1b0hS?=
 =?utf-8?B?dWRJaG5aWm1xeS9IWUZRUCsrYWQ3RjR6RlloemJ0SXJvaXV5K1VsTnhmRkNB?=
 =?utf-8?B?QUVnTGhMbXFOYmUxYXhPejVCa1YyZXdDVlNoVVMvYnA3aEtCMkJsSVB0ZU82?=
 =?utf-8?B?N0xlT2VQS2FRamVqVTc4ZjNVeTVlOWVycUtNNnE3YTlBVkp6R0xlWmdNRjVW?=
 =?utf-8?B?RmdpalB0eXB2dUM1eTdtY1ZVL3IxYVdQUnBreFFTejdNNTUxZnUrMlRiVXk0?=
 =?utf-8?B?bzRYVlhabFkvUU5Sb0xmdWVEL1lveTIwZm9wQTAyRUlkY21QczgrdVNENW9h?=
 =?utf-8?B?enpkMEdCZVZGdGRTcUpidkhwUHpXSlBwSmg3VGlJUU9xb2hCTThrL2lpS0tz?=
 =?utf-8?B?aEFOeElsSmZUTkgwZUxEdGJMVi8waDdHV29wZDhKOW5FcHpGOGJnNUhQLzNW?=
 =?utf-8?B?cTRCL0RwVUo3dVlGVC9XQlJ3ampXQjh1b0tIdDZlckpPcDVaWkwzL0J5ZzRT?=
 =?utf-8?B?RXdaeVJXQXFMWHo4SGZLT1hQQm1jNnNkd2h0enFwdzRuS3F2bjU3ai9uZEM2?=
 =?utf-8?B?QWJwVnJtRkg2Yko3Ri9qaFhVWWpLc0Y3TVB6T09OeGZKK096dDUydDgzdjhY?=
 =?utf-8?B?UzRuSitGUnpESjJna3M4OEJHUUsrbSszMVBJaUoybWZqOTBRUnlNNkJiUzZI?=
 =?utf-8?B?RXlMNDhHaFZvVG15TVFSYlBneTlxRitWSzVKMHJHOS9XU2xqNUN6YUlFeHFH?=
 =?utf-8?B?RnQ4bFdPT2dMMVdFZTQ3cmMzd0FQdHhESHVsTEx5VjJpa0dEOW1MTU9nR1hG?=
 =?utf-8?B?K1dDY2dkSEFOT2xweEg1aE83UTg5TDR5L2R4TlRESW9PeHBDSERvY0RVU3ZJ?=
 =?utf-8?B?R0NXNHBGSWhWdDBOeUtaNXByNTNCZlRHR0ZCMk05N1VRSkdNVkl3V29xYlZ4?=
 =?utf-8?B?K0dGdkFrR1J5UThtWitvc1E2eUV1cktvZ1Q5ZFhuL2lsaDRwbFcrbVE5bElK?=
 =?utf-8?B?Zm8rdGs4TmZwRmNvM2pJbWhvWDFTZ2w4Y2pXMnRQeVZwWU94QlR5Z1A3bHNV?=
 =?utf-8?B?eWtMY3p2anRoeVRMODBjR0E2N0RyVHNubHpJSWQxM28yRHY3ZmdQNU9WclFa?=
 =?utf-8?B?b08vR0V5dlZUa1hReFBaNzQrSkdRWm8rb3dPYnhFQ0dWM2pJYWVmT0xIZ0w3?=
 =?utf-8?B?cjN0RXFUeW9NQUIzSkdJVWdFVy9CblNZSTE3SmRuWlhVejZsdjkwbndtQkNZ?=
 =?utf-8?B?eWRpeWFpZlhnaCs2TFljc01DRzVKaFpFbk5YS2JpYXJVeGg5b1AvM1hVbXQv?=
 =?utf-8?B?emJxV2oyOVdmd0NMVHNzUmlZM2UralBOamVORkFKVnlzK2JzY0VRNXZLSkdw?=
 =?utf-8?B?eVVSSXBCWmJPN3FoUVBLOXJiaEE0ZFd6VitnT1hKQUR4bVgrY05pYm9XWHVG?=
 =?utf-8?B?S0cxVmtVOFI0bks4NktaK0pqbHJJMWRDMW9VRWFYOXNiTjNhQ0JBVGNzV0lY?=
 =?utf-8?B?Q0lQYzFYOTRzdUdqTDROVklNdkZ4WE14MXJTWWthQWYxM1FzbkpiNTR6TXU5?=
 =?utf-8?B?ZmEzL05FenRxcnhtT0Y0T3cwd2Q3KzlkNnh3L3hJS1VWODJRV1lFWE1VQnA5?=
 =?utf-8?B?UW5vbFNlOXVtU05mNGFTelRiQzQxZy9PN2ljZStZaE4rSVR2bkdZTUdQZUFh?=
 =?utf-8?B?U0I0V1dNWnI2bjJoVzNSRkJucEtIUlNhdzM0Zkxhd1FWWFloMDhsTVFMSUE0?=
 =?utf-8?B?RGt2aC9CWWV5dHFzZWV4bDZvZEorcDh4OUNycSsreDBlem4rS01yQ0sySW54?=
 =?utf-8?B?akMveFpMdlR1TkxGM1A3cXZmMWdFWXlZNEFxT1d1RklSV2tON3FVN3YxZjlL?=
 =?utf-8?Q?1074QSTH5NHAcPKmnpq9Jjs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1hScThLZSt5YlRVdlI5bjBnOWhnRnpWS0ltc0hGTjJ1cDgzUTVnZlIrS20w?=
 =?utf-8?B?ZXJmclNrYWtEMUVnMVlpV0xZMGxudExqQTJvd3dpRW43ZVRlcTFqTDZiUVNm?=
 =?utf-8?B?eVQwaVVyUWVLVzRvdHJTNHh2VWFvSGJqMlVnQldpMkV3ODFzRm1VTHZaRjVk?=
 =?utf-8?B?emhUUjY4RldyYmV2d0NNVEhlaVAvckxtN09vN1FJZnVLaVRWZUsvQmZvYW9N?=
 =?utf-8?B?MW12V1dNUnhRWTl5Z3hOWFRPanJ0aXhxWW44bWl1Tnh2Z2R4MXo5WVpPbVQ3?=
 =?utf-8?B?NzZGcTBlVXh6VFQ2SVFpWnFPREhsRUF5M0l4Y0FMZ2tiMGJnK0RoR3FtNzBw?=
 =?utf-8?B?ZUEvcnhFWS9Sc2NBMUVWVHZpNXZuQXhlRytPMm1JQlVoY281eDI4L2oyMXlR?=
 =?utf-8?B?RitPQjRRMlMwU2crbUJmTXhnelhnbDk3TlArSWVGSHF1NjAreUZTZ2V1Z0kr?=
 =?utf-8?B?U2cvNkdzUWZIemNjSWZaSjRzTlVxYXhCdnVQa1g4N0hhWDJ3c0UvWW9IL3kv?=
 =?utf-8?B?SmgyZnJGa0dvYlRQQXdwVGhzTWFCaTdvYjBqRzlTL0RaaEVnWnFwRng5R1Rx?=
 =?utf-8?B?SXB4UUZVenVlRS9Tb1grYTFLTWsyZjdQSTBjUFNxd2h2WUh5WWxoSFphNDJs?=
 =?utf-8?B?WFNKUXBmWEVldjJDMGdpSks2WFZ4NFpVVDVrMmpFdUg0S0RkM3FLNVpMemlt?=
 =?utf-8?B?VFFWeThjczI2Ull0TGlRVkcxVE5iYlRCWTZWREVQYUxiSjIrcm1TelNuTUJs?=
 =?utf-8?B?Uk5zK3g5UmI2OGk1RjU5S21va2pNRG1SNlZPc2ZXajZpemNEeUNTOW45UUJR?=
 =?utf-8?B?NS9sdHRhd1lwWWI1blAwL2REL1NmejVQam1zU0F1TGNGOG5DUlZpZkdrVitF?=
 =?utf-8?B?R0ovQnVvcm9PUXRKTFBuNE1COTI1RmdLZ09NczhvRkdLSGFEVUtSTU8rYkxo?=
 =?utf-8?B?WXZPbk9Nck1tVGZWVkhTdlFjMUdsbFpkR3V3VndpeG1PS3JmRXpLWll3TVB5?=
 =?utf-8?B?dURwb20xQjVPK3Y5WDhDcTdTcFA4eGVrZVUyUEwrYjlmcG8xUlNWNmwxM0Z5?=
 =?utf-8?B?OFhVYnd1S2U5Sm0zeFdpV1NhTHRmUys2ZHVqZzZIazh4Qk90ejRJWmV3aGNK?=
 =?utf-8?B?QmNTT295OEhwSDI5c3hRYVh1bXdIQTdGZUNxQVpnQWUxT1BQR1AvMmVwdHFa?=
 =?utf-8?B?NUo2aTRjZUxOd29IREpvNStMYUsrUlVQNVNkalFPUGN4bjlkU3NzUk5oRkEz?=
 =?utf-8?B?TXpmdzdGZEl1OCtVblNEaEtrOWFYUzNCMkdOUXp4dmxwc3pZNk5VWHYxdUwy?=
 =?utf-8?B?TTIxYlhZZHdBM3FFcHJ4TksrK3d2NkRXSmNzdEQ3S3dWa1V4L3VyQ05Xc1VE?=
 =?utf-8?B?dmtTU0E3RGs0L0N4MlN1Z1NEMjBITlgrOUNYWTZxVGRnT1Q4TURzbGM0OG55?=
 =?utf-8?B?K2hlNHRSLzNpajBHMDRZT1M0MmtWQVJnRFk4WHVmbjRORzI1eVpSM3JRUFFu?=
 =?utf-8?B?bi85V00vODBhemhnamZYMzI5aXNhZUxqZFV4VWduT3QvMnUwQXVpUWJQeDBJ?=
 =?utf-8?B?SVd6aG05bEJINFRha0pOSE5UZitTYTJzaWRBbzZHblpxMDROVmM5aFVXcWxr?=
 =?utf-8?B?UUwyVW82TWNlY1lvRm4rQWZYRTlaUUdYb0htVEFtZ1Q0bG9ycWNuODVETy90?=
 =?utf-8?B?WVMxbVowUUViM2w2REJjb1dyeW9TY2JwakMyS1ZiYkJhWlVzR3Z2VlUvTnRR?=
 =?utf-8?B?eWoyWDl2T1dwSGF1a1hSTy9tbytNTURIcHB6bHZocnI2M3d3VHBkMktwclRt?=
 =?utf-8?B?Z2hJeGN6ZEFFRFdpWE1DbGRpQ2lGUUpaaFJ4VEErWGs5ZktKK0pERkJIYWx2?=
 =?utf-8?B?azdEd1FReWVPd2x1aUtFaUU2OXV4ajNlbVdmWWN5K2hQZGVkdnhreFFOZDFV?=
 =?utf-8?B?QkRDRVFrYzhCNmtQZU40NXVSUE5BOXpocjVIMnhiU3IzWndNNndJOHhmNk5F?=
 =?utf-8?B?cWVjQWZ3K215WldXb1VyMWk4djJpNUZGclgyamtVMmduamFiclZHbHRtYVA3?=
 =?utf-8?B?R2J0YXJHNmVOZnAvQjJ5R1JJUXM3WFBLU1FPOW5DL0RxMHFnU3BuQnFVa1Fj?=
 =?utf-8?B?d2JYREFaRG1SdzlwbGExSWJlekFGbHpPai9sZHlaL1RzZmZ0ZENYYXdmVjM5?=
 =?utf-8?B?czRYS1FCU282WDNKbkhjWmF3QlBhMHhKczhSWjdXeHlrWDZwS243YlZ4NUtq?=
 =?utf-8?B?ZlVQYlFDeXFCeGJObGpFMUhtSmlwRkFhK0I1V2Mzb1VWbzEzMWprQnphZGRu?=
 =?utf-8?B?WnpvbTZxL1FZcm5OdlkyR2FsY25CWElCZVA0ZzNQTUhKOU5KVDNsbkg2dm85?=
 =?utf-8?Q?yenPPVMf75apgh6rL/VvzzBmpj/OdwBPZdgY2X1LW9xui?=
x-ms-exchange-antispam-messagedata-1: H1Q5O66+Ax2EZLz3HVWiGMmeCs+mjxk7qKM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E65B9CD35D750F4CA0272E42037D3758@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	93uR0oj4OTpcGJJ3QE67IW497p4HolwG2hc/5du94n9Jnj9OuSX9bW6wNyTeLwzBGc9bOdraIPIDulPIaRXE0jUmlP4f4/wYfnCvDsVeHIgUOmR/iriDu2tV6kxjhhn/LH/FR8l71NJPX2w5BUPXSHQM8D7rilYPLZL5aEVCVKEUVK/znuH8p/hmiy7yOsZNVjP8g1JR6YTjHLU8aPEkl+JzMykq4Oa4Uzoj8R+vlrVT+GSS22ixjlfR2WnFgkTOyc4EFSZHxDcuYF1bqHyTuqZldqreydTj8QM8YuQE9QtwqUH9ctnrZOmx7GUOl2dEA4E3M/qPeHMZbtgJulTH3Nmnz5EgeVFFwMeybcqsFys3Vzz1m1SYy0lM1ws4hxXGJ+2qtE6aixmon9ilJZPvyV95YLsrBFxdGoRBFWYuGOGgcd4pAakWU2kWTvPH+ARln/87qxmpdjxOMco87I1e8K6p38rs/KX5HMz/8fBNLjQaRgbL37C8nYaeAeyUU+Fsb7Mz7+up9LBQS4gM1amsicUdEWQdkUs8tak2aOrGanov6HGdGxw5rhA2pL9xsVPpyS/1OgP8b1iD+LL98R1VZfzff4JEfuJEc79D6SNNl4Sp9Ez9KKo0ZfUbHJ6ubFqn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73acf6a0-c2c2-416d-030a-08de552f8c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:46:23.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6MW7i3jebpdkkoT0meeK6JyrItTiUgXziElUlGL3Xb/KmUgZYZOnR8vE9z9C7oXFioKdW1lr0mMWk5SnKOVQpNCCjfFtsfUn0zmnYv6fzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8863

T24gMS8xNi8yNiAzOjU0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gRnJpLCBK
YW4gMTYsIDIwMjYgYXQgMTA6NTc6MzZBTSArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gT24gYSB6b25lZCBmaWxlc3lzdGVtIGFsbG9jYXRlIGRhdGEgYmxvY2stZ3JvdXBzIG9u
bHkgb2ZmIG9mIHRoZQ0KPj4gc2VxdWVudGlhbCB6b25lcyBvZiBhIGRldmljZS4NCj4+DQo+PiBE
b2luZyBzbyB3aWxsIGZyZWUgdXAgdGhlIGNvbnZlbnRpb25hbCB6b25lcyBmb3IgdGhlIHN5c3Rl
bSBhbmQgbWV0YWRhdGENCj4+IGJsb2NrLWdyb3VwcywgZXZlbnR1YWxseSByZW1vdmluZyB0aGUg
bmVlZCBmb3IgdXNpbmcgdGhlIHpvbmVkIGFsbG9jYXRvcg0KPj4gYW5kIGFsbCBpdCdzIHJlcXVp
cmVkIGluZnJhc3RydWN0dXJlLCB0aGF0IG5lZWRzIHRvIGJlIGVtdWxhdGVkLCBmb3INCj4+IGNv
bnZlbnRpb25hbCB6b25lcy4NCj4+DQo+PiBUT0RPOiBJZiB0aGUgZGV2aWNlIGRvZXMgbm90IGhh
dmUgYW55IHNlcXVlbnRpYWwgem9uZXMgbGVmdCwgYnV0DQo+PiBjb252ZW50aW9uYWwsIGFsbG9j
YXRlIHRoZSBkYXRhIGJsb2NrLWdyb3VwIGZyb20gdGhlIGNvbnZlbnRpb25hbCB6b25lLA0KPj4g
b3IganVzdCBFTk9TUEM/DQo+IEhvdyBsaWtlbHkgaXMgdGhhdD8gIEdpdmVuIHRoYXQgYW1vdW50
IG9mIG1ldGFkYXRhIGJ0cmZzIGhhcyBJJ2QgYmUNCj4gbW9yZSB3b3JyaWVkIGFib3V0IHRoZSBp
bnZlcnNlOiBydW5uaW5nIG91dCBvZiBjb252ZW50aW9uYWwgem9uZXMgZm9yDQo+IG1ldGFkYXRh
LiAgRGlkIHlvdSBvciBhbnlvbmUgZG8gYSByb3VnaCBjYWxjdWxhdGlvbiBvZiBob3cgbXVjaA0K
PiBtZXRhZGF0YSB5b3UgbmVlZCByZWxhdGl2ZSB0byB0aGUgZGF0YSBmb3IgdmFyaW91cyBzY2Vu
YXJpb3MgKHNtYWxsDQo+IGZpbGVzLCBsYXJnZSBmaWxlcywgbG90cyBvZiBzbmFwc2hvdHMsIGV0
Yyk/DQoNClllcyBJIGRpZCBoYXZlIHRoZSBpbnZlcnNlIG9mIHRoaXMgcGF0Y2hzZXQgYXMgd2Vs
bCwgYnV0IEkgdGhpbmsgd2UgDQpzaG91bGQgc3RpbGwgYmUgYWJsZSB0byBhbGxvY2F0ZSBtZXRh
ZGF0YSBvbiBzZXF1ZW50aWFsIHpvbmVzLiBXaGljaCBpcyANCm5lZWRlZCBmb3IgWk5TIHN1cHBv
cnQgYW55d2F5cy4NCg0KPiBLZWVwaW5nIHRoZSBwb29scyBlbnRpcmVseSBzZXBhcmF0ZSBpcyBv
ZiBjb3Vyc2UgbXVjaCBlYXNpZXIsIGJ1dCBpdA0KPiBoYXMgdG8gd29yayBvdXQsIGFuZCBoYXZp
bmcgYWxsb3dlZCB0byBjb21iaW5lZCB0aGVtIGJlZm9yZSBtaWdodA0KPiBoYXZlIHNldCBleHBl
Y3RhdGlvbnMgYXMgd2VsbCB1bmZvcnR1bmF0ZWx5Lg0KDQpUaGUgbWFpbiBpbnRlbnRpb24gYmVo
aW5kIHRoaXMgaXMsIHRoYXQgd2UgY2FuIGhhbmRsZSBtZXRhZGF0YSBsaWtlIA0KbWV0YWRhdGEg
b24gcmVndWxhciBub24gem9uZWQgZGV2aWNlcywgaW5jbHVkaW5nIHRoZSBhYmlsaXR5IHRvIA0K
b3ZlcndyaXRlIGl0LiBCdXQgYWdyZWVkIEknZCBuZWVkIHRvIG1lYXN1cmUgaG93IG11Y2ggc3Bh
Y2Ugd2Ugc2F2ZSB0aGlzIA0Kd2F5LiBUaGUgc2Vjb25kIG1vdGl2YXRpb24gaXMgdGhhdCB3ZSBj
YW4gcmVtb3ZlIHRoZSBmYWtpbmcgb2YgDQpzZXF1ZW50aWFsIHpvbmVzIG9uIGNvbnZlbnRpb25h
bCB6b25lcywgYWthIHRoZSB3cml0ZSBwb2ludGVyIGVtdWxhdGlvbiANCmV0Yy4uDQoNCg==

