Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52D72D85ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392046AbgLLKf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 05:35:29 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLLKfY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 05:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607769322; x=1639305322;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gYjP6AagjzXgPBkgT8nP2bhCnFCOSbdEB95zi3c+5hw=;
  b=fWpQPXUn28IqE6al/zxYFiMiFt52Vy3nIlFBogSjQu1y7u1oO6P7r1pX
   5XkE3/1SNcTwgulCTWaJ6nEISGAjldb3cs9itOTj99Fs5UzyI7Z3GxcHT
   jxbxGKfKekP7PmseefjAZlQjuAm6GmvmL1/zllLDzh3sG7uczFN+qoxY1
   6ICJs5s5rq1RA947Ayog6DzihH9jM0VQiG5R8vhtzKpJXdr+GGPn2xBwU
   2sIGNsUorbu6C2noc+3l7H2jCwqdMhJfTjU9Ql5e27D+DLRRhnITe7h+p
   DE/KiZduJOc+UT41/7FOb9oyo6K/O2OhM7GAS3Wa5yBD+8Kpspl5BzH0d
   Q==;
IronPort-SDR: xCiO9QouyrnjlDpXFHdJitr8GdtkkqTjo1foOOepRgTNF+olZxvAidypwdN7Z2GzKHtbQ7vrHn
 ILWuSptOCxJcbiM7Yhdd/bQfymLFJryq+gRCmLxxKzNi+apLSrkR91XuOXh+63lhte5O4mxjoq
 mHdTbKaPED29t37iMUz5lSoZn8ChDBrwUjJaFu2OI9DY8AnPIz6DyQmsSEkYBE7PxPcV97Nauf
 B0y6gxsv+dLpF/7tbqEmYQmB/SRlhpPlutTK/aq7+V5SAxgdVnPLKOAErxJ8haDeyMkH4RdByH
 zqc=
X-IronPort-AV: E=Sophos;i="5.78,414,1599494400"; 
   d="scan'208";a="265164801"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 18:34:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFU5yHJD9YJs9ykuaNwNqMdJm6NnGF6FVT62CQiX6gaiTfTMOD4oUm5RUcrbMTC+XBE0B5ni5cyV88QxVRFcvy1yOEoZArRkvZQJHesVXVzRpCSG2c7QPwm9s48s9xcXtNHQ9zAZRZr95fWPqlLEGBbCpqIT75EP4ZdRRYCTk/oX3OuFZ4D8u2E3KP/MyWd9H0MRQ0xiVcVlRB6VimF4Mxc7AL5fNsJhX67BYpfL9hU554qjHD3/YpXLvAnoOWmsTV78OzMI8f/4IsnTyq7iDXHYhLkRxyJbkwa09PRcEJvJaw6YCUuDoiPigIdtfRqd20EliOZlkphx22MnU2kdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d7sqIj/zmN5tUoxVWpMOSddJfLUlFpxn0z6+vb0nAE=;
 b=mYUvOQDdFTELu1cQtzPbK/F7ix/ND9YTGG+eVH6Snco2bUm1lZ1/0CkLC2UT08iYOjsPFVBk0RD/Luwvp2SnSRQOboP9CbLnK28R6W9hNPX28g2RtR+iTjBmxL4TpWECFDBQL/CaBVglkNyEbmYLdjvXz2IUCt5u05SdBVZWKu3nd6zPyOo06M7TvCzff1xeLWkAxeo6T0af7VuuSZULAA4F1ylx44xjgncmsEwane4kvExDL2hSuhZXIJJvN82kPzXgnaOYOWYQ33tqLQdZR+z2OhfiX36f4qb13e3CyxVfdpmpO6NmqeGhAm2al15x9BndYROtjmK6TrAO8i+ZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d7sqIj/zmN5tUoxVWpMOSddJfLUlFpxn0z6+vb0nAE=;
 b=TsPLDKEbDhIHER1NPnCajYBBEa0IqVADGPbkNOc4qqz6HnKOWPQ4AcEYbBxYXvMfLH5cDcN0sJqrRzTDm5i+QNGiOrJWEy32f4g7Sm1o5l/pCyFCzbVs73BsOPjmvpZ4m5ywTngK5wFo1aTG93btYgFq2xEwBsE0DXTsKK2IU8Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2143.namprd04.prod.outlook.com
 (2603:10b6:804:e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 10:34:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Sat, 12 Dec 2020
 10:34:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejHW6Ri+MjBUuw45QEtiWblg==
Date:   Sat, 12 Dec 2020 10:34:11 +0000
Message-ID: <SN4PR0401MB3598EA952D5F942C165422819BC90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
 <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210202020.GH6430@twin.jikos.cz>
 <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201211155348.GK6430@suse.cz>
 <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <7d14b742-feef-58b4-97da-45d05132b02e@cobb.uk.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cobb.uk.net; dkim=none (message not signed)
 header.d=none;cobb.uk.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc34b8bf-1a8a-4869-3b9e-08d89e8976f5
x-ms-traffictypediagnostic: SN2PR04MB2143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2143EF1128F5DEADF8143D289BC90@SN2PR04MB2143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQMCAAha69M7+YAcRAKLBsqBTiRWeCTmZM3XReNohPCBVCQ7q1yTqPjpHBLbcyO+Q4OD2hH2wxJgtVUYrMJNlM2Zbvq6NdLdlG2pyNozpMEnnrVZHO/M2mFzukfMdDgKbGzZcQRLxNEZKnTShhst7BUSHGtswQxP3moYQTBFi6gHD1uvuHHdhT3r2aklBZlM2VTUaQ38AEY35MpQfWOH6Ty+3ExZ73wdyJbn1iqeIb9Ryk2o6I8jBvqEUV/68U2azXFz9bv1gc+DCPp+D0G8oOkdQQW5w8ikrPyohqlQ0kdebaRrZMMY8tAYUVzhifvI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(9686003)(7696005)(86362001)(66556008)(83380400001)(6506007)(4326008)(5660300002)(508600001)(91956017)(54906003)(71200400001)(64756008)(66446008)(66476007)(2906002)(76116006)(26005)(53546011)(66946007)(8936002)(52536014)(33656002)(186003)(8676002)(110136005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lCwTyS/lOjeJU0wNBGASrgHBtVHE32RDKtMFMGiDX7LDUPceusdLvPtxtB2c?=
 =?us-ascii?Q?zZNRU+NmFGrG81RissdxguzfMrlATMSwHSYMsnQ6lGSu3xe8LkQG7UtyDap/?=
 =?us-ascii?Q?UwAq2AfCXq2w2fI2gTrvM4FLcL8fDWFo0bvEr6q9cGMcsgnK4JZB7/js0AsL?=
 =?us-ascii?Q?4l5jEYeRnMy3n2d0EIFvgrUgFiotSACjrXBT9jzObOPF/V7bAbKhX6j+tOF3?=
 =?us-ascii?Q?TmZyOhF7a4cvyoq7tO0T+oDDBpKffCiqTf6zwW6WJNu/Z+9M8+hfIceWtcEG?=
 =?us-ascii?Q?WPk9AYetfyLueCXpaDT/M3cWLBF4xcqSRVKW0Db9CKYH06IJSKJQVEVUtpbg?=
 =?us-ascii?Q?Jtb1dqjLFkjW2CiYExIZKSnEByU89A1fw3Egx98RsbnsORJ99zYZ9FoZandh?=
 =?us-ascii?Q?sNzNKnpdSsdML72GbKSEgdVAhZxq9DAr+DyxTsLL/rJxtIKIPZhVVIXpLHho?=
 =?us-ascii?Q?ohvrwVsMcvy7OGfTRlShAItKDvzE4IEnyG9HhTL0FQBMLdP4Txi57q9jfAEe?=
 =?us-ascii?Q?acj1GIZmgaEQI/VfT6SKNLgrvNNxFvclAeKZlCPVVEP/cxVGCXAHLYRJ0aVY?=
 =?us-ascii?Q?HuNlAOkouSZ0dla8lyX9b3eHQ17TBQ5W531nUK/xHPjcvPn73disCqp3qyXB?=
 =?us-ascii?Q?4TZ2uG8NK/UdIE5VUYxvryWBQftWDveR3khBTxridkCSF6NxkFlsr+qCbEqY?=
 =?us-ascii?Q?RL57tSPpuRSPbj/Rvv3sxy5zyf1dDr7t2NPqU/OGRyf2/uXvVurY3js9DC0U?=
 =?us-ascii?Q?pElzrK/BmVTCKzREYLi/k/3dFSbTOnqcE8wQuoL4bmUPrsFNQkJX0v24frB7?=
 =?us-ascii?Q?ix9BiJcKriEpQxsEYHYDjPFJO4UwvVDOSVSVaHdPrU2/79zab9eck9p0BD+f?=
 =?us-ascii?Q?Tap1ybGLbPRb8ShWs3tQhrYDpcFpjXVS9etH1rVkF8S1YWxV7PARsPcV5NQ3?=
 =?us-ascii?Q?QyIK/mXa1zah6T8yVZKb/Hq9jgDnEr0FXYU3rHRtn7qb7KmoiCe1XcgnvcZi?=
 =?us-ascii?Q?skrj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc34b8bf-1a8a-4869-3b9e-08d89e8976f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 10:34:11.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr8wxmhlKzpqmxB5NSMaRj0ZKT5cB3BPc+YBAHknPuYiNSNv7UT2iF8hDJGR16xWCg2ORT68a6dphjrx9AzVxUjalLS8WxlR7vg3zVBPZmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2143
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/2020 18:05, Graham Cobb wrote:=0A=
> On 11/12/2020 16:42, Johannes Thumshirn wrote:=0A=
>> On 11/12/2020 17:02, Johannes Thumshirn wrote:=0A=
>>> [+Cc Damien ]=0A=
>>> On 11/12/2020 16:55, David Sterba wrote:=0A=
>>>> On Fri, Dec 11, 2020 at 06:50:23AM +0000, Johannes Thumshirn wrote:=0A=
>>>>> On 10/12/2020 21:22, David Sterba wrote:=0A=
>>>>>> On Mon, Dec 07, 2020 at 07:23:03AM +0000, Johannes Thumshirn wrote:=
=0A=
>>>>>>> On 05/12/2020 19:51, Sidong Yang wrote:=0A=
>>>>>>>> Warn if scurb stared on a device that has mq-deadline as io-schedu=
ler=0A=
>>>>>>>> and point documentation. mq-deadline doesn't work with ionice valu=
e and=0A=
>>>>>>>> it results performance loss. This warning helps users figure out t=
he=0A=
>>>>>>>> situation. This patch implements the function that gets io-schedul=
er=0A=
>>>>>>>> from sysfs and check when scrub stars with the function.=0A=
>>>>>>>=0A=
>>>>>>> From a quick grep it seems to me that only bfq is supporting ioprio=
 settings.=0A=
>>>>>>=0A=
>>>>>> Yeah it's only BFQ.=0A=
>>>>>>=0A=
>>>>>>> Also there's some features like write ordering guarantees that curr=
ently =0A=
>>>>>>> only mq-deadline provides.=0A=
>>>>>>>=0A=
>>>>>>> This warning will trigger a lot once the zoned patchset for btrfs i=
s merged,=0A=
>>>>>>> as for example SMR drives need this ordering guarantees and therefo=
re select=0A=
>>>>>>> mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).=0A=
>>>>>>=0A=
>>>>>> This won't affect the default case and for zoned fs we can't simply =
use=0A=
>>>>>> BFQ and thus the ionice interface. Which should be IMHO acceptable.=
=0A=
>>>>>=0A=
>>>>> But then the patch must check if bfq is set and otherwise warn. My on=
ly fear=0A=
>>>>> is though, people will blindly select bfq then and get all kinds of =
=0A=
>>>>> penalties/problems.=0A=
>>>>=0A=
>>>> Hm right, and we know that once such recommendations stick, it's very=
=0A=
>>>> hard to get rid of them even if there's a proper solution implemented.=
=0A=
>>>>=0A=
>>>>> And it's not only mq-deadline and bfq here, there are also=0A=
>>>>> kyber and none. On a decent nvme I'd like to have none instead of bfq=
, otherwise=0A=
>>>>> performance goes down the drain. If my workload is sensitive to buffe=
r bloat, I'd=0A=
>>>>> use kyber not bfq.=0A=
>>>>=0A=
>>>> I'm not sure about high performance devices if the scrub io load on th=
e=0A=
>>>> normal priority is the same problem as with spinning devices. Assuming=
=0A=
>>>> it is, we need some low priority/idle class for all schedulers at leas=
t.=0A=
>>>>=0A=
>>>>> So IMHO this patch just makes things worse. But who am I to judge.=0A=
>>>>=0A=
>>>> In this situation we need broader perspective, thanks for the input,=
=0A=
>>>> we'll hopefully come to some conclusion. We don't want to make things=
=0A=
>>>> worse, now we're left with workarounds or warnings until some brave so=
ul=0A=
>>>> implements the missing io scheduler functionality.=0A=
>>>>=0A=
>>>=0A=
>>> I think that's all we can do now.=0A=
>>>=0A=
>>> Damien (CCed) did some work on mq-deadline, maybe he has an idea if thi=
s is=0A=
>>> possible/doable.=0A=
>>>=0A=
>>=0A=
>> Ha I have a stop gap solution, we could temporarily change the io schedu=
ler to bfq=0A=
>> while the scrub job is running and then back to whatever was configured.=
=0A=
>>=0A=
>> Of cause only if bfq supports the elevator_features the block device req=
uires.=0A=
>>=0A=
>> Thoughts?=0A=
>>=0A=
> =0A=
> I would prefer you didn't mess with the scheduler I have chosen (or only=
=0A=
> if asked to with a new option). My suggestion:=0A=
> =0A=
> 1. If -c or -n have been specified explicitly, check the scheduler and=0A=
> error if it is known that it is incompatible.=0A=
> =0A=
> 2. If -c/-n have not been specified, just warn (not fail) if the=0A=
> scheduler is known to be incompatible with the default idle class request=
.=0A=
> =0A=
> 3. Provide a way to suppress the warning in step 2 (is -q enough, or=0A=
> does that also suppress other useful/important messages?).=0A=
> =0A=
> 4. Expand the description in the man page which currently says "Note=0A=
> that not all IO schedulers honor the ionice settings." It could read=0A=
> something like:=0A=
> =0A=
> "Note that not all IO schedulers honor the ionice settings. At time of=0A=
> writing, only bfq honors the ionice settings although newer kernels may=
=0A=
> change that. A warning will be shown if the currently selected IO=0A=
> scheduler is known to not support ionice."=0A=
> =0A=
> =0A=
=0A=
=0A=
Works for me as well. My only concern is, people will default to bfq and th=
en =0A=
complain for XY because of the change to bfq. Note, I'm not against bfq at =
all,=0A=
I'm just arguing it's not a one size fits all decision.=0A=
=0A=
I'd also like to see if scrub on a nvme really is beneficial with bfq inste=
ad of=0A=
none. I have my doubt's but that's a gut feeling and I have no numbers to b=
ack up=0A=
this statement.=0A=
=0A=
Nice weekend,=0A=
	Johannes=0A=
