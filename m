Return-Path: <linux-btrfs+bounces-3036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09154872FBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 08:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888FB1F20DD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 07:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E55CDCC;
	Wed,  6 Mar 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R20kg/F3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hn+Zy0JV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334C1A58E
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Mar 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710436; cv=fail; b=QBFSLA80citIhVbStxq3D+0bMk+qilne6/8Zn0LiNF3rNoSJiTbkeBjTcCqUZRDD/iXijNpP5R696wHwKWEKxYAOJyC8UkYhpRJJNH0QKQKbT5cq9vlGoUhwq+Yk3mZKDwZBYuze8VDm1X6UUmPiX5EVWBvsdABk5SgM6MXsNWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710436; c=relaxed/simple;
	bh=EP1gcoLhs/gFRdAWXet1ON4yswukNRRJoBe31QaPKFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fz5y1qbS806S7TI7WAH8sDlEhwK1DRKpzhdQKWUDKMCntXjAPZWOfc9BdoFgNHN5gAJSYpUqcKmjX/WvTG8OXlrNsNy1jbs6HvR2rSL9SKhb5auzELngc0cxz+d7NAVzikqGo4M+0C7HtQcqpJm+RwnrwQz12X3w+5Cl5jw5ULg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R20kg/F3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hn+Zy0JV; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709710433; x=1741246433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EP1gcoLhs/gFRdAWXet1ON4yswukNRRJoBe31QaPKFU=;
  b=R20kg/F3BcMYH7AUmqJISZbHjHvFyD3N5d4Lr+NyjKhnUtqIh0EiKpfF
   VQyICkm28IW5Kkk2mEXmXlc8ChKXR7nrYVHcyLpOrVZHXfn+42PIT2EQW
   ZybP1r1uTHRfH4dHgOfSa85ts3n62q/YnP56s21Y7Cv33Ga3FVFWRroUE
   cYMTI9FYyzdRvno6pzqrQy9TBSUVgyysXsRgxxwliZ7jzBfL9pGBIvzRT
   jcxbRgjrp4Gk3Gzp+ZUOIHVzCoGFrihxVIF1WqF7tBjzpkz0GYls0Cz/X
   GkGFuOBoVP3uLGt5s5MLLkM1/MuC+nohcH70KmiuJG+79Q5IAZcKKMXMh
   w==;
X-CSE-ConnectionGUID: dv99Z64PQymAYrfSGBnvnQ==
X-CSE-MsgGUID: 9NieEOe2T1WPdBp64tZm4Q==
X-IronPort-AV: E=Sophos;i="6.06,207,1705334400"; 
   d="scan'208";a="11515829"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 15:33:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2U09L5i7/OY4db0YXEhgflrZwSPicFhXUassmvwZcoKjf7EqnZo4G2veFN8uUzPaStH2Jy2xZPqBIsYsYRfQE0gqKzkU/uY1W5O9ijYzoPl7cc0FxkQeRFx18PIQdEoy7A7BRF5CRDp5NaSPAQmgD8/uoD2wW/ZnrgQXjsTqsU9VOnQ0vHTcQb/qTf+EIwciTDwAkl+D9fh2XcsJKsJPG1/uJurJhnxKyTg2IyudsI2eASQtvq3yx617oB3Nr+5x8wJDbLhk5j0+W2RnkfFZa3vLVUq0dZiXLMjcyn+pok8P0syWhWoLFUuNqOiikvNOYceg1V+zGsEwvqfMcboTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP1gcoLhs/gFRdAWXet1ON4yswukNRRJoBe31QaPKFU=;
 b=LHaLbsvvJbMKn8NMtIhcBgf20i86WnK8/S/LETUwoGYGW18OouM5KZ1KZZ8wi3Jv1t4ZACblDhYxJe9UXPu/QjzMjmmfe3j2qE3XVLVF5m4/p4W5aoLRFOWkMPcrUCXTmHw713j2Ocg49nmr7sfDo4Hx3q9tQAb036v8dCTzrOoHZ28KHVBJeu41lshpFZ0bMS+8/ydJln2mM+B7F2nsOZCr9WDZK/tkZoMjov0DxfVlJQsrm7+WX7kr9b8c/QLxeaGsmNY1u4QvuzQTggHq7xwWqrOYgfrheKCO6v5JM3VaUPvVP6ZhBe784bKBESDSCzO+1A4DWC92yEMIt21Q2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP1gcoLhs/gFRdAWXet1ON4yswukNRRJoBe31QaPKFU=;
 b=hn+Zy0JV8qJJO6qQaivHwqJ30Wo9ETAUkoN5le3QcdvNxEjsvq+M7eNEVp2PnhK8eeOKLthDV1YZ067B0tm6wU7b41eJEGHrSQW9tm9CrXklUOYpscLdenRF9Cc3OvQErGsMfmeE5Cby4zKBphyOuGHyuHCKnchmFFWF9p/rHJg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6892.namprd04.prod.outlook.com (2603:10b6:5:22b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 07:33:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 07:33:50 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: fix memory leak in btrfs_read_folio
Thread-Topic: [PATCH] btrfs: fix memory leak in btrfs_read_folio
Thread-Index: AQHabtqsEzLFfGzMfE2F0TolGh2w07Eo9xOAgAFcZIA=
Date: Wed, 6 Mar 2024 07:33:50 +0000
Message-ID: <kstutzjb3tsnpmbt2zfkylymvidbmxmehwjeys27cavhukpgqz@7vunqa5cerrm>
References:
 <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
 <CAL3q7H7-GVYr8S1mgim9khOLM7y-6rAhGyj7auEPX_BMUFpHGg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7-GVYr8S1mgim9khOLM7y-6rAhGyj7auEPX_BMUFpHGg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6892:EE_
x-ms-office365-filtering-correlation-id: 0fea2d4c-8a68-4284-b140-08dc3dafc4ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6CoOloadKSnXwoTtvqSoEsljL61gzaHz/HLdkYN1fQtAfL5UxlAPo9GApXPBPCHMldOLWFwxTfvjRikY0HCHl+RZE0NogZB98hM4tEBYhVcXs0ueYMg7/FFFdK4lFKDSnzqxEHwxiVtifrFaV3Diyd75Z0DQUrB3LmtIchp4mtl+8JDKwBImo1bF7wBxH5yMd0ZqqYKJNuMBvArXjoQUODwsrUkc9N2XX70in45WodcSS/2oEDfJc/1aGYBUMcOlhrdrRqGiLgtGskvsFOEdEbDmrA5WYYpIuPDU+AHiOrK88cz52TOdutvU7y2PFvSUOri/lbljp3DUMC8lswbtr+nFvS1KhhH90xpdpfv+ux0VeK0EDNEhGrr5UNPyzxyYhF35UVyEmrOo6ERwmPWO1QbsJR3JoGVGUZBwy6m8L9UsuR5Y7SVl/fVklmPI/CyeiQ7tLOyiDJBPEPj1kCW+zS3XYzLdf7ugrYekB6GFg2d/ukGpxO3k5j3dCjPHQy/jZDtvcyuz4cASLxQVB0ud06mFulmPm7Fu43jZl+nfnkbYUiu/VFE09p+u1vZ6Hb1/gkjPlf5UQEJd97xELxZi0nQWFr0BunIzkKiOKP34+gGJJndO3mEQkjsMZM3nLsnTaVmcUlfusJMiRxgpAnkY3p/2OlybJzmyUnuPxB9SZxTH8H9j3dhoofzWoYngYiEUD2xp7KuXb3vWDIgqe0fb4tMGi2227VgA0HJTCfZgV2U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzMzdm12VFV5dGE4Q3BGMTFPYW16M1VlS1g0NzhDWmJxQ1JSOGNmM3hmeEU0?=
 =?utf-8?B?by8xdkxIaktIMUhheWc0SkZpS3pXLzhGV0hneG1tRnBHb0NZUU9pS291ckhv?=
 =?utf-8?B?dDNHUDY4dExqa0o0TDRvOE9Rb3pzTXhjQXkwZGw2K0s4SFZKcnZMWTBhamM4?=
 =?utf-8?B?OS9yT3VhV0dNMXI5NWtyelltd3RDVW83NlFlUk92QjBLVGJDNFhmSVNNaEdi?=
 =?utf-8?B?cWwvbTNKTTdvdnROOTBIREM3VHdLVFRMUXVtbkpheTl2NHdqRG03SU9pRmRG?=
 =?utf-8?B?N1EyYmpTRUdwMnJncVFWNmI0WUF2cUQ4R1V1bm4waC9TTy9jaXJwazJrYnpI?=
 =?utf-8?B?eXFJK25XTXFmSVBMS3ZGYnQ0TEdJTEZxdnFtZFhVRGNyR2hBNFNiWHZVNlFV?=
 =?utf-8?B?bTZtaDdobjAydlpHS0dZMDdZaEFUKzhtaWRIM2N0K2NsMnpLa0t0KzRnYlZO?=
 =?utf-8?B?ZjJReFBhSzFBSERsUjlxSXpkUUtVREU2UWluTzVoUWU1b3FHRTJmVDZDaW5T?=
 =?utf-8?B?TjVwK2xaNWkyVjNzSnFqTGI2R3NDK3pPbVo2b0xYeVZpdHhrUHFlUGVFYklU?=
 =?utf-8?B?T040Witla0oxeXlQZEFrSGhJSTZXQXhvbkRDemdKWmJHK3pveDlPRXlyNmcx?=
 =?utf-8?B?QmljY2gwTm8zVlFXNUtOWjcrSmIzRUtuM01jUFhZbStCQUs0ZlpML0ZnQ3JJ?=
 =?utf-8?B?ZkQ5c0NBMlVQdDBUMkloaEQrWlIxVXBieHBuVDFrU3JtR05tcThOWVUybCsz?=
 =?utf-8?B?YzFEVytkcDBhajZ5aDdSRm5TMWxjZXo2YmpUaU5YN3Q1U2xTQnpydTRmNkdV?=
 =?utf-8?B?K1ltNjBJc2RmczBzUWM4TW50cXVvUFdHTFl2VXR1Q3lUYXlDb1NTNmlhRlha?=
 =?utf-8?B?d3lwZ3M5ZGlhVWhoWEt3SHhiOUhaNFh3VU5wTmNuWU8zbjNZK040OVFmU294?=
 =?utf-8?B?aFJzNlpZNlpveVBPWFdhUXkzK1NLMWM5U3JBSnhCSGpqUWUvWUZ2SExQdmlD?=
 =?utf-8?B?SitzWjQrVktDWWs5WmpYZ3ZLN3k1NVhkd283QWZCSURFbm10TWs5QUVxODBS?=
 =?utf-8?B?UVZZOFNhbE9WTHMvT0haUVo2SFhqWk1zd2V0T2ExU1ZwUXFOYUZGL1RBem84?=
 =?utf-8?B?aGp0Z3laZ1V5NnBWUndyZWlzWUFraHF1dnhoSjNITFg5eWUwbmxlbkxGK254?=
 =?utf-8?B?NWhIdEhhNGhEYXdwNWtGaUJjeklvSW9qa0JXcWdzNDgxQS9XeDhERVV6VVFn?=
 =?utf-8?B?d2paZDBQWk5hdGRFWjNBMFB1YVZuTFVxS1ZuNk9yVkJrajFiM3pMN3VlbmdP?=
 =?utf-8?B?a05jclNFQWcvRHFqTUpham1TVnF2RUJ1bjVXbzMybUZ1b2REWlR5V0tSczJ4?=
 =?utf-8?B?QTQ1VTExM3VFQVVQRXJhRUdlcXE5Qkk2Q3ZXcWFyWHQ0S1BGa2ZKYkFpYU43?=
 =?utf-8?B?a0FhdmlTQzg5Nk5EZWNCODBiT1pnckVLR25GYkdUSnlmQklBR2V5Y1NFeDlw?=
 =?utf-8?B?czNiMURDd1J2NUExM3dJSDBqeEF6NXMweXFTNzdLZEZhQ3VRMm91Q3QrYytr?=
 =?utf-8?B?dnJhb3VUU0dpdko0L3UwTk16VHdJdU1Mb1RPRUdPOWtLUE9nQ0xnNkhLSDlM?=
 =?utf-8?B?VmJTN09OVUh0QmZBS2xUQXRpUk5iQXpFWGxvTTVpbUl3dmZkaFRsOVl3Y0Q1?=
 =?utf-8?B?MmVZU1h6WkRORlVjMGJiY3B3cXdqTUl6U1RvT2NsSFg5cTRsbUo3MVRwanNk?=
 =?utf-8?B?cnBFZkJqRzVBRGdrRjVPaXVGclkyMXdEYmZJUWJKMVZ6bzJsV083blBHSmdR?=
 =?utf-8?B?V25KWkc0TmlhRGlpZkRpdXZ3NEZBOXRCbjFsazVhRytnZnY0NFJUR1VmNnph?=
 =?utf-8?B?UEs2OTNGY3hPNTVIM2NEUjFpYTJCZ3pJZU5aRW5vRzRDcVFoeGRNYkJNQUNz?=
 =?utf-8?B?YW9oNVNrc1EvcW9pZ0REMU1VeU1IbDEzZEtrc3BSSGhqVnBwbnFtYkNSdEJu?=
 =?utf-8?B?cnRCeEpRcjduMkVpcUxKWFQybnBUWDZBK1QzMER5bjZHWldjOUVycVVXenVp?=
 =?utf-8?B?eWRvSTBsSEo0WndBZzNhbS9zTHdCZnY1VmRxTWFDcDJPZDFTV2hJTFdGbXY5?=
 =?utf-8?B?OWhvRU1RZXpCK3ROTTNqb0Y2MW9lbDluSVo4YXkvVEZEcm1YTnQ1Q295d3NH?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D9675906AD004DBD2707F2CC66C41D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3sLe3+Xepibvs85/wpnci/gO6CY1eBUf5SVN/KfQ3rRyuEag2sf80lmVe+FKFSLz9C/LuhSUxgO3JEKTluwnQ19zhr/aS9XsiNhNmdswQU21lblU5P2NnjIkyHi7G/SaMSysp7oXZ35s033qMBWiHK/6cxs2I/zmofxY3nYWwnn4EAARI90ltijm0UFdXoUwCKp2yA/3rOrRYVWsfkcqVDM1a39YMZpDVZE1lSsQX3PL4gGkkPRxnqX14IEr/lca0wLy0UJZsuRgKOH/V2T+g4FPyN/uh3cOI3+z6x2dYEAv6y58TCd8zJAzSC7Ypsn1JeX9Spo2t5P4RX+RQhLL9E0xM5qo+ZqjR71ZKReiAqu0DubIA0e05N1jV7+b0KALw3Wfm0dPIRJ7tm4BK0bvqczZJxtQX+REuBKYhzro3FwnGZpuThmbgmxOyu6E/d52mYgwtj9584NeKAX8tpG0VbHgax9zukslt8mMkLixokfUm/ZmZT2BRdCS7UbMTcmn7owfPg3swCGkFNb/a8QyHsau2IZ8KlBQz77wqVfL4URV+J3+dCHkhSKlnhQXFM/tPAcmTDy4oCM5NeDifnGbTKw7r8sMi16r0fw0pqlCBTrZSmqgJIVD1Oe3wvkc2NGP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea2d4c-8a68-4284-b140-08dc3dafc4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 07:33:50.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRaixJaafKGbrSmCazYlpdAq9FULbzR77O5nyqQrONiP1uWP2eEGzdRGvewyq1yIsNxMTiuQZw59At/sQ/cxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6892

T24gVHVlLCBNYXIgMDUsIDIwMjQgYXQgMTA6NDY6MzVBTSArMDAwMCwgRmlsaXBlIE1hbmFuYSB3
cm90ZToNCj4gT24gVHVlLCBNYXIgNSwgMjAyNCBhdCA4OjU04oCvQU0gSm9oYW5uZXMgVGh1bXNo
aXJuIDxqdGhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiA+DQo+ID4gQSByZWNlbnQgZnN0
ZXN0cyBydW4gd2l0aCBlbmFibGVkIGttZW1sZWFrIHJldmVhbGVkIHRoZSBmb2xsb3dpbmcgc3Bs
YXQ6DQo+ID4NCj4gPiAgIHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4MTAyNzZiZjgwIChz
aXplIDEyOCk6DQo+ID4gICAgIGNvbW0gImZzc3VtIiwgcGlkIDI0MjgsIGppZmZpZXMgNDI5NDkw
OTk3NA0KPiA+ICAgICBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMpOg0KPiA+ICAgICAgIDgwIGJm
IDc2IDAyIDgxIDg4IGZmIGZmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLnYuLi4uLi4uLi4u
Li4uDQo+ID4gICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4NCj4gPiAgICAgYmFja3RyYWNlIChjcmMgMWQwYjkzNmEp
Og0KPiA+ICAgICAgIFs8MDAwMDAwMDAwZmU0MmNmOD5dIGttZW1fY2FjaGVfYWxsb2MrMHgxOTYv
MHgzMTANCj4gPiAgICAgICBbPDAwMDAwMDAwYWRiNzJmZmQ+XSBhbGxvY19leHRlbnRfbWFwKzB4
MTUvMHg0MA0KPiA+ICAgICAgIFs8MDAwMDAwMDA4ZDkyNTlkNT5dIGJ0cmZzX2dldF9leHRlbnQr
MHhhMy8weDhlMA0KPiA+ICAgICAgIFs8MDAwMDAwMDAxNWEwNWU5YT5dIGJ0cmZzX2RvX3JlYWRw
YWdlKzB4MWE1LzB4NzMwDQo+ID4gICAgICAgWzwwMDAwMDAwMDYwZmRkYWNiPl0gYnRyZnNfcmVh
ZF9mb2xpbysweDc3LzB4OTANCj4gPiAgICAgICBbPDAwMDAwMDAwNTA5ZGRhMzY+XSBmaWxlbWFw
X3JlYWRfZm9saW8rMHgyNC8weDFlMA0KPiA+ICAgICAgIFs8MDAwMDAwMDBkZWUzYzFiND5dIGRv
X3JlYWRfY2FjaGVfZm9saW8rMHg3OS8weDJjMA0KPiA+ICAgICAgIFs8MDAwMDAwMDBiZjI5NDc2
Mj5dIHJlYWRfY2FjaGVfcGFnZSsweDE0LzB4NDANCj4gPiAgICAgICBbPDAwMDAwMDAwNDg2NTMx
NzI+XSBwYWdlX2dldF9saW5rKzB4MjUvMHhlMA0KPiA+ICAgICAgIFs8MDAwMDAwMDA5NGI1ZDA5
Nj5dIHZmc19yZWFkbGluaysweDg2LzB4ZjANCj4gPiAgICAgICBbPDAwMDAwMDAwNjk4YWI5NjY+
XSBkb19yZWFkbGlua2F0KzB4OTcvMHhmMA0KPiA+ICAgICAgIFs8MDAwMDAwMDBhNTVhMmI0Yz5d
IF9feDY0X3N5c19yZWFkbGluaysweDE5LzB4MjANCj4gPiAgICAgICBbPDAwMDAwMDAwNmUxYjYw
OGU+XSBkb19zeXNjYWxsXzY0KzB4NzcvMHgxNTANCj4gPiAgICAgICBbPDAwMDAwMDAwOGZjYzZl
NDk+XSBlbnRyeV9TWVNDQUxMXzY0X2FmZXJfaHdmcmFtZSsweDZlLzB4NzYNCj4gPg0KPiA+IFRo
aXMgbGVha2VkIG9iamVjdCBpcyB0aGUgJ2VtX2NhY2hlZCcgZXh0ZW50IG1hcCwgd2hpY2ggd2ls
bCBub3QgYmUgZnJlZWQNCj4gPiB3aGVuIGJ0cmZzX3JlYWRfZm9saW8oKSBmaW5pc2hlcyBpZiBp
dCBpcyBzZXQuDQo+IA0KPiBPaywgc28gdGhpcyBmaXhlcyAiYnRyZnM6IHBhc3MgYSB2YWxpZCBl
eHRlbnQgbWFwIGNhY2hlIHBvaW50ZXIgdG8NCj4gX19nZXRfZXh0ZW50X21hcCgpIi4NCj4gDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9idHJmcy9leHRlbnRfaW8uYyB8IDIgKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL2J0cmZzL2V4dGVudF9pby5jIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMNCj4gPiBpbmRl
eCA2NWU0YzhmYzg5YjEuLjgzMmJlOTAzMGFhMSAxMDA2NDQNCj4gPiAtLS0gYS9mcy9idHJmcy9l
eHRlbnRfaW8uYw0KPiA+ICsrKyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jDQo+ID4gQEAgLTExNjIs
NiArMTE2Miw4IEBAIGludCBidHJmc19yZWFkX2ZvbGlvKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1
Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICAgICAgICAgYnRyZnNfbG9ja19hbmRfZmx1c2hfb3JkZXJl
ZF9yYW5nZShpbm9kZSwgc3RhcnQsIGVuZCwgTlVMTCk7DQo+ID4NCj4gPiAgICAgICAgIHJldCA9
IGJ0cmZzX2RvX3JlYWRwYWdlKHBhZ2UsICZlbV9jYWNoZWQsICZiaW9fY3RybCwgTlVMTCk7DQo+
ID4gKyAgICAgICBpZiAoZW1fY2FjaGVkKQ0KPiA+ICsgICAgICAgICAgICAgICBmcmVlX2V4dGVu
dF9tYXAoZW1fY2FjaGVkKTsNCj4gDQo+IFRoZXJlJ3Mgbm8gbmVlZCBmb3IgdGhlIGlmIG5vdC1O
VUxMIGNoZWNrLg0KPiBMaWtlIG1vc3QgZnJlZWluZyBmdW5jdGlvbnMgaW4gdGhlIGtlcm5lbCAo
a2ZyZWUsIGt2ZnJlZSwgbW9zdCBvZg0KPiBidHJmcycgb3duKSBhbmQgdXNlciBzcGFjZSwgZnJl
ZV9leHRlbnRfbWFwKCkgaWdub3JlcyBhIE5VTEwgcG9pbnRlci4NCg0KRllJLCBnZXRfZXh0ZW50
X2FsbG9jYXRpb25faGludCgpIGFuZCBleHRlbnRfcmVhZGFoZWFkKCkgZG9lcyB0aGUgc2FtZSAi
aWYNCihlbSkgZnJlZV9leHRlbnRfbWFwKGVtKTsiIHBhdHRlcm4sIHdoaWNoIHdlIG1heSB3YW50
IHRvIGNsZWFuIHVwLg0KDQo+IA0KPiBPdGhlcndpc2UgaXQgbG9va3MgZ29vZC4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBGaWxpcGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4gDQo+IFRoYW5r
cy4NCj4gDQo+ID4gICAgICAgICAvKg0KPiA+ICAgICAgICAgICogSWYgYnRyZnNfZG9fcmVhZHBh
Z2UoKSBmYWlsZWQgd2Ugd2lsbCB3YW50IHRvIHN1Ym1pdCB0aGUgYXNzZW1ibGVkDQo+ID4gICAg
ICAgICAgKiBiaW8gdG8gZG8gdGhlIGNsZWFudXAuDQo+ID4gLS0NCj4gPiAyLjM1LjMNCj4gPg0K
PiA+

