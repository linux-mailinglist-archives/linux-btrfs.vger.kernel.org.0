Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFC4D2AC5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiCIIoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCIIoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:44:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0A98F70;
        Wed,  9 Mar 2022 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646815367;
        bh=k++kNOC2p1Cen2Bd+AWd1weeoH/sDqAVAD9mLuMJjgE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=HSKTAAcgngGBvxOO4Q5P632aMxaLBzz5a6G5PDOAvEoIPB6xmzMrRsQohr5pCkhJt
         WhvXUCKR/DaCsCANemg+AilBJ3Rtg5L/79QkhKOXoAf+dJiIvYeS5ONBGq1GGLI7zF
         wB05VopghE5SI22zOlsrxGljcKSlAdfs5VVUJ/U8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1npkRt2xtf-00O1Jl; Wed, 09
 Mar 2022 09:42:47 +0100
Message-ID: <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
Date:   Wed, 9 Mar 2022 16:42:41 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [btrfs] 3626a285f8: divide_error:#[##]
In-Reply-To: <20220309074954.GB22223@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t36bkf+wkjtCr9Lrc2hb5TIOui5AusuXuXA4D1VDl/3GBs5Jh6m
 xHxzNZ5BmyEY4CXqxZoL7+KR65w00PDyBXIoRph9TedRCLKXpKtdqbGd89ZMpkdfPcOm53X
 qDsHbTFdM0YsrzWbyXlkoohBe3p3UQKwChB7N88LhFHZc8PR9mb3Kk/30av5fAXngAyfbC1
 RtHXQvoapzml+zvqDk8GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4rdgA6dCX44=:WyexwiPI+otK5gsPu9v+2W
 eGVuzEryCUeWQ9jo5iteHmcfUtWvBIlrEOkTLYz3AuL7PUc3NqAeZHNK5kscRvFtsV6FMw9+O
 uox4Q7xDkyAO4BHc2pfzcaHQ/94lBpydCc45NL8+yZNlM+JUaeUvI7zHS1+xzQM6gxGXsvGrT
 uc7bBFjWEdeU0+IHqjpfCOi9A3PB81IqnfRFM50RCZ+CVWWKJ7QE9T/thCrLYuhfz+P8/Zlkt
 K2UhUlIgf/Rv1+w2vvsHF4bAE9qw3WvKvK1ThqKK/dtSTnCu4dV1SMg+5TQ5l/5Zo8aAS5G6x
 fpV153vzvS7ri9Xnax9MTWiN6E2cnNtUisCpoEo9d1txZADHEfA2TGiiA3ab/0iGaheqmed2M
 8RKQaXnY69VpWRorKqr0RV5SadBNjXosPyfvCD00CVYLLLrZWWwNjTOUCU/tFbvmoXmCeZWm0
 KrqythpSp/6V6/CuT05vh4zK8XG5oOEz6g1HklNMOy5Di1M7IO+krkxF3cz3H26Wy6A5ORFgw
 sNR+UcmSwG0IO5GT9/uacTLc1b6KwTrTSqUKz6XzrFVI8g0DwNIxV2PqN0Irm/q8OO6Q6FFGI
 SN/f5OTXcCFf2XqoDUPZA08WxAV+jpWVQahgiJ/Fe1ZDKWSITO59WQrA11SO8hIWUX3rnUv7r
 477Vzip4VRvWFyVcDJUqO4g1/BOtZTpaTglJPMIJ4RerKTwWL1v5rEDRfXh9ftvwIQEbicccd
 KCl9wbt7tOiA48comMcjQFEM/C9hP4U2etsSY+lIX01861nSVstmkINkuzzRB+lNaITUGqWn4
 Gzq69+K6D088JUYll69tZWTKm8RfXHZX1AyjFqoQxgyT7RZjtAspGO2sgpAEE2+OW21Drk2xO
 4M+211h7hbwByT135/Bn49lWNW8UnUk0HVYzAdoqT0i4YgfGkk34hKBTTNBla8ZI2Pj1W/Zzu
 VRGy8gbA5xiVbbJt3VgTL61/jrVBljpNgV6DcWpLCSZBg67XPhEgFl0ozKHn1WLMpPcrMl7fu
 JYEJRxukmeNJom8c+/FGVFZEvS4KBgVjG2+fzQu71g4Fli/RL8jkOr2fnxFYsbYB0ktpNzkCy
 6mlZQ9LbeAOtJs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 15:49, Oliver Sang wrote:
> Hi Qu,
>
> On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/2 16:44, Oliver Sang wrote:
>>> Hi Qu,
>>>
>>> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> This is weird, the code is from simple_stripe_full_stripe_len(), whic=
h
>>>> means the chunk map must be RAID0 or RAID10.
>>>>
>>>> In that case, their sub_stripes should be either 1 or 2, why we got 0=
 there?
>>>>
>>>> In fact, from volumes.c, all sub_stripes is from btrfs_raid_array[],
>>>> which all have either 1 or 2 sub_stripes.
>>>>
>>>>
>>>> Although the code is old, not the latest version, it should still not
>>>> cause such problem.
>>>>
>>>> Mind to retest with my branch to see if it can be reproduced?
>>>> https://github.com/adam900710/linux/tree/refactor_scrub
>>>
>>> we tested head of this branch:
>>>     d6e3a8c42f2fad btrfs: scrub: rename scrub_bio::pagev and related m=
embers
>>> and:
>>>     fdad4a9615f180 btrfs: introduce dedicated helper to scrub simple-s=
tripe based range
>>> on this branch.
>>>
>>> by attached config.
>>>
>>> still reproduce the same issue.
>>>
>>> attached dmesgs FYI.
>>
>> Still failed to reproduce here.
>>
>> Those btrfs/07[0123] tests are already in scrub/replace group, thus I
>> ran them almost hourly during the development.
>>
>>
>> Although there are some ASSERT()s doing extra sanity checks, they shoul=
d
>> not affect the result anyway.
>>
>> Thus I pushed a branch with more explicit BUG_ON()s to catch the
>> possible divide by zero bugs.
>> (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
>>
>> Mind to give it a try?
>
>
> in our tests, it seems one BUG_ON you added is triggered
> (full dmesg attached):

What the heck...

It's indeed some weird extent mapping has its sub-stripes as 0...

I must be insane or there is something fundamental wrong.

Mind to try that branch again? I have updated the branch, now it will
trigger BUG_ON() as soon as it finds a chunk mapping with sub_stripes =3D=
=3D 0.

I'm wondering if it's old btrfs-progs involved (which may not properly
initialize btrfs_chunk::sub_stripes) now.

Thanks,
Qu

>
>
> [   75.279958][ T3602] ------------[ cut here ]------------
> [   75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387!
> [   75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN PTI
> [   75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not tainted 5.17.0-r=
c4-00095-g6b837d4c40d5 #1
> [   75.304521][ T3602] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BI=
OS A05 12/05/2013
> [   75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340 [btrfs]
> [   75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9 98 f3 ff ff e=
8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8 96 c0 e9 3b =
f4 ff ff <0f> 0b 0f
> 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
> [   75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: 00010246
> [   75.343340][ T3602] RAX: 0000000000000007 RBX: ffff88810231d600 RCX: =
ffff88810231d61c
> [   75.351074][ T3602] RDX: 0000000000000000 RSI: 0000000000000004 RDI: =
ffff8881023a2458
> [   75.358807][ T3602] RBP: ffff8881097ad800 R08: 0000000000000001 R09: =
ffffed102828100d
> [   75.366550][ T3602] R10: ffff888141408063 R11: ffffed102828100c R12: =
0000000000000000
> [   75.374282][ T3602] R13: 0000000000100000 R14: ffff888141408000 R15: =
ffff888129c9c000
> [   75.382016][ T3602] FS:  00007f94c24ec8c0(0000) GS:ffff8881a6d00000(0=
000) knlGS:0000000000000000
> [   75.390691][ T3602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 000000020a796004 CR4: =
00000000001706e0
> [   75.404785][ T3602] Call Trace:
> [   75.407886][ T3602]  <TASK>
> [   75.410645][ T3602]  ? btrfs_wait_ordered_extents+0x9a1/0xe40 [btrfs]
> [   75.417049][ T3602]  ? scrub_raid56_parity+0x5c0/0x5c0 [btrfs]
> [   75.422853][ T3602]  ? btrfs_remove_ordered_extent+0xbc0/0xbc0 [btrfs=
]
> [   75.429341][ T3602]  ? mutex_unlock+0x80/0x100
> [   75.433733][ T3602]  ? __wake_up_common_lock+0xe3/0x140
> [   75.438897][ T3602]  ? __lookup_extent_mapping+0x215/0x300 [btrfs]
> [   75.445037][ T3602]  scrub_chunk+0x294/0x480 [btrfs]
> [   75.449984][ T3602]  scrub_enumerate_chunks+0x643/0x1340 [btrfs]
> [   75.455962][ T3602]  ? scrub_chunk+0x480/0x480 [btrfs]
> [   75.461083][ T3602]  ? __scrub_blocked_if_needed+0xb9/0x200 [btrfs]
> [   75.467317][ T3602]  ? scrub_checksum_data+0x4c0/0x4c0 [btrfs]
> [   75.473121][ T3602]  ? down_read+0x137/0x240
> [   75.477339][ T3602]  ? mutex_unlock+0x80/0x100
> [   75.481726][ T3602]  ? __mutex_unlock_slowpath+0x300/0x300
> [   75.487743][ T3602]  ? btrfs_find_device+0xac/0x240 [btrfs]
> [   75.493285][ T3602]  btrfs_scrub_dev+0x535/0xc00 [btrfs]
> [   75.498578][ T3602]  ? scrub_enumerate_chunks+0x1340/0x1340 [btrfs]
> [   75.504812][ T3602]  ? btrfs_apply_pending_changes+0x80/0x80 [btrfs]
> [   75.511120][ T3602]  ? btrfs_record_root_in_trans+0x4d/0x180 [btrfs]
> [   75.517428][ T3602]  ? finish_wait+0x280/0x280
> [   75.521819][ T3602]  btrfs_dev_replace_by_ioctl.cold+0x62c/0x720 [btr=
fs]
> [   75.528483][ T3602]  ? btrfs_finish_block_group_to_copy+0x3c0/0x3c0 [=
btrfs]
> [   75.535440][ T3602]  ? __raw_callee_save___native_queued_spin_unlock+=
0x11/0x1e
> [   75.542575][ T3602]  btrfs_ioctl+0x37ee/0x51c0 [btrfs]
> [   75.547691][ T3602]  ? fput_many+0xaa/0x140
> [   75.551823][ T3602]  ? filp_close+0xef/0x140
> [   75.556041][ T3602]  ? __x64_sys_close+0x2d/0x80
> [   75.560600][ T3602]  ? do_syscall_64+0x3b/0xc0
> [   75.564991][ T3602]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   75.570838][ T3602]  ? btrfs_ioctl_get_supported_features+0x40/0x40 [=
btrfs]
> [   75.577756][ T3602]  ? _raw_spin_lock_irq+0x82/0xd2
> [   75.582572][ T3602]  ? _raw_spin_lock+0x100/0x100
> [   75.587218][ T3602]  ? fiemap_prep+0x200/0x200
> [   75.591607][ T3602]  ? lockref_put_or_lock+0xc4/0x1c0
> [   75.596600][ T3602]  ? do_sigaction+0x4b3/0x840
> [   75.601075][ T3602]  ? __x64_sys_pidfd_send_signal+0x600/0x600
> [   75.606837][ T3602]  ? __might_fault+0x4d/0x80
> [   75.611226][ T3602]  ? __x64_sys_rt_sigaction+0x1d0/0x240
> [   75.616558][ T3602]  ? __ia32_sys_signal+0x140/0x140
> [   75.621461][ T3602]  ? __fget_light+0x57/0x540
> [   75.625854][ T3602]  __x64_sys_ioctl+0x127/0x1c0
> [   75.630414][ T3602]  do_syscall_64+0x3b/0xc0
> [   75.634633][ T3602]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   75.640307][ T3602] RIP: 0033:0x7f94c25df427
> [   75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 0=
0 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 =
00 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
> [   75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000010
> [   75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d51e9f72a0 RCX: =
00007f94c25df427
> [   75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000ca289435 RDI: =
0000000000000004
> [   75.687404][ T3602] RBP: 00000000ffffffff R08: 0000000000000000 R09: =
000055d51e9fa580
> [   75.695137][ T3602] R10: 0000000000000008 R11: 0000000000000246 R12: =
00007ffd06a4e97a
> [   75.702868][ T3602] R13: 0000000000000004 R14: 0000000000000000 R15: =
0000000000000005
> [   75.710600][ T3602]  </TASK>
> [   75.713445][ T3602] Modules linked in: dm_mod btrfs blake2b_generic x=
or raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ata_generic ipmi_devi=
ntf ipmi_msghandler
> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp c=
oretemp i915 kvm_intel kvm intel_gtt ttm irqbypass crct10dif_pclmul crc32_=
pclmul crc32c_intel
> ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect sysimgblt fb_=
sys_fops rapl ata_piix mei_wdt intel_cstate drm libata mei_me intel_uncore=
 mei video ip_tables
> [   75.756460][ T3602] ---[ end trace 0000000000000000 ]---
>
>
>>
>> Thanks,
>> Qu
>>
