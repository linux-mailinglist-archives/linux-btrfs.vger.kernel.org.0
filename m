Return-Path: <linux-btrfs+bounces-16045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E713FB242BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 09:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AC37216AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DBB2D8376;
	Wed, 13 Aug 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oakvillepondscapes.onmicrosoft.com header.i=@oakvillepondscapes.onmicrosoft.com header.b="fYRF14I1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020079.outbound.protection.outlook.com [52.101.152.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C52D63FD
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070157; cv=fail; b=Z+7f/9tk/cw0BvVRYHzUTVNvAI76/6yWtZWEKUbAO8swLXXZqcy/fTRxWFTuF9fOxwA4gnwYyGS6kvKEeBwBdd7ZmpLxXOpA1VJ3l8VN+4fdeLGL0iLomi4mNguVFRG3PPLQqfqAZZ7kxnbLXmrIanlV7/a1wVX6y348AByi1C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070157; c=relaxed/simple;
	bh=eQZgwwXCWSvUPNnGFxGhqIsTJLi6Z+a3XiKGKdpvdeQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETVbskoWXuuAYQYcTMOXXVobVMM7ZUX8PGDYCKewZtCM36yJjHEqpp0WrtiQB5pJxwqBid+UcsBET3J637H/SFhV6C3aa8g1szhfEUSF4BvM8TD9w2lbJZ/8CWFlkz7auYERw/RFXyJwezZf7rwCs1MjKqrLokD5WHpLFp1+B0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pauljones.id.au; spf=pass smtp.mailfrom=pauljones.id.au; dkim=pass (1024-bit key) header.d=oakvillepondscapes.onmicrosoft.com header.i=@oakvillepondscapes.onmicrosoft.com header.b=fYRF14I1; arc=fail smtp.client-ip=52.101.152.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pauljones.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pauljones.id.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTAr+Gmtb6rGEXWPxVAeOrfS6rYb2tnkP+CyRGykqt9LakIUDvGeUqVvFVjBlSXmbQshERQOaR/qV5uxAZI3KQ7TeiJjnOgeHTkSmqXx9dttIOEqHgCSj800clIxysO0vjJzSKXTbM316dVish3nM7Is1p0LG6baKMpG3/LQzLwmw+EJysDCjcDaTZjNg2JwFOum5RBZ6cFydk9NME8opQBdiMQ7qWaE8cYZLWWUn3qMNisbTdxAaa1y32R4QcI7UXMbnymnwEfwX+iY1fVXZOf8uKfC3R+TSE2nGGm51nWbkbRVF8+M4TU4x7XM1leH9bSbpWa3M3enhIfZP0bMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQZgwwXCWSvUPNnGFxGhqIsTJLi6Z+a3XiKGKdpvdeQ=;
 b=NLylK4QZjYdIwr90Kn3qjxgCpSEhxpKz7LGBV65wd7UFqd3cuLv4H8JupFiG3upzhyvtJApnJZcAobfCBs3LQpE92glYaIVcZ2pVlQ9sBJddybnNdRKTD9zk0GTGuNMOt3qXUjPOwrDlpQea/kkCunWPSUzpxTR1XtkSiwI5Z6rOX9WOXTTar9gxLvEJHKh8p35Hbg1oGTNFSQjUaWnMyMmnozA6pM8mf6tDuxHF5AjKpr+BjzWV/RMYA/996YqH5DtC6OTa+bXdlDJXUL7ZSIGFeyilYyp/p7J27ZeMaz4blDqafHwV8/kJivD2/ku1LGeBjzKfcVZV011na+Cgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQZgwwXCWSvUPNnGFxGhqIsTJLi6Z+a3XiKGKdpvdeQ=;
 b=fYRF14I1hif/5e9uCEsE5sayCANqhUUWeP1HrPSrkftiZ4LjL5W8ttehy2CbHLZE2xPNUngkRJStzW0I1MylXjEGnPOvPRdM0wBLVjmmVXvKucWdVgyd7/xNmW8C8vmFNbKJvyYhcJ7eb2b3wCApSBfIK63hLMjcZjZu3zs9AdY=
Received: from SY2PPF30FCB0762.ausprd01.prod.outlook.com (2603:10c6:18::28f)
 by SYBPR01MB8540.ausprd01.prod.outlook.com (2603:10c6:10:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 07:29:06 +0000
Received: from SY2PPF30FCB0762.ausprd01.prod.outlook.com
 ([fe80::a9a1:f8bf:2a92:12bd]) by SY2PPF30FCB0762.ausprd01.prod.outlook.com
 ([fe80::a9a1:f8bf:2a92:12bd%6]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:29:06 +0000
From: Paul Jones <paul@pauljones.id.au>
To: DanglingPointer <danglingpointerexception@gmail.com>,
	"johnh1214@gmail.com" <johnh1214@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: RE: BTRFS RAID 5 array ran out of space, switched to R/O mode with
 errors
Thread-Topic: BTRFS RAID 5 array ran out of space, switched to R/O mode with
 errors
Thread-Index: AQHcCjOujdQVqeSgLEyv4YUGuzW3ibRfqiyAgACDR6A=
Date: Wed, 13 Aug 2025 07:29:05 +0000
Message-ID:
 <SY2PPF30FCB0762CD40D9F13119B8C330D0CF2AA@SY2PPF30FCB0762.ausprd01.prod.outlook.com>
References: <99bc3ec8-8251-4530-ab4c-7b427883853e@gmail.com>
 <eeec436c-fa53-4644-aec6-5e4381da34ab@gmail.com>
 <89786d48-cdca-4e53-8646-09860a6f5482@gmail.com>
 <b1a7a056-2d0f-40c0-9899-8ecbfc29dfa5@gmail.com>
 <b4efb68d-28d9-44cd-8190-6870d0dce098@gmail.com>
 <1ffdaf61-e90b-40df-963a-224831f03163@gmail.com>
In-Reply-To: <1ffdaf61-e90b-40df-963a-224831f03163@gmail.com>
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY2PPF30FCB0762:EE_|SYBPR01MB8540:EE_
x-ms-office365-filtering-correlation-id: b09013e3-d361-4d34-d9ff-08ddda3b15c3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXNsaFQzL2dJZ2hVVjh2RHp2dkkxaUM4cE1mQnBRcjlOUHpxaXNlakEyUXhz?=
 =?utf-8?B?QnBEQXExc2hCdmZNcTh3TjZrOStVa0ZpcEdTMGhWU2tUWTV2VG1JblJUTFp5?=
 =?utf-8?B?eFhpN0NmWmR0R1g2b1R5cWdOWSsrTE1nWStxZ3JHZGUrU3dMSmN0MG01UnFC?=
 =?utf-8?B?UWx0a1dvTC9sbkN6RlVOeHpxaHhMWnlnYWdLYmlVNEQ4Z2c0UHFacy9oZlJD?=
 =?utf-8?B?am1BQ0dwVHJtVHIvTHNCRHg2WGNjSnp1L3cvcU9wWDFzZDd3MnpsdmhkLzFq?=
 =?utf-8?B?TStsSGRKSlI2dGkzakNvY09DYnQ5bEhVOGZOTGxOeFhRYlQwUGFzNEZKRitw?=
 =?utf-8?B?OWViTWxadFNlTmJqMGRESFJZOGVkaWNKU0JxMEFETks2czRDUW14Q3dHQ0xC?=
 =?utf-8?B?R2hLR0RjYTJhQkVlQUUrUzArRCtpRERGbE1kRjZ6a1c4Q25obWlUZ2FkcFFP?=
 =?utf-8?B?Tzc4cWV6aFJMY1JCQmZzK1BRZFA1QS9TenFtcTRqM3pENWlvbHFzVVNNN1FO?=
 =?utf-8?B?TkFXME5vSi90UHJ5eVFWdytTMHFQdHRrclFyQ1MwRFZUNVhJUHlyMjQ3Zmh6?=
 =?utf-8?B?Y29CYVlEMDRsVGttNUpBNitHNFAxUEc1NGo1NS9zME5OdmErMVYrNlBMVkxH?=
 =?utf-8?B?RHVKRERtRFZ5SGZlQU5SeHkzYzhOTnBJTXVnaHRoZjlUTTF6RXV2Vy9MOGJJ?=
 =?utf-8?B?RVdVV3BzMERZVkYrS1Q2akplQ2FBdTUrRE9kOTBadnhobU1NcENxYkNRaVhu?=
 =?utf-8?B?MHNRSXJkejZtTTNJTFVHbjc0M29XVmNpN1pKZmwzVmJnNisrUmNxZ1ptcFds?=
 =?utf-8?B?Z0dmcEt3c2lqOUVuS05pRnZEaXBzRXcySm9sNkRqUmZDakYvd1ZjVEJKK1Nw?=
 =?utf-8?B?NHpOTVdsdEo2ZU83b01vanhBbDhGWkdWaFZoODRBUDhKc3YxZEJUd2NQMlJ0?=
 =?utf-8?B?MTNLSWUxcjE2M3ZQbzIrQ0JJWFVFRlgrTnVEVkx0NFFoU3kvVE1DbDlFL3hz?=
 =?utf-8?B?eUN6OHMyRTF0cDBrbTdJWkMrSkhDbDZmNzVRU1c0d0EyS1BRc0hGeXA2VlZY?=
 =?utf-8?B?STdpa01zZHpNUkJYWXRNbGNvL2xhM0k4MXB2SktMUy8rV1pra2Nudjc2UnpS?=
 =?utf-8?B?U3VsU3VhUmNGaVhQYkZxVHpybGJ5Q3NPamZIekM3UE5GN1lQWDdhczVrMmxt?=
 =?utf-8?B?aXJLa2RXQ3lhZlBVdGwvZnloakVlbFBoNHRLWkVxWDZncGw5eGEycGp1dmpE?=
 =?utf-8?B?YVFuZ1k3OEhFcjVYcUZGNUdVS3o2azBsK2p1K3RtSHhuaWphWXliYnJ1SVFJ?=
 =?utf-8?B?VmZnRzdRWGRmQ29LWmx2dGoreG5GVUYreGg3RXQ4b0xYbnQzYmsxUEZmeHlR?=
 =?utf-8?B?TEFOQ1JyMm9MaU5hQUtVcTUwM09LaFZ2ZitWRmNtRVdvbThjRUdlR3F1MHk2?=
 =?utf-8?B?NUxhcGUwSHk4KzJXcE9sN3UwVENCS2dKWVlnMWxLaHpsTy9yWGpHU1VxK2JO?=
 =?utf-8?B?Um50SG1SSE5ldmVxQU96aXBlTFo4SDZ0UTQ5M05vclZmQ2JST1BnU1FnbytH?=
 =?utf-8?B?bGxwSDRQWTc2QzZDS3pKaE54Y0NNNW5UNDJPaW9jcUk0RUNjZmZGNWY1N0Nt?=
 =?utf-8?B?SE94dFpjek81aS8yV0RONVlwaHUrNnBKcjVUdzJpUmZlNmtYT0JRajBOYmJl?=
 =?utf-8?B?dnUra1pFZDBDeXlpbGcxcXlEU2NsOC9xZ1V2RkYyUzdUa1VkS2ptMllFUVVU?=
 =?utf-8?B?d08zWXJRYSs0b3Y0V2tONGZWYVBKaFRER2VlNGdkcUhrRU1hbURmcU5ESHBK?=
 =?utf-8?B?SmtVaVR4TmY2NHlBWTBCOHZPQno0NGJObVRZUUNROWtiVVM2NEV4TXdDUGpE?=
 =?utf-8?B?UWRGZmM3enBiV3NyVE85WTVtL2dGd2VvOU51SlVsTnBmUXpFaDJhVkVHY3Vr?=
 =?utf-8?B?QnFqZnBNdXNVcm5KMjloeEhSUDEzVXFHelluR3JNZ1NYWFdYN2FEa0tLckp1?=
 =?utf-8?B?dWNNRm92Vk93PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY2PPF30FCB0762.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFltYW12K1htWFdtZWZSUlc5cGJtbDNMaVpOTThIN2xWdUxXNzdYL3BLS25v?=
 =?utf-8?B?cHVDZUR3UTlJRXFFalFTWERxQmRNTUE5OG52TkVIcWFlNnNhL0NFS0xCcW9i?=
 =?utf-8?B?YkJYOHBsaG9NLytQajBuOUM3Q2FLNU1CL0JiSE9kb1lpdG0wK05wL2JjOCti?=
 =?utf-8?B?SUs0QWdndHJJZlZkeDlzSlRpa3EvWDNwK0ZmNzBxd3pRNXdzVVRVOVVxcENq?=
 =?utf-8?B?UkxyejdEU20rc3BzRWhNLzhlTkorRFBrUzJXQU1KZFkxaXkrWGVJMGEzQ0Fi?=
 =?utf-8?B?Zk9RbU4xMnZNZEhtdHhTWHR5ZlV0NjJIeHY4VmU3NUlsSDQ5bDEySmV0YjY5?=
 =?utf-8?B?NE9rM1VvTWxqOURJZVpBYjg0VjZkRVBsc2UyaEhFaDVzcGlrSVNIR05ybUFm?=
 =?utf-8?B?Q2NqWC9Lc1VnckVvaHA3ZDNXZEhKNkFnQmtTWTNONjc2blYxTmUrZzlyM2py?=
 =?utf-8?B?UnFDbTVCVnlNOFpUYlF2QkQ1SnpUNzJtQ00wVHlKdkFaUzV3R0RvaTJzSHB3?=
 =?utf-8?B?Y2Frb0wwQm0ybEFvdC9KOFZJb3BGVHdwQjlmMU5kdlZGTTBuM2ppL01mVi9R?=
 =?utf-8?B?SWJudExNUVdsbnJuRjd1MTl3SjJYclZhK05uenIyaGNjVkNNVFBlemg0dDNT?=
 =?utf-8?B?bzhWcmIyTmlDTVlwQmxCTU45c0JKUERKZTJTYnVjUUphS0xSNDFzOTg3SGhO?=
 =?utf-8?B?OFhodkh4dUJRNksvbjIxT1ltQmpraFlFbGdOclptNHFoYjd1QWx3Q3Z4SkZE?=
 =?utf-8?B?U3YzWGlhY3RsZzdCWFVPajlMbFhFVEpNNGtvRTFVOXFlQTFuUE1rZm9KbjFz?=
 =?utf-8?B?QUpjalJoL3kxUnJKU1hMdEcwVTFCb21WNWlubG02aVhVNW9sQTUvZVEvK0Nn?=
 =?utf-8?B?QUxpbXlNZnZiamVWMDJuTWFJWXh2TmR2NkZ3aElZNTRPUGZSS3dHbVIwdzBT?=
 =?utf-8?B?dWczSTZFdFd5UnY1enhJVjNjbXE5c1MycGs2a1h3M1lxNGxqTDRVWEtuWE5z?=
 =?utf-8?B?N09ySC9OcGZ6dFZWNHNEMjdMZkR1NTFNQTNBWFA2TkdhZmQzbE4zdm5FZDRB?=
 =?utf-8?B?TUxZcHRVT3Y1MXVXZ28rZVpJZ2U1Rm5XVytNc2ExTjdUN3hQTW54K3ExeC9s?=
 =?utf-8?B?S1cxYXNOaVBiaERqak9BcHR6Qy93NWJyZ3FrT0F2eEx5dFo3S2diM0VTY0h1?=
 =?utf-8?B?U2RWdWVTNjcvelNDVVppM0hlSFBoSEUySnp2dGovSVV5R3pRZjVEZHZCMmkr?=
 =?utf-8?B?Zlh2bUxhNDUrSklzQnpCSVNnMDkyYUdNUVJ3WlIwRXJoeFRPM1pqS3lmd2hj?=
 =?utf-8?B?VDdJZ3F1UnhLVGMvcU5pTENmbFZLMzc1M1M2RU9CMGZ1STVPT1RyYStEN0p2?=
 =?utf-8?B?TDJDTDdGYXkyWGs0a1JzTDBLNWV6eUY1TUlPbFdKRUJOYmJ3OUJMN29NOU5k?=
 =?utf-8?B?ckI0aDRoOWdDM1BqSjJZNkpBeE8xOXh5YUJhN055WndkRzMwbUVXVldsVUZ0?=
 =?utf-8?B?SytCMFlONHYzc082YmoxU1RjMUZ5NlFjN3M0SUxSelVDb0g4ODd2QzdwL0Rp?=
 =?utf-8?B?VTBieVh4NFAwN3dOb1QzV04waWl3anpLYWtud0dlQ0xXdVU5cm04QWs5WDda?=
 =?utf-8?B?R01rSzJjRFVrNEw3cS9ZRURJbUdydURPcDUwOUlreUY5OXNOUDF3Vk5qR1Jw?=
 =?utf-8?B?L2hyVzlQYmlCeWVWUUdjeUdXcGRWUmNlVmQxVVo3YlpuM2pmZWZFSUJ4c3Z2?=
 =?utf-8?B?cTdXQld4OVpla0lxaTBlUTBNMXRGY2JqRzlkdEwwOHl3THR0d1pSWjk0Ykxz?=
 =?utf-8?B?cVBJQ2lRS3ErWGI3bnhhNkZTWXlTb0FETzBhaHlQWjNIN1hkdW43Q1ByWFRH?=
 =?utf-8?B?Szcwbmxua29UekptSXhuZlVSMTY0MU1oaGxmOTZieU50bHV3eXVqVEhLODEz?=
 =?utf-8?B?czRkRHpBaTVTcXFkb3FNVnNrVEd5bFFEeDF5VkVQR09nN0FKbEdPM3JWNyto?=
 =?utf-8?B?cTNvVWJmaGRkV0FGN0g4clVJS1U2ZE01cGlTaEEyUFVFSjFrQnMyTHpEMm5P?=
 =?utf-8?B?M3RHUW8rUXRDZGF6K3hwS1h4NE8zOGgzcXNRV1FaRHlkVndvUEh3Q1lmOVQ2?=
 =?utf-8?B?cGtmL2Z6bWY2cWdsZ0lXSmlDeVZLZVNEU3gybUJFQ0pQMEI1ZzBhaEZDVWVm?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY2PPF30FCB0762.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09013e3-d361-4d34-d9ff-08ddda3b15c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 07:29:05.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgcMxhn2pYZpWFfy9RYK0oO2o0n0HNHRL2h7+yMcbQ3wBB9NNCwn7jWEN+KNPpeoMYhKzZRZCGYGppP40r72lI+f4SsQsNVDbuwt3b7VSwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB8540

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5nbGluZ1BvaW50ZXIgPGRh
bmdsaW5ncG9pbnRlcmV4Y2VwdGlvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMTMg
QXVndXN0IDIwMjUgOToyOSBBTQ0KPiBUbzogam9obmgxMjE0QGdtYWlsLmNvbTsgbGludXgtYnRy
ZnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBCVFJGUyBSQUlEIDUgYXJyYXkgcmFu
IG91dCBvZiBzcGFjZSwgc3dpdGNoZWQgdG8gUi9PIG1vZGUgd2l0aA0KPiBlcnJvcnMNCj4gDQo+
IHllcyBJIGRvIGhhdmUgYSBiYWNrdXAuwqAgVGhlcmUncyBhIG5pZ2h0bHkgYmFja3VwIHZpYSBk
dXBsaWNhY3kgYmFja3VwLg0KPiANCj4gVGhlIDhUQiB4IDMgdXNlZCB0byBiZSA2VEIgeCAzLsKg
IEkndmUgYmVlbiBzbG93bHkgdXBncmFkaW5nIHRoZW0gb3ZlciB0aGUgbGFzdA0KPiA0IHllYXJz
LsKgIEhvd2V2ZXIgSSBuZXZlciBnb3QgY2xvc2UgdG8gNzUlIHVzYWdlIG9uIHRoZW0gaW4gdGhh
dCB0aW1lLsKgIEknbGwNCj4gc2VlIHdoZW4gSSBjYW4gZmluZCB0aW1lIHRvIHVwZ3JhZGUgdGhl
IDYgdG8gYW4gOC4NCj4gDQo+IEhhdmUgeW91IHVwZ3JhZGVkIHRoZSBrZXJuZWwgYW5kIGJ0cmZz
LXByb2dzIHlldD/CoCBQZXJoYXBzIHRoZSBuZXdlciBzdHVmZg0KPiBmaXhlcyB3aGF0ZXZlciBj
YXVzZWQgdGhlIGlzc3VlLsKgIFRoYXQgc2VydmVyIG9mIG1pbmUgd2l0aCB0aGUgNzUlIHVzYWdl
IGhhcw0KPiA2LjEyLjQwIExUUyBrZXJuZWwgd2l0aCBidHJmcy1wcm9ncyB2Ni42LjMgZnJvbSB1
YnVudHUgMjQuMDQgYnkgZGVmYXVsdC4NCj4gDQo+ICBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCBz
Y3J1YiBpcyBub3cgaW4ga2VybmVsIHNvIHNob3VsZCBiZSBhdCB0aGUgdmVyc2lvbg0KPiBvZiB0
aGUga2VybmVsIGFuZCBub3QgYnRyZnMtcHJvZ3MuDQo+IA0KPiBUaGVyZSdzIGFsc28gYnRyZnMu
c3RhdGljIHdoaWNoIGlzIGEgZG93bmxvYWRhYmxlIGFsbCBpbiBvbmUgdXRpbGl0eSBmaWxlIHRh
Z2dlZA0KPiBwZXIgdmVyc2lvbiBvbiBrZGF2ZSdzIGdpdGh1Yi7CoCBIZXJlJ3MgdGhlIGNvdW50
ZXJwYXJ0IGZvciBteSBrZXJuZWwgdmVyc2lvbg0KPiBmb3IgZXhhbXBsZS4uLg0KPiBodHRwczov
L2dpdGh1Yi5jb20va2RhdmUvYnRyZnMtcHJvZ3MvcmVsZWFzZXMvdGFnL3Y2LjEyDQoNCllvdSBy
ZWFsbHkgc2hvdWxkIHJ1biBhIHZlcnkgcmVjZW50IGtlcm5lbCB3aGVuIHVzaW5nIFJhaWQ1LiAN
CkkndmUgaGFkIHRoZSBleHBsb2RpbmcgUmFpZDUgZnJlZSBzcGFjZSBlcnJvciBhbHNvLCBzb21l
d2hlcmUgYXJvdW5kIDkwJSBJIHRoaW5rLCBidXQgdGhhdCB3YXMgYSB5ZWFyIGFnbyBvciBzby4g
SSBidW1wZWQgaW50byB0aGUgZnJlZSBzcGFjZSB0aGluZyBhZ2FpbiB3aXRoIGEgNi4xNSBrZXJu
ZWwgYnV0IHRoaXMgdGltZSBpdCBoYW5kbGVkIGl0IGNvcnJlY3RseSBhbmQgY29tcGxldGVseSBm
aWxsZWQgdXAgdGhlIGRpc2suDQoNClJFIHNjcnViOiBJdCdzIGFsd2F5cyBiZWVuIGluIHRoZSBr
ZXJuZWwsIHByb2dzIGp1c3QgaXNzdWVzIHRoZSBpb2NybCB0byBnZXQgaXQgc3RhcnRlZC4gWW91
IG1pZ2h0IGJlIHRoaW5raW5nIG9mIHRoZSB0cmVlIGNoZWNrZXIgd2hpY2ggaXMgYSBtb3JlIHJl
Y2VudCB0aGluZyBkZXNpZ25lZCB0byBjaGVjayBpbi1tZW1vcnkgc3RydWN0dXJlcyBzbyBjb3Jy
dXB0aW9uIGRvZXNuJ3QgZ2V0IHdyaXR0ZW4gdG8gZGlzayBpZiB0aGVyZSdzIGEgYnVnIG9yIGEg
Yml0ZmxpcCBldGMuDQoNCg0KUGF1bC4NCg==

