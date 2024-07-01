Return-Path: <linux-btrfs+bounces-6055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BD91D8AA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37D8281414
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF46214D;
	Mon,  1 Jul 2024 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FKiHlS2b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oTS7jfdZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C42AD05
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818090; cv=fail; b=A7WzrcnWzgiVGxClvu+UnjRsgqW24f8nr0GxyV8OwSOee3SANgfdRj4PjH6UO3ObLWY9A/4xNnuWgu0oxGDoKaCv3C0c2tgtzDQ4noIY2cmaSSyStzRZ2RL1PkSr4Q/+NIMEMRUERuyNUbTPiut60LtA1U+M2bSqBCShSYb5540=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818090; c=relaxed/simple;
	bh=esoCWEJniLoBiJpPU6tlo42uE+0QiewoBfngb9yfy14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hrraZk1vfkvujk5IPRbWzw17n3DMq9pLLN4eHRAJuCZYCy22BcIvhk6Kpt90kTndTsqeo7k65BWqa2OxX7xxiDRXI0cPRwX3Ik4HRvgcu0d3rcB9IPru5c0vDfKUC9QU9PHWw+uj0uHxIQe9TQj2gQpZjrR8pKZkgKERJuAcCEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FKiHlS2b; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oTS7jfdZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719818088; x=1751354088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=esoCWEJniLoBiJpPU6tlo42uE+0QiewoBfngb9yfy14=;
  b=FKiHlS2boV1WXnopjzgg6/Jg25aeEiirOpy02rBHX+Bl/gTPhIsErb8T
   E3CAZkHyUYSUJqW0ZYg+c34Dzfl0e2Nua2C47sI++E5w2Mr0UvDcJh+mw
   zJ/Jpg4MYKGUE4a7x3HS17x+Nw9NfodranPvp1So+hJ+g8vT833DubvdW
   qn/I5m3+aFeu+fgz85InkSKkFiG9UEDe3oyA8ZCb2QSD8a+EvKXPocH7W
   HxTZqZAhTdy7Nxd0nn1QHTiZIrULa6YrEczE/v2eMysn3aQO2/k8HX0f/
   YLYa1AtBzkFO30iZJJ134KOOpslLha8h7RzSAIKv7eDiEB1FmaIoiRZDG
   g==;
X-CSE-ConnectionGUID: 7t8XwdT/T0OOqGkQepCjNA==
X-CSE-MsgGUID: hoL58ArwTZ2ZARMOywLy0g==
X-IronPort-AV: E=Sophos;i="6.09,175,1716220800"; 
   d="scan'208";a="20235296"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2024 15:14:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOg/6Kh/j//uwBkucSsLdWHmMBoEajzx0ZkrD3JTLEDjUbyAQ4vOzqvEJWzUvJ+EwHZoCUISLaTRi7P9XrITzEhgh0aCR4Fnj0DsF0Ax4grzRK7ejdX0U8Jh3zu1BZLv83TAQN/H5gxddsvPmlPyN5SL/GtsLZwj2VJR8kimLizsu1K/xWqPD09vwYdeTerMYl4kOm2vGAxkoGRsOKpLfQOYIUAU19sC5KH6WF44x4zJlcZa4OA3uvm50gDHBC++fkZ783bfjYSCfbmUjFHtdxTnPTK/xtcorwu1Zqmd7RgcZno4/ZQO4ao3gtfb5f7Xc7BE79PEkSXeMqH4+hl7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esoCWEJniLoBiJpPU6tlo42uE+0QiewoBfngb9yfy14=;
 b=Y+etR9pT1/d1O6Tbf4praks3kL2B07+Z4nAOGTATxbM0hr9NfftqVf2qaAcxbZSvb8LGEf7AamjOkb14orl1Oc4oEL65ejV61qejWyfioYh7FkfudcBRcj59w86RCej8lC2jqW8JF9XW+wiH8ijefp6yU7U1Bk70y2vkAB3HXQoe0qYmEexzqZoXO9v8vulnTQyLn7B3fpT9xLk465lgy4Nq9kw32j0GomqYawz8iOqwz/5GctaqTllftfUF795JyX1HrukB5Ax3YWsjdVzYHO++w8L9ZG+RXx6ZSvqXxT7dEh5hoqA4eX66i/Fx+J4P3N4LLtGh2iiTBQkeUWHm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esoCWEJniLoBiJpPU6tlo42uE+0QiewoBfngb9yfy14=;
 b=oTS7jfdZwzcYWNS+vM/O2nABjDq5Or9Cnjq1wZuVVmh3Kb/7s6PHfpAkpkfaAmHz0LwPLXcmIKOkZpGJTNipOjKJ1WfUobLjq5HPU4qhsdzgeMCYgo6zfleV20Ti6GUkYvYAMWXQkW+AUY6K6o3oZTiLViUySzGarwPQKogDzp0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7564.namprd04.prod.outlook.com (2603:10b6:806:137::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 07:14:38 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 07:14:38 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
Thread-Topic: [PATCH] btrfs: avoid possible parallel list adding
Thread-Index: AQHayRZ66O6rWExFRUmxidXXuvxvtrHc7aYAgASM1oA=
Date: Mon, 1 Jul 2024 07:14:38 +0000
Message-ID: <ikeovp477s5ittkv4tbr2ljzgaz34asc26kj6kwtoggvvfvc3r@qcls3233ff5f>
References:
 <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <CAL3q7H5jCHVhz1E4UgNdujtiX9FHhiWVhHsN3ow70WGHRTf94A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5jCHVhz1E4UgNdujtiX9FHhiWVhHsN3ow70WGHRTf94A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7564:EE_
x-ms-office365-filtering-correlation-id: 7786d91a-9f39-4a9b-8a5f-08dc999d7816
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDdrZ2tqK2RCSnFwanZjYS92T1luZm5SRzB2VEVIcmpLWGEzakwvWDFMNjVw?=
 =?utf-8?B?MHlnVWZTYlJ6eCs2QU1GTmN6WG4waDdQN3g5YU9pTm9JeDFwWWpoZU5KTGdM?=
 =?utf-8?B?N3RaQkE3bDAxTTdRVlB3ZmpTWTh4ZHhNR1M0Z0NzWjdjQkU3ZXhKRGhMYlEx?=
 =?utf-8?B?WnZLSVJDUTZSb29PQ1YxaHZQRmxTTlpvcE1zNXJNR0tJN2hCS1FHcCt4U21I?=
 =?utf-8?B?TUZjTStUU0ZNWjFvZVJmV1NDUXlZaTBCSkMvNy83cEhlSXNWenF1M20rc1dp?=
 =?utf-8?B?bnRNSmowOG5GUWJkUFF2SE5SWlJ1cVB2ZEhOVmQ5ZVBJWWRmUEY5bERIZHMz?=
 =?utf-8?B?SEpMa2M4V2Z0SXhlZi9ySmhGTGZxdGtHSG1vZ2FWWUZReTlqTkpCckFMU0Fl?=
 =?utf-8?B?TFlPeExOZm1HdHV3QU9naGxOTHBWbzlNQnhlUnZjZmJhT2JkUHF1RkFwck5n?=
 =?utf-8?B?TGhVbFhXcFhPU2xXVHRIYXJBdXNDQlUrWER6b2tNbGxsYnhBZXBwT1lBajVE?=
 =?utf-8?B?YTgrb0lZRVdWU0N4cTBZSUFpeVV2OERvZ1REOThDTWczbnV5SjA1aGlZVDE3?=
 =?utf-8?B?TXBmWjJUTkRZZHFzUDl0ZzVTY3BEL0E0YnJ0UEt3dkxkVVd0U2NDbnVJVW44?=
 =?utf-8?B?ZE9ZZ2hqZ2pwdjNnQStsZmI0bVBPcUl1SS82Zk1YNmZIYjdDSGFvem4vaGtC?=
 =?utf-8?B?L0gzaWlVK0ZSeGE1MEFTV0YzTkcxYkFhUVV6czZ2UnEyL3JmV1hDSHZPdWNI?=
 =?utf-8?B?MFJ5NXk4dDhjL09pcUhjWWJFdVBUYWE4NDYxbURlYjR4WHA3OFBuS1BjYmsx?=
 =?utf-8?B?cStGTm5XbFpNRGQyL0hIMG9ZTmx2WFl4TEJjMURmdzZCUVNnZHNZaU5Qamd6?=
 =?utf-8?B?QllvN2lqbTlZSnRJODFXN0JrSzFwVEt5Q1NpSVVUTXRHcXhJTXJGL25MYjds?=
 =?utf-8?B?bkdZWnBhaWxvZ0h6VzNpTEhEbXhOaithUll0TWpWMndzTXFubDBJMFhVdk9t?=
 =?utf-8?B?bHNvTFl5UE1GNGE1Vno0UDM4dC9sQ3djOTdZQkJzRzBTUlJSVE5pM28xVG1U?=
 =?utf-8?B?NVNkcy9ibDV2REl6ZVVZdCt4WjFoQU1FNEluK3pIS21hV0VUVEVmNkhUeHJx?=
 =?utf-8?B?WHBtekZydktQNDhCcHFMYzNWS0huNm9UemFhQUNxUXovWnlJWGtzMXd6Q2I3?=
 =?utf-8?B?NUZBdTBhWGt5VFFqV1VLb1c5a2U3YlFIMzZIK2xnbEMwZXdsdjM1Yk54d1px?=
 =?utf-8?B?YzgwSWdsTDJDSEhTNlRpVXc5UkZ1R3lvcTd3S3pLMDJ4cDdsc2c4S2lER0Vj?=
 =?utf-8?B?TWRibE4rYVlYM0FsdkpQbFhDSVlpSDlIaUhYTXdHcGNvSlZOOHQyaWdkTWlx?=
 =?utf-8?B?R3VVYlJ5aCtXQzdvVGl4NklGT2RVOGNtby9rcGlZa2FMS29ac2VUSklHM3ZP?=
 =?utf-8?B?VHhvTkhuNldaTjV1Q0l4L0ZjVmRxRzk3QUt3NFV0c2xadXZvT0M0bEpub21x?=
 =?utf-8?B?OElzdWNId2V4MGFTVTlvOEdjVUJFYnkzdFYzUGs3eDUybkxHV0NUbVVGdzhm?=
 =?utf-8?B?RTd0V29rL0NTNDl5d1hsdnhyeDFEVnpkYTJwUDVxMXRZTVlMT0hlZUxyRWxY?=
 =?utf-8?B?c09jamVFMDhZM00xWXBsOGhYS2lJVjB3NVNUWFZndkdTSUFQWUJyemR1YjNv?=
 =?utf-8?B?TUN3bnZqYjVtaEpKNGMvQXdEYzhRTi83cmxjMEEyQ0doZmo2azg5N1RPWXBG?=
 =?utf-8?B?MGJtVTlpL1lLTFplUE9mTTBmVFQ4bXk4OExIaTc3ZkRUVDRUSW1ZZXJybXpB?=
 =?utf-8?B?ZCttRk1KbjN3cStrWnNCTnk4dlJSekx2Smg1VGk4SWhya1UwWHZtWDFTdlU4?=
 =?utf-8?B?ZU40L2UzOHQrakppOFZCeVM0QXRpQUkwYktvUmNkaCtjMUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2ZTa0Q5M2UyTE16SnltUDZCWUtIS0xzY1h0aEhLSHduQ09YMHFhdGg5MGtB?=
 =?utf-8?B?c3VQbys2U3JJZ3g1dHRRYmJUc2NuaERRU054SmRnQ1o0dEg3OEJDQ1ZqL2o4?=
 =?utf-8?B?ZFlLS0hKQklBZS81RWh3QmFRaG84TnUwNk96SkI0U1ZEQzU1WGdUZnpXTWYw?=
 =?utf-8?B?ZHBBaU1lOE5FNWVsM2cvTlgzbE9JZWxnajUvWTdGa0U2TEllTEdJaE51bzB6?=
 =?utf-8?B?bXZLOThTbjI5dU9pUzNLZjlFRmdETEpTcTFNemtLNFBHNW1kU2U0UTJGR0dZ?=
 =?utf-8?B?eHVCUXpDOFR5MHhCOVVBd01wZWRiRmtzbElYVmVsbm9EazVhWUNOUnNUSndU?=
 =?utf-8?B?MWFYUlZ1RSt4bk1jSEl5ZjR0QVhqVUdTN1pydW5DbUdzazdSd1NCVDRNZHIz?=
 =?utf-8?B?bHBVa1crMlFlZmVNdTAyOE81Z3BXUG1BU3JOeGY1QVQ1SUhqZUVpL01DcDU0?=
 =?utf-8?B?T0lNVnFDTjlDbG11ckpNVUExZ0N0TnhJaDRCUmhJTlhER0ZPZlFJbmRTMGQv?=
 =?utf-8?B?aXhMVE05SUMyTURHTlJzUHFRSTR2SmUyTHp1WFVYQndFcVBGZHZZRE9HU0ls?=
 =?utf-8?B?N3hoUGIxVkIvR1RXYjZyM0Z0KzNjemVJK3NEVythNGwvSzBFZk9Wa2V2Y2to?=
 =?utf-8?B?emkwak1FNTJiYXRhMnNySndhMytqUXFTQTJ1TklsVmpEOTJFMFpXU2twRm1r?=
 =?utf-8?B?ejBWQ0RSejdaZWQrVGhCWWhmZXBCcnFHU2ZYTTZ6bk5nZVhtaWxjZDFKLzE0?=
 =?utf-8?B?K3h3aWhwK1o5VCt4aUs1WUdmaDVGOVhFVTR1SkhydEE2bUJpSzRlNnZGaFdw?=
 =?utf-8?B?RjhobkxuSE9Hb2dyOU9IQzdRMnkyaG5ncERjQlFKTFV5cDM2Y2lFSHQrOXZu?=
 =?utf-8?B?VFcvMU45VXNybk05UnFqallBNEFjMlk1VVdXbE0yZU9MU2Ryd2VuU004bUo5?=
 =?utf-8?B?U0J4N1kxdG1helVibmZmYWllVU5CZ1RQZVNodUtQSnlUZjNXVFJGYWRaZkZN?=
 =?utf-8?B?K3VIOUhyS2FYSVJjaFc5R2dMeE1CRVRBbHY3TW1ZZ2ZlS1I5N2FkenM5L01t?=
 =?utf-8?B?NDRBSEVodnowcG1PK1BaNDV3T0crSTIxQTlLUVhGak1TUmdKQWN4RThMSHQy?=
 =?utf-8?B?VWcrNGlaVDFkTWpNSkhFZHNKZGx0Mm1MVGZVUEt4OVIwRXZtU1gvYmFCNlM4?=
 =?utf-8?B?K3E3VHN6N3g5SDJ2OFM2eFpvZk9tOEdZMS83YVFNN0hRRUY0Rjk3dlBuSlNn?=
 =?utf-8?B?dmF3UFhXZ2RJd01jcUI4b3F0T1RKdGNYeEpNWHZwVzV6RWxmcFBNUWh4dDls?=
 =?utf-8?B?c2NSQzkwaDRSVFFodi9QOE9HOHJxcXIyTkxvdlpCb2F2NjRra3pYYzM4d0lw?=
 =?utf-8?B?ai8zSTA5djJ0OWVWMFhOUmQzVHJ5RmQ2RlpvV0JqSElVdDF0K0kyVmtuc0xQ?=
 =?utf-8?B?M2hwUGt2TURkOStUZkZNWjJOWmNhNjY4OFlWNnJpbEVOaks5TFhyU2tlcys1?=
 =?utf-8?B?NlkwaC9vaEl2eWJETXlaWTRPOVhDOVlDeU9od0xkU25wdld6MWFQTFIzbjAx?=
 =?utf-8?B?RkFBZW82K3JnMklzemRIMjBBU3lpOW0zdnlHVEtZdk1LZHM4OXo3aDZ5N3lI?=
 =?utf-8?B?MmU2WHE3K29iVWVWMkwxNWE4cm1URm9JOFFKWEw3UndKNmlWK2FJMUdORGNZ?=
 =?utf-8?B?azVwZEcvY1FPbXpIaldnQkJ3WTNLUFJPRktIYklsc2lWNitIV0UyVWgrNVFH?=
 =?utf-8?B?OExLUFJrSW1sRk93TkJkR1cvZjA1UEdOZEFsS0ZROUJhUzdEdUUzMkJ0aTdP?=
 =?utf-8?B?ZG9nc3o5MlA4MG5senQyWlBGQ0VUc2lxY3Q0UGg1OGhGWGkzSENSdkVxbUxP?=
 =?utf-8?B?UkxqUWViWi9GeitjSDUxbnhvazVXRWlFM0hSc05vVitMZXlSd0tIbHc0ZlRm?=
 =?utf-8?B?cVBIRGZyT2tJRUJhNjJwL1lOU3Q0Nlk0NVg1OTFqN2tBbDdUcFBQc1ptOE1J?=
 =?utf-8?B?N1kyOVI4RmVSU2x2Vm9mSGFQVklNOUJvOEdla25qKy9vZ2paWXpmVTA0Rmw4?=
 =?utf-8?B?NURHMzl3REdrUFRYWVFhZHNaTDZMYStPTGxxeldNZG5STVE2QWxVSmFUSVRy?=
 =?utf-8?B?cTRLNkw5WTNZWVUxaXBjUGlIM2xwdzlZazA5YTdoSWVIOTU2cFJ6SEhVZy9o?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D7310C007237149ABDEA8048BC138A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mKCN0cLAcxW4/wdwaFXkqDeNsqGlGrSM72jhSn0uaVFHAzVExF/Ar5/TLC7Qxr461gaNPlhgrFCCmLeHHB5AGisRZCt6DWiCLwzdHZ/ahGmyd5q4gbAEzKJKgN1L6pEClR36zE0b+2yPr4sQM5xL+Y9xduuEkOV4x30QhazxmJ/6olgawpY4rPK8rznsrshWJKcO/PMNQGLYUvO4J85bL90eLTryTiv4JGLb2+AQ7t7SsNsf2CRqoI5Dh03ZDiiumb5BTBLYNYKadWCAn5VEyejU1G4CX3aan4XchtYC99g5PaRhaY3fwcIS/UkKHYjHRsnNH8coJOOLkflW3jdyvRc8y9zpNyT5H/F5AMJcX4bwpux+cbW/MXYCaaFJGL6nC/HLyzQ8Ars4P+ndTIcV6sVkQBcEnEoHuDiGc2QMs+sJC+WAdKqL+3gOK0Wltj+SG6ym0GO9Z3NOT83OOO4bDQ7YN+7JRVfhS4UR/avbLHYOzK6SHRhXl6u0R6AVBw8mARojqqugU47AGuttilKx+q+v862Thcp8a+OMv5OOzMEPUnL0bWyOXilcXrIFjgdqjT5uLvOl0OGFeosrfkue3GMSrhbB1nyCkIPnqgBKX/yKyRRYIbC5K6upoJqAyKJx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7786d91a-9f39-4a9b-8a5f-08dc999d7816
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 07:14:38.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rk+Lr1xD0cLHbVib6TLoOlG4uTlno4YVx/vE0WlQLrrpc3FNYKhQXyMf01WnrmNCjvOEaOFTGiweQzp9pUDFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7564

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgMTA6NDU6MzBBTSBHTVQsIEZpbGlwZSBNYW5hbmEgd3Jv
dGU6DQo+IE9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDU6NTTigK9BTSBOYW9oaXJvIEFvdGEgPG5h
b2hpcm8uYW90YUB3ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZXJlIGlzIGEgcG90ZW50aWFs
IHBhcmFsbGVsIGxpc3QgYWRkaW5nIGZvciByZXRyeWluZyBpbg0KPiA+IGJ0cmZzX3JlY2xhaW1f
YmdzX3dvcmsgYW5kIGFkZGluZyB0byB0aGUgdW51c2VkIGxpc3QuIFNpbmNlIHRoZSBibG9jaw0K
PiA+IGdyb3VwIGlzIHJlbW92ZWQgZnJvbSB0aGUgcmVjbGFpbSBsaXN0IGFuZCBpdCBpcyBvbiBh
IHJlbG9jYXRpb24gd29yaywNCj4gPiBpdCBjYW4gYmUgYWRkZWQgaW50byB0aGUgdW51c2VkIGxp
c3QgaW4gcGFyYWxsZWwuIFdoZW4gdGhhdCBoYXBwZW5zLA0KPiA+IGFkZGluZyBpdCB0byB0aGUg
cmVjbGFpbSBsaXN0IHdpbGwgY29ycnVwdCB0aGUgbGlzdCBoZWFkIGFuZCB0cmlnZ2VyDQo+ID4g
bGlzdCBjb3JydXB0aW9uIGxpa2UgYmVsb3cuDQo+ID4NCj4gPiBGaXggaXQgYnkgdGFraW5nIGZz
X2luZm8tPnVudXNlZF9iZ3NfbG9jay4NCj4gPg0KPiA+IFsyNzE3Ny41MDQxMDFdW1QyNTg1NDA5
XSBCVFJGUyBlcnJvciAoZGV2aWNlIG51bGxiMSk6IGVycm9yIHJlbG9jYXRpbmcgY2g9IHVuayAy
NDE1OTE5MTA0DQo+ID4gWzI3MTc3LjUxNDcyMl1bVDI1ODU0MDldIGxpc3RfZGVsIGNvcnJ1cHRp
b24uIG5leHQtPnByZXYgc2hvdWxkIGJlIGZmMTEwMD0gMDM0NGIxMTljMCwgYnV0IHdhcyBmZjEx
MDAwMzc3ZTg3YzcwLiAobmV4dD0zRGZmMTEwMDAyMzkwY2Q5YzApDQo+ID4gWzI3MTc3LjUyOTc4
OV1bVDI1ODU0MDldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+IFsy
NzE3Ny41Mzc2OTBdW1QyNTg1NDA5XSBrZXJuZWwgQlVHIGF0IGxpYi9saXN0X2RlYnVnLmM6NjUh
DQo+ID4gWzI3MTc3LjU0NTU0OF1bVDI1ODU0MDldIE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAw
IFsjMV0gUFJFRU1QVCBTTVAgS0FTQU4gTk9QVEkNCj4gPiBbMjcxNzcuNTU1NDY2XVtUMjU4NTQw
OV0gQ1BVOiA5IFBJRDogMjU4NTQwOSBDb21tOiBrd29ya2VyL3UxMjg6MiBUYWludGVkOiBHICAg
ICAgICBXICAgICAgICAgIDYuMTAuMC1yYzUta3RzICMxDQo+ID4gWzI3MTc3LjU2ODUwMl1bVDI1
ODU0MDldIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gU1lTLTUyMFAtV1RSL1gxMlNQVy1URiwg
QklPUyAxLjIgMDIvMTQvMjAyMg0KPiA+IFsyNzE3Ny41Nzk3ODRdW1QyNTg1NDA5XSBXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGJ0cmZzX3JlY2xhaW1fYmdzX3dvcmtbYnRyZnNdDQo+ID4gWzI3
MTc3LjU4OTk0Nl1bVDI1ODU0MDldIFJJUDogMDAxMDpfX2xpc3RfZGVsX2VudHJ5X3ZhbGlkX29y
X3JlcG9ydC5jb2xkKzB4NzAvMHg3Mg0KPiA+IFsyNzE3Ny42MDAwODhdW1QyNTg1NDA5XSBDb2Rl
OiBmYSBmZiAwZiAwYiA0YyA4OSBlMiA0OCA4OSBkZSA0OCBjNyBjNyBjMA0KPiA+IDhjIDNiIDkz
IGU4IGFiIDhlIGZhIGZmIDBmIDBiIDRjIDg5IGUxIDQ4IDg5IGRlIDQ4IGM3IGM3IDAwIDhlIDNi
IDkzIGU4DQo+ID4gOTcgOGUgZmEgZmYgPDBmPiAwYiA0OCA2MyBkMSA0YyA4OSBmNiA0OCBjNyBj
NyBlMCA1NiA2NyA5NCA4OSA0YyAyNCAwNA0KPiA+IGU4IGZmIGYyDQo+ID4gWzI3MTc3LjYyNDE3
M11bVDI1ODU0MDldIFJTUDogMDAxODpmZjExMDAwMzc3ZTg3YTcwIEVGTEFHUzogMDAwMTAyODYN
Cj4gPiBbMjcxNzcuNjMzMDUyXVtUMjU4NTQwOV0gUkFYOiAwMDAwMDAwMDAwMDAwMDZkIFJCWDog
ZmYxMTAwMDM0NGIxMTljMCBSQ1g6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsyNzE3Ny42NDQwNTld
W1QyNTg1NDA5XSBSRFg6IDAwMDAwMDAwMDAwMDAwNmQgUlNJOiAwMDAwMDAwMDAwMDAwMDA4IFJE
STpmZmUyMWMwMDZlZmQwZjQwDQo+ID4gWzI3MTc3LjY1NTAzMF1bVDI1ODU0MDldIFJCUDogZmYx
MTAwMDJlMDUwOWY3OCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OmZmZTIxYzAwNmVmZDBmMDgN
Cj4gPiBbMjcxNzcuNjY1OTkyXVtUMjU4NTQwOV0gUjEwOiBmZjExMDAwMzc3ZTg3ODQ3IFIxMTog
MDAwMDAwMDAwMDAwMDAwMCBSMTI6ZmYxMTAwMDIzOTBjZDljMA0KPiA+IFsyNzE3Ny42NzY5NjRd
W1QyNTg1NDA5XSBSMTM6IGZmMTEwMDAzNDRiMTE5YzAgUjE0OiBmZjExMDAwMmUwNTA4MDAwIFIx
NTpkZmZmZmMwMDAwMDAwMDAwDQo+ID4gWzI3MTc3LjY4NzkzOF1bVDI1ODU0MDldIEZTOiAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZjExMDAwZmVjODgwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDANCj4gPiBbMjcxNzcuNzAwMDA2XVtUMjU4NTQwOV0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiA+IFsyNzE3Ny43MDk0MzFdW1Qy
NTg1NDA5XSBDUjI6IDAwMDA3ZjA2YmM3YjE5NzggQ1IzOiAwMDAwMDAxMDIxZTg2MDA1IENSNDow
MDAwMDAwMDAwNzcxZWYwDQo+ID4gWzI3MTc3LjcyMDQwMl1bVDI1ODU0MDldIERSMDogMDAwMDAw
MDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOjAwMDAwMDAwMDAwMDAwMDANCj4g
PiBbMjcxNzcuNzMxMzM3XVtUMjU4NTQwOV0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAw
MDAwMDBmZmZlMGZmMCBEUjc6MDAwMDAwMDAwMDAwMDQwMA0KPiA+IFsyNzE3Ny43NDIyNTJdW1Qy
NTg1NDA5XSBQS1JVOiA1NTU1NTU1NA0KPiA+IFsyNzE3Ny43NDgyMDddW1QyNTg1NDA5XSBDYWxs
IFRyYWNlOg0KPiA+IFsyNzE3Ny43NTM4NTBdW1QyNTg1NDA5XSAgPFRBU0s+DQo+ID4gWzI3MTc3
Ljc1OTEwM11bVDI1ODU0MDldICA/IF9fZGllX2JvZHkuY29sZCsweDE5LzB4MjcNCj4gPiBbMjcx
NzcuNzY2NDA1XVtUMjU4NTQwOV0gID8gZGllKzB4MmUvMHg1MA0KPiA+IFsyNzE3Ny43NzI0OThd
W1QyNTg1NDA5XSAgPyBkb190cmFwKzB4MWVhLzB4MmQwDQo+ID4gWzI3MTc3Ljc3OTEzOV1bVDI1
ODU0MDldICA/IF9fbGlzdF9kZWxfZW50cnlfdmFsaWRfb3JfcmVwb3J0LmNvbGQrMHg3MC8weDcy
DQo+ID4gWzI3MTc3Ljc4ODUxOF1bVDI1ODU0MDldICA/IGRvX2Vycm9yX3RyYXArMHhhMy8weDE2
MA0KPiA+IFsyNzE3Ny43OTU2NDldW1QyNTg1NDA5XSAgPyBfX2xpc3RfZGVsX2VudHJ5X3ZhbGlk
X29yX3JlcG9ydC5jb2xkKzB4NzAvMHg3Mg0KPiA+IFsyNzE3Ny44MDUwNDVdW1QyNTg1NDA5XSAg
PyBoYW5kbGVfaW52YWxpZF9vcCsweDJjLzB4NDANCj4gPiBbMjcxNzcuODEyMDIyXVtUMjU4NTQw
OV0gID8gX19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQuY29sZCsweDcwLzB4NzINCj4g
PiBbMjcxNzcuODIwOTQ3XVtUMjU4NTQwOV0gID8gZXhjX2ludmFsaWRfb3ArMHgyZC8weDQwDQo+
ID4gWzI3MTc3LjgyNzYwOF1bVDI1ODU0MDldICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDFhLzB4
MjANCj4gPiBbMjcxNzcuODM0NjM3XVtUMjU4NTQwOV0gID8gX19saXN0X2RlbF9lbnRyeV92YWxp
ZF9vcl9yZXBvcnQuY29sZCsweDcwLzB4NzINCj4gPiBbMjcxNzcuODQzNTE5XVtUMjU4NTQwOV0g
IGJ0cmZzX2RlbGV0ZV91bnVzZWRfYmdzKzB4M2Q5LzB4MTRjMCBbYnRyZnNdDQo+ID4NCj4gPiBU
aGVyZSBpcyBhIHNpbWlsYXIgcmV0cnlfbGlzdCBjb2RlIGluIGJ0cmZzX2RlbGV0ZV91bnVzZWRf
YmdzKCksIGJ1dCBpdCBpcw0KPiA+IHNhZmUsIEFGQUlDLiBTaW5jZSB0aGUgYmxvY2sgZ3JvdXAg
d2FzIGluIHRoZSB1bnVzZWQgbGlzdCwgdGhlIHVzZWQgYnl0ZXMNCj4gPiBzaG91bGQgYmUgMCB3
aGVuIGl0IHdhcyBhZGRlZCB0byB0aGUgdW51c2VkIGxpc3QuIFRoZW4sIGl0IGNoZWNrcw0KPiA+
IGJsb2NrX2dyb3VwLT57dXNlZCxyZXNlcmV2ZWQscGlubmVkfSBhcmUgc3RpbGwgMCB1bmRlciB0
aGUNCj4gPiBibG9ja19ncm91cC0+bG9jay4gU28sIHRoZXkgc2hvdWxkIGJlIHN0aWxsIGVsaWdp
YmxlIGZvciB0aGUgdW51c2VkIGxpc3QsDQo+ID4gbm90IHRoZSByZWNsYWltIGxpc3QuDQo+IA0K
PiBUaGUgcmVhc29uIGl0IGlzIHNhZmUgdGhlcmUgaXQncyBiZWNhdXNlIGJlY2F1c2Ugd2UncmUg
aG9sZGluZw0KPiBzcGFjZV9pbmZvLT5ncm91cHNfc2VtIGluIHdyaXRlIG1vZGUuDQo+IA0KPiBU
aGF0IG1lYW5zIG5vIG90aGVyIHRhc2sgY2FuIGFsbG9jYXRlIGZyb20gdGhlIGJsb2NrIGdyb3Vw
LCBzbyB3aGlsZQ0KPiB3ZSBhcmUgYXQgZGVsZXRlZF91bnVzZWRfYmdzKCkNCj4gaXQncyBub3Qg
cG9zc2libGUgZm9yIG90aGVyIHRhc2tzIHRvIGFsbG9jYXRlIGFuZCBkZWFsbG9jYXRlIGV4dGVu
dHMNCj4gZnJvbSB0aGUgYmxvY2sgZ3JvdXAsDQo+IHNvIGl0IGNhbid0IGJlIGFkZGVkIHRvIHRo
ZSB1bnVzZWQgbGlzdCBvciB0aGUgcmVjbGFpbSBsaXN0IGJ5IGFueW9uZSBlbHNlLg0KDQpUaGFu
ayB5b3UgZm9yIHRoZSBkZXNjcmlwdGlvbi4gTWF5IEkgaW5jb3Jwb3JhdGUgdGhpcyB0byB0aGUg
Y29tbWl0IGxvZz8NCg0KPiANCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBTaGluaWNoaXJvIEthd2Fz
YWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm4gPEpvaGFubmVzLlRodW1zaGlybkB3ZGMuY29tPg0KPiA+IEZpeGVzOiA0
ZWI0ZTg1YzRmODEgKCJidHJmczogcmV0cnkgYmxvY2sgZ3JvdXAgcmVjbGFpbSB3aXRob3V0IGlu
ZmluaXRlIGxvb3AiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5h
b3RhQHdkYy5jb20+DQo+IA0KPiBUaGUgY2hhbmdlIGxvb2tzIGdvb2QuDQo+IEkgd291bGQgaG93
ZXZlciBtYWtlIHRoZSBzdWJqZWN0IGxlc3MgZ2VuZXJpYywgbWF5YmUgc29tZXRoaW5nIGxpa2U6
DQo+IA0KPiAiYnRyZnM6IGZpeCBhZGRpbmcgYmxvY2sgZ3JvdXAgdG8gYSByZWNsYWltIGxpc3Qg
YW5kIHRoZSB1bnVzZWQgbGlzdA0KPiBkdXJpbmcgcmVjbGFpbSINCg0KU3VyZS4NCg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEZpbGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gPiAt
LS0NCj4gPiAgZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyB8IDEzICsrKysrKysrKysrLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyBiL2ZzL2J0cmZzL2Jsb2NrLWdy
b3VwLmMNCj4gPiBpbmRleCA3Y2RlNDBmZTZhNTAuLjQ5ODQ0MmQwYzIxNiAxMDA2NDQNCj4gPiAt
LS0gYS9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+ID4gKysrIGIvZnMvYnRyZnMvYmxvY2stZ3Jv
dXAuYw0KPiA+IEBAIC0xOTQ1LDggKzE5NDUsMTcgQEAgdm9pZCBidHJmc19yZWNsYWltX2Jnc193
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiAgbmV4dDoNCj4gPiAgICAgICAgICAg
ICAgICAgaWYgKHJldCAmJiAhUkVBRF9PTkNFKHNwYWNlX2luZm8tPnBlcmlvZGljX3JlY2xhaW0p
KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgLyogUmVmY291bnQgaGVsZCBieSB0aGUg
cmVjbGFpbV9iZ3MgbGlzdCBhZnRlciBzcGxpY2UuICovDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgYnRyZnNfZ2V0X2Jsb2NrX2dyb3VwKGJnKTsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBsaXN0X2FkZF90YWlsKCZiZy0+YmdfbGlzdCwgJnJldHJ5X2xpc3QpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmZnNfaW5mby0+dW51c2VkX2Jnc19sb2NrKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqIFRoaXMgYmxvY2sgZ3JvdXAgbWlnaHQgYmUgYWRkZWQgdG8gdGhlIHVudXNlZCBsaXN0
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICogZHVyaW5nIHRoZSBhYm92ZSBwcm9jZXNz
LiBNb3ZlIGl0IGJhY2sgdG8gdGhlDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICogcmVj
bGFpbSBsaXN0IG90aGVyd2lzZS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobGlzdF9lbXB0eSgmYmctPmJnX2xpc3QpKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19nZXRfYmxvY2tfZ3Jv
dXAoYmcpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFp
bCgmYmctPmJnX2xpc3QsICZyZXRyeV9saXN0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICB9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnVu
dXNlZF9iZ3NfbG9jayk7DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAg
ICAgYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKGJnKTsNCj4gPg0KPiA+IC0tDQo+ID4gMi40NS4yDQo+
ID4NCj4gPg==

