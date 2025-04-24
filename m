Return-Path: <linux-btrfs+bounces-13351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D15A99E87
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 03:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488EF7AA57B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D61E3761;
	Thu, 24 Apr 2025 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QiearlAi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d9OXqS61"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FA1D799D
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459550; cv=fail; b=e1loTqEuoRE3x4gTJ36PVAqOy8SQGnIWU0AIwYjubBEzChgpyp5NwSUFGmrGoymv/HFOXXeVQ0fs7V7LTN6R+6IG+r57bj+bdud1QMY5+kwNJbotZFhCZ7s1kvTOqiiJvFCmbKO5MQl0Eroyb40UIC5UBIopCpNhx+hfNXJV8tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459550; c=relaxed/simple;
	bh=n6HI1zgib7rVgw8iFGj8Bg6iZ6xmYZmBN+v90l4vyd8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAZY+rVbFHj/BXOsarEFKbjyXOqhV/iTkfW640JVmhQvB+Wfz4t2TR5LJBDC58Hxfad3La/pJzAqaCxXOiS+X+DJ1tAZtz4SVZFJ159v9++ew24rxlKlNKIeY4/CFo2vBnCh9qasHD6N3ZoDa5TlqNAHuPIPiuEbiqVufbkYOm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QiearlAi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d9OXqS61; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745459548; x=1776995548;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=n6HI1zgib7rVgw8iFGj8Bg6iZ6xmYZmBN+v90l4vyd8=;
  b=QiearlAit8lCzmRn8M9U5kq2yVI4Mr9P2iifPxQ2Qvu+uNwAwGLIrl9Y
   p3ohsY3vp6dT5u/h4AoLWx4qGmuEPHwO6fjZrBCrmGWeT4ilf4YLv0VXl
   nwnSmh3V6kxtMAxL7e5QA6s4rlHcsbvierpG+H8A+VSYSqFfDtHe/qeO6
   50tLWx3jYK3zYouv/OmvMtTezlVSEW5Fd+xP61Vn9CzMPyEKyN9BtYqYg
   PVHYpN3gWpzTBquDMiQJw/7BFfUKqQIpYIqqQxRdaYo+4QgvXhocPLTjI
   ENQaRBiVp552i6WQ2z5LQy39Jntjp+EAPsM+AG81a1YPQm6BdjrG54x/P
   g==;
X-CSE-ConnectionGUID: VKe2cwF4RZukZCwpSc2k4Q==
X-CSE-MsgGUID: 3wRBr2dwS7uZ3r9sQMDD0g==
X-IronPort-AV: E=Sophos;i="6.15,233,1739808000"; 
   d="scan'208";a="76323006"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 09:52:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVR2q7/RM3S1QoTBUVzENYeElGrfrA4xVjWmHdUpYLLkjuHRCZG0V0IeP6Zjsec/1hxtMnOgvdx3H7bb3UyJRA0cQNk7xvS2jO1dv9kziYwTA0BB5w4bEwHXAJk2noXwXxWQJbNLhw6n9iczV0eRs4dALJ4iCSx+VM7ihsOHsFdHBLGdTTs4YoH+V9YHUBMu//KjCR1tIFF+7ECP1yYoH8kQ4x/Ec+hjhMne3t9AJD+8+AG1t7xvUXXT4ioCUqTAB/JgEi5xfENGX20EThVgHbHGLbrB02oCtCmcIJdxblGw4o5bO9XqjpvvWjlWKJDQrHUTzoCHzysKviPqcJFtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6HI1zgib7rVgw8iFGj8Bg6iZ6xmYZmBN+v90l4vyd8=;
 b=VwrbuKih5NPopC9Du7WjN54Wq+uB6LHyxCgFwTf6zby/uW+9OVk3PbyEbTDjDYGf3amM+Uuod0yNVhHnveN5rtvn/YH9Xk/2H+FRe5FBEfIAuG4LmvGbykKTnChstsew752kq1OqFAnQE25Uf8f/fgF86BslN3rASgapbY5oUWUKlkP0MNUOBxVQrzUJzElz3gAVYZ51yfGJIrRbqrRiQElImd2XBWe3/0p1U0S94eLVdPK4bdoeQOrFV7w2TIqEbKClSXiTdN2bKWddh+qT9vX4QMq1Sonw9fFfk28ojJUQWNisbXkeUJxnDT4KpxOg6JzqMOma96F3qwXzIic9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6HI1zgib7rVgw8iFGj8Bg6iZ6xmYZmBN+v90l4vyd8=;
 b=d9OXqS610Zwr7eqnlYoYOTLpi0e/oF3UYI9q9KEd5T7LDZSg3uGEMQ6F8x+AaHD3i0agqwPwTBKlnp6UfOwCgo++9evNnKZh/H1neibTPbWpQOb8AraI2Ev649PfmolEVgiKSDznCpRFLnHbqzQw1Cw2ArH5k3KfHkH/x36C7tQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7699.namprd04.prod.outlook.com (2603:10b6:303:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 01:52:21 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 01:52:20 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: reformat comments in acls_after_inode_item()
Thread-Topic: [PATCH 3/3] btrfs: reformat comments in acls_after_inode_item()
Thread-Index: AQHbtHBndU+vm/DQak+ndK//aIzeZrOyDc+A
Date: Thu, 24 Apr 2025 01:52:20 +0000
Message-ID: <D9EHQPSBBS4G.2B8ALJ1KNJMET@wdc.com>
References: <cover.1745426584.git.dsterba@suse.com>
 <8f6470c838cb98fd83136e3285af6afd8b8f293b.1745426584.git.dsterba@suse.com>
In-Reply-To:
 <8f6470c838cb98fd83136e3285af6afd8b8f293b.1745426584.git.dsterba@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7699:EE_
x-ms-office365-filtering-correlation-id: 454dd461-a216-4745-b868-08dd82d2a69e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFQ3U1hDRGdmZTc2SmEvMTEzVVByL0hnTkt2UWEwL202Tko4bXhLcGpCUUhv?=
 =?utf-8?B?RUl6bGJEb1o3NGVVc0k2WEZ2SFVWcGxoU2NXWE1EM2JidDg3cjU2ZjFjT1NC?=
 =?utf-8?B?MXMzSVZrcmhkOGJlT0xtSzRmZWNVanpZMFFpOWpYV3d2d3JSYzQ4eDZUcGRk?=
 =?utf-8?B?L1BVbXpXdkdUZG1XWDk1M1dOenpHQUgvaVBuRURzNkNGbVNqajZQRlpqaWh6?=
 =?utf-8?B?eGQwTStjYkNMaC9URkc1T2xnSVZYVC9UR0o5KzRMN3ZFN3Q5c29MYmNMZFI5?=
 =?utf-8?B?M1FWUjgvLzVMU1dxUnNHNy9KYXIwNS9xQkZjME4raEt4aHBZY25vSkZLYWIw?=
 =?utf-8?B?a2ZMYUNEbVdUMGUyZDY1NmxTSHNYWjJ2TUhzRnNEeWZXQWpwWU1HY3hjVGYr?=
 =?utf-8?B?M1BUOUNvREhONXJ5bXV5RzJLbUpFUGVsMk5NYmtrQ2dLd2xDWWtlTVgra0Ew?=
 =?utf-8?B?MkM5bVlFV1NvWkhidVphMzJYTERpbm1qYUQ5b09vd0taVkovVjJuK1RYUEJq?=
 =?utf-8?B?MUJYeHdsMDJyenhvK0dsSzJDd29jV1Fvd0xBRnUxQjRaUXhnakRvZ1Y0RTBJ?=
 =?utf-8?B?S0NlWEFLOXZCK2d6WEFyK1A4aGhYQnAvZFJGbGNwMGp4NndtRnZwK0VNSUNH?=
 =?utf-8?B?ZE1DckVZRWVRZHlHY1d5N3hxMHNTQWVwNHdZb0h3WUowZFRVanN5aDhlbDE1?=
 =?utf-8?B?VmxNNUZUbEp5LzV6NVBnNVF6TFJEVmNhSVBkTC9kSm1HMm5WNXY3dlo1R0Ft?=
 =?utf-8?B?dmdDZ2pMbTNjNEx3OGpBMDIxTnFLaFBVUHpGcDNPSFpzZnZnT3RzOXNGV2pR?=
 =?utf-8?B?Uzl3R3R2WjFrOGtYZVBuNmNvZzU0RWIvNys2aWtVWS8wZkdCUFNGVVd0OVdT?=
 =?utf-8?B?V2hpdFhid2FmN1FKaURwTXQ5UjJCM0UwaFZ6Q000em14NXlPZ0Q0MnIyK3JV?=
 =?utf-8?B?ZXdlSzVvUUN3YmpEbWxwR3RhMmI5SWJTejZCdDhWOUhRQTFmdHZ5UnRZZ3lo?=
 =?utf-8?B?dUFwRjd4NWJ1TDVIL1lPY2FoRWUxYWdVSWZzcVFmdnJPSytZSG01UnVOMFZK?=
 =?utf-8?B?aEhSUllwbWxhUmxHU0lvZ1E2ZHlKdHlLUHZuV052M2FHS29CcmJQdzduY25i?=
 =?utf-8?B?dFpER2lyak9FN1lzeEFGNGxXcGJxZmJ3bVlXczV2Qng1alQ0cGpxejhPRm5Y?=
 =?utf-8?B?bGJlNnVsYy9oeFZYS2tTUktuNm4vTkprajZ0TFFyWVZHK2wyOVBSQmVJVkkz?=
 =?utf-8?B?cFNhQlJEbkQwdDFNS0xMcVBySTBVRHZOb3Q0UTVxem56SVhqMEc5dlhYcG1J?=
 =?utf-8?B?eFdOblNrTDhWODh5WndRL3V2UmZIVW5LSW5pNm5tNWVnVnIzSjlZNW5seTdm?=
 =?utf-8?B?MTBpTDNpb0dSOWdZVjF6eVkxNzZCcTY0UDdNVEhXakdvTkhaSlR5QTF6OFlM?=
 =?utf-8?B?ajZybEhseWFVZHVjSWdoUmNxL0VzRlZVdjhOdWsvN2dZRStqQ3hIV3Z5UzNR?=
 =?utf-8?B?L3FYeTJKWUwrc2RMNUFXUytGbjcyNGJ5OG5XU0pnY05Xc3RVbVJITEI2VG12?=
 =?utf-8?B?cnl3N29xOFpFOW5sakd3WTkxUmd4WGZmTWlDYXdOYStSZ2t6d1hacXFhcUNN?=
 =?utf-8?B?SnA2TmdBRDNYakowQ1RyZ1VDM1crZXhCRUFmQzlGYVRNTHYwVWNDUjhGdGNZ?=
 =?utf-8?B?aDlCV1NOMktQZ0RwcnNnT0NSY1VWd3JuR2NiM05XSDFRdnkrTVBkaTAzbERS?=
 =?utf-8?B?U1RZd1Y3TzRnTGlmcVhOYUtXZzg2N0RNWXg0alNtK0VNMkdEME1uUnAzYS8y?=
 =?utf-8?B?ZEE0c1h0aEYxWHk2dUZHVjFYMXdLVzgvc0hqMExIeng5a3JMNXFiR0R3K21O?=
 =?utf-8?B?dzcwZVlvVFdHbWwrWWh2UEtoSnM5NC9PTDF2c0dTV1dKc1JXUDI3aStWOHZK?=
 =?utf-8?B?ZlQ5L01ZaHV5UjNSMHJWSjZCeFczdkVhSnl5OGFNS0wzZjkvc2tnMG0vVEhF?=
 =?utf-8?B?ZGtiL0x5Um5nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkU1Mi9CdncyREtZcmZnaEFyVGR3aFRIL0RmMVpINTNEZ0QrWURPWE5IbW91?=
 =?utf-8?B?Ylo1ZEtYQVEvdGhrNGFNWHRUODRpZlR3aXZZaWRuNmVEdlJNOUxhQkpFc3lt?=
 =?utf-8?B?TEVXT2Mrb1Z4T3N4Wk5maGFIclNwQ1VmY2J0WjdpQ2ZHRVR3cGxKSGtPSDkr?=
 =?utf-8?B?ak1vczZ4K3ZzbVdaVkZmVlRhQ3c0TWY5cFBJZG1hUnRId2lzc1NXa3d5V2h4?=
 =?utf-8?B?VW1DZktJckh4cmovU3JpT1FxVXU3OUtneEpoUDFQaXU2cWNXQ0NIZnI2ZWN4?=
 =?utf-8?B?U2Q4elVoSVdDWElhOEpaZnE0cy9SaU9vbnV5djFwNHlPb2lhRnZkcFExMFBN?=
 =?utf-8?B?Q1g1Vk02NnRtNFd2MWpwNXNYTVBCekNzQjNoS2pQWVBQOHo1NFRDWlgxK0V2?=
 =?utf-8?B?cmRYOGIrNFZZSU56UEU2cVd1SGxXL0hjblV5YTJTU3pSaW8xUStobHlycFRY?=
 =?utf-8?B?aUIvMG9FQWluN2J6WkN3NndkVkwyY3FpWnI0YlNVWDZXcVdNUFA3WE43dW9w?=
 =?utf-8?B?cEVmcjE3dGQrSy81amEzMzR1RkJoMm5JVlhtdm9KdmU3YXZ6K3lWSEZmZGp3?=
 =?utf-8?B?a1d4bEFQTGVMOGFDR0NqSzR6YzJlQ2dXMU1aMmUxNlpBWkx1YmtBNTFFYno2?=
 =?utf-8?B?MGdnbU13cUxQVFh3aFl2YVlENnJZM1lzemtQL3owNDg0YXJ2Y0pIeml0YS8w?=
 =?utf-8?B?RGZ5TmRRVHdlc3QvR29tQWlaZ3F0bTNyNUgreDBsMW94Q1RIMDIyUW56RkJz?=
 =?utf-8?B?WTRHc25uVzdIcUU4cGZNRzdZOTRNNjgyQ09GelVmYkhRUVAvRzczMTdVQU1M?=
 =?utf-8?B?Y3B2VGt3dElhR3lGeVJuM2gvWHlKOHhNWTZnZXIwUUZtNEdTazlGeDZRZCsw?=
 =?utf-8?B?cmYxQ0VrMUV4Vkw2eXU5VmlnVitMeU1mQzhFTzJkZGFERlZSUkE1d2srMDhF?=
 =?utf-8?B?VTArWk4zNitXYmNWWHo2SGN0RG8rSW9CWllVNUpyL2N0U0FvRmJXSGJha3lP?=
 =?utf-8?B?SkdSbFk1RWxYTHJzUldtdkJySEpvNEIranJOZHR0RS9TNm1LZG05NW5Bd0Vx?=
 =?utf-8?B?OUVRMTYxUjExcXVlc0cyTW5ncXJGSFpRdjhkZ2ZINFY2Tkc2aHBKMklpREFX?=
 =?utf-8?B?d1JXZWc3eUVNbmxwRlFKWWpTdC93Tmo2VG81aTdlaDVFaW9Yd2lnVFBlNENa?=
 =?utf-8?B?YnZlQmxKSldabnpqQUhoY1dGVHlYVGF0MDZ0RklkS0pUdjM2WWF0M2tJTUh5?=
 =?utf-8?B?OWt3djFMQytoU3ZnOFlteEFEMGE1aENiVFkyV3dHRXJpOXkwcktkMmZTOWVP?=
 =?utf-8?B?YWhLN0plZTJGdm1qaXVZK0Z5YzVUbGQyOE40Y21wR1I4NmhDUVAyNHVKU1l5?=
 =?utf-8?B?SU1JMWxlMHZWQmlsY1NibTdEbWpKa0xOdU9IcndRclVrendncXJ3cjJRWGpM?=
 =?utf-8?B?aXBUNS92aDNRZElodGtrdkhnbHJDb1llU09VZG82Nll5OVdOTE55T1lJTzZx?=
 =?utf-8?B?UnJadnRZTFFQdlkxRElTd3ZsLytIK3k1RHcvdkVSR0k1YmtNdm5kYnRnNjBp?=
 =?utf-8?B?Qm1BbndCVmQ2aWhHRGordDdTM2VCckViSEF5ZFdsUGtHTVFGYTZJd0xJYlhl?=
 =?utf-8?B?Q2Zpcm1WQW9RcmZNRFNvVU4rZUx5SmhTdExkSmE4bkswSUZTcmtKc1l0OGVK?=
 =?utf-8?B?cndaOHhzUlRUeXVuRUtDMGZ4OUN2aDI3SDlQM2dwOHFVMTZkRmYwMWREdVFP?=
 =?utf-8?B?djVJQTU4MGFmQmZjaW0rN2ErYmV2VWw0NWZPRDBScUYwZnlCaGpPSmUwTlpu?=
 =?utf-8?B?T3Z3eUlhWm9pTU42bVFmRzVCeE9ZalJhclhtY0NTYVNuUGdHMENDelc3eGxO?=
 =?utf-8?B?QW8rdVp0Ri8zUlU5Y2RnS000Nk1lN3ZhU2lyanZac3BHQVRHeHcwMmQ3a0tS?=
 =?utf-8?B?R0h2WEhzSGFBZ25HMUlEY3VVd05PZnR5WG1GSm93c0RleXc2MExLbjhEcXB2?=
 =?utf-8?B?b09kcTNBcHRDQ21NRjhJL1BhbWpqckkvNU03Z1dzWERvelgxOERGVGlSYUFL?=
 =?utf-8?B?SWFNelp5OFFlcTVSL25DNWJYSHFJZDZmSllDTVBYN0JkdHFwd24wYTNabVpu?=
 =?utf-8?B?QVM5em1rQWh2ZUJEV1dqbGplSCtrRFc4dzQ5VFJoY2hTOGpNTTArbXgyNGZD?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345E2753A85727448C4D336D15F08A44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SFgQD0TwgmJoqTt21Fjl7ex63rFT/w7AnRBa4muzoUKYFAUaohcB/lS78DRzbXT9g5C77Js5zkr1Dd3dXmtOpLNeJUoQmETo6edQiZPgOMcW/3JxpjrDAa+RqWFPnYnrKq8kxVBlABn2ICi0cxUCvtKqZNUxgQn1orrRZ18AKLE7nn1auY1ozrD37hOXEl9k8ydYe/GolOQP3rN1gSVZaiNlRGtbcsn5u8AmKmW9zq/cmWHkQGfnnuh4mlVvoSDZ5xgIUXNtTmFogwg8zXOBm+xJ9+/M25S3BBW50wByuLo3kn7/laGfanKrtsEvdgiTsNNUkIbJCXyj13SfeFfGQn1iZH5lpgpQnWLpP9irKGiZF6+N3VX9GuvybkcuaX8Ljn3P5hNKcTRaH24ZsvLY3tEQSicRQxy3UcoOI7FnNODw0JjBp4tTq9afvH9Ma7h+trIpErdKuanlUqI311U4XuD2LkET6ZcckuT900SzcxiLURWwFHbu/oJV1ByP10R9ZCX2NEIqep9a+YLx8tpCuo5qkyI1fuD0XPm2O76dI1liocsnJhY4DtXMd6uJFl68JvubyAsTJpxKAMtz5/EsAp87QS0HEfZKctwR5YGhceba8MURxbCMt0tPbKtuKwue
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454dd461-a216-4745-b868-08dd82d2a69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 01:52:20.6149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFRi7xIz/Jqij0K/kE9NJN0Ckg+XG9H2GtpeilfBzritvFcPuas6fR5s1rJjyyNQNXRdORjkkrU/AAiBdTDSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7699

T24gVGh1IEFwciAyNCwgMjAyNSBhdCAxOjUzIEFNIEpTVCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTdGVyYmEgPGRzdGVyYmFAc3VzZS5jb20+DQo+IC0tLQ0K
PiAgZnMvYnRyZnMvaW5vZGUuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lub2RlLmMgYi9mcy9idHJmcy9pbm9kZS5j
DQo+IGluZGV4IGUzYmJlMzQ4YWM5MWUyLi5lMTg5NjdhMTRkNjQxOSAxMDA2NDQNCj4gLS0tIGEv
ZnMvYnRyZnMvaW5vZGUuYw0KPiArKysgYi9mcy9idHJmcy9pbm9kZS5jDQo+IEBAIC0zNzIxLDEw
ICszNzIxLDE0IEBAIGludCBidHJmc19vcnBoYW5fY2xlYW51cChzdHJ1Y3QgYnRyZnNfcm9vdCAq
cm9vdCkNCj4gIH0NCj4gIA0KPiAgLyoNCj4gLSAqIHZlcnkgc2ltcGxlIGNoZWNrIHRvIHBlZWsg
YWhlYWQgaW4gdGhlIGxlYWYgbG9va2luZyBmb3IgeGF0dHJzLiAgSWYgd2UNCj4gLSAqIGRvbid0
IGZpbmQgYW55IHhhdHRycywgd2Uga25vdyB0aGVyZSBjYW4ndCBiZSBhbnkgYWNscy4NCj4gKyAq
IExvb2sgYWhlYWQgaW4gdGhlIGxlYWYgZm9yIHhhdHRycy4gSWYgd2UgZG9uJ3QgZmluZCBhbnkg
dGhlbiB3ZSBrbm93IHRoZXJlDQo+ICsgKiBjYW4gYmUgYW55IEFDTHMuDQoNCmNhbid0IGJlID8N
Cg0KDQo+ICAgKg0KPiAtICogc2xvdCBpcyB0aGUgc2xvdCB0aGUgaW5vZGUgaXMgaW4sIG9iamVj
dGlkIGlzIHRoZSBvYmplY3RpZCBvZiB0aGUgaW5vZGUNCj4gKyAqIEBsZWFmOiAgICAgICB0aGUg
ZWIgbGVhZiB3aGVyZSB0byBzZWFyY2gNCj4gKyAqIEBzbG90OiAgICAgICB0aGUgc2xvdCB0aGUg
aW5vZGUgaXMgaW4NCj4gKyAqIEBvYmplY3RpZDogICB0aGUgb2JqZWN0aWQgb2YgdGhlIGlub2Rl
DQo+ICsgKg0KPiArICogUmV0cnVuIHRydWUgaWYgdGhlcmUgaXMgYSB4YXR0ciwgZmFsc2Ugb3Ro
ZXJ3aXNlLg0KDQpuaXQ6IHR5cG86IFJldHVybg0KQWxzbywgc2hvdWxkIGl0IGJlICJhbiB4YXR0
ciIgPw0KDQo+ICAgKi8NCj4gIHN0YXRpYyBub2lubGluZSBib29sIGFjbHNfYWZ0ZXJfaW5vZGVf
aXRlbShzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqbGVhZiwNCj4gIAkJCQkJICAgaW50IHNsb3QsIHU2
NCBvYmplY3RpZCwNCj4gQEAgLTM3NDgsMTEgKzM3NTIsMTEgQEAgc3RhdGljIG5vaW5saW5lIGJv
b2wgYWNsc19hZnRlcl9pbm9kZV9pdGVtKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmLA0KPiAg
CXdoaWxlIChzbG90IDwgbnJpdGVtcykgew0KPiAgCQlidHJmc19pdGVtX2tleV90b19jcHUobGVh
ZiwgJmZvdW5kX2tleSwgc2xvdCk7DQo+ICANCj4gLQkJLyogd2UgZm91bmQgYSBkaWZmZXJlbnQg
b2JqZWN0aWQsIHRoZXJlIG11c3Qgbm90IGJlIGFjbHMgKi8NCj4gKwkJLyogV2UgZm91bmQgYSBk
aWZmZXJlbnQgb2JqZWN0aWQsIHRoZXJlIG11c3QgYmUgbm8gQUNMcy4gKi8NCj4gIAkJaWYgKGZv
dW5kX2tleS5vYmplY3RpZCAhPSBvYmplY3RpZCkNCj4gIAkJCXJldHVybiBmYWxzZTsNCj4gIA0K
PiAtCQkvKiB3ZSBmb3VuZCBhbiB4YXR0ciwgYXNzdW1lIHdlJ3ZlIGdvdCBhbiBhY2wgKi8NCj4g
KwkJLyogV2UgZm91bmQgYW4geGF0dHIsIGFzc3VtZSB3ZSd2ZSBnb3QgYW4gQUNMLiAqLw0KPiAg
CQlpZiAoZm91bmRfa2V5LnR5cGUgPT0gQlRSRlNfWEFUVFJfSVRFTV9LRVkpIHsNCj4gIAkJCWlm
ICgqZmlyc3RfeGF0dHJfc2xvdCA9PSAtMSkNCj4gIAkJCQkqZmlyc3RfeGF0dHJfc2xvdCA9IHNs
b3Q7DQo+IEBAIC0zNzYyLDggKzM3NjYsOCBAQCBzdGF0aWMgbm9pbmxpbmUgYm9vbCBhY2xzX2Fm
dGVyX2lub2RlX2l0ZW0oc3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWYsDQo+ICAJCX0NCj4gIA0K
PiAgCQkvKg0KPiAtCQkgKiB3ZSBmb3VuZCBhIGtleSBncmVhdGVyIHRoYW4gYW4geGF0dHIga2V5
LCB0aGVyZSBjYW4ndA0KPiAtCQkgKiBiZSBhbnkgYWNscyBsYXRlciBvbg0KPiArCQkgKiBXZSBm
b3VuZCBhIGtleSBncmVhdGVyIHRoYW4gYW4geGF0dHIga2V5LCB0aGVyZSBjYW4ndCBiZSBhbnkN
Cj4gKwkJICogQUNMcyBsYXRlciBvbi4NCj4gIAkJICovDQo+ICAJCWlmIChmb3VuZF9rZXkudHlw
ZSA+IEJUUkZTX1hBVFRSX0lURU1fS0VZKQ0KPiAgCQkJcmV0dXJuIGZhbHNlOw0KPiBAQCAtMzc3
MiwxNyArMzc3NiwyMiBAQCBzdGF0aWMgbm9pbmxpbmUgYm9vbCBhY2xzX2FmdGVyX2lub2RlX2l0
ZW0oc3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWYsDQo+ICAJCXNjYW5uZWQrKzsNCj4gIA0KPiAg
CQkvKg0KPiAtCQkgKiBpdCBnb2VzIGlub2RlLCBpbm9kZSBiYWNrcmVmcywgeGF0dHJzLCBleHRl
bnRzLA0KPiAtCQkgKiBzbyBpZiB0aGVyZSBhcmUgYSB0b24gb2YgaGFyZCBsaW5rcyB0byBhbiBp
bm9kZSB0aGVyZSBjYW4NCj4gLQkJICogYmUgYSBsb3Qgb2YgYmFja3JlZnMuICBEb24ndCB3YXN0
ZSB0aW1lIHNlYXJjaGluZyB0b28gaGFyZCwNCj4gLQkJICogdGhpcyBpcyBqdXN0IGFuIG9wdGlt
aXphdGlvbg0KPiArCQkgKiBUaGUgaXRlbSBvcmRlciBnb2VzIGxpa2U6DQo+ICsJCSAqIC0gaW5v
ZGUNCj4gKwkJICogLSBpbm9kZSBiYWNrcmVmcw0KPiArCQkgKiAtIHhhdHRycw0KPiArCQkgKiAt
IGV4dGVudHMsDQo+ICsJCSAqDQo+ICsJCSAqIHNvIGlmIHRoZXJlIGFyZSBsb3RzIG9mIGhhcmQg
bGlua3MgdG8gYW4gaW5vZGUgdGhlcmUgY2FuIGJlDQo+ICsJCSAqIGEgbG90IG9mIGJhY2tyZWZz
LiAgRG9uJ3Qgd2FzdGUgdGltZSBzZWFyY2hpbmcgdG9vIGhhcmQsDQo+ICsJCSAqIHRoaXMgaXMg
anVzdCBhbiBvcHRpbWl6YXRpb24uDQo+ICAJCSAqLw0KPiAgCQlpZiAoc2Nhbm5lZCA+PSA4KQ0K
PiAgCQkJYnJlYWs7DQo+ICAJfQ0KPiAtCS8qIHdlIGhpdCB0aGUgZW5kIG9mIHRoZSBsZWFmIGJl
Zm9yZSB3ZSBmb3VuZCBhbiB4YXR0ciBvcg0KPiAtCSAqIHNvbWV0aGluZyBsYXJnZXIgdGhhbiBh
biB4YXR0ci4gIFdlIGhhdmUgdG8gYXNzdW1lIHRoZSBpbm9kZQ0KPiAtCSAqIGhhcyBhY2xzDQo+
ICsJLyoNCj4gKwkgKiBXZSBoaXQgdGhlIGVuZCBvZiB0aGUgbGVhZiBiZWZvcmUgd2UgZm91bmQg
YW4geGF0dHIgb3Igc29tZXRoaW5nDQo+ICsJICogbGFyZ2VyIHRoYW4gYW4geGF0dHIuICBXZSBo
YXZlIHRvIGFzc3VtZSB0aGUgaW5vZGUgaGFzIEFDTHMuDQo+ICAJICovDQo+ICAJaWYgKCpmaXJz
dF94YXR0cl9zbG90ID09IC0xKQ0KPiAgCQkqZmlyc3RfeGF0dHJfc2xvdCA9IHNsb3Q7DQo=

