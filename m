Return-Path: <linux-btrfs+bounces-5987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D2917C4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9B31C2283F
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F416848B;
	Wed, 26 Jun 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bL6evVHg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2012.outbound.protection.outlook.com [40.92.45.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC41662E3
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393483; cv=fail; b=cFVtZoP+AFwS4YfjCU7y/43QtRyICqhFUGy/Lznh+cAIlWS8Q+kVkN1ZK0eM8bVWbbybXA4rX7O9+fg5WaJnYL7+JLdrJyR0ScdiS5cW7YD4ju9mdjvolQ2qc9zJK3u2MfAg17EgmH5m7oAF7YqOx7kVttXHuRq286gs8tZpIiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393483; c=relaxed/simple;
	bh=hwdy5uZkXi0A5BCx1qNIbmuDm/HUayljMSiqg54oWyQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EbycdXH9Gxr2PQEWU7Fk/J5yjWXdWM6LDxoEiChokTzSlBLzC++fj4TDp8VYvLbI0RuLyN/EF9VTfHixUFwNdJ1gAzVv7ciS6WHEZRpUZwqw4NbSLVutdWE9Uo2MrImhbRTC82huDGt1RkbkLTHgtWX/i/CUWM7Df1Cag1KLUF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bL6evVHg; arc=fail smtp.client-ip=40.92.45.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvEFxgEolvStYHYFG7Hm8NPTIEz1pA2+fR8YVXt2/VsLWzVNF1GCbJzLWl0Z0XxX9dNg2inubaDMnUcqmu+NbKas/yVN8s4vS4u4157RbUhvzor1rn9nTTs17gyPpKSOMR0JHiKaBHv8nKpzxCRqdE/DZeIz47l4C61aDXAbsKGDUcDzvqqSfveoeoJ0aVLVd2GWqjEZjr7ul0GZNIewBk+zrvsc/v3Fwu1KgS0xPlorf3cwhJQGzKKqAOGI1WaM+Zunl7rbFCQms9kvBD6kcjnIbaI9zLAPtIsP8M2BHmZRsu2A+9PKZ5zIDZEjXCIwIAlF8WN8GEaungXSWLI1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwdy5uZkXi0A5BCx1qNIbmuDm/HUayljMSiqg54oWyQ=;
 b=cWmS5S6gF7STg+1bDMsIZo70278mjM/qaH8V6Lk4MN0J/+PwgRIehcvv9pK91XGnP7xofuz7TC1wqj8oc5jWOXQOxxcsByQnlFcXzc4OxWm6bPRQEZynfayziCuffyq2lyQ0T0TZEYg+pwD4RqBa3eL20FueexTTeIbhweCA1OTjsTKKU9RiU6Je9LKHKCJrJGClkCgoez1vPFRkwmw0NWyPCvueNC2vo2qIzir+6OfCR1kKhSVFK/q53X241+XPvubd3dnp3NBc2WCZPjItf4e/q+UoQ6xhRATMy8tlZd3YCqgBmd/liOd3jbVXISSitOcRzMNqhflNrLpCHHzdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwdy5uZkXi0A5BCx1qNIbmuDm/HUayljMSiqg54oWyQ=;
 b=bL6evVHgqSOTTQvu5khUoy1cCRf2DwlycU8xR9ZILS0T9fZuu0N4QgSBq+r3B62mZNxzNfqY+oOED5krEtWl7CHhwH0iFj+ZUkD1sn3ZtTR/I0QLgYzC3HkYUSX48A/wzN3vwY7SCxZzwBm4ih5iPM5Hl+fl46G1uyOYfRqPkgg49uysKQhGQwSAWNHZ3i3p2Zx9KPsNOOH+j6zyyFFDBBHr4t9BZLbMGyQkJVzTLW57WtBEM5RS35XPOQ46NqkMQTZuCWmwuwjisudENEGZnVJHBQfnshIlvavc5D9lcUNgrrmFQNXFh0TwX6wVwnF5r24SQT4ZxD9fKBEPF69ebw==
Received: from CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 09:18:00 +0000
Received: from CY8PR12MB7193.namprd12.prod.outlook.com
 ([fe80::aa62:af09:b5d7:2e45]) by CY8PR12MB7193.namprd12.prod.outlook.com
 ([fe80::aa62:af09:b5d7:2e45%5]) with mapi id 15.20.7698.017; Wed, 26 Jun 2024
 09:17:59 +0000
From: huang wolf <huang_wolf@hotmail.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: hello
Thread-Topic: hello
Thread-Index: AQHax6m9vMUK3fSDG0uhIHMTJl9Ogw==
Date: Wed, 26 Jun 2024 09:17:59 +0000
Message-ID:
 <CY8PR12MB71935063A0EACE92D40E8895F7D62@CY8PR12MB7193.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [YfpgoxTvMQHOBocyjpWpyXTiMgc8YB6O]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7193:EE_|SA3PR12MB9090:EE_
x-ms-office365-filtering-correlation-id: 5e4017a0-e057-4ee5-940b-08dc95c0df95
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199026|440099026|3412199023|102099032;
x-microsoft-antispam-message-info:
 bfaDI2Ol+sjZI6WA8GS/l3dDKDUoY+FrUL8FjFRCZG/y0KWKvjzKYDO76MIvNva9/AB6dUjty/sln1GEOHOtusrBdsS6RyGbF+m+gTmqJoEZER3w0oFVGmzCQ/XOqg0cZSIhd1Jz5I3xMRcBb4jsqBWrHoSVN051vaO2mdpELr+3Ij4gnncNKKIvqX5eRwd164t48eIogiWIRZ6kEW6oWKSHqjQa68DgT8S69D/QfF6+ErKs9rURA2JJDtfQR44NoRfaCFdOTlqBRv82rkZEji/2kYPcNQV0bTW8JI8mgr4CMaO7UaBjsmWfPcLcyEDnuq3hzxysUncd7t2r15sgB3UPEZpGioxDYfbS4jxoJUizcSSnlF44i0Tw/jQpRu0TuS3ZEYDMpTSslFzGcyaAyEYRXlEz8JFpbnzcr9Nsu4+ZePqZYhLIJWqItEEfUYCY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MEg4eVpQNGVoeEM3VTJOVEdkL0lTWWJ1VDRaMml6VWN6S0xxZTlGWkdqNFdO?=
 =?gb2312?B?VFBzRk9tblJGTys5NXJRNk1acWlNS1ErakVKaVFBZnAvaVdTVFZZM3J5c1J4?=
 =?gb2312?B?cFRUam5PYk5OeGpkZVZTT1FqRkMxZlJtdm50WHppR0FDSHhhWTBQVXZ3STFY?=
 =?gb2312?B?UHFHc1JxQ3Foc1RxYVg3N1ZxUTF5UWlZQW9YY0x5NVQyd1VEaitjeTRzU1Ar?=
 =?gb2312?B?TFNUZGlYLytxMjEyZjlhYkR1RnhoS2JtajZybVAvZDlFTVpuWTB3VGp0djIr?=
 =?gb2312?B?RG42aGxpVEZsL2FWSk0rdTI1dmF2dHhkVGUwMXl6L0gwbXhwYk5BUFZPSmlz?=
 =?gb2312?B?dmF4LzdrWitHblVvZW05NERKLzI3aUpTSVN5Q05QalQ0a1p1d2pBK0pZNm1S?=
 =?gb2312?B?Q3Eyd2hZRUxxUGI3S0ZYbUtJVWt0eXFxeGtqRnJtdytZU0JQM3ZkSXBkRXRj?=
 =?gb2312?B?ZU1hTksrbzM2ZlRpWklzR2FFZXFQRy83eVJGL1pSdG5VQkYwVHNWRTFxY3FR?=
 =?gb2312?B?ZXFPb3RoWHhwZDhIQ0NNemYzL3NOZWpqV1l5eXNUNlJOTDRJMWZnUmZoOS96?=
 =?gb2312?B?cWFYM2NrdmxXclJRZXJ0STk2KzVFbHYzeWpvbzZOVXEzQnZXN3J4a21LRXFH?=
 =?gb2312?B?WVlkSHhMTVJSblEzNHFjWVZBblZMOHpwK0xjdG5PSUxkcmQzUFJ3Rjc5bVJE?=
 =?gb2312?B?ZG5SQXdiQkF4Q0k2Z0RsR2xvbmgvcFhLQndqMDBabkRrYUxrRG1ZQmozOE9I?=
 =?gb2312?B?ejdrN2RTc2xjeVlHTmxQRHArOHZBS3JBZHBCWGpsRUxXY09uSDRzMFM3RGhO?=
 =?gb2312?B?aTVRRG5mSkZ5YklmZUxCQVVKR283UlJPZnVDV1huMDA2U2lQNHZzRkdSZUJQ?=
 =?gb2312?B?VHN4RVA3MzFkQ1hJd1V1clVqS3N5R25sTHFnNGx2R0o3dVpDWlowVGwrdUN5?=
 =?gb2312?B?Um9yNTc3L0Q3UnI2YXpxR1ZXbmFWUkhydUQweVUzVFZvbnpVUENHaEpBU3cx?=
 =?gb2312?B?cSthZVBUcXBlYjUzQ21JbnFHdWFncVNBQnFSTDZvbHdMTlV6dk41QzBrVW43?=
 =?gb2312?B?alVabGhweHNPSGE4QzZWOE40TXJNSm16YWsvRDZueHREZ01YdzE1Ym5iQ2tn?=
 =?gb2312?B?MUhkOUVOWE4ycDVMWklReWRlTFU1ejZOZGZVTHZhSmpQZEU3NEppQmNtTVFF?=
 =?gb2312?B?aUFoMjJzSmVhOWhuM2NKaEFRcU4vZy9MWm1vcyt0TURHejNWcld2TFkzd29M?=
 =?gb2312?B?UWtjSkZ1bGdtUkJBQVdCNE5JQldVRmRjNXQ5aFdhWmxuNzY3elFxbGNkRVpa?=
 =?gb2312?B?OXJXVnZMbmtJTllxNDFhVHlWWUovdCtiZ1UwYzJuRHZZblVrY1p3b1dyWWt2?=
 =?gb2312?B?OCtVYXk1bFdhRVpWcjZqV1NOODkyNFNYZ2hWdmh3aStOSEE5MG45M254RDFx?=
 =?gb2312?B?aGEvaDdMYmM4VDZCMDlFMGRTSXN6WEVLb2c3cUx3cmdvYU9XVzBQTG1icE9F?=
 =?gb2312?B?ejBENHNHN2wzVVFkUm85WXUyc0xUQ3NGMWdoRXE3WWtMaHZBZmF6RENjbHBl?=
 =?gb2312?B?RDhvTjJKRndDbzlDWjJZb3Z6dE56dDlQNzBxSmQxZnlGREZjNWM4ZVpmY3hz?=
 =?gb2312?Q?sRxKf7hQmFLgqRqi16OALBWhGzPoPnp+TC7Wx5I+Gkak=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4017a0-e057-4ee5-940b-08dc95c0df95
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:17:59.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

bGludXgtYnRyZnNAdmdlci5rZXJuZWwub3Jn

