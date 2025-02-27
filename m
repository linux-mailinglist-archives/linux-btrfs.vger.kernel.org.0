Return-Path: <linux-btrfs+bounces-11899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE78A47746
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 09:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D203B688B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24190225764;
	Thu, 27 Feb 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pZ+Go7bR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bH/25bVz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81624224895
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643483; cv=fail; b=YLamkOI8h0Mw5Adtmn2Ycakj9vo7P6e483bs7UjANdxUDlbmN9GcK6WEmThetJU2I/YpvMbIuKvOcoqyXm5x4YCWaXqJE4YG89FHKK7boW9CPy6yV9vwQ3fLCVGpLo+/AbZjVWDwF9cwY7o+TQkWfXGS3ZFjPwMwAVjdV6QMOBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643483; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+HrzU7a/nRnkD15/STKaxNOmaUF/+17WFrSUscUO+aW/I+5pxQq7GFx8wX8QvtIa6jm7Vvwazq9WjIIyIl/Rzov5t9tSV5lNzSOYmqwYkmTUUvOWVJVF2XnNnoQ6opNwpYjamShFyF4PDmj0WmN3u9FbvUXTxkIukuHCcYZqTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pZ+Go7bR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bH/25bVz; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740643480; x=1772179480;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pZ+Go7bRkQoBY9yJfZTpeXsFg8FW62Gw/KRlqz8WJjbZlZYlCsbDPQYG
   9GeoEXiA6eKvfKL4jSJ2fCdMNdpGUJE3ur9ftUW3YJxcmUuASQzXFvMMJ
   XbPSMksiRjdr32OeVY6VxKYtjLs+l8QmEabLVK2h85zFYa0DEV086xFDE
   ovA5Jm50P+/atGw8iGxR38Lrk64CGFHDloCKoO1bXac8GJiIrCTGy6Om+
   EdFNGKfFjh+7V/dWcYF5CrnXYyHm2hKqbf438oWgQC/pzeTzNx0T+pwGM
   2qwf2dlbYQZOmymZf1NrcDey1SWGRbQu8YuHjsVCNdgkSx2h/Tt6xwBIo
   A==;
X-CSE-ConnectionGUID: 8HegPdgxQeuHE/7TuGai6w==
X-CSE-MsgGUID: 2d/F1GkHQbuiVJPS0Toqhg==
X-IronPort-AV: E=Sophos;i="6.13,319,1732550400"; 
   d="scan'208";a="40605819"
Received: from mail-southcentralusazlp17011024.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.24])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2025 16:04:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXwWbSY4GOUls/pPkxs4RMTJnHWtm9SJtl1OLwX7F58tSLtIP2+V4z8N/Nr6NmDHw6BAz6tnnrqbp950RIA1xAVUTdlGopNKns+RMe5r/1gWqvqQkwYvC47YX4yvcdv9x6ZZOG3hLYEli9AgpiHujyvEdO7kubN4LeAYMMeXW3TTuRiWUse8EachbpyLNBS5SUQYp7uv8LGFgKucp6EHp2KJoI4GrUxbth/5cC1+mQuB9RIzE4CYIobpoxBehEo89C0kPaiQVpBNzTY3Hu/nxj6Ot95lV2MOH72IYkM67n12TMP2SQXhk6jyTFN1wnVL6T4mloiMwGY7eqELW8dCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FHUQOGiZPCrUmaL53jj/v52w36UmgA3OAqSdhkOoWTE8qZ4PkLviqzLMGpdpr/SHbe6Y/zZ2OixI5ReDbw8ZA4LrMDUVeaqjeq+lA+dR4na7AuldJYKWhMZYVaZVv9EyVxvJolUriwDynxNab7rXsk7WOML55CKLRigpAnAih8ZUBF0ywQVw+KHFbFFprLbXyQdvmBZySrJQ5pfEmapV69NSty9zgxrX8eG/20DGdOiPgz83xdYmVb50vhfC+iARrsvTw4D+NF/74ufHPt2+m5HeVw+2YqzlqUiN5vTIer9GrGuL2breEMhCWZQCZBowgr67kVt0EEJcgSGsw+7oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bH/25bVzfyTDWQO5yFwLQa7W7OQHCCgUbxVYoDsWFaSiaNzLfiwzScpOlbxjaPP3pVDi+GL1ChWMP013IFA7+Fn02HwFwxZ8X0y72oc+ibMazPdBxf2ydv1HknMhlby8kw5cMgzbFFw2q4lkwDkFJO45fpO/l8Oou/J30uVIFkM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8979.namprd04.prod.outlook.com (2603:10b6:806:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Thu, 27 Feb
 2025 08:04:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 08:04:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: simplify parameters of metadata folio helpers
Thread-Topic: [PATCH] btrfs: simplify parameters of metadata folio helpers
Thread-Index: AQHbh6HEbrfOt3tBm0CyFnCG2s4K2rNazTMA
Date: Thu, 27 Feb 2025 08:04:32 +0000
Message-ID: <13ceb981-1328-4d0a-9a32-7823f8df42bc@wdc.com>
References: <20250225161648.27512-1-dsterba@suse.com>
In-Reply-To: <20250225161648.27512-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8979:EE_
x-ms-office365-filtering-correlation-id: a0d6b22e-fd1c-4f90-9d9a-08dd57055e8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkJkRDFrdFlZZ3FTWDZkZVI4N1lNVVVRTmFDRHR3NjlyNlJzMVRpUFEybjhv?=
 =?utf-8?B?RUtQb1h6RzlwZnBFMExqTXBoclRuY1J0VUcyK0cvc3FhRW1kNXpHb09NRkRn?=
 =?utf-8?B?VVBpQlEwZVZ0VitSQnRIZU1rUDAwMW1LYTExdGhSQit1RjAwM29HZDFGcjBJ?=
 =?utf-8?B?U0FzRFdyRDNzRzM2dHMwV2ZMR1I2NHd4YTNTczR5bUpVRHBmQUtRS1pGR2xP?=
 =?utf-8?B?cnpCcG1zTzJ2bXNJSGFaVjJIcHlBczdnbFhxV2tLZUUzeUN1cHJuMEs5MVJU?=
 =?utf-8?B?NnU1VGszNGVjYlJEMko3T1U5S2NuTUFNTzNmYWtLTTZRU3NINWFadGxWb3Fl?=
 =?utf-8?B?NGtCSFFJR1l0amlIanZCZU55WFRSOUR0cWF4aFVPM1c4UzNmUTBFd04wL2Np?=
 =?utf-8?B?bmtCcjNVdTV0dzMzdEhRQlhnaUdremhId1IvN1pPUWhGQ3FkUlBlVHU1cHVq?=
 =?utf-8?B?bnpaaUpGdEdxbS9pM08rVFdqNUFndzQ0M05VVzhnNGxDS21JaVRVaHVvM0Zp?=
 =?utf-8?B?cmovQlNGR29mYzRWaktxcDdHRkRRN1VQaU0vbUVEOTRYQTVhTDc4cWpTR3Rs?=
 =?utf-8?B?TVBDT1NtMDJPSzFSSVl4V2ZZNVJVK0xIMjV0RUVKbzJVckJRRFNkeDhJQ2R3?=
 =?utf-8?B?TGYxZEduQWZpV0FSN0Nzai9NTlYzRUNLYkVQajd2RnpSaHFXOEdtckJkVWxM?=
 =?utf-8?B?ZksrQVpMY1NjVDY0WDJZMlF3RERPNmFNbUpobU04c05LMHhSOHlRcSszczg3?=
 =?utf-8?B?VHM2MkRta0Y0T3RJWWVlOTkyNjEyait5cUpxZ0duclRFOHNIOWplSXFtL3Vl?=
 =?utf-8?B?L2ZLeXhPRUdnVHZlS0pabjJ5NnJPL0dqdlRYQk8wbVZOU3JwcitlSnhHSFBh?=
 =?utf-8?B?WEovWXRhcTBsaDkrMk1iMVUzdzdiOEM1U1I1Q25kMElEWWZsU1d1aW9lQ3Js?=
 =?utf-8?B?RFZMWFVaVE1OMVIrOEFCZGJsL3dCZW14ZERweDFKVENScW00UGdaWFdHaUhk?=
 =?utf-8?B?NjdUbzIrMW1kRTJJNTQ5VkRaZ0txRkFNT0VOZGlMaGZCTzN4UEs3MWg5ZE0x?=
 =?utf-8?B?QmpBUURDZXM5RTMvQjBldDhyZENqT2NHSEtCNWZPWWFRUSsranRTMEVNUnlU?=
 =?utf-8?B?YWkvaWhNMFAvSnJsVzgzV0VpZXJ6eU9OcHFFVGhiaVZLNzVmSndsRGJ6SDls?=
 =?utf-8?B?R25qMm1hOU9CelNBZjdiNkoxbk9SaURFTjg4ZEdPRWlkWVNCRmVsYzN3WW5H?=
 =?utf-8?B?ejg4Wm9yV2crcjFrc21FYnNFK3ArL3pYUi9HcWFya3hqTGVvOWY4aVQzamg3?=
 =?utf-8?B?YXlkaFpFT05NSkpMQUx1TlVxU1lFUVZGNjF5NHNxTVF4Wmhla1hXb3RIOXRp?=
 =?utf-8?B?b3hNMEpsV2VJM1oza1duUzNwVXpMdUtYQ21aWWc1MnBKTU9IZThkcU4yRWhQ?=
 =?utf-8?B?cDNxVlk2NGVoK1lVblV3WkNNQmxxVDJKc0htdTd2anRmMHZ6VVR1ODRiOUVP?=
 =?utf-8?B?WWUvQjZzNlExNHVHblU5QUVlWEZOcTJHWU5lY1FpYlJ2eE5xTGFqQlQxS3ZM?=
 =?utf-8?B?dnNkRm40Zy9jZGZoYzNDMm03cWpFR3IveTBsWDhlWGF2U0poS3pBaVZJQnY1?=
 =?utf-8?B?a0dPQ3pzczNwakp0YkcyeGVyMkZFSndJeHl5bnRPMXMwYU5oNnA5bEdEYmtq?=
 =?utf-8?B?TjdmN2tLTjQ1clo1cFpmUTlqU21OZC9pNEhWQXd3RU5jdXlHOERsSWlxODlv?=
 =?utf-8?B?bklKbHA1K0hsUmtkOEt3ZG40MXlkQW9NVHhXc0pFRDZ5U0hHejZOekxVbHJ6?=
 =?utf-8?B?cFhVUERqL2xVenVaOGtuaUVvbWt1U0pEZXlWY2lxY0p2UFpkR0pXclR0VWRm?=
 =?utf-8?B?T3pvYnA0S1A2enpXMmt0YjZwdDFHVnpiZ1lxaUttS09sQmU4djhnT295WXdr?=
 =?utf-8?Q?zJAG3iIBo5S7H0PAuMh6V9m0KkxMzJRZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q09OOVNxcFRtWUkxK3FGQXdyejQ3RkZLb3BjY2dmN3BBQkU3VlhjVGNpaUkw?=
 =?utf-8?B?dVZWSjNiSmFZT09ub3crNEp6b3JDVzBYdXhESXNYZDhrcXJXVGxnTEo4eXBo?=
 =?utf-8?B?NHZnOW9LeHFNaHR2b1FGOWgvOUdVSDNqOXE4ZWlQdmxXdW4vSWV3NEFYV0la?=
 =?utf-8?B?MDUvdWQ1Titla0hDZmQwbGwrYXJYZEV4dEdUMGwxYjdiOU1OWVR2T0IyTmJM?=
 =?utf-8?B?RHFmQ3R4bC9yYTlFUTZqQmJhMDBUbnhEelViNFl2KzA5NjhqdzVQOGdHbU9G?=
 =?utf-8?B?eTVuaFVuOGlOeDJCV21EN29QUmhQckRxUXhzQ2pIS3RHVkNuemNUOU91eUVX?=
 =?utf-8?B?VXdiQ3QwMjRQUkMxSGRvcG1GQ1MwN1NGTUpqZFNNRXNDS09jQXpEb1FnVDZx?=
 =?utf-8?B?T3ZaZXR1MEJPRFRtSGxmUUEyRnkwRDB3aTZ2c0ZrVnBRRE16bWdPQU9Vb1BQ?=
 =?utf-8?B?WldEanJ5YnpLOXFoVlRSakVCYkgrUEVhV0VXVU1Wa3BhcVRrTllmR0lVTE1O?=
 =?utf-8?B?L2hwRTcxNmxrb0c3bTlDNFNTa2Z0aWs4Q0lJTks1SXJjOXowM0tkb245cG5O?=
 =?utf-8?B?NWZvSUwxYTl5M3RFMjlVRy9nWHc0cy9CZVpsMWlpZThlRS9uUnduazBuYTJz?=
 =?utf-8?B?eXNJamVNRVlQWU1GdkZFVDlRNjZRcTlOQjVvbmdyWEpYeTVuYU85UHV0cnlO?=
 =?utf-8?B?c3RDY2FINUlOQURaMzFYY1RLUmQ1Q1FrUXR3QjIvRU0vdWRUS1dscnZuOFJr?=
 =?utf-8?B?TGxpK2lRam0zVy9MWUlXQjF2QmpHR2tTNVBRWFZLQnY4bE9rdHMzVUovTmZK?=
 =?utf-8?B?STVkcURPMUs2bUpGTlFBSVExZDY3MXhTRTFydFN0NU9zendtdWwwY0FBTmlM?=
 =?utf-8?B?S251SGdhWXg1OTRSdzNWU1Z0WjZIRG0zYzkrY3R3c2JyZTJwNXZkL2JaU0po?=
 =?utf-8?B?T0grUVlXK2hkcFdZd1l0WmlVVmhGVXZLbFZ4YndFZjJKRU9RdzUrYUNzalg0?=
 =?utf-8?B?NWxTNjlNOVhzMTl5OHVQTUhrQkZ3TFlhc09yZW5UaXY1Qmgxdk01N0JoQnJ6?=
 =?utf-8?B?MHQ3cEJRQXI0YzFyTDhlTUhXMXRhcWJHRFNPTmhnU2FuN29LM0xtLzlFR0JP?=
 =?utf-8?B?U0lHMEFDbHpyWmYyMTZ3ZGdaYlZSUDRDNEJyZnB2QUhyVHZFVmNUTHpJeVd2?=
 =?utf-8?B?UHpNZG5GMERFQlhCbW55R1lMbzhIaWRGZmZpNDRRSENZQnJ2eEltdUMrQ3Q3?=
 =?utf-8?B?M2VteXV2Sm5XbGRpeGg0T0FkbEVSVHlnYnhGb05sYWUybFBpZ2lDNTdxbmhG?=
 =?utf-8?B?QWR3MDNwODhtUlIya1VPL2JNR3poT1Zta0VVcEZSeUlVZndIc2VkaDZYcnZW?=
 =?utf-8?B?ZU9tVUtnTEtsNmJBdnFRUG5GekRKcy9CVW5HM1J6Z2thT2VaZ0J0WmtNcmlr?=
 =?utf-8?B?VFJ2eHdkU2VIZ1BMTXpESStEbTdRTjYwYUJsZWJUNzFjczFEazRhNERqUHhN?=
 =?utf-8?B?ZXNWeUhPSlR0N3Q0L0NydFlwMFFxMTV6YXVVMURyZGtCVkFZMEhXUDI5WStO?=
 =?utf-8?B?Z29nSFl1dXFFTjdVK1h5Vjc5U2F6bGRUaW1OL2NHL2poWXl3ZEcrb3QvR3h4?=
 =?utf-8?B?YjJ4VEN6QWFTUSt4UlV1YUVHRmpJK0NYV09PRVQyNWlZQXFaUmFBT09xbUs2?=
 =?utf-8?B?QnlQeHNYZUVsekF5T0pHc3luMkI5cTBaNmtzR1JvMGExZHkwT01HSitTQjZB?=
 =?utf-8?B?S0krSDUrWGs2UU42YkEvRjJwZGRDRTY3a085M2JBVDFLb2k3aHdVWVhJUjhD?=
 =?utf-8?B?ZW9MNHFFem0xUFV1K0VZNU04Um9kV2ZnampIL24wQmtWdllTQ25HdndhMFd3?=
 =?utf-8?B?c0pQampKVHR4OGlmSWRGTXN0VFRuTmNveTZ4M3ZtR2lxaGZQUjNVNjh6RFh2?=
 =?utf-8?B?T1ZPenJIVkVybUtPWVJLeGd1VzE5VkdNYkFyZzNKZjhoV3V3U0RudmVwMjZ3?=
 =?utf-8?B?NFlMaEd3cHJoU0lkc0Q5V2VsWVJ3cHdLeWw1U0Vsa0dJUjUra3BHZGF5SFFV?=
 =?utf-8?B?K3FQNzdwTmNVdDVuU3NBK2Z2bnU1V3YzMktPdGpMVkNTSFdWbHFDZmlUS1l2?=
 =?utf-8?B?ZzJTYTZrVjFmT2JJeWNra1J3MlprM1JKQ09TeWZiNStENmsyZFQ0U0w4Z016?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F427924F9949B543974DFC426F6FD149@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoXWZ3/myzkaCuSQSOsa/iuDEbK7nO0fsJdXDsEBuDYx5ydY502wpUi0WHI/YXS2/NQfepQkpA8I1E73BCt699BkYfuTauzllxLbxiRopOfMCvdIel+KgoXMArDcD4YI7AAwUQ40P/woem3qIoVz1LCpu1x25GwAZvrnCuRvkmWxZh7mjRES+uMym4w6pdKJSFabgl25h6l8qpF187fArKMx/PH+l+bEEVx3eClgttBQERYfSmlmLSrriIhfXq3qqzTrlFBrb5hFBakRtmIAepsaNym+R6jiCNAE3bhQ0SabS/QSyAEWfHP8CJnm15ZaWkZ9It8WocIknFN8Gkn4xzH1YE4UEvsGkceZcWrS7pr0cjJFHTzbylITbICmYGHTRazvqqSrreawQG9Ft3AT03Ltw9Mw3wEYTVSIoqRzKbqqUcudBQPyCvEN/XB+Ulb6qDdVu8Hyh0sJm/e4EBiJhtQEp+l4G/i1j0bB1ybYqKkpkS22RFRO4tuYhIi5GJ/vM2YYTtNRlmXd5q4X7FUlcQf194keghkY4hs1CoESkjG+w20tG6ske56VywUmSbfYkHpL/WdE5S4+cSnQKHU5v0Qy/+R0oX3jzFpdELvLKNcazCfjxWXekOo8SdqqMyUZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6b22e-fd1c-4f90-9d9a-08dd57055e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 08:04:32.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGiKfdwDlyC4Z1CSf9iFHVGic2qryr8Sk242GisWGqOs+NO7PDyK/bZ3OrsNP2L7kcmFQ/UaiUTVGb8673kva4uzvhULa4/vBV0hQa6OQk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8979

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

