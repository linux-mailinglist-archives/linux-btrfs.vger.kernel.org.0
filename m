Return-Path: <linux-btrfs+bounces-2414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FD8560AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0F2818B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703C131749;
	Thu, 15 Feb 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B4WOlPi6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PxwOHJRa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0812AAC3;
	Thu, 15 Feb 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994570; cv=fail; b=d2arYXmr4aH6yS4uEzG0eXWGtjTDW1DhIMxH09cKK4KVOBNkeTJzkc3bloowSAEPOhOxeGjYeK8FsmbtriCY/k1YjBwf/bLavrNzwrNX4FZgpMWSGUJpjDuxm6/isAYYsd7YBXxVxGpr5m4QDoAMvwoFUnBBg41A5Kbo6sCNOvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994570; c=relaxed/simple;
	bh=J7/rdS5x0QadkFOTlnFfmnGVaHNZmPz9BOYl7VdDyEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVjXUs+FLeJ7bnGRQiaG77GvDyj/q5WPqPAZQFgntagewzee+uJvqIUUtau3E7VgF9gMftOlBY1fkv6RmqeiNOu9NZ7lrMrNww06Sa2Jn+R/CKLL+/Pr89+FELocgWpYjfdhuWEKNSuUnPUxzX80WUfKa0bjKiI1Fzc96DZJgOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B4WOlPi6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PxwOHJRa; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707994568; x=1739530568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J7/rdS5x0QadkFOTlnFfmnGVaHNZmPz9BOYl7VdDyEM=;
  b=B4WOlPi60mfnYIJJIk0bIP31AM3tRV/C+dCt1zjwSnRyljldCRmY8urA
   vfqCLA8Gs0IjCn6s/O0Vz2cAsd4jA2PtTG5YDG+ZwLZIvfV5sMdoK9ydG
   iulLhXJohgIgC1IKMGXj4W1ZwC/Qmqygw6412CF/Bcnv6jppZYZPruhL+
   wmqikKKHxVBdB1mnO/wFZW5Ef8NDaV+teOtRYl+YeMFefC0/UjJBmj6Of
   7ZJ97I/wpIk5z7wqveGzPE9PuW9cQPTRwsUpBdjy6uZDacdT+rCiwzlO7
   CAavQEsXswiSK8Vr6CZWVBBXE3MBc8khSOE7TEDR9FaXwoZEnrozYhjl/
   A==;
X-CSE-ConnectionGUID: fGBI6Mu1T52Xw1db/vtnDA==
X-CSE-MsgGUID: CmauU+wpTPuseUVSfecDUA==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="9364544"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 18:56:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLW39i6lEvmOxqcGRJgQhwpv7ZFvE7aqvsv7k5AfRDjsQCI5ut1AK2XQFG326RtNLFMyJn8pm0S1JUvJx03uVpwBpq70unFTILx7Y76hHQkKLUly8JPPvpAlPQn4P31czwZOk6ysCvMlcCJrKgjWW6Wtm7dkg3ZcRKMK5MdhlBcHIfLV4+CB27sLyDGNjeqA8390tjOrDapkromaBf9eTgBtYdN0kD26unAZRzX7VC5cTybVbFmYkslU24OgnFuHiw4NY+p1RN3bbj25j4Dtclbx1EY4btpbXJkW468xWNCJnHy/MVi0M80Ho0q3VtMuOtc5rM/nBwdeZp1eAwQ7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7/rdS5x0QadkFOTlnFfmnGVaHNZmPz9BOYl7VdDyEM=;
 b=SNfAETqL+Wtqmr5CyW8rSRxQmcbSEB1Y0NI9IpyHYLfRYODrO9rIou98YS408PigF8ClG1OGD1ZuUWVt/eh9MzBCMPf6/AlAz/01x+MJn9inCXncNY1c/ebi1HLYHi8oRyrUFtisviGiQc/nYwMlYQMJ/fabxIv8tl+I3ATRxkEhg47VgtMV8q0JRTZ4E8LVOVkSbRrSjkzv9nDDGgtL2sLOIuiVaeGP2k4SszwxW0r7HmryGiz7Z3YOTE7N8+kJZFDLopv+qEN+SsW41p5mns0xxFUlSApTQMwUKCL4tQwy8szL1hcezfszCpRuxNQzrrAovU9vqW+Ut6ttcaXSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7/rdS5x0QadkFOTlnFfmnGVaHNZmPz9BOYl7VdDyEM=;
 b=PxwOHJRasvz8ryQ1L4j8V+1c3TJwxzgslIknsZpg0TWgYMixcKiHFrP3IYxYsbPXzYHEQ9OzXyN6BcQvt99YAZ5DfzV+TvDWs9Kth1v1Es0NsOuYx7IG3CEUfjFuTYgu8EsOmPkbpob2xTf182G+jBwPcrL513vIOTVlhruI8OM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB9001.namprd04.prod.outlook.com (2603:10b6:806:398::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 10:56:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::73c4:a060:8f19:7b28%6]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 10:56:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
CC: Zorro Lang <zlang@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] fstests: btrfs: check conversion of zoned fileystems
Thread-Topic: [PATCH v2] fstests: btrfs: check conversion of zoned fileystems
Thread-Index: AQHaXlWI8fwBpYSzwUKBguaW2lFiUrEH9YKAgANI9AA=
Date: Thu, 15 Feb 2024 10:56:03 +0000
Message-ID: <02e52e02-395e-4fff-a3bf-c594965fcaa4@wdc.com>
References: <20240213082031.1943895-1-johannes.thumshirn@wdc.com>
 <02dadc0b-85af-47ae-8cf2-e1289c521aaa@oracle.com>
In-Reply-To: <02dadc0b-85af-47ae-8cf2-e1289c521aaa@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB9001:EE_
x-ms-office365-filtering-correlation-id: 5a7bbd25-fc49-43cf-3f84-08dc2e14b43f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vbkmwyCPenYAs/yNgUD1GiKTCVg+DnN76z2myMrCJPvmxjk2zNrERDPjAkipbgnsAQHL9wPyVC/jhVn9danJRjfVx0/rZj60TCayvuAo22T657nGoxlyScwnSY1NxYSDmd+SJ/1TLiXGgZMxdMSkX+PHIuUQR1+aiN52lfjQAdSfVcd9bxl36THqN0cNiDc0vnkP44KLOlnS07PZiB7Y5VjED54Gyt2NX75fDFRivtSxVR3J/5nANV7F9jtIdUX/K7TYUmMhuXWc5OvAEIvEtpeLkP469Qeq/h6X8zHWYIuiUnro8ZRcYIU3h2qH5nabe6vm8981F21t19HaUyeBXqumnd4BvmzViCLZqQNXT3uGSq1PezpR6awxkUcpeeXVlMjHETKG9noGNP38FmovEsjKIlYHmX8VZLbOEisU/Hr8TkdT5tnbbEOLP34ScAflhUycFFngYIAwZxiFSfjHzL95nCl/ucGcpYhMquN3GSvEFaMAYbPMHjz4/xAbCwpZMQwcpeULS1CMbS/FpqYv58yzDRxL0ONtpReG40MZZTQkPGeMuW35O+o3Bzrimesk1gvtIrEkNrScuq9dhLJJHkmeRCwJinvzSZikWy2i5VjU69UriTzF5WrarXo+i41E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(64756008)(31686004)(4326008)(41300700001)(8936002)(8676002)(66476007)(66556008)(66446008)(66946007)(2906002)(82960400001)(83380400001)(31696002)(86362001)(36756003)(38070700009)(54906003)(316002)(6506007)(110136005)(6486002)(38100700002)(76116006)(478600001)(2616005)(71200400001)(122000001)(26005)(6512007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFIvZEZETGtjdndUTVJ0UTdZaFFUNlNPZ2s1aStWR3hzTldYV2V2bEwyWk1R?=
 =?utf-8?B?aHRZMEVaekQrdklBUEFHYWhmV05xUG1SUFEyWElKV2tmcmlvdTRMOTBEdVVw?=
 =?utf-8?B?SHQ2NTR6ZHQyNnVGMUtQNklaS2RpWFlqU21ibXdLOG1xTEg2S09MZmszU3Fy?=
 =?utf-8?B?RmlrZHNFN3RRcXFYeitBRFQyUkJBaFVBSG1XeHJRL0J6eGhiRXdjeTR1UEl1?=
 =?utf-8?B?QVg3eGFvTVNxcTBrT1lnMkdiajJoY2VTUUUyam8vMHZ6SjNobHBSdDg2bXZM?=
 =?utf-8?B?UDRpdHA2L04vWHFTNUxnUjh6dzBYeU5KcTIyQkMwNWdBeVlDWENDQWI4Y2xV?=
 =?utf-8?B?MXNwKzM5QkJaeE1LY29yWVJOZm9oTVRreG9ua0FJNmxXR01POEordHJHSmhI?=
 =?utf-8?B?K2hEM0pTZ1hzTzlvQzRWRXIwM05oV3FEZ3BXSzFSb1Bja0ZNZURqdk1Ua2pH?=
 =?utf-8?B?dG1jUzNvM29rZk1VMHBxcUdXTk1SQWZWRUZxT3Rsa1RKTFBzRkd5MmRiTzNJ?=
 =?utf-8?B?LzdST2NQVHpzSFJaTnNZNE9pSUFaaFBWOFdOcVhYaWRpRnF0U0F2cDkwMWtT?=
 =?utf-8?B?eW1nUVgycWVRRmd5cllNMWhUVFFEN0h2QVNYSTNRTE9OQkIwODdWTUhIR1M4?=
 =?utf-8?B?UzgwSkxpYkxmOUJRT0M1cHlnby9EUnBINkRKQ1NnNU1Bc05TTWhzQ3JwVFpk?=
 =?utf-8?B?a0EybTRtTjFrWGZQcmRJZVRJYjBicTZ3MFowRnJSWjRab25EMGVDR1dmQW9S?=
 =?utf-8?B?SFNnbHRoaEh0djc2cHpkMXdLM0RMNWZadmRRbTluajR0RmJEcTJwZ09KTUN5?=
 =?utf-8?B?QmVlb2pvUzZoNUZwWXpCdGlRSWQ1N1pNbUpjcEg5RnUySTN2OWV4K2liZEdu?=
 =?utf-8?B?akxFVlhha2R4Zm9jZ3hwbTVMb0VCamdLVWxkZjduUzUzR2ZELzZyalY1WENs?=
 =?utf-8?B?RXRzTE5jZEF5U0RQSTB1cXFadzVHN1VZbXV0Wi9BZ2lNNkVRR09pU0N5c0pr?=
 =?utf-8?B?MTZENVVKODdIakFSMW1iTCtjVTNweVlQQ0tNVEp1RGlKVXdqNE02QVczV1N6?=
 =?utf-8?B?Y3Y2NmRZV0JBbEloTUlpZDBTRUE3UWt3ZHdpVzhXR05Cd2JXdnpsS3Iwcmpl?=
 =?utf-8?B?RmtEQXJzcHdRSjFsU0tvVGhaTVJEREFnTWtidXkwU2svZU5WM1dTejRsWkhH?=
 =?utf-8?B?bzBjT2drR3FPWnhJL3lTdTlYdjBaY0YvN2hKbHQ0S1VmOEtIbEdQQUcyLytT?=
 =?utf-8?B?ekVZRi9QeTdWeUE0V2xqU1NKSDBiNzUyS2ErOUtvbUFTVmxhMXh6bGJMY1p1?=
 =?utf-8?B?bnNpUjhlbnhQTEQ3NlBvdld1anVXTUFyZnFTSWU4enNYdkZtVEJrNUh3TnVB?=
 =?utf-8?B?d1QzVWNSTkwvYWQzcHNTVTRYMm1vVzh0TGJNbTRGOTVaOUNmVTB3ZmZ3NnUw?=
 =?utf-8?B?U3puUkZDMWJkRDFRbkRQcnVXNWR2MUEzMG8xaW9nOFJDa0luYUNLSTdFVHlQ?=
 =?utf-8?B?WjBpSGZscGZBQ2lVR3ZvV0tLTUJGbnJyL3AxZTJhbWFKY0FxMnc3M3RhamVI?=
 =?utf-8?B?d3A5Q28vc0FHQ09IRmNZQ3NwUURSenBJdjk1Zm5LdlBTaW42c0lGYi9rRVp6?=
 =?utf-8?B?aEdVRS91VWZ4bzdxREZlYU5CTWRuNENqSGUzN0FORnBtd3B0dHo2WkJ3ZEdK?=
 =?utf-8?B?dDdDbkFHR3lyQmp1U2Jka2pHTFRUTlY4SnBGWUpaU29xQkdNS0llWXV6Q2J3?=
 =?utf-8?B?aHZiWGtZRFRZYk9nWnNDZGcvTm5XeDVqQ3h3OWJFMlVmdUdlRUdxWE13L2Qv?=
 =?utf-8?B?NGNITHlqOXNLL1dnc2lFNjArSDlrYWJsMXVRWVZvVUxncmQzYlU3cDFMaTk5?=
 =?utf-8?B?OUNwYkE1YzkrQXFwTktjK2laSllrRHViTVo0U1ZPWmt4YUZvR29oYkFXSjE3?=
 =?utf-8?B?aTJDNHM2dTJXcmRkTTU4MkRDcmVhVllrK01OU1d6aldObmwyU0RHaHBxbjVZ?=
 =?utf-8?B?b1dsN3FZWTdKRVBaclZQTXJjMml0MWFudHRHMWpsM29lWUVURktkWU5FQjRn?=
 =?utf-8?B?dnc4dmU3OW5MSGV2b2tiQllrcyszSVJRRXZWRVRvS1BuRUFVSnpvckRKQThu?=
 =?utf-8?B?ZW9uNWxBYlFNOXMwTysrREZuQVluL29KTlFOM3dkcDI0Q2t1aXNseVdKbGE1?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8E86FEEE10D7549B3C46B39F5D4FFB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gXasIAVu83WwfU/3+sFgIO85Uskud8XDG9wrIw04rNtnXUyYlo/zOx78uP8mTHBpG1mxrAh33owJa29kiqGXi7YcooyKc2ZhBf1OAEIorHz9GxISP2lucDeGM5S3DY92JWr55jLSysiEUVwM2Zcw/V56+LvAt/yzQlB2jBQbXJ4yFuaSkphdrff2cRzda25sq+KRH8LqIlf6XHYEnGYmeqqSTQAV3lzke15k1cuSzxJjbY/cT0a0XrIRK1e/x25IZPEAcyvBPKrYUsfEoZIsXT1aO+HudxeCyftmao5jVsRVDTnloJnfNCyuswZnBO6HYY32AD9lc/9MjiQ7zzoPwEM3X3NF+fo5SFSkKJucS3OqRXlYyDpJU1LFFn2ByslYBfQhX84LUzjTAj2kmx/MBfJrOsj/g4cig7AxsqFDdArOZW0/7AAXhdu++QRrydhB95nU7FTrCH3vlDDG+utyomy2/B3uNBJV+iH0ZJGy6Cr1gbslruqfAEUvkaGX0TzJMPgYfggEGdsVR2kuYiqD5qLIy0V8ojT0Dq5YQcpQlUPDz8Tcd9BxicQEasNTh8leyn4Utlzqkks12tK0pw3/usuqiDPhFYUPaQyHxJ/fHoSQHFxF/HOWf/OsbwJ7ANr3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bbd25-fc49-43cf-3f84-08dc2e14b43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 10:56:03.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fg5SFZ5D8iMMmAJG5DusAO/7Ew5lvGSqXs2GsLp9898Kw9Nc9mTSk0CFwNkd84F7rkjQVAM5WSpCBbVDkmvJu9gpgoW0VnMdXr/lUoGUZmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB9001

T24gMTMuMDIuMjQgMDk6NDYsIEFuYW5kIEphaW4gd3JvdGU6DQo+IA0KPiANCj4gT24gMi8xMy8y
NCAxMzo1MCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gUmVjZW50bHkgd2UgaGFkIGEg
YnVnIHdoZXJlIGEgem9uZWQgZmlsZXN5c3RlbSBjb3VsZCBiZSBjb252ZXJ0ZWQgdG8gYQ0KPj4g
aGlnaGVyIGRhdGEgcmVkdW5kYW5jeSBwcm9maWxlIHRoYW4gc3VwcG9ydGVkLg0KPj4NCj4+IEFk
ZCBhIHRlc3QtY2FzZSB0byBjaGVjayB0aGUgY29udmVyc2lvbiBvbiB6b25lZCBmaWxlc3lzdGVt
cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEZpbGlwZSBNYW5hbmEgPGZkbWFuYW5h
QHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgICB0ZXN0cy9idHJmcy8zMTAgICAgIHwgNzUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgICB0ZXN0cy9idHJm
cy8zMTAub3V0IHwgMTIgKysrKysrKysNCj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0
aW9ucygrKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2J0cmZzLzMxMA0KPj4gICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2J0cmZzLzMxMC5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvdGVzdHMvYnRyZnMvMzEwIGIvdGVzdHMvYnRyZnMvMzEwDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDc1NQ0KPj4gaW5kZXggMDAwMDAwMDAuLjZiMDg0NmYwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi90ZXN0cy9idHJmcy8zMTANCj4+IEBAIC0wLDAgKzEsNzUgQEANCj4+ICsjISAvYmluL2Jh
c2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArIyBDb3B5cmln
aHQgKGMpIDIwMjQgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0aW9uLiAgQWxsIFJpZ2h0cyBSZXNl
cnZlZC4NCj4+ICsjDQo+PiArIyBGUyBRQSBUZXN0IDMxMA0KPj4gKyMNCj4+ICsjIFRlc3QgdGhh
dCBidHJmcyBjb252ZXJ0IGNhbiBvbnkgYmUgcnVuIHRvIGNvbnZlcnQgdG8gc3VwcG9ydGVkIHBy
b2ZpbGVzIG9uIGENCj4+ICsjIHpvbmVkIGZpbGVzeXN0ZW0NCj4+ICsjDQo+PiArLiAuL2NvbW1v
bi9wcmVhbWJsZQ0KPj4gK19iZWdpbl9mc3Rlc3Qgdm9sdW1lIHJhaWQgY29udmVydA0KPj4gKw0K
Pj4gK19maXhlZF9ieV9rZXJuZWxfY29tbWl0IFhYWFhYWFhYWFggXA0KPj4gKwkiYnRyZnM6IHpv
bmVkOiBkb24ndCBza2lwIGJsb2NrIGdyb3VwIHByb2ZpbGUgY2hlY2tzIG9uIGNvbnYgem9uZXMi
DQo+PiArDQo+IA0KPj4gKy4gY29tbW9uL2ZpbHRlcg0KPj4gKy4gY29tbW9uL2ZpbHRlci5idHJm
cw0KPiANCj4gY29tbW9uL2ZpbHRlci5idHJmcyBpbmNsdWRlcyBjb21tb24vZmlsdGVyOw0KPiBT
byBjb21tb24vZmlsdGVyIGNhbiBiZSBkcm9wcGVkLg0KDQpTdXJlLg0KDQo+IA0KPj4gKw0KPj4g
K19zdXBwb3J0ZWRfZnMgYnRyZnMNCj4+ICtfcmVxdWlyZV9zY3JhdGNoX2Rldl9wb29sIDQNCj4g
DQo+PiArX3JlcXVpcmVfem9uZWRfZGV2aWNlICIkU0NSQVRDSF9ERVYiDQo+IA0KPiBTbywgb25s
eSB0aGUgZmlyc3QgZGV2aWNlIGhhcyB0byBiZSBhIHpvbmUgZGV2aWNlPw0KDQpOb3BlLCBidXQg
X3JlcXVpcmVfem9uZWRfZGV2aWNlIG9ubHkgYWNjZXB0cyBhIHNpbmdsZSBkZXZpY2UgQVRNIGFu
ZCBpZiANCmRldmljZSAxIGlzIGEgem9uZWQgZGV2aWNlLCB0aGUgRlMgaXMgem9lbmQsIHNvIGFk
ZGluZyBub24gem9uZWQgZGV2aWNlcyANCndpbGwgdHJlYXQgdGhlbSBhcyB6b25lZCBkZXZpY2Vz
IHVzaW5nIHRoZSB6b25lIGVtdWxhdGlvbiBsYXllci4gU28gSSANCnRoaW5rIGl0IGlzIGZpbmUu
DQoNCj4gDQo+PiArDQo+PiArDQo+PiArX2ZpbHRlcl9jb252ZXJ0KCkNCj4+ICt7DQo+PiArCV9m
aWx0ZXJfc2NyYXRjaCB8IFwNCj4+ICsJc2VkIC1lICJzL3JlbG9jYXRlIFswLTldXCsgb3V0IG9m
IFswLTldXCsgY2h1bmtzL3JlbG9jYXRlIFggb3V0IG9mIFggY2h1bmtzL2ciDQo+PiArfQ0KPj4g
Kw0KPj4gK19maWx0ZXJfYWRkKCkNCj4+ICt7DQo+PiArCV9maWx0ZXJfc2NyYXRjaCB8IF9maWx0
ZXJfc2NyYXRjaF9wb29sIHwgXA0KPj4gKwlzZWQgLWUgInMvUmVzZXR0aW5nIGRldmljZSB6b25l
cyBTQ1JBVENIX0RFViAoWzAtOV1cKy9SZXNldHRpbmcgZGV2aWNlIHpvbmVzIFNDUkFUQ0hfREVW
IChYWFgvZyINCj4+ICsNCj4+ICt9DQo+PiArDQo+IA0KPiBDYW4gd2UgYWRkIHRoZSBwcmVmaXgg
J2JhbGFuY2UnIHRvIHRoZXNlIGZ1bmN0aW9ucyBzaW5jZSB0aGV5IGZpbHRlcg0KPiB0aGUgYmFs
YW5jZSBvdXRwdXQ/IEFsc28sIGltbywgaXQgaXMgYmV0dGVyIHRvIG1vdmUgdGhlbSB0bw0KPiBm
aWx0ZXIuYnRyZnMuDQo+IA0KDQpTdXJlLg0KDQo+IGFuZC4uDQo+IA0KPj4gK2RldnM9KCAkU0NS
QVRDSF9ERVZfUE9PTCApDQo+PiArDQo+PiArIyBDcmVhdGUgYW5kIG1vdW50IHNpbmdsZSBkZXZp
Y2UgRlMNCj4+ICtfc2NyYXRjaF9ta2ZzIC1tc2luZ2xlIC1kc2luZ2xlIDI+JjEgPiAvZGV2L251
bGwNCj4+ICtfc2NyYXRjaF9tb3VudA0KPj4gKw0KPj4gKyMgQ29udmVydCBGUyB0byBtZXRhZGF0
YS9zeXN0ZW0gRFVQDQo+PiArJEJUUkZTX1VUSUxfUFJPRyBiYWxhbmNlIHN0YXJ0IC1mIC1tY29u
dmVydD1kdXAgLXNjb252ZXJ0PWR1cCAkU0NSQVRDSF9NTlQgMj4mMSB8IF9maWx0ZXJfY29udmVy
dA0KPj4gKw0KPiANCj4gV2h5IG5vdCB1cGRhdGUgX3J1bl9idHJmc19iYWxhbmNlX3N0YXJ0KCkg
dG8gc3VwcG9ydCBhcmd1bWVudCBwYXNzaW5nDQo+IGFuZCBwYXNzIHRoZSBvcHRpb25zIHRvIGl0
IHRvIHJ1biBiYWxhbmNlIHVzaW5nIHRoZSBoZWxwZXIgZnVuY3Rpb24/DQo+DQoNCkknbGwgbG9v
ayBpbnRvIGl0Lg0KDQo=

