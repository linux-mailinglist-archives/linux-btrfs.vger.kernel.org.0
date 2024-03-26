Return-Path: <linux-btrfs+bounces-3616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207888C9EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6AD30644A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD31BC41;
	Tue, 26 Mar 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hc3L0MQD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wLXPrBua"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C11BC4F
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472024; cv=fail; b=n1w4Nj4w1ztRdK3CbqkUG7BAS/fEdjkQ8NTsnlvr2/1rvFwAF9S7BotwAWre6Sclc51shjQuNq0JcC47eEGbpG2tyUQg5JLUPOeF6/iaQjHtIwkOk3lmVteBAeG/HccVwSssWBSzY8vQ+6+Pa8UAtotBVCD2zlJ1A7nPQr4bFa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472024; c=relaxed/simple;
	bh=/9PuO610JdrtjzTRFVDdx3ItjshfomG5oSDrqqEqSwY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WtpOXBLMtMVFiXiyavAOjch0vrevTd3BL7lieD1v2cXS3gy7ChpZPdpHd/r7h2QD/65T7EmJSMKQsU39IN+fiwXcyL/xS93UfdBWRmma+zKjCbS6VGj+3nPk5hzxvxsHAppB+LrxLSC6gOQXBnrsjR0ke9W4AiZST0eByKbbMEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hc3L0MQD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wLXPrBua; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711472022; x=1743008022;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/9PuO610JdrtjzTRFVDdx3ItjshfomG5oSDrqqEqSwY=;
  b=Hc3L0MQDqbPr6Cwsfo7HSnyxIczNOUDKCTMDs2cIqAASY0IPC000pUME
   mYzj6y1IhCPUR2+qF3OlBl7GsnZSNVQ7Y5ptMPLVSv75XKiaYHLY5SRZO
   yHztZaw2lkO8nrg18wfrQXE4YJVFXv4KQVr5u1c7J1Xe0jiDNC/I0Oq1k
   w+ftq5AHB5x5Swb7aVcBCsmPqWmil4uOva7R9rSTCpBUXBICrQnOhnMiH
   NW6QD71/aY0sao2j+w2T+sjTWgWCRcpw1V1eHsmgUuI4EVMTpH2vWwY1l
   9hICTbIexDdGpitLnSW8prALmnnCWoSAtw+2flvqe7MhlvOx34FZVKaq3
   A==;
X-CSE-ConnectionGUID: zu3UOREtTDWuJ15vn2CC5A==
X-CSE-MsgGUID: y1Zk83qRSmmg7ypGp/2m9Q==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="13175189"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 00:53:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHSZzaAQqokg3GE1KYz+v8N4krY/Za+Od3uZVSqWnp9HVqsYse4ewPBsxp3i7gWSrPzoPwTQPolywb+XszhDGG/dBkThUUE3yjZoRobdrdxZ+AFd/I4xHPalOYjRdvqplCu0wWJBaNVNBqBRN7nYY2UXMy7u1LwCipp6x580Uio3aFN7ruBxSezA9wH1uDpnt/a+TWwR4ZXifksBSDn7DSlaffb4enuICfsRbbx/Hsn/emud3ootmLeF48YHHD5ZYPNQoc62Kl9hfkYB5CtYY6ajzrK9c1udGs+hd6Dn+eDpNQIHCYD/spuYzuw0aIVVtv7kDGC3g/Ops4xsohSYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9PuO610JdrtjzTRFVDdx3ItjshfomG5oSDrqqEqSwY=;
 b=PvdvGKCg7+6BIqj3qE2KCunzpwWLHeZhaZMusDCIw3k9zy+VjVvR/3Z9t8J7UOrspEO9vJV2SL/YhEovz/4No0ZxvPp4R8at5XQfaZug2Ro9LcubRtAnGAmSZ9EQxyY0xvqORFvhTncc08sK6UiQ7Gr68/S/Aqm2cm5CV86tZovCI+woRYOgameNJPQ5b4D6+fmbGMOrtCzgzPPiobgwWXUA1EahWNcYot9RWlZKrHd+EJ6woOgSuPBDN2AlNsP+Bh+sjkLlr3xLAslLGTy4RXrGkh8hZPoSLPxfejQX7UFYYqHiec0+yUUwUWM5e0v7T3nxoxKvdbFRN1sEpnIa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9PuO610JdrtjzTRFVDdx3ItjshfomG5oSDrqqEqSwY=;
 b=wLXPrBuac5XYVMUkQxkD2eUU3wPgn1m6JdEL/PPT/cgDKbbGSf5S5QPMhnqlpa23kZL1wUP2bY+fczKXiYZmO/jiB63PA3wf0Gu1oP+m+hwJHxA5e1LcR2scG3NZQLTHAR73LulmbsfgVegNgqaD8XiOESPvUldpm6QEi+WocNs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8067.namprd04.prod.outlook.com (2603:10b6:610:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 16:53:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:53:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Thread-Topic: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Thread-Index: AQHafxPSOs8PVdIkc06ZzaYfR76DFLFKPhyA
Date: Tue, 26 Mar 2024 16:53:32 +0000
Message-ID: <7ada4ba7-f5cf-4515-863f-38b79f45253e@wdc.com>
References: <cover.1711412540.git.wqu@suse.com>
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8067:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zLkTC03une4taOf3VU/hX4myIszcHXCxqF9uv2i55i1FEKBJsr77c/Vofd8MemACteLkT82CEUyO9fW8/kJ/KoocPB1ZR6fQ+eV2VzBtR94JuODhGBLrzw1tUFEEH7Vqc0pIOU5gJ9jUlun+ixtsgtd2tPc0WZBi3kdQOAAdistnsufoTcfHA9lc3RklPW/7gBd87uVIqT2U5kkXKKD4EAAA3UGn4hflMsgg2Amdymtvz18U3mJvsBTrBKIrIOlsmdvAtJIrI07NQ98FFX8cwG4svx5K5mqMZLehRsDg8nOxaWFUFHQtWWxphrWxf4pDZqhbm2W1dir+pbB/JyfjpTuMEeUwOnVt4a+0eWdQLrpZC/rT5XXn7gtiq1zF6SNZEe81r3RtRPen/H8PK/2bYai7n4klMDAi/sRh6Jv5hjtisoVccW9a/6PwWiMtmkYjyqE+0kpr1yBpF7aeT3p9jIs4rFpTXXuzDf0+IwsN+FVdBzoCecW4jeF3di6UJ9Jk3jM31BES0VrH2aWzXgVGSo4tcqGVW5yBErLo+074/qDXy/LobAD0VP2WjEsnrbltGbf7iWVrC6/AwYgxdTLS4wjM6sJNOitreIKuw/PAsm+fnisXQbQNTDZ2PueSU+BybeN/jFt8WQbK/bKXy8D2BGll0sRW6T/JRIfPBzpXxhk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkVrMnNTQ1J4eDRKRlZiYm5LTUJGZFdQTms4c0V4OUZOWEx6aks2OWtYQ05T?=
 =?utf-8?B?aUVNc2NQU01BWjBBOE5GNHAxR2x5bEtxS1pCdkVvZCtaUERFL25RbHRMTjht?=
 =?utf-8?B?SlB3eW4yV09UdTBQZlRienBSUUNuVnlBVzBiTzZZcHFjZzNBYVBCTUhyV2lS?=
 =?utf-8?B?UEdXNXNPVFQ3dG1oMWZMUVo0NCsxL3huNHJWbSs4cW1selF2RmEwUHVteURT?=
 =?utf-8?B?ZWdHelFjWGxUeGtidzNQTmxMNzR5d1VielU1NU5wMVpBK1U1SXFSMmNwc1Bo?=
 =?utf-8?B?aHlOVDlVQlFCM1d3V1NmTS9RNzZHNnd5TDNxaVdxVFlQaERoZkpDNFEwUnhj?=
 =?utf-8?B?eGhzdzVGSXcrNmdyWE4vSlJObjFtUTJ0SUFHSG9nekFqSURFOE9uZ0VLZGVW?=
 =?utf-8?B?aHlRTlNGRVRxbk8wNHZ5MHl5OXA0cWlBMFA5a1hTcC9xdHhUdlFkNHg4OUVZ?=
 =?utf-8?B?T1lRRTlrVHo0OThXaXpESFJES2RtdGpWalEzYjUzMm5CR3ZKY0UxekRrZ3hl?=
 =?utf-8?B?VmdJUklVWGRMZnlqT1ZIK2NJaWZFWGxoNGRublc0R21hNzRGQzlPaTljNGNq?=
 =?utf-8?B?ZDhsUmxvMjVVVld2WkYzZkMxK1JSbVNhODdmbEpzNDNuWk8zbUFIM2pTQVV1?=
 =?utf-8?B?cjJ5cEZxMTZDS3NVNWdneFM3THlaK2dIYzdoSStaZGk3dTZZbXVzaWtob0Nq?=
 =?utf-8?B?Y1o2TCt3NGlFQVBKbHlqdXJmZUJCSDI0dk9xMTdyeERWZWFtUUtNWE56b3N5?=
 =?utf-8?B?U3hocEdOd3ZBSlZKb2VsR1FvSndncjZOeW1GNnJxUmxaUXB4cGJGZW9qVkM1?=
 =?utf-8?B?Z3RIREw2Mmd1UnJ2MEJsRFB4aEh6aTVLRzFLdzZPbGdyVmhIYXQ4b0docHpV?=
 =?utf-8?B?clNzN3ZYbjNlMWpWaUF2MmZ4cDRXTzhwa1YwUU9OKy9XSXhjd25OL0hsOFN3?=
 =?utf-8?B?Qktsckp1WVRMMmVIdllJUGp0bU5EcW9JSzhpZmljR3BONW8ycWk1UDFJZndP?=
 =?utf-8?B?ZU9jQ01uUithd055MUx2SlNPRHVDU2h2b20yeEpDckM0bmZOckdQczdEdUJB?=
 =?utf-8?B?eWJraFZzQVI5OGZlYnROeHpLRTBIc2JnVHE0c1hvRmQveUpMdmZ5RFRBZ0VT?=
 =?utf-8?B?TmlubGM1Zm81RXdTTW5OYzdlVXN5RVcrSGNabXBGQVhiNzBRK01xdWdnelBh?=
 =?utf-8?B?QmR2S0lpaHFGcW0vc1h1a2dHYzVDQmdYeVIxNzlMc0daTmgvMkZIaUhaSHFv?=
 =?utf-8?B?U25NOUNkS2hCTVRUN0FiOTNFd29tTW5EaGZveXZFUCtGZk5UZTg5NklkMGw2?=
 =?utf-8?B?WVVOOTVJUElZTEVqalJ2a1J5RjgvcDhFZGpLak1XTmtvY2xKZ1NzeDZoM0RE?=
 =?utf-8?B?eFZhTjhJUXpUSkZrMkJoUlRXV01nalVpY0dnSXhWWXNOMDJtay9kcCtRajk5?=
 =?utf-8?B?RWFtUXcwSVVhaGgxbm5menZGMHY2M09UZWU5YVFuc1g0MVVNUDEyNjhvQXhX?=
 =?utf-8?B?ckg0b0hQY1YwMXRuZk1oSVNmTjZNOTVKcEpkUFdyWnJBbmRiM2daZVBiY1Ba?=
 =?utf-8?B?M09sR3puWXZMc2c1T0JSSFdDSHJIQi9tRys0UWRzY05uejlGcmZPR0w0Z0Nh?=
 =?utf-8?B?ZFliUFdTb0c1dmR1cCtKMVY5MHdVZ1NoNWZhaFRVaFNML3J4bjdseElpMFlL?=
 =?utf-8?B?dzhBcnQ5TXNlR2U5c29EV2lvOGtTY0Q4ZGhEK1lUZWg0TDNMYUdxMk9MQ09T?=
 =?utf-8?B?MW95QUhSNWw5WDdmbmdtajVvOUxnZXlla0lCc1pzdzdDckUyNlVLVE1MSkJn?=
 =?utf-8?B?RlMwNUdHc0JIMjArYkI4WkdLYitoeXc5ZlpXLzMrWWdkVFJ4MjF6eVloNFB0?=
 =?utf-8?B?d1cxbDZBbVFBb0tsMEQwVXVRMjl4MmFCd1JSM0UvZ1c1NDE1YnM5OGpvajAz?=
 =?utf-8?B?MlpBRzRjZDlpUTY0LzltalloSTE5SmljK0dGTXlYMlhPZjhkMnJkWVprcWpP?=
 =?utf-8?B?RkVLTGJza3VVVU5WbFkwWDk0YVY2RUpISU4wQkZrL1FuZStUZ1VROGhvK3JQ?=
 =?utf-8?B?ZHZ4ODBpL0JHQ3lmRjJ4bEY1YU5jRVEya3RVaG9OUFNuSVBpNzg1VnZxd2xW?=
 =?utf-8?B?dklsRUgvN2F2RzE2Qlc2RFBNT0JWWjJNUENDZnJMNmtnbFZiSUJjNE80ckp5?=
 =?utf-8?B?eFFqSG5WSTYxV3Q2R2lGOE5iN3h4REI1K3V3Y1ZUN20rY0hrZ2JPdWhVUmZn?=
 =?utf-8?B?QTBJQW9iRjB6NElKdUthWmU1WTBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE5333EF6B26AB48AA5DA0B270C2B697@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+N+SDpK+X3i3Ogn7HB0ig8q4jfhk+OXQY7akHzYlQ/zX1u3kgkDA30/O14p901hXFkyY79aJAaPgJSESYTG6+J9WdOfdsuHmArWaigoWD0DXWQ98UBRBLe0SKvOvIkyKpOa+3ugWyrX2Pv3l2GqvGS5dS+FYxq7wxMizpqKTfYzWSU8NjA/8/BIBC/yvPDaTXojzyhqN7KZgNvxDy2wzRFRnmn2XsmeI5B5KgIRsJvjpPeZQ4GJt2zAFzMQCrvv9JzmjYla82wlxVcZ+ub3yJIxLDEzahHhgQOgJky9xMb9YwLF5Lvr2Z8Kpjl/oq1vZT89bfruJW7GVvgfouS32hvPdEhjgbWikVGD+j723N0pM3uDSUlKvMlnNbdFHOP7NLCQ4JtxEWhuhi4rQPucyEHcVe+a+OGJphHV2hNJzTE7zwKgUk6LLbM0HhLqJFTPBZlBAKTEGsrwie+S+jR+9wu3XcaFuc7qiRSzyMrKnnKMCOLLkOgej3i2yAFrmAwG77noxzwdml+F0aTYRY3AZLci5WMCa4ZSDRCJ+M9Yezj4orZCWWD5E85UVhaIpIG+pV7dNJ90wLM9RwWsWR2zy6FWewWeFEdmrMwnknMGCChV5HBgIj1OmY0fVxSc51e6S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca3604-0b81-4637-046f-08dc4db544f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 16:53:32.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsmWt14CHEqaqig2O2mf8fqf6V/5D4akPIkC/OWoO7k8kdb5eZD7GWPgIwGrHTOGOyWXrCScgimTuYgNCkGEnI14n2F+B4q4nPO0weUO+WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8067

TG9va3MgZ29vZCB0byBtZSwgdGhhbmtzIFF1DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

