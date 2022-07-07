Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84807569EA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiGGJhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 05:37:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76934505C
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657186637; x=1688722637;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sMrcsVeY5LdVvdd2c3FAfnJE8L5hiNxA5OrCXCtw0GM=;
  b=LzoZF/GI/y8tb/1q30Pf92Fnv+V+g2lBMTYU7cBxZ5C4S+RslWx/ciNV
   Q+XNasZqokWY+xzqhknJ/3RMVKi4J5Cu1wSr/M5GqoLhi/zsowGug/ZW5
   E1wpPkt+XejYgVzu4OVGL8hGStr2QygaA/s0Ql2LKarEavyFDf35DsazA
   WRBaez9I+Da4W6gba1VkQD0aaeqDyrc6wVm30FGi8zQe8E6gsKrZgFL79
   7j5p1v7rC6xYtfeqpOWz2P+OqMENcJ21GGW8EvvPK5qPOMN7T+Yf+yIDX
   3VUDUev4RmQlNOjlYldk9V3+Y9npzIe8dIHZ6XiiSlMRrKU1Md6EAf3Rx
   w==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="205069120"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 17:37:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPCLy1I7aAnxO82IX51cqF/eMqxYRzTHMX4Aj16yiUf3c/iCMDG2bbUf4LvyjT/8+M1MgGlh2iQZ8HbZ3MwN+i05vJtc78I/oFTA86ukwx09eKldyq6P3Xzn8J48VKRz2Xgq1Z+ptvJm/QTJhbu8vySi7hbS8cpL9mkoajUitY8jZZ2ZUJTHx7I44Pk63mDYWw1z9SXwfmi4Krv3WoxSuquD5mlrBOxkrbcmZap211jNE5/HP4cZWDnBuH8m8PPjOkT1flAIBDRF5kMNPNlc7gZ8mcVuLzyNw2KMn8hiQTCX1G3HPTjLFIQIyaRkN35ZXhOa/sS+5V+PpmP+noNaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIqRcKlAqDiAN5rj2IgiALlmVd2LgWH57yIE0a9+Cm0=;
 b=fctcHCFgi81tefnb8jwQASLVkfa3l4OSFgW82Ew/OX+2zRG5PJaAqdBNQ9VgQ2BdonXlGNsZqJWbP+U+v5dBTZXjuhlXL2Q2KcR0CzlMWTC5G5fi9v6Gqs4yS2QMND1G32cmYyN/CU0mZi8v6mZAxw9b5oP+kTt7W18amNdA6lohJxdD/JH2RH6a7QAPIbWfnlB2iEx7M7Rcb5Rd/oXQoSMo3IX+9VdHLSGbg4fiIcfK5XRWmBGv5Fog+udNnqs+dq2NbBab2kp40UejBbd2OP7LxmzGPBpIsnBP6ku3pDhknIxwQdE3tNINv9OAai9F/fuBsB19FMgeM6aDRLK4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIqRcKlAqDiAN5rj2IgiALlmVd2LgWH57yIE0a9+Cm0=;
 b=jPA3pqmOspQm7AWRmHVH8To6gWSZzT91GTZpCu8C0KDNIMhpjJhddWqSDGyDghJOE/qdFMjpIsUxZr0Iuq9Dll1lmypove6oKrchXA1r3xQyn5mx/KaSzsrnVGXEUBoVQ2zVB86dylvlweIvLNr139WSOm4qcg5R+q0YPOutHms=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5770.namprd04.prod.outlook.com (2603:10b6:5:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 09:37:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 09:37:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Thread-Topic: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Thread-Index: AQHYkcM9alGZpxHAsE+tS/mKw9JDjg==
Date:   Thu, 7 Jul 2022 09:37:16 +0000
Message-ID: <PH0PR04MB7416EDF3C4EC0AA72A2C2A619B839@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37bac72-391a-4230-15d8-08da5ffc478e
x-ms-traffictypediagnostic: DM6PR04MB5770:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cH1MghLXyAxMBKojYWzHSAMfJ8lKjwGPRmfejVmGrtuIUd7PldDBFYLr8E2NlnfjUgnPkHAtoOLfmSrRHQq3oorHWrDUQaw+lFmmiLGqrbNqDITUDrl8bVjf/O4GvFJZNVbOCgWxjJDpUTVvbGAO/P6inus02rbDDGyF1sCPwfQ2oO6V0+8r24ZttSgzROC22TefTa1IFkzaWoSbSIp5IwSaxf+RhfsfXfc4/7+FUYfPe4jIbrZqbf5UaUTf354BWPA9rC3Sea8sf2paiG4v9htLkZyqfL3ihWNOUPf8sjbc3r71lCdfg5+QPXbxB8Izv0ebIDHx/7iQGhNf/zdFiUUbu8YhaGJJLMMSi/YjAtSaujjpHEbu+3Mi+z650MNJaMsbRubNPYQ4UjrAN3RrRv+H4lTpzxFJfcUVhCiQX8/Cchmat4iqWFeFXX/SkUVjo/fK3HefmVW05s7VA2xTPR2KGS/UzHiZxTTmlHRqC/K8NsBZ8eBE7+mUT2JjcvzEnyDNMb5QQaEXTN3FAU3oPXzF95YEvk5G/TzNQKtX71i7w6PcmtzLHQqPS7cKiOHnw6ZWIoFVDKNUxoa7y9THituYgH6OYuBXCm2Tojq4TAGC8nMD0+ynoHAKo5i1Hp1aM6/H/4bDgjXmOB7BVfRuNjqOAGb+KV1gkZcs1NThsQlibzFLL1zDAifu9PiYdkZFooNDJsKbghAq1oz7kKxw7VNBUgO0IR4IOtudcyWovPGFJIBqR9MQ6XXgrWLe0JKmGob7/C5SmB6lPvuuYPl24BF6PuQj81dud0mMCMqxpmFmvwClNGyb2bm6Mv+wfPx4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(38100700002)(478600001)(186003)(110136005)(55016003)(71200400001)(33656002)(4326008)(83380400001)(64756008)(38070700005)(86362001)(66946007)(41300700001)(82960400001)(91956017)(76116006)(122000001)(316002)(8936002)(6506007)(8676002)(7696005)(53546011)(66476007)(2906002)(52536014)(66556008)(9686003)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yZsYUgqhmET3x7by7h6R7CJBXLnssP7CW+NK5TfCSFXj8u7jakpvHRsyzvzz?=
 =?us-ascii?Q?zFpQiTXceuE/VfFfrpSr2S0uBC8XxKJGvS8YabIdw8jNMRR6wVJwJEF4uksf?=
 =?us-ascii?Q?a6P2Aa8WWVKq3DYOCQJqQl8FgDwaTaBfxPuYuqxlDHeVML6ZiHebxlk1YMGL?=
 =?us-ascii?Q?T+v7s6q4A2pX38RQrGvu0xSMEWxcdkkPWmX+lcJx0E9e/a8irEXR4a0wVjP/?=
 =?us-ascii?Q?mVtRZBHrVZCNMKtkoSb/QbLlRv6mXtQPa9sqz7kJ3S3uxH4fxLpOxbOTNhuv?=
 =?us-ascii?Q?Gxjbfe5hOuu/xtTOkdqPHIkLZCxJlTSNnIsaq7GIsvmvqsNU+dfVunPJ1ZZB?=
 =?us-ascii?Q?aDyHgJX//bFozpxj4OiD1HLWqWtm0jYdMyXoTF+4R1gp1pVl194USTHoKIkI?=
 =?us-ascii?Q?93S50AWwB/Yx6zeNsSIAPN8eTiDzd1ytJuJTQXH8O0ls1HdAD/lpEQTvBwQh?=
 =?us-ascii?Q?rJyiWxDjg33nClscwrEfo4d1940h4jy+g0VqiQBoQF/zOoo1KNqtD1UqKekp?=
 =?us-ascii?Q?K7reR4zyB6jaKVtBQNyZ/OG18Gl6CL6+AlwPLcxyq+rTAT9lNvFceZi/1vuG?=
 =?us-ascii?Q?sCE8mCxGrFPwCtXP9x1kWBYzd3AIrkdnxHXhd6LBOyuX0ZIj83m1M6ij8a0h?=
 =?us-ascii?Q?HU1X97tNSHx8YmrZbvH/5pI9Mlq168P7AbnrU8cRaSEC5t1fCpNutU7hm9Na?=
 =?us-ascii?Q?Gz848mSx0lpfaC1y8pvEuvAsAdADCvdgTSeeqjbPq/e/PvPpKwha+30Cu0/j?=
 =?us-ascii?Q?dSetxBX3ScEQxmJTcGxmuwuO+l+idiksSe33Y2vUmAAaYTjzY4UISzoovPX7?=
 =?us-ascii?Q?pN6L9AE/cfKv9xXFnPJoFrpSzDDgSsnYnE5Ef6rWUYaP51e5P0tzEDgFygNn?=
 =?us-ascii?Q?lj756cSD86LfNprtiDTz1UOwWFM36eXzzog+/w1Mj4JnU0TxEfsT4ZkKlwEY?=
 =?us-ascii?Q?VXxX1th+P7LdppRpwk4aKTwoWHo99uxBGwphR2GSy5QmMxVurBWHQmpPK8mk?=
 =?us-ascii?Q?Um4SNCFq4nvvIKGxifncihqs6m8g11tFU/HYTe1hiVLE873Acfr1GZNEVUss?=
 =?us-ascii?Q?NHWdxcCFmxvF8fdBf5AXMSS21S+4UEnXzKjg9iRHWCTW9fdQ49at0rhQzc0p?=
 =?us-ascii?Q?M+BaaxdZLI+AuPFIJUoAo+AVmvoYK9pwMAh1FX8EMfAo/BG5khnOt7UNIq1s?=
 =?us-ascii?Q?TVYZfVgFL4uWGJ1BBK4HD+erinNOTa8LtjWy/AKs8bRLUVtwsAC0OYRAyWir?=
 =?us-ascii?Q?zFovYiZmaST7O7HsTvXydu8rlcHcBpbKe1k4sx0APGsO4nrr6W5bwXTI7B51?=
 =?us-ascii?Q?zjvv9JCHd7mrCCWcEonBOrk1NoRqLDcwlltoV7P2e1Jrdve5sKBPLSZmOFqy?=
 =?us-ascii?Q?00xsp4l8E3DHsZEdo+zXae3FVZTmjhMC4AMot14WUx6kochKyrWSXCYazO62?=
 =?us-ascii?Q?QqtksYqc/IOIz4pZgO4g54bhfxCxRuLlyx4DyvylIzAiTK7isN3+xr+4j5qn?=
 =?us-ascii?Q?Ct58kWshcvHONdUhGoMgXFRP5j8GvVs1+nVGtyTsj+v+PHm9B//JYAlFl+14?=
 =?us-ascii?Q?XbY622U9Oe2A1v3Es8lnWjg4R3WHxzuN26pXkETnNEEkqzyeHm4UGpsnKwGJ?=
 =?us-ascii?Q?qeiHfvCII1oG5kHeuAU0yGi+Vn67rNGKEHiZjRDLv8BBmWcg2G3f6GJxxPk1?=
 =?us-ascii?Q?sJvUuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37bac72-391a-4230-15d8-08da5ffc478e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 09:37:16.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uw1p20z+RoyFjtgFd5xVJUA1PFXkdDs7tzglt+r3P/MX/VOvxx46d/UKpr1wnl4FIT4RrVRBab5xasKllXuJ46WhpQOMZhLh7hhw/3e5IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5770
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.07.22 07:49, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/7 13:36, Christoph Hellwig wrote:=0A=
>> Just a high level comment from someone who has no direct stake in this:=
=0A=
>>=0A=
>> The pain point of classic parity RAID is the read-modify-write cycles,=
=0A=
>> and this series is a bandaid to work around the write holes caused by=0A=
>> them, but does not help with the performane problems associated with=0A=
>> them.=0A=
>>=0A=
>> But btrfs is a file system fundamentally designed to write out of place=
=0A=
>> and thus can get around these problems by writing data in a way that=0A=
>> fundamentally never does a read-modify-write for a set of parity RAID=0A=
>> stripes.=0A=
>>=0A=
>> Wouldn't it be a better idea to use the raid stripe tree that Johannes=
=0A=
>> suggest and apply that to parity writes instead of beating the dead=0A=
>> horse of classic RAID?=0A=
> =0A=
> This has been discussed before, in short there are some unknown aspects=
=0A=
> of RST tree from Johannes:=0A=
> =0A=
> - It may not support RAID56 for metadata forever.=0A=
>    This may not be a big deal though.=0A=
=0A=
This might be a problem indeed, but a) we have the RAID1C[34] profiles and=
=0A=
b) we can place the RST for meta-data into the SYSTEM block-group.=0A=
 =0A=
> - Not yet determined how RST to handle non-COW RAID56 writes=0A=
>    Just CoW the partial data write and its parity to other location?=0A=
>    How to reclaim the unreferred part?=0A=
> =0A=
>    Currently RST is still mainly to address RAID0/1 support for zoned=0A=
>    device, RAID56 support is a good thing to come, but not yet focused on=
=0A=
>    RAID56.=0A=
=0A=
Well RAID1 was the low hanging fruit and I had to start somewhere. Now that=
=0A=
the overall concept and RAID1 looks promising I've started to look into RAI=
D0.=0A=
=0A=
RAID0 introduces srtiping for the 1st time in the context of RST, so there =
might=0A=
be dragons, but nothing unsolvable.=0A=
=0A=
Once this is done, RAID10 should just fall into place (famous last words?) =
and=0A=
with this completed most of the things we need for RAID56 are there as well=
, from=0A=
the RST and volumes.c side of things. What's left is getting rid of the RMW=
 cycles=0A=
that are done for sub stripe size writes.=0A=
=0A=
> =0A=
> - ENOSPC=0A=
>    If we go COW way, the ENOSPC situation will be more pressing.=0A=
> =0A=
>    Now all partial writes must be COWed.=0A=
>    This is going to need way more work, I'm not sure if the existing=0A=
>    data space handling code is able to handle it at all.=0A=
=0A=
Well just as with normal btrfs as well, either you can override the "garbag=
e"=0A=
space with valid data again or you need to do garbage collection in case of=
=0A=
a zoned file-system.=0A=
=0A=
> =0A=
> In fact, I think the RAID56 in modern COW environment is worthy a full=0A=
> talk in some conference.=0A=
> If I had the chance, I really want to co-host a talk with Johannes on=0A=
> this (but the stupid zero-covid policy is definitely not helping at all=
=0A=
> here).=0A=
> =0A=
> Thus I go the tried and true solution, write-intent bitmap and later=0A=
> full journal. To provide a way to close the write-hole before we had a=0A=
> better solution, instead of marking RAID56 unsafe and drive away new user=
s.=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
=0A=
