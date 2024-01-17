Return-Path: <linux-btrfs+bounces-1516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8988304AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A97BB246AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3E1DFCF;
	Wed, 17 Jan 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qpAqVKdu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YE1iCBhH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E1DFC8
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491752; cv=fail; b=NjUjsMz4Q3akquT1FqBmEN4HqV3eX5FqcDJuo/JjuKyTbETmzLpEcfkzam0tee168737cjVQu68CXi7W675CstJ9rGcYMq6bqTjIelDrP4z+OwEvaUdZdgEZjGOy4V8gDdnn3gdBtXtkEagDKBwzVqNrNfKoLKaDWZ48sS484Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491752; c=relaxed/simple;
	bh=ggxi1uUUVcdrmC2QyD73VIHHMV0rpYn9YLRzOnLsdrk=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=nxP61/q+wygeKoM53gFUSSKCvUS6XuUpw3WVOTOscxCY5KR7g/bdhuTdCcTNM0TXrB6w984M8tqXrD/kZ/2/ur0uRS22Dqb87x8v8UlfZhjex08NWqHNjEA4IHcEsyN7IyjZTwbJZfi+tEGCCZSdueIdlAi2fnoRuSCtQq30Q/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qpAqVKdu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YE1iCBhH; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705491750; x=1737027750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ggxi1uUUVcdrmC2QyD73VIHHMV0rpYn9YLRzOnLsdrk=;
  b=qpAqVKduenxFV56H7FSFy4Vg0gOtgnAa6+hUUcwsmvM0vtuSRXFGmRP8
   uj2GkJK5fsFSTvUhQFaXR4mgtIYFe32JziK73yDaeVFHGpf94r/6+Blsv
   PqRnkLMAA4BrXEvweedDfqlLSHfuhCpovXLLa4E66Y6WziSac2VTdir2t
   58UmiE3/bzH1MKOdx4CXxxA75Mfzc4BCpZ6sZ4TdYVgD7j54fBuf0R7ql
   bPugBvmKyLdnTlENBewYOgAxMhOAN2DNuEBQkQJMwZXSzIq/gkmpJbbY0
   l8HahifMgy4qbymlX+13ikNaHxqbP/FknrkveogwIjHAAfVen16+0WR/K
   A==;
X-CSE-ConnectionGUID: Hzvxsdy1Qkm8NEje4CRAFA==
X-CSE-MsgGUID: vAz0yGKpQ/SlmF9CXpllRQ==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7157111"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 19:42:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brgoXR+fadxsqpcJAXSAASb1OaBcBZKVUULbt+ddtPnnNJWGdO0LYYz0ubwF3Ivo1b/0jliClE164D3Z5SZu20kar+QvMIJapjvjjqjoXDZwpraM/PF3SCVDP+wjW3tu8XrqZqrBfUmkzydhrdej+NDscZXmDMGzE4xP7uuNBbTDR6XAWpuXiVzEmizB5bpyFwZ8WzRdu/TNCK62REulgIhccjw1d+XA2bOOiWoXeza+K6FYm/8hjHqZcCzZhLuXrlx0CHfqVs0Viv3YfQuCCBban+0/PN1++K7s8X6iSMameBoOMkGMgWnLaL0d7Q2+8GtVlux6YsXI8gX+9GXGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggxi1uUUVcdrmC2QyD73VIHHMV0rpYn9YLRzOnLsdrk=;
 b=Nn6brPXynonJLdh/Mme+1WTK+109l0gDQkgOIrA2NdBmHb52Ttp/wtrRgBTcXK3e67hDH/BqWYB3bWyW6+ARrJn8LEZtE89hCmC2scnRNiZJuT+GoK4CX3lfVZwIJ0OVsZCrQo0zrfhdOcpZhmFjyvhEG75jNfEKMpyfv2nKgFNi4n3GeasBL3WTMrlZGTedR0TSEZLZWYkT9HIP2teR6Wqcv0ZXgdPxGxM/d8qMWTAn9+ojX/bK7am/9PTmUjyqz53G1KXRbHkijNxFSvglKM/aT/hsYVMyKUb2EPlFaLKx0prlLfKJpT2E+KbQfRPE0TV8H83YARC3XPGWnrfkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggxi1uUUVcdrmC2QyD73VIHHMV0rpYn9YLRzOnLsdrk=;
 b=YE1iCBhHRJIrgLE+Sw7aMZ3ENXg4NswzE8DIrdHqjgVXEMSJgnWe3yguocoPm2yXrdz58NHhJc+R1f3imDx48bXiMIC1N2yU8D+gYHin20qyGqKwZfONk9Kq4y+RkH++gR3qWE70PxGHpf8h2mz5WJcfOsoUILLkKAo+U4KOHoE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6913.namprd04.prod.outlook.com (2603:10b6:a03:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 11:42:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 11:42:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove duplicate recording of physical address
Thread-Topic: [PATCH] btrfs: remove duplicate recording of physical address
Thread-Index: AQHaSTA/MpZYsS0/FE6blS1ztHGBlLDd4FCAgAABywA=
Date: Wed, 17 Jan 2024 11:42:26 +0000
Message-ID: <45173429-2e92-4305-af29-47c63f91317f@wdc.com>
References:
 <022e1767f333e36d22e0c6f859334ae9433e42a4.1705487315.git.johannes.thumshirn@wdc.com>
 <CAL3q7H7sTX2jsguSZtZ9XwtPEsCyegXO22E3Y6j=qLg=UnoJCg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7sTX2jsguSZtZ9XwtPEsCyegXO22E3Y6j=qLg=UnoJCg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6913:EE_
x-ms-office365-filtering-correlation-id: 424505b8-adcd-4db4-e4ad-08dc1751610c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /VSWZFoswIU3sOj8s0ygkSlGKdZ3AAIf4v4A320AnwlBRmLUrVQCLre+y9jP5yT2Le09drchE/qJX3e657iTVCx0cRlJl2SnXxx7y+OevQg/Q/AIcAfALetNKvdNm92AphjteSPj71shBIYy1L3fEZDwWiSEbEon/gFLME51jSlEsUywp+1Bl/EI3ChNQREij2hSMC6J+35XcytafjTtSKABTKo9R97sKwmWqygrB4ZXR8BO/OrHueGagTl5SnEFLrTXBvQTY/JlCuHMn2RyOE0ajnxZBaG7PizUI5yX6SWwCg0WkGH8Y7YxiFajBz6T1w26xPoK8cnllJShOYXLMHnQoUoe2rOdr2A7zaJDcEnbkkxrm1mYkY8pOQaisrs9KM0uL46W2smtZM957yaO8X5zdbmltWxt2KlJNt9KdK84/SLDcmFcDPH8RjqatlPWZw6ybq6YY+Q1SNRqfqmTwS5HMji6ZsEJCFnwWjfpBjTULHM6StxCfvBbl4CWf2r5FHsKhCcGAjhQyYsJYpMsuJhOP+rEkoKbFUk+PD6pLhwDsH9o4cWp0GoBY67eLIUaeRPuOkc6Yera+khFd37imWM1dqfpcjZlcDl7VYGwJZvACqxKfDzU1S/2zUgFaKAZJt1L6BZ6ZATBVugTo+Qm1lbg+ktIq1RJtwhCpeZb3xVpdvNNNZYfUnWcVmgjez4+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(53546011)(71200400001)(38100700002)(66946007)(6512007)(41300700001)(2616005)(76116006)(8936002)(122000001)(8676002)(4326008)(5660300002)(6506007)(4744005)(478600001)(6486002)(2906002)(66556008)(316002)(64756008)(66476007)(91956017)(66446008)(110136005)(86362001)(36756003)(82960400001)(38070700009)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?My9yRjJXcEVFVE1RVytWeVBQS3hXelZjK1psb3BIcHJSWUloZHF4eDJwUmRC?=
 =?utf-8?B?ekR2d0U2V3c5TjB2anBWOGlibEU5WEtwSXhHQWhseVpVMjB1RHZmWkRtYXRG?=
 =?utf-8?B?b2dJNDA3Z0lUcU9UZmFlbStvSlJzeXEvdzdqak5VWGUwTzVQK1RZU0VwTjlt?=
 =?utf-8?B?ZW1mN2FDZEJuOTMyWlZPOUY0U1UxSTdnNGJ0UGoybldzejhrN08rSUxrc0E1?=
 =?utf-8?B?VmxDL09POVRkU2lOTk9wT0JVQTlmS1FsOHFwMTRpd3dTS2hKYnVLTUUvWUhJ?=
 =?utf-8?B?WU5sS3JFbi9HWjQxRE1lM29aQjFlUmNUQnoxOW9UU1ppSjNZVlFVbzRzVDVk?=
 =?utf-8?B?OG5SdmJLS2taYU5pSmN4QUlCeWx3M3VBSzRnQU8wMXNYc1Nra2NKZWJydFpo?=
 =?utf-8?B?QjRJdFYvQ09DSno4Y0t3NUJpMVZFQTN0ZTdEYUlrcFlLME51Sk56YUNHK3hs?=
 =?utf-8?B?VS9GMXZQV20vaG1ZSGhRMFRncUx6WHpHWEVrYTEwbEVZTFhtSmxGejJHM2g0?=
 =?utf-8?B?SS9sWW1udE1rNzRNMnJpTHhHeVlTTkdQWHFtejBmdDBUSG92L0tJRnF3amVS?=
 =?utf-8?B?dStPM05JTGg5YTJDN01jOCtwa0xHaHNoRnVRSUF5WnVQdnE3M3Q1d3QvbzB2?=
 =?utf-8?B?eU43bFdmNTZ2Tnd6MklpbWxJdGJlTlBkdFByWUlHVzVvZWpIWVBYbEhHZEpB?=
 =?utf-8?B?bk5EeDY1dWsraEh3akNyUUYvdUxWVlZRRnBwd0szQjVZZE5TSEljV2pXYjJ0?=
 =?utf-8?B?aVNmamF6TDR4ZzJUZ205Wmd1QkJCUUwxMGVBWElxUEthUXNkQUxETTNuY1hS?=
 =?utf-8?B?WFZxeWp3QUk3dnNNSHVEckZXOUFrcmR4RmdEdTNyVk9PN0NiNHlody9wcUlN?=
 =?utf-8?B?aUVuNDRKSWZrVXBmMmtkS2ZQN3dsZVdSOUR0NityNUREeWtHcWZ0VXM3TUJR?=
 =?utf-8?B?NUZsN01qU1dJUTdtSXVHME0vSDlMcUhoc1dtdGhLUG54VGVtelVlYU0zVG5J?=
 =?utf-8?B?dkhhMjZxdkpCK3VvQ1QwbzZEMjJQc0YrZXQrdnFQaHhIVU4xVEZGTktndWow?=
 =?utf-8?B?YzlBMEJPUWpkU0lZbGtvcjRvVEs4QmM3Qkt4VjROdDhFeUlyQ1VwRk1OQzZs?=
 =?utf-8?B?OE5wMThMWVBQdVpweGo4TjZqejBIdFFPZzY1YmhPc1RtaFArRE5Wb2kxYUU2?=
 =?utf-8?B?Vkk1MDNNbzRuSTNIdzNCTllyRERWVTVjVU9aNlBPdjRvS1U4THY3cXZqaDE2?=
 =?utf-8?B?SksxY0FWMHcvUm9mKzJhZ3M5bFIvbXJlQXZKTHpEdk5IdTNPck5FZ0k3WGRQ?=
 =?utf-8?B?UzgxcktMeGd6WU1QSHdyZzg4MEZoMmxXdDBIY1hhRmloQk95RWZDK1JuVDN3?=
 =?utf-8?B?cTdpWlpBWmU4M25GZDZpWnYyV3hhM1ZKa0d5aGZybUZ1Z3lGVjh3M1JuWkdK?=
 =?utf-8?B?azFXZk15aHZkYWU3c2FheElMSnQrc2lmaDRQVHY0NndiSitPWFFUQWJ3TjhD?=
 =?utf-8?B?cFpOSXAxTTZIdHZmMlRHaGdITE9Xamd2dS9uYUtVK2crQjJNMUZIeGdJc0hS?=
 =?utf-8?B?OUdsZXN5Q1pIKzFGMTFqc0FCU2RpTHpDcVYrVlplZzc4bjJ3Zjc3YTR2c1pE?=
 =?utf-8?B?ZDNsRjN5VzhPVWlKc1FaWUpIVGJCRlZBRy9aN0JiUlczU2E5ZVBrelJEakN4?=
 =?utf-8?B?VzdMcFFtaVU4U2ZvQ2V3YVptZTlhOXJhV2pabzVpaG9XT0htZGhnRHYvRWtD?=
 =?utf-8?B?Zy9GMUZZWG9FQ2JyN1BDZS82K2w3M0tNSk9FTW9WYVFQNjA1ZFJVdzFrZDRz?=
 =?utf-8?B?MmgvT3R0WE1qSC93WnBHcGdJOXNzQldkWmhBRFlFTWxERUVOV1FLMVkwbWtk?=
 =?utf-8?B?alA0MFRON0F2SnNudjZNSm1YSWpYZ1ExRjNiS2cvT3N6Rjk0eDc0NXl1d0xu?=
 =?utf-8?B?cEkrbml4WkhuZ1pLMkdDb0RtcE1MZElBV29obHhUQlBTdVNtR1VSSkpuWDY5?=
 =?utf-8?B?Y21oQ3N0L1dPNEphZEd0aFREcmR1MzZmdUNWUXk3aDBRNHlTUmIvbG5sUHR1?=
 =?utf-8?B?QVlyTnYzak1CNFNBMEh1Q2dVcWF4anNkdTlkOUQyMHpUNkhybE80MUkxNmJv?=
 =?utf-8?B?OFZNQyt0R2gzelFLeGp0S2orL1RFbmdXS2x3eWd6NlpmNnIxN0FDYjExeURH?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <060431A43C5E9B42B7156C76DCCCB4B9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OX76RWKESG32UVvKSPAagAi55iO55qszWwWRQ8GqsyszN8YhcdUTI4qgy5gxMkRPggh7NHJ4ZPRIK5/k9z8Vcamwi6uhzq5lkHH48mpaBwrXg8Po/rXQjouNQVdy0eTSfuVOU+NkmabQ5UZaifxmyQwsGHhRyC1mO1w9Lkfr/qpgQ80DPCzwS0gBVfJ8p96G9kegWAlYyaJs9uA7e2AejdoSsE5wA49RK5Ax30EWrYyJiY3l4vFSszNjeEqJuw8t5KhaKs1RlctOvyMBV19HeSCii+W9fBagL0j0WujBVr93myeMDjbF/2Y0sJE7HUCNi8V2sFNwi9G17xOjb78CvbiELjlrqH+0kE3BVzeG2/iGhLfku7bkbrVjQltiR1Lp0eSUHdC5Sg6+bSFUSbRzbROM1THSZEGA0s/J4ojLzz1RSmQA9lbxsuZRYR18ISt2U4/VbM0c7XMYabNZCM1S4fyj6KChvWrw1ZKf3o29yVEaQrPMRye33tSpOW5BQrIGCqBqg1JOu1xkBmc/DnHjEgiuLPv8hoDmnxQueQ6hLImtQATAI3yTzPD0Cz33xzdlsncG6dK0BGFmzIg8bVQ/RsMJ3OFjjxIfx22gJi587sM0tfKCX8Djh8AZugsj8wCj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424505b8-adcd-4db4-e4ad-08dc1751610c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 11:42:26.7504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcKiwUIkEowP6yyjgrrw01XGiI7WTUkildNQb5mdfSJ6gUsbCAWe+Rg9SbLCfKbYTo2IGLtzTKKFv9tJ7jNrOD1LLg/d7F0kNKjdi8SL+ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6913

T24gMTcuMDEuMjQgMTI6MzYsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFdlZCwgSmFuIDE3
LCAyMDI0IGF0IDEwOjM04oCvQU0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+IDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+Pg0KPj4gUmVtb3ZlIHRoZSBkdXBsaWNhdGUgcGh5c2lj
YWwgcmVjb3JkaW5nIG9mIHRoZSBvcmlnaW5hbCB3cml0ZSBwaHlzaWNhbA0KPj4gYWRkcmVzcyBp
biBjYXNlIG9mIGEgc2luZ2xlIGRldmljZSB3cml0ZS4NCj4+DQo+PiBUaGlzIGR1cGxpY2F0ZWQg
Y29kZSBpcyBtb3N0IGxpa2VseSBwcmVzZW50IGR1ZSB0byBhIHJlYmFzZSBlcnJvci4NCj4+DQo+
PiBGaXhlczogMDJjMzcyZTFmMDE2ZSAoImJ0cmZzOiBhZGQgc3VwcG9ydCBmb3IgaW5zZXJ0aW5n
IHJhaWQgc3RyaXBlIGV4dGVudHMiKQ0KPiANCj4gVGhlIEZpeGVzIHRhZyBpcyBtZWFudCB0byBi
ZSB1c2VkIGZvciBidWcgZml4ZXMgb3Igc2lnbmlmaWNhbnQNCj4gcGVyZm9ybWFuY2UgcmVncmVz
c2lvbnMsDQo+IGJ1dCB0aGlzIGlzIGp1c3QgcmVtb3ZpbmcgYSByZWR1bmRhbnQgcGllY2Ugb2Yg
Y29kZSB0aGF0IGRvZXNuJ3QgY2F1c2UNCj4gYW55IG9mIHRob3NlIHByb2JsZW1zLg0KPiBXaXRo
IHN1Y2ggYSB0YWcsIGFuIHVubmVjZXNzYXJ5IHN0YWJsZSBiYWNrcG9ydCB3aWxsIGhhcHBlbiBh
dXRvbWF0aWNhbGx5Lg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IA0KPiBBbnl3YXksIGFwYXJ0IGZyb20gdGhl
IHVubmVjZXNzYXJ5IHRhZywgaXQgbG9va3MgZ29vZC4NCj4gDQo+IFJldmlld2VkLWJ5OiBGaWxp
cGUgTWFuYW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCg0KT2sgcmVtb3ZlZCB0aGUgZml4ZXMgdGFn
Lg0KDQpARGF2ZSBJJ2xsIHRha2UgdGhpcyB0cml2aWFsIHBhdGNoIGFzIGEgZmlyc3QgZXhhbXBs
ZSBvZiBjb21taXR0aW5nIG15c2VsZi4NCg==

