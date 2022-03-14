Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4A4D7953
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 03:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiCNC0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 22:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiCNC0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 22:26:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D312AB7;
        Sun, 13 Mar 2022 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647224678;
        bh=nopgT3p8IOJtrDpFDOTpe30oEPdd9mlDmFB4Ng7SBAo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Dd8egrGT3d4WBVGcM2FH1G2Z+DVXBr0o00lKmSoXBefXBBPgfdWypVbcNJtnRHo6j
         JRgrvXVdhJwgMCPCyQ6J6/mhDJDW9jWKHqhi/3AsQs0eQi40qopv3IJdjw7EwSDc6d
         QJW+7fSrTT68e3X1TnbvERE9dSoc/RcrJEMv6fUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1nLsDJ1ntk-00GXVM; Mon, 14
 Mar 2022 03:24:38 +0100
Message-ID: <eb6f9763-5bc1-5ac0-0b82-0ee7994e85c6@gmx.com>
Date:   Mon, 14 Mar 2022 10:24:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, linux-btrfs@vger.kernel.org
References: <20220301063026.GB13547@xsang-OptiPlex-9020>
 <e55fb58e-bb3a-ce51-b485-6302415b34e4@gmx.com>
 <20220302084435.GA28137@xsang-OptiPlex-9020>
 <dbc84dd2-7e6d-95b0-d7bc-373f897a7063@gmx.com>
 <20220309074954.GB22223@xsang-OptiPlex-9020>
 <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
 <20220314020549.GA24245@xsang-OptiPlex-9020>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [btrfs] 3626a285f8: divide_error:#[##]
In-Reply-To: <20220314020549.GA24245@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wrl5pVXOBVTtH8HU+zOmEi5s/5TLXkJQMcDLgNnC3SmZVBaXQaL
 OqumTOaWfcUM5LLMNN5UzYNtqxqXnrqaDKjn2CTG2hxAHKzCXDo44SzQWrV5ls9h1DJUOP1
 QA9XTx/ptCsEEHIYPoefPXD0qenof9i/DibsZhDMyBpHBzKE7UFT4HAd+eNKVHvHIHxoxMV
 lpVYPfXNjUEzueTSBwsPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qWtPymLP9Vs=:fj1qLNi1x5dZi+gN9eEAAQ
 WpmNWbp+lK15lozPBeh6ELXewbrpK1fJSBpvCPnJbCLIq4hV7i9vHLeIdYHvCUCStZrZfM2K1
 fd0tSRtMt4X99vREXmN1lk9dPfhTitWxp4p4yMLg6RAtylULTXdCCcs0RzWGxukyKU/zyI9b2
 /awdE3zJthOLss8Rq8RXHkX/4P/ivkXhmf6aSPqJyXK2QBCd+EtWkn73o0n9EMfyic1NPzE5N
 NHRiXh7tAhCN1Y/DmJPMaMCu00+fVKl8pq2p6Y85d/Qkl1L7z95CKDqwWcdPmOek+54fEa0WA
 KXKVfb5AlK9o9dXVqmqO/DHRg2w2L9K0wc3umWk8+RJrpXXJAj+u7Scufk0ca2BqoAJ3doaFe
 ZCY3+Ltm+cGTi8BH3gpKnxO5RfOIYlfqf7r+yZREaCbrVTtZhr9N6fdLEkQTPpH/MtvOcCNYH
 WUkdRlsOFZdzE2meX9m6qMB10Ebl8rmI8A7vWPqskOmdA/GiJ4kUyZ6BbQ+GJQ6uEghESAuMO
 NdhDOhynqahfxlVydMI24sy1tGkzqpBVGCAfNGQ+/5J6UJ6noJuM4cbExTSZu8JD1tQ7SKZ5c
 dIDdr345BAwtgNuWBSRmU3pnLRM4KyUTI1CWTgbwCY8hAPYJr/2BDHgnimPpdWyzlFfStK8r/
 uoj2bQLqevXX4wM5k+pVIsZAaZVCgwYTiIb2qpTIaRtn2DXKmtNHLDGlcZ5yx8GDmoyGNXJi7
 b72LOI8+sZDhBCDucbP/1QDZpCGQl6uqh3kfSkH1NcVgY8/yGgdeFiPtmhF2bchxTdNjUwHUm
 XQt+w6jCtjImwOQNGMmTYGBddQh1DQYGjkEhCP9qFTF//6NEBfa3D1gXZZ1Hnc/GwZ8DbRuAz
 raVYvDCP5hE+pWO7z1RtzAUBJ4ZqIPiWhtlXwishtVP5aH/hjT4eqC2A/XP7/GiCZLyjzzPlR
 acWKJrggHT5gQ5VmFmIbGmEEyWVepLk5nfQiRP9ivAaMzsmJDXdI7gAIj2rKOt4De/NCYiTjU
 1z6spR7q9IYbh+Kx15nRHEStLnNLfnd+WHVWRiVsGRybxtgIpXFsgnOcswd1vwOkkqSxp+sS0
 adOqhgzIh2ml0Y=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/14 10:05, Oliver Sang wrote:
> Hi Qu,
>
> On Wed, Mar 09, 2022 at 04:42:41PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/9 15:49, Oliver Sang wrote:
>>> Hi Qu,
>>>
>>> On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/3/2 16:44, Oliver Sang wrote:
>>>>> Hi Qu,
>>>>>
>>>>> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> This is weird, the code is from simple_stripe_full_stripe_len(), wh=
ich
>>>>>> means the chunk map must be RAID0 or RAID10.
>>>>>>
>>>>>> In that case, their sub_stripes should be either 1 or 2, why we got=
 0 there?
>>>>>>
>>>>>> In fact, from volumes.c, all sub_stripes is from btrfs_raid_array[]=
,
>>>>>> which all have either 1 or 2 sub_stripes.
>>>>>>
>>>>>>
>>>>>> Although the code is old, not the latest version, it should still n=
ot
>>>>>> cause such problem.
>>>>>>
>>>>>> Mind to retest with my branch to see if it can be reproduced?
>>>>>> https://github.com/adam900710/linux/tree/refactor_scrub
>>>>>
>>>>> we tested head of this branch:
>>>>>      d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and relate=
d members
>>>>> and:
>>>>>      fdad4a9615f180 btrfs: introduce dedicated helper to scrub simpl=
e-stripe based range
>>>>> on this branch.
>>>>>
>>>>> by attached config.
>>>>>
>>>>> still reproduce the same issue.
>>>>>
>>>>> attached dmesgs FYI.
>>>>
>>>> Still failed to reproduce here.
>>>>
>>>> Those btrfs/07[0123] tests are already in scrub/replace group, thus I
>>>> ran them almost hourly during the development.
>>>>
>>>>
>>>> Although there are some ASSERT()s doing extra sanity checks, they sho=
uld
>>>> not affect the result anyway.
>>>>
>>>> Thus I pushed a branch with more explicit BUG_ON()s to catch the
>>>> possible divide by zero bugs.
>>>> (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
>>>>
>>>> Mind to give it a try?
>>>
>>>
>>> in our tests, it seems one BUG_ON you added is triggered
>>> (full dmesg attached):
>>
>> What the heck...
>>
>> It's indeed some weird extent mapping has its sub-stripes as 0...
>>
>> I must be insane or there is something fundamental wrong.
>>
>> Mind to try that branch again? I have updated the branch, now it will
>> trigger BUG_ON() as soon as it finds a chunk mapping with sub_stripes =
=3D=3D 0.
>>
>> I'm wondering if it's old btrfs-progs involved (which may not properly
>> initialize btrfs_chunk::sub_stripes) now.
>
> below BUG print was caught by your new patch (detail dmesg attached):

Thank you very much for the detailed report!

The triggered BUG_ON() means, we're getting sub_stripes =3D=3D 0, for
unrelated chunks (in this case, it's DUP from sys chunk array, from the
full dmesg).

And from the code context, it's from super-block, thus there must be
something wrong with the mkfs.btrfs.

But unfortunately, I re-compiled my btrfs-progs v5.15.1, retried, and
still no reproduce.

Mind to share the result of "btrfs ins dump-tree -t chunk /dev/sdb2" and
"btrfs ins dump-super -f /dev/sdb2" just after the mkfs.btrfs call of it?

As the BUG_ON() mostly means, the result from mkfs.btrfs is not correct.

Thanks,
Qu
>
> [   44.577527][ T1980] ------------[ cut here ]------------
> [   44.583552][  T335]
> [   44.583990][  T337] 512+0 records out
> [   44.583997][  T337]
> [   44.593932][ T1980] kernel BUG at fs/btrfs/volumes.c:7157!
> [   44.593940][ T1980] invalid opcode: 0000 [#1] SMP KASAN PTI
> [   44.598832][  T335]   Data:             single            8.00MiB
> [   44.603293][ T1980] CPU: 5 PID: 1980 Comm: mount Not tainted 5.17.0-r=
c4-00095-g7f159e82828e #1
> [   44.603297][ T1980] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BI=
OS A05 12/05/2013
> [   44.603299][ T1980] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
> [   44.605509][  T335]
> [   44.609168][ T1980] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 3=
8 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85 19 =
fb ff ff <0f> 0b 4c
> 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
> [   44.609171][ T1980] RSP: 0018:ffffc90002be76c8 EFLAGS: 00010246
> [   44.609175][ T1980] RAX: ffff888102c98e00 RBX: 0000000000000000 RCX: =
0000000000000000
> [   44.609178][ T1980] RDX: 0000000000000000 RSI: 0000000000000008 RDI: =
fffff5200057ce75
> [   44.612227][  T335]   Metadata:         DUP               1.00GiB
> [   44.616871][ T1980] RBP: 000000000000033c R08: 000000000000005e R09: =
ffffed1034dd6791
> [   44.616873][ T1980] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 R12: =
ffff888214586b40
> [   44.616874][ T1980] R13: ffff888102c98e18 R14: ffff888102c98e1c R15: =
0000000000000022
> [   44.616876][ T1980] FS:  00007fad1bd12100(0000) GS:ffff8881a6e80000(0=
000) knlGS:0000000000000000
> [   44.622475][  T335]
> [   44.628578][ T1980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.628580][ T1980] CR2: 00007fff9d90df68 CR3: 00000001407fc003 CR4: =
00000000001706e0
> [   44.628583][ T1980] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [   44.628585][ T1980] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [   44.628588][ T1980] Call Trace:
> [   44.638095][  T335]   System:           DUP               8.00MiB
> [   44.645166][ T1980]  <TASK>
> [   44.645168][ T1980]  ? _raw_spin_lock+0x81/0x100
> [   44.651206][  T335]
> [   44.653388][ T1980]  ? _raw_spin_lock_bh+0x100/0x100
> [   44.653395][ T1980]  ? __raw_callee_save___native_queued_spin_unlock+=
0x11/0x1e
> [   44.673370][  T335] SSD detected:       no
> [   44.678876][ T1980]  ? add_missing_dev+0x3c0/0x3c0 [btrfs]
> [   44.686756][  T335]
> [   44.694598][ T1980]  ? btrfs_get_token_64+0x700/0x700 [btrfs]
> [   44.701187][  T335] Zoned device:       no
> [   44.708574][ T1980]  ? memcpy+0x39/0x80
> [   44.708581][ T1980]  ? write_extent_buffer+0x192/0x240 [btrfs]
> [   44.716449][  T335]
> [   44.724294][ T1980]  btrfs_read_sys_array+0x2c7/0x380 [btrfs]
> [   44.734138][  T335] Incompat features:  extref, skinny-metadata, no-h=
oles
> [   44.735313][ T1980]  ? read_one_dev+0x13c0/0x13c0 [btrfs]
> [   44.741786][  T335]
> [   44.749628][ T1980]  ? mutex_lock+0x80/0x100
> [   44.749634][ T1980]  ? __mutex_lock_slowpath+0x40/0x40
> [   44.758164][  T335] Runtime features:   free-space-tree
> [   44.765352][ T1980]  ? btrfs_init_workqueues+0x4c1/0x7ba [btrfs]
> [   44.768515][  T335]
> [   44.774620][ T1980]  open_ctree+0x16ac/0x2656 [btrfs]
> [   44.777966][  T335] Checksum:           crc32c
> [   44.782064][ T1980]  btrfs_mount_root.cold+0x13/0x192 [btrfs]
> [   44.784268][  T335]
> [   44.789241][ T1980]  ? arch_stack_walk+0x9e/0x100
> [   44.789247][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
> [   44.796977][  T335] Number of devices:  1
> [   44.800614][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
> [   44.806131][  T335]
> [   44.808314][ T1980]  ? legacy_parse_param+0x6a/0x7c0
> [   44.808320][ T1980]  ? parse_rescue_options+0x300/0x300 [btrfs]
> [   44.814273][  T335] Devices:
> [   44.818205][ T1980]  legacy_get_tree+0xef/0x200
> [   44.818210][ T1980]  vfs_get_tree+0x84/0x2c0
> [   44.822077][  T335]
> [   44.827928][ T1980]  fc_mount+0xf/0x80
> [   44.827934][ T1980]  vfs_kern_mount+0x71/0xc0
> [   44.830557][  T335]    ID        SIZE  PATH
> [   44.835890][ T1980]  btrfs_mount+0x1fc/0xa40 [btrfs]
> [   44.842730][  T335]
> [   44.848134][ T1980]  ? kasan_save_stack+0x1e/0x40
> [   44.848149][ T1980]  ? kasan_set_track+0x21/0x40
> [   44.850862][  T335]     1   300.00GiB  /dev/sdb4
> [   44.854618][ T1980]  ? kasan_set_free_info+0x20/0x40
> [   44.854624][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
> [   44.859803][  T335]
> [   44.865032][ T1980]  ? __x64_sys_mount+0x12c/0x1c0
> [   44.865036][ T1980]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   44.871101][  T335]
> [   44.873263][ T1980]  ? terminate_walk+0x203/0x4c0
> [   44.873268][ T1980]  ? vfs_parse_fs_param_source+0x3b/0x1c0
> [   44.878354][  T335]
> [   44.882803][ T1980]  ? legacy_parse_param+0x6a/0x7c0
> [   44.882808][ T1980]  ? vfs_parse_fs_string+0xd7/0x140
> [   44.889280][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb1
> [   44.890770][ T1980]  ? btrfs_show_options+0xf00/0xf00 [btrfs]
> [   44.895501][  T335]
> [   44.901430][ T1980]  ? legacy_get_tree+0xef/0x200
> [   44.901435][ T1980]  legacy_get_tree+0xef/0x200
> [   44.901448][ T1980]  ? security_capable+0x56/0xc0
> [   44.905612][  T335]  btrfs
> [   44.911057][ T1980]  vfs_get_tree+0x84/0x2c0
> [   44.911062][ T1980]  ? ns_capable_common+0x57/0x100
> [   44.913278][  T335]
> [   44.918247][ T1980]  path_mount+0x7fc/0x1a40
> [   44.918252][ T1980]  ? kasan_set_track+0x21/0x40
> [   44.925201][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb1 /fs/=
sdb1
> [   44.927087][ T1980]  ? finish_automount+0x600/0x600
> [   44.927092][ T1980]  ? kmem_cache_free+0xa1/0x400
> [   44.931642][  T335]
> [   44.935926][ T1980]  do_mount+0xca/0x100
> [   44.935931][ T1980]  ? path_mount+0x1a40/0x1a40
> [   44.935933][ T1980]  ? _copy_from_user+0x94/0x100
> [   44.938799][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb2
> [   44.941885][ T1980]  ? memdup_user+0x4e/0x80
> [   44.941890][ T1980]  __x64_sys_mount+0x12c/0x1c0
> [   44.941893][ T1980]  do_syscall_64+0x3b/0xc0
> [   44.946884][  T335]
> [   44.951068][ T1980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   44.951074][ T1980] RIP: 0033:0x7fad1bf10fea
> [   44.951077][ T1980] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 =
00 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
> [   44.956197][  T335]  btrfs
> [   44.958245][ T1980] RSP: 002b:00007fff9d90f878 EFLAGS: 00000246 ORIG_=
RAX: 00000000000000a5
> [   44.958249][ T1980] RAX: ffffffffffffffda RBX: 00005628efc57970 RCX: =
00007fad1bf10fea
> [   44.958251][ T1980] RDX: 00005628efc57b80 RSI: 00005628efc57bc0 RDI: =
00005628efc57ba0
> [   44.958263][ T1980] RBP: 00007fad1c25e1c4 R08: 0000000000000000 R09: =
00005628efc5a890
> [   44.958264][ T1980] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000000
> [   44.962993][  T335]
> [   44.967613][ T1980] R13: 0000000000000000 R14: 00005628efc57ba0 R15: =
00005628efc57b80
> [   44.967616][ T1980]  </TASK>
> [   44.967617][ T1980] Modules linked in: dm_mod btrfs blake2b_generic x=
or raid6_pq
> [   44.973257][  T335] 2022-03-14 01:34:21 mount -t btrfs /dev/sdb2 /fs/=
sdb2
> [   44.977243][ T1980]  zstd_compress libcrc32c sd_mod t10_pi sg
> [   44.983019][  T335]
> [   44.985203][ T1980]  ipmi_devintf ata_generic ipmi_msghandler intel_r=
apl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp k=
vm_intel
> [   44.990720][  T335] 2022-03-14 01:34:21 mkdir -p /fs/sdb3
> [   44.995962][ T1980]  i915 kvm intel_gtt ttm drm_kms_helper irqbypass =
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel syscopyarea=
 sysfillrect
> [   44.998174][  T335]
> [   45.002882][ T1980]  sysimgblt rapl mei_wdt fb_sys_fops ata_piix inte=
l_cstate libata drm mei_me mei intel_uncore video ip_tables
> [   45.002919][ T1980] ---[ end trace 0000000000000000 ]---
>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> [   75.279958][ T3602] ------------[ cut here ]------------
>>> [   75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387!
>>> [   75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN PTI
>>> [   75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not tainted 5.17.0=
-rc4-00095-g6b837d4c40d5 #1
>>> [   75.304521][ T3602] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, =
BIOS A05 12/05/2013
>>> [   75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340 [btrfs]
>>> [   75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9 98 f3 ff ff=
 e8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8 96 c0 e9 3=
b f4 ff ff <0f> 0b 0f
>>> 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
>>> [   75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: 00010246
>>> [   75.343340][ T3602] RAX: 0000000000000007 RBX: ffff88810231d600 RCX=
: ffff88810231d61c
>>> [   75.351074][ T3602] RDX: 0000000000000000 RSI: 0000000000000004 RDI=
: ffff8881023a2458
>>> [   75.358807][ T3602] RBP: ffff8881097ad800 R08: 0000000000000001 R09=
: ffffed102828100d
>>> [   75.366550][ T3602] R10: ffff888141408063 R11: ffffed102828100c R12=
: 0000000000000000
>>> [   75.374282][ T3602] R13: 0000000000100000 R14: ffff888141408000 R15=
: ffff888129c9c000
>>> [   75.382016][ T3602] FS:  00007f94c24ec8c0(0000) GS:ffff8881a6d00000=
(0000) knlGS:0000000000000000
>>> [   75.390691][ T3602] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
>>> [   75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 000000020a796004 CR4=
: 00000000001706e0
>>> [   75.404785][ T3602] Call Trace:
>>> [   75.407886][ T3602]  <TASK>
>>> [   75.410645][ T3602]  ? btrfs_wait_ordered_extents+0x9a1/0xe40 [btrf=
s]
>>> [   75.417049][ T3602]  ? scrub_raid56_parity+0x5c0/0x5c0 [btrfs]
>>> [   75.422853][ T3602]  ? btrfs_remove_ordered_extent+0xbc0/0xbc0 [btr=
fs]
>>> [   75.429341][ T3602]  ? mutex_unlock+0x80/0x100
>>> [   75.433733][ T3602]  ? __wake_up_common_lock+0xe3/0x140
>>> [   75.438897][ T3602]  ? __lookup_extent_mapping+0x215/0x300 [btrfs]
>>> [   75.445037][ T3602]  scrub_chunk+0x294/0x480 [btrfs]
>>> [   75.449984][ T3602]  scrub_enumerate_chunks+0x643/0x1340 [btrfs]
>>> [   75.455962][ T3602]  ? scrub_chunk+0x480/0x480 [btrfs]
>>> [   75.461083][ T3602]  ? __scrub_blocked_if_needed+0xb9/0x200 [btrfs]
>>> [   75.467317][ T3602]  ? scrub_checksum_data+0x4c0/0x4c0 [btrfs]
>>> [   75.473121][ T3602]  ? down_read+0x137/0x240
>>> [   75.477339][ T3602]  ? mutex_unlock+0x80/0x100
>>> [   75.481726][ T3602]  ? __mutex_unlock_slowpath+0x300/0x300
>>> [   75.487743][ T3602]  ? btrfs_find_device+0xac/0x240 [btrfs]
>>> [   75.493285][ T3602]  btrfs_scrub_dev+0x535/0xc00 [btrfs]
>>> [   75.498578][ T3602]  ? scrub_enumerate_chunks+0x1340/0x1340 [btrfs]
>>> [   75.504812][ T3602]  ? btrfs_apply_pending_changes+0x80/0x80 [btrfs=
]
>>> [   75.511120][ T3602]  ? btrfs_record_root_in_trans+0x4d/0x180 [btrfs=
]
>>> [   75.517428][ T3602]  ? finish_wait+0x280/0x280
>>> [   75.521819][ T3602]  btrfs_dev_replace_by_ioctl.cold+0x62c/0x720 [b=
trfs]
>>> [   75.528483][ T3602]  ? btrfs_finish_block_group_to_copy+0x3c0/0x3c0=
 [btrfs]
>>> [   75.535440][ T3602]  ? __raw_callee_save___native_queued_spin_unloc=
k+0x11/0x1e
>>> [   75.542575][ T3602]  btrfs_ioctl+0x37ee/0x51c0 [btrfs]
>>> [   75.547691][ T3602]  ? fput_many+0xaa/0x140
>>> [   75.551823][ T3602]  ? filp_close+0xef/0x140
>>> [   75.556041][ T3602]  ? __x64_sys_close+0x2d/0x80
>>> [   75.560600][ T3602]  ? do_syscall_64+0x3b/0xc0
>>> [   75.564991][ T3602]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [   75.570838][ T3602]  ? btrfs_ioctl_get_supported_features+0x40/0x40=
 [btrfs]
>>> [   75.577756][ T3602]  ? _raw_spin_lock_irq+0x82/0xd2
>>> [   75.582572][ T3602]  ? _raw_spin_lock+0x100/0x100
>>> [   75.587218][ T3602]  ? fiemap_prep+0x200/0x200
>>> [   75.591607][ T3602]  ? lockref_put_or_lock+0xc4/0x1c0
>>> [   75.596600][ T3602]  ? do_sigaction+0x4b3/0x840
>>> [   75.601075][ T3602]  ? __x64_sys_pidfd_send_signal+0x600/0x600
>>> [   75.606837][ T3602]  ? __might_fault+0x4d/0x80
>>> [   75.611226][ T3602]  ? __x64_sys_rt_sigaction+0x1d0/0x240
>>> [   75.616558][ T3602]  ? __ia32_sys_signal+0x140/0x140
>>> [   75.621461][ T3602]  ? __fget_light+0x57/0x540
>>> [   75.625854][ T3602]  __x64_sys_ioctl+0x127/0x1c0
>>> [   75.630414][ T3602]  do_syscall_64+0x3b/0xc0
>>> [   75.634633][ T3602]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [   75.640307][ T3602] RIP: 0033:0x7f94c25df427
>>> [   75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26=
 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 0=
0 00 0f 05 <48> 3d 01
>>> f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
>>> [   75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: 00000246 ORI=
G_RAX: 0000000000000010
>>> [   75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d51e9f72a0 RCX=
: 00007f94c25df427
>>> [   75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000ca289435 RDI=
: 0000000000000004
>>> [   75.687404][ T3602] RBP: 00000000ffffffff R08: 0000000000000000 R09=
: 000055d51e9fa580
>>> [   75.695137][ T3602] R10: 0000000000000008 R11: 0000000000000246 R12=
: 00007ffd06a4e97a
>>> [   75.702868][ T3602] R13: 0000000000000004 R14: 0000000000000000 R15=
: 0000000000000005
>>> [   75.710600][ T3602]  </TASK>
>>> [   75.713445][ T3602] Modules linked in: dm_mod btrfs blake2b_generic=
 xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ata_generic ipmi_de=
vintf ipmi_msghandler
>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp=
 coretemp i915 kvm_intel kvm intel_gtt ttm irqbypass crct10dif_pclmul crc3=
2_pclmul crc32c_intel
>>> ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect sysimgblt f=
b_sys_fops rapl ata_piix mei_wdt intel_cstate drm libata mei_me intel_unco=
re mei video ip_tables
>>> [   75.756460][ T3602] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
