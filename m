Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F143076B5B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjHANXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHANXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:23:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3241982
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690896221; x=1722432221;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=kYnUsfjZfhY2NwnNDe5Sdp32gHAhBOaArXXoLGfz89D1yHHv4epY6/q4
   1XhOcIck6BH3LHXVjNL/0KJtRb3dI8Pm9ET8iBUx52k+rRfEhi681aAXL
   vA9cxnlZ+A1txN3J/B8m3rC7/3vFougbCdFfMV6aaOCgCnaH8k4D+MQRE
   5DFDzvxymZ7X/4jGkB8sLOmIDY63oGeKZMnOr0lNhgGgrt/F03CxwNzlB
   cAH6WZLfMnZcImmOQnuPvHx0yQdtZJngirP4jao12ElRSqZ35RqjlF0A3
   I4pBHBI+/DuI0G14bUSVMpbSgzKzIXVSQSqM7Q1lj0SqpcdcPfavjr4Ju
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="351781975"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 21:23:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCF45omx+Ssi6hoS/vOyk0AFvZng6ZSqA7w5hWzDiXDcscGyyezjkrsD7cFyNpaqShLiM9g8GpqaBcK2/xQvpWHpetjsexayEiXevtP9wnQ72JO1j0KbCaCrn3GTokYVucU4DgBUNwZmd2OWz9uLLWNjksa7mp8UNYXl3mZyU+3fXLVmfArS0UBG6MnTm8xcxx3TpJw2TLRs57kt0D4ZT3Mx+8eMnPl5BUT8Cw6M7dkXVwj9C3GmcfIaHK1rza9S5ipM1/wp9n5U5SuJWwHk6H+M8usVIXLii4jaAJVBJtkuuy1t0JiKDnZOwXeAx6RPIUkVc3PKhAw3lFPRuUeTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jROm+MBqNoVa7Qobnx9A+M49cY0MxXsUMAoGauJ/t1R0CkepUEfLFhjYJe0wuoFQLaDX0l6jwqrQ2IU5wkc+e5xkYAvDeUxAtkb0+c/B/ZMSu37EZvb8aLVYlo778MNDfVOjmqS4KjPaNmkLv/iYjJY9wK1oxoV/XL4KN8C+D7X/5Ul9k/QEs4Q+kZG037/4jin9TMR9Z2FYnmGjdHOM6Hit+LVL3bktPxMSSlRDAWU8nY0V6RO/cTftZOJMuV5Z7ajgRLuGQP8Zy/IInfzdFBx20cmJ177CEtN9Y6GXCa553QS7HJUA/FksAEll9kiTs4xkjoJojfoLAO9d26H67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZmnEV6UI0Fc8GkHXgoqz+b5R6kEbtmKeLzf8AKGvLGtxLJaIB0Vy6OsaG7q3bYuLpHWwEZsSlRlWGhKt/pMV/oCie2cEUhLqnGv3NjAmKADydhVQHKFNEe5b2c91w5aKfROCC0isP/er4vgSdWAZCf/2xnP3PNaQGbMAPHcopYo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7989.namprd04.prod.outlook.com (2603:10b6:8:f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 13:23:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:23:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/7] btrfs: fix metadata_uuid in btrfs_validate_super
Thread-Topic: [PATCH 4/7] btrfs: fix metadata_uuid in btrfs_validate_super
Thread-Index: AQHZw6C0/GxJ7dpmCkWqfwAncf6Ppq/Vb38A
Date:   Tue, 1 Aug 2023 13:23:37 +0000
Message-ID: <71811bf0-c22c-013f-6bf7-20c0c2d83301@wdc.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
 <35e2982c9d712253aff6d5c771ed6a3820a5090f.1690792823.git.anand.jain@oracle.com>
In-Reply-To: <35e2982c9d712253aff6d5c771ed6a3820a5090f.1690792823.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7989:EE_
x-ms-office365-filtering-correlation-id: e79d5df4-09e0-46d2-2688-08db9292839f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+08O7ID2gOQ7R4U43+p5MCMsWEGFsoI8VniAo1OjezT2Ttgb9WHA97EI5VhLmgNEK0nt8gzOhFk7sKQQUuPcZ4G31ja8DYvxd4vn+c70jn0eOuoZW3XGR6BzB+cq19O2WM/YPCFJn8q9GdNWY3OgLomP7rr7gwZ9955r2vzdDS8fgVE+kzWa7Vv0PDkfqIH6LYvK+aKdKyXrmVu0mUgMdcilaGDnLPBWqqlpbNa+/sWWxRtgfW6HZstqKmNlwfxmU5GlR1rtC4TQyiSbCHODd8fp7lUay7VUsc1O4yc1ohjDRz/BFGO5oSA7gXYk5IsaZk2fdpulTJr7/cBa+Fcsrf1soKNbRn+Ec7Qv1v3h9dSGIIdjuGigZLotMnnTzPPHdPwuh/Gdl4bbIG+st2s7fOffhrVAncZtDSOFEXs8xCqN3BqUovcMS2mZvI6HzcvBGnbXgBnspwHLzGof/1Pu4oZUzwWmB+iMpsgl/D4jUkPfgKF9bkcZIQNn6dlwsv1V3ogWOXla/gOkwZmE4ASH9NJPk06zrQ5K7Kntbw8iqmTq4KNv1/qv8AHETsNwrN1CVdVFgwooEd+F2YdFlCwyb67Q2NQBbNtCM1WYlxcRSri9p31gt6B0VFQkNVhnCGxXHEdcmOLP1soCm3fgh0UjJvWd8LHFWPxjLTTrBn2xplP0VB0w24rfPY7FbopMbLd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(91956017)(6512007)(71200400001)(31686004)(5660300002)(558084003)(186003)(4270600006)(66946007)(76116006)(66446008)(66556008)(66476007)(64756008)(478600001)(110136005)(6486002)(316002)(38070700005)(41300700001)(8936002)(8676002)(82960400001)(122000001)(26005)(38100700002)(31696002)(86362001)(6506007)(36756003)(2906002)(19618925003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFQ2NjlyK250TjlPUks2dUdHNERDSEh1UHZWdXFQaDE4RFoyYzkxVkxPazVK?=
 =?utf-8?B?L05aQTU2VVhsUFlGUk9TUHhPc1NFK2FVZ3U3SDZtZ0ZpNVoweWhONUVPNXBM?=
 =?utf-8?B?WW5NZHR2cDZmMGhTUm95UytBMFc4ZVZtTkNhNW9FdzJPanlOd25hSDBzSUpu?=
 =?utf-8?B?cjgwZWJmSTdwZStMSHVzK2RLangrTFdwbkFvWlk5Mno2b3FnU0hJZ3hQRjdY?=
 =?utf-8?B?bGxxQVI2NmYvRnh1SHlVZHJHMFAvaVpJdE1zaFcrY1o4anBXRGZrWmJGTEo2?=
 =?utf-8?B?UzQwT1gzZys5aEFtWVp6N05EM0g0VEUyY2o5MkdxZ3FuVzgxZHJ4YzBCaEVh?=
 =?utf-8?B?ejVnL0MvVUxnQUdPdlpkdXdBbHVuM09ZOTU0WGJScEpLVzFqcG9Qc29xUmhj?=
 =?utf-8?B?U0c1OFUrTGwxVWRlTlJBUExlL3phSXhxa3Jiak90MVBHaVoxQ3hld1BSSCsx?=
 =?utf-8?B?SDMzNWxvNDN0TkR2enF2TlNxRDBxbDJpUlArMUFCRWFWeFgwSEMrYjNzOEVD?=
 =?utf-8?B?ejJUd3o0ZTNLSjlhWG5mbVNsWjh1S09ZdjBnenhuR3lGZHZ6WW5ES0JScHUv?=
 =?utf-8?B?UTA0WkswYXhXTVkzRlgxbWoxbzNsSWtyVHdXR3RTTjNkMVFtdWU0YzA1amFq?=
 =?utf-8?B?ZTZEdlNObm90WnpkYUthRGtwTkFrTTZ0ZGU2SjdIckJQQ0lPVExCWFhXbWdQ?=
 =?utf-8?B?SGlSSEloWDd6VmhoaytEb1gxUDdzUWZtd1dXTlJaTkIwMFFqZk9rY3JYdi9m?=
 =?utf-8?B?Z1dOYXFXbUNQemhsY0lzWWlETWNlY0ExWnFiMzZxcTVwTXk4WGRqdVBmYUlH?=
 =?utf-8?B?cUozQkg5OWJKWnAxN0JnbHY3SzhpQno4TCtsTVFpbjkxekRUZkxJWitubDkv?=
 =?utf-8?B?blV6UDh5d2cxck5nVVFoOGMzWXpWaGRrVG5CTjZ2NCtPcHA3N1p0NDNwY2Uv?=
 =?utf-8?B?c2Z2cjhVRDM2c2YyZEI5eEZhNlNwVnAvWCtaamlHdHczUG1OQTQzU2IzZEth?=
 =?utf-8?B?cUwwTmRGcURRdFdvR2M3RWxqV3dCcUJqYlFXaUV1WnNxbFBWbTlsa0VwUyt2?=
 =?utf-8?B?ay9JdmZ0MWhtUW1VZnl4Z3V4NmliN1pJNHhPUFdKUnZzOU44eVZucUFNL0Jt?=
 =?utf-8?B?czk3dTlDUTlkN0dxNEpDT1BsaUJpOElsaTJCRDNQL1piMkFWUVg1dXFpbUZJ?=
 =?utf-8?B?WXFOKzc0bDUxVTR2S1dvejVEZm0xYnh6ZHpzQTZFajl6WCtkSXZ6Q3NKMEUv?=
 =?utf-8?B?ckVtdXhMMWRxZ2UwTTBqQkNDMWRSVjhoYkJJd2hvNWhUYWRRckF2YXRRekpi?=
 =?utf-8?B?OFUwV2NzRU14MTlFcmdTbmo0WHRMTHloMGxMZjgwNWVwZVRRTE5UL29LRnhi?=
 =?utf-8?B?Mm1ub0FMMnloVWZUUkVZRzFmcDQ4aVdYdVV3UzVCRyt3d3VVQktiNmhvUlVt?=
 =?utf-8?B?VW1mQVpyL2xHQzYrL0duU3hxWXd3Zi8vV1paVkpnNk9HLzQ3bGFXbjh5UDk5?=
 =?utf-8?B?cWUyTmVGNk9FTTJrRTN6UjAvOTcwS2l0Q3JMMGNSaFV5Q2ZBTzliUThGend2?=
 =?utf-8?B?K2lBNWVBNjJOcEFpRk9tMFljdGFiTXRNdW1IWndvaEQ3K2xra29jWVNzanp3?=
 =?utf-8?B?MnNJUWtDeVBtMkNGNndhMnBNWDAwdDIxTnNvUFR4Q1lsVGJlTU9IbmlmSTF0?=
 =?utf-8?B?OS9YWUtTZlI1aGtsQ0FKWk56QmQrWkVndnFoc3UxNkwxRlFFMHY4WHRWSm5H?=
 =?utf-8?B?UWJMLzIvQXYyY0VwejBuK1c0ZFo3bEU2Y2pyRjZqVEorTGEvT0dPTTBKS1Uy?=
 =?utf-8?B?SXkyaysweTZ6Tk9YTDZYdzBuYjFMSDduMHVGY2EyVkx1OWhSMGRRUUtUcDRI?=
 =?utf-8?B?NHBFSE43c29sZzBhT2g1eklOalNPWVdVQXdJTWlqRXFqc2NNc2dDNGNzOWhP?=
 =?utf-8?B?N2NmU1FZN0xGYU5zWHNaTlQyRWFvb3Q1L1htQUtYbWh4NTNhV2dLRm5yRWlr?=
 =?utf-8?B?ME9pQi9LN1E1VGtzR05vRmR3SGRGeTdXc05XZFVZY1dUUWRTcDZ2K0hMZits?=
 =?utf-8?B?L25nSUlDeksrVXlHV2dveEx6TzBiVGdWcXdRTjR4RTVRSnpBMmpmVUFCZHVC?=
 =?utf-8?B?c0w2dDhyaXBnQUQ3OVdoUmZWTHVCamJxVG8xNzBQTEl3TEhTWVN4R0lralVN?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A0BA6FD685154BA2C07BAD1EFA5501@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +JLyLve9cL9aZOLnlARSmvDG8HaDruS4gAab84PVRj7b+iwzPae22u08uqGqdrbRxtCGczrDxBR2E9oSG40xFCPWkDmessFDRTuFgW3xO6cW252EEuRQxO2kIjE4Dv+EXpCJ6jAEfeG7oHU4f0fSqt+SZ8ZfQGCZU9EuyRZVe0YOAa+ATnwSZceUXLt7IoJF3aWWJ6npqS+MebwLR5ykpHrfhnIvxqobyeaVh68Wmnqh0ijUYWwwkZQhZVdDUAeQWXXToAEY1ugjPOfSkrXUoiI70BFf9s8jla0pRHLP0lNarMzSLsxIvgEuEaE+4ZE2k0A+TOd2pk8wzwzc722fl86yV1VWsJYAF/BPeQbRpqUpFcVOJKB/wsdNavWAYatOAngMpBZKgyOcqP3C2ZIMSLdUq8K+CnsYlK88FCsp+m6TRPUNG3Cg5uIECic6wo4CojOFukZ4rRAgwXlGkaTzxlasAbGpYCm3RtzI5/HdJ9UaExVGZin8hFpw1PxcVVH0806GtkhAXU9TkfjWUpxoNFOW9IeF5Eb8+uv5N0zG98eAzVqSfXOJ+LW7cjIjFKrPfwDwSFpiOWnf4UhZewa3GNcOEgL/Ong6txcmuAnbuN0rsBbM1WjPVRsbZF+9LE/5c7QDdrgxPUt5Se+vxn/80kaEMgkwrNBuy0MMohFrdIIi4kAu3p7kInThzIyehHRpmzNkoSTfgbgtSeYr79mt5aVBEt5VK++sn217Wk/2RF9T6nLCeRguB+MCgK7hSnBUr7ezFJTZZbMHENsQIZTX2ncnI43l5BXPt4TYGHoXQylZvB1t9tUgfq13cIjaXpNP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79d5df4-09e0-46d2-2688-08db9292839f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 13:23:37.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyMqbMgXOI1InUkwnBo6KwGi1ATdKCzFCMX/9hSEjc1YAH7SgJugbAMpJvnRfA+LYd0M+A4N93Q0yo0IysihERu5wjTFX6Q9J/P3GpBj6G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7989
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
