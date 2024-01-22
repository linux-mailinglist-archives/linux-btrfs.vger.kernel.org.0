Return-Path: <linux-btrfs+bounces-1598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADC836341
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFA61C2301A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D19383BC;
	Mon, 22 Jan 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jXpeO5qm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KS9Inigh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B720DFC;
	Mon, 22 Jan 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926662; cv=fail; b=McKQqPytt7jx+LuhtoxgjCiTYu998An9H1ebboNPbam/Gh+ovM/A84K5wL1xI92+3/kJjuHOfRSBtyShAKD8jPmouZiPHJME5qW6pNXCTgFQrhyEseF4AIyDsR8mzfctOUGIW5SNA7pvc496eh7M8qZc2dylBKGm9XZSCapPoOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926662; c=relaxed/simple;
	bh=eihrJLHor0QXFA+T6ADrdmpQaxT6KYVk07zmDzKpMEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQnZrnwVerbUTcqEI4Q2uCDpkCxWZ7ksFIqiuK/4pd3JuLtG0/m35IDWi1RwUxSXG4eP6DhhxkUORGpuWCYjjxFiZpqJNvstedCMOocdS7w2Ke5WImVsHAsXzenYE7PPoHMeYmbYyJOY1x3u/HsuER9uJFddE8BsQi/DpUjln+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jXpeO5qm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KS9Inigh; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705926660; x=1737462660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eihrJLHor0QXFA+T6ADrdmpQaxT6KYVk07zmDzKpMEk=;
  b=jXpeO5qmqE4lpnpjt92l3RiaDPxNYh9dZo9AZdOpXFpjy7D0cmSdXVHr
   m7xocDvgXs65L8KOZZBhfL3lRwcQ70tNIW0rLB/t+yP1Tv4uE0CXkAcU8
   T3gQ1UA0xgZFOA3Rzwf3tsu4FkMvOouPll0hcLXvHv8LxZa9PTl17UkIy
   3C0yBtD17CMRyfjt+OAI0g3inBw+CEbu7SgL3qUOaDHZB13xCRr2rlw+A
   tg9Ae2d1WbfudM/82vqukm1o/Ud3x5NjkBCu+7/WQJSIKDp4ntv2i5fZm
   W5f+rnEeEd9VU+aSbY2lTShCGKcm53fhjoVgbFvzPzylI6Ra0VW/4uaeO
   Q==;
X-CSE-ConnectionGUID: n0X76uQsSneuUHkgbSiVNg==
X-CSE-MsgGUID: DziCfu3bTtyQl7GezMoetw==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7658439"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 20:30:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCjsp8uaiWUx5TgTooMCRJFai9lyhRxjw68wGdOgqKIlLf/Zgktbpnjv4lk1XVhtWnhZ4rW8K83Jc2BzuWLZ+MPqtPBcuDG5v3qWh5LJjwCGMdEEJKZ4/pX+ASTt78le9Km3Msu+/gSKpx9OQaJ589GdXQJ1+8INCa3gDdAJ05MYo99okefFIVpMGIsppMHIPA9ZoVdi7aYqzjZt/F9yYOm068646GM5kJ8G2OhOtr2GO9pmY52+SIZbouMB8urlkzHAfDQBAB7+ksdlwxyM6HxXcPALGV7MRkC6nwN9KZ7R7nJ8jIJtwtace2yVnB/2PXgoltdN3agfHHK8lbLpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eihrJLHor0QXFA+T6ADrdmpQaxT6KYVk07zmDzKpMEk=;
 b=Lt5h8NO1zwkeKC0wqYribL+w28yVR9hEEiLgEQk9bxxb1KKyvuLJZA/t9pD1zirOsFif9nms1pz9hf+52hLYVd96luRIdYHWEhsUVl6FzgVvmGpaD+WEBNqihQaW7yiP9DTlL5pCHDuVal5pvX+46QrN4wtgz8KVKk00MFEZgl1xeMFztq7QyjLQnYoWGO6aukQ7WzWKQiBj6lM5yFDrukcH49dXhM/hDBpQ/3zaswviRihy/qrGgOfLFxK02iRi4sC+PtRrpsk2AHTInsM40tEcpyJW8sQbNsYxNvdL9F7kiMZduagbqUh/06ZnNnduSev1W0VeGH3/zmgX3zoLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eihrJLHor0QXFA+T6ADrdmpQaxT6KYVk07zmDzKpMEk=;
 b=KS9InighwDdg1fc2skJYDmh1CtlTK6ahwnP21I2Cx0DzgGhzW5x9V+jc97n2UQOh8PNGzew+O+Sw/UdLaIIJMLDAnzqFqjgYgYNy2C+0Ar5WQfYWwYFfP9z7XFIUEhYoOnCoOyZXcZidWhZJOs2ALbjAaXQTWa1hPrvoJe18CI8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV8PR04MB8959.namprd04.prod.outlook.com (2603:10b6:408:18c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:30:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 12:30:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Topic: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Thread-Index: AQHaTSDvvUnny9ygKUWOlIYLgVefArDlwQgAgAACYgA=
Date: Mon, 22 Jan 2024 12:30:52 +0000
Message-ID: <f5d54836-5edf-4cd0-88c8-f2d474368ea9@wdc.com>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
 <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
In-Reply-To: <x6bi4u2u65q37tde3s357lzhce4wglpobfgp7qgzhun4iadg3m@2pewiu6xuts4>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV8PR04MB8959:EE_
x-ms-office365-filtering-correlation-id: f3c0b6af-fadd-4660-8e66-08dc1b45f95d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 81emKzxUW4HV4EkEQRVYEsNm9Y5iboG2QxS2ywBkFeeB1vFKq3ABNof0wKf31sxvpi4Mr6VHxgE/Wdgn41tUKC+Qa6phwbN5TN1fWTYsdq3v1z/PsYAlQ8AHRwMXDoyeV6ZCQ8KpEvfxavRdVFUQwghRBtl8WH6xlYI9qkpZ8Pi5KJeDlTs6q3gqW4Cw48cuiqP88BrmNm2w2OJ+Zpp3fkea2FdMFzTI4AsnQf9BCWsMJd4zRO3uqwjncAvcdivdWSPwt9BHTkjkeeiYKtdyQrLZy5WiDSq4wSSFH0osHGy2xSS8DdWeN99IuRoIXzXe0an+hC9eUc9u8BUpEpiuAGHyR9bAEr2jS8ZV7dtcCeS8CsQTYMqXLNPO7yQ//gsPpVtcZK7M8pIwE/FHcdPlY/3AcVd4eDJbA9xuRrnqgliRR2MFzQ6h/8HGGLdUTZpfSaH/plcgr9IOjhSLtw9xRcP8g8ioF7FNGKaG49nc//64TcEPOk4/poezhCbuF3g4lMVPEXvaSsj5F97CRQ7nCmtZHQUJOpUMASO6TKAYQXLCN1p00of/bUjBX8KBduzuDJ4YsIXSz0bI/AIrbPst7eOkb4xH4SuR3sno11kHDXyKsfyptN7Q5CLZOZKdcXTTPqNaseFVG0xxSe4H3JXMId1IGuyhv+u5QaL5FmY+a8ffgRgN0r7vrQx/7IdR548Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(8676002)(8936002)(4326008)(6862004)(2906002)(5660300002)(41300700001)(38070700009)(6486002)(26005)(2616005)(6512007)(83380400001)(53546011)(478600001)(71200400001)(6506007)(122000001)(82960400001)(31686004)(38100700002)(37006003)(66446008)(66476007)(54906003)(64756008)(66556008)(6636002)(66946007)(86362001)(316002)(76116006)(91956017)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmM1dW5kSnljNk1va0V4a0VSamsxcnlJcTZUSCs5V3c1bVFXQTFPN1VPUHlN?=
 =?utf-8?B?d0RiUlFhRCtXeTZKa0dxSG1SUGVrUmxDblhrNVl0VkNadUVoYWdoODNaOFpx?=
 =?utf-8?B?SWpJakhMNXBNd0ZWZzhsQnFpdTNic1E0ZS9oUU5NUW1jcTE1T3kvTTJZbVQv?=
 =?utf-8?B?bnJPRHh6b05RcXNkMzVRWXI1Z1JScUQraVlYbTZYTWVLQVlKQ0FTK1JKWE1Z?=
 =?utf-8?B?NVlCWUxUQlZCbVNPZTQwZXQyZlJQMkRVUnQycE95QXRMN2lvZFFBcnc0SFIy?=
 =?utf-8?B?M0hjNUlITlF0OEdYUGJ5NHRpVXlvWE43NS95d1RFS0lQbWhKVkJFOUZWQ0w5?=
 =?utf-8?B?cUo2RFVLUko4Q0ZPdEpqN1dFQSsvaVBFWE1FQTYrbTVrQS9MOXNiQjJFM3hT?=
 =?utf-8?B?c3BjcldkQzY2YXR1RG9GNUFmRE9yQzhTZC9Ya1VEWUhpUUx2cjlVSDNXclZy?=
 =?utf-8?B?U2J6bGJERHBFVzd0S3U1MkhKK3AwZzVSMDlZNWRteFo5c2VLQTMzbkdScjYz?=
 =?utf-8?B?RExLb053Mzk0RFRRQTV0UWY1ZndFaEl0NmFRS2VXTUhKQUZ5Z3F1czlDVzdm?=
 =?utf-8?B?WjlzSWNWejdKc0RyUXpBbUFaRFIyMk1VZFhaZk5GOEJoTi9jdjdoMWpSSHAy?=
 =?utf-8?B?Rzg0NlZ0UTF1UGtCWi9DTUJVd1JBcGRaV1pTVjdYM24zbEpQOTFFRWtWOVN3?=
 =?utf-8?B?M0dNc2NlQWFhcmFYWU8yWmx0a2F0cE53aGNpMDFGMzRBbmxGRUtFMk56UmFY?=
 =?utf-8?B?eDRHVW1UVjE2TXY4TUhHL1ZwZ3dZay9vcVpXR09jUkUyaHpSc1ljRzFyTkh5?=
 =?utf-8?B?ekV2TnpGR3EydFdCNmhUWXo4Q25OYnJDczg5OS9jRU9RbHQzWWRkRDNOeFBn?=
 =?utf-8?B?ZjdkalZBUzNNUWUxOStNWW5qdXI3RmxGV2svOVlMNDVoRkhpdVl0THhlR1lC?=
 =?utf-8?B?aHN4TmM3N0xtOFJkUzdtVzBLRGZram0zR1h5WUoyTU5xSGhzQytPV3Y5dUpV?=
 =?utf-8?B?NHNUeVlvV3ppVmdkNi93T1luS25oalpyNzlYRFh2bVdnd2xUTk40S3IxU3o1?=
 =?utf-8?B?OUg2NE0yMFJLNkRCWWJ3cHBIbWpxY2IwUUNMTGV2VFN5M2dBTnJhU3lVaU9H?=
 =?utf-8?B?NHVRRlowQ2dBZm1LVVkrNkx4d210V2lxV0drQ2ZiMGVkbkFOUzhTUHplanBZ?=
 =?utf-8?B?U1BIeHA3ZjBFT01ScnpRRGZUNU1NcmVlM2lEalR1WVBBSmEyS0hGNUdKa1g4?=
 =?utf-8?B?M1ZVMS9XSEdFTm82YVlvTEU0dmp5UFA2MXlpRE9BelNmN1NRS3Nndk1vNUIw?=
 =?utf-8?B?a2h6cVp2M0pBQUhWUjlzV2ZxeTZWM1hiT1hVbFI2YTZmb3lleGg1clo4dzNO?=
 =?utf-8?B?djV0MXdOS0NhbHVRSXRtUVluNXA1NDdzUStJOGtZLy9qelNEYnlucUI1Mmdq?=
 =?utf-8?B?OXdvUmIrcVFMTWJuM3JwVHJVdlFNTnowYUZzRmgvSll4eStyNWFLcEo4RUVi?=
 =?utf-8?B?U01yU0Q5OVA3b3VuTTRBOGxWRWEvcEk0akVZVEY0dGpjOTdQT3JwMzh2ZW01?=
 =?utf-8?B?cVNLeFZKYkh4Y1lwNmZWeHBRMmFONmthWVRZOHA2L0wwV0ZlL1lmUi9MZ0Fz?=
 =?utf-8?B?aEpNSjBpQ1B5OG1PQ3lJSEZCVFNFcC8wc3JkR1F6bFROM3hJcTJodTdPQTVS?=
 =?utf-8?B?RjV5VExjVm4yTDBGZGMyYVVrSUd1NHpsTEJybUlZM1lKTnAvNlRnSjI0SmFV?=
 =?utf-8?B?Qi9Wa3JWRDQ1Y0RROE9CYkQ4eEZuUU1XU0FIYWpEQlMvUXpDdWZJTFNPc2ls?=
 =?utf-8?B?Z0M0THhaRGhldUtLWWVqb1ZOcEEyZkFkTzM1cjdiMWxDOThiSzlvaEtXSUZE?=
 =?utf-8?B?UlJFZ3BOdkZqV09xRUxXRFphTy9rYWJMdTc3Q3RTbmZuNmZyakFXRTV4YVg3?=
 =?utf-8?B?UkF3dkdqbXhmWlZGc2lpMXllSFl0TENxWlNySUM5Z2E3Mm9xWEFNZWRzR3Uz?=
 =?utf-8?B?Yk40cnNYUVpranZBZjBaYWVuRDNHeS9TL0ZvMmlCRjBxSzIxUkszSDlGdEc5?=
 =?utf-8?B?UVJrRHdvMkhDd25mMVFmNm5hQ3FabXYrZlNZb3B6ZGtzNS84Smk2WUIxczVD?=
 =?utf-8?B?dndudWxVNnp5b0dQQ2wxUnZlV3VxZk94NENZTTdTZWxTZ1lVdDE2anZSL3ln?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C645379DEF5441850F387D72A25478@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	45F3GsJucWhMZjnYTaHKdKM0xVXOOM4J9eglOnbL8BL4c4qHdYoLErW+BjZ7rcWnTDFOk7v4O0n6TU6kbxwpInTdqod4r5IVY6fGfdoie+h61grh0BvY9cCwd3dyEtpE2nFwU7bPUtuXWgsdkLqOxiM5eLbmeAO0FW2OBzI/MOXhIn2AxMRKRJb992tt9Ax9m9LKDceaKzPVN188v+nAElh7cvmF38yJ69JvYqzTUysAT8WNju6hwgTf5rL4i0lxjUJOyVhUCIss9tkxXAZispYgKyKK9zsrDDJX5a4Ts3NapPMRRQ45Tar6UtrefKWgGzsbVuYDX334SC0KnzwGHKubzLJfEg7tdpWWysGXqNV5N8+nWGfCEBIMjy8+Qv6ta2bvRyPryT5d89gAo26vlqPggkXUXoSEdAadsgWnAumaKEdLFDizu+sT2rOtqkZI3BZpiRGmIWIJspV+1gZzpCUbHx/qRY0PmkEg8wxfX9RhwiELdrsNNV7ndhmszEF+0TDrEWVESHVz0VMjpEV3WJ/LSQTrHV//ucYim2dgFYX60FFlI0HxQQG1aIhyMgPJKqtqzchUQgC4t8NemMdx2+cWHqIyt3wHgLu/MSM3tikqC7a9FuGXx8do0cZvtQKU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c0b6af-fadd-4660-8e66-08dc1b45f95d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 12:30:52.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fx/LSn18lTS5E7OjVP6+6dohp6bae823/ZKapFuiA+GNdSTCn4Z8i2xUkscqTTS36QVYPOqVP6R+9s2FNDANMe5dueKWLzeVspFm0e8SLZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8959

T24gMjIuMDEuMjQgMTM6MjIsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gT24gTW9uLCBKYW4gMjIs
IDIwMjQgYXQgMDI6NTE6MDRBTSAtMDgwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gdmVyeSBmYXN0IGJ1dCBzbWFsbCBkZXZpY2VzLCB3YWl0aW5nIGZvciBhIHRyYW5zYWN0aW9u
IGNvbW1pdCBjYW4gYmUNCj4+IHRvbyBsb25nIG9mIGEgd2FpdCBpbiBvcmRlciB0byB3YWtlIHVw
IHRoZSBjbGVhbmVyIGt0aHJlYWQgdG8gcmVtb3ZlIHVudXNlZA0KPj4gYW5kIHJlY2xhaW1hYmxl
IGJsb2NrLWdyb3Vwcy4NCj4+DQo+PiBDaGVjayBldmVyeSB0aW1lIHdlJ3JlIGFkZGluZyBiYWNr
IGZyZWUgc3BhY2UgdG8gYSBibG9jayBncm91cCwgaWYgd2UgbmVlZA0KPj4gdG8gYWN0aXZhdGUg
dGhlIGNsZWFuZXIga3RocmVhZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgIGZzL2J0cmZz
L2ZyZWUtc3BhY2UtY2FjaGUuYyB8IDYgKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZnJlZS1zcGFjZS1jYWNo
ZS5jIGIvZnMvYnRyZnMvZnJlZS1zcGFjZS1jYWNoZS5jDQo+PiBpbmRleCBkMzcyYzdjZTBlNmIu
LjJkOThiOWNhMGU4MyAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL2ZyZWUtc3BhY2UtY2FjaGUu
Yw0KPj4gKysrIGIvZnMvYnRyZnMvZnJlZS1zcGFjZS1jYWNoZS5jDQo+PiBAQCAtMzAsNiArMzAs
NyBAQA0KPj4gICAjaW5jbHVkZSAiZmlsZS1pdGVtLmgiDQo+PiAgICNpbmNsdWRlICJmaWxlLmgi
DQo+PiAgICNpbmNsdWRlICJzdXBlci5oIg0KPj4gKyNpbmNsdWRlICJ6b25lZC5oIg0KPj4gICAN
Cj4+ICAgI2RlZmluZSBCSVRTX1BFUl9CSVRNQVAJCShQQUdFX1NJWkUgKiA4VUwpDQo+PiAgICNk
ZWZpbmUgTUFYX0NBQ0hFX0JZVEVTX1BFUl9HSUcJU1pfNjRLDQo+PiBAQCAtMjY5NCw2ICsyNjk1
LDcgQEAgaW50IF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Uoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3Vw
ICpibG9ja19ncm91cCwNCj4+ICAgc3RhdGljIGludCBfX2J0cmZzX2FkZF9mcmVlX3NwYWNlX3pv
bmVkKHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmxvY2tfZ3JvdXAsDQo+PiAgIAkJCQkJdTY0
IGJ5dGVuciwgdTY0IHNpemUsIGJvb2wgdXNlZCkNCj4+ICAgew0KPj4gKwlzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbyA9IGJsb2NrX2dyb3VwLT5mc19pbmZvOw0KPj4gICAJc3RydWN0IGJ0
cmZzX3NwYWNlX2luZm8gKnNpbmZvID0gYmxvY2tfZ3JvdXAtPnNwYWNlX2luZm87DQo+PiAgIAlz
dHJ1Y3QgYnRyZnNfZnJlZV9zcGFjZV9jdGwgKmN0bCA9IGJsb2NrX2dyb3VwLT5mcmVlX3NwYWNl
X2N0bDsNCj4+ICAgCXU2NCBvZmZzZXQgPSBieXRlbnIgLSBibG9ja19ncm91cC0+c3RhcnQ7DQo+
PiBAQCAtMjc0NSw2ICsyNzQ3LDEwIEBAIHN0YXRpYyBpbnQgX19idHJmc19hZGRfZnJlZV9zcGFj
ZV96b25lZChzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJsb2NrX2dyb3VwLA0KPj4gICAJCWJ0
cmZzX21hcmtfYmdfdG9fcmVjbGFpbShibG9ja19ncm91cCk7DQo+PiAgIAl9DQo+PiAgIA0KPj4g
KwlpZiAoYnRyZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0oZnNfaW5mbykgJiYNCj4+ICsJICAgICF0
ZXN0X2JpdChCVFJGU19GU19DTEVBTkVSX1JVTk5JTkcsICZmc19pbmZvLT5mbGFncykpDQo+PiAr
CQl3YWtlX3VwX3Byb2Nlc3MoZnNfaW5mby0+Y2xlYW5lcl9rdGhyZWFkKTsNCj4+ICsNCj4gDQo+
IElzbid0IGl0IHRvbyBjb3N0bHkgdG8gY2FsbCBidHJmc196b25lZF9zaG91bGRfcmVjbGFpbSgp
IGV2ZXJ5IHRpbWUNCj4gc29tZXRoaW5nIHVwZGF0ZWQ/IENhbiB3ZSB3YWtlIHVwIGl0IGluIGJ0
cmZzX21hcmtfYmdfdG9fcmVjbGFpbSBhbmQNCj4gYnRyZnNfbWFya19iZ191bnVzZWQgPw0KDQpI
bW0geWVzLCBJJ3ZlIHRob3VnaHQgb2YgYWRkaW5nIGEgbGlzdF9jb3VudCgpIGZvciB0aGUgcmVj
bGFpbSBhbmQgDQp1bnVzZWQgbGlzdHMsIGFuZCBvbmx5IGNhbGxpbmcgaW50byBzaG91bGRfcmVj
bGFpbSBpZiB0aGVzZSBsaXN0cyBoYXZlIA0KZW50cmllcy4gT3IgZXZlbiBiZXR0ZXIgIWxpc3Rf
aXNfc2luZ3VsYXIoKS4NCg0KPiANCj4gQWxzbywgbG9va2luZyBpbnRvIGJ0cmZzX3pvbmVkX3No
b3VsZF9yZWNsYWltKCksIGl0IHN1bXMgZGV2aWNlLT5ieXRlc191c2VkDQo+IGZvciBlYWNoIGZz
X2RldmljZXMtPmRldmljZXMuIEFuZCwgZGV2aWNlLT5ieXRlc191c2VkIGlzIHNldCBhdA0KPiBj
cmVhdGVfY2h1bmsoKSBvciBhdCBidHJmc19yZW1vdmVfY2h1bmsoKS4gSXNuJ3QgaXQgZmVhc2li
bGUgdG8gZG8gdGhlDQo+IGNhbGN1bGF0aW9uIG9ubHkgdGhlcmU/DQoNCk9oIHNoKnQhIFJpZ2h0
IHdlIHNob3VsZCBjaGVjayBieXRlc191c2VkIGZyb20gYWxsIHNwYWNlX2luZm9zIGluIA0KYnRy
ZnNfem9uZWRfc2hvdWxkX3JlY2xhaW0oKSBhbmQgY29tcGFyZSB0aGF0IHRvIHRoZSBkaXNrIHRv
dGFsIGJ5dGVzLg0KDQo=

