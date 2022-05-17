Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B26529ADB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiEQHc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiEQHcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:32:51 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30930222B4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652772769; x=1684308769;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q9iAmA5kir2mnQApITeGlc/ASWPX9bgYRl4BUHpkR3k=;
  b=cbD1bi+I8AIWW3sUadOXKUmV4jFiWTyWSrwalGCbl68Km/a9U7wbBW/B
   8NH7j2B/SknCgJrCKaKDvhgLhI4ZJpJNt2/8o787wJBVxgnDkg5OFZx42
   Jl7l3WT4IeMk4GW+gxV+InLp+i5fIOAYXlbg02MKTjSi2e4V+y547lpZE
   pf55+QIDPLR8CQrTvYen5QLaUmDG9aIkQc6uIae1iWrKb0WrmaUcQgFnB
   eResRbLftT6tVxgntHGnPrDLZBaNcAy5UBCIcXwQLs6nRXEG1ZC70L4wK
   rmSpWvERaCTgxsl1SIdsuph7yNc2zW65LJkCQIbg2dZOVTLD6/xh1586T
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="199350085"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 15:32:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keGCMBYAvOg4ibKQQgxGADJyT6yFeFDJDSpI9T3yUT7Cv9QhJ6XhdI5DjkpUlgkiHnkUs4qKBkPH6v61h6pIUcn49iK3ZSh7YsCn3OqfWROXSPI9vUddUZODJm5SsF6PVGQPv1W20gyadMyTszHLq7P8GxX/tfn3Jut5pyLINY4XiXPciGi3eUi17aW4AerindBSW4KthJ1rJeAjewrX+Sl7DTIHyf8Tcdj1csqeVIDdF4DQ8V5OMATR/50ULxcPS6I63PZvHQhWzT51ASjaiLXkqby+QNNAOEWCHp+IVcWXk6ELqHyJvz+hR4TNHsMft2wJsyhZcCGn9Iw6BEyUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV4O3v163u5cknNj4LMeEP4yQH4SKMJwuIJ5/LZXPEI=;
 b=gVmw6li69Z6Y3BZINot4AAgq9FksGsW7UjF1tP2AFI+U3FT56aDuJkCkcGMjBtcArkoQkmbYMIIwul9etmSxu2p73IMGbwqdqK50xMAmfx64C9wUFeWfO3kQd9lNrF/iSj0P3MHe3amip50M0S88k4BaOPGHbR2z2ppEFt1XpHx8UUJk7MMw0fgDYebFxU5RxQfDbs4OWS+0f3wfP7/D6GrDW9QOxE8mVzjLeCQc7bEsNvKkh2LHsrU8+Oj/2F5cXrEt4cOHz4apjaExVpsBcKmFfkyImC8oXgmFqKgyeVNlKJKhvZpCkNzYOZpMH33bH2oIB6Zj+7WKkx1pZ1a8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV4O3v163u5cknNj4LMeEP4yQH4SKMJwuIJ5/LZXPEI=;
 b=NiSxoI3BF6w8u7yWlj/yr3FMXqUcQ9dcJkbrBC+stO9XfGZtwq93YPvjIw6YdOx+7OjeUSykPl3AxJiV0i2SL5l/rdi8qkiZ6vlsI+T3y3eRd1kHbhr+l+kOeBBgmiJHnsHW3vwgNAugw06BPIbfL4fG66ZGsT7QLrUNO1Jwqsw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0541.namprd04.prod.outlook.com (2603:10b6:3:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 07:32:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:32:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Topic: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Index: AQHYaTGyNcHorGSGJ0SpCqziAWVW1w==
Date:   Tue, 17 May 2022 07:32:47 +0000
Message-ID: <PH0PR04MB741613EDCFC95CCCF5587CBB9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <64227525-4507-9a04-942c-e081c6550f69@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65029825-ac3e-44d6-0aeb-08da37d770d0
x-ms-traffictypediagnostic: DM5PR04MB0541:EE_
x-microsoft-antispam-prvs: <DM5PR04MB05418705E1784800B8E0802F9BCE9@DM5PR04MB0541.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHH9G1A92SrfB1ej5vfuM5hyeoZQijmejms7baeCBRlYNJ1J76LzeAca1wBSDKLfqIyRY5MLDeJoocZYAxzhVy6X8xg1ye7OCQp4Wyu5VodJsaqRHKGgEzQcWuJ0Q7huKfjb9lC2xGQpJDuy0dANLxgEXAaUG2SdkKw6AuD2Wuuv1f1EEjn8uGCaWT3ZCgeBfOdf20f3DU2mxjAoR/Oz9uOgx9rFDZyTZfxBUQt4qy5vauTBQD06aVeq3d1gmoKnC3nhRS8QtEc7rpBdQUOPBkFwWYgTOVg46DjXbBwKn+2JqcpkNKJC9IBGaBAr3XcdHeARbJyOYrerXvtrZXOuG8lSxQvq50sGgxGSVWzPJmUFFSuq8bWWvnBYVFAQSIwfBHSDm8Lp/nKSltD3mgGDsMwVa7AGhdmbzRWJ/rvJLbFqMv0TV0F7DHwV0q9I8+CfJTRFAtbAiGZmV0t5J7M3AmBCqdab6CMFZ51AikqRWeB/XCi/OzA6bML9AbOB5gAT39Teh57CFvEYis9hroOvuh1LQKbLb6bHoKKMkFpUjfc9MY66U0nmYxlo5/acxbRVdNYZPgUvsTu9Xko9Iyl8OzkT/Ef0ihlTTuZ94QOeadD0RD6CQcC4uWnER9zsamCpVjoBjr0ZA8E6OPq9SrLEhgiP//vk823Gx2Q80Jvjikdz5qgFPNlAfvS/uMXKFr4248JoXpysCalJaZt9dPMDpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(9686003)(38070700005)(38100700002)(82960400001)(186003)(316002)(7696005)(110136005)(83380400001)(86362001)(33656002)(71200400001)(5660300002)(508600001)(91956017)(52536014)(66556008)(66946007)(76116006)(66476007)(64756008)(8936002)(66446008)(8676002)(6506007)(53546011)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?L6sBsWT6BIdr22/7vbGuLI/n/xYbiU/0BoQnSdFcKO5KAAKUj+4ssL/MSu4tWh?=
 =?koi8-r?Q?Lo95Dk/SF6KRWVpD+6g0m6YfJERA73UtHkUwTpRjtsHH8Hys9N60kS2WRabJhb?=
 =?koi8-r?Q?QuUAESIOkwD5hmAgfXQCXV/+zIWePTEFpEKyn8lRtNYCWGePCNqUHv5aAc0TUg?=
 =?koi8-r?Q?wA81DI5C6oaDk2IanvqaYvRZ01AE4rbV4p6zAopTXRbPv00wxPbh4ZRvw3uw8y?=
 =?koi8-r?Q?70bvHceD/Mkbp4b0wPiZVffHe1mHf3kIDua9scpzIn0e4Ljc2Vz6AcQVNBH7hn?=
 =?koi8-r?Q?QmhVEYE0sXwcPWGrDLGfjMjX5OggPt10BGh3rzTEtfHhu3s6i7Duoa5exDDVHC?=
 =?koi8-r?Q?lroDmRTTlypvPnNlSjYlOGDCSaMfJdZJMyN+m3hD0t0+URJr/GVO1Rn6fE3Olg?=
 =?koi8-r?Q?svnZr9t08jERlklJAI+GeThV4eZIzXPnZFoLBSvTphSO3gYo9kaxA7rtTFVesV?=
 =?koi8-r?Q?XpvBP7DGEVPBPRTYSDnPgfOB/znBSd23cJYzzjLbCsybQxpYnbV0dvq7T6YoXL?=
 =?koi8-r?Q?lodZOld+JrQdxo10OIhmUyeYvzrhipQRdM008L7K1qY/v46BCDrDB+hf6PIeTD?=
 =?koi8-r?Q?maaM5JC3iB9DHxD1UhyHklpeOukMaIB0eVFjdYhJSmrBUXVBDks8slaQUIjqck?=
 =?koi8-r?Q?VHItLWbXhrjpNBeLFwwmg3GmDfBbo33KrU9KU6u7iSLqATWb3ypmN3wNfvQqlw?=
 =?koi8-r?Q?jB/evQGjq9K//qeLKdUN//k5592A2gzRXofgivsGBAzqZ6vSInT3/qSbzLA8ON?=
 =?koi8-r?Q?BAM2Ik1kkNm9BiobuU2ohGE+0XhhunjzB3GPNCxwQvUKJnoTtNuqjq2GS/3SUD?=
 =?koi8-r?Q?USEFokgJhS3zD9Pkk0C+E3zeBDV+m/hXpFDgBHSwchrepnRO7K6vCKh4fHd7vT?=
 =?koi8-r?Q?1kkSuF0MIR6i/Ov5MPlFy1LKk9CgdrzwTtTCKMFd7FC2XQFvGXaHs4m3NmrtWt?=
 =?koi8-r?Q?v9KJXqNSzWJy+LE6RJfQvaGOIWLxvhgzcNGWX+z2lUL0dkk9KLV6R9ybqzrv/g?=
 =?koi8-r?Q?HlKsIXuASFWCDOJ+31zbg3Lyg/rQC7OmuzOhGvwCDaEgjXzOJ6jULccGxFr+96?=
 =?koi8-r?Q?W5OFbT3ARvec2P2wNauCDfkYuIqwTv39oDc4Kt9osNANclBIMRqzsTL8tJbn/C?=
 =?koi8-r?Q?FENqRKvb/+KwiBf+AVmTPjxdSPGEWTrMKrIUgi3rFmr+a8OjObLqQCsPGHdjHJ?=
 =?koi8-r?Q?saQKqjOzM07HwZOvOxoysBrP5v4y7VTyBdsnV23YjeI+tI/NGdi0g+t4GRi8Gi?=
 =?koi8-r?Q?SpjkOiJmJi+sktkvWDv0zPAylshw5OjLtF+ch12BPTusEFpOl4R5gtwQe4a0d9?=
 =?koi8-r?Q?aW/4ftatz9w1asdztcrrBvsFhfAC6ywiSJubW/lV1FN/ASikYtStDD3gcl50Rw?=
 =?koi8-r?Q?Rxz0nuuDQda/A4LlsMn4f5XGJPc8K5ySRwJTtmGf4cFS9ZCe7kDj+st4iETPv/?=
 =?koi8-r?Q?HI5EoRzFKsjoukOHBY4qOOx/uvZD0vbcHtgfKfBMsTkYSdAIURR9MsUni87hr1?=
 =?koi8-r?Q?nJQsgdBm83v54CKSE+h3O/voStVSD+tjpBcpI24cqdGz2lo1pCSA/+WhAQyoVR?=
 =?koi8-r?Q?KwZ/RqoZ1QXrhtAlpu1Il38SupE5oOf1zEnldwdgIELVbxqqLQP059oQN+BCxy?=
 =?koi8-r?Q?kz0T6TfzgCxr2jEQLn7CCOsizD0MUhim5tzNYPHaE7WYEKsGfLAgltr0Snz2uv?=
 =?koi8-r?Q?h5nffn/psCdzSbsKwa1T97H8e4wuKMgEtn2MsfNYcuwj92hNZear/vPrU2SDZn?=
 =?koi8-r?Q?7i?=
x-ms-exchange-antispam-messagedata-1: k/5vWG5lmDwLt11p2Y9v9HikORoObOGmxtxgnhpdQZJSpoY/n0Q7ZZy6
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65029825-ac3e-44d6-0aeb-08da37d770d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 07:32:47.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9a088JLVl8mI/nlkejxSLB08c1ZX9MtFgCbPK0ipDU/DxK4w7QOyUr2Mwq9V69IlYjqU67aI9DjyY4Dvd2RPVZZnmbydIyKNBUJBHkIsdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0541
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 09:23, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 16.05.22 =C7. 17:31 =DE., Johannes Thumshirn wrote:=0A=
>> Introduce a raid-stripe-tree to record writes in a RAID environment.=0A=
>>=0A=
>> In essence this adds another address translation layer between the logic=
al=0A=
>> and the physical addresses in btrfs and is designed to close two gaps. T=
he=0A=
>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the=
=0A=
>> second one is the inability of doing RAID with zoned block devices due t=
o the=0A=
>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>=0A=
>> Thsi is an RFC/PoC only which just shows how the code will look like for=
 a=0A=
>> zoned RAID1. Its sole purpose is to facilitate design reviews and is not=
=0A=
>> intended to be merged yet. Or if merged to be used on an actual file-sys=
tem.=0A=
>>=0A=
>> Johannes Thumshirn (8):=0A=
>>    btrfs: add raid stripe tree definitions=0A=
>>    btrfs: move btrfs_io_context to volumes.h=0A=
>>    btrfs: read raid-stripe-tree from disk=0A=
>>    btrfs: add boilerplate code to insert raid extent=0A=
>>    btrfs: add code to delete raid extent=0A=
>>    btrfs: add code to read raid extent=0A=
>>    btrfs: zoned: allow zoned RAID1=0A=
>>    btrfs: add raid stripe tree pretty printer=0A=
>>=0A=
>>   fs/btrfs/Makefile               |   2 +-=0A=
>>   fs/btrfs/ctree.c                |   1 +=0A=
>>   fs/btrfs/ctree.h                |  29 ++++=0A=
>>   fs/btrfs/disk-io.c              |  12 ++=0A=
>>   fs/btrfs/extent-tree.c          |   9 ++=0A=
>>   fs/btrfs/file.c                 |   1 -=0A=
>>   fs/btrfs/print-tree.c           |  21 +++=0A=
>>   fs/btrfs/raid-stripe-tree.c     | 251 ++++++++++++++++++++++++++++++++=
=0A=
>>   fs/btrfs/raid-stripe-tree.h     |  39 +++++=0A=
>>   fs/btrfs/volumes.c              |  44 +++++-=0A=
>>   fs/btrfs/volumes.h              |  93 ++++++------=0A=
>>   fs/btrfs/zoned.c                |  39 +++++=0A=
>>   include/uapi/linux/btrfs.h      |   1 +=0A=
>>   include/uapi/linux/btrfs_tree.h |  17 +++=0A=
>>   14 files changed, 509 insertions(+), 50 deletions(-)=0A=
>>   create mode 100644 fs/btrfs/raid-stripe-tree.c=0A=
>>   create mode 100644 fs/btrfs/raid-stripe-tree.h=0A=
>>=0A=
> =0A=
> =0A=
> So if we choose to go with raid stripe tree this means we won't need the =
=0A=
> raid56j code that Qu is working on ? So it's important that these two =0A=
> work streams are synced so we don't duplicate effort, right?=0A=
> =0A=
=0A=
That's the reason for my early RFC here.=0A=
=0A=
I think both solutions have benefits and drawbacks. =0A=
=0A=
The stripe tree adds complexity, metadata (though at the moment only 16 =0A=
bytes per drive in the stripe per extent) and another address translation /=
=0A=
lookup layer, it adds the benefit of being always able to do CoW and close=
=0A=
the write-hole here. Also it can work with zoned devices and the Zone Appen=
d=0A=
write command.=0A=
=0A=
The raid56j code will be simpler in the end I suspect, but it still doesn't=
=0A=
do full CoW and isn't Zone Append capable. Two factors that can't work on=
=0A=
zoned filesystems. And given that capacity drives will likely be more and m=
ore=0A=
zoned drives, even outside of the hyperscale sector, I see this problematic=
.=0A=
=0A=
Both Qu and I are aware of each others patches and I would really like to g=
et=0A=
the work converged here. The raid56j code for sure is a stop gap solution f=
or=0A=
the users that already have a raid56 setup and want to get rid of the write=
=0A=
hole.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
=0A=
=0A=
=0A=
