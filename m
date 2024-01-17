Return-Path: <linux-btrfs+bounces-1511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37B83010E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 09:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868232877B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79BD26B;
	Wed, 17 Jan 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QeF+GT4s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QwLjTv/Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C901C153
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478972; cv=fail; b=dwyLMgJI/KX/uwSk88WbRHnI6oTDTgur0ISR2ZHq5PFzg9eLVsal/yl5dAZ+RsaCyR/AnL/5sPlbmwGz9BSoxy7aHXaqE/qISDShEjP+N3inu0MY9b3fxAnFMk10Z0Addw4ZH3tmBu7dLUYvfUdYM3hGXQiK7k+lmoRrvYzHwmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478972; c=relaxed/simple;
	bh=tH/jRpMBJUWOzgTlzg91co1hLC+w9SReobgZEbH9ojw=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=aEclIbVmsda1M5ZEliAd1EfZzg/Yn4zRr4crbJK9SwEzvgnuRTIr6Ru7cC0/vXtqrE7GZoMkSyoQ+29GrrTMvVc17avmROZLWdecXHixPe9LYl/lnt7KMgWIsUzIYvjgYpvHd12dKb/+J3VW9EqIj/JptkrX+8MO0BLbjMZpBO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QeF+GT4s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QwLjTv/Y; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705478970; x=1737014970;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tH/jRpMBJUWOzgTlzg91co1hLC+w9SReobgZEbH9ojw=;
  b=QeF+GT4svSZTr6BGUnt0X+Gs3NDtPpsVT4bBjimiob/zpndbxJFGwOML
   E3BFxdqMQUOuw+K571P/lz1ErHGgmeEic5UnpLwbZYc/FpEVhrJ6SDPUB
   /13/RFXJhnMe/E8f/AgHe27S75JTd55OOmUCr8S//9TqGbxtJx2G/EH4J
   qvpoeVEh4h5v7lrTzPY/pxzcWYYJa7iP21+K3WMLyios6Z9VQ9C9AWqwO
   YqFhc5xFaor60OYXQgpgNbHtOCshO+25QqRLTfGC7xANxGL8A8FsGK4jr
   TrNSbY2HATVIV+oPNQjDMua3bSp/7zMIj8a/ZfAkj+ztCJL70KjrPzIaj
   Q==;
X-CSE-ConnectionGUID: eFE/2XmSSyqxjvRoJS96qg==
X-CSE-MsgGUID: I9MeIwxkQmq0mq/JpDCsWg==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7025120"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 16:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUfeCEZQqKIuBCyqPFXdQ4H5ZMeC9qLuKbHFIVyTxMbRPsy7kALNrvWiE2WpJaKnEe1L/qeKVhUmmNjqb4AJ2mPy4rtOVkdghf5oYBIEuZKvVGah91g7IsKZsE5c0o8Go45snmLMBis/2rIeWztcl8ze7+M+60e4ADprmziIoWYiV0OlNYtaUome/MkJYhJrUdD2cUhE43M+IcGiUkpQeEVGdhS2x3ilYJdLTgfWRyjZm7/Q+FIeOaYDmrPjHKelEeXiU3r387kkJ13eatSuP9L6cpXQpWVQ1jQrWOlU2NRH4hJt4uOE3zEKGk6KA+AD2tqyqjhdnA0PDztOPIEn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH/jRpMBJUWOzgTlzg91co1hLC+w9SReobgZEbH9ojw=;
 b=AOgJx29y+Iegmnb54IP7VYPw0ArV8C5VxrlnPUlH6xqKo/wWn8Dkhu+rf3OaMSweuB3U5p5bNqvZ48WXsnIpNNduGWuTzs0bpKbfBTImOyUKHxb+KOqICHWh5IeWJvhptfjdvsxSr2uYqgluSjtb6zyLfsdEXN2aayt9S9tBvqgM0q8zoWRHpgUXj1lk6P2BwFamrbvwMcpS99gsDZ15u8c3RtBhUh7Id2tthrBQgfc1Qm86d9ZLOdfivTI9B/oEsRoROXWcvQ56IgjNJgYdDNjmMwSwX2/Je/dUONWutwGuriyydFL6ZHzp/hYllcBo/DQJULphuOFxXZ3OaRNO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH/jRpMBJUWOzgTlzg91co1hLC+w9SReobgZEbH9ojw=;
 b=QwLjTv/YH4Rpj9CqR5dPx7QE8lyGP/bXVMyA+hOfeHfZrOfSM9OzoET6FS7/poWFpntoSbf3yNy0TB3IagOChcMsw6+3jpC/ElTJpjKXmoajLw3svJYTWXzkH67yz8wzYskz3WPEiAzmQpjRIKiYmlTj0Ur9bN+N3CP8iPFgdEE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6887.namprd04.prod.outlook.com (2603:10b6:610:97::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 08:09:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 08:09:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Thread-Topic: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk
 length is not 64K aligned
Thread-Index: AQHaSNy+OX/p0UaZ8U2dm8znFmOQ/rDdoyIAgAAAwoCAAANUAA==
Date: Wed, 17 Jan 2024 08:09:20 +0000
Message-ID: <a83de224-623c-4370-82f2-45c8c6d5f134@wdc.com>
References: <cover.1705449249.git.wqu@suse.com>
 <7810799d-23c3-4a43-905b-e5112cd7d6e9@wdc.com>
 <7fec99a2-1eae-403e-a95a-32314f46b8dd@suse.com>
In-Reply-To: <7fec99a2-1eae-403e-a95a-32314f46b8dd@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6887:EE_
x-ms-office365-filtering-correlation-id: bc086740-5554-4d83-c4eb-08dc17339bce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ScjB7me+a+32rJxy7yElyaRuaN+mDxXh/OEk6cVIG3OEjlzdkr7rIwdEiz8y6j4ZbMiHNM5lFMb+hzJiqRdUPC9rx4MqxWEidoQHhMR5Yg6v0JUlXpIAfyPNYNpwCixeStwMznl1Rch3MZL+COnDXTda4SHhdiUTHyrT3XkDy62+enHwIqVjFZfZkFkL8ibFmMONPU0Q59EKDE+IvKZZVk0j8pRkPPmg1VsekyJrYCGhARryUK8FIRvX6/hZPMjSdy67MaO402S0oXtyYz47QHjURMFPjY5Ia0vt0vsFI0wlIbgOUahz1L2/zeTigqIIVOLI1IsVxl7Kov2Jh4J0+InKk1Ioe12HerxKXSITCdY1xz/jSBm/oE9vD3I2EiVYcUQ60DHe8NKtYgHsa46j2zHQ5U1vlcPxGdVbHj+7uwCp+nJSPZ8Mjc/Y+vX217lEki7EHCi/fCeK71idjsPbrmIf5FREeNyaN/STZf0VdCSCZ5s4dSeisbhjgGMnkENBcWmNi2ypHTH07JZ32lWQA3PkD0yt9gMAyc67l/P/fYohOwIx9FESpU3VAX+Yhio1WkYuRudKrNWM7llyy7119cmTJ6DTS7oK2cTS7hCdwVATrkRY2nbos7p59dJ52fsK6hvUFJHk4fpWfJt1kaoheOdhgNRCeZ369L4yRrXjIt/qk2SVQvw4J0CJIlKACifR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(71200400001)(6512007)(6506007)(26005)(53546011)(2616005)(38100700002)(36756003)(31696002)(86362001)(38070700009)(82960400001)(6486002)(8676002)(2906002)(76116006)(122000001)(83380400001)(5660300002)(110136005)(316002)(91956017)(8936002)(66446008)(478600001)(66556008)(41300700001)(66476007)(64756008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0VFYUMzdmNSSGY0NlNsVVYrUmVrdXNDMHkrZnpDQmFSZ01DS2lGbkpDaVVo?=
 =?utf-8?B?VnpOdEo0cGZ2d3FhT1BTcTZYMFpvZVF4eXpYaGpRSzdjRXBHNTBEUjJtbS9k?=
 =?utf-8?B?VS9KRktwRFZXcVYxb2tvV2hzK2xiV3BabDZDS0tyMXQvMklNMzBKdDRUaEFQ?=
 =?utf-8?B?ZGl4L0tZemErVmh5Nmw2ZmN5WDRWV21uL2JIWFBxVEo0d2UycFVvU2N6alJq?=
 =?utf-8?B?d05TeERFWVNGaDZlaG04MjRERUIyUEVlMytLM0JIZzJvcGUvMk5OVEw1ODN2?=
 =?utf-8?B?bzFpbVFuTncxWVZmNGI0MmkwUWIrOHZ3Y2hhQnpYb2tCTEhyc08zQ1BCWUR1?=
 =?utf-8?B?YUxhcHE5Vk14Q0ZKK0Vwc1pRb1JyMHJzeUJrcEJyMk40czE4RXlEUVM0bHk2?=
 =?utf-8?B?STcyekJIN0FMTDhDODVpSjBocWo2Uk5HNkppQXE4L1JKdjBiNloyYVJJQWtx?=
 =?utf-8?B?dmM2eVVmMzg2dS9VMVJ1eW1sZDdEYVl6cGs1bTRVd2pUd3pyYlpPZ2pPVUxp?=
 =?utf-8?B?TnlCclRwZnRHMVFNdm5JR3hnUFZTSHFGMWJNeCtvSUJtSm03bzJaaVM1bmNV?=
 =?utf-8?B?K2NSZjRFTHp5NGtrZ1BJTWptSHhwaFBMaVFQMlRmdElNblJzdGxUNCtqbDZw?=
 =?utf-8?B?ZzZaQ0duQ0pjR0prclI0L0JQMk02OEEzTndxSCtFeWUyZXhXYm13VTBma0Vo?=
 =?utf-8?B?Yks1OFluUzJUZFRac0c0N3AzdDNoM1pDZTFyV215YTJvRjZmY09lY1lGS3A5?=
 =?utf-8?B?MTEyQ3hRR3F1MVdxR3dDeThBMGhWVUYwclp4L3B4dDFvOVloNXhBN2kxVVVQ?=
 =?utf-8?B?RG93VHd4aDRTdlFKM1pkS3RQQkpQaDkvMklWalNhMks4bU9ndDJPWi82Nitj?=
 =?utf-8?B?UTlRdkRENzMyVHF0Q0xicG92cTZPRVRrcVNxU25JMHVpUVo4bGJFQTZ2MXd6?=
 =?utf-8?B?ZHdycXg2YUxuM2dmZnhFZ1JvTGZET3dCeXVIc3dxcUVoVVJRWjN5MnpFUXlx?=
 =?utf-8?B?WVIvUFVXWkhhWm8wZFZXWDN1bDlNSG5wNGRIaFBxb3VyakpOWmxkVnBpY2c2?=
 =?utf-8?B?UHdURFZNU2Y0c1V1NkhmR3hBZFAvanNxb2FVS2RnNFZhaktpQzYzTnY2YUpI?=
 =?utf-8?B?OGtBK0hMTXIvWmJZU1N6djVvUWlYQ3VKcndHaXEwZFN4SFZHMUxGeWcwSDQ0?=
 =?utf-8?B?K2pzdWU4dUxRclByQnRHQmFFeVhlOXFVamx3TGI0b3dYdWgvam9zME9mZXI1?=
 =?utf-8?B?dEszWUlncVBLMWRiMWZZeDY0dGMrTDZYOWVNeEhEQTQxY0xIT2J2dU1XN2ZY?=
 =?utf-8?B?UHpCL2VJTnF2YWFuQk9LRlBxay81QTFhSEMrcTJZOEtLaGxFZDA4N1B6eTd2?=
 =?utf-8?B?eTZpeGJDN2txVDlyQUYrTGNLSHZ3eWtna3FyVWNsUlNWVGxRSlJzd3Y2ajZP?=
 =?utf-8?B?NWZUb0U0NGttNmlKaDR2YkpOTHVnSm8rSENQVUtkQlp2U3A0Z3F4cTdCaHRq?=
 =?utf-8?B?T1ZBaGg5c2hRZERqcmtWUDQ2Smp4czhPRlhVNTlzRXIrdjQwNjYxN2dkNG9S?=
 =?utf-8?B?djFBOEVzdnYrMEJDclpVN0xlSTNBZmdpbXQ4VExSbEFZeDUrTDY5eUVRRGxR?=
 =?utf-8?B?enN1VkVDVllzNmR2OWJVTVh5U0RrN0VkdnFUYUI3L1l4V2h3VTdhVWt6M09m?=
 =?utf-8?B?ZTdqV2pQa1cwWTMveGxTeUM5Tk8vSUJGQnJ1eGg0THRMUU5QaEwwOUZyVVI3?=
 =?utf-8?B?NEhCRjVwcWpsdUNsc3pJa3RKK2dNRnpsRnJVaTdFZjc2WHhpc1AwRFErRkNa?=
 =?utf-8?B?aVBnaEFyT3lNcGxOcGo5Ny8zZTI4NXRWMjYyNmF1N2l2SU9aK0d1U2I2SFFX?=
 =?utf-8?B?WmdWM3pIb1BUZWxKTlNieXdJTkk4RGY0UzM4cWdnWUhEUUR5UXZ3NWNvNy9X?=
 =?utf-8?B?QXU0V29USjY2RUY3Ri9DaTQ3dEN1RVRGSWFUSVhEOFJZWFBOK2VtNnZLNUlS?=
 =?utf-8?B?NG5idkZmd096SHFyRUZhdjQ3NEZFdFJzYkRxTzMwRUFxNXc4dmg4cnN2Z2lr?=
 =?utf-8?B?eFUxZHlTeWxtVW1OcEt1Y05zUTJCWVRhVHFub1pNVnFtdXE1OTlFZTZlaUlC?=
 =?utf-8?B?clN0LzFmaHhPTXFYQWF3YWFYL21MS3NiZFpFYThjQ2ZOSHVDUDZaMGYzR2N0?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4AA5760187E44A8E59BF68C0D4C6A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5COv3IHoOoWhxmxf+rPBaiQtGygkLJBrWtG1eX6L7wSajRdibDH4lVEMBfRl7BVCtvlGwZkHvk3Nrzz43zaAobv1Roq+Kja6O4GQhaMPictjOmFJB6NRKRryJ904vc16tcMV1U+CRSe0mCIwWvusJ0rg1rXHesd1xpa/b2IQGu38dioLi4hpZ5/7FRcshJdYuHJdffZce6bQfciVCvtH7j15BfIWZIYff+oNppwE/LSY5rUmU2esIN2kfBjpjq9z82HkuXJSd/MNTWzJsY8mNn5aYiXgNRoAxAbFcND/wYK6apMsu0TEZR8Kz8HS2WGO4/s8Q2ysQoXN0uOU2bWZbujrSjsxvsVNybqamUmxv/XbIFyoVgYmAXKpLoot0H9DfoeXm+75ZgI3oF5Xb7tCwisNugRoOHVzZ7xfcvo1Se7Ru/YcGCJIybWD5dUeG8xZCVtrMpYNwz+iueAb4fOGdUj5VazNvFR8T2c716VGqIR9cV+C8MLuyNS+W7ELIIpyjhrmw6WL0GWfsKQjeIWZ2Nj+7cAiOArEvImx4TzIhdQoX+JfTBy9rV+cSX+rhkEGY93arUyzmYyg+6BkTK8cU2ElE3TL84bbDFF2Q883wFpL1xp9r0DXYpnl47zDQPRI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc086740-5554-4d83-c4eb-08dc17339bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 08:09:20.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N24ERkc8QrGxyYK5ooUOeQty8uVT3V88plRLQ+6ddXwTWC3hWSXFm8Ecdo8Z6qpKfoEFlpHl+//t2Fapou8tzOSIcyiJOidsODeRwSoWXeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6887

T24gMTcuMDEuMjQgMDg6NTcsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDI0LzEv
MTcgMTg6MjQsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9uIDE3LjAxLjI0IDAxOjMz
LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4gW0NoYW5nZWxvZ10NCj4+PiB2MjoNCj4+PiAtIFNwbGl0
IG91dCB0aGUgUlNUIGNvZGUgY2hhbmdlDQo+Pj4gwqDCoMKgIFNvIHRoYXQgYmFja3BvcnQgY2Fu
IGhhcHBlbiBtb3JlIHNtb290aGx5Lg0KPj4+IMKgwqDCoCBGdXJ0aGVybW9yZSwgdGhlIFJTVCBz
cGVjaWZpYyBwYXJ0IGlzIHJlYWxseSBqdXN0IGEgc21hbGwgDQo+Pj4gZW5oYW5jZW1lbnQuDQo+
Pj4gwqDCoMKgIEFzIFJTVCB3b3VsZCBhbHdheXMgZG8gdGhlIGJ0cmZzX21hcF9ibG9jaygpLCBl
dmVuIGlmIHdlIGhhdmUgYQ0KPj4+IMKgwqDCoCBjb3JydXB0ZWQgZXh0ZW50IGl0ZW0gYmV5b25k
IGNodW5rLCBpdCB3b3VsZCBiZSBwcm9wZXJseSBjYXVnaHQsDQo+Pj4gwqDCoMKgIHRodXMgYXQg
bW9zdCBmYWxzZSBhbGVydHMsIG5vIHJlYWwgdXNlLWFmdGVyLWZyZWUgY2FuIGhhcHBlbiBhZnRl
cg0KPj4+IMKgwqDCoCB0aGUgZmlyc3QgcGF0Y2guDQo+Pj4NCj4+PiAtIFNsaWdodCB1cGRhdGUg
b24gdGhlIGNvbW1pdCBtZXNzYWdlIG9mIHRoZSBmaXJzdCBwYXRjaA0KPj4+IMKgwqDCoCBGaXgg
YSBjb3B5LWFuZC1wYXN0ZSBlcnJvciBvZiB0aGUgbnVtYmVyIHVzZWQgdG8gY2FsY3VsYXRlIHRo
ZSBjaHVuaw0KPj4+IMKgwqDCoCBlbmQuDQo+Pj4gwqDCoMKgIFJlbW92ZSB0aGUgUlNUIHNjcnVi
IHBhcnQsIGFzIHdlIHdvbid0IGRvIGFueSBSU1QgZml4IChhbHRob3VnaA0KPj4+IMKgwqDCoCBp
dCB3b3VsZCBzdGlsbCBzbGllbnRseSBmaXggUlNULCBzaW5jZSBib3RoIFJTVCBhbmQgcmVndWxh
ciBzY3J1Yg0KPj4+IMKgwqDCoCBzaGFyZSB0aGUgc2FtZSBlbmRpbyBmdW5jdGlvbikNCj4+Pg0K
Pj4+IFRoZXJlIGlzIGEgYnVnIHJlcG9ydCBhYm91dCB1c2UtYWZ0ZXItZnJlZSBkdXJpbmcgc2Ny
dWIgYW5kIGNyYXNoIHRoZQ0KPj4+IHN5c3RlbS4NCj4+PiBJdCB0dXJucyBvdXQgdG8gYmUgYSBj
aHVuayB3aG9zZSBsZW5naHQgaXMgbm90IDY0SyBhbGlnbmVkIGNhdXNpbmcgdGhlDQo+Pj4gcHJv
YmxlbS4NCj4+Pg0KPj4+IFRoZSBmaXJzdCBwYXRjaCB3b3VsZCBiZSB0aGUgcHJvcGVyIGZpeCwg
bmVlZHMgdG8gYmUgYmFja3BvcnRlZCB0byBhbGwNCj4+PiBrZXJuZWwgdXNpbmcgbmV3ZXIgc2Ny
dWIgaW50ZXJmYWNlLg0KPj4+DQo+Pj4gVGhlIDJuZCBwYXRjaCBpcyBhIHNtYWxsIGVuaGFuY2Vt
ZW50IGZvciBSU1Qgc2NydWIsIGluc3BpcmVkIGJ5IHRoZQ0KPj4+IGFib3ZlIGJ1Zywgd2hpY2gg
ZG9lc24ndCByZWFsbHkgbmVlZCB0byBiZSBiYWNrcG9ydGVkLg0KPj4+DQo+Pj4gUXUgV2VucnVv
ICgyKToNCj4+PiDCoMKgwqAgYnRyZnM6IHNjcnViOiBhdm9pZCB1c2UtYWZ0ZXItZnJlZSB3aGVu
IGNodW5rIGxlbmd0aCBpcyBub3QgNjRLDQo+Pj4gwqDCoMKgwqDCoCBhbGlnbmVkDQo+Pj4gwqDC
oMKgIGJ0cmZzOiBzY3J1YjogbGltaXQgUlNUIHNjcnViIHRvIGNodW5rIGJvdW5kYXJ5DQo+Pj4N
Cj4+PiDCoMKgIGZzL2J0cmZzL3NjcnViLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pg0KPj4gRm9yIHRoZSBzZXJpZXMsDQo+PiBSZXZpZXdlZC1i
eTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+
PiBPbmUgbW9yZSB0aGluZyBJIHBlcnNvbmFsbHkgd291bGQgYWRkIChhcyBhIDNyZCBwYXRjaCB0
aGF0IGRvZXNuJ3QgbmVlZA0KPj4gdG8gZ2V0IGJhY2twb3J0ZWQgdG8gc3RhYmxlKSBpcyB0aGlz
Og0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIu
Yw0KPj4gaW5kZXggMDEyM2QyNzI4OTIzLi4wNDZmZGY4ZjY3NzMgMTAwNjQ0DQo+PiAtLS0gYS9m
cy9idHJmcy9zY3J1Yi5jDQo+PiArKysgYi9mcy9idHJmcy9zY3J1Yi5jDQo+PiBAQCAtMTY0MSwx
NCArMTY0MSwyMyBAQCBzdGF0aWMgdm9pZCBzY3J1Yl9yZXNldF9zdHJpcGUoc3RydWN0DQo+PiBz
Y3J1Yl9zdHJpcGUgKnN0cmlwZSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgIH0N
Cj4+DQo+PiArc3RhdGljIHVuc2lnbmVkIGludCBzY3J1Yl9ucl9zdHJpcGVfc2VjdG9ycyhzdHJ1
Y3Qgc2NydWJfc3RyaXBlICpzdHJpcGUpDQo+PiArew0KPj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IHN0cmlwZS0+YmctPmZzX2luZm87DQo+PiArwqDCoMKg
wqDCoMKgIHN0cnVjdCBidHJmc19ibG9ja19ncm91cCAqYmcgPSBzdHJpcGUtPmJnOw0KPj4gK8Kg
wqDCoMKgwqDCoCB1NjQgYmdfZW5kID0gYmctPnN0YXJ0ICsgYmctPmxlbmd0aDsNCj4+ICvCoMKg
wqDCoMKgwqAgdW5zaWduZWQgaW50IG5yX3NlY3RvcnM7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKg
IG5yX3NlY3RvcnMgPSBtaW4oQlRSRlNfU1RSSVBFX0xFTiwgYmdfZW5kIC0gc3RyaXBlLT5sb2dp
Y2FsKTsNCj4+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIG5yX3NlY3RvcnMgPj4gZnNfaW5mby0+c2Vj
dG9yc2l6ZV9iaXRzOw0KPj4gK30NCj4+ICsNCj4+IMKgwqAgc3RhdGljIHZvaWQgc2NydWJfc3Vi
bWl0X2V4dGVudF9zZWN0b3JfcmVhZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBzY3J1Yl9zdHJpcGUgDQo+PiAqc3Ry
aXBlKQ0KPj4gwqDCoCB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmZzX2luZm8gPSBzdHJpcGUtPmJnLT5mc19pbmZvOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBidHJmc19iaW8gKmJiaW8gPSBOVUxMOw0KPj4gLcKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgbnJfc2VjdG9ycyA9IG1pbihCVFJGU19TVFJJUEVfTEVOLCANCj4+IHN0cmlwZS0+Ymct
PnN0YXJ0ICsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyaXBlLT5iZy0+bGVuZ3RoIC0NCj4+IHN0
cmlwZS0+bG9naWNhbCkgPj4NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZzX2luZm8tPnNlY3RvcnNpemVfYml0czsN
Cj4+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG5yX3NlY3RvcnMgPSBzY3J1Yl9ucl9zdHJp
cGVfc2VjdG9ycyhzdHJpcGUpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCBzdHJpcGVfbGVu
ID0gQlRSRlNfU1RSSVBFX0xFTjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgbWlycm9yID0g
c3RyaXBlLT5taXJyb3JfbnVtOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGludCBpOw0KPj4gQEAg
LTE3MTgsOSArMTcyNyw3IEBAIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9pbml0aWFsX3JlYWQo
c3RydWN0DQo+PiBzY3J1Yl9jdHggKnNjdHgsDQo+PiDCoMKgIHsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IHNjdHgtPmZzX2luZm87DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJ0cmZzX2JpbyAqYmJpbzsNCj4+IC3CoMKgwqDCoMKg
wqAgdW5zaWduZWQgaW50IG5yX3NlY3RvcnMgPSBtaW4oQlRSRlNfU1RSSVBFX0xFTiwgDQo+PiBz
dHJpcGUtPmJnLT5zdGFydCArDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZS0+YmctPmxlbmd0
aCAtDQo+PiBzdHJpcGUtPmxvZ2ljYWwpID4+DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmc19pbmZvLT5zZWN0b3Jz
aXplX2JpdHM7DQo+PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBucl9zZWN0b3JzID0gc2Ny
dWJfbnJfc3RyaXBlX3NlY3RvcnMoc3RyaXBlKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQg
bWlycm9yID0gc3RyaXBlLT5taXJyb3JfbnVtOw0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBB
U1NFUlQoc3RyaXBlLT5iZyk7DQo+Pg0KPj4gU29ycnkgZm9yIHRoZSBjb21wbGV0ZSB3aGl0ZXNw
YWNlIGRhbWFnZSwgYnV0IEkgdGhpbmsgeW91IGdldCB0aGUgcG9pbnQuDQo+IA0KPiBUaGF0J3Mg
d2hhdCBJIGRpZCBiZWZvcmUgdGhlIHYxLCBidXQgaXQgdHVybnMgb3V0IHRoYXQganVzdCB0d28g
Y2FsbCANCj4gc2l0ZXMsIGFuZCBJIG9wZW4tY29kZWQgdGhlbSBpbiB0aGUgZmluYWwgcGF0Y2gu
DQo+IA0KPiBKdXN0IGEgcHJlZmVyZW5jZSB0aGluZywgSSdtIGZpbmUgZWl0aGVyIHdheS4NCj4g
DQoNClllYWggb2YgY2F1c2UsIEkganVzdCBoYXRlIHRoZSBvdmVybHkgbG9uZyBsaW5lIGFuZCBj
b2RlIGR1cGxpY2F0aW9uIDpEDQoNCg==

