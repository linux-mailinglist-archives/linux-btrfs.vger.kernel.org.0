Return-Path: <linux-btrfs+bounces-5009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC58C6A4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED901281494
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FD15665D;
	Wed, 15 May 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UUlfEv/I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0JyrIfe6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2802156255
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789474; cv=fail; b=tWgQmAKXOlRKJVek7xGdVW2aNpgEwo8idTGzWcg9JKp9Mzz4ompqRpUGsbUcgYa96yzIDUVMVoNLBCF3we6c53N8Md8Gr+ozdyHQM8qqu5WrGHLgifB+lIY1RmtWnR3dv74UV7sP6NuNX+cRiyZoFLUwG9m9ryfO9DewybTW2+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789474; c=relaxed/simple;
	bh=hkwqEXfc82EAInz1ykCZpC8JWL7Y9fq/LVhWyKJl0t0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C/hYGmaJxKRYK3K9Kj3AujPmQf16T6bZk88AnAxh7Cezukx6t6voNe3MPxPEQEjA38ipVwHCZLItV9ZzLkXL9jmpMittnh34ro1axJyNS+eaiKN9a93U5ZS1ZkWKQb+U1BLmRD8mNgu+qJEZP0+jPZCgBjBcOgtrTimHqo6CMmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UUlfEv/I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0JyrIfe6; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715789471; x=1747325471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hkwqEXfc82EAInz1ykCZpC8JWL7Y9fq/LVhWyKJl0t0=;
  b=UUlfEv/IsJNo7vw+5MEdM5Z2K16LSag6nWRuVy4IaD8CrJvDLmhMOpk0
   tX9psSfi1i4kDkWr0F5LZ1OGDdCRJORwye/tm317xDrsrUDyX+bzNcDv7
   +4zD7/dv1GRwiD+2mZ6BhlPDiN3ARFMrfaGt9DNW6u5wYjI3tP7fGxKAO
   VGDNuvdOBQogVzMDohARQwiaq60qLlDtYVU5j/3p0/a62F1Awi4PYpXnn
   bfcUpoVvk223Spidn4OFW4/CLhIrm405j5qYiDL25jeCISycZoRNg+G3B
   jJgySWt8y5d1YwkMVb+YuGRYl+qg1ckfxf4yttPe6JpRt2HaT9XGs/KbK
   Q==;
X-CSE-ConnectionGUID: GlYyHvB1QNmpB5231Gg1Ug==
X-CSE-MsgGUID: KZuPaa1wQYiPC/CSFbBbqw==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="16650524"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2024 00:11:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIf8qXTbWhoO3Kja6Z+t/9jaiFKttMASXZ/FGUAQjvlLWEMvUydMFkTKYd2T80ysPR923pJdwqZYT8tSr95d36N+N298esMXXNzrqSijoW4W9PQtjLRClS5a0myqrvLBs9dcWsEnAYhSdgxKmgSwSNN+aIucomdj5ie8GPGOdXlZFi6T6rUugHM/3VSyoDf1y8CD7jE+e3lcQmWtbMbMmg8nYsf2oFx/nYaLkKlkqeq6A+VMZ8+MPg+Xp6fPuH5080GoddxflLeZo6ZArLy9FbOv7isYgrQQrk1/BbHDW9uD0nJb05gTiKevkIWcAfDRP1Ej1wHOwXb/S7fALURWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkwqEXfc82EAInz1ykCZpC8JWL7Y9fq/LVhWyKJl0t0=;
 b=m8FbPDT+tYgT4J+p2l3s5CA+eexmmJpVdaV85QCrd5yMpR9/6uTjUyNd69vBYhFP1m1bY2COMoNarNJXATdx8ICBVkPLeuJjVIyGR+LqqwAEu09oFvBiEQYYMXXk0ZQoXlTerZW554nP+aKt6JxR2NnS6ngpC5E9xstsy0DXBcCapRUeXdbfj8qP55GnXsWuI48PAUldzZPK5XuB2ld0XEJ142nCoRcdPkaBvG1YV3xuZmlV7Ke1YkHRwDKKOe4+TIxaNLRvsBqEt8JvPs5sc4H148CwgYCBEE9sK6ksyHADE0RTt89t8jmPNU1hg4sM9C9DrTkChUx5jqiaztt4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkwqEXfc82EAInz1ykCZpC8JWL7Y9fq/LVhWyKJl0t0=;
 b=0JyrIfe6T1V3rZKinbKPvNZx4Uz7LZFbhAw7l+ltecZMI8S6NJfb8y3Qch6IqrBnzAQlyoAFBfWYRjEO6m6FJ+IhfHOkbcHzQ6BSukDg5OEVxvr6ifLyH5km+Epy+VLYzwgHNqXrkL77EiwuJlwo+NX+TGDJPI3AkO3CVp//44s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB9032.namprd04.prod.outlook.com (2603:10b6:930:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 16:11:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 16:11:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] btrfs-progs: support byte length for zone
 resetting
Thread-Topic: [PATCH v2 6/8] btrfs-progs: support byte length for zone
 resetting
Thread-Index: AQHapiwGEjF1/Hx6V02DQCEiDsl96bGXWIeAgAEgCwA=
Date: Wed, 15 May 2024 16:11:03 +0000
Message-ID: <bxcsi225e5cpmvod6yx764nihpml6dyizjtgslmqajmvtn26mq@l2yuxz4myrye>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-7-naohiro.aota@wdc.com>
 <d971380b-1867-4e8f-b9c8-aeda8aec2c79@gmx.com>
In-Reply-To: <d971380b-1867-4e8f-b9c8-aeda8aec2c79@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB9032:EE_
x-ms-office365-filtering-correlation-id: 5a6db7a5-f8ef-463c-c841-08dc74f99e48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVl0R1dqOVkwS0hNYkZ0anpVeTZKeDB3SWttaURWUk1YTE5CQUlUYzhOWUY5?=
 =?utf-8?B?WUxCTlRjM2tsR25hb0pJUUNScEhPK3lETVBPZXNXb0pCSkRkNEZZLzcxZGdI?=
 =?utf-8?B?YnQ2ek5oVittbU1nd2VzU0Zwa3ZEQVowZ2I2dnFtYmN6c0YyQVdXcUdQcE9O?=
 =?utf-8?B?UTVUS3BSdGs3bHAyNENGakJtWjVKSkt5MmUxZlpNa20rcEZ3RzBOcEJpMVlT?=
 =?utf-8?B?NkRPTEJ3ZVBzZW9pVmYvYVg0am9xVCs4bG5LK25VL280em5jU1RJUzEzTGdE?=
 =?utf-8?B?V3VKRm5KbW43b3craXZ2cGdTdzR0UlRiRC93TEhaSWJvUytQYUNiVnM0ZGhI?=
 =?utf-8?B?NmwvR2FWTFFESjZMTW5TM1FRbFVUREJ2MlRrS3drUnVUQkU0SWRJbjh6SFpF?=
 =?utf-8?B?cXBiZCtmNlpTL2h6eWRpc2dOV3ZreDh4Y0ZraTBVWnhUd0hQZFdmd2VxdkxR?=
 =?utf-8?B?UnhodDIya1RpOGo0UmZ5UStsOG85b1FyYjE4bmNLTmJhVENuWnBpeEZmdHZH?=
 =?utf-8?B?RzBnYld1UXBMeWMySGxsRk1qRlNZSDNlL3hkV1pvRHdzSlJyemczTFRWdmcr?=
 =?utf-8?B?YzNXWVRYaXBSb2RXaTVnZDRHaXJJeUhpQXlFbmVhL2c1eHkyMnRPU2laQ3dM?=
 =?utf-8?B?UGlDU0s2VWRZRlBSMng3c2Y3TTJjOEk2QUlyaW9GOVU1QXhRTmN3ZnA0b0Nw?=
 =?utf-8?B?TWI2SVA3SXFqaVpLWVlZN2dHZGd4SHJlclBqS05PZllYeGE1UGxvbElLNGo1?=
 =?utf-8?B?N1g4QWtCKzlrUDQ5K2EyZml4T0JCclkrc3JUM0Rlb09URlRBK3MyK2hEYmtN?=
 =?utf-8?B?bGF5cVgwZE5yWWhhbFBHVWlqcWoxNEZvSVZTTnpTRFFPMGcybGtEK0d2aXgy?=
 =?utf-8?B?dm5hVTkvZURhbjU5VXQwdlVYMFhmWjViZjZ0bHFVWjBkVERiSFRpVVlKaDdz?=
 =?utf-8?B?ME9NTlB1akNpaWdOenhhZElpdWhUMFVIZDduVTEwT3lVRHFPcWhKU3lrTFFJ?=
 =?utf-8?B?T1hFcTBmdTc4aXlESm40VlpDbVVHSitieGlyb0RJRFlJZWExczd1aXJGeS9x?=
 =?utf-8?B?UVNSdGQyaXFrQVlHU3JhZTJwdWsxbVRlVmxXS25FeGtGcFY1elRYVk5ISzlB?=
 =?utf-8?B?dCtsOS9qRFRObTdYekRoY2RWRHgxTzNHWXN5Z2MwS2wwNzloR2U4bWNwQ1Zu?=
 =?utf-8?B?anlkaDJOazJzVmpLdG1vTFZ5QnRhckRoaDVIdDdPeklGNDF4WXVTR1JlOTJC?=
 =?utf-8?B?Wmh1bUpCSEJGbG9RNm9rU1B6ZnZBQTJGMnBmWTBZYmJvRVhpamtQNklENTdz?=
 =?utf-8?B?MVVHTnh1Y1l1dzRpMXlrdWZtRWpUWFFWY2RUa2tzdDQ3MXcrdmJLNkF5Zm5Q?=
 =?utf-8?B?cHpzbTk2RHZTa2NBUUJaS1k4a2tPcHdaNnh5d0M3VmZ5cmd6R0M3OEx1RDVi?=
 =?utf-8?B?Z0ZxVGtUWkxscFhxNGFvOWFZT2J2bE9NNVZRY0hxL3ZGSmtKOFNUUXk2V0g5?=
 =?utf-8?B?cGtLRGNuN1d1MFgxSFArcnVXZlQyN25NSURMTVIrQ2Q2M1ZUZGZHcXlQb3pS?=
 =?utf-8?B?SEx1cjhYVzRmSFI3eExLZ0NZaHgvT20wRHB5NmFhQzBVZWI0NFAySFJxN0t1?=
 =?utf-8?B?OGt5ak8yY2FIcFhYb0t4YWhJZ2lFNVZ4bGxKMjFOcDN6b25hd1l4YmErLy8z?=
 =?utf-8?B?dFMrZTJVVGpFYTBYVGJFbm0xTVlodk4zRzJmOUhNQ2huWk84alVqS3hnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1h5MEljSjBTcTJLQW5mMHRNMWFNN0RJUmU2b0xhbDNnU2FkSWNJUFV2Qkpr?=
 =?utf-8?B?WkFONnNTTktqNGp5MDRSM0hWbTFBaGM0bE1iQkNNZmtGU0VFTk9yLzdkRnZ6?=
 =?utf-8?B?MCtCMGVObGtYWUxoUTl3WUFtVVNJTFprT0I4dUUyRDNVd21UeUpNTVR3WUZM?=
 =?utf-8?B?RnY0UndySXYrTnExNTlST0JXTTQrNkl5V08yMlJoZWFtdkIwTU9MaHN1YlRP?=
 =?utf-8?B?SHBRb0RMNEVhY21Hb2hWOVlDVlJuS3ROM3grTHV5UzhGaWZlSjk1OS9ocXh3?=
 =?utf-8?B?TEp0TWJVSHBhSVN3a1ZUOXprbzgyQnB6WnhjRDVwcC9JVXk3bFdFRzd0NCtZ?=
 =?utf-8?B?U2ZCd29QY1NIVkJWeFlTTk9SdnUwaUVUaGtDL3RCb0pqTmJ5MTk1TlB5Y0dN?=
 =?utf-8?B?RmZpcVhLb0FvS3FXRnpKYlhCSWhMQUpYWmRvN3BlMjVsbXJYNGJiRW5ZYUdZ?=
 =?utf-8?B?ZnJtSVhHK2lZa0FxazJVQmJTNFVNdlhoNThkTzVMeDNNMWtZcU12bkpXdE1M?=
 =?utf-8?B?dkJiVzJQRmlYaDk0UytnbWN6d1dTblFyQTBKYysxWDFBbS9kZGY5UGJPOGxS?=
 =?utf-8?B?LzR2TDF5MWlsQm5DM2hhVllyNDdjVHFkaDR5VjZ4cjNaNkt5UUdzcTRsOGo1?=
 =?utf-8?B?VDg3UE42bWFPMEJnOE15M0xlOTVoakF3MnhCYUxoRDhSNDdraGZWMUhoYmg0?=
 =?utf-8?B?Z2JISEtIY2UwcjRYeTJvRElyV29RMHBsUktQL0NrcC95OXdHOUt4enB3bzNt?=
 =?utf-8?B?ZWtGQzRQMExkWkZWaWZJTkpraytraTI2Ym8weG1rWjUwU25mVTQwMUJLak9V?=
 =?utf-8?B?aFVlOW5KcUVUUTE4cXlVbjN3RDQyTk9qMkk2cHYzZDFQL0NXT3pTWlI4Nmtn?=
 =?utf-8?B?Nkpld05uU1pkV3VjRm1veGFhQWQvRFh2NnBkZENXT1hhWHY4VEpMZmRsb0tD?=
 =?utf-8?B?V2tWdTM0aGJlQS9kUWkwTW5XN0Rsc1NpUWFvMmlZTU1EWXQyZ3dORitJam1J?=
 =?utf-8?B?Q3hYSlFKc3czTmxYaXJmVEhUaEVGb0g5aW5hUGk2N0hmQW5CbDU2VXRNdlpC?=
 =?utf-8?B?OXcvSGpLUGZldVY0aXQ3dExpdlZzdGpNaWl5Z0lQMWszWlFCdUxUdUZ0NlV2?=
 =?utf-8?B?ME1Yc1V5L083cGF5Z01aS2NZcWxMWGk4M0lkSGdHL1JLR2c2WGx6SVVpcnF0?=
 =?utf-8?B?TGRlOVBFNy9xdmJpbldIRno1ZnYxc2w0YjIwQUpEcWl1MHcwM3AydUczN2RK?=
 =?utf-8?B?dGFMVzlaM1F1MFl5QVcvNHdmZjZIbkxhZFJMdmR6Y0grZFh6MlhEUHp1Z1JV?=
 =?utf-8?B?eWZQSUNpdndCTkdYbUEzMCtBSEpuT2xlSjlCWHo0TEZ3SkRabGwzcmRlQ1RI?=
 =?utf-8?B?dFFtNmo4N1NXUzZLSE1hYklUQitLazVDZFlzUkY2cnVDRW01R1lPUzIxT1BM?=
 =?utf-8?B?K0FiTDBpUG1KZHlCZmxDK3NUMGpHQjFad3VOUUo1TytCdWFYeEo3UlAwNWkw?=
 =?utf-8?B?TnRwQ3VOTi9pVUN0RG9HZllSakNLY2RtNFZtcXdHSk0wbUtFYmdMZWhzbVZ5?=
 =?utf-8?B?UmZkZms0UlFFZ1I3NDdWaHRaODdaVENuUStqQUV4ZkNnSTErOExGSlhuRVho?=
 =?utf-8?B?c296cHVyNGdvMUFtVlA2VVVGalVuNWhEaVdpeXArSXRWbVJwVGxFMlBVWFl2?=
 =?utf-8?B?aWFLSnkxNy93cnFHNTE1N1IvaXMwWlBPUjRTdzBrNEhwaTQ0Q0U1KzQxTDVY?=
 =?utf-8?B?S0xZY2ZqOXN1MTdQTS9Cam5FSFNKbCs1U29xSklvS1o2b0N0c0xzZUNhczRI?=
 =?utf-8?B?N21qazN6V3lGYU1WRWtZUUw4UmRPd1Bjc1IwbjdKREpwSWNDRUZ6WjVuUmVl?=
 =?utf-8?B?ZC9EZWhkQVY0TG5PTHpvclgrbW5XS2Y3bzJxZkhmaUJCT2NZNjc0Zk9LSTc2?=
 =?utf-8?B?QzFLZUNRL3lzWGpydTBYUFVKUkJ4QndrYWFVY1RrekFwOEsvWGlIOU5oRkVh?=
 =?utf-8?B?cUppYnFLSjRjaU05WTRKdW5KaVVPUi9Mb1FJdlIxWnk3MzZrSU9GT0JCc1lV?=
 =?utf-8?B?ckd3dUFGTlphQzZzSlY3aG5JNFBhR0VrS1l5cHhYbGhDY3FZR21ZSURpYUp1?=
 =?utf-8?Q?swF14+8fSz/U5gcrSDE2Cfmlt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7A3F773971D4745A94BB465DEB5E9FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lcvHp7/hJGecQDIuLd6OaQsESO8JOS8NnB9pzqCUmvGNJCeIRrBeW4ahuqI7XLIcVps0pc7UoTv9thnLrwwMDfrocoxKzzCa1VL7T2rwAwKOpC0tYRD0xo+xvUHBwr5+e3Qr/iy6N1TmxydeXmdlfdfIZNUYOAUBv6laNJXcLg8MYaXplB+ggTSzgLJ8hJ15zLE94TWO8qMhPM6dwITTmODaIzc6TJ7z8VXrLMM09Scof20bEyKCuTiHMDRAoL8qPMvr2OHh6KkmZAwGnxJBBC202jii34feIor6SNn48ZyNok0lgu6MyzzTEAxeyt5L7Qan4QWupHwPuHGpkV5KHwF2lm/fpYFHEgUjADtHImiuNeuXd4dXR2haVH2j01SWL8vykGSCQID25uU3jAfr59gHVwz6m7UyUwHqOZBjgA3xoFGY3vgYJt0Ch22XnEwFy3kXWCwdqtr7J171bc5NFb294qsFOfAnpmnFCofg8VkDY/4oWMAWryIL0FMd5TCDfEV0e5m3vRg4HeA6i2FHHbSSB1oRpcqXgAoF8pTGahEvk34Dr6JLuRM0rYsNO7OE4tzuSg7Y1i1Bydkzlaz1rXqnijwZhiuhJbMe+UCCsqpmsjaAPQ0Ds2Nob5nK2QPX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6db7a5-f8ef-463c-c841-08dc74f99e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 16:11:03.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjKRCpgP4IVHqWEgmCWq179SuIOEMnsCJWasHZyF5EfAttFUCoC7k2gLbcGik7KqEOwpr13U0iuLi1PrWuTPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9032

T24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMDg6Mjk6NTVBTSArMDkzMCwgUXUgV2VucnVvIHdyb3Rl
Og0KPiANCj4gDQo+IOWcqCAyMDI0LzUvMTUgMDM6NTIsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+
ID4gRXZlbiB3aXRoICJta2ZzLmJ0cmZzIC1iIiwgbWtmcy5idHJmcyByZXNldHMgYWxsIHRoZSB6
b25lcyBvbiB0aGUgZGV2aWNlLg0KPiA+IExpbWl0IHRoZSByZXNldCB0YXJnZXQgd2l0aGluIHRo
ZSBzcGVjaWZpZWQgbGVuZ3RoLg0KPiA+IA0KPiA+IEFsc28sIHdlIG5lZWQgdG8gY2hlY2sgdGhh
dCB0aGVyZSBpcyBubyBhY3RpdmUgem9uZSBvdXRzaWRlIG9mIHRoZSBGUw0KPiA+IHJhbmdlLiBJ
ZiB0aGVyZSBpcyBvbmUsIGJ0cmZzIGZhaWxzIHRvIG1lZXQgdGhlIGFjdGl2ZSB6b25lIGxpbWl0
IHByb3Blcmx5Lg0KPiANCj4gTWluZCB0byBleHBsYWluIG1vcmUgb24gd2h5IGFuIGFjdGl2ZSB6
b25lICpvdXRzaWRlKiBvZiB0aGUgZnMgcmFuZ2UgaXMNCj4gYSBwcm9ibGVtPw0KPiANCj4gSXQn
cyBwcmV0dHkgaW5zdGluY3RpdmUgdG8gY29uc2lkZXIgc3VjaCBhY3RpdmUgem9uZXMgb3V0IG9m
IHRoZSBmcw0KPiByYW5nZSBhcyBub24tZXhpc3QsIHRodXMgc2hvdWxkIG5vdCBjYXVzZSBtdWNo
IHByb2JsZW0gKHVudGlsIHdlIHdhbnQgdG8NCj4gZXhwYW5kIHRoZSBmcyBldGMpLg0KPiANCj4g
VGhpcyBzaG91bGQganVzdCBhY3RzIGxpa2UgdGhlIGRhdGEgYmV5b25kIGZzIHJhbmdlIGluIHRy
YWRpdGlvbmFsDQo+IGRldmljZXMsIGFuZCB3ZSBuZXZlciByZWFsbHkgYm90aGVyZWQgdGhlbS4N
Cg0KQSB6b25lZCBkZXZpY2UgbWF5IGhhdmUgYW4gdXBwZXIgbGltaXQgb24gdGhlIG51bWJlciBv
ZiBhY3RpdmUgem9uZXMsIHNvDQp5b3UgY2Fubm90IHdyaXRlIGludG8gem9uZXMgYmV5b25kIHRo
YXQgbGltaXQgYXQgdGhlIHNhbWUgdGltZS4gDQoNCmh0dHBzOi8vem9uZWRzdG9yYWdlLmlvL2Rv
Y3MvaW50cm9kdWN0aW9uL3pucyN6b25lLXJlc291cmNlcy1saW1pdHMNCg0KU28sIGlmIHdlIGhh
dmUgYW4gYWN0aXZlIHpvbmUgb3V0c2lkZSB0aGUgRlMsIGJ0cmZzIGNhbm5vdCB1dGlsaXplIGFs
bCB0aGUNCmFjdGl2ZSB6b25lcyBmb3IgaXQuIEluIHRoZSB3b3JzdCBjYXNlLCBpZiB5b3UgaGF2
ZSBhbiBhY3RpdmUgem9uZSBsaW1pdCA9DQo4IGFuZCA1IHpvbmVzIGFyZSBhbHJlYWR5IHVzZWQg
b3V0c2lkZSB0aGUgRlMsIHdlIGNhbm5vdCBtYWludGFpbiB0aGUNCm1pbmltdW0gbmVjZXNzYXJ5
IDQgYWN0aXZlIHpvbmVzOiBzdXBlcmJsb2NrLCBkYXRhLCBtZXRhZGF0YSwgYW5kIHN5c3RlbQ0K
YmxvY2sgZ3JvdXAuDQoNClRlY2huaWNhbGx5LCB3ZSBjYW4gc2NhbiBhbGwgdGhlIGRldmljZSB6
b25lcyB0byBjb3VudCBhY3RpdmUgem9uZXMgYW5kIHRyeQ0KdG8gbGl2ZSB3aXRoIHRoZSByZXN0
LiBCdXQsIEkgZG9uJ3Qgc2VlIGEgY2xlYXIgdXNlIGNhc2UgZm9yIHRoYXQuDQogIA0KSG93ZXZl
ciAuLi4gSSBqdXN0IG5vdGljZWQgd2UgZG8gaXQgc28gYmVjYXVzZSB0aGUgY3VycmVudCBtb3Vu
dCBjb2RlIG5ldmVyDQpjaGVja3MgdGhlIGJ0cmZzX2RldmljZS0+dG90YWxfYnl0ZXMuIFRoZSBt
aW51bXVtIGFjdGl2ZSB6b25lIHJlcXVpcmVtZW50DQpjaGVjayBpcyBicm9rZW4gZm9yIHRoZSAi
LWIiIGNhc2UsIHRob3VnaC4NCg0KSSBiZWxpZXZlIG1hbmRhdGluZyBubyBhY3RpdmUgem9uZXMg
b3V0c2lkZSB0aGUgRlMgYm90aCBhdCBta2ZzIGFuZCBtb3VudA0KdGltZSBpcyBhIGNsZWFuIHdh
eSB0byBnbyB1bmxlc3MgdGhlcmUgaXMgYSByZXF1ZXN0IHdpdGggYSBnb29kIHJlYXNvbi4NCg0K
PiBUaGFua3MsDQo+IFF1DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90
YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gICBjb21tb24vZGV2aWNlLXV0
aWxzLmMgfCAxNyArKysrKysrKysrKystLS0tLQ0KPiA+ICAga2VybmVsLXNoYXJlZC96b25lZC5j
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIGtlcm5lbC1zaGFyZWQvem9uZWQu
aCB8ICA3ICsrKystLS0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvY29tbW9uL2RldmljZS11dGls
cy5jIGIvY29tbW9uL2RldmljZS11dGlscy5jDQo+ID4gaW5kZXggODY5NDJlMGM3MDQxLi43ZGY3
ZDljZTM5ZDggMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL2RldmljZS11dGlscy5jDQo+ID4gKysr
IGIvY29tbW9uL2RldmljZS11dGlscy5jDQo+ID4gQEAgLTI1NCwxNiArMjU0LDIzIEBAIGludCBi
dHJmc19wcmVwYXJlX2RldmljZShpbnQgZmQsIGNvbnN0IGNoYXIgKmZpbGUsIHU2NCAqYnl0ZV9j
b3VudF9yZXQsDQo+ID4gDQo+ID4gICAJCWlmICghemluZm8tPmVtdWxhdGVkKSB7DQo+ID4gICAJ
CQlpZiAob3BmbGFncyAmIFBSRVBfREVWSUNFX1ZFUkJPU0UpDQo+ID4gLQkJCQlwcmludGYoIlJl
c2V0dGluZyBkZXZpY2Ugem9uZXMgJXMgKCV1IHpvbmVzKSAuLi5cbiIsDQo+ID4gLQkJCQkgICAg
ICAgZmlsZSwgemluZm8tPm5yX3pvbmVzKTsNCj4gPiArCQkJCXByaW50ZigiUmVzZXR0aW5nIGRl
dmljZSB6b25lcyAlcyAoJWxsdSB6b25lcykgLi4uXG4iLA0KPiA+ICsJCQkJICAgICAgIGZpbGUs
IGJ5dGVfY291bnQgLyB6aW5mby0+em9uZV9zaXplKTsNCj4gPiAgIAkJCS8qDQo+ID4gICAJCQkg
KiBXZSBjYW5ub3QgaWdub3JlIHpvbmUgcmVzZXQgZXJyb3JzIGZvciBhIHpvbmVkIGJsb2NrDQo+
ID4gICAJCQkgKiBkZXZpY2UgYXMgdGhpcyBjb3VsZCByZXN1bHQgaW4gdGhlIGluYWJpbGl0eSB0
byB3cml0ZQ0KPiA+ICAgCQkJICogdG8gbm9uLWVtcHR5IHNlcXVlbnRpYWwgem9uZXMgb2YgdGhl
IGRldmljZS4NCj4gPiAgIAkJCSAqLw0KPiA+IC0JCQlpZiAoYnRyZnNfcmVzZXRfYWxsX3pvbmVz
KGZkLCB6aW5mbykpIHsNCj4gPiAtCQkJCWVycm9yKCJ6b25lZDogZmFpbGVkIHRvIHJlc2V0IGRl
dmljZSAnJXMnIHpvbmVzOiAlbSIsDQo+ID4gLQkJCQkgICAgICBmaWxlKTsNCj4gPiArCQkJcmV0
ID0gYnRyZnNfcmVzZXRfem9uZXMoZmQsIHppbmZvLCBieXRlX2NvdW50KTsNCj4gPiArCQkJaWYg
KHJldCkgew0KPiA+ICsJCQkJaWYgKHJldCA9PSBFQlVTWSkgew0KPiA+ICsJCQkJCWVycm9yKCJ6
b25lZDogZGV2aWNlICclcycgY29udGFpbnMgYW4gYWN0aXZlIHpvbmUgb3V0c2lkZSBvZiB0aGUg
RlMgcmFuZ2UiLA0KPiA+ICsJCQkJCSAgICAgIGZpbGUpOw0KPiA+ICsJCQkJCWVycm9yKCJ6b25l
ZDogYnRyZnMgbmVlZHMgZnVsbCBjb250cm9sIG9mIGFjdGl2ZSB6b25lcyIpOw0KPiA+ICsJCQkJ
fSBlbHNlIHsNCj4gPiArCQkJCQllcnJvcigiem9uZWQ6IGZhaWxlZCB0byByZXNldCBkZXZpY2Ug
JyVzJyB6b25lczogJW0iLA0KPiA+ICsJCQkJCSAgICAgIGZpbGUpOw0KPiA+ICsJCQkJfQ0KPiA+
ICAgCQkJCWdvdG8gZXJyOw0KPiA+ICAgCQkJfQ0KPiA+ICAgCQl9DQo+ID4gZGlmZiAtLWdpdCBh
L2tlcm5lbC1zaGFyZWQvem9uZWQuYyBiL2tlcm5lbC1zaGFyZWQvem9uZWQuYw0KPiA+IGluZGV4
IGZiMWUxMzg4ODA0ZS4uYjQyNDQ5NjZjYTM2IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC1zaGFy
ZWQvem9uZWQuYw0KPiA+ICsrKyBiL2tlcm5lbC1zaGFyZWQvem9uZWQuYw0KPiA+IEBAIC0zOTUs
MTYgKzM5NSwyNCBAQCBzdGF0aWMgaW50IHJlcG9ydF96b25lcyhpbnQgZmQsIGNvbnN0IGNoYXIg
KmZpbGUsDQo+ID4gICAgKiBEaXNjYXJkIGJsb2NrcyBpbiB0aGUgem9uZXMgb2YgYSB6b25lZCBi
bG9jayBkZXZpY2UuIFByb2Nlc3MgdGhpcyB3aXRoIHpvbmUNCj4gPiAgICAqIHNpemUgZ3JhbnVs
YXJpdHkgc28gdGhhdCBibG9ja3MgaW4gY29udmVudGlvbmFsIHpvbmVzIGFyZSBkaXNjYXJkZWQg
dXNpbmcNCj4gPiAgICAqIGRpc2NhcmRfcmFuZ2UgYW5kIGJsb2NrcyBpbiBzZXF1ZW50aWFsIHpv
bmVzIGFyZSByZXNldCB0aG91Z2ggYSB6b25lIHJlc2V0Lg0KPiA+ICsgKg0KPiA+ICsgKiBXZSBu
ZWVkIHRvIGVuc3VyZSB0aGF0IHpvbmVzIG91dHNpZGUgb2YgdGhlIEZTIGlzIG5vdCBhY3RpdmUs
IHNvIHRoYXQNCj4gPiArICogdGhlIEZTIGNhbiB1c2UgYWxsIHRoZSBhY3RpdmUgem9uZXMuIFJl
dHVybiBFQlVTWSBpZiB0aGVyZSBpcyBhbiBhY3RpdmUNCj4gPiArICogem9uZS4NCj4gPiAgICAq
Lw0KPiA+IC1pbnQgYnRyZnNfcmVzZXRfYWxsX3pvbmVzKGludCBmZCwgc3RydWN0IGJ0cmZzX3pv
bmVkX2RldmljZV9pbmZvICp6aW5mbykNCj4gPiAraW50IGJ0cmZzX3Jlc2V0X3pvbmVzKGludCBm
ZCwgc3RydWN0IGJ0cmZzX3pvbmVkX2RldmljZV9pbmZvICp6aW5mbywgdTY0IGJ5dGVfY291bnQp
DQo+ID4gICB7DQo+ID4gICAJdW5zaWduZWQgaW50IGk7DQo+ID4gICAJaW50IHJldCA9IDA7DQo+
ID4gDQo+ID4gICAJQVNTRVJUKHppbmZvKTsNCj4gPiArCUFTU0VSVChJU19BTElHTkVEKGJ5dGVf
Y291bnQsIHppbmZvLT56b25lX3NpemUpKTsNCj4gPiANCj4gPiAgIAkvKiBab25lIHNpemUgZ3Jh
bnVsYXJpdHkgKi8NCj4gPiAgIAlmb3IgKGkgPSAwOyBpIDwgemluZm8tPm5yX3pvbmVzOyBpKysp
IHsNCj4gPiArCQlpZiAoYnl0ZV9jb3VudCA9PSAwKQ0KPiA+ICsJCQlicmVhazsNCj4gPiArDQo+
ID4gICAJCWlmICh6aW5mby0+em9uZXNbaV0udHlwZSA9PSBCTEtfWk9ORV9UWVBFX0NPTlZFTlRJ
T05BTCkgew0KPiA+ICAgCQkJcmV0ID0gZGV2aWNlX2Rpc2NhcmRfYmxvY2tzKGZkLA0KPiA+ICAg
CQkJCQkgICAgIHppbmZvLT56b25lc1tpXS5zdGFydCA8PCBTRUNUT1JfU0hJRlQsDQo+ID4gQEAg
LTQxOSw3ICs0MjcsMjAgQEAgaW50IGJ0cmZzX3Jlc2V0X2FsbF96b25lcyhpbnQgZmQsIHN0cnVj
dCBidHJmc196b25lZF9kZXZpY2VfaW5mbyAqemluZm8pDQo+ID4gDQo+ID4gICAJCWlmIChyZXQp
DQo+ID4gICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCQlieXRlX2NvdW50IC09IHppbmZv
LT56b25lX3NpemU7DQo+ID4gICAJfQ0KPiA+ICsJZm9yICg7IGkgPCB6aW5mby0+bnJfem9uZXM7
IGkrKykgew0KPiA+ICsJCWNvbnN0IGVudW0gYmxrX3pvbmVfY29uZCBjb25kID0gemluZm8tPnpv
bmVzW2ldLmNvbmQ7DQo+ID4gKw0KPiA+ICsJCWlmICh6aW5mby0+em9uZXNbaV0udHlwZSA9PSBC
TEtfWk9ORV9UWVBFX0NPTlZFTlRJT05BTCkNCj4gPiArCQkJY29udGludWU7DQo+ID4gKwkJaWYg
KGNvbmQgPT0gQkxLX1pPTkVfQ09ORF9JTVBfT1BFTiB8fA0KPiA+ICsJCSAgICBjb25kID09IEJM
S19aT05FX0NPTkRfRVhQX09QRU4gfHwNCj4gPiArCQkgICAgY29uZCA9PSBCTEtfWk9ORV9DT05E
X0NMT1NFRCkNCj4gPiArCQkJcmV0dXJuIEVCVVNZOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAly
ZXR1cm4gZnN5bmMoZmQpOw0KPiA+ICAgfQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwt
c2hhcmVkL3pvbmVkLmggYi9rZXJuZWwtc2hhcmVkL3pvbmVkLmgNCj4gPiBpbmRleCA2ZWJhODZk
MjY2YmYuLjJiZjI0Y2JiYTYyYSAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwtc2hhcmVkL3pvbmVk
LmgNCj4gPiArKysgYi9rZXJuZWwtc2hhcmVkL3pvbmVkLmgNCj4gPiBAQCAtMTQ5LDcgKzE0OSw3
IEBAIGJvb2wgYnRyZnNfcmVkaXJ0eV9leHRlbnRfYnVmZmVyX2Zvcl96b25lZChzdHJ1Y3QgYnRy
ZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4gPiAgIAkJCQkJICAgdTY0IHN0YXJ0LCB1NjQgZW5kKTsN
Cj4gPiAgIGludCBidHJmc19yZXNldF9jaHVua196b25lcyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywgdTY0IGRldmlkLA0KPiA+ICAgCQkJICAgIHU2NCBvZmZzZXQsIHU2NCBsZW5ndGgp
Ow0KPiA+IC1pbnQgYnRyZnNfcmVzZXRfYWxsX3pvbmVzKGludCBmZCwgc3RydWN0IGJ0cmZzX3pv
bmVkX2RldmljZV9pbmZvICp6aW5mbyk7DQo+ID4gK2ludCBidHJmc19yZXNldF96b25lcyhpbnQg
ZmQsIHN0cnVjdCBidHJmc196b25lZF9kZXZpY2VfaW5mbyAqemluZm8sIHU2NCBieXRlX2NvdW50
KTsNCj4gPiAgIGludCB6ZXJvX3pvbmVfYmxvY2tzKGludCBmZCwgc3RydWN0IGJ0cmZzX3pvbmVk
X2RldmljZV9pbmZvICp6aW5mbywgb2ZmX3Qgc3RhcnQsDQo+ID4gICAJCSAgICAgc2l6ZV90IGxl
bik7DQo+ID4gICBpbnQgYnRyZnNfd2lwZV90ZW1wb3Jhcnlfc2Ioc3RydWN0IGJ0cmZzX2ZzX2Rl
dmljZXMgKmZzX2RldmljZXMpOw0KPiA+IEBAIC0yMDMsOCArMjAzLDkgQEAgc3RhdGljIGlubGlu
ZSBpbnQgYnRyZnNfcmVzZXRfY2h1bmtfem9uZXMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2lu
Zm8sDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gDQo+ID4gLXN0YXRpYyBpbmxpbmUg
aW50IGJ0cmZzX3Jlc2V0X2FsbF96b25lcyhpbnQgZmQsDQo+ID4gLQkJCQkJc3RydWN0IGJ0cmZz
X3pvbmVkX2RldmljZV9pbmZvICp6aW5mbykNCj4gPiArc3RhdGljIGlubGluZSBpbnQgYnRyZnNf
cmVzZXRfem9uZXMoaW50IGZkLA0KPiA+ICsJCQkJICAgIHN0cnVjdCBidHJmc196b25lZF9kZXZp
Y2VfaW5mbyAqemluZm8sDQo+ID4gKwkJCQkgICAgdTY0IGJ5dGVfY291bnQpDQo+ID4gICB7DQo+
ID4gICAJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICAgfQ==

