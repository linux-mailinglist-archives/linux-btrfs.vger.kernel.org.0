Return-Path: <linux-btrfs+bounces-10990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D883A149C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 07:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4663C16AFA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1B1F76BA;
	Fri, 17 Jan 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fm9A58Em";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W9SoLlGE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D421F7080
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096298; cv=fail; b=B2RdGtFspX1bVHnIp+zS4gLafky87oBkAmSBllhwl/GGN7gHJ+Z79EK5CzBKH5FGytO1bh01ct9RTqnqIUxgjtkaALafQiyN3NdkGsSdhICzCuDS7krGoCLnWwwSutZiWvtcIEdZm/rjMRUQhMs/Q0vBgcvDGAVWWHeVIjTAKk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096298; c=relaxed/simple;
	bh=vxxfoKNXs+ibikuywk6ZQuu4+v/BENw2Wtyt/kJx9mE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQo/RGyg41yBuH8DDV/FUo2GIr+4XGK6L2ZFCsSPBgpJv3MjTXjkDbemQGsETtc413Rp7S/B8B2G8rm3N91ICqrTEzhI72Lt6dEG73qGe/h7PH8XeBNCDbXb91x2ByVlH9z2DWmdnF94fHoumFcugAi2X838aNMYQZddIrwYthQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fm9A58Em; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W9SoLlGE; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737096296; x=1768632296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vxxfoKNXs+ibikuywk6ZQuu4+v/BENw2Wtyt/kJx9mE=;
  b=Fm9A58EmQqPiqUtsH5avk03zMqXpL9YLpzypuuyB8DrZ0O5QqFr5ic2Y
   m/MFu6cJ3irwcUX+uRAP8e172FK5xbhdjqcF1Dh/8Wgsfy7TWXu/RTAmm
   3o10vBS8SbiOsk5B4ocrh7SQxBuH8BKICpACnEyfmOk8rJ5zPPDrP86Xk
   GbaKd32RLz39o7Bz51R/jvzIsrO1IrxscKO7UOL1S6SYa44kpodOPupRt
   aGMgCKCTpUSzHyVLcDNXvQ3NGvPeuC4BASnHdhVfaQIIB1LIyexietuK1
   Tj1gcH1q92BS7zNzS0SqwmTmaRskV6zDdjXsDz78umbILcvXHQvNyMB3m
   w==;
X-CSE-ConnectionGUID: 4wb6dz27Sy6YZ/DkG3wCdQ==
X-CSE-MsgGUID: 0YjpLjDCS+6N2XLkq21D0A==
X-IronPort-AV: E=Sophos;i="6.13,211,1732550400"; 
   d="scan'208";a="35535228"
Received: from mail-bn8nam04lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2025 14:44:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBGyPhdRYvW72CyBkifWlgOx6awHJTdTyzvf2EAMJJJxF3LnnEOO9WJ+dYjW9hdqR6qyYUHpEWLnqZWNDizfHhXb9EnfDpUS8loebAEsHrgdeWKjYjAjWiIdbNwd8eQyDY1JXIEURXGRFF10poEvYi9IzaKAdyoq/A1q7uHPcSK/2ezfxnD9o6GL9C66GQkGCRqrePaFG2392z1bqJ+OzqGNdWEfT1xgVbHGVa7FD3Dg/99VbXah1h9WViXMqRCSRjVRdpo1orMrVSYpWHOBnkRmMSVEV4lq3Y3Odqjz8r50w/tRdf1a+LWIOzJoYyVuPuN5BZiC+tMItX4q+NP19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxxfoKNXs+ibikuywk6ZQuu4+v/BENw2Wtyt/kJx9mE=;
 b=ev+eMVdvl4OIf4xOx9IG3zBcBCrHK35WoJJV6Q0hDKKX3Avf0qk+BBLD3MDGP8/UIigyhrLRXXJQaryt7xbbRkWVavWPkyVcwuxUd04FxQKPDPs0pDX6u3/ob+0b/HAR4zlkun8/dUZr6/nnAssQbzA2+y9MJDc5rayNhHTx9vTazPbDn/37bYS8PileQ9GOD8aJEnJ7dRyKnhYMG4FmEqXvIzlCmcAglSHzQVaUqSFYbMDDLcsSroHy4VsA09HSvqYCckni8qvbzClVFTgYtpp85HZVLKPk1NOTJaNY5DZ1Sq/45j8uivfZ7bIcQ7EwRJPG+avpgkmJmzLjwOGfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxxfoKNXs+ibikuywk6ZQuu4+v/BENw2Wtyt/kJx9mE=;
 b=W9SoLlGE8e80L1V8QbFy3aYWmuxYRveTE4/uZnuzDuPr1pad/6s2JWu3pHK94vXOsuqLNME8oZTPuJUH60rOSyBx+Yalk4laSbNnAB4mm4H6VtEzlmiiOi4G8jLL1UPzsLz30hVgvpthJcQ6UY8JGSM/cy1wBeilmVVwDR11PfU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7626.namprd04.prod.outlook.com (2603:10b6:806:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 06:44:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Fri, 17 Jan 2025
 06:44:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yuwei Han <hrx@bupt.moe>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] zoned device can't properly start full balance
Thread-Topic: [BUG] zoned device can't properly start full balance
Thread-Index: AQHbaIOc2GBW5txcYECJRhGlQ5ArOrMahZGA
Date: Fri, 17 Jan 2025 06:44:47 +0000
Message-ID: <e13a009b-f221-4c1a-824b-cbdf3fd3f82d@wdc.com>
References: <FC80D8E2329D01B2+8728a519-d248-4c20-95ad-91750de9fc88@bupt.moe>
In-Reply-To: <FC80D8E2329D01B2+8728a519-d248-4c20-95ad-91750de9fc88@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7626:EE_
x-ms-office365-filtering-correlation-id: a84a8de2-9cc2-4a60-a5e6-08dd36c26f6e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zjh2Wk85Q3NWQkFjdjQ5enlXVFF4ZTBCaVdVOWJlTkMrend6WjUzMVZsMkQr?=
 =?utf-8?B?RDR6ckFDN0x0eWZyVUQ0UU1RR2ZpQ2ZURXI5K3ZGbURVbkVnTkRtVUo3bmhU?=
 =?utf-8?B?bmlXS09hSzhYUmdRckZIRjhJaG9vUmVQQllLa2ZmWnBYYllZcDVVbkJxZVd2?=
 =?utf-8?B?bG0zYVdDRDhFazdSSDdRcE5oSlpkblIrc1YvUHZZNFFMRHp0amk0TDBTcC9m?=
 =?utf-8?B?akpCQlpxdDFQdHZwV3dZRVIwUm5uL3BnNi94dkNzME9wcTVNaGNPN1ZtQXVP?=
 =?utf-8?B?REs3eUtLb3Y0SVlXbGN1ekRzWDdDY2xMSnRkS3FIdVRvM0hDLzlQdG8weHZ2?=
 =?utf-8?B?WU1Tc3hzd093cVFGRTJPNW5MTEJZQUVyOWM1U1M0eUM0bkZPNXNvd2Q4a1la?=
 =?utf-8?B?R2tLYXVUZzRMNmM2bk02bzNHTnAzSGVnekhYNVB0QmJHeC9vRXRseEtPNC9K?=
 =?utf-8?B?NHBzL1ZaRXhERS9KWFkxbjdLMnB6a3dHVnZYN1NTcG5oUm1qb2o1TUhjOG1C?=
 =?utf-8?B?akxYYTlhMFlrSlJGcEI3VVhaTkNVdXBIdysyendYNjkzeTVMMWVUNFl3ajhs?=
 =?utf-8?B?VTA3U3RyaEJFOGd2L1pxaWlUQkhSL3Avc2ZyUkFqOVFiM2cxVzU1OUhTc2Zz?=
 =?utf-8?B?K2NtZnBoK3BWREViN2xHcXp6QjZUa2QybkdUZzllbmVVTjg3N3hnL0hHTDRp?=
 =?utf-8?B?V0NZdHZ2RTJGdTJNVXJVbWc2L3RTdlFUVnNwRXVCYkZobWJ3SHJ0VjdUUHI5?=
 =?utf-8?B?Wm5TVFJ6M3ZkTjRJdmZMWlJHYTJXNlFCK0VFRW5xNkhJU1JkODhGeWp0dmY4?=
 =?utf-8?B?bVVEbzdBZ2Y4RlQ1bHk2THh6VGM3NUN5anNiN2VidmhzcXVkaEREMGx3WWxw?=
 =?utf-8?B?ZGg4TjNXK2hhdEtvbE1IdnJRVFRsZ2NoeVR5b3dFVkZCd2diSjJLemdKRFZs?=
 =?utf-8?B?VVB6WEk3YjNlYUQ1RkR1UGlMT0tiRktzN2MxZjlxNEYwdVpqVmdXelRsODlN?=
 =?utf-8?B?bGpITEdOaGtra1ViRGNrbUxSb3A5TFA1c0M5ekgrOTFsYUl5ZlJxdE9qekJK?=
 =?utf-8?B?ZnJLRzk2Mnc4cndLVXU4VGhxWC9RVFpJZDRCNEV5cGFPc0Q1OERwUExKd1RJ?=
 =?utf-8?B?dmd0WkZyMll4WnZ5cHFuZzhZTlRhSU9rYW1QYTAzWUxRTHlZRXdTNDhtVjN0?=
 =?utf-8?B?bVZTc2ZHbTkwM3pXNXk0K3VnV0ZaWHhDOUIvbFYvbW5Cc2RJVEhlSTArc0Nz?=
 =?utf-8?B?UnNlbk1EcEVwRmQ5ZWgwTVRFN2V2aDAxVVAzWlBQZHdHOE1NRmxxZHg2Qjhx?=
 =?utf-8?B?a2VSYXArV3lVcHhMbTRaZ3d4SkxOSWpkZUJPTUwwKzJIaUtuOVlnSHRyOE41?=
 =?utf-8?B?TlByVmlOeDMxemxQaFYyakZUZzlCMUZuZTM0ZlpPQTNTVTJxSlFyRzM1Ty9W?=
 =?utf-8?B?QXlrTXgxL01jakoyVDRDM1ExWVpJRHVlRVZnWGxVSXpiWnQ3SjJtSzcwem9N?=
 =?utf-8?B?d3ZrTmlGUHZBYzNzczJmQ0dmWnIzeU9uQ1d5b05rbG9vMnJ6VnRKRmQ2UWpx?=
 =?utf-8?B?Tkd6cWtLYUoyYWx0YjZCUk5OQkVUT2xHRFdRUUNxc0RoVVR1cDJOdGZDOEc3?=
 =?utf-8?B?dDJBREsvdWh0a3hyRkZLYzNKQXhJeGRqdkUxaHIwMlljUGE1TUdhcnB3b2hs?=
 =?utf-8?B?MSs5UzdLKzRVUU5Oa0pZM0gxTElqcVYxN0p6K2NlTEFHcy93QTZjNjk3cXRr?=
 =?utf-8?B?OTBORXhlRkNSOWlJazl6d1ljVnVxV2g4WXNCcWRNc0tHUlRJRkNCeGp1SG5M?=
 =?utf-8?B?cXVnSThHVnR1VFB4bTdtYWZsWTloRmNuMXR2ZGR1a1V0WUdvV0g3aXdPYk12?=
 =?utf-8?B?bUg2WVJvdkt3elQ2cGRneE4yeGZwN1FTZVZTKzFxL3BqMmNWeVJsV1I0cjNr?=
 =?utf-8?Q?vkKyCvjpzs/vn9LWZOoabQd74557oaPy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDk2cnJUZ2g1djM2dkhKM3hTOTNCeTM1cm5RS2xGNmxVN2dLNzlTM1V4L3hH?=
 =?utf-8?B?WEdRbVZJOFk3KzhqYjQrNGZld1QyakprUkRhNzdDRG9wTnhFMTBnOWYxTmJq?=
 =?utf-8?B?REZvRkxlL1hBbXI3MlZkT3VJdWl1c0ZuNUZyS3J4YzlpT09BQTZaNHJVK2Qz?=
 =?utf-8?B?ZnFFOEthTHFKeGtaRmNmQzg1Q0Z5THN5QnNrTGMzWkQ4ZHA2d29aaXBYNmtn?=
 =?utf-8?B?K3F3c2FVK0pndi9GRkU4UnUwU0NPdWM2M2JDVVRreXlaSjkxZ2p1TEg1NUxS?=
 =?utf-8?B?ZktZTkxlWDR4a0xJdG1GcFZjdnFFMTI4YXhJaGpNNFo3YTUvNnc4emJORU55?=
 =?utf-8?B?eUlnc1FUMmJ6SllFOWx5K3FEc0ZVUThFWE1MZzVYcVZzNWpCNXh0VDE2aXQy?=
 =?utf-8?B?blRZNmdBcEpmclBnVU10MXVPT21HVk1TYUJwOW9FRGI0blAvM3BrSGdyYWxy?=
 =?utf-8?B?WWFpdGxHeFBocy9KMnI5dzlZVFFPbTMwK1dSalJWNkRQYkVJK0VTdEE3R2pS?=
 =?utf-8?B?alplMVNGUUsxUTI2S2kxUGQ4QlBOQzh4QzQ5NG1WeHlYQnFRbFVIczZKMTcv?=
 =?utf-8?B?UjFGNnNraEpGaUQ0aUJFUG4rNituTTJxaS9ZZ0d4N0l6L3dHeG1nL1RzMS93?=
 =?utf-8?B?VnU2OWJ4ZDU0YmxpSVFJUWpmZFd0SkwwbVIvamxOOVlpTkNqdXk0VGtrVlB0?=
 =?utf-8?B?TXlEVTI0ZVJpZ0VRT0pxdWx6U0s1WDRPVjhFci84Vzk3MVIxWjhOckdNQVY4?=
 =?utf-8?B?NUovdjh5YjFxZ0RtcDNRR0lJOTdJTURRMHY4dkpFSlZ3SVBPL0pqNHZaSEp5?=
 =?utf-8?B?d1pHVjdpWVNwVDMycE92VHk0Q0Y5bjFWK2ZuV0EyY1pnTmxLeTI0czFJLzVP?=
 =?utf-8?B?L0ZtczRIZjVLa3JqWEJGOTRndndMUHNTYXk4Uy9uNzVQNzRpS3lPOXN3NlFH?=
 =?utf-8?B?OHhlMXc4YWZONExKdFI3TTRYUVV3UjlSbWN0MkptbUFlQjNMRVJkVEdZZWVN?=
 =?utf-8?B?WVBKemhhS0l0d0ZCZHZkTXEwTW85My85dmVGKzZIdWRNa3BTUWpTM0hRc3Fk?=
 =?utf-8?B?TEVWUENzV0VTK05CamE3bDI4cTU2ZVJROVc4TGV5WU85VDh1NHFLS294WEJE?=
 =?utf-8?B?eHQxdjBFUlh2RVdEYUZKd2RKVWVPN0FtZkZ2VG82aXA4cUVlbmRTblVNaEpv?=
 =?utf-8?B?c3o4aDhjb2RxeFpKRHNFNUxRRnhPL1hScnpKQ3lYWG40d3BuZzgrRVJMWnlR?=
 =?utf-8?B?cWhleVRlZ2NFYzJxT09DRlV3djBRUENiNmlOQWt0b1ZmMld4UlR6OU12d2M1?=
 =?utf-8?B?SDQ0UXpSUzMzaTRWOHZaS2V0T1l2UGU5YWtJL08raXJ6T1hNeEs1M20zNENT?=
 =?utf-8?B?MVd0enptVnAzOUZIVjBZVHMxTm40c3dTNUd2eXNtNGlKLzU2eStVTVVWemRC?=
 =?utf-8?B?eXFaTVoyTitrV0ZhUmIxMkNPak1wYzJwOXExcndWL2t4Njk4Slc4eXJrSmR5?=
 =?utf-8?B?dnhlcTNEeENlTDNWZlVpcVBxYUd0dGlYR0VOMUJvVzFpYkozc3B6cHhPWlFR?=
 =?utf-8?B?ZlU1L0JneEhXRTduSXJEOVlLaFpTMmx0ZHF1aGdkZlhSTlhCemVWNEQrVXNx?=
 =?utf-8?B?eE9qWitudXpaUHZTWFFzcnF3L0E5RlNJN25IUUVXZVZ5UFkvclg4ajBuVFpx?=
 =?utf-8?B?VHBqd1AvbjE2Nk1xZzJ6YU4veWU0bGl6Z3hrUFR1MktiaUVpQUFtQmZCY0xN?=
 =?utf-8?B?YUlmN3Jkd2FXMVpybnVoNUZvMHhENmo1WUhyWlJyb2ZLT09mY2tYaHo4a3NL?=
 =?utf-8?B?WFZWUFZHTlRiOE1ZdlQxbGNucVlmUlNDbzBxNDVPdzRKZ2RTRUU2TmNqT0Nk?=
 =?utf-8?B?VnhEbFpqbThrSUk5QVIrdGRZa2tVRTBqWFE5RFZzcTBuRGRhcFJyeDdYKzBN?=
 =?utf-8?B?d1VORE1EUGdKc1RTWkRROTJ2S0Rrck5HSlFOMGliZDRQd0FzSjlHM2d5ZkNH?=
 =?utf-8?B?WDA3all5d3MxR0MwWThhL2NIVDJjSEdzVHBLV0ZxemtablZZYy9nTWlzRE9s?=
 =?utf-8?B?bXl5S1psbFRNY0U3MXE0eHE1R0FNOWJkMkVDZWdXb3FrUmdqMkdHbFY5WE9r?=
 =?utf-8?B?Vk5NT0tJcUIyNFVwdnZoaUtvQm5rTzhrQldOL1hIQXk5aTJnT3JQbFN6b29x?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89396446820D1C4F85C6CF2CE80FA6E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	znXWyM5df7TFVONpjkokB4CxCTYBkYrTucvA1CX1dPdkskZQAmVpoiMXl/maUipWTdBFLMC+/oufNvH+EgQlxqhOb7vc9RWr+bg8eZjCHzIJJtPqm6F74L1eFJvIkpXElF3XEoKOjCZv0Molpl78yMTlaVly0RyZaS/PzyWQEs9IMteXHCFZUk1U02E2nMmcb5fZyGcTNZ1jvpxxvxv4cDzSG8bcjfDluFnEbZUF+hC73xgRnwo3PGSrbFj6qbcuxp91oSahHBYrBq34i7/7puUg1VbilLyUoHScy72RpsmldQhgb3y/7qTsyvtti2bh7f017rgyP7ZHPrLgNxbFXzIAM7BhBxxI8wIzDmAEz7mBf/2ng7enYmZHO3brGudPucDUyEft64yIOwWw4zxD2e/MzyBONXXX87Ua3Et6lDIY58pZy7J5dvJQR4vcEB27gJRrA7jfVLv/jTykNIXDF/39V3Ox44zjR9NnrAhV/qzjSvwpszVnt0/LUPrsXMTA0xCO+fFaFD1eEyjoxn7pcExFFgWkLbpovoRFyoTKpkM5aPUzdnNbG0yq189DrlY1i/XGjLpa7Bmffn+/+lZpxmKqnAELUb0135i6leIJY1WPW1+oqmbucZ3jFaQ7tOkl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84a8de2-9cc2-4a60-a5e6-08dd36c26f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:44:47.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRIKbeHhqfekJ+CDSDJZ15JybZnYNCZgXJAM5v6PFCyM77UO+9H8xnP3aBpi/Zg2zS0WRwQb5WJBTYZmYPK0aVeWnw/Kgfy0DkAlMRdLspc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7626

T24gMTcuMDEuMjUgMDM6MDAsIFl1d2VpIEhhbiB3cm90ZToNCj4gWzIyNjExMDIuNjA3NzY0XSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogcmVsb2NhdGluZyBibG9jayBncm91cA0KPiA0Nzg1MTg0
MTI1NzQ3MiBmbGFncyBkYXRhDQo+IFsyMjYxMTAzLjUwMzY2NV0gQlRSRlMgZXJyb3IgKGRldmlj
ZSBzZGIpOiBiZGV2IC9kZXYvc2RiIGVycnM6IHdyIDUyOSwNCj4gcmQgMCwgZmx1c2ggMCwgY29y
cnVwdCAwLCBnZW4gMA0KPiBbMjI2MTEwNC4zMTEwOTRdIEJUUkZTIGluZm8gKGRldmljZSBzZGIp
OiBiYWxhbmNlOiBlbmRlZCB3aXRoIHN0YXR1czogLTUNCj4gDQo+IHVuYW1lIC1hOkxpbnV4IGFv
c2MzYTYgNi4xMS4xMC1hb3NjLW1haW4gIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBTdW4gRGVjDQo+
IDEgMTE6MjY6MzIgVVRDIDIwMjQgbG9vbmdhcmNoNjQgR05VL0xpbnV4DQo+IA0KPiBBbnkgc3Vn
Z2VzdGlvbnM/DQoNClRoZSA1Mjkgd3JpdGUgZXJyb3JzIGxvb2sgdmVyeSBzdXNwaWNpb3VzIHRv
IG1lLiBOb3cgd2UgaGF2ZSB0byBmaW5kIG91dCANCmlmIGl0J3MgYnRyZnMsIHRoZSBkcml2ZSBv
ciBzb21ldGhpbmcgaW4gYmV0d2Vlbi4NCg0KQ2FuIHlvdSBzZW5kIG1lIHRoZSBvdXRwdXQgb2Yg
J2J0cmZzIGRldmljZSBzdGF0cyAvZGV2L3NkYicgYW5kIA0KJ3NtYXJ0Y3RsIC1hIC9kZXYvc2Ri
JyBhcyB3ZWxsIGFzIHRoZSBmdWxsIGRtZXNnPw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==

