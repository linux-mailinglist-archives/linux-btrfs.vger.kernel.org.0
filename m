Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86E6B2A9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 17:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCIQVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjCIQUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 11:20:31 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F91F4B5
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678378329; x=1709914329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gRHQe5ny8zvcgcQQ/qvnvYGYSZZfnBajQ3NVhV81Vqo=;
  b=YoXqgbnkbwDJ7N6evLwXFVSly/czfTYDYcpB5QaaM0NITbsS8Vgqvgz1
   OMh5l/HlhqTsrfivtwAbbUuyeYK2uzJ9r/HBFBTo0yg4GOz2nQzHqibmY
   fHxhaYJCqKwNuG5kkzSJBzHxvVuTEaYz+wGS6I4eFdIbhblMzNm+mR74H
   ArnN/cwuP5u242d/xU5R9pPsWmIrm9Pkq5eQ7ki4E94J930gzsCCe6iob
   Ro5Us6bKowP64JEDGcW74O67r0v5aPUDwAcssBb+U8NW43AC45QcCPYd4
   zndDfmf4fDUGX79t/02gt9x+EcHxj3SfpiwaZQQoF+YYbjZMcoBg9VBhX
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="225018326"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2023 00:10:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/ZUsDxWBKktXNPEGF/d/7akwsMRtpvE5UhSgQhQH79lf4U3Gxh+fGYnX78L09Jwx74TW8YynrvajMgLTZ9s2tykGHX3W4mYgrjWbD/GUh7EXlH3O7FLVMlJKP22pOpGHMlS51Ip2rx0xdDo/APNWOcfZMGbi2q+mTJc2n9U9NdOqHyTuqzP4HmYb0aj3PPMDV1eYR5ZZ3I/m9TY7bgjWTlViEmky/hFvPb8puSKJPz2Ihylh/JkrjuF8HjAA3mU5njEOnb8HnIW0N7HdcHuWqrN1h5IV1gn3s+hrSL1oWczszqcCagosEbeVE3VfFchHvWX+nFmuW6/pZt8kCjJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRHQe5ny8zvcgcQQ/qvnvYGYSZZfnBajQ3NVhV81Vqo=;
 b=nIw9SNTTsYTo1/kMGsNo788ZAzDfFXWJE0livKZjzgIp5RxaXw5i00JEqX2DHBaE3ypR7VqM60NDKFQs5Gf/9ZuJ0t3cKEdkzRYn18gINF4MTza5x8M+rRTIM4ckC1aCkSUvVexweXaSLxyNKEjD2gATrzb0o04YKxE/tlkQxRJxwZRZ5wfu15ZTRKZOBKf74zu3UkWTZuksoW68sUSu7HWq8m7OcDb4PoSGbU1Ahi6qubvJmr2PHUC3ZyJi3nmULZ1VsvL2TtgsAuQYODyz9pGwPXbgL4n3cI+QMyWGFYTrax/Kv4qb7zJVKdVaS+LFhz/Px6tgEQedgkBzBdqEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRHQe5ny8zvcgcQQ/qvnvYGYSZZfnBajQ3NVhV81Vqo=;
 b=h8tamq6JorSVIZDh4VVM3eDut/3y9IMBI49+NqGfWJ6z9U6XCnLr5DMaQag5VbIeP8wCHJYy5fh4cLlARThPv+rYl+s5gJuVYeMt1Nz099UD4Tef4JTkghAdmdGll4Vfmr2ZHHa5IyOAW0ue9eBF/SoEE+UmpPbasE5BBmvbhvo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6004.namprd04.prod.outlook.com (2603:10b6:408:56::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 16:10:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 16:10:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/20] btrfs: don't check for uptodate pages in
 read_extent_buffer_pages
Thread-Topic: [PATCH 17/20] btrfs: don't check for uptodate pages in
 read_extent_buffer_pages
Thread-Index: AQHZUmavHqGRC8dukUm5TT9Hg365p67ynosA
Date:   Thu, 9 Mar 2023 16:10:33 +0000
Message-ID: <8d3ed1e0-a0df-4b5b-95dd-2bb5048d80ac@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-18-hch@lst.de>
In-Reply-To: <20230309090526.332550-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6004:EE_
x-ms-office365-filtering-correlation-id: ffc12701-bbb7-4300-f54b-08db20b8cf85
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DlW5MZJXkHDo2sBkLbT1Nc8k/uqeVGnev95TkRUma1W7PuHrUaORAO0Ptzszzs3ArrnFbnRlqf49DyIcyHc+YRgqUOyKt02LFLcuoXsIZ8q9TMgltQMyPqypVDK8buqh/riaPU/I3UbSe51evQjFh4QjdrpZOrWmC1+BvPim6t9FQmCuR+4mzHPZsD1jDrN8pnDjx72MF6/o317C2Zik66GXMvlwbZDF2fiwge2nYQOa3zH9UG0eYZ5uqNi58KOBnHRw0lgbvHkbeeBrZwBWDaOlDI1JJz+MyUDThw43Bic5dXb1NjNdsG3nAXSMp1GlQ5jENNkbD39IWLDctrAyuI3jBFBHzd/xgWxQJ5XWiXe1mW8YK5S/76c4dhHgkRfPGLkEWAE4E2jnjX2oU96ddAJBo+qWePxSvoZvIG3B/UQUR+k7J+6i88auE4B0G8DdaNpIBGr0O3Uvry+74jBPFTDbc+FhBB8SNA33q98u/MutYs48O1ZLR/dP9iyan0/mPMHOiLxxJ4iN7Q15j5D/7DOjhfkq/ZNNquFY+TSojmrpUajOMcYrxH/ttac3ihvQc3Is8+jrxNYXMvs0nBx5tBa4ndqpaKxru2npPtSrh53IalUD+OBFdnp7HRrD4VWmv0piDEuAQ/Hg12Emn8qsfs+8cmTk3LpqOTXPgqd/Jgy31FOc5cAT5xbQwPKDK7v+Couv2oTJ2MLc3d5sHOnhriNSgP9AMtqNwxRPQRhqTYQlPrIocOKMmxJWsEEn1qmuh+xJaSV6B1opEftkJNuWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(38070700005)(2906002)(31686004)(5660300002)(36756003)(4744005)(31696002)(66476007)(8936002)(66446008)(4326008)(66946007)(66556008)(64756008)(41300700001)(110136005)(8676002)(316002)(91956017)(86362001)(478600001)(71200400001)(76116006)(6486002)(82960400001)(6512007)(122000001)(6506007)(38100700002)(53546011)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDRCbFcyNEI2Ry9DbS8xVE5ibEgxRko0MEl5WE5pMzUyNTNJdDZkRnE3WmV2?=
 =?utf-8?B?b3drVWJCaHdZem5mRTRhYXJrRmpYNnREU1c0WE50czFGZFNhM2dTV3N2ay9P?=
 =?utf-8?B?Skt2cm11RVQ0ZDJlamRGd1NlYXhxc255eDN0ZVA5b0I2SjFGUm1BOTVVTGl1?=
 =?utf-8?B?bWVaaWdDVUZLckVMNzZidFhncitUQTVya2lTcWVlYlFwYlpPSWRqUTZJVXZj?=
 =?utf-8?B?T0h6cnJ5ZFc5RlZXQWRUeDIrR0t2b0JRM01OM1RwT1ZCNEx6b1BaYWhtTHFx?=
 =?utf-8?B?U2lXa1F3Q0R2MWViNUsrdG5ES0Z4SG93M3pGMXEzUjJvYS9HUzNxc3NYSTgz?=
 =?utf-8?B?dFlwcWZxM3ViakszR01jWS9zcE52d3R6OTRWS3AyMGxiYUdzUVFYZU15Nnd4?=
 =?utf-8?B?ZlFTYUdpTHRTL1p5NnozMEFML2lxUk8rNDErVW4vbnVkdTlSNTFTZDY2T2Vh?=
 =?utf-8?B?NU9rYUFtczJ0aFRMWllmYWt1LytxZmRCMi9tYVFhQ3ZlR2VMZENoNU1tQjNo?=
 =?utf-8?B?SFdSSjNZZWZvWkJQY0F0VmU5NlhHZDBOeHB6ZmpDTHl3Q29jL0JVMm5PbUxy?=
 =?utf-8?B?V25DdzBXZE14eDNXN3ZSbVU5cVJZK1ozMDkvWGNudHBNcTdTdlpsOFdnWnRJ?=
 =?utf-8?B?QklidzZ1OTZDZU01WlpBQklvdG1rbHJRVStlVFpwdGh3bm84c0J1cVQ5cGRV?=
 =?utf-8?B?cGg2ZnJsWUNHbmZ6UzJ2RzhrRmRRSXhkSUsvUnFtU3U0NkZzQlUxbkNSdmV5?=
 =?utf-8?B?eTF4NUxvM3R5T3UvZzZ1ZlVDQ0hnTlY1cmhGbmZkazZldFU3R0YxcXpNUS8r?=
 =?utf-8?B?OG9hUlFFOFh3RjBlT2o4RGo3M1VWdVA4cm9ueFhXeVZBMStHMHRCczBiRWF3?=
 =?utf-8?B?VVdmWm9yNVpKWmJsTFpkb2E2eEhIend4SjUyME9FSVI3WGNiUWw0QysxajZq?=
 =?utf-8?B?VHpBbjNkYjhHajh0Vitabm1JbldsMmVSeGk2ZUxxQm5nbmx1V0FMUXhGTVp3?=
 =?utf-8?B?WllYdmlvMmpnMDNDbnpkNHYxNktlWlVWc2ppMDJjV0s5dHR6OEs5VTFibUx5?=
 =?utf-8?B?QStEclJad3cxbEh1ODhyYXRHaEpEQjd0K2ZlamJGTVgzWlNabjE5Z2RKUnZS?=
 =?utf-8?B?bUhBampPdjd2WmE2RGN6dEpYWUNicU5wRnRraC9xMy8wMHNXVXpzUFJSclBj?=
 =?utf-8?B?ajU3dTNuWVZucndURWVNa2ZZYkFSN2IwYk9NRzY3ZzFnN1hNUW9RSTZhVE93?=
 =?utf-8?B?OVlPYzRTQmg1MmppOWpLSVZUdVl3aDYvU1M0MDhPSHg4M0Z3N05WT21icDEv?=
 =?utf-8?B?ME1DdmNkQUpMeU1xOU9EMkc3OXZoTkw1TVhQbnBOdHhocGJKcDZQUncxUk9R?=
 =?utf-8?B?SkF2RFZGbEl6YTB2cnZMbUo0a2ZUdnZKTGtNV3dlUHJnWWh1WlZiY2E4OXFQ?=
 =?utf-8?B?enZ4dUErTWcwY01WRzA1SldSZUxJY2x2RDg4aXluY2wzSWd1cVQ4endYUkl6?=
 =?utf-8?B?V1lLUnMzNTIyZnd1UFd5eEc4TXhzbXZYWkpxUjRmUmVPSDdQSjFNbkVVc3lB?=
 =?utf-8?B?U1lyblM0d0FZbHVpMXkxZ1p5WDZtQWxxL2RFeFVlS2EwWk0vQkZGay81cWI3?=
 =?utf-8?B?L2FHK0V6emZjc1lqZ2lrT0x3Z0tpMFJnQi9pWmVrU1U5Y1NldUJHMUlDanJm?=
 =?utf-8?B?QU1Bb2dqaDVkZmhxWHB5Sk1BWi9YQUgwdy9EN2ZscVh0bnFyK0RZVUd0cXpq?=
 =?utf-8?B?aXRuOXpHR2czSVZwZDRZekszRGxFd2o1clBjd2Z3NUdZcFRQNmZRTkdQMEJo?=
 =?utf-8?B?aGlsTUNTZ2JPdEtDYnF4cXM4bU44b0FmSmRObDZBYjZiVHB2U3BINGd1K3lx?=
 =?utf-8?B?MGk2V3BWZkJwRG1maFR3L1RpMVJKd3RVTVp5OHVUMmRnRFpSekZzOWVkZlVq?=
 =?utf-8?B?Yi8zbVd3eHAxSlFDTWFTSEFKemZSRS9qOG84dWcvS2F3dmQxeUY2TVVIRFlX?=
 =?utf-8?B?SUNVSkVmM2g1cjhQVUlqTWJycTZ2Qms4c0duUFBNT2FiMHF4V3RSQWlBNDZ3?=
 =?utf-8?B?Yytudm1HR1UyL1M5RHJSSlVUdlNNNG8vcEFkengyK0toWVZhYWxlMVR3WFBF?=
 =?utf-8?B?RldFWVpwSC9JcGpYOTQ3YlZpQ0xYUEFmOGNBV2gyVkVFNGswNkZvNXBObVFm?=
 =?utf-8?B?WmlaZnlDOW9BY29ZQVF3Ri8weXpoT1QxWDVjV0hEOTBCcGJCbU92ZmtCUUlk?=
 =?utf-8?Q?41Y1qB+bFmk2jiEOPnF+bE6Vwoxeb4aB+AW7tGshiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <680ED4D5398EA44EBA34DCD1205C770B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uVKBdiwM+zwyQrKY3TP0s2dhy1ymA8SAdxa+xFU/kBanO/bP1YUnT3kKm3f/xtj/XsO1qsyHsVN5j4f7uutVaV0H+Me6tEXucL1JRTXZedK2ihw0JqdQ2cmlbFtEF5KBTy8rkqbP8Y76XdGlQXfGOTwc+tV14U5K5y6CWE60IT4WKp5C/LWN5xBdqJjB5y/5CfjK2gaXSQ82+kWo+pJFBnxOlc5/W04R+9rNFBuTey49Bm1E7hMgi/7TVuyYkZRmGCCjt3uaKlUJIYgEkq0S1T8CaX01ee7h9a9Y9hw4q25XXkro4jmhMKsSNy6I6pTt6U34+GIlPjj/zIlPrK0no9ZirF2quLkXBhhibj8C2Hrkr7XX4x2wBNpnQl9zD/sMKZeJNfCy6jIi5bQ7tG+gDM1jCzqNR+w2AxLVCOOTAigK0D+CWw1NmaDsjRdImy+7RFLceGKYhBp3mor/dXwV6Cm3ig5lTtjBzevYpUPW1DmgGMSGcjetz7SLVgMWzcF/tiLzKO73FPALCr5Idb51c3YaNvskjS1TwA4ytWf6iy/RP5vq8uezkdhg3DDjT459c8qRTAhwzDqwo6nX9ENvoZUesRKF4+mhtJhqm9VKqhq8ZIkz0Dx9HGwKc37Y+CS3RvC3bitH0k0Pl8Y05nLFcJV0SuKBGPKfTbmbTLmyGAEKD29JiuZ1c48s48C48YYZSjQzt2Ebjol/TFRyJYum9duq9pguvdepgsake5b3fKvWhUFDeXKnPtOlo/GTOtUVVQ9ZPvNSOl9e34nJ039R+WTO1Jrb+vP/McN1IbQNjkLEx3FiOVvxjTUJylWmpCBQG5KwjBNZ4XjGw82ry3a9uf1WDawLC8H4UtWb/KwCB+bQ3bTNfjD3tW4EY3FNAoCW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc12701-bbb7-4300-f54b-08db20b8cf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:10:33.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVahxgezHc+/KiV/gwnQHxOhL6i+9olML4tXzZUeXaxShqV+trO/nl8LjWxe6LTbga+zPMokPOBGZXNJPRWda/eRdVA45t8qtxOkqMt2P20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6004
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgb25seSBw
bGFjZSB0aGF0IHJlYWRzIGluIHBhZ2VzIGFuZCB0aHVzIG1hcmtzIHRoZW0gdXB0b2RhdGUgZm9y
DQo+IHRoZSBidHJlZSBpbm9kZSBpcyByZWFkX2V4dGVudF9idWZmZXJfcGFnZXMuICBXaGljaCBt
ZWFucyB0aGF0IGVpdGhlcg0KPiBwYWdlcyBhcmUgYWxyZWFkeSB1cHRvZGF0ZSBmcm9tIGFuIG9s
ZCBidWZmZXIgd2hlbiBjcmVhdGluZyBhIG5ldw0KPiBvbmUgaW4gYWxsb2NfZXh0ZW50X2J1ZmZl
ciwgb3IgdGhleSB3aWxsIGJlIHVwZGF0ZWQgYnkgY2EgY2FsbA0KPiB0byByZWFkX2V4dGVudF9i
dWZmZXJfcGFnZXMuICBUaGlzIG1lYW5zIHRoZSBjaGVja3MgZm9yIHVwdG9kYXRlDQo+IHBhZ2Vz
IGluIHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcyBhbmQgcmVhZF9leHRlbnRfYnVmZmVyX3N1YnBh
Z2UgYXJlDQo+IHN1cGVyZmxvdXMgYW5kIGNhbiBiZSByZW1vdmVkLg0KDQpzdXBlcmZsdW91cyBe
DQoNClsuLi5dDQoNCk90aGVyd2lzZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
