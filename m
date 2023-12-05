Return-Path: <linux-btrfs+bounces-655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE0805B08
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8AD281E61
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185559E56;
	Tue,  5 Dec 2023 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MT4+yefz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Tv9/A7xs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C01BD;
	Tue,  5 Dec 2023 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701796740; x=1733332740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=haAsT9/BIwuCt6JT8pshBaxWxrgc3ugKJSFNYKDikvU=;
  b=MT4+yefzz/m8Dzr7owgDkwqQ55iPnNT/Hnc5iTiTKFctgmK5KBcHsEiB
   S3XY7v8Dr5r4828PJBWfLWTi+1jLQIYJlMP4uXQ4Cn4s8uBO2LhU8dzCC
   3JmMo8IGGvDdZHG9hjySV7S2/q1mtozuzwyY86G3bfVZ4k9BGlUuKDqhd
   KlINF7oMDYJLqfPO5jGQmDkamr2gXZQTdu7oDRfOxPMBXPSsugOTU21RV
   OBsiBHyWcfYPW/fsrfDkYciLO0pD7/PldPjmyLJsCFvqN4k4RCa9JmZrb
   bXzg6qcMFYqGHxX5L1H2n13hV92MMDDCkRtheY3oLlo3D2RH5f3/a7j9q
   g==;
X-CSE-ConnectionGUID: F+oNzAcvRja3CZQt0n7vPw==
X-CSE-MsgGUID: C/b00T8HTiyZCeKWwX722g==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043613"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 01:18:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNuTRBJbhaTSGpxOA2yKwXOAF4OUAxpygc/D20tV++wjQzK8qnOiswumnG0TTUQtuJ4FHRveNO20Agtwe7cdbJ+ebd2Ea90zRfHKhKqCqhq4cmWlMdyFi7av5nz0vhk2zzPqshUxify/8z5BPxBB2sRSVcXXMQF9yjnngF9IDFMD7ucq8KSTSoOTGbBI3CvAik7hz0Z0AA9xHjQ9m0Kkhl7XqviDnMyxGrueEL8rh11ioqdXT+hC11N3YbXc1fdgIp1mKuSXhlT8P8vmI/GWJN4t2DuS3nRdCvs8Eohocumbk8ExUs2oJUUmVOSwciCJAJVA3n49+y/1ekH9qaVKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haAsT9/BIwuCt6JT8pshBaxWxrgc3ugKJSFNYKDikvU=;
 b=hiKi7IdvRbm+AAr19Pfe4qER2Vm183zxIeBHSnBhWsgs9VbE4XZIBQdk+tjvnuIbn/pZMYXMQxI9GH8ZC6XGXCTqenFNRSEr0AniC6PPA+Dbysn226tffwxAJ3MIWIQyHfJlutRFAoH9vTp4U00XKX0IJ+jgHYSMdabbbcal6+4rYlrjQQO1tNSzkXCVjICLuS6cr/bjr1E52ALUJi0FeRm6mHmPd+T0C/RLwQxhJAU+epJmjZgNBZwIiyGMObB4xXYI/NVT+Wa+vo+zuS1SrgfEF7GiBhfVJM9fWKCNQAj9z5XGh3tXRh2iI7JULoaxdIZ/hdk1cXJSkoY6bDJF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haAsT9/BIwuCt6JT8pshBaxWxrgc3ugKJSFNYKDikvU=;
 b=Tv9/A7xsrGUrImF/Y8ASEPpOwsWomT3Aj6AL9xr621MbzoH4Piak79aq/6SGzjMHJQlrkEQdRtE+TV5HWxdqltGb3ygNtOY2gGt42fKAnU6YGBEzxCEJUH9/iBb6X1wlFaUkZSkbvtXfXjXxPmEcHJIh13pGGi/NnxJR1u7KC4w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8499.namprd04.prod.outlook.com (2603:10b6:806:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:18:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:18:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, Filipe
 Manana <fdmanana@suse.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with 4k
 write
Thread-Topic: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with
 4k write
Thread-Index: AQHaJ3jp4tja0Ok3sk24VFnrCwf3i7Ca7VmAgAAB94A=
Date: Tue, 5 Dec 2023 17:18:57 +0000
Message-ID: <dc1aeaf6-ec9d-4035-b61d-7b1d38189830@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
 <20231205-btrfs-raid-v2-3-25f80eea345b@wdc.com>
 <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8499:EE_
x-ms-office365-filtering-correlation-id: 0572ce77-e82d-49fb-0243-08dbf5b64401
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gs/V05YAt4o16fdXYDFBAMs1r6XdZqCZ931OPwkR2w6IaMO6lBVeQreAHG+v8oN64cyY4Xr0CYXipzymSHeR/ZpdJpBym1VFS2JgiPsKZD47bO/DRT7i7LIfR1V2lwyHIjoPC0+1mLGRJBqCoxFEN/MyeYw1wqoAeG3j0XaHQUUtASeAonhRWtrzOfSUSKTAptgta6htISDF7fYhQ/954PeldD6b0x6hzyNuTia2NoZicZ9Lhae6Ds3iwa7NRcfLvvYBBQE+SukdBQPyN8s+e7Lpm4VsN72Ij9ItZakmsAUCHdaGBEBERy/PLF9+5GEfq3NtKD8uF0hMqjKd6WCZS6xJEmHEmXhp6B1zaw4IQysx3db35M8oWPL+WRYcHCqSeIBAfbRgKFMJar1u5Hm6ZeQ8BBC50Z/V0a+RRwkKSAIwHPwXqDzrUqB3aWnUW7pl6V/wRnvGWjdBOVs92N/Un206p7vqBWl55I87PajU+78x4GXWJaTGwel7V6X/XpxCZI+e2L5C1FSemP7n8qgaVBbjH3ZmKFFuTv8e3I89IF/aAmoGLrFIQOcXjIacfrIUTU6gw5a36RcN/fsfJF0I/49cNI0yC1rt14oS8VDu242IRIBi8XBDH/vrNEAsPkaYrJaVbTy+uw0d+ehcwuwfRAVKv3f4dSWSEvCTGZHLDB18UuwllX0RNkpYJoCx2t7a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31696002)(82960400001)(2906002)(5660300002)(4744005)(36756003)(38070700009)(86362001)(41300700001)(6506007)(71200400001)(478600001)(6486002)(6512007)(53546011)(38100700002)(122000001)(26005)(2616005)(31686004)(8676002)(4326008)(6916009)(8936002)(76116006)(66946007)(66556008)(66476007)(66446008)(91956017)(54906003)(64756008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWUxbTM2M2xvbU1vME85MmRxUldpMDZVYVB3Uzk3bENsTjI5NXdzTmk1VzZv?=
 =?utf-8?B?cTg3aER2VVpLUkJ3ZHVVR2F6S054UGpzWGZqaXJzYTMvTGd4WTllSW5IRVJq?=
 =?utf-8?B?TFQrZ242aVJhUXFwZm5LcW85dTYvTU5PRnBDV3RPOTZvSC9sakJzdGtVWEkv?=
 =?utf-8?B?NURESVBuY1plZnpLbHUySVlxVFoyZ0JxSFR2M3JLWFFWZUg1bXA5L1lQdlYw?=
 =?utf-8?B?MktNR2QvNTVUVkY5dzIzeXF6ZXhDRlVYUWZkeFAwZ2d4dnVxNm1GS21SRk1w?=
 =?utf-8?B?YkZCNmJmNEtYdmRUNCtxeVpNVC95dGVhK3NKc0lOanV5Uk15Z3pCZjFzYU1h?=
 =?utf-8?B?QXlnbkRmS2hSY2ZVS29DeDNuRi9hbGNmQ2J3Qm16OUd5S05nbUp6WmtUdHBC?=
 =?utf-8?B?am51Z0xpcXQwQ3lFTGZNS2xEVldjVHZSQ2o0cTd0bm9EMkZqSUZmV2cwNjVo?=
 =?utf-8?B?Wk1VMFh1bEtFQy9NN2pObXg1YW9hbGR5V2M5QWZSSStHQ1ZLS1IrcEtxUTNY?=
 =?utf-8?B?NmVxRVhrUituRjA3Qm1NNE8yVnVpVUtQNWhuRld1c2dtVVpwaERubWJES3BN?=
 =?utf-8?B?TUx5VTdUb2wzOS9ETndQSW1SRm9Sa3VvR3JoZ0pCd2NnRmlGbWR6MnhOaVNk?=
 =?utf-8?B?S0xGYXNuNmc1eXdmZXVVY1ZtL1dUOTB3QnV6S0FTeW8wVlJsRkZhVXRMWDRs?=
 =?utf-8?B?dGhVdmxzTUhhMG95YkFPT2JzczNjeGdRVzkxTVZ1SDNVUStUd0xWRXZsVERv?=
 =?utf-8?B?RlE2bWJjTDZJRXYvRHJyejZVR2ZzVGh6RHpKWFllNENwMWtkTG1neVZmczFk?=
 =?utf-8?B?SEh0RTNUTmFnVXgwbkNoN0hNZXpPOXBidEExSWR6WXhRdDJhQWl2bmcrWXVY?=
 =?utf-8?B?TXJjQys1YU1iUjUrSUZXZWMwQXZTQ01ZWTBjSFdKWVV2dDBRZ0plUHhPcjhN?=
 =?utf-8?B?anZZTUdHeVFrUXlvUFJvWTlUK0VWRkJWbVV4ZVZnMTlLWUlxcGx1Y3RQZUdC?=
 =?utf-8?B?c3hlbFZXMGlidlFjY2tRcDlEZzRqajVrNEhESTBRcEdNelpzdjBrT2Q5NUYv?=
 =?utf-8?B?amtIUEg3Kzg0NGY5OVFVTnVldWpjSXFXaUFEby9kUkhEMGRmS0NoTjQ0MGg3?=
 =?utf-8?B?YncrM2M3SUNES3VZQ3JNN1k1bUd5ZFZ3dXNnM0hBczBTVFgzYmdnanZxVUdF?=
 =?utf-8?B?M011emdaYVhVV3l4cEw0NzlkWXlmTVByQWVRVFZ1ekxaWmZxckdSUWxpd0g2?=
 =?utf-8?B?YmYwY25tOVQ1N2FJNXRJSmZtTElpbmhLbG0rcXZlMVlmRVdtc1pJZVR5U0Jq?=
 =?utf-8?B?Rm5Ib3MxMzlHbGdGTTYyTzc5RnJodi9wWDJXNlg5ZnBOTWQ2Mm41MkFjME44?=
 =?utf-8?B?bEtibW1MandFZ09lV2hzUFZwa3lXNzlYNlRjVUhKTHhOank2R2ZkcitYVTZy?=
 =?utf-8?B?Q25HOTN0VUxZTUNwMld1SjdtSHhrQkVMdGNHQXlUU2w2bzgxSHlRT0xtVVpp?=
 =?utf-8?B?RUd2WGhuKzR1Zm5rTHo3SHU4enZJYzZTOFA4NGV4clJTTjExZTBqenZwRFhH?=
 =?utf-8?B?MisxeUQ4STBraHpTV1lHaVIwYVJMUDNrak5IYW1oeFFjSi9SZGxLSWtGQmp6?=
 =?utf-8?B?LzFuZUdRTUw5aS9OWWZMelpjVFMrQTN5enhheS9jNzV4eGVLZnIzdEN4cnAz?=
 =?utf-8?B?ekRHQWZBV0VnZzVvYU85c0VaUjdZVGg3SmVzVitrMUFlVEc3NTJPT0h2SlZX?=
 =?utf-8?B?VmpRQ2FTZ09FMC9MTHhyS1I5SWNTWG02eTlMazUyVTlxWHl6MU9MT3Yrcmhn?=
 =?utf-8?B?M0djek9uZlMwb0dSTkNmazQycXdhc0lNb1dxRzcwN0FrWEpzOTJnUjZtZXNx?=
 =?utf-8?B?eE02cEwrY3Q4b2VTeVZ3QUpFNEhtc1hEeWt6aVNaanQxaDFMRUxaTUJvWkd6?=
 =?utf-8?B?aSt3dXJtWFNsNkdSOU1LcEJzVEdaQjZKSWZiMVQ0WWZ0V0xzQjZIMmpmTWkx?=
 =?utf-8?B?akI3WXQ4NG1Qc25jT1poR2pMRGI2cGFhRlBmbUtnVlMvd1Z1eW5uNEJrSEts?=
 =?utf-8?B?L2w0QWtRbWlOdDl6L3RuZlN3T0s1bmhmVnpnVWlDM2FEU3RRb3Y1Zy9rUEtl?=
 =?utf-8?B?Qy9OY3IxanVuVDBVYXdwZUUxT1VqZHBudDlidXRtT2NTcHJ0TGdIdW5tOWtu?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E48D68C68BE7684EB759C33166DB0508@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GlCM/PDVU+z/rpCRoAsS9ldbmwHFgXUA5Vqw3KUz7wPkr1u1JO/HFQBQRcOAXlCt41ptfQT8UbbbTSD6t8QkMw+PCRa3S4QUbH/fFhRu71oIwC7JRpuRiQTDWns2I7425nUCJZvtplS/h10BHlh9kYKCJMgPB5SRspE6JRIMjqahwTOS60DWjvLZGwo9fKYND8Bje7dIRdrp/YcaYyveGNjO4Nv65o8/95VqdwZRcyw8FM3i7hP/ziMau2nWKTQRvwr0yFsos++r1r0QOZcou8gmavnyCjKKWPoB+s6mnwoU1EtsyL8nG/zRA3zSxgsf4D7+fNoUSh2l7GurArMJ6k3UcBOsH3JnjFqnKIwikqKVQtMUtYs41yai6mQ+v/na+V4HP28zl4txAeXVWEMXwklFI5lO22NO1LcVkDR0LrZQEslCdrMFvBFil+tTqS94IZ3Qxb9V3H/KQmv82xjuHdQoncHk+Zuco0gg0ONJiRTyMUIBO91XGgwK9vpBIuWmXyBuEiSGQOJd5U7eIsV1weUeyyhTT3EEFAVAnyuuWs+qGvIzbpkrlvsy+YUjUmz+WiGVgT5XRfpQsA6ScS6VLhDt3WkgkiYVjZy3wxfxoz0jlTDUhxflpkEVeDHlGRwSWAsWgJwlsmIOI9KXLtk9BT4BFuJFIRk7/GzusRqqu4yE1QDc7/amVA8SSuM3mp9woIPIWDpQoYTzUUaUIjt9/uRAIeVNE+erEXFhE7tcMsrdv5SYvOAj/IFnrrCXnugR8OUP9wHeL9yOn6ETYJ01xS4/k9ktvHYqoddBMJXGh5fg9iZp6pvD6sdnhQv3QcgIu1VxPEH1czQInsOiSeYIB+EZIxFuTAGhYJa48oO/Kw4rzuCvJ0rY3J0aFsE3YirWsP3teeQtZWSp50mxLM+y6A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0572ce77-e82d-49fb-0243-08dbf5b64401
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 17:18:57.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruQYpZjevrGf7CnFc5vx/Zg7g5kMD+YjuA2SClSjMzDXJX6S9lBxS2LdWitV50zxrdzO4Fj2wNH5sJ7/dRkXVnR6jYUT4Q7IMMYjnTUte84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8499

T24gMDUuMTIuMjMgMTg6MTIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDUs
IDIwMjMgYXQgMTI6NDXigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToNCj4+DQo+PiBUZXN0IGEgc2ltcGxlIDRrIHdyaXRlIG9uIGFs
bCBSQUlEIHByb2ZpbGVzIGN1cnJlbnRseSBzdXBwb3J0ZWQgd2l0aCB0aGUNCj4+IHJhaWQtc3Ry
aXBlLXRyZWUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQpbLi4uXQ0KDQo+IA0KPiANCj4gQW55IGlkZWlh
cz8NCj4gDQoNCk9oIGZvciBub24tem9uZWQgZHJpdmVzLCB5b3UgZG8gYWN0dWFsbHkgbmVlZCAi
LU8gcmFpZC1zdHJpcGUtdHJlZSIgDQphZGRlZCB0byBta2ZzLiBXaWxsIGZpeCB0aGlzIEFTQVAs
IHNvIGl0IGNhbiBiZSBydW4gb24gbm9uLXpvbmVkIGFzIHdlbGwuDQoNCg==

