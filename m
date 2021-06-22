Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35C73B1015
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFVWbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 18:31:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27747 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFVWbv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 18:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624400974; x=1655936974;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L+8f3siCJ0L5ry6RrmXO6+geT1rWm1iYF589uwce8Jc=;
  b=pTr9IPH1MMjFwJ8S9SjmlxhvVz5KLs+QvnLyInY32vBAJ7epOOdtV53N
   vWtgGV6Yl/TuxUN/P42RQY3dVRiTVC21cLbm3WgegqXaYzqkIMMbR2uCW
   JPKGRstlY/6JhrGwKaCFGyn3Hb9aDLs0gT2jNSmQo/CKX/pHM52Qzbboy
   keqcgwONc028364QN5N+O6K2nsPf85fCC1dxOHu9ofptcuLZzCdfirUI/
   QEpR6saX1HaeylJSStrjPdlz+zeayhaqyUVtnxJMKFIvscMFtuAGDds5J
   LyzXlZwD+d9ng4IUVuCyJ2HoUE1D/dUhu8u/x2hSw+otqNhZgmtKrmH2P
   A==;
IronPort-SDR: 8pXxoe0LInTJ3akRLu3jztQi4sz1dTehL5jKUIpiIASczWZKq12ugA5JOgY/6D1/VMalPP73Vf
 JNi+xE+nJaFOKTzkMDEQkhFdqoxYQN1TXlIy897/eUB0PynEvfObGxFKoIiSMllj3j7d473eto
 HRjfDackHgVKlNgoW4vyK+AE4AM7cUtJIu1Ywk27dYsSu3RTiPOs84IwiqzHKmNl1CrqVGD8S1
 u7v/+HvE5Jrfqnip7jspLYR2WNjTzT2Aq+JTcBP40nOR4tGoHSpfyjVKtMiciA8iSxybXO62cU
 cEA=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="284106063"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 06:29:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR5EvfV/x3VX960lSf2yD5dio7Y/STrMb6wadO0KvRxE0QEKvgR7VGLbdPLIsqHh46lQMtrfBw2+8I3FpTB3Gs93YWVdghficJCLnGpORK9BhmKgDwc1KskX0T4qEp845cIUe8xI0qtG2FSU6iY1Tv+oNZEA7t7T7IDPqRRm9w6vtGI/nrSbeQd1OS9vnKbrsj1Vk9N5WQzjib6AnglJhzoPm3WmrT9Vt+SeZpXcsw4KPx5MIVWS8cowa4f5ymPG+asrZ283fiuVzDIKnBuHBh83fOCaAvoPLEaAIMCRSPntN7ktgkjCGDswK/1DAsfvkRrUon+flR5zALqcM4Bw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSpIYyXTg35xIPQ3sdQd9uJijhUQidJ0BY7TGgSFGJg=;
 b=Ke7QxQNg2Wc2MRj7whwpr1Ac/6ac0RHMFzZj03/HHiqNxoQu7qawJk2v8uM+s/qSsXqfeZB4wSh5Mx+4+ig0I2McymQSYSowG6NbD39ap4bA5qw3LehY/24+8JzA/Pb5fo0sXcP//U/QlcVqu+w+rFvO51SIVFLWOM5LmYj+c/8rABi2d2HLqdQ2rbdK4LNADOPRW8tk7gcWjygAYm2wOeUo4dYpNy9QOXhKEToBd8/UcnujppRgAUzeedEz2W4jqPYzv9OVWzDF05ehLLZnW1CUFesBLTwDernT6Xtb/zKqCyoXhVN7wd9z4fKbSmmpgthRnVYFt6WcQ/d9mlmaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSpIYyXTg35xIPQ3sdQd9uJijhUQidJ0BY7TGgSFGJg=;
 b=Lovp265UFT0yK74RI+Eq7E9Koc4qbXEZiPrm3WB33YGQ3dz0zoQksdAOX90Lb0eZzYB+WnFQXZqsk/VuF0ovO5YSi8XAcQnxu7oD82L4uBd8QY8gYmElcju4OMyvoFk/hyYs9bVKLvXNVUgPSj6YkZU4tn8SUBMHc8cqcyneL2U=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6395.namprd04.prod.outlook.com (2603:10b6:5:1f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 22:29:33 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 22:29:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
Thread-Topic: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
Thread-Index: AQHXZ24fBo38dS2zX0qj8Z2+ZCaIYw==
Date:   Tue, 22 Jun 2021 22:29:32 +0000
Message-ID: <DM6PR04MB70814347CB0008FC61468F49E7099@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
 <20210622175811.GK28158@twin.jikos.cz>
 <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5431:92d2:5401:e0b8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c09c72e9-a473-49d5-4dcc-08d935cd3581
x-ms-traffictypediagnostic: DM6PR04MB6395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB639537321F6BB02908685E03E7099@DM6PR04MB6395.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xluSlJtGdV9eAVUA+djXr/8kVxhM/BK/4A2RxfjKsOKiukUnD5xxkafGCWivNQIUT0Tw1IGzQzF7VGI6aaESunlZUt0j1oW6VrbGmIybafnvqopD8jjUuP2M98ZCHM13BTn/ZD1FJzsK3hpgI1+UBEkDEgTh9KsJODBQ/pkrjXjggnG5LSZ3RTB0xswgvMjctxYoK3pQ/Z3gGVoCySwvIRA7L3tlpvHKfNVyP0p47Ix2MD/xwikzCBwPwi7aQg5Ai3aE5NZM/sFL/L1x33BO/uGMrWOUFMZ08P2VZsUG6j9IeWKCyCHr+LuFu/vhtKkbLZgc8Ois0z+XIeT0MdiOgGtYy09C8ZlhtEiLJsmzhMe+21BaFGYkIrqG1QcJTWfYtgDBZSni80BEdsCDn8wU6dGcvBjBju7EoSDoUZ1bK1ZekpC3mJ8PDC7oDiw/jknsHYh8QYkQMogf1+uwUCDnl14+eF4TZQswXRAUdSGSXvJBxd/NWE/Cr8hfDoI+YyKsawnh+vo7wu0wpA+2zx002oOC2+8Gq2f6VlUNxGWJE7yHilGrE7DQEP5gC4r3Fly8+j98waJaABkk3YcJs2slsyRNDxG0i97kOc8U1T+5bjW8thp47P3dPmqaG00LqPY6nb85bKx8p9l7uBwJTl8r4Rs7aDkDK8xnuWVw4QbmMZBuqXSVrBKeusXl+1Yb/XnWrsfFp+9vJBz6KV9HqeBBZSOQhcaoPesn54suR4UceHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39850400004)(83380400001)(5660300002)(110136005)(316002)(64756008)(66556008)(2906002)(66446008)(66476007)(66946007)(186003)(76116006)(91956017)(8676002)(966005)(9686003)(38100700002)(33656002)(122000001)(52536014)(7696005)(86362001)(8936002)(6506007)(53546011)(55016002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jrGQwS787p33XqGaLILasKCcHcYxYIoBqBuRUfNAMQpjN/bLq4Y3FWRXnqH7?=
 =?us-ascii?Q?Zdogs0w/oFJ/o3XKocxXfhSUE+8BnerEDYhSM5mEYuvqDV3zYexHKQF5WUJQ?=
 =?us-ascii?Q?8k9v690n2XVbzA/P3Y+1a3sc65sYJol13BzCtEmgg8wlA7eZpwjtixw5OiEB?=
 =?us-ascii?Q?u1dqmKrsLb950lXr3pFs5xz9WKNFDfjygxtW/i3iYENd7EsvkV4JLLYqEB/Y?=
 =?us-ascii?Q?Ci2W4s9C+cHzq3b6Yocsayxbp7vy4NNX5dacYv3SHq/y0MEM6TyLs6y2GVE8?=
 =?us-ascii?Q?Szc9OZ+Tlbt4yAXYrPF4IHm9YLTG/N9hjn00F1iHhP3mvcdogu4EK9eVMAXI?=
 =?us-ascii?Q?Phb5/d3vqFnOoP3pL2sZZDwMOGYeGpCIIM006IIuxxkXk4OzV6crYN3ywh4i?=
 =?us-ascii?Q?KqQa0sZ/ZTxb0+BSI6UMpM0IJq1LyMFyWE5/pS+X3rVCGgYlgDztrLZlPhIm?=
 =?us-ascii?Q?VH8Yxwjvto7h740IYxLyNruxqKnZZlsh8tI09i+gxadgvdD1p6H1wmtbrzr8?=
 =?us-ascii?Q?Hc2GD8MNBIMX5ZrDmTCIeCtMtuRIPP+4DinOH/uYHgYZeHXKSH7On62wYnl+?=
 =?us-ascii?Q?RXDp7bJi/XhLFgBjK/E+dv7jSk73WVk2tQtCZ4MyZ8EOmzvGtgSxNxkLRyem?=
 =?us-ascii?Q?0pXZzBBBghPld1e8YAZNcSvNgy+V2fZeNCkxcOaG16NN6eIhR4ZSoAmBox14?=
 =?us-ascii?Q?gT/XTp0EclRnpMBeA9/YkTRcUsfcVtgFbK1KcwhtRxNzcxsFw/bGv8WF1Xve?=
 =?us-ascii?Q?x0bb4U1LEUsIGh5g1v2HWgebtAGUKgurjPQMDtuVooeeD1D2UicIBp+6NX1l?=
 =?us-ascii?Q?Ghp71btiWLJuJBmn9CPy2lwR1MPVcGoGnDVPrdHP8AAIwg/HmeBljBGyjXNk?=
 =?us-ascii?Q?x02RT9FNum2iE+U1jVexDb54DrWaOLWI8VJPshZEm0G87Bj/Fn3CunBcitVC?=
 =?us-ascii?Q?B79bjLMqGsBlu3fRctGOACyOpR73tLaiOi2aALyGEDlmlRP41flkWoV26JYL?=
 =?us-ascii?Q?loqwkLilQsS4Sb0mK045RuTqq9uSRKef+Wtn0gUywzGT8RumvJ/+3vMStAd1?=
 =?us-ascii?Q?O90B4ofn5DMqJ+wXxCoyZ6KYxdAHMwNNkPchzSLMNW6w78ElGm7bOh+dOB7L?=
 =?us-ascii?Q?Z4pOsSJLZ+XGLUyR5YYNc/WoIfe8DcaNp4lDvR+wF2ea0ZE07sfShfmJtNX0?=
 =?us-ascii?Q?XcwgI2yi2zXY0c6Nzaz9IPORZlXWT/7jSoDsVnnvmJyM5Jim+vSSSxzSAoav?=
 =?us-ascii?Q?AZVhM7uOWfKVZeemzbVqSLcvgnLcI+bALZ95VllZ5CUGyIKEoKRSPIJU1knT?=
 =?us-ascii?Q?a6tg0TBoY8GzNsbSFtwyJtjz207axHQ1cKwvPp9EtLr/ziGhbiuugQg70MjM?=
 =?us-ascii?Q?NQUyw4D08pFodbip+kAx8LuHvSz8Xm8VQ5gu6rN8+iV+StZszQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09c72e9-a473-49d5-4dcc-08d935cd3581
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 22:29:32.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/9VkEh3RJW+Oora0cvcoe2roLkZU8f61+IA/oK0VmKoyau6oFf7ifY2aPDacxC3dGfa9OCdQaFuz/WWXEnqlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6395
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/23 3:20, Filipe Manana wrote:=0A=
> On Tue, Jun 22, 2021 at 7:01 PM David Sterba <dsterba@suse.cz> wrote:=0A=
>>=0A=
>> On Tue, Jun 22, 2021 at 02:54:10PM +0100, fdmanana@kernel.org wrote:=0A=
>>> From: Filipe Manana <fdmanana@suse.com>=0A=
>>>=0A=
>>> When a task attempting to allocate a new chunk verifies that there is n=
ot=0A=
>>> currently enough free space in the system space_info and there is anoth=
er=0A=
>>> task that allocated a new system chunk but it did not finish yet the=0A=
>>> creation of the respective block group, it waits for that other task to=
=0A=
>>> finish creating the block group. This is to avoid exhaustion of the sys=
tem=0A=
>>> chunk array in the superblock, which is limited, when we have a thunder=
ing=0A=
>>> herd of tasks allocating new chunks. This problem was described and fix=
ed=0A=
>>> by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk ar=
ray=0A=
>>> due to concurrent allocations").=0A=
>>>=0A=
>>> However there are two very similar scenarios where this can lead to a=
=0A=
>>> deadlock:=0A=
>>>=0A=
>>> 1) Task B allocated a new system chunk and task A is waiting on task B=
=0A=
>>>    to finish creation of the respective system block group. However bef=
ore=0A=
>>>    task B ends its transaction handle and finishes the creation of the=
=0A=
>>>    system block group, it attempts to allocate another chunk (like a da=
ta=0A=
>>>    chunk for an fallocate operation for a very large range). Task B wil=
l=0A=
>>>    be unable to progress and allocate the new chunk, because task A set=
=0A=
>>>    space_info->chunk_alloc to 1 and therefore it loops at=0A=
>>>    btrfs_chunk_alloc() waiting for task A to finish its chunk allocatio=
n=0A=
>>>    and set space_info->chunk_alloc to 0, but task A is waiting on task =
B=0A=
>>>    to finish creation of the new system block group, therefore resultin=
g=0A=
>>>    in a deadlock;=0A=
>>>=0A=
>>> 2) Task B allocated a new system chunk and task A is waiting on task B =
to=0A=
>>>    finish creation of the respective system block group. By the time th=
at=0A=
>>>    task B enter the final phase of block group allocation, which happen=
s=0A=
>>>    at btrfs_create_pending_block_groups(), when it modifies the extent=
=0A=
>>>    tree, the device tree or the chunk tree to insert the items for some=
=0A=
>>>    new block group, it needs to allocate a new chunk, so it ends up at=
=0A=
>>>    btrfs_chunk_alloc() and keeps looping there because task A has set=
=0A=
>>>    space_info->chunk_alloc to 1, but task A is waiting for task B to=0A=
>>>    finish creation of the new system block group and release the reserv=
ed=0A=
>>>    system space, therefore resulting in a deadlock.=0A=
>>>=0A=
>>> In short, the problem is if a task B needs to allocate a new chunk afte=
r=0A=
>>> it previously allocated a new system chunk and if another task A is=0A=
>>> currently waiting for task B to complete the allocation of the new syst=
em=0A=
>>> chunk.=0A=
>>>=0A=
>>> Fix this by making a task that previously allocated a new system chunk =
to=0A=
>>> not loop at btrfs_chunk_alloc() and proceed if there is another task th=
at=0A=
>>> is waiting for it.=0A=
>>>=0A=
>>> Reported-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>> Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7l=
iz@naota-xeon/=0A=
>>> Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array=
 due to concurrent allocations")=0A=
>>=0A=
>> So this is a regression in 5.13-rc, the final release is most likely the=
=0A=
>> upcoming Sunday. This fixes a deadlock so that's an error that could be=
=0A=
>> considered urgent.=0A=
>>=0A=
>> Option 1 is to let Aota test it for a day or two (adding it to our other=
=0A=
>> branches for testing as well) and then I'll send a pull request on=0A=
>> Friday at the latest.=0A=
>>=0A=
>> Option 2 is to put it to pull request branch with a stable tag, so it=0A=
>> would propagate to 5.13.1 in three weeks from now.=0A=
>>=0A=
>> I'd prefer option 1 for release completeness sake but if there are=0A=
>> doubts or tests show otherwise, we can always do 2.=0A=
> =0A=
> Either way is fine for me. I didn't even notice before that it was in=0A=
> 5.13-rcs, I was thinking about 5.12 on top of my head.=0A=
> =0A=
> The issue is probably easier for Aota to trigger on zoned filesystems,=0A=
> I suppose it triggers more chunk allocations than non-zoned=0A=
> filesystems due to the zoned device constraints.=0A=
=0A=
We will run tests today. We can trigger this problem very consistently runn=
ing=0A=
fstests.=0A=
Note: First name of Aota is Naohiro. Aota is Naohiro's family name :)=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
