Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A47C4263
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbjJJVXc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjJJVXc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 17:23:32 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9411B4
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696973011; x=1728509011;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Sq44w3MaZipAArjwQunFU7RjFpTrhTbtBBq6kMYfz9I=;
  b=Naa8unlPrRVstlaFHxwyjxCGfY7/g/naSK8z/AzTaNcmqbAnxcmonwuZ
   dxchDRwsxhEMmeT+HvLLgBaMFUAgS15QrXVne6BexmxdNiZsOPtOGk4+2
   Nk3T3jEXdeovrHrywZV2RLpyhXmtpdb5J2Clb2W2FudSCa50Rhn1X+NpT
   s=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694736000"; 
   d="scan'208";a="159295442"
Subject: RE: btrfs_extent_map memory consumption results in "Out of memory"
Thread-Topic: btrfs_extent_map memory consumption results in "Out of memory"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 21:23:29 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 8DBB960B7C;
        Tue, 10 Oct 2023 21:23:27 +0000 (UTC)
Received: from EX19D030UEC001.ant.amazon.com (10.252.137.253) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:23:23 +0000
Received: from EX19D030UEC003.ant.amazon.com (10.252.137.182) by
 EX19D030UEC001.ant.amazon.com (10.252.137.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 10 Oct 2023 21:23:22 +0000
Received: from EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89]) by
 EX19D030UEC003.ant.amazon.com ([fe80::6222:63e7:9834:7b89%3]) with mapi id
 15.02.1118.037; Tue, 10 Oct 2023 21:23:22 +0000
From:   "Ospan, Abylay" <aospan@amazon.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Thread-Index: Adn7hypl09BTxineSnqUNneAxmdLqQACeriAAAcD1ZA=
Date:   Tue, 10 Oct 2023 21:23:22 +0000
Message-ID: <ddb589008e7a4419b67134be7ae90f8b@amazon.com>
References: <13f94633dcf04d29aaf1f0a43d42c55e@amazon.com>
 <ZSVyFaWA5KZ0nTEN@debian0.Home>
In-Reply-To: <ZSVyFaWA5KZ0nTEN@debian0.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.178.24]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe,

Thanks for the info!

I was just wondering about "direct IO writes", so I ran a quick test by ful=
ly removing fio's config option "direct=3D1" (default value is false).
Unfortunately, I'm still experiencing the same oom-kill:=20

[ 4843.936881] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cpus=
et=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/,task=3Dfio,pid=3D649,uid=
=3D0
[ 4843.939001] Out of memory: Killed process 649 (fio) total-vm:216868kB, a=
non-rss:896kB, file-rss:128kB, shmem-rss:2176kB, UID:0 pgtables:100kB oom_s=
core_a0
[ 5306.210082] tmux: server invoked oom-killer: gfp_mask=3D0x140cca(GFP_HIG=
HUSER_MOVABLE|__GFP_COMP), order=3D0, oom_score_adj=3D0
...
[ 5306.240968] Unreclaimable slab info:
[ 5306.241271] Name                      Used          Total
[ 5306.242700] btrfs_extent_map       26093KB      26093KB

Here's my updated fio config:
[global]
name=3Dfio-rand-write
filename=3Dfio-rand-write
rw=3Drandwrite
bs=3D4K
numjobs=3D1
time_based
runtime=3D90000

[file1]
size=3D3G
iodepth=3D1

"slabtop -s -a" output:
  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
206080 206080 100%    0.14K   7360       28     29440K btrfs_extent_map

I accelerated my testing by running fio test inside a QEMU VM with a limite=
d amount of RAM (140MB):

qemu-kvm
  -kernel bzImage.v6.6 \
  -m 140M  \
  -drive file=3Drootfs.btrfs,format=3Draw,if=3Dnone,id=3Ddrive0
...

It appears that this issue may not be limited to direct IO writes alone?

Thank you!

-----Original Message-----
From: Filipe Manana <fdmanana@kernel.org>=20
Sent: Tuesday, October 10, 2023 11:48 AM
To: Ospan, Abylay <aospan@amazon.com>
Cc: linux-btrfs@vger.kernel.org
Subject: RE: [EXTERNAL] btrfs_extent_map memory consumption results in "Out=
 of memory"

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



On Tue, Oct 10, 2023 at 03:02:21PM +0000, Ospan, Abylay wrote:
> Greetings Btrfs development team!
>
> I would like to express my gratitude for your outstanding work on Btrfs. =
However, I recently experienced an 'out of memory' issue as described below=
.
>
> Steps to reproduce:
>
> 1. Run FIO test on a btrfs partition with random write on a 300GB file:
>
> cat <<EOF >> rand.fio
> [global]
> name=3Dfio-rand-write
> filename=3Dfio-rand-write
> rw=3Drandwrite
> bs=3D4K
> direct=3D1
> numjobs=3D16
> time_based
> runtime=3D90000
>
> [file1]
> size=3D300G
> ioengine=3Dlibaio
> iodepth=3D16
> EOF
>
> fio rand.fio
>
> 2. Monitor slab consumption with "slabtop -s -a"
>
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 25820620 23138538  89%    0.14K 922165       28   3688660K btrfs_extent_m=
ap
>
> 3. Observe oom-killer:
> [49689.294138] ip invoked oom-killer:=20
> gfp_mask=3D0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC), =
order=3D3, oom_score_adj=3D0 ...
> [49689.294425] Unreclaimable slab info:
> [49689.294426] Name                      Used          Total
> [49689.329363] btrfs_extent_map     3207098KB    3375622KB
> ...
>
> Memory usage by btrfs_extent_map gradually increases until it reaches a c=
ritical point, causing the system to run out of memory.
>
> Test environment: Intel CPU, 8GB RAM (To expedite the reproduction of thi=
s issue, I also conducted tests within QEMU with a restricted amount of mem=
ory).
> Linux kernel tested: LTS 5.15.133, and mainline 6.6-rc5
>
> Quick review of the 'fs/btrfs/extent_map.c' code reveals no built-in limi=
tations on memory allocation for extents mapping.
> Are there any known workarounds or alternative solutions to mitigate this=
 issue?

No workarounds really.

So once we add an extent map to the inode's rbtree, it will stay there unti=
l:

1) The corresponding pages in the file range get released due to memory pre=
ssure or whatever reason decided by the MM side.
   The release happens in the callback struct address_space_operations::rel=
ease_folio, which is btrfs_release_folio for btrfs.
   In your case it's direct IO writes... so there are no pages to release, =
and therefore extent maps don't get released by
   that mechanism.

2) The inode is evicted - when evicted of course we drop all extent maps an=
d release all memory.
   If some application is keeping a file descriptor open for the inode, and=
 writes keep happening (or reads, since they create
   an extent map for the range read too), then no extent maps are released.=
..
   Databases and other software often do that, keep file descriptors open f=
or long periods, while reads and writes are happening
   by the some process or others.

The other side effect, even if no memory exhaustion happens, is that it slo=
ws down writes, reads, and other operations, due to large red black trees o=
f extent maps.

I don't have a ready solution for that, but I had some thinking about this =
about a year ago or so.
The simplest solution would be to not keep extent maps in memory for direct=
 IO writes/reads...
but it may slow down in some cases at least.

Soon I may start some work to improve that.

Thanks.

>
> Thank you!
>
> --
> Abylay Ospan
>
>
