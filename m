Return-Path: <linux-btrfs+bounces-9957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456E9DBACC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 16:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96863B23808
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F51BD03B;
	Thu, 28 Nov 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D//HiHfZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q5JOCSKn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D81B2195
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808580; cv=fail; b=TpgGxVd+AfKlc2HJabegpHW59wHw0R4JPPoQOQ1165qmcBqWs+K6k//WdFiXJLhPvhotOt9aYXnlOnuLHrwTTHbA4yDsTLoeZyqeJyAdL8W4kOD2+w8AmC5VLBbDFIECC3C2BbdYk8e2Lr31vc2apCeKymOaiJA5oRNODL+P7pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808580; c=relaxed/simple;
	bh=FShidHw9yrj8rHtUPCNM8yafOv2hZJN8762thvwcd2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6NPM2P58ggVgIhJj2qLrYdNWn3i+EPFlCBA8BBx5E+Z+Bavas2KWXj8E2IUQmceAH1BRq+DoZX43L3vNQrMAlID4UF98YTAa1vgGqYr4rfE3Y5gYh/3QQ5CRASQPYnsNwCQXiXTvZp2juuwaFZqTPN74PAtRckaHlZZo2pIRio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D//HiHfZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q5JOCSKn; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732808578; x=1764344578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FShidHw9yrj8rHtUPCNM8yafOv2hZJN8762thvwcd2Y=;
  b=D//HiHfZqji0WzWvdmXdYO1qWKZZaB55uDKQXiTzjuvH4kZ8ObTnqt7x
   n5jbAwuIgsBGe8ug6RZoYjh9lVOj5PxpaKp9UszX/Dx2ZC3JKgTn5ZTtq
   9ndUfG+b+OYNBUI+JYD5A5hGJO+XphDN/4EtO+0vpglU54Qnrh0W9iiZB
   xXK6VzFMNlX3I89NkQxGaQyNNQQXxEy/KNZIcajYiuAQ1Nf/v8o74jSzz
   QsXj6yjX0tm8mje3imzgMxQKNeEaAQIpBNeMOFnGqM1yIZ9SqH5gJcc0V
   faRwNjNrflxpS1j6dzzcpsqVk/MkGgURVW1VXU3izJRq2EoHa7Nn7r6S1
   A==;
X-CSE-ConnectionGUID: g9pas7AoSKSAgbftoR3ZVQ==
X-CSE-MsgGUID: qqgur6nKQQCJh+aZH2eL6Q==
X-IronPort-AV: E=Sophos;i="6.12,192,1728921600"; 
   d="scan'208";a="33125547"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2024 23:42:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkPwvUh3ra33coGuAxkYGo5GFnLi7b1slecEYnFDylV0tdXzk5A0HUhmHK8dPCBtWU6STk23Y9hndq89j32vrcOxE3ZfVmBnnayWOdEwy4QNcg3jbd0qBFqtZwCdfrPsAtiY7XLj+Fp3/80ppdksofBR5DVbMcnjgMvAkDwApdZg2gX2C+PGCnwvnySruq2HLeMeQGw4euJixItaivilvZmhHSXHRD1MsS91c2TLyvOLzlhWxTdbEtNIa/ewXEW0qap8xLHFzn0Cz92MIkgCorBiTEg66RKAV7sQpp3Ny61A8myvHwEwS6cUs0gk/q6BynHueC107yRkNMLG3vLHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FShidHw9yrj8rHtUPCNM8yafOv2hZJN8762thvwcd2Y=;
 b=KUTmYIKj3NVE9an266vDtohNLVikHGR09rxxFwMUEi6uTFkfKa0yP0p1cbs5U59PTzFWAuug8gdf7r0PykFL3PiKIJl/1OtCyP16bU8vP0xNBI1Jlu+Y2dZdfRyJEA7OwW6BHY17dlzgnAqDVMGPVB5uP1GNIyalkKhJScX9x0LElxhQYDSg3thzaghnxhR5kPNsUvYcVcPvkyouPdnrACafrMNnAW+O93WL7Zjf4hR9xQgf3McxLaTlEjgstQX/8wAhOqcSvaGWRtu3JcXJ/ypnruKK5GzYM7vTEA3D+QkECyzeeIZmDMz282dAvatFK8gGK6JwtLjLCmD4ovhfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FShidHw9yrj8rHtUPCNM8yafOv2hZJN8762thvwcd2Y=;
 b=Q5JOCSKnNrKQLH868eSu6HpgkrMrUWdM1YCr8F0px1FBDh5oRyjRlxG80zfeqfShgdyZxfBXtSYC/bHcciGz7Bncthj9sJF8r4eg5EWgC6pEwdgNlubCvAN4te1pi5jnuFJ5ac69r5IY8E9wG1/WgkP4PshMLBjZ5HpQ/Z76RFA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH7PR04MB8636.namprd04.prod.outlook.com (2603:10b6:510:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 15:42:49 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 15:42:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: don't BUG_ON() in btrfs_drop_extents()
Thread-Topic: [PATCH] btrfs: don't BUG_ON() in btrfs_drop_extents()
Thread-Index: AQHbQXjUOnq2ONP8j0yaRo6PcfAKXLLMoboAgAAzrgA=
Date: Thu, 28 Nov 2024 15:42:49 +0000
Message-ID: <24726df5-cacf-4275-8b33-41017baf7e76@wdc.com>
References: <20241128093428.21485-1-jth@kernel.org>
 <CAL3q7H5gy1wd-07a8rGdo2=AYHioPO1FXp3CD-5yBYDzSwL6DA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5gy1wd-07a8rGdo2=AYHioPO1FXp3CD-5yBYDzSwL6DA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH7PR04MB8636:EE_
x-ms-office365-filtering-correlation-id: 93365e11-56e3-4a4a-7fc2-08dd0fc3501d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTVxZW5yRmswcEQweUpvRjhPTkZNR1hiMmJjdFZRN2VuQXo4Nzk0K0FPVksv?=
 =?utf-8?B?VFkzdDd2SE5CUkdNYU1KWDhJWmlJTDEvQTNNM285Tno2QXdiVVlQaFVISURx?=
 =?utf-8?B?N3B2UW1Ic0ovWnNxV0pMcW1ZODZtbEJ6c2xYNWpVaFFmdEVINHU5RjNiTU52?=
 =?utf-8?B?SlQ4NzArUTZwcUloN3JGNVkzc2JGOHRxZkRhM1M1aW5nTmFDNVNiaWp4M2gv?=
 =?utf-8?B?UkZUSWF3K3Y5UGZ3dmFWd0pHZmt2UXF0ajhXNEVSeExCci9PSEM0aDNuaTdZ?=
 =?utf-8?B?cFVhUkh5RUw0RkRJY3NXMkVQQnhnYkhpdFh5RXRJSU1KNkxFc1J3NVNXWmJB?=
 =?utf-8?B?b0JuRzRZalZtVFFEdjBPbU5uWU1MM1dnN3o0U3k2QzJQejJyRGJRV0Fqa2Jj?=
 =?utf-8?B?VFlGLzBCcEpRbllwaWwvT1ErT1ExZjNDS0RjVDZTbUJJSDdXVldSVkNRV2Nq?=
 =?utf-8?B?bmVJL1JBOVlkUVNya2RwejljRTJsWTRrRWQva2ZIZjVwbitXT3NQTFRsK29m?=
 =?utf-8?B?RGJEV0pSK3c0MXpBaUZsSjg4V1pVNHNZa1A4QXg3WWhVZGk4cTFUWW9jc3VP?=
 =?utf-8?B?WnpvRlhuaE1pSHZZOEY0ZzRHOVVFejVXUWhuRHhneGZDUXNSdzQvZCt1WTQ4?=
 =?utf-8?B?QXdydmJwdnJlaUpWbDVrTUFveWoxdFlRb0UxZ0lJZFF4YnNkQnR5NkM2cHl0?=
 =?utf-8?B?S0ozNVd0RWdUKzdYZks1VERBTjBnK3E2Y1FveDNvOFVqSUlUM1RYOUsyYW1Y?=
 =?utf-8?B?cXdZcjhyWkxyUEZQa3lEV0pZV0hBTVdmeUhrWnpqOXJFcE1xNUFHYlBJQURH?=
 =?utf-8?B?MU5PMlFwcnNtR1FiNFZZUVhOU3YwLzdFcUE5dWZPNUtERk45U0Q1ZFloa2lt?=
 =?utf-8?B?NUpRQTV2bnpQVDhrVUlCQy83alhvNmVzNGVNZjViVk1ZTVpIbEx5Nk92b1B5?=
 =?utf-8?B?UjFUaTBKQnhaQzd4Mk9vYmVrZlp0M1QrNlQ5QzdVNHFzeW5BOVNJTlF0UTBY?=
 =?utf-8?B?TnZGc0J4dmpyTW1ZQTVkZEdubWJmMVdmWGMxS3V0ejVUOHJKV3lIZlozNW9i?=
 =?utf-8?B?ekRjQnRmQTE2am9OTzFOQzBseksxTDU1bGE0cXV5S0lGUDdtdDQ0WTdNd2U3?=
 =?utf-8?B?eWhxdjEweFJKVUVjRVpWZTFZN09UVnJrcENxQ3E0bklJN1M1U1R2TTdsMHM1?=
 =?utf-8?B?WWFaOWxsZ2IyMnAvcFhRcXREVXQxMDM0SVE0eUxlTSt1MUg5Nk9wLzd1TzhS?=
 =?utf-8?B?SWlyNkpuT3JYVGNEUkFaeUovNTgvYXBYZDRQaDBHZnRsNE1XdnhzSzl5QzJI?=
 =?utf-8?B?TEZ0bGRaTFVQNzdKL1FRNlgvRmJZSlkydzEzdTBVM2U2aDYrY3RyTm5FWTFY?=
 =?utf-8?B?c2IvQVMvcVl6RU9LaGNRSUdTUEJiY1VOTHk2Si9Ncm9QRkd0Qmh3SDk2RU5Z?=
 =?utf-8?B?SFlDZWczSmc1L1dyMzhNdHkxamlwTHBWSWFyeTQ3ajl6Y2x2S0l5Wkw3V0N1?=
 =?utf-8?B?VTVrZzNwR1AySWJQdExQcnNCYUNaSXZEbXZ4eDFXQldGMDVlRmFvaC9xRy9P?=
 =?utf-8?B?NGJKNWtkOFg2Z2IrZndkY1JOYWk5cUN0dlN1Zm1zcXZ3NCs4dHBGUzNwTTRa?=
 =?utf-8?B?Zlc2bzdRNkhOTFFqbk5vZlZxc3cwajRpMzZsSnc2aEMrZTVGRGpoUmJGMjM3?=
 =?utf-8?B?bEZyUysraWdtdFBGQnJZemlvMkpqa3BBWGVLU3ZPY2kzMFRzM2NpWlZ2Qm1y?=
 =?utf-8?B?dkxyQStHdFlhQkhDS28xdDVGVjRFeHdSOGZhakhSUGxLMjNxamdaUFhxT3FU?=
 =?utf-8?B?RzdVSEltM1FWTVFQNmEvbkRuR0JqQ0JNZitxN1lVWktKL0xCak1wLzdEZUZp?=
 =?utf-8?B?Tzc0bUpBR3owVVJHTTNWVWd4d3p5dVM1d2VrL1FHenM2cEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2hKeit1ak1CM2FRcTlaSW5rdUd4ZkNSaVhjcmNZQ2NKRDJXVzVqTFg0QXBB?=
 =?utf-8?B?enN1VmtrZkprbTJPdGtSMk42NVlNaXZXYVRhVHk4SG4vMUlHcEZpZmZRLzZP?=
 =?utf-8?B?NGpWeGJObTZFMXo0N1lub1BZSUQ3TytQc3IvU1JrOXpZTjUxZS9UbFVNTGxw?=
 =?utf-8?B?YmIzTEN1OEt1ajRCbjBVVkl3T3RLWEpIYzBqcFFDYm94d3lxSURZeE9jbXJ0?=
 =?utf-8?B?cS9PdUdLZFphTXRkczVSRE95a3U0WHZXWExOYnYvSjl2eXEyQzloNUNUMWVU?=
 =?utf-8?B?Nnk2KzFncGIrU3praUVpMEtjTHVFNkhNSlY0eUtwMTlPeXdYS0JtbjhjUUZK?=
 =?utf-8?B?aUl3MElWQnMvR0g1alZKbHRtYms1TWJPVmY0bVpSb2dDcnE5Mkw4OUdtNjl5?=
 =?utf-8?B?R0kwdXJOUXkxTTRTdHBUQVMzb2tEMXVrYkxQYThSNWVYdi9ZenRLOUIyaHJF?=
 =?utf-8?B?dllDOVBGWnRTbnFXSVJKYi8zaWZqKzlLMzlCUlhObldDeDhLYVRvK3BwOWFa?=
 =?utf-8?B?eHRzdThPazVVTlo2alJKTXZndFNZVk5Jd1R5REdvMzFXQk10NGwvWlRqMkts?=
 =?utf-8?B?c3lWNjFubjVVbXJNcUxQQko5TFppcUhFNExhOWMyMzh6L2s5TVRzTnMrNU5M?=
 =?utf-8?B?eDJEanJrN1l6QURLNkNZeU4wbnhIMFlxdlRwZnFzMVBqWTB4d21XemZuY1Nt?=
 =?utf-8?B?cGtsTmJXeGN1R2ZTOFo4VHI0Rm1ad21SdXZjc2Q1TU9NeU9VVVg5enVqUmZ5?=
 =?utf-8?B?d0Q1RXFYc2FuQkZmRWxacU9wQnR6NkNJSWQ3R2VpUSt6UklUQm92eEExeE1k?=
 =?utf-8?B?aUc1N0VrcE1sUUd0aEFFK3huNlhaUHJlQ2UzNHR4Znh6d1h5WHRxUkZZTklX?=
 =?utf-8?B?NkwyaGlTdzlSSDhGejhQYjFpN05Qd3QwaDlVQUpYL1hnVEZXRTZPTnFmZ1hR?=
 =?utf-8?B?Wm8vdDcyVTFIRWFPb09LNURGa1hXU3FGNE1rdDVmZmJ4cVJnY2JlZjc3UDdQ?=
 =?utf-8?B?UFZCYzg0dVFLS25QUjZqbWFibzFncXBwMVBlREQzb0tseEpRMElwSUNoQUcv?=
 =?utf-8?B?N2tRckM4dzVEUlRMeDVwV2dHY1drTUJjbm5ZaVhtVkgrSlcwZ2JubTdVYlpo?=
 =?utf-8?B?M0pGMUdVdWRxOTQ1OE5KUnhiOE8vaTJSZ3NLaUNyVUJLcTBTZHlPTUpnelFS?=
 =?utf-8?B?dmhqV2MvTnpIeEQ0SUlRUTU1RFgvZVNJc0RWTmxJK2hFeGptdEtPS3BWK2Z5?=
 =?utf-8?B?TlhmeDNrRWIrWWtUQ0ljWkFkSWJHb1RQd3FNSU5tc2trU0dLeVFKZGhlTURR?=
 =?utf-8?B?K0RUL0FNY2Nja0ZxcnNrUDF2dUp0VjRneGkrVEd0eCtrMWluZTFINjl3aHVh?=
 =?utf-8?B?RWVhbUNLTHYyRndHRDByODhDcmM0S2FvV1hEMlU0S2sxREQ4OSt2WUpwNEtz?=
 =?utf-8?B?eHBwT2lCTVN5cXZDZkliRVpoMGxnVm9SbmR3bVQ5dmJWUFhiU040c3hsSWpZ?=
 =?utf-8?B?ZG4xQUY4OE9pYUJkSzdZVWpUUHQyZlFodGFqaG4yZG81QktuU3VzQzhyR0l1?=
 =?utf-8?B?cElLQ2pGcWNZZW5MV0JQRjRRb2JLMEoyS0c0Vm9PRzhLNS9GUGdNMUplV0tZ?=
 =?utf-8?B?WmdXaHB0UXVpVFJnMk42T3FrNWttYzhlTDl1YWxUbWpQbEhiK3kwUFV5ODIw?=
 =?utf-8?B?MU9OZkJoY2pEeTduaElKcHdHNFVjL2E3MVZiUFpyODY1WVNKZ1JTM3lMN2JP?=
 =?utf-8?B?cmk2Q05qeGZJa0NsNEErRDM0ZENoWFV0c1ljdlowTUp6Y2h4TVVyT3IxbEhM?=
 =?utf-8?B?V2Y3a2tZVGRVdys4WlNTRW96Ym9jVFZMZFh6ZFgxWWFpVXhRUmxqUWJ4MEhR?=
 =?utf-8?B?dkYyWmlNT3NPY2g2QWZQRlUyVEVzMlkvVjdNOW9uRTRma1lGcW5qcVRHeXNp?=
 =?utf-8?B?ODVkMSs3RzhWNU12L3hlMEo2ODc1Yk5FMzdLN1hTOU1HS2J1cFI0UzNJQkpp?=
 =?utf-8?B?M05JY05GcUR1Umc0UXU5czRHTzl1YXNnZlBvbVdCVjBiRWF0Rk9aOTB2YmIv?=
 =?utf-8?B?Tk9HSGh3STNyYmN4MjRheFZ0cTlkVThXNVE4NnM1M1BTY2twOGtTY25yU1FB?=
 =?utf-8?B?YWtiNFA0dm1raFFFMGgxajhtL1dPVFp3MUZBWExFTWlZSTJkaC9aMU5yYzJV?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8D1C0A112D2B347AD4BA72938749976@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/Lg0zYh5wufW9RP5Hl2e0X5ij1c8DvsW6wX7E+UKXv4ivO6NPdNA7QtazW8NvT8/UBYfZyHeGSzbWeqBpCbDdM0usWcsB/d4bHNUMnt/T0mfTBeEidaTBuKu86f9iXhFp4XOxNBYxE9fiQEu8EPoiWqBCYpQ1N2GHI2uv0N9F0YuH0dqiFJfBGgETMrVHdZXRIxg0rqQrovsXkC/xfLPqS++15bvOHXyAf4zJNdH4gFrDhnQdvTlHYHYc9wXfupYqkWHs6vDHlzvJJQwhuSxlJcF+Tq5SAnhpZqn5koJwRdZEU142qczkrYaQLLw2Ml81UBr0oPLZbBF4dChYxh1hPQJtwPvlYPRnPJCjXJZ15sAQUelG2kK53TjvGZwllodfHmlmIV53UJ7XhNVjxfaNfkXvEiqSAhC7TJYYtqhknfd5MrUAeaHSjTNyjuDTQUKxN+Eb8Yy6Af0PqaOjW+MGX+xhl1V53GRzAcvgz7p5sV4oXBzadaJGuKE7T+Pr+BveUlYBgiEy81UDo89VJHe2lRCVxwOjLB2prBZXoXUKBtc+bFZlI8RWUvrNY8qvtXXrdh1sejpdWDcpol0Vr6sE7lmyU2UnkEzJSpPpHz/5grqEbqP1E1PeRPPmJC+8EIC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93365e11-56e3-4a4a-7fc2-08dd0fc3501d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 15:42:49.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSiueogZLKav3hoXPCsv2pB0oc7Gm4vOYC7dtbDXwiCvdwLzyq5RlzQipPczDYm8NYonlhdyDFJpIgmj00l35FgaMLGc3As79Bep+vuf5fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8636

T24gMjguMTEuMjQgMTM6MzgsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFRodSwgTm92IDI4
LCAyMDI0IGF0IDk6MzTigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IGJ0cmZzX2Ryb3BfZXh0ZW50cygpIGNhbGxzIEJVR19PTigpIGlu
IGNhc2UgdGhlIGNvdW50ZXIgb2YgdG8gYmUgZGVsZXRlZA0KPj4gZXh0ZW50cyBpcyBncmVhdGVy
IHRoYW4gMCBpbiB0d28gY29kZSBwYXRocy4gQnV0IGJvdGggb2YgdGhlc2UgY29kZSBwYXRocw0K
Pj4gY2FuIGhhbmRsZSBlcnJvcnMsIHNvIHRoZXJlJ3Mgbm8gbmVlZCB0byBjcmFzaCB0aGUga2Vy
bmVsLCBidXQgZ3JhY2VmdWxseQ0KPj4gYmFpbCBvdXQuDQo+Pg0KPj4gRm9yIGRldmVsb3BlciBi
dWlsZHMgd2l0aCBDT05GSUdfQlRSRlNfQVNTRVJUIHR1cm5lZCBvbiwgQVNTRVJUKCkgdGhhdA0K
Pj4gdGhpcyBjb25kaXRvbiBpcyBuZXZlciBtZXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IC0tLQ0KPj4g
ICBmcy9idHJmcy9maWxlLmMgfCAxMiArKysrKysrKysrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2ZpbGUuYyBiL2ZzL2J0cmZzL2ZpbGUuYw0KPj4gaW5kZXggZmJiNzUzMzAwMDcxLi4z
M2YwZGUxMGRmNWIgMTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9maWxlLmMNCj4+ICsrKyBiL2Zz
L2J0cmZzL2ZpbGUuYw0KPj4gQEAgLTI0NSw3ICsyNDUsMTEgQEAgaW50IGJ0cmZzX2Ryb3BfZXh0
ZW50cyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICAgbmV4dF9zbG90Og0K
Pj4gICAgICAgICAgICAgICAgICBsZWFmID0gcGF0aC0+bm9kZXNbMF07DQo+PiAgICAgICAgICAg
ICAgICAgIGlmIChwYXRoLT5zbG90c1swXSA+PSBidHJmc19oZWFkZXJfbnJpdGVtcyhsZWFmKSkg
ew0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgQlVHX09OKGRlbF9uciA+IDApOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgQVNTRVJUKGRlbF9uciA9PSAwKTsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChkZWxfbnIgPiAwKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IGJ0cmZzX25leHRfbGVhZihyb290LCBwYXRoKTsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPj4gQEAgLTMyMSw3ICszMjUsMTEgQEAgaW50IGJ0cmZzX2Ry
b3BfZXh0ZW50cyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywNCj4+ICAgICAgICAg
ICAgICAgICAgICogIHwgLS0tLS0tLS0gZXh0ZW50IC0tLS0tLS0tIHwNCj4+ICAgICAgICAgICAg
ICAgICAgICovDQo+PiAgICAgICAgICAgICAgICAgIGlmIChhcmdzLT5zdGFydCA+IGtleS5vZmZz
ZXQgJiYgYXJncy0+ZW5kIDwgZXh0ZW50X2VuZCkgew0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgQlVHX09OKGRlbF9uciA+IDApOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgQVNTRVJU
KGRlbF9uciA9PSAwKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChkZWxfbnIgPiAw
KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KPiANCj4gV2h5IG9ubHkgdGhlc2UgMiBCVUdfT04oKSdzPw0KPiANCj4g
VGhlcmUncyBhbm90aGVyIEJVR19PTihkZWxfbnIgPiAwKSBiZWxvdy4NCj4gDQo+IFRoZXJlJ3Mg
YWxzbyBhIHNpbWlsYXIgb25lIGZ1cnRoZXIgYmVsb3c6DQo+IA0KPiBCVUdfT04oZGVsX3Nsb3Qg
KyBkZWxfbnIgIT0gcGF0aC0+c2xvdHNbMF0pOw0KDQpQbGFpbiBvdmVyc2lnaHQuIEkganVzdCBj
YW1lIGFjcm9zcyB0aGlzIGJlY2FzdXNlIEkgbmVlZGVkIGFuIGV4YW1wbGUgDQpmb3IgYSBzaW1p
bGFyICJwdW5jaCBob2xlIiBwcm9ibGVtYXRpYyBpbiBSU1QuDQoNCj4gQWxzbywgSSdkIHJhdGhl
ciBoYXZlIGEgV0FSTl9PTigpIGluIHRoZSBpZiBzdGF0ZW1lbnRzLCBzbyB0aGF0IGluDQo+IGNh
c2UgYXNzZXJ0aW9ucyBhcmUgZGlzYWJsZWQgKGFuZCB0aGV5IGFyZSBkaXNhYmxlZCBvbiBzb21l
IGRpc3Ryb3MgYnkNCj4gZGVmYXVsdCksDQo+IHdlIGdldCBiZXR0ZXIgY2hhbmNlcyBvZiB0aGUg
aXNzdWUgZ2V0dGluZyBub3RpY2VkIGFuZCByZXBvcnRlZCBieSB1c2Vycy4NCg0KU3VyZSBJJ2xs
IGNoYW5nZSBpdCBhbmQgYWxzbyBpbmNsdWRlIHRoZSBvdGhlciBCVUdfT04oKXMuDQoNCg0KPiBU
aGFua3MuDQo+IA0KPiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXh0ZW50X3R5
cGUgPT0gQlRSRlNfRklMRV9FWFRFTlRfSU5MSU5FKSB7DQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSAtRU9QTk9UU1VQUDsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPj4gLS0NCj4+IDIuNDcuMA0KPj4NCj4+DQo+IA0KDQo=

