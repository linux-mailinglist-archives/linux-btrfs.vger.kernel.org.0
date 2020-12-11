Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52752D7B30
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgLKQnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:43:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6420 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388081AbgLKQnP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607704994; x=1639240994;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ct98Jrwb/8E4ZQK4CDjYas9qOZC4qXuLmWO3n9WnRKE=;
  b=SKnBY4ifuv4CSpDtBmTN/vtN1v/Qg4MvB5kEGHJ/F0aST91R8BUettFn
   rwqUWFfPnq8e8shLuOnjL4Lc+/9iYu1/rhMQXb7gAxMKJLaQpkWNYLvfv
   nP8c9apAYuWLapZogtxo+7dayONKPDkH16GGf8y740MWy3saUqxLOfOFD
   LKjJqNlGxgDSldN+k4p7+sFHkHEwFCVZgzNyNN9Eg61bUEGY38S25MGeE
   GR+4+tUmuZiGflSpk0xhULd25BFJKAh/HnezD+ejQXmlP3yAmuD7YBScE
   MXLtcu12VGJp0QLQRWNChOag5kJc51UuwcSirJEn9erKsfyC8rRw9yKB1
   A==;
IronPort-SDR: eeP2kRuncJInuIolTNz7tEua6ZuR58O5NbTVBGKWd7iQtu9a9B9o+iOriDo4RyNiJ7WiY+w4hm
 FRZf1XPkprkR2o+EbOJWXOF85DTkQzaZ/fyETscxt3UzqL/LXQH2JDtvnM699v3ZackfTm6lfU
 oDfM0G8U2EbULwHf9Cj+VxjplSLXi/FXSnbgL8Uy+WZjDXIPLibCh0t4b6MQGNc3spYLWF0QA9
 hj/U8ODDGSWrVU0DwSwh4hb71znsTEKvC/0qt1BAHq2ebABOTQN8dSSv8d5YfWiyZHkB7oOxjT
 iCA=
X-IronPort-AV: E=Sophos;i="5.78,411,1599494400"; 
   d="scan'208";a="159412507"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 00:42:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7fTGbP/Pc9xP9ZguvW0LilhaUWChAGW9kueqxvD0H7VtR17WJ76MYTv2q5ckN+qS0LTUA0e3Vlguj18nrIJ9dAIqtReJQXrTPFgorz80wNvOR5xitYrkcjMre8hNoYDLo2dRVcM1xLNDB0pQtYKRKeVh+DP2bary5xvhR+lRRJC0qZEyeeN7RUD4RVjaJGI+7jpE6VwJRXcgQicYkZgwoDDkx6G7lN6aXgMuTWGBSVLwgLGEpWT6D3/sqL3SPMrz9vHaPOhsy6GAm4c6G1EEmGbni8pTzNaWbcCsS4g7hnfPQWTLYPjk7/BIKd4vahXHzcEELG5BhFtP8T0TzOVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct98Jrwb/8E4ZQK4CDjYas9qOZC4qXuLmWO3n9WnRKE=;
 b=QMChWMjODX9+gY5U/mtiCEHvqlLIEBt3PO3C/kE3KA4zvhDCTvmaXZZEL1b0Zb/6R7D2ofoVnyPKfBHkMwQDd9WP/f6t76z+fR44SZ4DemqTxfKFyQfefSH6QCKg8dB1rGNh9C7vvxgk54y3ZX2s4EfFq9JkLa9JI/r28QgZ8iTO77kUgWHi/bJTK3wzyzxOpi/UTaM1ZwnAh3yvBuMZQNlZJFwBUz19TB97l8/3DMBZjGMqbYPBCuUse2ZqmXPuF7Hs6y7ZoG329gZJY8B/7A7PXC3wrizBLbQ8AIaRvKX5OqkRh+kgAv9ElYnikzcnDFPScKRmFmtzCGes2wevBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct98Jrwb/8E4ZQK4CDjYas9qOZC4qXuLmWO3n9WnRKE=;
 b=Or1JIHAZ7Lj0PzFB1dkHs5wyM9DoFLtxYD/LYfqIq6y3mQWGnoTCFpNvHfTjnjxDzgdJVo8E0cf9MPJPR4NcvobqGxx7B0BxcJ/bQOF1S8tXYQxTr7vGyVo9GhVmvW3/mvIfAE7qphgJspBsPRHnnhAeIVNc3QnEU6HWGUbBsbU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4928.namprd04.prod.outlook.com
 (2603:10b6:805:9d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 11 Dec
 2020 16:42:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 16:42:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejHW6Ri+MjBUuw45QEtiWblg==
Date:   Fri, 11 Dec 2020 16:42:07 +0000
Message-ID: <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
 <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201211155348.GK6430@suse.cz>
 <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 647b9416-a55f-44fd-7ea4-08d89df3b29c
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4928DA3EFFD1588EC321F2049BCA0@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSuTKRhcs6VYXyO1R4FzBy/Qmjrre55PyY+mGgAC5zq1V9yCR42E48ytrgaIzo/D5JohMCCG8+c+uCl1xu21OYZuq4YQE2/oaxEqpf4jTQ8B8k8lsA47o87lWG6Q0aqU1MOOpXKjqmDsQ7cnDzM4rhkfQ3Q6byZN/KeGnSdycH+3abQ0VuV3AQphbQSt2Pz75rTO7quXoKN8jEITUo+GvFtWFUrZ9HmLKh+rq+a4fIGtH8e+QpC/0jN6mEzUeazMFAgUpzuG9CrsoHhe4RRnSRio1enhqKfM7d/DtsHM3e53plOAYLdd4ruD/SkZlOuH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(8676002)(64756008)(26005)(5660300002)(186003)(7696005)(83380400001)(52536014)(33656002)(76116006)(54906003)(6916009)(9686003)(86362001)(4326008)(55016002)(2906002)(66946007)(66476007)(71200400001)(508600001)(6506007)(53546011)(91956017)(66446008)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y2rLBvcHwYyVb9sgmG2yoh3k/AJY9JFAKfjwig+QAWoDMxaEfdM+LmPNOvf5?=
 =?us-ascii?Q?vuNY2BeIOM/Ng6SelzMSjEYMjzcwIMmP+53+2q1MgYoberJRHcJlolRfGG40?=
 =?us-ascii?Q?vgLBzWDB6OnSiR9AgQALbtBgP8LseO5iwgkXgRcB/rSCef3H3tSSmUYl6S6N?=
 =?us-ascii?Q?kn3bNKDO6KtYq9wu7kaP7gm1558c63WGmo4daM9bZYRZksgEZHIj9Zsg7iZL?=
 =?us-ascii?Q?NcluKt2VjzIW3FARYl2TmSaixGGrPMM22xVahAOb3cgrFfn3N5ycUCDuswOq?=
 =?us-ascii?Q?bMmo2qmEJfIMwjhF+nOCQPAdIu12eA47Ry2tgJHVC66VKUI1KH+Im9rasAL/?=
 =?us-ascii?Q?QSaIZwuHPYhwI6Mnh4Im3vQuptUA5zHhjA34/Ng4fhOfaPmixTwQ/400cScq?=
 =?us-ascii?Q?ci5BxtsNPFSJiKX3cJm1bl27xHIYO2nR0VJlA6FVMiEN3Lv/77dOot/SBx1Q?=
 =?us-ascii?Q?JyxLzOYuOSenIFwYLkq02ucYuEIn35Xd63F95lQPnbpq/51VEBrt4jK5gkC0?=
 =?us-ascii?Q?mk+wG7xwgPsx9VivedMCpjqNEHmLrzQWAYDW6WrbVP23zVbFpNDnzZQbNijD?=
 =?us-ascii?Q?DT3X94Z2PAfYAW8KiOllVt1eGqgacFtGPF0Oyol6hBVjp7/I2GLo83f4fQBy?=
 =?us-ascii?Q?3ccJIc1LZStg6qH4EwOisH1Pxsujp2IdP5IkLxcPJ0dXVTyvjciue6MDsfrg?=
 =?us-ascii?Q?aLbVAOfgysTPCT1pcgibx/qj8qsTi5xldWQVBNQTvkj8GsX/CfMjcltJt/ZZ?=
 =?us-ascii?Q?zLedqZ8a65JjmMaAw+ttA7Z8YnUoO9UNcfjoXQQzGxStoaXzv3JatdUeKYPG?=
 =?us-ascii?Q?FDaQZzm1APQ1VDhLUwG391sXW3SCx2OVngT6JvgxE1ZiR/3WtXXQ1qBq9iQn?=
 =?us-ascii?Q?uAYFIczzebHb6DpF3B/yvaLEOzBqgS4vRuzK9kfqmCCat893rzms4DwUq1Fg?=
 =?us-ascii?Q?g4mxXv1fWWav11GBs45iVThEJkicVAL3RUmzvNQV6KNQy6q7MqR8yKWJ6Jl+?=
 =?us-ascii?Q?JXLd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b9416-a55f-44fd-7ea4-08d89df3b29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 16:42:07.1189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7Aq2R8097ZmzqFM1MdjCg2+juH/Zcyf/TRg7mFQaoabJHTeF5d/POISiv3B/THK8tqtSWesHM9dnWq2BA9dFcslb7be9oXhftzJiYtmMYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/2020 17:02, Johannes Thumshirn wrote:=0A=
> [+Cc Damien ]=0A=
> On 11/12/2020 16:55, David Sterba wrote:=0A=
>> On Fri, Dec 11, 2020 at 06:50:23AM +0000, Johannes Thumshirn wrote:=0A=
>>> On 10/12/2020 21:22, David Sterba wrote:=0A=
>>>> On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:=0A=
>>>>> On 05/12/2020 19:51, Sidong Yang wrote:=0A=
>>>>>> Warn if scurb stared on a device that has mq-deadline as io-schedule=
r=0A=
>>>>>> and point documentation. mq-deadline doesn't work with ionice value =
and=0A=
>>>>>> it results performance loss. This warning helps users figure out the=
=0A=
>>>>>> situation. This patch implements the function that gets io-scheduler=
=0A=
>>>>>> from sysfs and check when scrub stars with the function.=0A=
>>>>>=0A=
>>>>> From a quick grep it seems to me that only bfq is supporting ioprio s=
ettings.=0A=
>>>>=0A=
>>>> Yeah it's only BFQ.=0A=
>>>>=0A=
>>>>> Also there's some features like write ordering guarantees that curren=
tly =0A=
>>>>> only mq-deadline provides.=0A=
>>>>>=0A=
>>>>> This warning will trigger a lot once the zoned patchset for btrfs is =
merged,=0A=
>>>>> as for example SMR drives need this ordering guarantees and therefore=
 select=0A=
>>>>> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).=0A=
>>>>=0A=
>>>> This won't affect the default case and for zoned fs we can't simply us=
e=0A=
>>>> BFQ and thus the ionice interface. Which should be IMHO acceptable.=0A=
>>>=0A=
>>> But then the patch must check if bfq is set and otherwise warn. My only=
 fear=0A=
>>> is though, people will blindly select bfq then and get all kinds of =0A=
>>> penalties/problems.=0A=
>>=0A=
>> Hm right, and we know that once such recommendations stick, it's very=0A=
>> hard to get rid of them even if there's a proper solution implemented.=
=0A=
>>=0A=
>>> And it's not only mq-deadline and bfq here, there are also=0A=
>>> kyber and none. On a decent nvme I'd like to have none instead of bfq, =
otherwise=0A=
>>> performance goes down the drain. If my workload is sensitive to buffer =
bloat, I'd=0A=
>>> use kyber not bfq.=0A=
>>=0A=
>> I'm not sure about high performance devices if the scrub io load on the=
=0A=
>> normal priority is the same problem as with spinning devices. Assuming=
=0A=
>> it is, we need some low priority/idle class for all schedulers at least.=
=0A=
>>=0A=
>>> So IMHO this patch just makes things worse. But who am I to judge.=0A=
>>=0A=
>> In this situation we need broader perspective, thanks for the input,=0A=
>> we'll hopefully come to some conclusion. We don't want to make things=0A=
>> worse, now we're left with workarounds or warnings until some brave soul=
=0A=
>> implements the missing io scheduler functionality.=0A=
>>=0A=
> =0A=
> I think that's all we can do now.=0A=
> =0A=
> Damien (CCed) did some work on mq-deadline, maybe he has an idea if this =
is=0A=
> possible/doable.=0A=
> =0A=
=0A=
Ha I have a stop gap solution, we could temporarily change the io scheduler=
 to bfq=0A=
while the scrub job is running and then back to whatever was configured.=0A=
=0A=
Of cause only if bfq supports the elevator_features the block device requir=
es.=0A=
=0A=
Thoughts?=0A=
