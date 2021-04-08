Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689CF358081
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDHKWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 06:22:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:50035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHKWt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 06:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617877357;
        bh=tz7PDpgMeBHI2+zWudSAlg4Y0T81IAA2910jvuvrzWA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=KbFbiPVND462Au6f3HzqleC495ARdW9HAm6B7JiElm8p5UX9TKsPB1zxpFtHMgNdu
         dY3UgBGijJE2d2kdFRWbsythnScxhR75EAqj1IwNmVhehbstPVGkEnGNUqJNT0Xnq/
         SX4COe9L+gNz6AazhGQr2PsqWX+oN/6jtdjH4Mo8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1lQ45M11HM-00DDj5; Thu, 08
 Apr 2021 12:22:37 +0200
To:     Joe Hermaszewski <joe@monoid.al>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
 <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
 <CA+4cVr8XEJwyccvAhfgJUZyTcjubkava_1h+9+3BggN6XpH3iA@mail.gmail.com>
 <c8e82fcd-de9d-d46f-e455-1d0542fda706@gmx.com>
 <CA+4cVr-gg89KovFG+Yso0iYjhPjnx3eMNK8qG6W1SLY2WkozdA@mail.gmail.com>
 <8315aaf6-26e9-ad0a-cc49-1a1269266485@gmx.com>
 <CA+4cVr9nWjnNbWNctd4vZaoeyqFTyG1DCSTYbrbC4A27XtDG2Q@mail.gmail.com>
 <f8a63ef3-9eaa-f5ea-e403-be81ffcf7c85@gmx.com>
 <CA+4cVr82ujZrdsmjpUPBg3W2xL4gQJwjGwvA2LTy-yj73BhGfg@mail.gmail.com>
 <d7b26dfa-d40b-43e5-07e3-67d5377f84c2@gmx.com>
 <CA+4cVr8sxGT1Zz+1tz+0OqBCukFgn7d_ZZq31bXASc426YbJ7A@mail.gmail.com>
 <1ae47f73-f39e-bb71-d0b2-02999a703a4b@gmx.com>
 <CA+4cVr9Zgscn=L0a6CXrCaWK12mne8EpdW0eEe+PPuhQG2fmxQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs crash on armv7
Message-ID: <0cecdcfa-348d-adca-314e-dbf82fa38943@gmx.com>
Date:   Thu, 8 Apr 2021 18:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CA+4cVr9Zgscn=L0a6CXrCaWK12mne8EpdW0eEe+PPuhQG2fmxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3GqbeZqm0x59wontJIC2u8VJVyOpoltomrRiHvPoe5JUL9DXU2
 JIRVa6m341JkS+8uPMhiHdGQSObd/hkdYfDyZvsJcW4vsVHIDO0aTjudgUZIKAwBDzKNwah
 oU7EVIfEpulO6i4BKCe3NSb1Y9bkaAgYPJcRLEIyvFWvO0iUMQPOE3mecuEM99RbdsimZN1
 cQXFww1zXv0AhJnUcylFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Usdv7L5p6ac=:RGkcKrebQy8Y6Cp9stlyxn
 lhp+Px1rz/jQAUG4IU+Iv/rWmqSbCcR0Xhki1NRz7zTQz9bjtiJc6xkSG2TXygYVeTr7I5wm3
 zsfghXAKfTyd9d3TeTriV7VfImrG8aXJSCaUuITwrY9hoULlcGTc3CQdFExDEStozuv40zlSY
 vunMFsO4OXE3F5NtwfLwO+XbflRE9L9+fgWpOy9RPNTTEX9cxCgemggaVw2rOmVpL0l6eKNyu
 w1EvxHQ68ivoYG2oevjle0poHxcVv6lrX1DSD+4ZWshPS64qV3rvfsTzfqDTQ99QIDmg0Dk9h
 yaX/MJOgnaI3sLorz1cu/+yFmEVCiFNCfidVn2eQN5D6WDkk+cS0nnqg/wZpGZWR9ciDQze2C
 +MhWcOBfb3hz0RI1yuWq5N67uJnL0gEIsdd2mTQFZMyZhVPcE7xFkuLjPMi58h/3ZrEHCN0rw
 xd0i8mgnTNtda4y0JZWd7krKJVzrt/q/XykBcw7BuIqvughcKL756crub7QS9RCHuU8AeoPwn
 ZmoOoSzxH/QRmO65S+Urc/Gbrq29c8d4Ve7XC6Ch34V5GZR5yGUsz0e3q0fpZqzxz3FN23tV+
 Y54stnhbakQxENLgnvTCXztMA59w2Cyq9aO8iTSH6M40Y9HwFAPAUVPp8yKEZb645q9F2Z+pN
 I8QZDgdJRA1hhYZ0W5SidGACoA7jlJTOpvQxkQjuQmDl31az+tHOQNoZ+Sm5x2Ndz+mzIrohD
 //NZWTX5AVHqMW7pt4Eu8v600+KcboRUVr90fKiNJtOnzd0ILWahFCl9dEwQrOIMtSox5vmkB
 RkUriE9dMSvRhjEPTW0tPZwxU2MJUcv/0xAwbK888r4aN1W249HA7LC2BaYCe2YuESR3C0UlK
 V5rav+PRRz+2Ze259qUx164Kx9rbqbuFiqy/RKIql0bbjLnUmfSRNOnQJzFX1belOV8rDhvUq
 YBBVvqmBEJtIxk1HweLUR/4oreH6r8WOxJO6ZkSsL0TjITSF+5RbxCcclhkSrs2vpVBN8YvG3
 JEFBX88CyhV9XCFafRN2m3ixtIuWRN+k22kN7o0pbVHJocnuFSGJhJ4B1+gLxZQpDF0mO2EA3
 IElu21ReHbfLt9oWGNwNOjQ3zqUtFjs+IVqmgCWoHhUTQcPe8CzjKG1zPXm7xKogBwqVSFbE0
 JhZm0IJp68L/SWT6HSjVNQTN441q+oHQsz+Aej8TA9AHR7XXOT+ULKzvmypwacG6tzmxxLImi
 ZuGIq76uY9ahheYRd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/8 =E4=B8=8B=E5=8D=886:11, Joe Hermaszewski wrote:
> Thanks for explaining so patiently, I have a couple more questions if
> you have the time:
>
> With the patch I assume that this FS will just refuse to mount on
> arm32,

Yes.

If the fs has a chunk beyond 16T, it will be definitely be rejected.
For your case, since you already have such metadata, meaning there is
definitely at least one chunk at or beyond that boundary, thus
immediately rejection will be triggered.

> and in general such a large FS can't be used reliably there.

Not "reliably", but completely "unusable".

As btrfs can't even read some metadata, it would be a miracle to mount
the fs while avoiding all metadata read beyond 16T.

> (If I'm wrong about this, is it possible to use a 64 bit machine to
> move the offending metadata back below 16TB? (I feel that this may be
> a gross misunderstanding!))

Moving is possible (balance is here for the work).

But balance can only move data to larger bytenr, meaning it will just
make the case worse.

The requirement for balance to move data/metadata to larger bytenr is,
btrfs assumes chunk with larger bytenr are created newer.
Thus things like balance itself may use that feature to make sure if it
has balanced the full fs.

Thus in btrfs, the bytenr of new chunks are increamental, no way to
create a new chunk with lower bytenr.

>
> I'm not sure I understood this part of your reply:
>
>> Btrfs balance will also go forward larger bytenr, thus it's unrelated t=
o size at all.
>
> I just realised that the last couple of messages didn't go to the
> list, I'm happy for you to reply to the list if you feel that this
> conversation would be beneficial there!

Sorry my bad...

Thanks,
Qu

>
> On Thu, Apr 8, 2021 at 5:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/4/8 =E4=B8=8B=E5=8D=885:36, Joe Hermaszewski wrote:
>>> Thanks for the quick reply! In this case what's the best course of
>>> action for me?
>>>
>>> - Can this array be mounted and recovered without problems on a 64 bit
>>> machine?
>>
>> There should be no problem as long as btrfs check reports no error.
>>
>> It's purely runtime assumption failed to get met, thus no real damage t=
o
>> your fs.
>>
>>> - Does this 16TB limit refer to the total size of the devices, or the
>>> apparent size after RAID? (I assume the former as this array is only
>>> 14TB after raid I think).
>>
>> The limit is to any address space, not only some file/device size.
>>
>> For btrfs even you only have 1 disk with 1T size, you can still get
>> metadata beyond 16T.
>>
>> Btrfs balance will also go forward larger bytenr, thus it's unrelated t=
o
>> size at all.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks for the patch, I'll take a look at building my system with it i=
n
>>> future.
>>>
>>> Best wishes,
>>> Joe
>>>
>>>
>>> On Thu, Apr 8, 2021, 4:38 PM Qu Wenruo <quwenruo.btrfs@gmx.com
>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>
>>>
>>>
>>>      On 2021/4/8 =E4=B8=8B=E5=8D=884:16, Joe Hermaszewski wrote:
>>>       > It took a while but I managed to get hold of another one of th=
ese
>>>       > arm32 boards. Very disappointingly this exact "bitflip" is sti=
ll
>>>       > present (log enclosed).
>>>
>>>      Yeah, we got to the conclusion it's not bitflip, but completely 3=
2bit
>>>      limit on armv7.
>>>
>>>      For ARMv7, it's a 32bit system, where unsigned long is only 32bit=
.
>>>
>>>      This means, things like page->index is only 32bit long, and for 4=
K page
>>>      size, it also means all filesystems (not only btrfs) can only uti=
lize at
>>>      most 16T bytes.
>>>
>>>      But there is pitfall for btrfs, btrfs uses its internal address s=
pace
>>>      for its meatadata, and the address space is U64.
>>>
>>>      And furthermore, for btrfs it can have metadata at bytenr way lar=
ger
>>>      than the total device size.
>>>      This is possible because btrfs maps part of its address space to =
real
>>>      disks, thus it can have bytenr way larger than device size.
>>>
>>>      But this brings to a problem, 32bit Linux can only handle 16T, bu=
t in
>>>      your case, some of your metadata is already beyond 16T in btrfs a=
ddress
>>>      space.
>>>
>>>      Then a lot of things are going to be wrong.
>>>
>>>      I have submitted a patch to do extra check, at least allowing use=
r to
>>>      know this is the limit of 32bit:
>>>      https://patchwork.kernel.org/project/linux-btrfs/patch/2021022501=
1814.24009-1-wqu@suse.com/
>>>      <https://patchwork.kernel.org/project/linux-btrfs/patch/202102250=
11814.24009-1-wqu@suse.com/>
>>>
>>>      Unfortunately, this will not help existing fs though.
>>>
>>>      Thanks,
>>>      Qu
>>>       >
>>>       > To summarise, as it's been a while:
>>>       >
>>>       > - When running scrub, a "page_start" and "eb_start" mismatch i=
s
>>>       > detected (off by a single bit).
>>>       > - `btrfs check` reports no significant errors on aarch64 or ar=
m32.
>>>       > - `btrfs scrub` completes successfully on aarch64!
>>>       > - Now, I can confirm that `btrfs scrub` fails in the same mann=
er on
>>>       > two arm32 machines.
>>>       >
>>>       > Not really sure where to go from here. The only things I can
>>>      think of are:
>>>       >
>>>       > - Bug in `btrfs scrub` on arm32 (seems unlikely given the sing=
le-bit
>>>       > error here).
>>>       > - A bitflip on the original machine wrote bad data to the disk=
, and
>>>       > somehow only the arm32 implementation catches this...
>>>       >
>>>       > I can give a newer kernel a try (I'm on 5.4.80 at the moment) =
I
>>>      suppose
>>>       >
>>>       > Best,
>>>       > Joe
>>>       >
>>>       > ```
>>>       > $ dmesg
>>>       > [  258.791966] BTRFS info (device sda1): scrub: started on dev=
id 4
>>>       > [  258.792030] BTRFS info (device sda1): scrub: started on dev=
id 1
>>>       >
>>>       >   the magic generation gap you mention is
>>>       > 15, I'm more suspicious about me
>>>       >
>>>       > [  258.792062] BTRFS info (device sda1): scrub: started on dev=
id 2
>>>       > [  411.849669] ------------[ cut here ]------------
>>>       > [  411.849786] WARNING: CPU: 0 PID: 218 at fs/btrfs/disk-io.c:=
531
>>>       > btree_csum_one_bio+0x22c/0x278 [btrfs]
>>>       > [  411.849789] Modules linked in: cfg80211 rfkill 8021q ip6tab=
le_nat
>>>       > iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6
>>>       > nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter ip6table_raw iptable=
_raw
>>>       > xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcp=
udp
>>>       > ip6table_filter ip6_tables iptable_filter phy_generic uio_pdrv=
_genirq
>>>       > uio sch_fq_codel loop tun tap macvlan bridge stp llc lm75 ip_t=
ables
>>>       > x_tables autofs4 dm_mod dax btrfs libcrc32c xor raid6_pq
>>>       > [  411.849836] CPU: 0 PID: 218 Comm: btrfs-transacti Not taint=
ed
>>>      5.4.80 #1-NixOS
>>>       > [  411.849838] Hardware name: Marvell Armada 380/385 (Device T=
ree)
>>>       > [  411.849840] Backtrace:
>>>       > [  411.849850] [<c010f698>] (dump_backtrace) from [<c010f938>]
>>>       > (show_stack+0x20/0x24)
>>>       > [  411.849855]  r7:00000213 r6:600f0013 r5:00000000 r4:c0f8c0c=
4
>>>       > [  411.849861] [<c010f918>] (show_stack) from [<c0a1bb28>]
>>>       > (dump_stack+0x98/0xac)
>>>       > [  411.849866] [<c0a1ba90>] (dump_stack) from [<c012a998>]
>>>      (__warn+0xe0/0x108)
>>>       > [  411.849870]  r7:00000213 r6:bf058f4c r5:00000009 r4:bf12099=
0
>>>       > [  411.849875] [<c012a8b8>] (__warn) from [<c012ad24>]
>>>       > (warn_slowpath_fmt+0x74/0xc4)
>>>       > [  411.849878]  r7:00000213 r6:bf120990 r5:00000000 r4:e1c1c00=
0
>>>       > [  411.849936] [<c012acb4>] (warn_slowpath_fmt) from [<bf058f4=
c>]
>>>       > (btree_csum_one_bio+0x22c/0x278 [btrfs])
>>>       > [  411.849941]  r9:00000001 r8:e6afec78 r7:e1c1c000 r6:ed7f700=
0
>>>       > r5:00001000 r4:8fd00000
>>>       > [  411.850044] [<bf058d20>] (btree_csum_one_bio [btrfs]) from
>>>       > [<bf059f84>] (btree_submit_bio_hook+0xe8/0x100 [btrfs])
>>>       > [  411.850049]  r10:e6afe4c0 r9:ecc57fc0 r8:ecc57f70 r7:ed7f70=
00
>>>       > r6:00000000 r5:c1660370
>>>       > [  411.850051]  r4:bf059e9c
>>>       > [  411.850154] [<bf059e9c>] (btree_submit_bio_hook [btrfs]) fr=
om
>>>       > [<bf08b1ac>] (submit_one_bio+0x44/0x5c [btrfs])
>>>       > [  411.850158]  r7:ef2d58ec r6:e1c1dcac r5:00000000 r4:bf059e9=
c
>>>       > [  411.850260] [<bf08b168>] (submit_one_bio [btrfs]) from
>>>      [<bf096664>]
>>>       > (btree_write_cache_pages+0x380/0x408 [btrfs])
>>>       > [  411.850263]  r5:00000000 r4:00000000
>>>       > [  411.850366] [<bf0962e4>] (btree_write_cache_pages [btrfs]) =
from
>>>       > [<bf0590b8>] (btree_writepages+0x7c/0x84 [btrfs])
>>>       > [  411.850371]  r10:00000001 r9:8fd00000 r8:c0280bcc r7:e1c1c0=
00
>>>       > r6:e1c1dd80 r5:ecc57f70
>>>       > [  411.850373]  r4:e1c1dd80
>>>       > [  411.850428] [<bf05903c>] (btree_writepages [btrfs]) from
>>>       > [<c0284680>] (do_writepages+0x58/0xf4)
>>>       > [  411.850431]  r5:ecc57f70 r4:ecc57e68
>>>       > [  411.850439] [<c0284628>] (do_writepages) from [<c0278b68>]
>>>       > (__filemap_fdatawrite_range+0xf8/0x130)
>>>       > [  411.850442]  r8:ecc57f70 r7:00001000 r6:8fd0bfff r5:e1c1c00=
0
>>>      r4:ecc57e68
>>>       > [  411.850448] [<c0278a70>] (__filemap_fdatawrite_range) from
>>>       > [<c0278cf0>] (filemap_fdatawrite_range+0x2c/0x34)
>>>       > [  411.850452]  r10:ecc57f70 r9:00001000 r8:8fd0bfff r7:e1c1de=
4c
>>>       > r6:e0202428 r5:00001000
>>>       > [  411.850454]  r4:8fd0bfff
>>>       > [  411.850509] [<c0278cc4>] (filemap_fdatawrite_range) from
>>>       > [<bf060544>] (btrfs_write_marked_extents+0x9c/0x1b0 [btrfs])
>>>       > [  411.850512]  r5:00000001 r4:00000000
>>>       > [  411.850615] [<bf0604a8>] (btrfs_write_marked_extents [btrfs=
]) from
>>>       > [<bf0606f0>] (btrfs_write_and_wait_transaction+0x54/0xa4 [btrf=
s])
>>>       > [  411.850620]  r10:e1c1c000 r9:ed7f7010 r8:ed7f7000 r7:e02024=
28
>>>       > r6:ed7f7000 r5:e1c1c000
>>>       > [  411.850621]  r4:e56433f0
>>>       > [  411.850724] [<bf06069c>] (btrfs_write_and_wait_transaction
>>>      [btrfs])
>>>       > from [<bf062428>] (btrfs_commit_transaction+0x75c/0xc94 [btrfs=
])
>>>       > [  411.850728]  r8:ed7f7418 r7:e0202400 r6:ed7f7000 r5:e56433f=
0
>>>      r4:00000000
>>>       > [  411.850831] [<bf061ccc>] (btrfs_commit_transaction [btrfs])=
 from
>>>       > [<bf05cd98>] (transaction_kthread+0x19c/0x1e0 [btrfs])
>>>       > [  411.850836]  r10:ed7f728c r9:00000000 r8:001abf6a r7:000000=
64
>>>       > r6:ed7f7414 r5:00000bb8
>>>       > [  411.850838]  r4:ed7f7000
>>>       > [  411.850893] [<bf05cbfc>] (transaction_kthread [btrfs]) from
>>>       > [<c014fab4>] (kthread+0x170/0x174)
>>>       > [  411.850898]  r10:ecbddbfc r9:bf05cbfc r8:ed669800 r7:e1c1c0=
00
>>>       > r6:00000000 r5:ed560d40
>>>       > [  411.850899]  r4:ed54eb00
>>>       > [  411.850904] [<c014f944>] (kthread) from [<c01010e8>]
>>>       > (ret_from_fork+0x14/0x2c)
>>>       > [  411.850907] Exception stack(0xe1c1dfb0 to 0xe1c1dff8)
>>>       > [  411.850911] dfa0:                                     00000=
000
>>>       > 00000000 00000000 00000000
>>>       > [  411.850915] dfc0: 00000000 00000000 00000000 00000000 00000=
000
>>>       > 00000000 00000000 00000000
>>>       > [  411.850919] dfe0: 00000000 00000000 00000000 00000000 00000=
013
>>>      00000000
>>>       > [  411.850923]  r10:00000000 r9:00000000 r8:00000000 r7:000000=
00
>>>       > r6:00000000 r5:c014f944
>>>       > [  411.850925]  r4:ed560d40
>>>       > [  411.850976] ---[ end trace 1bbf4c394bd7fb26 ]---
>>>       > [  411.850986] BTRFS warning (device sda1): page_start and eb_=
start
>>>       > mismatch, eb_start=3D17594598817792 page_start=3D2412773376
>>>       > [  411.857914] BTRFS: error (device sda1) in
>>>       > btrfs_commit_transaction:2279: errno=3D-5 IO failure (Error wh=
ile
>>>       > writing out transaction)
>>>       > [  411.869764] BTRFS info (device sda1): forced readonly
>>>       > [  411.869772] BTRFS warning (device sda1): Skipping commit of
>>>      aborted
>>>       > transaction.
>>>       > [  411.869778] BTRFS: error (device sda1) in
>>>      cleanup_transaction:1832:
>>>       > errno=3D-5 IO failure
>>>       > [  411.877843] BTRFS info (device sda1): delayed_refs has NO e=
ntry
>>>       > [  411.878076] BTRFS warning (device sda1): Skipping commit of
>>>      aborted
>>>       > transaction.
>>>       > [  411.882940] BTRFS warning (device sda1): failed setting blo=
ck
>>>      group ro: -30
>>>       > [  411.882956] BTRFS info (device sda1): scrub: not finished o=
n devid
>>>       > 3 with status: -30
>>>       > [  411.883030] BTRFS warning (device sda1): failed setting blo=
ck
>>>      group ro: -30
>>>       > [  411.883039] BTRFS info (device sda1): scrub: not finished o=
n devid
>>>       > 4 with status: -30
>>>       > [  411.883104] BTRFS warning (device sda1): failed setting blo=
ck
>>>      group ro: -30
>>>       > [  411.883116] BTRFS info (device sda1): scrub: not finished o=
n devid
>>>       > 1 with status: -30
>>>       > [  411.883191] BTRFS warning (device sda1): failed setting blo=
ck
>>>      group ro: -30
>>>       > [  411.883200] BTRFS info (device sda1): scrub: not finished o=
n devid
>>>       > 2 with status: -30
>>>       > [  411.953186] BTRFS info (device sda1): delayed_refs has NO e=
ntry
>>>       > [  576.361548] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.369639] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.378477] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.386936] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.395093] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.396830] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.403153] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  576.450091] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.462821] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.474987] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.486882] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.497905] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.824673] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  576.838414] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  577.324362] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  577.337736] BTRFS error (device sda1): parent transid verif=
y
>>>      failed
>>>       > on 12756293910528 wanted 1752939 found 1752922
>>>       > [  578.462271] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  578.470347] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  578.479476] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  578.488099] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  578.496793] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  578.505280] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.539117] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.547207] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.556371] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.564922] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.573356] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  580.581573] BTRFS critical (device sda1): unable to find lo=
gical
>>>       > 2412789760 length 4096
>>>       > [  581.427776] verify_parent_transid: 28 callbacks suppressed
>>>       > ... many more of these
>>>       > ```
>>>       >
>>>       > On Sun, Dec 20, 2020 at 8:30 AM Qu Wenruo <quwenruo.btrfs@gmx.=
com
>>>      <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>       >>
>>>       >>
>>>       >>
>>>       >> On 2020/12/19 =E4=B8=8B=E5=8D=886:35, Joe Hermaszewski wrote:
>>>       >>> Ok, so I managed to get hold of a 64bit machine on which to =
run
>>>      btrfs
>>>       >>> check. `btrfs check` returns exactly the same output as the
>>>      armv7 box
>>>       >>> (no serious problems) which I suppose is good. `btrfs scrub`=
 also
>>>       >>> finds no problems. Boring Logs below.
>>>       >>>
>>>       >>> What I don't quite understand is how the scrub problem on
>>>      armv7l is so
>>>       >>> reliable when it's not persisted on the disks, is the same p=
hysical
>>>       >>> memory location being used for this breaking value, or is it
>>>      perhaps a
>>>       >>> specific pattern of data on the bus which causes this?
>>>       >>
>>>       >> If it's so reliably reproducible, then I guess that would be =
the
>>>      case,
>>>       >> either a specific memory range has the problem, or a specific
>>>      pattern on
>>>       >> the bus causing the problem.
>>>       >>
>>>       >>>
>>>       >>> If it's the former, how easy would it be to find this broken
>>>      location
>>>       >>> and blacklist it? If it's the latter then I guess there's no
>>>      hope but
>>>       >>> to try replacing the psu/machine.
>>>       >>>
>>>       >>> The machine survived a couple of days of memtester (on about=
 95% of
>>>       >>> the RAM) and `7z b` with no problems, *shrug*
>>>       >>
>>>       >> The memtester should rule out the former case, the latter cas=
e
>>>      may be
>>>       >> resolved by newer kernel if it's not a hardware problem but a
>>>      software one.
>>>       >>
>>>       >> Thanks,
>>>       >> Qu
>>>       >>
>>>       >>>
>>>       >>> Best wishes and thanks for the generous help so far.
>>>       >>> Joe
>>>       >>>
>>>       >>> btrfs scrub aarch64:
>>>       >>> ```
>>>       >>> [j@nixos:~]$ sudo btrfs scrub status -d /mnt
>>>       >>> UUID:             b8f4ad49-29c8-4d19-a886-cef9c487f124
>>>       >>> scrub device /dev/sda1 (id 1) history
>>>       >>> Scrub started:    Fri Dec 18 14:24:30 2020
>>>       >>> Status:           finished
>>>       >>> Duration:         7:36:31
>>>       >>> Total to scrub:   2.40TiB
>>>       >>> Rate:             91.95MiB/s
>>>       >>> Error summary:    no errors found
>>>       >>> scrub device /dev/sdb1 (id 2) history
>>>       >>> Scrub started:    Fri Dec 18 14:24:30 2020
>>>       >>> Status:           finished
>>>       >>> Duration:         7:12:51
>>>       >>> Total to scrub:   2.40TiB
>>>       >>> Rate:             96.90MiB/s
>>>       >>> Error summary:    no errors found
>>>       >>> scrub device /dev/sdd1 (id 3) history
>>>       >>> Scrub started:    Fri Dec 18 14:24:30 2020
>>>       >>> Status:           finished
>>>       >>> Duration:         19:47:01
>>>       >>> Total to scrub:   7.86TiB
>>>       >>> Rate:             115.70MiB/s
>>>       >>> Error summary:    no errors found
>>>       >>> scrub device /dev/sdc1 (id 4) history
>>>       >>> Scrub started:    Fri Dec 18 14:24:30 2020
>>>       >>> Status:           finished
>>>       >>> Duration:         19:46:38
>>>       >>> Total to scrub:   7.86TiB
>>>       >>> Rate:             115.74MiB/s
>>>       >>> Error summary:    no errors found
>>>       >>> ```
>>>       >>>
>>>       >>> btrfs check aarch64:
>>>       >>> ```
>>>       >>> [nixos@nixos:/]$ sudo btrfs check --readonly /dev/sda1
>>>       >>> Opening filesystem to check...
>>>       >>> Checking filesystem on /dev/sda1
>>>       >>> UUID: b8f4ad49-29c8-4d19-a886-cef9c487f124
>>>       >>> [1/7] checking root items
>>>       >>> [2/7] checking extents
>>>       >>> [3/7] checking free space cache
>>>       >>> [4/7] checking fs roots
>>>       >>> root 294 inode 24665 errors 100, file extent discount
>>>       >>> Found file extent holes:
>>>       >>>           start: 3709534208, len: 163840
>>>       >>> root 294 inode 406548 errors 100, file extent discount
>>>       >>> Found file extent holes:
>>>       >>>           start: 98729984, len: 720896
>>>       >>> ERROR: errors found in fs roots
>>>       >>> found 11280701063168 bytes used, error(s) found
>>>       >>> total csum bytes: 10937464120
>>>       >>> total tree bytes: 18538053632
>>>       >>> total fs tree bytes: 5877579776
>>>       >>> total extent tree bytes: 534052864
>>>       >>> btree space waste bytes: 2316660292
>>>       >>> file data blocks allocated: 17244587220992
>>>       >>>    referenced 14211684794368%
>>>       >>> ```
>>>       >>>
>>>       >>>
>>>       >>> On Sat, Nov 28, 2020 at 8:46 AM Qu Wenruo
>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>       >>>>
>>>       >>>>
>>>       >>>>
>>>       >>>> On 2020/11/27 =E4=B8=8B=E5=8D=8811:15, Joe Hermaszewski wro=
te:
>>>       >>>>> Hi Qu,
>>>       >>>>>
>>>       >>>>> Thanks for the patch. I recompiled the kernel ran the scru=
b
>>>      and your
>>>       >>>>> patch worked as expected, here is the log:
>>>       >>>>>
>>>       >>>>> ```
>>>       >>>>> [  337.365239] BTRFS info (device sda1): scrub: started on
>>>      devid 2
>>>       >>>>> [  337.366283] BTRFS info (device sda1): scrub: started on
>>>      devid 1
>>>       >>>>> [  337.402822] BTRFS info (device sda1): scrub: started on
>>>      devid 3
>>>       >>>>> [  337.411944] BTRFS info (device sda1): scrub: started on
>>>      devid 4
>>>       >>>>> [  471.997496] ------------[ cut here ]------------
>>>       >>>>> [  471.997614] WARNING: CPU: 0 PID: 218 at fs/btrfs/disk-i=
o.c:531
>>>       >>>>> btree_csum_one_bio+0x22c/0x278 [btrfs]
>>>       >>>>> [  471.997616] Modules linked in: cfg80211 rfkill 8021q
>>>      ip6table_nat
>>>       >>>>> iptable_nat nf_nat ftdi_sio phy_generic usbserial xt_connt=
rack
>>>       >>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_rpfilter
>>>      ipt_rpfilter
>>>       >>>>> ip6table_raw uio_pdrv_genirq iptable_raw uio xt_pkttype
>>>      nf_log_ipv6
>>>       >>>>> nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp ip6table_filter
>>>      ip6_tables
>>>       >>>>> iptable_filter sch_fq_codel loop tun tap macvlan bridge st=
p
>>>      llc lm75
>>>       >>>>> ip_tables x_tables autofs4 dm_mod dax btrfs libcrc32c xor
>>>      raid6_pq
>>>       >>>>> [  471.997666] CPU: 0 PID: 218 Comm: btrfs-transacti Not
>>>      tainted 5.4.78 #1-NixOS
>>>       >>>>> [  471.997668] Hardware name: Marvell Armada 380/385 (Devi=
ce
>>>      Tree)
>>>       >>>>> [  471.997669] Backtrace:
>>>       >>>>> [  471.997680] [<c010f698>] (dump_backtrace) from [<c010f9=
38>]
>>>       >>>>> (show_stack+0x20/0x24)
>>>       >>>>> [  471.997684]  r7:00000213 r6:600c0013 r5:00000000 r4:c0f=
8c044
>>>       >>>>> [  471.997691] [<c010f918>] (show_stack) from [<c0a1b848>]
>>>       >>>>> (dump_stack+0x98/0xac)
>>>       >>>>> [  471.997696] [<c0a1b7b0>] (dump_stack) from [<c012a998>]
>>>      (__warn+0xe0/0x108)
>>>       >>>>> [  471.997700]  r7:00000213 r6:bf058f4c r5:00000009 r4:bf1=
20990
>>>       >>>>> [  471.997704] [<c012a8b8>] (__warn) from [<c012ad24>]
>>>       >>>>> (warn_slowpath_fmt+0x74/0xc4)
>>>       >>>>> [  471.997707]  r7:00000213 r6:bf120990 r5:00000000 r4:e18=
22000
>>>       >>>>> [  471.997765] [<c012acb4>] (warn_slowpath_fmt) from [<bf0=
58f4c>]
>>>       >>>>> (btree_csum_one_bio+0x22c/0x278 [btrfs])
>>>       >>>>> [  471.997770]  r9:00000001 r8:c10decb8 r7:e1822000 r6:ed6=
6b000
>>>       >>>>> r5:00001000 r4:4fd00000
>>>       >>>>> [  471.997872] [<bf058d20>] (btree_csum_one_bio [btrfs]) f=
rom
>>>       >>>>> [<bf059f84>] (btree_submit_bio_hook+0xe8/0x100 [btrfs])
>>>       >>>>> [  471.997877]  r10:e2197b48 r9:ec845fc0 r8:ec845f70 r7:ed=
66b000
>>>       >>>>> r6:00000000 r5:e2b74af0
>>>       >>>>> [  471.997879]  r4:bf059e9c
>>>       >>>>> [  471.997981] [<bf059e9c>] (btree_submit_bio_hook [btrfs]=
) from
>>>       >>>>> [<bf08b1ac>] (submit_one_bio+0x44/0x5c [btrfs])
>>>       >>>>> [  471.997985]  r7:ef3724d4 r6:e1823cac r5:00000000 r4:bf0=
59e9c
>>>       >>>>> [  471.998087] [<bf08b168>] (submit_one_bio [btrfs]) from
>>>      [<bf096664>]
>>>       >>>>> (btree_write_cache_pages+0x380/0x408 [btrfs])
>>>       >>>>> [  471.998090]  r5:00000000 r4:00000000
>>>       >>>>> [  471.998193] [<bf0962e4>] (btree_write_cache_pages [btrf=
s])
>>>      from
>>>       >>>>> [<bf0590b8>] (btree_writepages+0x7c/0x84 [btrfs])
>>>       >>>>> [  471.998197]  r10:00000001 r9:4fd00000 r8:c0280d14 r7:e1=
822000
>>>       >>>>> r6:e1823d80 r5:ec845f70
>>>       >>>>> [  471.998199]  r4:e1823d80
>>>       >>>>> [  471.998255] [<bf05903c>] (btree_writepages [btrfs]) fro=
m
>>>       >>>>> [<c02847c8>] (do_writepages+0x58/0xf4)
>>>       >>>>> [  471.998258]  r5:ec845f70 r4:ec845e68
>>>       >>>>> [  471.998266] [<c0284770>] (do_writepages) from [<c0278cb=
0>]
>>>       >>>>> (__filemap_fdatawrite_range+0xf8/0x130)
>>>       >>>>> [  471.998270]  r8:ec845f70 r7:00001000 r6:4fd0bfff
>>>      r5:e1822000 r4:ec845e68
>>>       >>>>> [  471.998275] [<c0278bb8>] (__filemap_fdatawrite_range) f=
rom
>>>       >>>>> [<c0278e38>] (filemap_fdatawrite_range+0x2c/0x34)
>>>       >>>>> [  471.998279]  r10:ec845f70 r9:00001000 r8:4fd0bfff r7:e1=
823e4c
>>>       >>>>> r6:c1955e28 r5:00001000
>>>       >>>>> [  471.998281]  r4:4fd0bfff
>>>       >>>>> [  471.998335] [<c0278e0c>] (filemap_fdatawrite_range) fro=
m
>>>       >>>>> [<bf060544>] (btrfs_write_marked_extents+0x9c/0x1b0 [btrfs=
])
>>>       >>>>> [  471.998338]  r5:00000001 r4:00000000
>>>       >>>>> [  471.998441] [<bf0604a8>] (btrfs_write_marked_extents
>>>      [btrfs]) from
>>>       >>>>> [<bf0606f0>] (btrfs_write_and_wait_transaction+0x54/0xa4 [=
btrfs])
>>>       >>>>> [  471.998446]  r10:e1822000 r9:ed66b010 r8:ed66b000 r7:c1=
955e28
>>>       >>>>> r6:ed66b000 r5:e1822000
>>>       >>>>> [  471.998447]  r4:eddc4f30
>>>       >>>>> [  471.998551] [<bf06069c>] (btrfs_write_and_wait_transact=
ion
>>>      [btrfs])
>>>       >>>>> from [<bf062428>] (btrfs_commit_transaction+0x75c/0xc94 [b=
trfs])
>>>       >>>>> [  471.998555]  r8:ed66b418 r7:c1955e00 r6:ed66b000
>>>      r5:eddc4f30 r4:00000000
>>>       >>>>> [  471.998658] [<bf061ccc>] (btrfs_commit_transaction
>>>      [btrfs]) from
>>>       >>>>> [<bf05cd98>] (transaction_kthread+0x19c/0x1e0 [btrfs])
>>>       >>>>> [  471.998663]  r10:ed66b28c r9:00000000 r8:001aab57 r7:00=
000064
>>>       >>>>> r6:ed66b414 r5:00000bb8
>>>       >>>>> [  471.998664]  r4:ed66b000
>>>       >>>>> [  471.998719] [<bf05cbfc>] (transaction_kthread [btrfs]) =
from
>>>       >>>>> [<c014facc>] (kthread+0x170/0x174)
>>>       >>>>> [  471.998724]  r10:ed765bfc r9:bf05cbfc r8:ed56a000 r7:e1=
822000
>>>       >>>>> r6:00000000 r5:ed5c8600
>>>       >>>>> [  471.998726]  r4:ed5c8740
>>>       >>>>> [  471.998731] [<c014f95c>] (kthread) from [<c01010e8>]
>>>       >>>>> (ret_from_fork+0x14/0x2c)
>>>       >>>>> [  471.998733] Exception stack(0xe1823fb0 to 0xe1823ff8)
>>>       >>>>> [  471.998737] 3fa0:                                     0=
0000000
>>>       >>>>> 00000000 00000000 00000000
>>>       >>>>> [  471.998741] 3fc0: 00000000 00000000 00000000 00000000 0=
0000000
>>>       >>>>> 00000000 00000000 00000000
>>>       >>>>> [  471.998745] 3fe0: 00000000 00000000 00000000 00000000
>>>      00000013 00000000
>>>       >>>>> [  471.998749]  r10:00000000 r9:00000000 r8:00000000 r7:00=
000000
>>>       >>>>> r6:00000000 r5:c014f95c
>>>       >>>>> [  471.998751]  r4:ed5c8600
>>>       >>>>> [  471.998820] ---[ end trace 6a9fb9f547659a4d ]---
>>>       >>>>> [  471.998855] BTRFS warning (device sda1): page_start and
>>>      eb_start
>>>       >>>>> mismatch, eb_start=3D17593525075968 page_start=3D133903155=
2
>>>       >>>>> [  472.015514] BTRFS: error (device sda1) in
>>>       >>>>> btrfs_commit_transaction:2279: errno=3D-5 IO failure (Erro=
r while
>>>       >>>>> writing out transaction)
>>>       >>>>> [  472.027321] BTRFS info (device sda1): forced readonly
>>>       >>>>> [  472.027326] BTRFS warning (device sda1): Skipping commi=
t
>>>      of aborted
>>>       >>>>> transaction.
>>>       >>>>> [  472.027330] BTRFS: error (device sda1) in
>>>      cleanup_transaction:1832:
>>>       >>>>> errno=3D-5 IO failure
>>>       >>>>> [  472.035378] BTRFS info (device sda1): delayed_refs has =
NO
>>>      entry
>>>       >>>>> [  472.039102] BTRFS warning (device sda1): failed setting
>>>      block group ro: -30
>>>       >>>>> [  472.039107] BTRFS info (device sda1): scrub: not finish=
ed
>>>      on devid
>>>       >>>>> 3 with status: -30
>>>       >>>>> [  472.039114] BTRFS info (device sda1): scrub: not finish=
ed
>>>      on devid
>>>       >>>>> 4 with status: -30
>>>       >>>>> [  472.039227] BTRFS warning (device sda1): failed setting
>>>      block group ro: -30
>>>       >>>>> [  472.039230] BTRFS warning (device sda1): failed setting
>>>      block group ro: -30
>>>       >>>>> [  472.039237] BTRFS info (device sda1): scrub: not finish=
ed
>>>      on devid
>>>       >>>>> 2 with status: -30
>>>       >>>>> [  472.039243] BTRFS info (device sda1): scrub: not finish=
ed
>>>      on devid
>>>       >>>>> 1 with status: -30
>>>       >>>>> ```
>>>       >>>>>
>>>       >>>>> To rob you of the suspense:
>>>       >>>>>
>>>       >>>>> printf "0x%016x\n" (17593525075968 - 1339031552)
>>>       >>>>> 0x0000100000000000
>>>       >>>>>
>>>       >>>>> Very surprising considering that this machine has ECC ram!
>>>       >>>>
>>>       >>>> ARMv7 with ECC, and we still had such bitflip!?
>>>       >>>>
>>>       >>>> I guess everything is possible in 2020.
>>>       >>>>
>>>       >>>>>
>>>       >>>>> What would you recommend as a fix?
>>>       >>>>
>>>       >>>> It's a hardware problem, I really don't have any
>>>      recommendation at all.
>>>       >>>>
>>>       >>>> I guess you may want to request an RMA?
>>>       >>>>
>>>       >>>> Thanks,
>>>       >>>> Qu
>>>       >>>>
>>>       >>>>>
>>>       >>>>> Best,
>>>       >>>>> Joe
>>>       >>>>>
>>>       >>>>> On Thu, Nov 26, 2020 at 7:05 PM Qu Wenruo
>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>       >>>>>>
>>>       >>>>>>
>>>       >>>>>>
>>>       >>>>>> On 2020/11/26 =E4=B8=8B=E5=8D=886:53, Joe Hermaszewski wr=
ote:
>>>       >>>>>>> Hi Qu,
>>>       >>>>>>>
>>>       >>>>>>> This is the output of btrfs check with the device unmoun=
ted:
>>>       >>>>>>>
>>>       >>>>>>> ```
>>>       >>>>>>> [root@nixos:~]# btrfs check --readonly /dev/sda1
>>>       >>>>>>> Opening filesystem to check...
>>>       >>>>>>> Checking filesystem on /dev/sda1
>>>       >>>>>>> UUID: b8f4ad49-29c8-4d19-a886-cef9c487f124
>>>       >>>>>>> [1/7] checking root items
>>>       >>>>>>> [2/7] checking extents
>>>       >>>>>>> [3/7] checking free space cache
>>>       >>>>>>> [4/7] checking fs roots
>>>       >>>>>>> root 294 inode 24665 errors 100, file extent discount
>>>       >>>>>>> Found file extent holes:
>>>       >>>>>>>           start: 3709534208, len: 163840
>>>       >>>>>>> root 294 inode 406548 errors 100, file extent discount
>>>       >>>>>>> Found file extent holes:
>>>       >>>>>>>           start: 0, len: 99450880
>>>       >>>>>>> ERROR: errors found in fs roots
>>>       >>>>>>> found 11279251902464 bytes used, error(s) found
>>>       >>>>>>> total csum bytes: 10935906504
>>>       >>>>>>> total tree bytes: 18455740416
>>>       >>>>>>> total fs tree bytes: 5798936576
>>>       >>>>>>> total extent tree bytes: 532250624
>>>       >>>>>>> btree space waste bytes: 2308849707
>>>       >>>>>>> file data blocks allocated: 17243418611712
>>>       >>>>>>>    referenced 14210256932864
>>>       >>>>>>> ```
>>>       >>>>>>>
>>>       >>>>>>> Looks the same as before...
>>>       >>>>>>
>>>       >>>>>> Then it means, at least your metadata is pretty safe.
>>>      Nothing really
>>>       >>>>>> needs to be worried (so far).
>>>       >>>>>>
>>>       >>>>>> This also means, the problem only happens at runtime, not
>>>      something on-disk.
>>>       >>>>>>
>>>       >>>>>> If you are OK to re-compile the kernel, and the warning
>>>      message is
>>>       >>>>>> always the same at line number 531 of disk-io.c, then I
>>>      recommend the
>>>       >>>>>> attached debug diff
>>>       >>>>>>
>>>       >>>>>> The diff will output the found_start (from eb) and
>>>      page_start (from page).
>>>       >>>>>> If it's memory bitflip, we should have a pretty signature
>>>      diff at the
>>>       >>>>>> output.
>>>       >>>>>> If not memory bitflip, then we really have a bug to dig.
>>>       >>>>>>
>>>       >>>>>>
>>>       >>>>>>>
>>>       >>>>>>> I'm afraid I don't have the precise details of the trans=
id
>>>      error
>>>       >>>>>>> saved. I think I meant to write earlier that the message
>>>      that comes up
>>>       >>>>>>> now and then is the "errno=3D-5 IO failure (Error while
>>>      writing out
>>>       >>>>>>> transaction)". I've not seen the transid mismatch one si=
nce
>>>      the first
>>>       >>>>>>> incident, sorry for that slip-up.
>>>       >>>>>>>
>>>       >>>>>>> I'll try and attach to a known good system, will I have =
to
>>>      attach the
>>>       >>>>>>> whole array because I don't think I have that many
>>>      enclosures for the
>>>       >>>>>>> drives.
>>>       >>>>>>
>>>       >>>>>> You only need to mount the fs you're seeing the problem.
>>>       >>>>>> But if that fs is on multiple devices, then I guess you n=
eed
>>>      to mount
>>>       >>>>>> them all.
>>>       >>>>>>
>>>       >>>>>> Thanks,
>>>       >>>>>> Qu
>>>       >>>>>>>
>>>       >>>>>>> I'll also run a memtest on this box.
>>>       >>>>>>>
>>>       >>>>>>> Thank you for the helpful response.
>>>       >>>>>>>
>>>       >>>>>>> Best,
>>>       >>>>>>> Joe
>>>       >>>>>>>
>>>       >>>>>>> On Thu, Nov 26, 2020 at 2:15 PM Qu Wenruo
>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>       >>>>>>>>
>>>       >>>>>>>>
>>>       >>>>>>>>
>>>       >>>>>>>> On 2020/11/25 =E4=B8=8B=E5=8D=8811:28, Joe Hermaszewski=
 wrote:
>>>       >>>>>>>>> Hi,
>>>       >>>>>>>>>
>>>       >>>>>>>>> I have a arm32 machine with four drives with a btrfs f=
s
>>>      spanning then in RAID1.
>>>       >>>>>>>>> The filesystem has started behaving badly recently and
>>>      I'm writing to:
>>>       >>>>>>>>>
>>>       >>>>>>>>> - Solicit advice on how best to get the system back to=
 a
>>>      stable state
>>>       >>>>>>>>> - Report a potential bug
>>>       >>>>>>>>>
>>>       >>>>>>>>> ## What happened:
>>>       >>>>>>>>>
>>>       >>>>>>>>> A couple of days ago I could no longer ssh into it, an=
d
>>>      on the serial
>>>       >>>>>>>>> connection there were heaps of messages (and new ones
>>>      appearing with great
>>>       >>>>>>>>> frequency) along the lines of: `parent transid verify
>>>      failed on blah... wanted
>>>       >>>>>>>>> x got y`.
>>>       >>>>>>>>>
>>>       >>>>>>>>> Although I don't have a record of the precise messages=
 I
>>>      do remember that there
>>>       >>>>>>>>> was a difference of `15` between x and y.
>>>       >>>>>>>>
>>>       >>>>>>>> This normally can be a sign of unreliable HDD, which li=
es
>>>      on FLUSH,
>>>       >>>>>>>> killing metadata COW.
>>>       >>>>>>>>
>>>       >>>>>>>> But, your btrfs check doesn't report the same problem,
>>>      thus I'm confused.
>>>       >>>>>>>>
>>>       >>>>>>>> Would you please try to run a "btrfs check --readonly
>>>      /dev/sda1" with
>>>       >>>>>>>> the fs unmounted?
>>>       >>>>>>>>
>>>       >>>>>>>> And, would you provide the full dmesg of that mismatch?
>>>       >>>>>>>> The reason for the exact number is, I'm suspecting
>>>      hardware memory
>>>       >>>>>>>> corruption.
>>>       >>>>>>>>
>>>       >>>>>>>>>
>>>       >>>>>>>>> I power-cycled system and started a scrub after it
>>>      rebooted, this was
>>>       >>>>>>>>> interrupted quite promptly by several more errors in
>>>      btrfs, and the disk
>>>       >>>>>>>>> remounted RO.
>>>       >>>>>>>>>
>>>       >>>>>>>>> Every now and then in the kernel log I get messages li=
ke:
>>>       >>>>>>>>>
>>>       >>>>>>>>> `parent transid verify failed on blah... wanted x got =
y`
>>>       >>>>>>>>
>>>       >>>>>>>> Not showing up in the gist dmesg though.
>>>       >>>>>>>>
>>>       >>>>>>>>>
>>>       >>>>>>>>> ## Important info
>>>       >>>>>>>>>
>>>       >>>>>>>>> The dev stats are all zero.
>>>       >>>>>>>>>
>>>       >>>>>>>>> Here are the outputs of some btrfs commands, dmesg and
>>>      the kernel log from the
>>>       >>>>>>>>> previous two boots:
>>>      https://gist.github.com/b1beab134403c5047e2efbceb98985f9
>>>      <https://gist.github.com/b1beab134403c5047e2efbceb98985f9>
>>>       >>>>>>>>>
>>>       >>>>>>>>> The "cut here" portion of the kernel log is as follows
>>>       >>>>>>>>>
>>>       >>>>>>>>> ```
>>>       >>>>>>>>> [  409.158097] ------------[ cut here ]------------
>>>       >>>>>>>>> [  409.158205] WARNING: CPU: 1 PID: 217 at
>>>      fs/btrfs/disk-io.c:531
>>>       >>>>>>>>> btree_csum_one_bio+0x208/0x248 [btrfs]
>>>       >>>>>>>>
>>>       >>>>>>>> The line number shows, the tree bytenr doesn't match wi=
th
>>>      the one in memory.
>>>       >>>>>>>> This is really too rare to be seen, especially when we
>>>      have no other
>>>       >>>>>>>> error reported from btrfs (at least in the gist)
>>>       >>>>>>>>
>>>       >>>>>>>> Since there is no other problems showing up in the gist=
,
>>>      it means it
>>>       >>>>>>>> could be a bit flip, considering the magic generation g=
ap
>>>      you mention is
>>>       >>>>>>>> 15, I'm more suspicious about memory bit flip.
>>>       >>>>>>>>
>>>       >>>>>>>> If you can provide the full parent transid mismatch err=
or
>>>      message, it
>>>       >>>>>>>> may help to determine the possibility of hardware memor=
y
>>>      corruption.
>>>       >>>>>>>>
>>>       >>>>>>>> Thanks,
>>>       >>>>>>>> Qu
>>>       >>>>>>>>
>>>       >>>>>>>>> [  409.158208] Modules linked in: cfg80211 rfkill 8021=
q
>>>      ip6table_nat
>>>       >>>>>>>>> iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag=
_ipv6
>>>       >>>>>>>>> nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter ip6table_raw
>>>      iptable_raw
>>>       >>>>>>>>> xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LO=
G
>>>      xt_tcpudp
>>>       >>>>>>>>> ftdi_sio usbserial phy_generic uio_pdrv_genirq uio
>>>      ip6table_filter
>>>       >>>>>>>>> ip6_tables iptable_filter sch_fq_codel loop tun tap
>>>      macvlan bridge stp
>>>       >>>>>>>>> llc lm75 ip_tables x_tables autofs4 dm_mod dax btrfs
>>>      libcrc32c xor
>>>       >>>>>>>>> raid6_pq
>>>       >>>>>>>>> [  409.158258] CPU: 1 PID: 217 Comm: btrfs-transacti N=
ot
>>>      tainted 5.4.77 #1-NixOS
>>>       >>>>>>>>> [  409.158260] Hardware name: Marvell Armada 380/385
>>>      (Device Tree)
>>>       >>>>>>>>> [  409.158261] Backtrace:
>>>       >>>>>>>>> [  409.158272] [<c010f698>] (dump_backtrace) from
>>>      [<c010f938>]
>>>       >>>>>>>>> (show_stack+0x20/0x24)
>>>       >>>>>>>>> [  409.158277]  r7:00000213 r6:600f0013 r5:00000000
>>>      r4:c0f8c044
>>>       >>>>>>>>> [  409.158283] [<c010f918>] (show_stack) from [<c0a1b3=
88>]
>>>       >>>>>>>>> (dump_stack+0x98/0xac)
>>>       >>>>>>>>> [  409.158288] [<c0a1b2f0>] (dump_stack) from
>>>      [<c012a998>] (__warn+0xe0/0x108)
>>>       >>>>>>>>> [  409.158292]  r7:00000213 r6:bf058ec8 r5:00000009
>>>      r4:bf120990
>>>       >>>>>>>>> [  409.158296] [<c012a8b8>] (__warn) from [<c012ad24>]
>>>       >>>>>>>>> (warn_slowpath_fmt+0x74/0xc4)
>>>       >>>>>>>>> [  409.158300]  r7:00000213 r6:bf120990 r5:00000000
>>>      r4:e2392000
>>>       >>>>>>>>> [  409.158358] [<c012acb4>] (warn_slowpath_fmt) from
>>>      [<bf058ec8>]
>>>       >>>>>>>>> (btree_csum_one_bio+0x208/0x248 [btrfs])
>>>       >>>>>>>>> [  409.158363]  r9:e277abe0 r8:00000001 r7:e2392000
>>>      r6:ea3d17f0
>>>       >>>>>>>>> r5:00000000 r4:eefd2d3c
>>>       >>>>>>>>> [  409.158465] [<bf058cc0>] (btree_csum_one_bio [btrfs=
]) from
>>>       >>>>>>>>> [<bf059ef4>] (btree_submit_bio_hook+0xe8/0x100 [btrfs]=
)
>>>       >>>>>>>>> [  409.158470]  r10:e32ce170 r9:ecc45fc0 r8:ecc45f70
>>>      r7:ec82b000
>>>       >>>>>>>>> r6:00000000 r5:ea3d17f0
>>>       >>>>>>>>> [  409.158472]  r4:bf059e0c
>>>       >>>>>>>>> [  409.158575] [<bf059e0c>] (btree_submit_bio_hook
>>>      [btrfs]) from
>>>       >>>>>>>>> [<bf08b11c>] (submit_one_bio+0x44/0x5c [btrfs])
>>>       >>>>>>>>> [  409.158578]  r7:ef36c048 r6:e2393cac r5:00000000
>>>      r4:bf059e0c
>>>       >>>>>>>>> [  409.158683] [<bf08b0d8>] (submit_one_bio [btrfs]) f=
rom
>>>      [<bf0965d4>]
>>>       >>>>>>>>> (btree_write_cache_pages+0x380/0x408 [btrfs])
>>>       >>>>>>>>> [  409.158686]  r5:00000000 r4:00000000
>>>       >>>>>>>>> [  409.158788] [<bf096254>] (btree_write_cache_pages
>>>      [btrfs]) from
>>>       >>>>>>>>> [<bf059028>] (btree_writepages+0x7c/0x84 [btrfs])
>>>       >>>>>>>>> [  409.158793]  r10:00000001 r9:4fd00000 r8:c0280c94
>>>      r7:e2392000
>>>       >>>>>>>>> r6:e2393d80 r5:ecc45f70
>>>       >>>>>>>>> [  409.158794]  r4:e2393d80
>>>       >>>>>>>>> [  409.158850] [<bf058fac>] (btree_writepages [btrfs])=
 from
>>>       >>>>>>>>> [<c0284748>] (do_writepages+0x58/0xf4)
>>>       >>>>>>>>> [  409.158852]  r5:ecc45f70 r4:ecc45e68
>>>       >>>>>>>>> [  409.158860] [<c02846f0>] (do_writepages) from [<c02=
78c30>]
>>>       >>>>>>>>> (__filemap_fdatawrite_range+0xf8/0x130)
>>>       >>>>>>>>> [  409.158864]  r8:ecc45f70 r7:00001000 r6:4fd0bfff
>>>      r5:e2392000 r4:ecc45e68
>>>       >>>>>>>>> [  409.158869] [<c0278b38>] (__filemap_fdatawrite_rang=
e) from
>>>       >>>>>>>>> [<c0278db8>] (filemap_fdatawrite_range+0x2c/0x34)
>>>       >>>>>>>>> [  409.158874]  r10:ecc45f70 r9:00001000 r8:4fd0bfff
>>>      r7:e2393e4c
>>>       >>>>>>>>> r6:c73bc628 r5:00001000
>>>       >>>>>>>>> [  409.158875]  r4:4fd0bfff
>>>       >>>>>>>>> [  409.158929] [<c0278d8c>] (filemap_fdatawrite_range)=
 from
>>>       >>>>>>>>> [<bf0604b4>] (btrfs_write_marked_extents+0x9c/0x1b0 [b=
trfs])
>>>       >>>>>>>>> [  409.158931]  r5:00000001 r4:00000000
>>>       >>>>>>>>> [  409.159033] [<bf060418>] (btrfs_write_marked_extent=
s
>>>      [btrfs]) from
>>>       >>>>>>>>> [<bf060660>] (btrfs_write_and_wait_transaction+0x54/0x=
a4
>>>      [btrfs])
>>>       >>>>>>>>> [  409.159038]  r10:e2392000 r9:ec82b010 r8:ec82b000
>>>      r7:c73bc628
>>>       >>>>>>>>> r6:ec82b000 r5:e2392000
>>>       >>>>>>>>> [  409.159040]  r4:c8b81ca8
>>>       >>>>>>>>> [  409.159141] [<bf06060c>]
>>>      (btrfs_write_and_wait_transaction [btrfs])
>>>       >>>>>>>>> from [<bf062398>] (btrfs_commit_transaction+0x75c/0xc9=
4
>>>      [btrfs])
>>>       >>>>>>>>> [  409.159145]  r8:ec82b418 r7:c73bc600 r6:ec82b000
>>>      r5:c8b81ca8 r4:00000000
>>>       >>>>>>>>> [  409.159248] [<bf061c3c>] (btrfs_commit_transaction
>>>      [btrfs]) from
>>>       >>>>>>>>> [<bf05cd08>] (transaction_kthread+0x19c/0x1e0 [btrfs])
>>>       >>>>>>>>> [  409.159253]  r10:ec82b28c r9:00000000 r8:001aaafa
>>>      r7:00000064
>>>       >>>>>>>>> r6:ec82b414 r5:00000bb8
>>>       >>>>>>>>> [  409.159254]  r4:ec82b000
>>>       >>>>>>>>> [  409.159309] [<bf05cb6c>] (transaction_kthread [btrf=
s])
>>>      from
>>>       >>>>>>>>> [<c014fabc>] (kthread+0x170/0x174)
>>>       >>>>>>>>> [  409.159313]  r10:eca87bfc r9:bf05cb6c r8:ed619000
>>>      r7:e2392000
>>>       >>>>>>>>> r6:00000000 r5:ed5ee700
>>>       >>>>>>>>> [  409.159315]  r4:ed5ee1c0
>>>       >>>>>>>>> [  409.159320] [<c014f94c>] (kthread) from [<c01010e8>=
]
>>>       >>>>>>>>> (ret_from_fork+0x14/0x2c)
>>>       >>>>>>>>> [  409.159322] Exception stack(0xe2393fb0 to 0xe2393ff=
8)
>>>       >>>>>>>>> [  409.159326] 3fa0:
>>>        00000000
>>>       >>>>>>>>> 00000000 00000000 00000000
>>>       >>>>>>>>> [  409.159331] 3fc0: 00000000 00000000 00000000 000000=
00
>>>      00000000
>>>       >>>>>>>>> 00000000 00000000 00000000
>>>       >>>>>>>>> [  409.159334] 3fe0: 00000000 00000000 00000000 000000=
00
>>>      00000013 00000000
>>>       >>>>>>>>> [  409.159338]  r10:00000000 r9:00000000 r8:00000000
>>>      r7:00000000
>>>       >>>>>>>>> r6:00000000 r5:c014f94c
>>>       >>>>>>>>> [  409.159340]  r4:ed5ee700
>>>       >>>>>>>>> [  409.159342] ---[ end trace eea59ced12fa7859 ]---
>>>       >>>>>>>>> [  409.165084] BTRFS: error (device sda1) in
>>>       >>>>>>>>> btrfs_commit_transaction:2279: errno=3D-5 IO failure (=
Error
>>>      while
>>>       >>>>>>>>> writing out transaction)
>>>       >>>>>>>>> [  409.176920] BTRFS info (device sda1): forced readon=
ly
>>>       >>>>>>>>> [  409.176947] BTRFS warning (device sda1): Skipping
>>>      commit of aborted
>>>       >>>>>>>>> transaction.
>>>       >>>>>>>>> [  409.176952] BTRFS: error (device sda1) in
>>>      cleanup_transaction:1832:
>>>       >>>>>>>>> errno=3D-5 IO failure
>>>       >>>>>>>>> [  409.185049] BTRFS info (device sda1): delayed_refs =
has
>>>      NO entry
>>>       >>>>>>>>> [  409.310199] BTRFS info (device sda1): scrub: not
>>>      finished on devid
>>>       >>>>>>>>> 3 with status: -125
>>>       >>>>>>>>> [  409.664880] BTRFS info (device sda1): scrub: not
>>>      finished on devid
>>>       >>>>>>>>> 4 with status: -125
>>>       >>>>>>>>> [  410.106791] BTRFS info (device sda1): scrub: not
>>>      finished on devid
>>>       >>>>>>>>> 1 with status: -125
>>>       >>>>>>>>> [  411.268585] BTRFS warning (device sda1): failed
>>>      setting block group ro: -30
>>>       >>>>>>>>> [  411.268594] BTRFS info (device sda1): scrub: not
>>>      finished on devid
>>>       >>>>>>>>> 2 with status: -30
>>>       >>>>>>>>> [  411.268605] BTRFS info (device sda1): delayed_refs =
has
>>>      NO entry
>>>       >>>>>>>>> ```
>>>       >>>>>>>>>
>>>       >>>>>>>>> Information requested here
>>>       >>>>>>>>>
>>>      (https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list
>>>      <https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list>):
>>>       >>>>>>>>>
>>>       >>>>>>>>> ```
>>>       >>>>>>>>>    $ uname -a
>>>       >>>>>>>>> Linux thanos 5.4.77 #1-NixOS SMP Tue Nov 10 20:13:20 U=
TC
>>>      2020 armv7l GNU/Linux
>>>       >>>>>>>>>
>>>       >>>>>>>>>    $ btrfs --version
>>>       >>>>>>>>> btrfs-progs v5.7
>>>       >>>>>>>>>
>>>       >>>>>>>>>    $ sudo btrfs fi show
>>>       >>>>>>>>> Label: none  uuid: b8f4ad49-29c8-4d19-a886-cef9c487f12=
4
>>>       >>>>>>>>>           Total devices 4 FS bytes used 10.26TiB
>>>       >>>>>>>>>           devid    1 size 3.64TiB used 2.40TiB path /d=
ev/sda1
>>>       >>>>>>>>>           devid    2 size 3.64TiB used 2.40TiB path /d=
ev/sdc1
>>>       >>>>>>>>>           devid    3 size 9.09TiB used 7.86TiB path /d=
ev/sdd1
>>>       >>>>>>>>>           devid    4 size 9.09TiB used 7.86TiB path /d=
ev/sdb1
>>>       >>>>>>>>>
>>>       >>>>>>>>> Label: none  uuid: d02a3067-0a23-4c1f-96ac-80dbc26622f=
2
>>>       >>>>>>>>>           Total devices 1 FS bytes used 116.35MiB
>>>       >>>>>>>>>           devid    1 size 399.82MiB used 224.00MiB pat=
h
>>>      /dev/sda2
>>>       >>>>>>>>>
>>>       >>>>>>>>>    $ sudo btrfs fi df /
>>>       >>>>>>>>> Data, RAID1: total=3D10.25TiB, used=3D10.24TiB
>>>       >>>>>>>>> System, RAID1: total=3D64.00MiB, used=3D1.45MiB
>>>       >>>>>>>>> Metadata, RAID1: total=3D18.00GiB, used=3D17.19GiB
>>>       >>>>>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>       >>>>>>>>> ```
>>>       >>>>>>>>>
>>>       >>>>>>>>> Thanks to demfloro and multicore on #btrfs for prompti=
ng
>>>      this email.
>>>       >>>>>>>>>
>>>       >>>>>>>>> Best wishes,
>>>       >>>>>>>>> Joe
>>>       >>>>>>>>>
>>>       >>>>>>>>
>>>       >>>>
>>>
