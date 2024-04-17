Return-Path: <linux-btrfs+bounces-4380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C08A88CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 18:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59701F23001
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AC14884C;
	Wed, 17 Apr 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rrw4grao";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zMO671zc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FB147C9E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371063; cv=fail; b=PV9F49Jc/Fhcj2j5yDNHTlZJsta8U7TM7DKyT44/SIe5WlQEhvwewTxJPPg5ugpyWE95JQBFrUYCmWKs7ME/O9gsam6KugZpx/HCCXZC0CQmorSR1bXmDDXTbHVtL77j/rUnh0cuoQBvPcdN3K32//NNte9N8qWlWdk7sFJtxns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371063; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gY1+pgD7/LoxuhuJO8rrAUeRt8Y5LbSxZ2mPV5eAi2FvKDF3Rx3hcsNw3QC/nXBGhZ8WN7LTqxwtxlDveW7ByYGXVK+xQESkzPe8ZKud7NL3pcjL0MDjOxua0xM2OXG/iN6mDPE9TW2jAMex0TalnUnU/0bHpVIMjq1daFP4RCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Rrw4grao; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zMO671zc; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713371061; x=1744907061;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Rrw4graoVuCIQ8ZivYimfSgFnOwwfw+eg1TK8/F5hvH6SulN8QXpNPyl
   I9vV99xJeF+XV5yPbYzM8Db9VjSZqbfi6LfXua3J2kwWJ+HOjQO68dpIu
   Dg+noO4a52Tb3oWxB26qHQiT9yUrE4y5J+91EQ76XxWF6ulFmOyHF5XD0
   Gk4Y7Ojg91LIA69vwxCr0A0Yj6hYkCmwbFPaIMYPMfsgXtSr+Q+IKw9x1
   t2BtdNTZNqdr+djG1mWta1JWU7AawjRjE3n9Kl3wJFaw+1aKTBPOyZFvn
   b6NSpSrKzBMW9PlPy3AsHyLmMURdIr5JypP0QV6TmJdqPfPPmn/8aJ72E
   w==;
X-CSE-ConnectionGUID: iO0s78y8T0ePgpNECQ5rAQ==
X-CSE-MsgGUID: bHUc9qqPThOKkDIL8/IPkQ==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14938912"
Received: from mail-westusazlp17011008.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.8])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 00:24:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3DFd+UIKJFK4memQmaagiGtos0eF/96z8LW8SFBI2DpsFoPeJKwq9uAyGzyIlWwPFwesEHNZCJL4NGDDhwAqkQ6WZLYvuepysCNfYjUoeeZ0J+VtwcjOq+gCpJTHM0dSo3hjWL3mV0tD2NtEOjbd0+7LVfGyyrGk53/oUuBGpIx9Yo382GKseVL3Nlxz6z9Ae9upeJjy644PoyPhBP3CpI0KSFCQNkQjyr8cPxJKxa/re30zPkCpJ+fVv2u94hGMZcN3o+v/ovEweUboCzOCmOazhiA6MWFbEJyL5RUEEGTpbRPTRzsyjR/z8mV/WO5i3FAbqCKg+ClVl9vpqpb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OXCvQRsHC13QzuQhknGYMP9JoZUohetBMbnMrWnGlQhaNDpWKqKBIeTYMg5oVNbe9eSaQhYI7Tk2NjLJm4UWlkmHGOy0JkUrrmgpe9jk0omKQy7kkrqCqxOk8wY6gubXiPdxIuLorpdsQqqmp0TuZE+LF3hJL1mmuUQQfsECuIIjrrfvz9IZyDzAMS5vw3GMuqrM8qpaZe5MDpCK5SeeJsduWhLxnL+ZsCNlwysXFeg6P6z6mYp31NHLK0RUXddEKxTSHtpzY9drZ88AyooecmtR5f6gzv62+Knx8N36OOjG/7PyXYPBXHzn5HByCfi8RI0jKiKcMSsXZLMDkCWC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=zMO671zcG9DqyDLP/gUFXyA1c8LljW5EKx2DCK7ZpLKNvj3Tls2mgEXLR252YrxBEp3oGc08sD4SExvetjnDyrTVeypL3hwO1++qs1AXpOy7Zj+cIUX25YoNASQvQodX/5GfqOpOLUXD7wudetEp7vHdDxRwHkkne6HvXizzZ58=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8418.namprd04.prod.outlook.com (2603:10b6:510:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 16:24:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:24:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/17] btrfs: move extent bit and page cleanup into
 cow_file_range_inline
Thread-Topic: [PATCH 04/17] btrfs: move extent bit and page cleanup into
 cow_file_range_inline
Thread-Index: AQHakNSuGJDj0DmMpUu4xQVpR3FTFrFspboA
Date: Wed, 17 Apr 2024 16:24:18 +0000
Message-ID: <391e2380-db7e-43bc-8d7a-d935ad7c929a@wdc.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <2d2d537ce3d1843f344ebb88d55f6e830c7fdb28.1713363472.git.josef@toxicpanda.com>
In-Reply-To:
 <2d2d537ce3d1843f344ebb88d55f6e830c7fdb28.1713363472.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8418:EE_
x-ms-office365-filtering-correlation-id: 0e12c771-93a8-42e1-aae9-08dc5efad503
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uO7O1WsMygrvtFsAgKO3+9JqNTw8hWBOM0lurGggOCPVRe0MAWB2rvEBhykUVZUUGOopinmTm7rHFPXTf8Q80ZMC0o3JAZQHfbtlVVEL3N8dXu3wXdZ8vRoN96EV8WT66v6ZRGr8g2o8UJN9+XMH1dCyutKeozzWC4NwZ9F3svXE4QaOcbb9TO9kQIAK6jGUR7cVk4qqqQiQ62vX471rOTxbcFJB9bayMThdhXmoZGgYyfMOwW3GJK6yz9BWSbwGkvJUcoALIOier+5bpUId6VJJnH/NqlmmUBjww5iuEz2IloNzGAqrgep3ESug2IsmD6yD3WXK5PI280/akVYQUQzpnUl/ICc2wj145UN8xBHXn8Fb74xO+518bGL9tK5nfXljcw9WxGYLrbo12riCjG/946RludERZWf4Z7kMMwVW0Zm4UIxIlntL4JlTcf8iPGZpkaSaVUqobb0XTKfuoAxqe3CqQMlpTAyjZ+EAtIr3MywlWtq1aJ3lmb+vqbu/6sjzNbVWRjr3YxPShiXwjaSQfMGZ5s8TrVVA8a3qjAYv30M7i4nnZJQAq6wgGQh2yx2aiIPRgANrTTeICWj2Wl1+ZpCTtsvHx6+552+ZSNBV7mIiIJGRCUNS+JxsRszFh19GEjaNClhtaE5Y1ZIc0gHRW49m5TBZ6OVEBTIrw4vJZTMBQLvaYReu8rNPhefJDv6HuT3LI4FE+d8Z8OkAymTJBjjTQ11PTv229LSbgqk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWJyTEFnMlcyRTVQVkM4UWhudlk0SG9hWlVPVXhjWTBYTzVxeEZxMTg3ZDNQ?=
 =?utf-8?B?RWdYOEY3RzRERjdleTg5cEZ1NG1obmo4OTVzNmRMemxaYTFFWm9oeWVUaFpD?=
 =?utf-8?B?WDczNWRQblp4OC96bzlhNjhMNFNQZ2tNUThiWmsrNDJJaEpmNUgvM1JKcUJV?=
 =?utf-8?B?Zk42OEdqcjFKZklOK1VzREhmdzRQR2pwS2xGdVdsNzZBQ3NvVE0veUk4UVV0?=
 =?utf-8?B?N1pyY1pITHJseE5DYkZjQWdZTnJ4a0xpRmkwRlJJNWVXNEV4WnUrUnRXOHBa?=
 =?utf-8?B?aUI3ZmIyc0dpdWUzblAwYktsVExsaXR3QlF2bzVqZmo1SGhUeHJLckRXZG9D?=
 =?utf-8?B?aU9kK3IrL3ZsUGtsOVVRZGlwSUZnR1kxNG1TOXhBYnFzYUhiK281dlFjcmpk?=
 =?utf-8?B?a3NUeTFiSHdjQnlGUjVVMTFpb0ZGVFNVRU9Td1VjVy9sT05rMlh5ZnR3RHls?=
 =?utf-8?B?ZWxNZkdPZ0pqb2RBZWdRdXJLQ3BxRytxaHNVOGF0WmE0eG85V3R0dlBWcTk1?=
 =?utf-8?B?eVZFMUhzeHErQXZJVHFXNnRVWnRVWGx0VEw4MitHQ2pZWTJyTkp1N2szYnVo?=
 =?utf-8?B?SWRsSWpOZU1mdDVreG5qMWNETEhUcWN0dExWVHpWdm43ZlJlNWNVUVlkK0dr?=
 =?utf-8?B?WlpTWXNURVFVVHBWNHBKTGdtOU9YZHBUUFpUVytqVUZPTlhpN1dva3JVZUMx?=
 =?utf-8?B?eCtVVENuT3Q5bnFtblJyYXJiU291Y2NVMVhuMThYSHkrVTVRQkRvN0lUQkdz?=
 =?utf-8?B?RHBITWlreTFBV0M5TE5PUzlQbnRMRGJ6WnB5d003NmM3TGlqcG52QllkeURI?=
 =?utf-8?B?L0w0cFdPMHMzK0cxN3puRDI4Slk4STNlT2xFb2ZzZ0gwcUNrdm0yS2F4OTBI?=
 =?utf-8?B?WkRZTGpNT1o5bGt2cUVkQWNCQUJJeGhMUWNDNm1HcVBpb1c0cEwxMjBINUdM?=
 =?utf-8?B?bmdHcFoxVzBOdXcySlBvSXJCSmkzTG5HcWJNSmtnY2VHbDh0WDJyTkJjUnAy?=
 =?utf-8?B?Ym82TFFoM1Z3U1E2Nkk5N295OC9WYjloYWRKNU56cjN4RjhNMkRFaXFOZ2pI?=
 =?utf-8?B?WUFOQ1p4MU5rekYrNUN5T2dUNmpibEpSdkR2RzdUb1Jtc3ZzbzA5ckdKc3kx?=
 =?utf-8?B?RmtVQjk4YWwyYWRkMVpQNFNxZXg4UnA0bUJaQy8wVHo4N1lpNEUwcW51Sm5T?=
 =?utf-8?B?azFoRGhEaU55TWJ3MCtIZHllZVdmSjBVSVV3NFlSTGg4WUlvdVZzTDVjRm9X?=
 =?utf-8?B?eFcxWnFYbDA1U0RTbWNlZGl4ajRMdlM2bHFLRXM3Yk9oWXhkajg1OEZiLzcz?=
 =?utf-8?B?bXZIMThkemY4dXowZHB2bFVKcGo3L1ltcGN2Ym12allreUhPTFduODNya3dY?=
 =?utf-8?B?bExqNlZNc2lUbjRESGVuQ0psMFFkRjBoa1BudnEzS0NRUXBxbE1uekdpc2Z3?=
 =?utf-8?B?VmYwR2NwaVkvdzNLNGtMQ0NocUkxNlkzd0pFclBjOGJnamthNWhhV0h0d0h3?=
 =?utf-8?B?QSs0NmNvSnFBUjdVQk1vQldTZFJWT0xzT2huMWEwTzMvV0ZDSXdBV1piTGx0?=
 =?utf-8?B?dFlDT0hwZzRsZTkwNGlGRmZiTnlkQTBxZWRMV3pmdzI4K01YNlNUSlFYMXF5?=
 =?utf-8?B?UFB2L3ExQ0wvOFprOUQ5U1Z3ZGxzNXVhSVlOOGxSTVAraTMvN255MHJBeG9r?=
 =?utf-8?B?RTRheUtUbnpPd2FVSW5ZMmxpWm5kWjc0cUJvY29yOFZQMkRFVGpWcUdKMzlz?=
 =?utf-8?B?RHdKSHdUU09NcitaQ3BkejQ3dEhNaFAwSUV5NXAvbE4wbXQ4Ui80dGZ4UXow?=
 =?utf-8?B?NWcxKytlMldPMHorQWxmVlNBRTZVUXR1OTVOUWlKdlRhNEdNT2lyWWh2bEx6?=
 =?utf-8?B?QlJOZVp5cno3SjhiMFBYMEZvTnZZMEd1NHFaOG5Dd1EyaTUyanB1L21WRmJ5?=
 =?utf-8?B?UmdWMThZQWQxQm9JbDN0V1p1TFNDT2g4WENyRVdic3dETEl3MXRBdzY3UDla?=
 =?utf-8?B?NnpQR3lsZkx3K1dBRnY4THMybUZwd0Y3ZE5WYnltNnJ5MkdqQys3VlIwVXpj?=
 =?utf-8?B?bm1PRmIwNDhORUJvWnRWSm1qeERrYVNDM200SnUrVDZ6dnhNVGs2cSswaS8w?=
 =?utf-8?B?TGI0T1BMTkk0RENtbHlqWWoxd2RweFJGSy9vR3BhVC94R29FQms1NkY2YWlZ?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9277AF28CCF4C34FAF87BD5CF37A8989@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wCif2xT/e/EKFBiOlyAjklsZPfPhdkpN4QnsC1OVLXHdTEz4v4pDRFbgF3GyknWtOE3j9gW8odqNq/+tzAXMhmXiUTq0cqqKfdXcX1I3wCF5Nl6NITH5q+YBuczE5lPSR0MKMu8G+JXpOGkHHles5bsLjrRQ5S0QYxaN75kqzG77uqBh1mH87EeFGAnDc6cLxRdTvsgmCXhv41k4984KJ8KWBinx7F9jtY2noyAAtiU4xQ6/Z2t+Aw5VXrUtqzJ7hdR1woCsQmvFJTaI/BGgDOkiOw9FSqGwYKKHiRYsM9bz1bb4xvkM+y1OVHS6p31Fi8niZ9LR/rfKhYCJ3t3q0Eizyp7APdE5of0cSu5ymWkSJ0q/zurTQbYE6DueQeyCyFoyGoinYtF/C3k2oydrOt5LzQDq5rYwMqkJ2JMSSU04MTcLVNYj3VQorWIVQQynu/DfMWyzA3uDCaEwWT9pbVNRUpT3GXvKwrhQC/JwJETkIdjm7+vV/GBkfUWpjV/jjcoyQkqt4B3aCXV0nn8dNq4CbSVylk3UnhPyS1FtwePKC9i+twBqvC7WWXn8cCsmXPF2rMLgkiAZHpmx8U3OUHDI9ZDC88Kj5uXm1v1qOoV9OvDAOh6pkIN2iAKAeCnn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e12c771-93a8-42e1-aae9-08dc5efad503
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:24:18.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8lexinQ9vfLKhnC8HUJR9V/l7YGAoNuzMYzd+JYOOI6blEQtTMhufggCaJjKB0MBDR68P3Lqy44gyPQlyk4XddQ+tRyeGkzt6kPMEExnv40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8418

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

