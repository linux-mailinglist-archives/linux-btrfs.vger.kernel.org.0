Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8E42B0A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhJLX56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 19:57:58 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:58570 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233903AbhJLX56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 19:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634082955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ht6SWN+igDwD0WlE/kPzoYGSqR6+7riiReNVs8IVt08=;
        b=Br27LXX3DNpptsxgbvNiZABy2lmnpgCgdIBmmh9R4IVYMsJeCjQKMZMBgFHfRhRtWpQUgL
        H5P3jf4e+XK4LCD+AbH466wkuGSJveSXuF1dSPpc9IIjcYjfj1/6guSCiEmw9eoPOoDK6I
        0jN+XLgfe7d+obuP1VJf5TKv6/sQA/Y=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-EJHnr6UoMSa7q_2zAVDWvA-1; Wed, 13 Oct 2021 01:55:54 +0200
X-MC-Unique: EJHnr6UoMSa7q_2zAVDWvA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kypAKK3e6yS4Mkx31R0I3CFaAJL1BHuIwi7ema8TRAaWoQYZKfr25iCoMHr16vsW/RbM8hAJy8IEe3S3IugiGY6CtqChcIJDAJ5Ia+MwLtmyQ68juE03cH+kuaOCNpbCV6f/ksZJcFqoKeJ3uQ3zgZDNIcuGkoppMDmrVsKgN2wBw3foxQ0Joi4RAs8ORvPO6NZByUEu3MTaiYT4Sc9vsskiyhDFZGoTDhv063tnAtIU6tl7g9/1sCQMoLU3tg/gun35pu6cZ+BTMHM3c9t+C7LK9UfdR3E/sEVvbq0i1jQ+rv2bAhR5n1XoWrN1vJ0BHJnZz+vwmFI8Gf/rKZvHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lrt8xDx3bwabeqk1iA2vPPdX5t3eOr52a7wYB6SZefI=;
 b=XigtcC7qsjP5hijPckxzW83NFs4PUTIvJFF7gtQ2nqk2rlQcJsPRAy6COQ6BkPA08977kFKGKeUNwFDUlYklVTTdyMyKE14810Qh0sSQgbGOlDcT7FNgcHfTUOsBynfK+sH04yL8PkE7STxksenmtWN59JlxEESlNBd2XfpQWwttV07wiZ6Y7plNtcEMrZVPvs81ig8h1XRYtvH+TfdAw4PuafdfTgC+YHUcQH9GxEgWwTVM7Qq/w7o/7m7VddJ86/oeZE6dQkzwB7VvHBDkHniRg3vwD+UJ175w4MQ8z01zYZVuUYMTjqmXqlVqo+avcMfQNGf/qoiwEo9swUrFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8310.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 23:55:53 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 23:55:53 +0000
Message-ID: <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
Date:   Wed, 13 Oct 2021 07:55:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0036.namprd07.prod.outlook.com (2603:10b6:a02:bc::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Tue, 12 Oct 2021 23:55:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5e8d2f-8b17-4316-ac0b-08d98ddbd324
X-MS-TrafficTypeDiagnostic: AS8PR04MB8310:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8310E16AA16A09A2D634D1B0D6B69@AS8PR04MB8310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47iOKYuRKytFmuNUUp8fRrW++kPmQQFdF4sfvziQ594iutDJsBRtKeb0evjRvC6JakE2FFtEKXbXGNaze97selzYezf6G40NGJoMCd3zR+pHPuESudCgvdpyywUfNLU6yOkrA65tzVdVfwpovwiV6DkvB/VOebuX7/WqQt6bjMC0r+8DRgmkwPpwRV0prq0JrwtYBK++vePNCpdBD2Xn1oQYXF7maf0gdMeN6jXI5m6VFlXkQ82SqMHpBrK2y9Y2IpKW/i05BmSkVuzVlFr6TZdYe+56EtgDDD8b4wZhKTFhp9Rm6EiqvxhBn5rskUicPkh3EqDkZBtrd9NKFqFAVMT9aXypie88cVQbpjh5esLTdyH3S+EKcjJxwefhU9BPM9Rp1w3U0MKp+H86220pDpUrBdXRYbeJXXLCsqFMMQXivLGjOStHlcSsorqpCkTlkZgj+RZLQaN9kY1di+Ldn672WUkfVcwvEM22U8BFfAM4o6MDyPquTMF2TedVxfnMTobYpmAlrc2hGV6Q/24D26GDttRYXFm4TVQS0Q1qqRKjjPA/+dwzC+sSqfbU4VnKn6nZMMDTsGcoBA6C/45t5Pf+CRCYB9dt2aCDViB/JL+mcRqX9S3KPFqewx687mt2JthRi6AGU7hd0ZODimfooma9WcupE338p/kxzveLH9B2mmdqUnsmC8RnMDUXm+SBUQpAsVUx3jpUe9ScBgl1nAUO/C3NzJWppopDR6lBVyB0aV4+YqqqkssrPtAVjqQ6U93UwTiUyo4zQuxtkh5T4N2v0oRf9jCS0JuMJS5Jbuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(31696002)(83380400001)(956004)(86362001)(26005)(6666004)(4326008)(45080400002)(110136005)(5660300002)(16576012)(54906003)(6706004)(19627235002)(316002)(186003)(38100700002)(2906002)(31686004)(66946007)(508600001)(66556008)(53546011)(66476007)(8676002)(6486002)(2616005)(8936002)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wc3RdJzVBVq23/5hIT8ynrxFRsCjxoSnOZdcwcB4WB01l2+YC1eD40ABYvIC?=
 =?us-ascii?Q?YNMi+2DZ4Gp/1cz9nyQGD6RZ1ijSg+qYOcOo0zFx+5YpsxTBNT9OayguFCnx?=
 =?us-ascii?Q?cPYkwq22/HuepP/qu/4Qw+yLsXgHjmKOKhu9ZDSWePd0npynajK1If2AyrGs?=
 =?us-ascii?Q?u2OwbtDJcWOHKljLBDkdNsPfeLF5mcZunaKyvHUFi7UKXQoDP2ha+IIB/EOJ?=
 =?us-ascii?Q?EpWki5eOlBMYaAba3MeymRvrLeOXLFYtOZkIldJk6LkYNFdHlzKsg3/t4rNu?=
 =?us-ascii?Q?vv+YN12bA14kpF4a62JA70RkYIjCPEcaGOA2YJIgAtjpmm574PevdiuLANjf?=
 =?us-ascii?Q?yjAcF0sAyrWVQKNM/kpI55j7nXtGMAGppR5TWF/rggUQblbQz8mwveVb5Qt2?=
 =?us-ascii?Q?bZj3UM9CSeeNcjtEQBb1DWl4f6AD25IR/eeuUfuWL95ylP2DJQm+JxijaHR+?=
 =?us-ascii?Q?Wl7/yd9+RkDkR5tcLdCpJ2nSPBbMOvys7f0papF62se6GfptPLaclMHyqVBn?=
 =?us-ascii?Q?DRDOrSbb4mQsp4FPtu4bAdRACq+o1Gy+zcCjA/S59wKPxyPMXEWLzyjul2JG?=
 =?us-ascii?Q?SYY8P1QGFJNZyjknAm4i2yb8P+lvYLRmpdtlKcYOq5PF8RALFN1rm2/YgiTZ?=
 =?us-ascii?Q?ZSc6SVlJVSY4+6MjtsyYdXnrtxpM73OE+3IzL2uTZ3bjvzys7aCX004WxsoG?=
 =?us-ascii?Q?yg2O7ZMFcyMx0keWXYDf8B+smdjHUO6qPzPZnmIcH+eA39J5ES3166HWXDHL?=
 =?us-ascii?Q?sXMFGK+IPZ6g1wbgopCs7gLq99Mn/Tz6FC+NyRFwBJIOsOYA97X9xsQYNhYE?=
 =?us-ascii?Q?14FMFASWK7ZRiTSmDlBGNWneb4Q4AupPbDurSq2/iixL3y6eai1+ozfMi3sV?=
 =?us-ascii?Q?nhYE4MgXUx2iFL6Mwwo3af3yxjRRsv0+6Fzgh1Xq9Pd+HL+0BGywqceA3kwy?=
 =?us-ascii?Q?308g7QFEpAUxxeWd+pFX78H+Cnhe7hv8aIWn7ibBeGfoUqt0Zyr8IOy4Vjfd?=
 =?us-ascii?Q?WAmynP8OQbxBCD1pHVcWhECWf+YYLvNjBWRvkfPdEGKSnv3URwJyxxbSZZYl?=
 =?us-ascii?Q?Bt7AH6+pbwXxGe89PueLS7mWaZM/h4ITtug2tES1BaPMskIQ0Bw/3In2o9dx?=
 =?us-ascii?Q?JIqsnKKLdld3EYh5N/zMau/GRPxQG+y7ByqzLPvcaDbwMH5e9nUfWT5XPIMx?=
 =?us-ascii?Q?ZXFgdXfxoa3sPb8zyu1XFXMfNeRq1ik1Gv4myC4vKTmIlhJqqMGBTy3FLliT?=
 =?us-ascii?Q?3FX2A28pG3iVAhemmus0s3zyYpdpvti4rYcKi29pFvi4lKrGmFWJIZIWbRwj?=
 =?us-ascii?Q?wQyB/tLeqqGyX0VtvPLy4HBK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5e8d2f-8b17-4316-ac0b-08d98ddbd324
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 23:55:53.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncWyY963FNGv7j4Z53jHCJvLUoHiCu/G+7z1M0665O1f8kgFiZAAPEd4bczM+/e4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8310
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 22:30, Chris Murphy wrote:
> On Tue, Oct 12, 2021 at 2:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/10/12 13:25, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.10.21 =D0=B3. 3:59, Chris Murphy wrote:
>>>> Linux version 5.14.9-300.fc35.aarch64 Fedora-Cloud-Base-35-20211004.n.=
0.aarch64
>>>> [ 2164.477113] Unable to handle kernel paging request at virtual
>>>> address fffffffffffffdd0
>>>> [ 2164.483166] Mem abort info:
>>>> [ 2164.485300]   ESR =3D 0x96000004
>>>> [ 2164.487824]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>>>> [ 2164.493361]   SET =3D 0, FnV =3D 0
>>>> [ 2164.496336]   EA =3D 0, S1PTW =3D 0
>>>> [ 2164.498762]   FSC =3D 0x04: level 0 translation fault
>>>> [ 2164.503031] Data abort info:
>>>> [ 2164.509584]   ISV =3D 0, ISS =3D 0x00000004
>>>> [ 2164.516918]   CM =3D 0, WnR =3D 0
>>>> [ 2164.523438] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000015=
8751000
>>>> [ 2164.533628] [fffffffffffffdd0] pgd=3D0000000000000000, p4d=3D000000=
0000000000
>>>> [ 2164.543741] Internal error: Oops: 96000004 [#1] SMP
>>>> [ 2164.551652] Modules linked in: virtio_gpu virtio_dma_buf
>>>> drm_kms_helper cec fb_sys_fops syscopyarea sysfillrect sysimgblt
>>>> joydev virtio_net virtio_balloon net_failover failover vfat fat drm
>>>> fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
>>>> virtio_mmio aes_neon_bs
>>>> [ 2164.583368] CPU: 2 PID: 8910 Comm: kworker/u8:3 Not tainted
>>>> 5.14.9-300.fc35.aarch64 #1
>>>> [ 2164.593732] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/=
06/2015
>>>> [ 2164.603204] Workqueue: btrfs-delalloc btrfs_work_helper
>>>> [ 2164.611402] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=3D--)
>>>> [ 2164.620165] pc : submit_compressed_extents+0x38/0x3d0
>>>
>>> Qu isn't this the subpage bug you narrowed down a couple of days ago ?
>>
>> Not exactly.
>>
>> The bug I pinned down is inside my refactored code of LZO code, not the
>> generic part, and my refactored code is not yet merged.
>>
>> Chris, mind to share the code context of the stack?
>=20
>  From the bug report:
>=20
> * provision Fedora 35 aarhc64 cloud based VM in openstack
> * try rebuilding kernel rpm(it seems there is need for some load on
> the system to trigger the issue, but it seems to reliably trigger for
> me)
>=20
>=20
> So it seems reliably reproducible when compiling the kernel...

I mean, the code line number...

It can be extracted using <linux_source>/scripts/faddr2line script.

Thanks,
Qu

