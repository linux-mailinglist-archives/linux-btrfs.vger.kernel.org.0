Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9D5735B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiGMLnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGMLnk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 07:43:40 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFD2194
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657712615; x=1689248615;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xh+IwIhzrgmKz83/ho9vnYTDvie4OssssZ4bagODoEk=;
  b=erjYvVQUB5H2nFlx+IvgPFZZkOOm+LuTu9zaBsOeVo+y4yKh9vcyopa/
   8ryhQ0N9ZaT3lAVzb+QxVPgq7B+bCgboQoDVH9drCPaVrRYZmNQBRShbY
   O/kzv5GACytgHtp4S/4+ufDkkTrutICXkq7bI1fi5BMLpR90mKNSwcNEE
   7ZH1Esyn6jnKH+0hDqGA2JDHFUJXvyZG7P7ttUtw3k16z1uOTeeGS1EmS
   tT2aYGOjjBQ1Tqg41NFOSseYmX+DfNRxJs5X10yH+CvfYII6o3VzejHJk
   LwcYCaKutn7Zd8lZ3b9SYbx4pzqxtyPeGwDIyCk9EX3uorOCJ7KlaG7VR
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="205597412"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 19:43:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG/duZvuuDhR0LjI7qCR0XGcA7MdSnwI1eLSMLWahA3vsK4dsrYCyh1RhniW9ROX51G/aHH1t59GyHtdNf3HquKJ71FOMUrzLnPwDHPnwT/4t74g2yADpA+3nXyCAzxJjdjs0NoQTY7YZtQzui7VD/x1ZtpwfV43B3DcuK6tj2znIafouzINVxyXHNOEg0JtHb0Yla8ZNqPWx5zJ5btzDJRBYv/Lh8a25pVeujsDdtMISAQ11Gbxvt9YqCho2hzagFM0vJ+JLVR8X3AE4HGz2B2mdXfItghNrxkR60emut42EsOj+GWVMoRuaKvSkfsrWxJV8ECNNrKV/3Qfj1ZSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1G+H2Em8oS9GXakomgCHED3iNn3CQ0vBBmBf4PDa00=;
 b=ZZLZ+HOK3lLI36JgyJIFsG8g8CvBmocNzmmWnyZYNQIUfieAWTY6LbiQbq7G7QSPATI8qIMqlhhX1g2W9VVY31dhtcwWUvtXisr7IStq4Z36TTdbMMJ215INuFX1hPpmkW1URd3EA9YyLL2zKSVl/DmC2QPpq1NghPHEl9m7C9+l5e6xjG7dgaiRIIloRrE1j2WGCAmEcH4h+akF1XwEKcH5ufgiLmY5ZxlaYW8RlROOBIzGoR1ESSV5fohpXFDh7o7SrLvTJKWCpv4CAL89tIElHVujAyloEDVqfDZvE7Ey8w9nZaPn2nrHV5Jvf8e6nzvXl0bF3/N/6FNlBcvwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1G+H2Em8oS9GXakomgCHED3iNn3CQ0vBBmBf4PDa00=;
 b=FWduamqmW7nadYzj2vBW5OkPPxOFami5i063irl/z3ctPw0KLlNj+g1F7fkAys5atI0s77c4cMSrw6TQ6JOgZOtjkFW/RZqaMd+1mQgieZGqALWuAtFoIEn7xVjUo9jdzPcbeu7ddZMfQWpZpCwQnsgYnV/iKmiFT/F2hYUn5/g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7204.namprd04.prod.outlook.com (2603:10b6:303:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 11:43:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:43:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Wed, 13 Jul 2022 11:43:32 +0000
Message-ID: <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 422fddc8-d100-4d7c-455e-08da64c4e9d1
x-ms-traffictypediagnostic: MW4PR04MB7204:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaY9GaAQs4P34BSz10enDa4pzsW4QaYWfDBsz6ayOB8UZr3vBtZFhMz3aRqR2nxAKSppNansiEQHVwTR3sG4xvZEuGgybJkrK1Tjw98WJk6Coh5om4w2nNPgnJLal6CVmQ3Jq9Q3KkJB044djZjKfICmBqqU95JaIGeZLVVIf6MmuFjdv9vLj1iOhlv7j6y3jndy5+vph6OCu4Wuyhb7bf5NycwpP1qVJ6ry/gL2iaDSqXn2fcI8HGn6mQyu2N67RHM2se1d7eT6Vh9/h6940+Lr9jHgE42/XLOynMbxD1fJ6CGysDo5Y0qQpt/sVbBMWTz8ooAVhvEJpSUuQoF/+Tp41T8u6QPKoa3os9APGwbC9m3WwuqNx57NGq4mposqUggLlb/jxtWfV55hvXT+TcB1gl/vnfjNbKb6XM1fLt2LDV8sNUaWD0vVwT7agMLTZyC/LRNEn7qmAYyNEVNIWS9xM9hl69mFoJtPQVoEYsS4AXGKEtE9pyNxpPZv+9aGoM2YIAbIuSYYrA8TFhzYXmU1591Gj+sK8tETpxerPoCqnOFHGSVF0x6f8jjRIJVE1NTTHRcXaX09Q6QGS8Rkk3SnNjfP0yM9VZ6+9vmbuPNWYtpzzI01NG3J6S17eLskKcY35HBg/wAiJIePzx0F+wj/aGGak3fhYeEhePWRha3LA+o5M05y/0RN8Rnb6L1KvBuLUGRP9gXcv0Aop6eRoaj3BwIRheIWeEz8u8e2MhD8xitEJu70KshpUZO33r6H+MaFl9yGEcyF///R7TBSjVKVnMwyR5ye+hthaE8WsEh5xKP9BN8LwzPmDymONB8y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(91956017)(186003)(83380400001)(55016003)(38100700002)(122000001)(64756008)(66476007)(76116006)(110136005)(66946007)(316002)(82960400001)(66556008)(8936002)(71200400001)(478600001)(52536014)(41300700001)(8676002)(9686003)(66446008)(2906002)(7696005)(5660300002)(53546011)(6506007)(86362001)(33656002)(26005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?exvLqQDY13OfuTonyfK6hQ7tBRGFtcnW3U9vhPmOKad0odQGCm5V//6LhDN+?=
 =?us-ascii?Q?FAYi1z8qxgZFfHOBBoYUnCRxojwKSNM1aY+BE14t/2kAhpVbzWD4jPEekvqu?=
 =?us-ascii?Q?bH+YOqlKmS1kzXGTEWLmhdXyjs9eroFmvQKmXe2plRYzCDO739SlIfHCQtl5?=
 =?us-ascii?Q?yAFHyFo9JwZ26Me1Pu+IbU8AlG5sDIl86zqBtFBqgw/THb/1XUzl6q6o7eFl?=
 =?us-ascii?Q?TDkurfF1SyKwmCm2eHtUF5I2FtnvsAip+SKDQJj1xNwF1h32qY8UTksy9KKF?=
 =?us-ascii?Q?tD6+p8qyiHalPA+oq/QmjqBmJz8UPxSBktX+ZOMjNHWs2t04sx9Ofs4NH1X+?=
 =?us-ascii?Q?NSsG0w1RtS0c8h0us0Vi6kCzuN0A7BfeKC1vBxBtM8xzM5NbaODD4TkJ2KVB?=
 =?us-ascii?Q?wYRM9GDbO5vSb9cY3yW8tn9rOfwevdQrPeFipC69Tvh3uxhuYzfpJNQE4eXR?=
 =?us-ascii?Q?Jayku1j6f+BhxBOZq8dw5arXwDmdDrtkCeilyxhBzBfQKc8oxcXAaxEgZJUK?=
 =?us-ascii?Q?IQ0x1pSUnbQ1Pp8Bo2zavvmftWBQWffytwWGWohQZhNfYcfKTLu3YNOONXuW?=
 =?us-ascii?Q?D06WyiKyU36KVK5RF9rL6u1qGw6l6iis9yVLmtY8lB9aXbVQknKj0llax/av?=
 =?us-ascii?Q?82Z1evJjF5F+uaHFfk1ad6qJutdTjbubzgzGvfCKwuecyR8091Tx+0hgQ33C?=
 =?us-ascii?Q?s6P2BkH07eqqOxWjbym3Dyqyekj4Gi0BNjXxdseL06tqxxFJaG5XdpXAQObz?=
 =?us-ascii?Q?XKEuHvZO56pPFN8F/viSjDB/7uMC5S7KEQEfPjig6DbNxXh4OtMjHD1c8Dlz?=
 =?us-ascii?Q?vgbiZhewCU5PRKSn/740S7Mi6N1T5De+mJrudt2BWRfMKGe4BZbT9OMsOnwX?=
 =?us-ascii?Q?GxyOyM5Ldss/2MaDO1B0cgL++cbEQIN/Uc65+qZyekhwV3wb6YwjZvMCqKzs?=
 =?us-ascii?Q?PItre9SN0k65iz0lKlp9IVOFj6bfFIFhGM6Ez4qmW1rEmq+r4CjcxpuLee5I?=
 =?us-ascii?Q?WKynFwXMVLsaykwWjpDufX4oELGvxzpVVzIyJhDnwJqIOuu41nOoT8pxOmUJ?=
 =?us-ascii?Q?w9s6euaTViWl6aHq4Nu3s8vx8KLrEzAw88O7x6FkL46XXKwqWbCufEIldCJ7?=
 =?us-ascii?Q?AGTRvovQbPjchnk4/66gcjotAjU6oZH8FtSkxvwwLEAIoQcgeTCv2QScPXgu?=
 =?us-ascii?Q?Ll9tlqcdMBSZNtYMp6ZxDi+0rc0O3lnugb0Fyi/nS3qB+JjTyikdNeX810HW?=
 =?us-ascii?Q?VokjMQL07JemKrZSUHjj6p63gH19X+u4r3KI7HkD93SozxMUFjRk4BwEaNkQ?=
 =?us-ascii?Q?vD/A7f+drXRuuaAhkaHQJRGOyRWECptZIuX3i43PCGnRtT/xnSUCXwVOsa21?=
 =?us-ascii?Q?SlsxghgW2Efn/lKMR8ypi3eItj+eTMPZYCKWN+T27/yMRYTZsOa/m9zwPgfI?=
 =?us-ascii?Q?I+f9ojOqYQ2DKHUJ8UOgJxcL06flTzSJDUAzBV+4Vov9MxxRjQSTMB+Yfs8r?=
 =?us-ascii?Q?EUwnHiGHKQy4d8M0XWKlsNhtyZNHGk5FPIC/pggBd3UP2mEM2/HN5p0fjWoU?=
 =?us-ascii?Q?jW4rr7QgvL07Cfj/isIzhjnUCam0cFlVVXqnr0ZtMZ23yoS0/YXBU7d1lp+m?=
 =?us-ascii?Q?4U0gKS8RKUJjT9WdJIqgdAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422fddc8-d100-4d7c-455e-08da64c4e9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 11:43:32.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/6dDJyTjP5pWdM0QOkWFVgoe5cQTxvdTgNGd0ZFEurrpFhZMGTk/zofGIK5did/D7hjBeUAJukZ7mAFUUVaCBblHW6HZtE+74i628fxuOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7204
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 12:54, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
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
> =0A=
> Here I want to discuss about something related to RAID56 and RST.=0A=
> =0A=
> One of my long existing concern is, P/Q stripes have a higher update=0A=
> frequency, thus with certain transaction commit/data writeback timing,=0A=
> wouldn't it cause the device storing P/Q stripes go out of space before=
=0A=
> the data stripe devices?=0A=
=0A=
P/Q stripes on a dedicated drive would be RAID4, which we don't have.=0A=
=0A=
> =0A=
> One example is like this, we have 3 disks RAID5, with RST and zoned=0A=
> allocator (allocated logical bytenr can only go forward):=0A=
> =0A=
> 	0		32K		64K=0A=
> Disk 1	|                               | (data stripe)=0A=
> Disk 2	|                               | (data stripe)=0A=
> Disk 3	|                               | (parity stripe)=0A=
> =0A=
> And initially, all the zones in those disks are empty, and their write=0A=
> pointer are all at the beginning of the zone. (all data)=0A=
> =0A=
> Then we write 0~4K in the range, and write back happens immediate (can=0A=
> be DIO or sync).=0A=
> =0A=
> We need to write the 0~4K back to disk 1, and update P for that vertical=
=0A=
> stripe, right? So we got:=0A=
> =0A=
> 	0		32K		64K=0A=
> Disk 1	|X                              | (data stripe)=0A=
> Disk 2	|                               | (data stripe)=0A=
> Disk 3	|X                              | (parity stripe)=0A=
> =0A=
> Then we write into 4~8K range, and sync immedately.=0A=
> =0A=
> If we go C0W for the P (we have to anyway), so what we got is:=0A=
> =0A=
> 	0		32K		64K=0A=
> Disk 1	|X                              | (data stripe)=0A=
> Disk 2	|X                              | (data stripe)=0A=
> Disk 3	|XX                             | (parity stripe)=0A=
> =0A=
> So now, you can see disk3 (the zone handling parity) has its writer=0A=
> pointer moved 8K forward, but both data stripe zone only has its writer=
=0A=
> pointer moved 4K forward.=0A=
> =0A=
> If we go forward like this, always 4K write and sync, we will hit the=0A=
> following case eventually:=0A=
> =0A=
> 	0		32K		64K=0A=
> Disk 1	|XXXXXXXXXXXXXXX                | (data stripe)=0A=
> Disk 2	|XXXXXXXXXXXXXXX                | (data stripe)=0A=
> Disk 3	|XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX| (parity stripe)=0A=
> =0A=
> The extent allocator should still think we have 64K free space to write,=
=0A=
> as we only really have written 64K.=0A=
> =0A=
> But the zone for parity stripe is already exhausted.=0A=
> =0A=
> How could we handle such case?=0A=
> As RAID0/1 shouldn't have such problem at all, the imbalance is purely=0A=
> caused by the fact that CoWing P/Q will cause higher write frequency.=0A=
> =0A=
=0A=
Then the a new zone for the parity stripe has to be allocated, and the old =
one=0A=
gets reclaimed. That's nothing new. Of cause there's some gotchas in the ex=
tent=0A=
allocator and the active zone management we need to consider, but over all =
I do=0A=
not see where the blocker is here.=0A=
