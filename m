Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325241A96B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhI1HL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 03:11:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33657 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhI1HLq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 03:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632813005; x=1664349005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FMl43khR4W0jmonDUjOuKStT95G/0Cv1ln6VsshPzJQ=;
  b=ftYzpoPlPT4k/rGSSm4MILdzYLYhYaXtDwZ0sNMJ8o85tF+/LSMJkWRL
   EvpfMkPjSDad66drJuaLpcdaKipp63fTs0lXsy1/C2Z78AmyBscSt2WiX
   xbGfcXQU6A97UXgubWvX7cRe13wHGJZZPeifaV2s5XRG9w18hLIQ70PO1
   i9PIGT+xaIqX35cYQ78mjfJttLv2bpJiWrp5EZ52H/p4UewJQzBJ1oUm0
   JQyTUrx9fsJCL/rmTamQ3a1Tqe3U7GbM1hxGHrxax3OAoqv6fqoFxUG4b
   SL1CB4HnEqLS4IhsSA9BkOeb6c/gLSdAuvHoOQGNzrJnpvS/RbDgD3yXx
   g==;
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="185945020"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2021 15:10:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB++rHxGGf+ADXJ7i9qcqoCxkxWC3HB2DjYAP48LwGaly+CJE6KpVa7NZTjs2CZUwZ0HIcZXyoaS076O9IkFR7g6F7GQlSi4wo/B0JuzwkLjGEHWdN+9rEICqmOSPX9SGmhxNTwY7tMtLTcnceyWidY5knYTUDWVdO9RIukwE3bktOTkiKaNY2Dc99J4vkJZYNZQVLzzGEfPZN2qguMZTy1KW8bmUV++3kAvGOJQrQSe3BbcO8OPdkW/aoR9F6Favyk/bkSR9JmLJ123WmW6coplSdfzRUJw9icqmdZhi3vo2TY0Nms8PUMH+DG6OQx+iW2dPG0FK12TieOZwiu/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sZaH4+vHRlzUtegYRkC+jumCuNQ/3Tyvq8bm7atYpRc=;
 b=EAtSBBVzENOgupfi17SafUMf96BdObIJoUoYRU2d0sgPfk/GXRnq6rYLnJfYNsecSPzMDmuqZFQiQv9eOYegnj4a2EvBTxCkg9JcxsuVrpScEeFlsJPr+nouVFP89/60Tz9ZDEZVjmca+o5T0iBb15X6hD8oEYITsdm0aSSNar/t8ssNDGGr4w+bpmm5bDBgmROCIt0gWn+n4fMugXdBSFPt712XgtIJ3jQNLz3bYDxVNlXFzxqj1ntJTKrUdIaZ0tfkfi3SJDLtZQCf6bv+QVcooWGScmnnMM++rxfGjty0ZKJEveQhcsbP9lpEG10HryvbR1oiATFvbD/wieRQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZaH4+vHRlzUtegYRkC+jumCuNQ/3Tyvq8bm7atYpRc=;
 b=s3GD7x2jBUyY3o81YOIpuWt1zH0T33l0mbKZrC0yO/uIGJtjkEpQnCP9D3t2rEP77q6Hk5UReaKXJOeoWErErSXoTMrcsXR/gsw4ESotZzzhoEk0WqMbgfMogOAqUH4CE9n0xiYUhc0eMKVId5DPxM05GUOBme34abhjnbx2OEc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8358.namprd04.prod.outlook.com (2603:10b6:a03:3d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 28 Sep
 2021 07:10:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 07:10:03 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Sven Oehme <oehmes@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwRZ8Fj0FRlU2SoMhzGhNwNKu29x+AgAEwLQCAAFaggIAAAtkAgAACKICAAAF5AIAABGmAgAAD/gCAAACgAIAAAMyAgAB+mQA=
Date:   Tue, 28 Sep 2021 07:10:03 +0000
Message-ID: <20210928071002.jzm7e6ndm2qh6x4o@naota-xeon>
References: <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
 <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com>
 <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com>
 <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com>
 <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
In-Reply-To: <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecbe43fe-a7e2-45fa-c6d9-08d9824efe34
x-ms-traffictypediagnostic: SJ0PR04MB8358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB83580849B4FC2FF278D30DAE8CA89@SJ0PR04MB8358.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHN2ybf9UaEm1ywaqlsfAgWFv7jQ/5ACJDrdVBva6KUkVT6/vhlHGvzxaxDN5aXL9zH6Egp+RIFqQery9KPqmMyV0Mfa2KVpgS9nPabL5hUtU0ACN41N94nUjRbo7reNaNIeaR2eu2CwXf36KtNCvGLJyFfj2R4YR9ZJE0AV2q9/MnLcA1TiNB1idL/Ti4F5BdnNx1mkewrR21scEZioN03M0sh+4IgQSI6eAFMNeGxhRfvRNNRlDasUVXR8Kl7LI53Eon+YQR7Xryz95YnoG9PnYfxAUgjFVRF3PbmKDtZcK3/wmO56tzwVBTUrSXsPeu3Le2/z3FquFjp/YDcSxc5lEf+C453UOFVQ0ky+bb5FI8KDtItwnN6F15QxSOi54fZkH+mrtonzLnLkrvuiw4ii5rwH9q7ndBuyAyx9u2pH2Qx/LRfzjFeYnbJTebctoT/u1/64STH6yB1clI+5cd5Bga/gPvjITzIjzS6A0TqHJRbzvdQmN3XJQBrLOa3GWL/FhVDOhAcXK4nXLaaFsp1uOG/Gw7bFanDj3UxC8jtkmY7b2Qo++cQE5scfq3pNlSHjuJ900v0438C7c9KUidPApUbcBmSAEEFPfNaMUwN7W3+d2JAgt58SMxuituyUWZ2ftzAM2E4eerC32MlpqluIVq1xc/LTsOxKHyHXLrO/y+N2c1xTVV9/nZ2oZLfxuNPGMfsWgQxPbz7i3j7Et9NvR6TM+q6RGAyEnvKtfwgjKS6h/7lN4a8Z5phODxaZg/A6DN4mu+GxK5sgzPypT01aujplvxrfkUucD5GQEB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(4326008)(8936002)(8676002)(6916009)(86362001)(38100700002)(83380400001)(186003)(122000001)(64756008)(38070700005)(71200400001)(66946007)(91956017)(76116006)(66446008)(66476007)(66556008)(53546011)(6506007)(30864003)(33716001)(54906003)(6486002)(1076003)(2906002)(966005)(6512007)(9686003)(316002)(508600001)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cOtBw6g7Ti0huUUchCHccEF33iNoK/DAugzKjWp3UvsIjNNIL3l+Z8xHCNVs?=
 =?us-ascii?Q?WWENIUDnCSB52uU+7mhB0z5XiQf0tVCMtj5yjZd6fSb0ug//VAsoEh+Mqx8N?=
 =?us-ascii?Q?MJJFgAA1matC5380xWpNnMyJBPzX6ko06lge8sIQJJOSsRkPVDzJ7B+Hh5Ho?=
 =?us-ascii?Q?YcBbCSk8iEJHP/qAXqBzYcelnvLo8qi9RXqEBegDA8KsNzpQGGhZVW7NNh2F?=
 =?us-ascii?Q?hTKikyDy+wRMY0ERHDlPHcTwlgWKjeTlyKNNpKbOmkAPuupxFO1sBK7OiS5+?=
 =?us-ascii?Q?tev7gmn8aHAJF8nuGLgqwIX7b9FrCKOPgAhvSr43WrMrbqqlI5Cxw/QoEvLL?=
 =?us-ascii?Q?D09C8cmgIC8FSq56c3NCuqO0SS+KeWZKotkrDj53iSqiJce4NhAtbKHyI1pA?=
 =?us-ascii?Q?9zg2zrUQjpFMt/ujviMb9p+Th/ZZXwymxeFB6ID06JQLuyZg65gOVVMobRqU?=
 =?us-ascii?Q?qKATTqjcMGzUmEVQLZxzUAbjjjv4QlKUPK9rDN7Ds0sjGN0SOA/jm4q+OQYH?=
 =?us-ascii?Q?vv9R4E/S5qkK1eLCXrEJc2ZxBSziaz10FE/DzobjFs/rV20hiDIbiP50qMSp?=
 =?us-ascii?Q?e9HQMngbu6eLs1eJQKIU02C9oTQY3FC+abXruhy309N0nTl3vfe4fr7cQCrC?=
 =?us-ascii?Q?htTUmaPcYGguIw5oYMpim+WCHPvdSYzcFDLGSpPVwF4YV+6ZvtnIpYgXxxLc?=
 =?us-ascii?Q?tUZCVJCyV9reWfCuNZBz0859IsMy47BFUPWR4yaYH6aFPkonV0k5huhs4HnM?=
 =?us-ascii?Q?faU8l7cL4dtxt7e76/Y5lLpnRBNbWGIw2HqucDjGO5dG/w2EbPFfBM2cV7wa?=
 =?us-ascii?Q?gAXjIK3OML25C5Xc+sd4EpaQTPkrWMUxG1ZCcCBKUzvZ3GWIrqUCBAHXlKyU?=
 =?us-ascii?Q?awhNdsEGdlfG4iabG11bdxE0eGQDG1c0BpXQAH7BI/e2XZpHMZurMjJPZQmV?=
 =?us-ascii?Q?5rrGTw2W48jeVaPBEyb3IsUiwNvX3VxH0bdm8PMk/5I2WIECF2xi6b7eSGFI?=
 =?us-ascii?Q?byCZ7AqqY1vZpuAgxNVnfBsYTC3r6WBovW+GHMMMWk4drNZSrDESRd1lc6pb?=
 =?us-ascii?Q?rOyQtYg/8lOs7BkvDj1a2hnqDCT7Vv9lwW8dW4x3sy3NFdZuN1weB3FqOwgm?=
 =?us-ascii?Q?G+EZ/HsrUiBZcHmJZkM7xIvSFtL166wx3spFU3gVAuYQpQnFiJkOPfkzaab2?=
 =?us-ascii?Q?Z0h/Im/3pxQE8IBrd/jCDu59DG8ugLS4bIicTJ/5Vj39B5afSsQ+NPFhAejl?=
 =?us-ascii?Q?eaXH4/krAz/lj8R5mTicodTdn48Eq/ipddRX3KWtezxdGL4lOFpG1EJyfaoo?=
 =?us-ascii?Q?plHet25ylfajgJUYWQZ5csLExVdoeChtuxnxvLyWbkBpcw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABE5295B41369F41B3FADE926DB8A558@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe43fe-a7e2-45fa-c6d9-08d9824efe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 07:10:03.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulWXZFSHdH2Oiy+YFZj1YSWhueSf/oPodK9kBoYdHYp5eexxOvOYK2jJ3jAg1X+41iYbqLH9xnY832labJRTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8358
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 05:36:55PM -0600, Sven Oehme wrote:
> I should add that the copy process starts and runs for a while, but
> then stalls. The last 2 times I started over from scratch it stalls at
> around 200 GB, so ~ 1-2 files into the copy process.

Thank you for the detailed info. I'm also working on to reproduce the
issue.

BTW, how is the memory usage at the hung time? Can I have "free -m"
output?

> Sven
>=20
> On Mon, Sep 27, 2021 at 5:34 PM Sven Oehme <oehmes@gmail.com> wrote:
> >
> > the workload is as simple as one can imagine :
> >
> > scp -rp /space/01/ /space/20/
> > where space/01 is a ext4 filesystem with several >100gb files in it,
> > /space/20 is the btrfs destination
> >
> > its single threaded , nothing special
> >
> > Sven
> >
> > On Mon, Sep 27, 2021 at 5:31 PM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> > >
> > > On 2021/09/28 8:17, Sven Oehme wrote:
> > > > yes i do :
> > > >
> > > > root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/queued
> > > > 3760
> > >
> > > Can you give more information on the workload ? How can we recreate t=
his ?
> > >
> > > >
> > > > On Mon, Sep 27, 2021 at 5:01 PM Damien Le Moal
> > > > <damien.lemoal@opensource.wdc.com> wrote:
> > > >>
> > > >> On 2021/09/28 7:56, Sven Oehme wrote:
> > > >>> Hi,
> > > >>>
> > > >>> i tried above  :
> > > >>>
> > > >>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
> > > >>>        0        89
> > > >>>        1        1462
> > > >>>        2        1
> > > >>>        4        574
> > > >>>        8        0
> > > >>>       16        0
> > > >>>       32+       0
> > > >>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch
> > > >>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
> > > >>>        0        89
> > > >>>        1        1462
> > > >>>        2        1
> > > >>>        4        574
> > > >>>        8        0
> > > >>>       16        0
> > > >>>       32+       0
> > > >>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch_busy
> > > >>> 0
> > > >>
> > > >> Do you have the queued count too ? If there is a difference with d=
ispatch, it
> > > >> would mean that some IOs are stuck in the stack.
> > > >>
> > > >>>
> > > >>> echo 1 > /sys/kernel/debug/block/sdr/hctx0/run
> > > >>>
> > > >>> doesn't make any progress, still no i/o to the drive
> > > >>>
> > > >>> Sven
> > > >>>
> > > >>>
> > > >>> On Mon, Sep 27, 2021 at 4:48 PM Damien Le Moal
> > > >>> <damien.lemoal@opensource.wdc.com> wrote:
> > > >>>>
> > > >>>> On 2021/09/28 7:38, Sven Oehme wrote:
> > > >>>>> i tried to repeat the test with FW19, same result :
> > > >>>>
> > > >>>> The problem is likely not rooted with the HBA fw version.
> > > >>>> How do you create the problem ? Is it an fio script you are runn=
ing ?
> > > >>>>
> > > >>>>>
> > > >>>>> [Mon Sep 27 15:41:22 2021] INFO: task btrfs-transacti:4206 bloc=
ked for
> > > >>>>> more than 604 seconds.
> > > >>>>> [Mon Sep 27 15:41:22 2021]       Not tainted 5.14-test #1
> > > >>>>> [Mon Sep 27 15:41:22 2021] "echo 0 >
> > > >>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > >>>>> [Mon Sep 27 15:41:22 2021] task:btrfs-transacti state:D stack: =
   0
> > > >>>>> pid: 4206 ppid:     2 flags:0x00004000
> > > >>>>> [Mon Sep 27 15:41:22 2021] Call Trace:
> > > >>>>> [Mon Sep 27 15:41:22 2021]  __schedule+0x2fa/0x910
> > > >>>>> [Mon Sep 27 15:41:22 2021]  schedule+0x4f/0xc0
> > > >>>>> [Mon Sep 27 15:41:22 2021]  io_schedule+0x46/0x70
> > > >>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_get_tag+0x11b/0x270
> > > >>>>> [Mon Sep 27 15:41:22 2021]  ? wait_woken+0x80/0x80
> > > >>>>> [Mon Sep 27 15:41:22 2021]  __blk_mq_alloc_request+0xec/0x120
> > > >>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_submit_bio+0x12f/0x580
> > > >>>>> [Mon Sep 27 15:41:22 2021]  submit_bio_noacct+0x42a/0x4f0
> > > >>>>> [Mon Sep 27 15:41:22 2021]  submit_bio+0x4f/0x1b0
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btrfs_submit_metadata_bio+0x10f/0x1=
70 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  submit_one_bio+0x67/0x80 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btree_write_cache_pages+0x6e8/0x770=
 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btree_writepages+0x5f/0x70 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  do_writepages+0x38/0xc0
> > > >>>>> [Mon Sep 27 15:41:22 2021]  __filemap_fdatawrite_range+0xcc/0x1=
10
> > > >>>>> [Mon Sep 27 15:41:22 2021]  filemap_fdatawrite_range+0x13/0x20
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_marked_extents+0x66/0x1=
40 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_and_wait_transaction+0x=
49/0xd0 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  btrfs_commit_transaction+0x6b0/0xaa=
0 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  ? start_transaction+0xcf/0x5a0 [btr=
fs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  transaction_kthread+0x138/0x1b0 [bt=
rfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  kthread+0x12f/0x150
> > > >>>>> [Mon Sep 27 15:41:22 2021]  ?
> > > >>>>> btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
> > > >>>>> [Mon Sep 27 15:41:22 2021]  ? __kthread_bind_mask+0x70/0x70
> > > >>>>> [Mon Sep 27 15:41:22 2021]  ret_from_fork+0x22/0x30
> > > >>>>>
> > > >>>>> if you tell me what information to collect, I am happy to do so=
,.
> > > >>>>
> > > >>>> The stack seems to point to a "hang" in the block layer so btrfs=
 side waits forever.
> > > >>>>
> > > >>>> When you get the hang, can you check the queued and dispatch cou=
nters in
> > > >>>> /sys/kernel/debug/block/<your disk>/hctx0 ?
> > > >>>>
> > > >>>> Once you have the numbers, try:
> > > >>>>
> > > >>>> echo 1 > /sys/kernel/debug/block/<your disk>/hctx0/run
> > > >>>>
> > > >>>> to see if the drive gets unstuck.
> > > >>>>
> > > >>>>>
> > > >>>>> Sven
> > > >>>>>
> > > >>>>>
> > > >>>>> On Mon, Sep 27, 2021 at 11:28 AM Sven Oehme <oehmes@gmail.com> =
wrote:
> > > >>>>>>
> > > >>>>>> Hi,
> > > >>>>>>
> > > >>>>>> I also have an  Adaptec HBA 1100-4i at FW level 4.11 (latest) =
, which
> > > >>>>>> according to https://ask.adaptec.com/app/answers/detail/a_id/1=
7472 is
> > > >>>>>> supported but see the exact same hangs after a few minutes ...
> > > >>>>>>
> > > >>>>>> what i see in dmesg is :
> > > >>>>>>
> > > >>>>>> [Mon Sep 27 11:20:03 2021] INFO: task kworker/u102:6:190092 bl=
ocked
> > > >>>>>> for more than 120 seconds.
> > > >>>>>> [Mon Sep 27 11:20:03 2021]       Not tainted 5.14-test #1
> > > >>>>>> [Mon Sep 27 11:20:03 2021] "echo 0 >
> > > >>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
> > > >>>>>> [Mon Sep 27 11:20:03 2021] task:kworker/u102:6  state:D stack:=
    0
> > > >>>>>> pid:190092 ppid:     2 flags:0x00004000
> > > >>>>>> [Mon Sep 27 11:20:03 2021] Workqueue: btrfs-worker-high
> > > >>>>>> btrfs_work_helper [btrfs]
> > > >>>>>> [Mon Sep 27 11:20:03 2021] Call Trace:
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  __schedule+0x2fa/0x910
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  schedule+0x4f/0xc0
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  io_schedule+0x46/0x70
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_get_tag+0x11b/0x270
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  ? wait_woken+0x80/0x80
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  __blk_mq_alloc_request+0xec/0x120
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_submit_bio+0x12f/0x580
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio_noacct+0x42a/0x4f0
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio+0x4f/0x1b0
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  run_one_async_done+0x3b/0x70 [btrf=
s]
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_work_helper+0x132/0x2e0 [btr=
fs]
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  process_one_work+0x220/0x3c0
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  worker_thread+0x53/0x420
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  kthread+0x12f/0x150
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  ? process_one_work+0x3c0/0x3c0
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  ? __kthread_bind_mask+0x70/0x70
> > > >>>>>> [Mon Sep 27 11:20:03 2021]  ret_from_fork+0x22/0x30
> > > >>>>>>
> > > >>>>>> i will also downgrade the LSI adapter to FW 19, but i think th=
is is
> > > >>>>>> unrelated to the FW as i can see this with 2 completely differ=
ent
> > > >>>>>> HBA's and 2 completely different drives.
> > > >>>>>>
> > > >>>>>> Sven
> > > >>>>>>
> > > >>>>>> Sven
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> On Sun, Sep 26, 2021 at 5:19 PM Damien Le Moal
> > > >>>>>> <damien.lemoal@opensource.wdc.com> wrote:
> > > >>>>>>>
> > > >>>>>>> On 2021/09/25 3:25, Sven Oehme wrote:
> > > >>>>>>>> Hi,
> > > >>>>>>>>
> > > >>>>>>>> i am running into issues with Host Managed SMR drive testing=
. when i
> > > >>>>>>>> try to copy or move a file to the btrfs filesystem it just h=
angs. i
> > > >>>>>>>> tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14=
.6 but the
> > > >>>>>>>> issue still persists.
> > > >>>>>>>>
> > > >>>>>>>> here is the setup :
> > > >>>>>>>>
> > > >>>>>>>> I am using btrfs-progs-v5.14.1
> > > >>>>>>>> device is a  Host Managed WDC  20TB SMR drive with firmware =
level C421
> > > >>>>>>>> its connected via a HBA 9400-8i Tri-Mode Storage Adapter , l=
atest 20.0 FW
> > > >>>>>>>
> > > >>>>>>> Beware of the Broadcom FW rev 20. We found problems with it: =
very slow zone
> > > >>>>>>> command scheduling leading to command timeout is some cases. =
FW 19 does not seem
> > > >>>>>>> to have this issue. But that is likely not the cause of the p=
roblem here.
> > > >>>>>>>
> > > >>>>>>> Is there anything of interest in dmesg ? Any IO errors ?
> > > >>>>>>>
> > > >>>>>>> Naohiro, Johannes,
> > > >>>>>>>
> > > >>>>>>> Any idea ?
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>> I am using the /dev/sd device direct  , no lvm or device map=
per or
> > > >>>>>>>> anything else in between
> > > >>>>>>>>
> > > >>>>>>>> after a few seconds, sometimes minutes data rate to the driv=
e drops to
> > > >>>>>>>> 0 and 1 or 2 cores on my system show 100% IO wait time, but =
no longer
> > > >>>>>>>> make any progress
> > > >>>>>>>>
> > > >>>>>>>> the process in question has the following stack :
> > > >>>>>>>>
> > > >>>>>>>> [ 2168.589160] task:mv              state:D stack:    0 pid:=
 3814
> > > >>>>>>>> ppid:  3679 flags:0x00004000
> > > >>>>>>>> [ 2168.589162] Call Trace:
> > > >>>>>>>> [ 2168.589163]  __schedule+0x2fa/0x910
> > > >>>>>>>> [ 2168.589166]  schedule+0x4f/0xc0
> > > >>>>>>>> [ 2168.589168]  schedule_timeout+0x8a/0x140
> > > >>>>>>>> [ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
> > > >>>>>>>> [ 2168.589173]  io_schedule_timeout+0x51/0x80
> > > >>>>>>>> [ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
> > > >>>>>>>> [ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
> > > >>>>>>>> [ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
> > > >>>>>>>> [ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
> > > >>>>>>>> [ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
> > > >>>>>>>> [ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
> > > >>>>>>>> [ 2168.589262]  new_sync_write+0x114/0x1a0
> > > >>>>>>>> [ 2168.589265]  vfs_write+0x1c5/0x260
> > > >>>>>>>> [ 2168.589267]  ksys_write+0x67/0xe0
> > > >>>>>>>> [ 2168.589270]  __x64_sys_write+0x1a/0x20
> > > >>>>>>>> [ 2168.589272]  do_syscall_64+0x40/0xb0
> > > >>>>>>>> [ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > >>>>>>>> [ 2168.589277] RIP: 0033:0x7ffff7e91c27
> > > >>>>>>>> [ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 O=
RIG_RAX:
> > > >>>>>>>> 0000000000000001
> > > >>>>>>>> [ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 R=
CX: 00007ffff7e91c27
> > > >>>>>>>> [ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 R=
DI: 0000000000000004
> > > >>>>>>>> [ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R=
09: 0000000000000000
> > > >>>>>>>> [ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R=
12: 0000000000000004
> > > >>>>>>>> [ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R=
15: 0000000000020000
> > > >>>>>>>>
> > > >>>>>>>> and shows up under runnable tasks :
> > > >>>>>>>>
> > > >>>>>>>> [ 2168.593562] runnable tasks:
> > > >>>>>>>> [ 2168.593562]  S            task   PID         tree-key  sw=
itches
> > > >>>>>>>> prio     wait-time             sum-exec        sum-sleep
> > > >>>>>>>> [ 2168.593563] ---------------------------------------------=
----------------------------------------------------------------
> > > >>>>>>>> [ 2168.593565]  S        cpuhp/13    92     88923.802487    =
    19
> > > >>>>>>>> 120         0.000000         0.292061         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593571]  S  idle_inject/13    93       -11.997255    =
     3
> > > >>>>>>>> 49         0.000000         0.005480         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593577]  S    migration/13    94       814.287531    =
   551
> > > >>>>>>>> 0         0.000000      1015.550514         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593582]  S    ksoftirqd/13    95     88762.317130    =
    44
> > > >>>>>>>> 120         0.000000         1.940252         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593588]  I    kworker/13:0    96        -9.031157    =
     5
> > > >>>>>>>> 120         0.000000         0.017423         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593593]  I   kworker/13:0H    97      3570.961886    =
     5
> > > >>>>>>>> 100         0.000000         0.034345         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593603]  I    kworker/13:1   400    101650.731913    =
   578
> > > >>>>>>>> 120         0.000000        10.110898         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593611]  I   kworker/13:1H  1015    101649.600698    =
    65
> > > >>>>>>>> 100         0.000000         1.443300         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593618]  S           loop3  1994     99133.655903    =
    70
> > > >>>>>>>> 100         0.000000         1.137468         0.000000 2 0 /
> > > >>>>>>>> [ 2168.593625]  S           snapd  3161        15.296181    =
   166
> > > >>>>>>>> 120         0.000000        90.296991         0.000000 2 0
> > > >>>>>>>> /system.slice/snapd.service
> > > >>>>>>>> [ 2168.593631]  S           snapd  3198        10.047573    =
    49
> > > >>>>>>>> 120         0.000000         5.646247         0.000000 2 0
> > > >>>>>>>> /system.slice/snapd.service
> > > >>>>>>>> [ 2168.593639]  S            java  2446       970.743682    =
   301
> > > >>>>>>>> 120         0.000000       101.648659         0.000000 2 0
> > > >>>>>>>> /system.slice/stor_tomcat.service
> > > >>>>>>>> [ 2168.593645]  S C1 CompilerThre  2573      1033.157689    =
  3636
> > > >>>>>>>> 120         0.000000       615.256247         0.000000 2 0
> > > >>>>>>>> /system.slice/stor_tomcat.service
> > > >>>>>>>> [ 2168.593654]  D              mv  3814      2263.816953    =
186734
> > > >>>>>>>> 120         0.000000     30087.917319         0.000000 2 0 /=
user.slice
> > > >>>>>>>>
> > > >>>>>>>> any idea what is going on and how to fix this ?
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> thx.
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>>
> > > >>>>>>> --
> > > >>>>>>> Damien Le Moal
> > > >>>>>>> Western Digital Research
> > > >>>>
> > > >>>>
> > > >>>> --
> > > >>>> Damien Le Moal
> > > >>>> Western Digital Research
> > > >>
> > > >>
> > > >> --
> > > >> Damien Le Moal
> > > >> Western Digital Research
> > >
> > >
> > > --
> > > Damien Le Moal
> > > Western Digital Research=
