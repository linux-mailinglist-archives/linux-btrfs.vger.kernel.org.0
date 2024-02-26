Return-Path: <linux-btrfs+bounces-2800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261BD867AED
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585E9B37752
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DF130ACF;
	Mon, 26 Feb 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kf/qwLJW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U4qTHeS1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8111BDD8
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960076; cv=fail; b=Pb/+obNCgniSebYn5opjwzWqV1zXLfPkG9gnYrLfX13PsksCDFjpPBQznGsHKynMWPtYGNUUQWhDuz0IvMlUqzzYOc6erMa8yLV3WmxGPzXaIoJwvzxVMixNRCFh9wrEqmLFOv9u3uyP6/jdG8T/4m4qbsa9rJt3Zc4UCemcadE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960076; c=relaxed/simple;
	bh=mYLHVJNSY+uDKuhGnxN+402QNVV4FtHnCAeOggYJGe0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXzIYP37o5PYs9eY+LXojbgEVkX6Wq+pBqDG774TwRUsJV+fKU++Fi38it7dcijUkGxPyX1dWttk43ZRHz4oqzKS1n1d/QrKQRl69lhu7HKT8dbRKHCQlW9YGKU2JW2R9Z0wYQXj/o87XT1jYSpb9j9PbmYBXyLOLYRgDYQg3hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Kf/qwLJW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=U4qTHeS1; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708960074; x=1740496074;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mYLHVJNSY+uDKuhGnxN+402QNVV4FtHnCAeOggYJGe0=;
  b=Kf/qwLJWrrQtgB8R4QfdVQdI8Kg0X5qoUI3pZDM2RBo+RyeWmnOF5jMt
   SY6x//qLLE7YAL0N1jPkqqER4glYOdPsBdFOOp5bbAPzP2FHUCp3iwWZ0
   UPGvu87J1efFW9v+l3pl1UMQPuEpzmZFgZmqUp3PlbzMmMhJWVWUmrS2h
   GVktZul+bKOvv5IWb1jIl6cWbZQ+w/5asFEd5FO+l5gTGphthKfRF5Fpb
   GYr1q7cFpW448C4Tmlrgl8/TYFY1c8P523Wn1Bls8Lb1ar+PbYmMVW55W
   /rMQySqYF3+bHkN7lAqlRCQVdmKp8bxaqhmy/cuRtfGnbJlH793T/OrDR
   g==;
X-CSE-ConnectionGUID: d3da30MLQLu786TuZaqDIQ==
X-CSE-MsgGUID: Sz96piD9STS2HfnccPWukA==
X-IronPort-AV: E=Sophos;i="6.06,185,1705334400"; 
   d="scan'208";a="10442736"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2024 23:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuAojP024HlGy3oLty4i6a/9BHHV5Zm2vhCAX3951+4NQFmw5HTuewo4/YZ+I/BbeSwQzUu01OhDS4L28FoXdZx+iMchJ1jClRHpOExM88wwBCGUdWSIx46THz9RwUCkDyS5UHAyl9wuSrO1mLFu43EY26LcPEyV/ZGyiwvbpbpbuz6AjKubT3dXYA3f+w7Sfdjd/YIvRsYU8KMhuVdnrYKElSmja7R/G+k+/wNwDJElNSh1AxUqofjDDUY0Fg4LPn6J60IVfNvtLcc7a/a1C/62qAkTNNprTo1maSo+7x74Aap0ng7eGCRKA9uLcMDWDjAcCAzGuLPqefMKSLMmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYLHVJNSY+uDKuhGnxN+402QNVV4FtHnCAeOggYJGe0=;
 b=nQYeZ7Dn5V2U0k9q3swFjaas4P4t/rGMwoPw18PdpcCcFziGHJiHvPNT51WNhS/57rprGOwv+KF5BeZJ3JVWOtH69mYAcSNxQqdon+EnbqUMdtW6swMcKuwdzl72aZpTdEBIhQ4voZal4fjxI9rDAzfq4gQS+HiYzwqrIlRoBMRNcrN/V1Gas8rFcN4Cr3NUFcVnbs83Hy+cSppkAPnOOVAoTWm/dJ9fd/bncMU1B7TwfXAC6HHehGe1daglnFpaP7+uzurvG1WUV9b6cZSvN9ceWNcaHgNLPArCHJGdm3g0/NdjWFNHP8cQB4P6OlHvKdeKRNiMKuQ3g6xxAKykrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYLHVJNSY+uDKuhGnxN+402QNVV4FtHnCAeOggYJGe0=;
 b=U4qTHeS11SMTkiMNeK8KCLGb+Hty8+J/FZlqvNeZLTjA154DoVnzE2Gjg8vi6Z5DfwgcPHEmtaSAGqvYElM8QHXDpoxNmYfyCUYw9leibNcyzJOxF4nRXhSschJC70MWW2Vhl/EwMu8EQK0osUv/Esj5v4g7b9K3bRogJIA63n4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6312.namprd04.prod.outlook.com (2603:10b6:a03:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:06:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:06:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, WA AM <waautomata@gmail.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: Super blocks checksum error on HM-SMR device
Thread-Topic: Super blocks checksum error on HM-SMR device
Thread-Index: AQHaZxtmdv61aKMhcU2eyt07iPeWZrEaCVkAgAKzPQA=
Date: Mon, 26 Feb 2024 15:06:40 +0000
Message-ID: <da2e52b1-eb47-4e34-bb00-f606e16f01e6@wdc.com>
References:
 <CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com>
 <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
In-Reply-To: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6312:EE_
x-ms-office365-filtering-correlation-id: 583b4c07-a8af-4d0e-45ed-08dc36dc897d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fy71OTYVIZViGnUicaWIrnbbk5kl1MUfiFMKCONCCeHSeSBN/8+lVy2U6nC5eMAflbPGKBixsZZF619vTr7bYvVR/gPVq5DRxnJe1ZMb1HEXFQpFr4z3wijqXo2aZSy+9l+W/PPmkZfkD/q765Y1aknrfXP88jmAJ4KVXLHImibkmRQJruMofFYCnbRQF5drtwNWflba+RdtSIj8n4EBbfa/xbTtDoDqJiInUtcLNvN1bsMgn9v2TA4g8EyOypLHL26LkneEWncPCd2SQcJHpYhJEvyey+r5NEM7CMjZH8QmUShcztduEuFnF1mzO1mE1xVYcXhnYczyCUpQSxFR3zbxvYwrW55TLAyWZniHdwkA2nOhnpzFyiAbtPZzFfX8cyePfwDGb/L1iS7ajhMyTmucGw04dfwx75ykrrSaBWc34LE/3vTJMkjU83b2oEg1q+dxzCwoItb71P/NaqYcOiR4EGcVZBQuxbewQupW4NDyxWTKSlvlA2naDvHg3RD5LzV1ScDa6c0Uedtk6Jw1dCLUIcL7wHmApaB4y9JLjywiJWkhydBBfeH5M7szyf0nRYSlWDv4Jq9rq4WuKv5aedthA53pCVLplMfZJ4vJ/1U//3uO0MbEiS2OzTF6eTCifI3Cc+G17GMCJ8rC/QaZ8ZMoX4T7JNuYf8pUTTgql/fq+eiGyO1fl8IFgTjUSpEZguN/jKFaYXk2AQqRNNoYzA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWVkV1NCRHpRVW9DZUkzZ3BvWkJrbnQzWmFCZk12MkZKd2hqUU5NREdMSUhm?=
 =?utf-8?B?QU9qSTJtMlc4Q3V5M2lkQXd4SHJQODhPY3c0UUxJdWRubVpDNUdnR3kyd3BK?=
 =?utf-8?B?ZDlGdUNLRFpQTUVKcC9zNDZYTHFyUy9kemlXKzBrZDRuVGJQclp3WExDc2wr?=
 =?utf-8?B?OGRRVmpWQnRNQzg3YUE3am0zLzlEZG55KzNRWExtcWl5QnZCTzFWYU80c2Ez?=
 =?utf-8?B?cFl2TkZKZkRVK3p5SktVMU90K1oxbEE3RW4rTW5JMytZbUdyVmhNcllJOGJK?=
 =?utf-8?B?dHQrQ3I3WCtSTkMyQWlBZnRNaWlkSlFBMTBUWTdIV21vcDhEVU9ZZUxNaHR2?=
 =?utf-8?B?dmJWZDRWRGU3OWI5U1IzVFF3Uzh5NkZZaDZ2bE9HWHRPYm1YaVVvclI3dGNu?=
 =?utf-8?B?QVkwcWVVZmVSSDk0U2hjN3dNbkc3bW12WDltRVR3aksybGUzUStTV3BWN3Np?=
 =?utf-8?B?QmhLUU9Da1plYUU0WCsrdHZ4TmNHL3BoQ0dTQjF1QXA4T2ExYVJPaTgzeGp1?=
 =?utf-8?B?a0V3ZGJ6UTFmNFo2V1N1Z25yK05kVFBJS1RiWTJxeHVxWnJoaTRLd0NQdGMy?=
 =?utf-8?B?UzJCK1Z0TlhwVVJmTXZ1TUQ2Z3JrOHh2L2c3QmZNNWUvVHAvamRXeU5tQTI2?=
 =?utf-8?B?RDhyeVl2T3REeFR5V2xIUnR5Rll5VjAwQWlKcThhdGtPQXk4QjM0TTErS1hW?=
 =?utf-8?B?MWJmQVgwaWx3UzV6UlE0YzhWUTM3NVBKWjR4allyQU9EK2FXdUdMTDJBeXZ2?=
 =?utf-8?B?R0lPamh1VFJxL0FVdCtQc0hsaEJtUEw0dy9lOUVtSWNIR281eTYvMkpjbEtn?=
 =?utf-8?B?OGNhUTdySUEremVDY3ZjZm5NVVFQU3ZMWGhPb1BjbTNSZHF5LzIwMWRZbENJ?=
 =?utf-8?B?ckFYa3J6a2NlYUY3UERnQ2t4Njg0M1hSWHcrQTQ2bTVvQ2dMaVc1SXNDWGFU?=
 =?utf-8?B?L1RyODhsd0U1UjVOWjFIaVVQNDl0dzdQN0JxRjBKN0U1QklPbmtiTjhkQVFK?=
 =?utf-8?B?RHR3QWZBY3VoMVJoUWVUR3hVaFhrTXNSaktsMGw0T1NaNlFhZGVnS0pBWG1W?=
 =?utf-8?B?RkZvWWlZbHZCKy93R3VlbUhwNjdaVlp0bVlFQWtGSTdSRlR4czB2aGhGOHQx?=
 =?utf-8?B?WXRsWlBiWmZnMktDbnpScmxRNHlEVVZ6eWlPNmNSKzUvU3FLbG8vNEtPWERP?=
 =?utf-8?B?V2xUS2p1Z0YyUFRlUEwzYWRjb0FqRWpLcXk1Q0RVb0QyYlVTaWQxK3ZDMDFE?=
 =?utf-8?B?eWhueEpKS2lrNDVCMTQvU0FGd3BENVJYT2Z5Q0w4NklQbkRXa0pTdEMwM2c0?=
 =?utf-8?B?NVdXYzgranpLR3h3amw1a2xsQ1VQMGNtbWxjbWtMWU9JVXZsa3lRYXYzaVNh?=
 =?utf-8?B?b3dNNVZGcWR0U3ljL1pvSk1tQ2c2SkFvOXQwTEl1Z0lUdUFRSUVBWk9zU2Va?=
 =?utf-8?B?OFVsMmZxd0k3N3Rsc3FlaC9hOFBqZHdsMUI5SWZmQjJ5V2k0NzNQWHRYUUMy?=
 =?utf-8?B?VmNXRU5VVjBQUG1PUWx3NGdZdkMzTU1iSGNPdmh6WjBzTG5QMEJ4OWZzT2p6?=
 =?utf-8?B?b0hOVU0yaVFCLzgyWDdFMXg2TW15UmN4RklkSFFwSGtQbWxFWGdaV2l4dWt0?=
 =?utf-8?B?cHI5R1ZBSnZDR3FReDRTK2xoaHJNczdub0srNXR0eVExZVpuNnZIblV0aVNY?=
 =?utf-8?B?VGRiSDNrR0s5anlqWHo3SFFuMllaWTlsdThxaFRlbXkwbjVwVEZobHJhOHhC?=
 =?utf-8?B?SE05TDZoOTNUazJMUXNsaVZTTkFHSkxHb0ZYNTFYRE5FVmZxZ3Zha1g0a1N3?=
 =?utf-8?B?d1RQeEFsbmkwYmhJYmR6eit5SC9SNEYxZWdSVzZYWnp6ampLYUNLM2J5N3FQ?=
 =?utf-8?B?ZE51TFpQN05ZaFk0UEhOcFJ4VUI3ZEtLeVB0WHI2RVVmMW4wZEpXZ0pWV0V0?=
 =?utf-8?B?UVcxR1I0WXlzQk5nUDZ2UkFSR1BpZ2VnQnVUdnpSRngveG43cnBScGNlbFM0?=
 =?utf-8?B?RGtaTDB6TFJLMk5MNmtSZHpVbGxKRUlkTFNzeTdsb2ttcTM5UzFxSHJMbHZO?=
 =?utf-8?B?TXBJWVRtZWN3VVQ4Mmo1TUZORzNSOUpCSlhqZkx6M0dCUmtwU2JVZC8yWU5h?=
 =?utf-8?B?QXVBRXZGSWVmcm9BajVYNGJPaUNaM254YW81SWRtNXlHcWVtaEVUWUtSVU1y?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17011F3A580CBE4DAAAB9974514E4B92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AJKLl0fQkW7n4Ed5IEyLuBeQEPAdxLpF6u7f2U8+fcuhfLFcMRYqop3V6odKjqJP12gesBCq4f4b4G4b/w3bJT22Sp1wcN4k8mymRd21+5NJcpC2S8IeVs4o1YaoooT2Xr5pKiX+p+HFvRyNyDPCtdD5/P54M6fEvrO999RY12N15++kcySsAnO3x3Nn3CU1KTGWF+4OKAVnybH044kMSuyUSB42Jh0dbkwFXpTYHPBI81eLchZDnPnucFE57LpDuqlMQ5wyu4aGPM+DmEqv1p7pYggApIUmKEWglilOQQsO1/iuwOKkyexGdZoRKX429+NEYlPYo8lc3mVc0wZwhj8dQFKla/PfdzNvev8djDxhIACkpKPdhGTdCupRfOhoaR8/zbg6sGpms66Tgxev/Cz2YwAk+0Gw0Z6z7RW0vhfsL8BVCmb3CiJndbhQ5GQWVPKH5xYjJ5DGukSTgy7s2uDPngQVkSqSY6ScJrCnVEHeaB/D55aCEuTy8TCwJuUAOIwqOt2m9/Typ9GTNjT0QPXL5G7NorNYBMiax1eAMJMuQEBHxtycLm0B5GOXlD0y/QeP968cVhM2QptvMiDmiZk3Fm2sSvK1VwSEmrp6B9DYnW1bScdP/y5ZP4qbh38O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583b4c07-a8af-4d0e-45ed-08dc36dc897d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 15:06:40.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcatMIj/6HmRkFgXKXIE8ghJoMihdE++z5ppxI6EF5ubBjSkWjVM6jWbymtejqFvEK1kiVeh4g5sSFadkQSvVB9H/SCOAL8kx6csG9jMKnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6312

T24gMjQuMDIuMjQgMjI6NTIsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC8y
LzI0IDIyOjQ2LCBXQSBBTSDlhpnpgZM6DQo+PiBHcmVldGluZ3MsDQo+Pg0KPj4gSSBoYXZlIGEg
V2VzdGVybiBEaWdpdGFsIFVsdHJhc3RhciBEQyBIQzYyMCAoSHMxNCksIGEgSE0tU01SIGRldmlj
ZS4NCj4+IEl0IGlzIGZvcm1hdHRlZCB0byB6b25lZCBCVFJGUyBieSBgbWtmcy5idHJmc2ANCj4+
IGBidHJmcyBzY3J1YmAgcmVwb3J0cyB0aGUgZm9sbG93aW5nIGVycm9yczoNCj4+DQo+PiBTY3J1
YiBzdGFydGVkOiAgICBTYXQgRmViIDI0IDE1OjQyOjM4IDIwMjQNCj4+IFN0YXR1czogICAgICAg
ICAgIGZpbmlzaGVkDQo+PiBEdXJhdGlvbjogICAgICAgICAwOjA5OjM0DQo+PiBUb3RhbCB0byBz
Y3J1YjogICA3Ni42NEdpQg0KPj4gUmF0ZTogICAgICAgICAgICAgMTM2LjcyTWlCL3MNCj4+IEVy
cm9yIHN1bW1hcnk6ICAgIHN1cGVyPTINCj4+ICAgIENvcnJlY3RlZDogICAgICAwDQo+PiAgICBV
bmNvcnJlY3RhYmxlOiAgMA0KPj4gICAgVW52ZXJpZmllZDogICAgIDANCj4+DQo+PiBbU2F0IEZl
YiAyNCAxNTo0MjozOCAyMDI0XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogc2NydWI6IHN0YXJ0
ZWQgb24gZGV2aWQgMQ0KPj4gW1NhdCBGZWIgMjQgMTU6NDI6MzggMjAyNF0gQlRSRlMgZXJyb3Ig
KGRldmljZSBzZGIpOiBzdXBlciBibG9jayBhdA0KPj4gcGh5c2ljYWwgNjU1MzYgZGV2aWQgMSBo
YXMgYmFkIGNzdW0NCj4+IFtTYXQgRmViIDI0IDE1OjQyOjM4IDIwMjRdIEJUUkZTIGVycm9yIChk
ZXZpY2Ugc2RiKTogc3VwZXIgYmxvY2sgYXQNCj4+IHBoeXNpY2FsIDY3MTA4ODY0IGRldmlkIDEg
aGFzIGJhZCBjc3VtDQo+PiBbU2F0IEZlYiAyNCAxNTo1MjoxMiAyMDI0XSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RiKTogc2NydWI6IGZpbmlzaGVkIG9uDQo+PiBkZXZpZCAxIHdpdGggc3RhdHVzOiAw
DQo+Pg0KPj4NCj4+IFdoYXQgd2VudCB3cm9uZyB3aXRoIHRoZSBzdXBlciBibG9ja3M/DQo+IA0K
PiBJIGJlbGlldmUgaXQncyBhIGZhbHNlIGFsZXJ0Lg0KPiANCj4gQXMgZm9yIHpvbmVkIGRldmlj
ZXMgYnRyZnMgbm8gbG9uZ2VyIHB1dHMgc3VwZXIgYmxvY2tzIGF0IGZpeGVkIHBoeXNpY2FsDQo+
IGxvY2F0aW9ucywgYnV0IEknbSBub3QgYW4gZXhwZXJ0IG9uIHpvbmVkIGRldGFpbGVkLg0KPiAN
Cj4gQEpvaGFubmVzIGFuZCBAbmFvaGlybywgbWluZCB0byBjaGVjayB0aGUgc2l0dWF0aW9uPw0K
DQpZZXMgaXQgZG9lc24ndCBhbmQgc2NydWJfc3VwZXJzKCkgZ3JhYnMgdGhlIHN1cGVyIGJsb2Nr
IGFkZHJlc3NlcyB2aWEgDQpidHJmc19zYl9vZmZzZXQoKSBpbnN0ZWFkIG9mIHVzaW5nIGJ0cmZz
X3NiX2xvZ19sb2NhdGlvbigpLg0KDQpTbyB0aGlzIGRlZmluaXRlbHkgaXMgYSBidWcsIHdoaWNo
IHdlIG11c3QgZml4Lg0KDQpTb21ldGhpbmcgbGlrZSB0aGlzICh1bnRlc3RlZCkgc2hvdWxkIGRv
IHRoZSB0cmljayBmb3IgdGhpcyBjYXNlLCBidXQgSSANCmhhdmVuJ3QgYXVkaXRlZCBvdGhlciB1
c2VzIG9mIGJ0cmZzX3NiX29mZnNldCgpIGlmIHRoZXkncmUgc2FmZSAoYS5rLmEuIA0Kbm9uLXpv
bmVkIG9ubHkpLg0KDQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMv
c2NydWIuYw0KaW5kZXggMDEyM2QyNzI4OTIzLi4wODI5M2MwMDk1ZWQgMTAwNjQ0DQotLS0gYS9m
cy9idHJmcy9zY3J1Yi5jDQorKysgYi9mcy9idHJmcy9zY3J1Yi5jDQpAQCAtMjgwNSw3ICsyODA1
LDEwIEBAIHN0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sgaW50IHNjcnViX3N1cGVycyhzdHJ1Y3Qg
DQpzY3J1Yl9jdHggKnNjdHgsDQogICAgICAgICAgICAgICAgIGdlbiA9IGJ0cmZzX2dldF9sYXN0
X3RyYW5zX2NvbW1pdHRlZChmc19pbmZvKTsNCg0KICAgICAgICAgZm9yIChpID0gMDsgaSA8IEJU
UkZTX1NVUEVSX01JUlJPUl9NQVg7IGkrKykgew0KLSAgICAgICAgICAgICAgIGJ5dGVuciA9IGJ0
cmZzX3NiX29mZnNldChpKTsNCisgICAgICAgICAgICAgICByZXQgPSBidHJmc19zYl9sb2dfbG9j
YXRpb24oc2NydWJfZGV2LCBpLCAwLCAmYnl0ZW5yKTsNCisgICAgICAgICAgICAgICBpZiAocmV0
KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfZnJlZV9wYWdlOw0KKw0KICAgICAg
ICAgICAgICAgICBpZiAoYnl0ZW5yICsgQlRSRlNfU1VQRVJfSU5GT19TSVpFID4NCiAgICAgICAg
ICAgICAgICAgICAgIHNjcnViX2Rldi0+Y29tbWl0X3RvdGFsX2J5dGVzKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KQEAgLTI4MjEsNiArMjgyNCwxMyBAQCBzdGF0aWMgbm9pbmxp
bmVfZm9yX3N0YWNrIGludCBzY3J1Yl9zdXBlcnMoc3RydWN0IA0Kc2NydWJfY3R4ICpzY3R4LA0K
ICAgICAgICAgfQ0KICAgICAgICAgX19mcmVlX3BhZ2UocGFnZSk7DQogICAgICAgICByZXR1cm4g
MDsNCisNCitvdXRfZnJlZV9wYWdlOg0KKyAgICAgICBzcGluX2xvY2soJnNjdHgtPnN0YXRfbG9j
ayk7DQorICAgICAgIHNjdHgtPnN0YXQubWFsbG9jX2Vycm9ycysrOw0KKyAgICAgICBzcGluX3Vu
bG9jaygmc2N0eC0+c3RhdF9sb2NrKTsNCisgICAgICAgX19mcmVlX3BhZ2UocGFnZSk7DQorICAg
ICAgIHJldHVybiByZXQ7DQogIH0NCg0KICBzdGF0aWMgdm9pZCBzY3J1Yl93b3JrZXJzX3B1dChz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykNCg0KT1RPSCwgb24gYSBITS1TTVIgZHJpdmUg
dGhlIDFzdCBzdXBlciBibG9jayBpcyBpbiBhIGNvbnZlbnRpb25hbCB6b25lLCANCnNvIGEgcmVw
b3J0IHpvbmVzIHRvIGdyYWIgdGhlIGxvY2F0aW9uIHdvbid0IHdvcmsgZWl0aGVyLCBidXQgd2Ug
aGF2ZSB0bw0KZ2V0IHRoZSBsb2NhdGlvbiBmcm9tIHRoZSBlbXVsYXRlZCB3cml0ZSBwb2ludGVy
Lg0K

