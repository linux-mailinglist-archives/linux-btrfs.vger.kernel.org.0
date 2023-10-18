Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4201A7CEB72
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 00:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJRWpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 18:45:12 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727B114
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Oct 2023 15:45:09 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id CC97BFBF947;
        Wed, 18 Oct 2023 22:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1697669107;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=8A05PQXmS1R+hxHkGv0HSAD2arPNADCbuePEv+iVC3s=;
        b=FTcer1mPG4xyjWMSPkYoT3qt+loWPVeYQtvtxN2wezgvTp0p5Be4h4acTa52cE7D
        sQHBTvilm/KJamLmefL1bwrYblzAtJpB+d7GNKxpTxux0ErHrrrWSEKyO5J6TvfmC0W
        vwK71OA7KxG3HT6DkdE6TlH6diFNXg55qC8ylCrjXBQpfNuvbdTy7MAoakUyO3PF9nn
        AVVC9ri+bij11nJYViMth5JkUEO0up+mffVhITzmLApibdMpHTzJruWQ2wtrxDqKNhT
        crsWCZOdTr2mHjZR1i1v77sy6JUwz4AqFZyOLPpHUoUrC6B40eEjLZ2QecXDJ+fr4op
        clvH1UpRNg==
Date:   Thu, 19 Oct 2023 00:45:07 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Fdmanana <fdmanana@gmail.com>, Aospan <aospan@amazon.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <Nh3u2MJ--3-9@tutanota.com>
Subject: RE: btrfs_extent_map memory consumption results in "Out of memory"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>Hi Filipe,
>
>> > I was just wondering about "direct IO writes", so I ran a quick test b=
y fully
>> removing fio's config option "direct=3D1" (default value is false).
>> > Unfortunately, I'm still experiencing the same oom-kill:
>> >
>> > [ 4843.936881]
>> > oom-
>> kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cpuset=3D/,mems_allo
>> > wed=3D0,global_oom,task_memcg=3D/,task=3Dfio,pid=3D649,uid=3D0
>> > [ 4843.939001] Out of memory: Killed process 649 (fio)
>> > total-vm:216868kB, anon-rss:896kB, file-rss:128kB, shmem-rss:2176kB,
>> > UID:0 pgtables:100kB oom_score_a0 [ 5306.210082] tmux: server invoked
>> oom-killer: gfp_mask=3D0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP),
>> order=3D0, oom_score_adj=3D0 ...
>> > [ 5306.240968] Unreclaimable slab info:
>> > [ 5306.241271] Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total
>> > [ 5306.242700] btrfs_extent_map=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26=
093KB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26093KB
>> >
>> > Here's my updated fio config:
>> > [global]
>> > name=3Dfio-rand-write
>> > filename=3Dfio-rand-write
>> > rw=3Drandwrite
>> > bs=3D4K
>> > numjobs=3D1
>> > time_based
>> > runtime=3D90000
>> >
>> > [file1]
>> > size=3D3G
>> > iodepth=3D1
>> >
>> > "slabtop -s -a" output:
>> >=C2=A0=C2=A0 OBJS ACTIVE=C2=A0 USE OBJ SIZE=C2=A0 SLABS OBJ/SLAB CACHE =
SIZE NAME
>> > 206080 206080 100%=C2=A0=C2=A0=C2=A0 0.14K=C2=A0=C2=A0 7360=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 28=C2=A0=C2=A0=C2=A0=C2=A0 29440K btrfs_extent_=
map
>> >
>> > I accelerated my testing by running fio test inside a QEMU VM with a l=
imited
>> amount of RAM (140MB):
>> >
>> > qemu-kvm
>> >=C2=A0=C2=A0 -kernel bzImage.v6.6 \
>> >=C2=A0=C2=A0 -m 140M=C2=A0 \
>> >=C2=A0=C2=A0 -drive file=3Drootfs.btrfs,format=3Draw,if=3Dnone,id=3Ddri=
ve0
>> > ...
>> >
>> > It appears that this issue may not be limited to direct IO writes alon=
e?
>>=C2=A0
>> In the buffered IO case it's typically much less likely to happen.
>>=C2=A0
>> The reason why it happens in your test it's because the VM has very litt=
le RAM,
>> 140M, which is very unlikely to find in the real world nowadays.=C2=A0
>
>I increased the memory to 8GB and ran the test overnight without any OOM e=
rrors. Glad memory management mechanism works as expected!
>
>> Pages can only
>> be released when they are not dirty and not under writeback, and in this=
 case
>> there's no fsync, so the amount of dirty pages (or under writeback)
>> accumulates very quickly.
>> If pages can not be released, extent maps can not be released either.
>>=C2=A0
>> If you add "fsync=3D1" to your fio test, things should change dramatical=
ly.
>>=C2=A0
>> Thanks.
>>=C2=A0
>> (And btw, try to avoid top posting if possible, as that makes the thread=
 harder
>> to follow.)
>My apologies for the top posting.
>
>Thanks for your help!
>
>--
>Abylay Ospan

I did not see if you were using compression mentioned anywhere in the email=
 chain but the extent map issue appears to be compounded significantly by c=
ompression. I've run into it under normal loads deleting snapshots on real =
machines with only 8gb of memory. https://www.spinics.net/lists/linux-btrfs=
/msg139657.html
Sincerely,
David
