Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E668E61F77E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKGPXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiKGPXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 10:23:05 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342D1EC71
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667834584; x=1699370584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kGwB058aRkGIT8V8TnAe+cYruH8Vv/VTl43Bcd6V9NE=;
  b=P3e6JaGp+h3EqX+qleRyHdh275HTwRM33NOC64TghEi0C9ierfu5f5nh
   +Ah5hJi17gZnDJGu9WvtLLkSru0jo64p0IiP4fqH7o7o2CsLHMBIy4zOm
   /ePJEB+ycdDj0M4wKhYMvcaPTUwEMejg77YQkKnvqJ5igXqCA50npINJJ
   dNjFAHNmqVeuVzan2BRgfBYIVszcsjaHhv27cnXJhRfBc+U9jaZkAz477
   g3udze+9EwSzwa87byg/DbT1reD0i4AAVafFJbjs1Rb9UsXctHaRJQDIA
   ynTPBkRiJ4jgexB/2keMgIjfIIgdhejwpbTOR+lV33n8NgXk1du1Ti7j3
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="216014123"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 23:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnPo5jZMI0zpDuHqKRSwGh8p95kZ10CebROZfV/oI8Bzzy7rrNvKH9iDFHGgi7ilz0YXH0X66/gNqOzCBY319toMqgx3iT5LGDu4mWQRFt6ctdNjr1N7gnLGLbwXqwoxTD+MHUn3Tt6e8G1QWZ/uXGRogAbSnsBKx+w6MgMzXRBmFVF9NmvJWRPT5/ZExZZxaiNK9wPeiLXOFOAT8iALbwjso4ZoxbRQQyUQwXMpMHk3TVJdeYw+Rpftv9jFlk6zFAmmA7KYc8UAxVya3Htjbgv1KTbSD3/U3r26kE5jGInStXsFoXpv47mIrUzxV+dI13pf4Y/BDSjDxv7xhPbEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGwB058aRkGIT8V8TnAe+cYruH8Vv/VTl43Bcd6V9NE=;
 b=Q9kLmO4hkw1X9Q/vLn4YR3IO9Kpkx59X7UPbVzCb+MDl2O1lT2acdwQ2YIofbe22jzVqw6bRzEf5GQWzqZERddmCJD1UijpOvS/TFuMyRZcCXWIwrRubfy09ktqofhhRPX7UXIKa9Vn7IhSmZUW8PZDfXe1KwBrSZS2X4W8ZA+JoY0ikoTqYzdQzY3pOuiyjpxRbPwe0yMozHx/bb8Kb7wo+Tw0PTvlBivY16n63nDMGtwU5zs6zCk8Df3lhTvX5B2jRb0KoHDaO7f3pxAj4K4zf8EcxzpyFfjnGlBaAmbRNGNw8NerGYZkIxT+fR0rKH7r93Lnbyx1BcGjiT8GukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGwB058aRkGIT8V8TnAe+cYruH8Vv/VTl43Bcd6V9NE=;
 b=L7gMPbSSnaXl4jBERqi+PWfxL+9TJ8e8ZIPLxLwnhPyCs8dw5b9PxsZ6skdC/Q9afFSrCUWxg0G3S2pXZ+2UjuUywTgI7OW2N+g0SDyChg/BrlShWHNrlND6spKQsQJN9XeU1j2gR5KDnZ+2n0nDD2g174vx/EQgCmmBm3aiFGc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5191.namprd04.prod.outlook.com (2603:10b6:a03:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 15:23:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 15:23:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: zoned: clone zoned device info when cloning a
 device
Thread-Topic: [PATCH 1/3] btrfs: zoned: clone zoned device info when cloning a
 device
Thread-Index: AQHY8FeE2elHX5ExHEuwTUwFqzo6R64zl1KAgAABowA=
Date:   Mon, 7 Nov 2022 15:23:00 +0000
Message-ID: <6a3d155c-8214-c5c5-ec7f-0530be6110e8@wdc.com>
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
 <af4caecf1d6fac27654cfd47b72eea865cdcbf61.1667571005.git.johannes.thumshirn@wdc.com>
 <20221107151708.hddbm4gqxucdwtro@naota-xeon>
In-Reply-To: <20221107151708.hddbm4gqxucdwtro@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB5191:EE_
x-ms-office365-filtering-correlation-id: 988a77c3-5e4a-4101-d341-08dac0d3f533
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /98PNi2Mxg7sBSz6T1AqM+8/t+yxrIsQY0L8cGwgCpQWkq7F2TTduAVqyKjAOkQN1BOoyhyQuIjnCd62GX8jWozYsMo+d9LQey0K4sCiagVr1ga6vvn5UsfO4iNKuH1Wwl8Hz1kz+Vh9N2Rg0ieN03cQm7VnbB7N+lzJpg3M1OeNTr/A4kJ+0ADTvBX9gjMdRMXzlRvjy7PSGkSkv4YJGnLpGbwkZSI5GsofTx9ytvd4LMzegXhGkBG0NKcEgzE/h7orMvpJkgW4InnL/sgiDHQavYQ8QEEunofcdockXYdanSJPWYQq3XjDYfrpjjzO+A76cd2U7+a7iEiLxyMrQJ7PLXMCeDyra24W/yfeKoPg9uBBkZWTTDFmcTEf8GFCSMMByFsG0R/nxjCcLAti75poSy9i7scYaEUY6hNmpDjO8YfyNSqwRfpme+yY4uuUWYTruDpsBS5wLeIB+5sHV4+aGL4eZSRZCtuvUpQNGDf+6+kS85iV2iLv0ER7PEA+FX9HsXXXiDX0rkE60XAQa8JoVuZJDreI4Ae5TnKFWURIrdItKU55m+bxjw+X3pWtpoopNYlLDy4NdXPPtyH92tY/2BGrRvE1qLaxK/DhBRHRFOD65pqG7P0HRjFZbwNV+ABRxrBV7DAQ1f4yMrCmBnfMRGC0UgJP+tNNKZvwC/INQkxq1IbdULemYvm8pZbkgS/vMd4CJ7+ej7Ee82jOeWIV1HnhRAWEmHukQORgEmfc1iFnjgsd/QVWxtjlK5j+fv4DOLhY/4q7BItzceNHgoBc5brw3YNi0J+nYB3IOlyXVvUjnCd4pgEj23PSnPotgdn0aLV6uE9h+Z2Ggwg/WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(186003)(2616005)(6486002)(2906002)(37006003)(316002)(6512007)(6506007)(54906003)(6636002)(36756003)(53546011)(478600001)(38100700002)(122000001)(82960400001)(71200400001)(38070700005)(86362001)(31696002)(83380400001)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(91956017)(4326008)(8676002)(31686004)(6862004)(5660300002)(8936002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZQaFJyS2JzOCs2ckt4MEJNV1BNM1RqdWl4eDdRc2pzTXF4bHFIY3JYdkwz?=
 =?utf-8?B?Q21kbHFudnpab3FyZ24rY1p5SGVOVHkrdzJoSlJ5THBpYkdPWG5QMkJacXNV?=
 =?utf-8?B?b2IxNjFMeGF2eVpTRGtZeFJZM3R0RnNBMDk4ekY0dU56RFJ5ek5BQkFXUjMz?=
 =?utf-8?B?dDhaNStPQzZNWlFFeE9nYlAxeHpKVnJxbUhLazk1RlRWbkQ4TUVhNC9pRklk?=
 =?utf-8?B?dy9lUFk2NEVuTjNEQThGOFRuVVBDUUtHWmFSU2dBZzJpa092WEZLdGI1TE0r?=
 =?utf-8?B?bFBneGtSVDlTNGxINGpqeUZQeHpkWC9KcE9WWnQ0a1oxY2tKelp3cHEyMjdN?=
 =?utf-8?B?K1VOQlhKUDdDZVZ6M0N0T1NMT3NESm9WejZpTGFFbXdYT0oxM0ExTWRrSGFr?=
 =?utf-8?B?MWdVT3FDYnRnMUJQa3U3blRvODdYekh0VEg2RkFPcHlxSkw2VlBsc2p6NUtW?=
 =?utf-8?B?N3J4cVMyM21qODlyRXFQWlpVZTBJSDkzd2FIbXlrbHg3L3VxL0ZZOW0ydUUy?=
 =?utf-8?B?OGFOdlJMSUVKQngwejdONU91d1BULytrRjhNSDNwV3YxMS8xNzkyamxaUnVv?=
 =?utf-8?B?WGVnOGd5ZWplWHBub293SUhGY0RhdWRoRVJoZllhQTBWb0FXN1lCSzN3RU1R?=
 =?utf-8?B?Z3Q4TEdWL0JVSEkzNTI2S1U4Qit4WlVaSE82YmFMYTczaG5TamowVlloN2JU?=
 =?utf-8?B?dFhmaWhSbk9FOVBOUVl3c1p0N1lhb2xDRlllaUtKRjUyZmtWMkxYbGhhL05t?=
 =?utf-8?B?RlJUWFVVWGJoNEFOZWZtMi9ZN1hMNlR6SDJWdHEwS1ZtVUgzYXpiZzFuUXBu?=
 =?utf-8?B?SEdxWFhoeGJoMW9wSkJVQ0x5di9LeEJMNHhQYVdYcitlZ0R3Z1VjNHBQdjc2?=
 =?utf-8?B?TnQ2bUZsaCtseURQTjI0VlgwcnMvWmFLRWRKUW9wMlFlZi9GeFlSd1MrZkF0?=
 =?utf-8?B?ME9hUEp0OGY4RUdsMm94K29ZbDFWWHQzN0hxNGFTQ2szSGhVdHl1NmdQUmJU?=
 =?utf-8?B?ZEM3TzlqS3B3VnByOUlydE5NY2NuK3hIRFBtYkU2NUVWZVJQWnRid01nb3I5?=
 =?utf-8?B?M1ZCUTJzTkgvd2pLZkU2bzdQcnR4ZXJ0SEdWRGdlQi9oSWZ3ZDZhc2hVam10?=
 =?utf-8?B?QVVHWUdIaEMxcUFtR2pFVW13R3oycklyalBLZWIrNGpMNy94K2RBYWR0dkd1?=
 =?utf-8?B?U2g4U2Y2NzA4amhPKzJXc0krRTBWak5mWkJIeERUbGVmMmlkelVkRWxLU1pT?=
 =?utf-8?B?WmRMNGU0c29idFJDbHFyRWhqYnlUTnhtOFl1Y2lTU2djQzNSWGUyTVVHMElq?=
 =?utf-8?B?RDdWS3pqckFhdTBLWnFZUnM1bGcwMk5EQWNleUcxemw4c3p6RjFqckNGYXE1?=
 =?utf-8?B?VXFwMnBaVSt1WWlDUytCZzJtSFpjOVdkSGo3dlRlMndwYyttcnpiQW1kSDYz?=
 =?utf-8?B?Z2FnS0l0dGc4N2hVV2ZiYUdSNU42NWFhenIxR0FJQ0lldnlkMzZKSldYMHZI?=
 =?utf-8?B?R1BZQkpBa0ZPOFJkdEp4bGR2V2tnYkFUMHlQZ1JNRVp0ZGRQTjQ4OGoxZ0dm?=
 =?utf-8?B?ekFnT25JRmxZT0pmNkxienNTWG1sczZKU2pzTEZDaTl6T1p6QkkzbmRYemNk?=
 =?utf-8?B?RnFpNFNlZzdtYWZiUWNXM2JXeHJON0crNmZmdjFxRDVwMU5vcXNxSnQyQmZ2?=
 =?utf-8?B?QkxyV0tiSDlBVjVzS2hyaEtZR1VOeFh5YkJLTGI4LytCQ05nYU1UUVNMVjAw?=
 =?utf-8?B?clFsQ1hGeERLZko4MnRxNnpzZlNsOHRtVmdYMFpPRXQ2WmJJeXlwRk8vd3Bo?=
 =?utf-8?B?TDRYeS9lSUFhVjdteWZJNVNRV3pySmNHaEZra1lmTjhtSWZYWi9xWkIxbGU0?=
 =?utf-8?B?c2h2K0JFTmNnZ2hpTG1sMDFRUnlyV1ZTYjZsN3ZONzgrL1pIeDBWSU9yZTNj?=
 =?utf-8?B?eWdDQ1Z1Q2NJMmRtdnNiOTczMHBFNWY4U2l4UzM4cHNrclUzdUVTMjBrcW52?=
 =?utf-8?B?dTBJM1pieFZBa2dEdk5wYXlWamNWeHRrZ25KRHBGMmZ6Q3pDSW5GZUlQQ01w?=
 =?utf-8?B?cFZVWnJaVm9uY3p3QjN1NGlISklkYmRnT2NvMkdHVTNPZUJxVnN4amVSZEM3?=
 =?utf-8?B?bWxscExyRlJUR3d3bm5CSjNEWXF3MjB2V1Jyc202RWM2RG1qWVNMc0tXeGhF?=
 =?utf-8?B?OVJQdkZ3VjBzSXJ5ZFpSVkVLTFp2eWdaZ09YNUxMc3M1TjJuT1NlNXpYelRr?=
 =?utf-8?Q?rt5Bt1uR3wnkEA0gc30Cp/aH/EfF6orTF38V14CG38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B7DC7D0E9747469CD12A4E4577F83B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988a77c3-5e4a-4101-d341-08dac0d3f533
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 15:23:01.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hr6asYDr50A0ucdaGVsEEy7ZqDTLLeY23i668y9xnXKWSMwlT9IZtxWNlB0RGflAsfXuIcRG2ptTW8rdsmQQwugnsQ++bRO9FMRQZXKxKiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDcuMTEuMjIgMTY6MTcsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gDQo+IEkgaGF2ZSBhIGNv
bmNlcm4gYWJvdXQgdGhpcyBmdW5jdGlvbi4gU2luY2UgdGhpcyBmdW5jdGlvbiBkdXBsaWNhdGVz
IHRoZQ0KPiB6b25lX2luZm8sIGl0IG1pZ2h0IGNhdXNlIGEgc3BsaXQtYnJhaW4gc3RhdGUgb2Yg
em9uZV9pbmZvLiBBY3R1YWxseSwgdGhhdA0KPiB3b24ndCBoYXBwZW4gYmVjYXVzZSB0aGUgY3Vy
cmVudCBjYWxsZXJzIGFyZSB0aGUgc2VlZGluZyBkZXZpY2UNCj4gZnVuY3Rpb25zLiBBbmQsIGFu
b3RoZXIgc29sdXRpb24sIHJlZmVyZW5jZSBjb3VudGluZyB0aGUgem9uZV9pbmZvLCBpcyBub3QN
Cj4gYW4gb3B0aW9uIGFzIGl0IGlzIG9ubHkgdXNlZCBmb3IgdGhlIHNlZWRpbmcgY2FzZS4NCj4g
DQo+IFNvLCB0aGlzIGZ1bmN0aW9uIGlzIHNhZmUgb25seSB3aGVuIGEgY2FsbGVyIGVuc3VyZXMg
cmVhZC1vbmx5IGFjY2VzcyB0bw0KPiB0aGUgY29waWVkIHpvbmVfaW5mby4gSSdkIGxpa2UgdG8g
aGF2ZSBhIGNvbW1lbnQgaGVyZSBzbyBmdXR1cmUgZGV2ZWxvcGVyDQo+IG5vdGljZXMgdGhlIHBy
b3BlciB1c2FnZS4NCg0KQnV0IGlzbid0IHRoaXMgdGhlIHNhbWUgZm9yIGFsbCBvdGhlciBmaWVs
ZHMgb2YgYnRyZnNfZGV2aWNlPyBHaXZlbiBpdCdzIA0Kb25seSBjYWxsZWQgYnkgY2xvbmVfZnNf
ZGV2aWNlcygpIHdoaWNoIGluIHR1cm4gaXMgb25seSBjYWxsZWQgYnkgZWl0aGVyDQpvcGVuX3Nl
ZWRfZGV2aWNlcygpIG9yIGJ0cmZzX2luaXRfc3Byb3V0KCkgaXQncyBhIHNhdmUgY29udGV4dC4N
Cg0KDQo=
