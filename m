Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC04DBED0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 06:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiCQF50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCQF5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 01:57:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF696267599;
        Wed, 16 Mar 2022 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647494749;
        bh=jTQ6gnMC8ZXKGR16yRpZ0wN0d62WXoGkTh0927A/KD8=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=S970iCU9gqBBDOaRQEx3Mt8tik+St1aBCcfrn9mRF5EWzCHs/Rh4F+23fcZylU8KM
         gBxBtZ/wqy+fEa/biH5+5l/L+HnTeMrPj6hXnkSNz7MlcsMa+IhVPWcGcTVlotc0CH
         qANb3r+XDLI7EAmAZEL7TfYhZs5c16Zq4AzYGgLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm2D-1nJVIt0YiB-00GF9l; Thu, 17
 Mar 2022 06:25:49 +0100
Message-ID: <bdf807ac-8e8e-c64e-4454-264e10857d18@gmx.com>
Date:   Thu, 17 Mar 2022 13:25:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, linux-btrfs@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
References: <20220301063026.GB13547@xsang-OptiPlex-9020>
 <e55fb58e-bb3a-ce51-b485-6302415b34e4@gmx.com>
 <20220302084435.GA28137@xsang-OptiPlex-9020>
 <dbc84dd2-7e6d-95b0-d7bc-373f897a7063@gmx.com>
 <20220309074954.GB22223@xsang-OptiPlex-9020>
 <c28efa5a-e2ae-486b-6a51-5e063086937c@gmx.com>
 <20220314020549.GA24245@xsang-OptiPlex-9020>
 <eb6f9763-5bc1-5ac0-0b82-0ee7994e85c6@gmx.com>
 <57656d0d-d4d4-4d68-de82-e29093d19d3e@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [LKP] Re: [btrfs] 3626a285f8: divide_error:#[##]
In-Reply-To: <57656d0d-d4d4-4d68-de82-e29093d19d3e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TWgyNk1qfGDKHRBfn8PVRar2uC9LUeA/UfD9coKamFtGYFE17MT
 mug4WtmwGbrN6Q+qXr+AHsTYiD9JLysHajnX0eHqXglKwnDQiOJPXgOdRQoHtGlqFQ9yyeU
 EknsXcw3uL082JQiKazxnkLKF9bkhVy/t6Q3SYTYrEy3jqyxYGGSrV4cOQqs6vlQWYmpE74
 +fK04o2vJn28Tyyx7RFVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5um6HoSmIwA=:383yYuIRTVXb4cBpGfFUUe
 wqSH8Ndph8rY1SgNBpg8dY8muXAtDk9//xKxjzLOsQAmnLk5akAZsTYuHIFxucRMdiUIDCrQz
 lWi/KSbExqMYIr5ytmH0EhHQJFT3SRNvKQDiqQ3Pg/xby8d61raSV/ZYJ0ThqUTxlfEnacVl1
 gp+RWHDZXeS51YqJM6yinis5Tal7hbZ8i08JAClYGLX2nyjGdJ2PxmxFxt5aBsuJ84lOPQtD+
 x6vLjo1dbJHBxsNIyTji+3mVT4l1Aghznwi2LOA415uo7xf/g3aqN1G+chOLRtf0D0KZXViiv
 SnvJ4boEg5Bvje1LXc6Lec6eEmWC79Ew2RGSL1xzP1BWpUbuiPOC8sEtJ/9dIm6tUm6dtllwA
 nvIOPOtWaaiNQXF39CEOA92ZGRlH69hcmJveX7ovElTRsQIhL9NJvDO89O6v5ap+iARon3SBC
 11riBm1zZaCG2kuKt1iUqjNwM9HXuN/djiRw2unIJhEzx21Xw/JLW0fzt7z/ZacBMjQwx+fqO
 uaTzmOgKE3MaC0UgI0ky983OzDY1JyLrpm8QFZ3uBun4DDafvZRwSbaIwx7W2hG6Yt9+yRXw5
 Gt9uxuFeNFqTS4DKnVDXhvnQ4AF8j4+vX346HI3lEevdqk5lYtfg0W8MSvL2WuPCZMS7d9DOD
 MY2e06YxLAjteL4dhY3FgwzAvgfuP44CGO24NGqwA68hgbnUI443Oje/vZ8viGy56nS2gEa52
 EY28LOMi0DkgX9SNWNB8hODdKg5zwv+xBhfRDu7chn8l2zW0by0WyggTZfx9660gMck+vkmH6
 5SKSNj511UQhPWypgQaDgfAwWp69U4QIU6GKNgpYNJ/Xo3h3dODrL44l4bz4appQNhjqCrvcQ
 5IJ262zijHSGtBGX6wU6lHVvo9FT1CVL+mWMhiz9I8st24Xsnq51iT24x1/LeCO/BmNuAy3y1
 7hDu4qU3RD1wX+oWxy7nURnMMlX1eDi1G0REjRttQSu1HW5TnfnJTYZ70cR5RlHEIhZQZ9mMz
 ebR7NB+dCrY4VH0fyzw/M2onH3UfZNryNWk37thewgIMCqd8tyi+b23okBKNLFv2QJ32ieR5F
 ZBE2jRCO4XgXSo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/17 12:37, Yujie Liu wrote:
> Hi Qu,
>
> On 3/14/2022 10:24, Qu Wenruo wrote:
>>
>>
>> On 2022/3/14 10:05, Oliver Sang wrote:
>>> Hi Qu,
>>>
>>> On Wed, Mar 09, 2022 at 04:42:41PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/3/9 15:49, Oliver Sang wrote:
>>>>> Hi Qu,
>>>>>
>>>>> On Fri, Mar 04, 2022 at 03:26:19PM +0800, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/3/2 16:44, Oliver Sang wrote:
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> On Tue, Mar 01, 2022 at 03:47:38PM +0800, Qu Wenruo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> This is weird, the code is from simple_stripe_full_stripe_len(),
>>>>>>>> which
>>>>>>>> means the chunk map must be RAID0 or RAID10.
>>>>>>>>
>>>>>>>> In that case, their sub_stripes should be either 1 or 2, why we
>>>>>>>> got 0 there?
>>>>>>>>
>>>>>>>> In fact, from volumes.c, all sub_stripes is from
>>>>>>>> btrfs_raid_array[],
>>>>>>>> which all have either 1 or 2 sub_stripes.
>>>>>>>>
>>>>>>>>
>>>>>>>> Although the code is old, not the latest version, it should
>>>>>>>> still not
>>>>>>>> cause such problem.
>>>>>>>>
>>>>>>>> Mind to retest with my branch to see if it can be reproduced?
>>>>>>>> https://github.com/adam900710/linux/tree/refactor_scrub
>>>>>>>
>>>>>>> we tested head of this branch:
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 d6e3a8c42f2fad btrfs: scrub: rename scrub=
_bio::pagev and
>>>>>>> related members
>>>>>>> and:
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fdad4a9615f180 btrfs: introduce dedicated=
 helper to scrub
>>>>>>> simple-stripe based range
>>>>>>> on this branch.
>>>>>>>
>>>>>>> by attached config.
>>>>>>>
>>>>>>> still reproduce the same issue.
>>>>>>>
>>>>>>> attached dmesgs FYI.
>>>>>>
>>>>>> Still failed to reproduce here.
>>>>>>
>>>>>> Those btrfs/07[0123] tests are already in scrub/replace group, thus=
 I
>>>>>> ran them almost hourly during the development.
>>>>>>
>>>>>>
>>>>>> Although there are some ASSERT()s doing extra sanity checks, they
>>>>>> should
>>>>>> not affect the result anyway.
>>>>>>
>>>>>> Thus I pushed a branch with more explicit BUG_ON()s to catch the
>>>>>> possible divide by zero bugs.
>>>>>> (https://github.com/adam900710/linux/tree/refactor_scrub_testing)
>>>>>>
>>>>>> Mind to give it a try?
>>>>>
>>>>>
>>>>> in our tests, it seems one BUG_ON you added is triggered
>>>>> (full dmesg attached):
>>>>
>>>> What the heck...
>>>>
>>>> It's indeed some weird extent mapping has its sub-stripes as 0...
>>>>
>>>> I must be insane or there is something fundamental wrong.
>>>>
>>>> Mind to try that branch again? I have updated the branch, now it will
>>>> trigger BUG_ON() as soon as it finds a chunk mapping with
>>>> sub_stripes =3D=3D 0.
>>>>
>>>> I'm wondering if it's old btrfs-progs involved (which may not properl=
y
>>>> initialize btrfs_chunk::sub_stripes) now.
>>>
>>> below BUG print was caught by your new patch (detail dmesg attached):
>>
>> Thank you very much for the detailed report!
>>
>> The triggered BUG_ON() means, we're getting sub_stripes =3D=3D 0, for
>> unrelated chunks (in this case, it's DUP from sys chunk array, from the
>> full dmesg).
>>
>> And from the code context, it's from super-block, thus there must be
>> something wrong with the mkfs.btrfs.
>>
>> But unfortunately, I re-compiled my btrfs-progs v5.15.1, retried, and
>> still no reproduce.
>>
>> Mind to share the result of "btrfs ins dump-tree -t chunk /dev/sdb2" an=
d
>> "btrfs ins dump-super -f /dev/sdb2" just after the mkfs.btrfs call of i=
t?
>>
>> As the BUG_ON() mostly means, the result from mkfs.btrfs is not correct=
.
>
>
> We have added the "btrfs ins dump" commands after mkfs btrfs call, and
> got below log:
> (full dmesg attached)
>
[...]
> [=C2=A0=C2=A0 94.332728][=C2=A0 T337]=C2=A0 item 1 key (FIRST_CHUNK_TREE=
 CHUNK_ITEM
> 13631488) itemoff 16105 itemsize 80
> [=C2=A0=C2=A0 94.332733][=C2=A0 T337]
> [=C2=A0=C2=A0 94.344629][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 length 8388608 owner 2 stripe_len 65536
> type DATA
> [=C2=A0=C2=A0 94.344635][=C2=A0 T337]
> [=C2=A0=C2=A0 94.354342][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65536
> sector_size 4096
> [=C2=A0=C2=A0 94.354348][=C2=A0 T337]
> [=C2=A0=C2=A0 94.363469][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 num_stripes 1 sub_stripes 1

Correct value.

> [=C2=A0=C2=A0 94.420718][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes 1

Correct value too.

[...]
> [=C2=A0=C2=A0 94.454066][=C2=A0 T337]
> [=C2=A0=C2=A0 94.463995][=C2=A0 T337]=C2=A0 item 3 key (FIRST_CHUNK_TREE=
 CHUNK_ITEM
> 30408704) itemoff 15881 itemsize 112
> [=C2=A0=C2=A0 94.464001][=C2=A0 T337]
> [=C2=A0=C2=A0 94.476279][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 length 1073741824 owner 2 stripe_len
> 65536 type METADATA|DUP
> [=C2=A0=C2=A0 94.476288][=C2=A0 T337]
> [=C2=A0=C2=A0 94.486957][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 io_align 65536 io_width 65536
> sector_size 4096
> [=C2=A0=C2=A0 94.486963][=C2=A0 T337]
> [=C2=A0=C2=A0 94.496023][=C2=A0 T337]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 num_stripes 2 sub_stripes 1

All the sub_stripes values are correct.
So the on-disk values are correct, not something wrong in btrfs-progs.
> [=C2=A0 238.576361][ T2052] ------------[ cut here ]------------
> [=C2=A0 238.581694][ T2052] kernel BUG at fs/btrfs/volumes.c:7157!

But we still got a sub_stripes value as 0, from the super block
sys_chunk_array.

I have no idea why this could even happen.

There used to be some bug in misc-next, that makes extent buffer read to
always return 0.
But I don't think that's still in my tree.


Anyway, I have updated the refactor_scrub_testing branch, with one new
RFC patch, and rebased its base.
(Of course, I tested it locally using the scrub and replace group
without crash)

Mind to give it a try?

This branch will no longer trust the sub_stripe value from on-disk data,
and the branch base is much newer, definitely without the old possible
read extent buffer value bug.

Although the debugging BUG_ON()s are removed, if the divide error still
happens, I really need to check my sanity then...

Thanks,
Qu



> [=C2=A0 238.587222][ T2052] invalid opcode: 0000 [#1] SMP KASAN PTI
> [=C2=A0 238.592808][ T2052] CPU: 5 PID: 2052 Comm: mount Not tainted
> 5.17.0-rc4-00095-g7f159e82828e #1
> [=C2=A0 238.601424][ T2052] Hardware name: Dell Inc. OptiPlex 9020/0DNKM=
N,
> BIOS A05 12/05/2013
> [=C2=A0 238.609347][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
> [=C2=A0 238.615411][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0=
 03
> 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85
> 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b
> 7c 24 78
> [=C2=A0 238.634889][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
> [=C2=A0 238.640817][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 =
RCX:
> 0000000000000000
> [=C2=A0 238.648652][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 =
RDI:
> fffff52000679e75
> [=C2=A0 238.656487][ T2052] RBP: 000000000000033c R08: 000000000000005e =
R09:
> ffffed1034dd6791
> [=C2=A0 238.661055][=C2=A0 T339] 512+0 records in
> [=C2=A0 238.664320][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 =
R12:
> ffff88812830c500
> [=C2=A0 238.664322][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c =
R15:
> 0000000000000022
> [=C2=A0 238.664323][ T2052] FS:=C2=A0 00007f66fb9b4100(0000)
> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
> [=C2=A0 238.664325][ T2052] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> [=C2=A0 238.664327][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 =
CR4:
> 00000000001706e0
> [=C2=A0 238.667935][=C2=A0 T339]
> [=C2=A0 238.675758][ T2052] Call Trace:
> [=C2=A0 238.675761][ T2052]=C2=A0 <TASK>
> [=C2=A0 238.675762][ T2052]=C2=A0 ? _raw_spin_lock+0x81/0x100
> [=C2=A0 238.719432][ T2052]=C2=A0 ? _raw_spin_lock_bh+0x100/0x100
> [=C2=A0 238.724404][ T2052]=C2=A0 ?
> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
> [=C2=A0 238.731635][ T2052]=C2=A0 ? add_missing_dev+0x3c0/0x3c0 [btrfs]
> [=C2=A0 238.731805][=C2=A0 T339] 512+0 records out
> [=C2=A0 238.737188][=C2=A0 T339]
> [=C2=A0 238.737177][ T2052]=C2=A0 ? btrfs_get_token_64+0x700/0x700 [btrf=
s]
> [=C2=A0 238.748791][ T2052]=C2=A0 ? memcpy+0x39/0x80
> [=C2=A0 238.752632][ T2052]=C2=A0 ? write_extent_buffer+0x192/0x240 [btr=
fs]
> [=C2=A0 238.758510][ T2052]=C2=A0 btrfs_read_sys_array+0x2c7/0x380 [btrf=
s]
> [=C2=A0 238.764301][ T2052]=C2=A0 ? read_one_dev+0x13c0/0x13c0 [btrfs]
> [=C2=A0 238.769742][ T2052]=C2=A0 ? mutex_lock+0x80/0x100
> [=C2=A0 238.774016][ T2052]=C2=A0 ? __mutex_lock_slowpath+0x40/0x40
> [=C2=A0 238.779169][ T2052]=C2=A0 ? btrfs_init_workqueues+0x4c1/0x7ba [b=
trfs]
> [=C2=A0 238.785244][ T2052]=C2=A0 open_ctree+0x16ac/0x2656 [btrfs]
> [=C2=A0 238.790345][ T2052]=C2=A0 btrfs_mount_root.cold+0x13/0x192 [btrf=
s]
> [=C2=A0 238.796139][ T2052]=C2=A0 ? arch_stack_walk+0x9e/0x100
> [=C2=A0 238.800848][ T2052]=C2=A0 ? parse_rescue_options+0x300/0x300 [bt=
rfs]
> [=C2=A0 238.806803][ T2052]=C2=A0 ? vfs_parse_fs_param_source+0x3b/0x1c0
> [=C2=A0 238.812382][ T2052]=C2=A0 ? legacy_parse_param+0x6a/0x7c0
> [=C2=A0 238.817352][ T2052]=C2=A0 ? parse_rescue_options+0x300/0x300 [bt=
rfs]
> [=C2=A0 238.823313][ T2052]=C2=A0 legacy_get_tree+0xef/0x200
> [=C2=A0 238.827848][ T2052]=C2=A0 vfs_get_tree+0x84/0x2c0
> [=C2=A0 238.832122][ T2052]=C2=A0 fc_mount+0xf/0x80
> [=C2=A0 238.835879][ T2052]=C2=A0 vfs_kern_mount+0x71/0xc0
> [=C2=A0 238.840852][ T2052]=C2=A0 btrfs_mount+0x1fc/0xa40 [btrfs]
> [=C2=A0 238.845864][ T2052]=C2=A0 ? kasan_save_stack+0x1e/0x40
> [=C2=A0 238.850573][ T2052]=C2=A0 ? kasan_set_track+0x21/0x40
> [=C2=A0 238.855202][ T2052]=C2=A0 ? kasan_set_free_info+0x20/0x40
> [=C2=A0 238.860181][ T2052]=C2=A0 ? btrfs_show_options+0xf00/0xf00 [btrf=
s]
> [=C2=A0 238.865988][ T2052]=C2=A0 ? __x64_sys_mount+0x12c/0x1c0
> [=C2=A0 238.870784][ T2052]=C2=A0 ? entry_SYSCALL_64_after_hwframe+0x44/=
0xae
> [=C2=A0 238.876709][ T2052]=C2=A0 ? terminate_walk+0x203/0x4c0
> [=C2=A0 238.881415][ T2052]=C2=A0 ? vfs_parse_fs_param_source+0x3b/0x1c0
> [=C2=A0 238.886993][ T2052]=C2=A0 ? legacy_parse_param+0x6a/0x7c0
> [=C2=A0 238.891963][ T2052]=C2=A0 ? vfs_parse_fs_string+0xd7/0x140
> [=C2=A0 238.897021][ T2052]=C2=A0 ? btrfs_show_options+0xf00/0xf00 [btrf=
s]
> [=C2=A0 238.902809][ T2052]=C2=A0 ? legacy_get_tree+0xef/0x200
> [=C2=A0 238.907519][ T2052]=C2=A0 legacy_get_tree+0xef/0x200
> [=C2=A0 238.912051][ T2052]=C2=A0 ? security_capable+0x56/0xc0
> [=C2=A0 238.916761][ T2052]=C2=A0 vfs_get_tree+0x84/0x2c0
> [=C2=A0 238.921036][ T2052]=C2=A0 ? ns_capable_common+0x57/0x100
> [=C2=A0 238.925921][ T2052]=C2=A0 path_mount+0x7fc/0x1a40
> [=C2=A0 238.930205][ T2052]=C2=A0 ? kasan_set_track+0x21/0x40
> [=C2=A0 238.934838][ T2052]=C2=A0 ? finish_automount+0x600/0x600
> [=C2=A0 238.939722][ T2052]=C2=A0 ? kmem_cache_free+0xa1/0x400
> [=C2=A0 238.944434][ T2052]=C2=A0 do_mount+0xca/0x100
> [=C2=A0 238.948362][ T2052]=C2=A0 ? path_mount+0x1a40/0x1a40
> [=C2=A0 238.952900][ T2052]=C2=A0 ? _copy_from_user+0x94/0x100
> [=C2=A0 238.957609][ T2052]=C2=A0 ? memdup_user+0x4e/0x80
> [=C2=A0 238.961886][ T2052]=C2=A0 __x64_sys_mount+0x12c/0x1c0
> [=C2=A0 238.966510][ T2052]=C2=A0 do_syscall_64+0x3b/0xc0
> [=C2=A0 238.970791][ T2052]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0x=
ae
> [=C2=A0 238.976554][ T2052] RIP: 0033:0x7f66fbbb2fea
> [=C2=A0 238.980840][ T2052] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48=
 83
> c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 534513d9f513c4b9a622b34c8fb=
11281d9ee5a0644 00 00 49 89 ca b8 a5 00
> 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64
> 89 01 48
> [=C2=A0 239.000318][ T2052] RSP: 002b:00007fffa196f178 EFLAGS: 00000246
> ORIG_RAX: 00000000000000a5
> [=C2=A0 239.008593][ T2052] RAX: ffffffffffffffda RBX: 0000562feab9a970 =
RCX:
> 00007f66fbbb2fea
> [=C2=A0 239.016430][ T2052] RDX: 0000562feab9ab80 RSI: 0000562feab9abc0 =
RDI:
> 0000562feab9aba0
> [=C2=A0 239.024264][ T2052] RBP: 00007f66fbf001c4 R08: 0000000000000000 =
R09:
> 0000562feab9d890
> [=C2=A0 239.032108][ T2052] R10: 0000000000000000 R11: 0000000000000246 =
R12:
> 0000000000000000
> [=C2=A0 239.039946][ T2052] R13: 0000000000000000 R14: 0000562feab9aba0 =
R15:
> 0000562feab9ab80
> [=C2=A0 239.047783][ T2052]=C2=A0 </TASK>
> [=C2=A0 239.050664][ T2052] Modules linked in: dm_mod btrfs blake2b_gene=
ric
> xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi sg ipmi_devintf
> ata_generic ipmi_msghandler intel_rapl_msr intel_rapl_common
> x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm_intel kvm
> intel_gtt ttm drm_kms_helper irqbypass crct10dif_pclmul crc32_pclmul
> crc32c_intel syscopyarea ghash_clmulni_intel sysfillrect mei_wdt
> sysimgblt fb_sys_fops ata_piix rapl intel_cstate mei_me drm libata mei
> intel_uncore video ip_tables
> [=C2=A0 239.094228][ T2052] ---[ end trace 0000000000000000 ]---
> [=C2=A0 239.099560][ T2052] RIP: 0010:read_one_chunk+0xa02/0xc80 [btrfs]
> [=C2=A0 239.105641][ T2052] Code: 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0=
 03
> 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2 0f 85
> 19 fb ff ff <0f> 0b 4c 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b
> 7c 24 78
> [=C2=A0 239.125151][ T2052] RSP: 0018:ffffc900033cf6c8 EFLAGS: 00010246
> [=C2=A0 239.131117][ T2052] RAX: ffff8881028b2980 RBX: 0000000000000000 =
RCX:
> 0000000000000000
> [=C2=A0 239.138981][ T2052] RDX: 0000000000000000 RSI: 0000000000000008 =
RDI:
> fffff52000679e75
> [=C2=A0 239.146847][ T2052] RBP: 000000000000033c R08: 000000000000005e =
R09:
> ffffed1034dd6791
> [=C2=A0 239.154710][ T2052] R10: ffff8881a6eb3c87 R11: ffffed1034dd6790 =
R12:
> ffff88812830c500
> [=C2=A0 239.162579][ T2052] R13: ffff8881028b2998 R14: ffff8881028b299c =
R15:
> 0000000000000022
> [=C2=A0 239.170443][ T2052] FS:=C2=A0 00007f66fb9b4100(0000)
> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
> [=C2=A0 239.179267][ T2052] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> [=C2=A0 239.185742][ T2052] CR2: 000055f0bbc19d40 CR3: 0000000209c0a005 =
CR4:
> 00000000001706e0
> [=C2=A0 239.193607][ T2052] Kernel panic - not syncing: Fatal exception
> [=C2=A0 239.199567][ T2052] Kernel Offset: disabled
>
>>
>> Thanks,
>> Qu
>>>
>>> [=C2=A0=C2=A0 44.577527][ T1980] ------------[ cut here ]------------
>>> [=C2=A0=C2=A0 44.583552][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.583990][=C2=A0 T337] 512+0 records out
>>> [=C2=A0=C2=A0 44.583997][=C2=A0 T337]
>>> [=C2=A0=C2=A0 44.593932][ T1980] kernel BUG at fs/btrfs/volumes.c:7157=
!
>>> [=C2=A0=C2=A0 44.593940][ T1980] invalid opcode: 0000 [#1] SMP KASAN P=
TI
>>> [=C2=A0=C2=A0 44.598832][=C2=A0 T335]=C2=A0=C2=A0 Data:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> [=C2=A0=C2=A0 44.603293][ T1980] CPU: 5 PID: 1980 Comm: mount Not tain=
ted
>>> 5.17.0-rc4-00095-g7f159e82828e #1
>>> [=C2=A0=C2=A0 44.603297][ T1980] Hardware name: Dell Inc. OptiPlex 902=
0/0DNKMN,
>>> BIOS A05 12/05/2013
>>> [=C2=A0=C2=A0 44.603299][ T1980] RIP: 0010:read_one_chunk+0xa02/0xc80 =
[btrfs]
>>> [=C2=A0=C2=A0 44.605509][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.609168][ T1980] Code: 03 0f b6 14 02 4c 89 f0 83 e0 0=
7 83 c0
>>> 03 38 d0 7c 08 84 d2 0f 85 14 01 00 00 48 8b 44 24 10 8b 50 1c 85 d2
>>> 0f 85 19 fb ff ff <0f> 0b 4c
>>> 89 c7 e8 f4 b0 fa ff 31 c0 e9 4d ff ff ff 48 8b 7c 24 78
>>> [=C2=A0=C2=A0 44.609171][ T1980] RSP: 0018:ffffc90002be76c8 EFLAGS: 00=
010246
>>> [=C2=A0=C2=A0 44.609175][ T1980] RAX: ffff888102c98e00 RBX: 0000000000=
000000
>>> RCX: 0000000000000000
>>> [=C2=A0=C2=A0 44.609178][ T1980] RDX: 0000000000000000 RSI: 0000000000=
000008
>>> RDI: fffff5200057ce75
>>> [=C2=A0=C2=A0 44.612227][=C2=A0 T335]=C2=A0=C2=A0 Metadata:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00GiB
>>> [=C2=A0=C2=A0 44.616871][ T1980] RBP: 000000000000033c R08: 0000000000=
00005e
>>> R09: ffffed1034dd6791
>>> [=C2=A0=C2=A0 44.616873][ T1980] R10: ffff8881a6eb3c87 R11: ffffed1034=
dd6790
>>> R12: ffff888214586b40
>>> [=C2=A0=C2=A0 44.616874][ T1980] R13: ffff888102c98e18 R14: ffff888102=
c98e1c
>>> R15: 0000000000000022
>>> [=C2=A0=C2=A0 44.616876][ T1980] FS:=C2=A0 00007fad1bd12100(0000)
>>> GS:ffff8881a6e80000(0000) knlGS:0000000000000000
>>> [=C2=A0=C2=A0 44.622475][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.628578][ T1980] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:=
 0000000080050033
>>> [=C2=A0=C2=A0 44.628580][ T1980] CR2: 00007fff9d90df68 CR3: 0000000140=
7fc003
>>> CR4: 00000000001706e0
>>> [=C2=A0=C2=A0 44.628583][ T1980] DR0: 0000000000000000 DR1: 0000000000=
000000
>>> DR2: 0000000000000000
>>> [=C2=A0=C2=A0 44.628585][ T1980] DR3: 0000000000000000 DR6: 00000000ff=
fe0ff0
>>> DR7: 0000000000000400
>>> [=C2=A0=C2=A0 44.628588][ T1980] Call Trace:
>>> [=C2=A0=C2=A0 44.638095][=C2=A0 T335]=C2=A0=C2=A0 System:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DUP=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> [=C2=A0=C2=A0 44.645166][ T1980]=C2=A0 <TASK>
>>> [=C2=A0=C2=A0 44.645168][ T1980]=C2=A0 ? _raw_spin_lock+0x81/0x100
>>> [=C2=A0=C2=A0 44.651206][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.653388][ T1980]=C2=A0 ? _raw_spin_lock_bh+0x100/0x100
>>> [=C2=A0=C2=A0 44.653395][ T1980]=C2=A0 ?
>>> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>>> [=C2=A0=C2=A0 44.673370][=C2=A0 T335] SSD detected:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 no
>>> [=C2=A0=C2=A0 44.678876][ T1980]=C2=A0 ? add_missing_dev+0x3c0/0x3c0 [=
btrfs]
>>> [=C2=A0=C2=A0 44.686756][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.694598][ T1980]=C2=A0 ? btrfs_get_token_64+0x700/0x70=
0 [btrfs]
>>> [=C2=A0=C2=A0 44.701187][=C2=A0 T335] Zoned device:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 no
>>> [=C2=A0=C2=A0 44.708574][ T1980]=C2=A0 ? memcpy+0x39/0x80
>>> [=C2=A0=C2=A0 44.708581][ T1980]=C2=A0 ? write_extent_buffer+0x192/0x2=
40 [btrfs]
>>> [=C2=A0=C2=A0 44.716449][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.724294][ T1980]=C2=A0 btrfs_read_sys_array+0x2c7/0x38=
0 [btrfs]
>>> [=C2=A0=C2=A0 44.734138][=C2=A0 T335] Incompat features:=C2=A0 extref,=
 skinny-metadata,
>>> no-holes
>>> [=C2=A0=C2=A0 44.735313][ T1980]=C2=A0 ? read_one_dev+0x13c0/0x13c0 [b=
trfs]
>>> [=C2=A0=C2=A0 44.741786][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.749628][ T1980]=C2=A0 ? mutex_lock+0x80/0x100
>>> [=C2=A0=C2=A0 44.749634][ T1980]=C2=A0 ? __mutex_lock_slowpath+0x40/0x=
40
>>> [=C2=A0=C2=A0 44.758164][=C2=A0 T335] Runtime features:=C2=A0=C2=A0 fr=
ee-space-tree
>>> [=C2=A0=C2=A0 44.765352][ T1980]=C2=A0 ? btrfs_init_workqueues+0x4c1/0=
x7ba [btrfs]
>>> [=C2=A0=C2=A0 44.768515][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.774620][ T1980]=C2=A0 open_ctree+0x16ac/0x2656 [btrfs=
]
>>> [=C2=A0=C2=A0 44.777966][=C2=A0 T335] Checksum:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crc32c
>>> [=C2=A0=C2=A0 44.782064][ T1980]=C2=A0 btrfs_mount_root.cold+0x13/0x19=
2 [btrfs]
>>> [=C2=A0=C2=A0 44.784268][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.789241][ T1980]=C2=A0 ? arch_stack_walk+0x9e/0x100
>>> [=C2=A0=C2=A0 44.789247][ T1980]=C2=A0 ? parse_rescue_options+0x300/0x=
300 [btrfs]
>>> [=C2=A0=C2=A0 44.796977][=C2=A0 T335] Number of devices:=C2=A0 1
>>> [=C2=A0=C2=A0 44.800614][ T1980]=C2=A0 ? vfs_parse_fs_param_source+0x3=
b/0x1c0
>>> [=C2=A0=C2=A0 44.806131][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.808314][ T1980]=C2=A0 ? legacy_parse_param+0x6a/0x7c0
>>> [=C2=A0=C2=A0 44.808320][ T1980]=C2=A0 ? parse_rescue_options+0x300/0x=
300 [btrfs]
>>> [=C2=A0=C2=A0 44.814273][=C2=A0 T335] Devices:
>>> [=C2=A0=C2=A0 44.818205][ T1980]=C2=A0 legacy_get_tree+0xef/0x200
>>> [=C2=A0=C2=A0 44.818210][ T1980]=C2=A0 vfs_get_tree+0x84/0x2c0
>>> [=C2=A0=C2=A0 44.822077][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.827928][ T1980]=C2=A0 fc_mount+0xf/0x80
>>> [=C2=A0=C2=A0 44.827934][ T1980]=C2=A0 vfs_kern_mount+0x71/0xc0
>>> [=C2=A0=C2=A0 44.830557][=C2=A0 T335]=C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=C2=A0 PATH
>>> [=C2=A0=C2=A0 44.835890][ T1980]=C2=A0 btrfs_mount+0x1fc/0xa40 [btrfs]
>>> [=C2=A0=C2=A0 44.842730][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.848134][ T1980]=C2=A0 ? kasan_save_stack+0x1e/0x40
>>> [=C2=A0=C2=A0 44.848149][ T1980]=C2=A0 ? kasan_set_track+0x21/0x40
>>> [=C2=A0=C2=A0 44.850862][=C2=A0 T335]=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=
=C2=A0 300.00GiB=C2=A0 /dev/sdb4
>>> [=C2=A0=C2=A0 44.854618][ T1980]=C2=A0 ? kasan_set_free_info+0x20/0x40
>>> [=C2=A0=C2=A0 44.854624][ T1980]=C2=A0 ? btrfs_show_options+0xf00/0xf0=
0 [btrfs]
>>> [=C2=A0=C2=A0 44.859803][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.865032][ T1980]=C2=A0 ? __x64_sys_mount+0x12c/0x1c0
>>> [=C2=A0=C2=A0 44.865036][ T1980]=C2=A0 ? entry_SYSCALL_64_after_hwfram=
e+0x44/0xae
>>> [=C2=A0=C2=A0 44.871101][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.873263][ T1980]=C2=A0 ? terminate_walk+0x203/0x4c0
>>> [=C2=A0=C2=A0 44.873268][ T1980]=C2=A0 ? vfs_parse_fs_param_source+0x3=
b/0x1c0
>>> [=C2=A0=C2=A0 44.878354][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.882803][ T1980]=C2=A0 ? legacy_parse_param+0x6a/0x7c0
>>> [=C2=A0=C2=A0 44.882808][ T1980]=C2=A0 ? vfs_parse_fs_string+0xd7/0x14=
0
>>> [=C2=A0=C2=A0 44.889280][=C2=A0 T335] 2022-03-14 01:34:21 mkdir -p /fs=
/sdb1
>>> [=C2=A0=C2=A0 44.890770][ T1980]=C2=A0 ? btrfs_show_options+0xf00/0xf0=
0 [btrfs]
>>> [=C2=A0=C2=A0 44.895501][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.901430][ T1980]=C2=A0 ? legacy_get_tree+0xef/0x200
>>> [=C2=A0=C2=A0 44.901435][ T1980]=C2=A0 legacy_get_tree+0xef/0x200
>>> [=C2=A0=C2=A0 44.901448][ T1980]=C2=A0 ? security_capable+0x56/0xc0
>>> [=C2=A0=C2=A0 44.905612][=C2=A0 T335]=C2=A0 btrfs
>>> [=C2=A0=C2=A0 44.911057][ T1980]=C2=A0 vfs_get_tree+0x84/0x2c0
>>> [=C2=A0=C2=A0 44.911062][ T1980]=C2=A0 ? ns_capable_common+0x57/0x100
>>> [=C2=A0=C2=A0 44.913278][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.918247][ T1980]=C2=A0 path_mount+0x7fc/0x1a40
>>> [=C2=A0=C2=A0 44.918252][ T1980]=C2=A0 ? kasan_set_track+0x21/0x40
>>> [=C2=A0=C2=A0 44.925201][=C2=A0 T335] 2022-03-14 01:34:21 mount -t btr=
fs /dev/sdb1
>>> /fs/sdb1
>>> [=C2=A0=C2=A0 44.927087][ T1980]=C2=A0 ? finish_automount+0x600/0x600
>>> [=C2=A0=C2=A0 44.927092][ T1980]=C2=A0 ? kmem_cache_free+0xa1/0x400
>>> [=C2=A0=C2=A0 44.931642][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.935926][ T1980]=C2=A0 do_mount+0xca/0x100
>>> [=C2=A0=C2=A0 44.935931][ T1980]=C2=A0 ? path_mount+0x1a40/0x1a40
>>> [=C2=A0=C2=A0 44.935933][ T1980]=C2=A0 ? _copy_from_user+0x94/0x100
>>> [=C2=A0=C2=A0 44.938799][=C2=A0 T335] 2022-03-14 01:34:21 mkdir -p /fs=
/sdb2
>>> [=C2=A0=C2=A0 44.941885][ T1980]=C2=A0 ? memdup_user+0x4e/0x80
>>> [=C2=A0=C2=A0 44.941890][ T1980]=C2=A0 __x64_sys_mount+0x12c/0x1c0
>>> [=C2=A0=C2=A0 44.941893][ T1980]=C2=A0 do_syscall_64+0x3b/0xc0
>>> [=C2=A0=C2=A0 44.946884][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.951068][ T1980]=C2=A0 entry_SYSCALL_64_after_hwframe+=
0x44/0xae
>>> [=C2=A0=C2=A0 44.951074][ T1980] RIP: 0033:0x7fad1bf10fea
>>> [=C2=A0=C2=A0 44.951077][ T1980] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 8=
9 01 48
>>> 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8
>>> a5 00 00 00 0f 05 <48> 3d 01
>>> f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48
>>> [=C2=A0=C2=A0 44.956197][=C2=A0 T335]=C2=A0 btrfs
>>> [=C2=A0=C2=A0 44.958245][ T1980] RSP: 002b:00007fff9d90f878 EFLAGS: 00=
000246
>>> ORIG_RAX: 00000000000000a5
>>> [=C2=A0=C2=A0 44.958249][ T1980] RAX: ffffffffffffffda RBX: 00005628ef=
c57970
>>> RCX: 00007fad1bf10fea
>>> [=C2=A0=C2=A0 44.958251][ T1980] RDX: 00005628efc57b80 RSI: 00005628ef=
c57bc0
>>> RDI: 00005628efc57ba0
>>> [=C2=A0=C2=A0 44.958263][ T1980] RBP: 00007fad1c25e1c4 R08: 0000000000=
000000
>>> R09: 00005628efc5a890
>>> [=C2=A0=C2=A0 44.958264][ T1980] R10: 0000000000000000 R11: 0000000000=
000246
>>> R12: 0000000000000000
>>> [=C2=A0=C2=A0 44.962993][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.967613][ T1980] R13: 0000000000000000 R14: 00005628ef=
c57ba0
>>> R15: 00005628efc57b80
>>> [=C2=A0=C2=A0 44.967616][ T1980]=C2=A0 </TASK>
>>> [=C2=A0=C2=A0 44.967617][ T1980] Modules linked in: dm_mod btrfs
>>> blake2b_generic xor raid6_pq
>>> [=C2=A0=C2=A0 44.973257][=C2=A0 T335] 2022-03-14 01:34:21 mount -t btr=
fs /dev/sdb2
>>> /fs/sdb2
>>> [=C2=A0=C2=A0 44.977243][ T1980]=C2=A0 zstd_compress libcrc32c sd_mod =
t10_pi sg
>>> [=C2=A0=C2=A0 44.983019][=C2=A0 T335]
>>> [=C2=A0=C2=A0 44.985203][ T1980]=C2=A0 ipmi_devintf ata_generic ipmi_m=
sghandler
>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
>>> intel_powerclamp coretemp kvm_intel
>>> [=C2=A0=C2=A0 44.990720][=C2=A0 T335] 2022-03-14 01:34:21 mkdir -p /fs=
/sdb3
>>> [=C2=A0=C2=A0 44.995962][ T1980]=C2=A0 i915 kvm intel_gtt ttm drm_kms_=
helper
>>> irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
>>> ghash_clmulni_intel syscopyarea sysfillrect
>>> [=C2=A0=C2=A0 44.998174][=C2=A0 T335]
>>> [=C2=A0=C2=A0 45.002882][ T1980]=C2=A0 sysimgblt rapl mei_wdt fb_sys_f=
ops ata_piix
>>> intel_cstate libata drm mei_me mei intel_uncore video ip_tables
>>> [=C2=A0=C2=A0 45.002919][ T1980] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>
>>>>> [=C2=A0=C2=A0 75.279958][ T3602] ------------[ cut here ]-----------=
-
>>>>> [=C2=A0=C2=A0 75.285221][ T3602] kernel BUG at fs/btrfs/scrub.c:3387=
!
>>>>> [=C2=A0=C2=A0 75.290490][ T3602] invalid opcode: 0000 [#1] SMP KASAN=
 PTI
>>>>> [=C2=A0=C2=A0 75.296010][ T3602] CPU: 2 PID: 3602 Comm: btrfs Not ta=
inted
>>>>> 5.17.0-rc4-00095-g6b837d4c40d5 #1
>>>>> [=C2=A0=C2=A0 75.304521][ T3602] Hardware name: Dell Inc. OptiPlex
>>>>> 9020/0DNKMN, BIOS A05 12/05/2013
>>>>> [=C2=A0=C2=A0 75.312344][ T3602] RIP: 0010:scrub_stripe+0xed3/0x1340=
 [btrfs]
>>>>> [=C2=A0=C2=A0 75.318250][ T3602] Code: 90 00 00 00 e8 0e f9 96 c0 e9=
 98 f3 ff
>>>>> ff e8 c4 f9 96 c0 e9 26 f3 ff ff 48 8b bc 24 80 00 00 00 e8 f2 f8
>>>>> 96 c0 e9 3b f4 ff ff <0f> 0b 0f
>>>>> 0b 4c 8d a4 24 b8 01 00 00 31 f6 4c 8d bd 20 02 00 00 4c
>>>>> [=C2=A0=C2=A0 75.337480][ T3602] RSP: 0018:ffffc9000b47f550 EFLAGS: =
00010246
>>>>> [=C2=A0=C2=A0 75.343340][ T3602] RAX: 0000000000000007 RBX: ffff8881=
0231d600
>>>>> RCX: ffff88810231d61c
>>>>> [=C2=A0=C2=A0 75.351074][ T3602] RDX: 0000000000000000 RSI: 00000000=
00000004
>>>>> RDI: ffff8881023a2458
>>>>> [=C2=A0=C2=A0 75.358807][ T3602] RBP: ffff8881097ad800 R08: 00000000=
00000001
>>>>> R09: ffffed102828100d
>>>>> [=C2=A0=C2=A0 75.366550][ T3602] R10: ffff888141408063 R11: ffffed10=
2828100c
>>>>> R12: 0000000000000000
>>>>> [=C2=A0=C2=A0 75.374282][ T3602] R13: 0000000000100000 R14: ffff8881=
41408000
>>>>> R15: ffff888129c9c000
>>>>> [=C2=A0=C2=A0 75.382016][ T3602] FS:=C2=A0 00007f94c24ec8c0(0000)
>>>>> GS:ffff8881a6d00000(0000) knlGS:0000000000000000
>>>>> [=C2=A0=C2=A0 75.390691][ T3602] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR=
0:
>>>>> 0000000080050033
>>>>> [=C2=A0=C2=A0 75.397054][ T3602] CR2: 00007ffe454aa8e8 CR3: 00000002=
0a796004
>>>>> CR4: 00000000001706e0
>>>>> [=C2=A0=C2=A0 75.404785][ T3602] Call Trace:
>>>>> [=C2=A0=C2=A0 75.407886][ T3602]=C2=A0 <TASK>
>>>>> [=C2=A0=C2=A0 75.410645][ T3602]=C2=A0 ? btrfs_wait_ordered_extents+=
0x9a1/0xe40
>>>>> [btrfs]
>>>>> [=C2=A0=C2=A0 75.417049][ T3602]=C2=A0 ? scrub_raid56_parity+0x5c0/0=
x5c0 [btrfs]
>>>>> [=C2=A0=C2=A0 75.422853][ T3602]=C2=A0 ? btrfs_remove_ordered_extent=
+0xbc0/0xbc0
>>>>> [btrfs]
>>>>> [=C2=A0=C2=A0 75.429341][ T3602]=C2=A0 ? mutex_unlock+0x80/0x100
>>>>> [=C2=A0=C2=A0 75.433733][ T3602]=C2=A0 ? __wake_up_common_lock+0xe3/=
0x140
>>>>> [=C2=A0=C2=A0 75.438897][ T3602]=C2=A0 ? __lookup_extent_mapping+0x2=
15/0x300 [btrfs]
>>>>> [=C2=A0=C2=A0 75.445037][ T3602]=C2=A0 scrub_chunk+0x294/0x480 [btrf=
s]
>>>>> [=C2=A0=C2=A0 75.449984][ T3602]=C2=A0 scrub_enumerate_chunks+0x643/=
0x1340 [btrfs]
>>>>> [=C2=A0=C2=A0 75.455962][ T3602]=C2=A0 ? scrub_chunk+0x480/0x480 [bt=
rfs]
>>>>> [=C2=A0=C2=A0 75.461083][ T3602]=C2=A0 ? __scrub_blocked_if_needed+0=
xb9/0x200 [btrfs]
>>>>> [=C2=A0=C2=A0 75.467317][ T3602]=C2=A0 ? scrub_checksum_data+0x4c0/0=
x4c0 [btrfs]
>>>>> [=C2=A0=C2=A0 75.473121][ T3602]=C2=A0 ? down_read+0x137/0x240
>>>>> [=C2=A0=C2=A0 75.477339][ T3602]=C2=A0 ? mutex_unlock+0x80/0x100
>>>>> [=C2=A0=C2=A0 75.481726][ T3602]=C2=A0 ? __mutex_unlock_slowpath+0x3=
00/0x300
>>>>> [=C2=A0=C2=A0 75.487743][ T3602]=C2=A0 ? btrfs_find_device+0xac/0x24=
0 [btrfs]
>>>>> [=C2=A0=C2=A0 75.493285][ T3602]=C2=A0 btrfs_scrub_dev+0x535/0xc00 [=
btrfs]
>>>>> [=C2=A0=C2=A0 75.498578][ T3602]=C2=A0 ? scrub_enumerate_chunks+0x13=
40/0x1340 [btrfs]
>>>>> [=C2=A0=C2=A0 75.504812][ T3602]=C2=A0 ? btrfs_apply_pending_changes=
+0x80/0x80
>>>>> [btrfs]
>>>>> [=C2=A0=C2=A0 75.511120][ T3602]=C2=A0 ? btrfs_record_root_in_trans+=
0x4d/0x180
>>>>> [btrfs]
>>>>> [=C2=A0=C2=A0 75.517428][ T3602]=C2=A0 ? finish_wait+0x280/0x280
>>>>> [=C2=A0=C2=A0 75.521819][ T3602]=C2=A0 btrfs_dev_replace_by_ioctl.co=
ld+0x62c/0x720
>>>>> [btrfs]
>>>>> [=C2=A0=C2=A0 75.528483][ T3602]=C2=A0 ?
>>>>> btrfs_finish_block_group_to_copy+0x3c0/0x3c0 [btrfs]
>>>>> [=C2=A0=C2=A0 75.535440][ T3602]=C2=A0 ?
>>>>> __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
>>>>> [=C2=A0=C2=A0 75.542575][ T3602]=C2=A0 btrfs_ioctl+0x37ee/0x51c0 [bt=
rfs]
>>>>> [=C2=A0=C2=A0 75.547691][ T3602]=C2=A0 ? fput_many+0xaa/0x140
>>>>> [=C2=A0=C2=A0 75.551823][ T3602]=C2=A0 ? filp_close+0xef/0x140
>>>>> [=C2=A0=C2=A0 75.556041][ T3602]=C2=A0 ? __x64_sys_close+0x2d/0x80
>>>>> [=C2=A0=C2=A0 75.560600][ T3602]=C2=A0 ? do_syscall_64+0x3b/0xc0
>>>>> [=C2=A0=C2=A0 75.564991][ T3602]=C2=A0 ? entry_SYSCALL_64_after_hwfr=
ame+0x44/0xae
>>>>> [=C2=A0=C2=A0 75.570838][ T3602]=C2=A0 ?
>>>>> btrfs_ioctl_get_supported_features+0x40/0x40 [btrfs]
>>>>> [=C2=A0=C2=A0 75.577756][ T3602]=C2=A0 ? _raw_spin_lock_irq+0x82/0xd=
2
>>>>> [=C2=A0=C2=A0 75.582572][ T3602]=C2=A0 ? _raw_spin_lock+0x100/0x100
>>>>> [=C2=A0=C2=A0 75.587218][ T3602]=C2=A0 ? fiemap_prep+0x200/0x200
>>>>> [=C2=A0=C2=A0 75.591607][ T3602]=C2=A0 ? lockref_put_or_lock+0xc4/0x=
1c0
>>>>> [=C2=A0=C2=A0 75.596600][ T3602]=C2=A0 ? do_sigaction+0x4b3/0x840
>>>>> [=C2=A0=C2=A0 75.601075][ T3602]=C2=A0 ? __x64_sys_pidfd_send_signal=
+0x600/0x600
>>>>> [=C2=A0=C2=A0 75.606837][ T3602]=C2=A0 ? __might_fault+0x4d/0x80
>>>>> [=C2=A0=C2=A0 75.611226][ T3602]=C2=A0 ? __x64_sys_rt_sigaction+0x1d=
0/0x240
>>>>> [=C2=A0=C2=A0 75.616558][ T3602]=C2=A0 ? __ia32_sys_signal+0x140/0x1=
40
>>>>> [=C2=A0=C2=A0 75.621461][ T3602]=C2=A0 ? __fget_light+0x57/0x540
>>>>> [=C2=A0=C2=A0 75.625854][ T3602]=C2=A0 __x64_sys_ioctl+0x127/0x1c0
>>>>> [=C2=A0=C2=A0 75.630414][ T3602]=C2=A0 do_syscall_64+0x3b/0xc0
>>>>> [=C2=A0=C2=A0 75.634633][ T3602]=C2=A0 entry_SYSCALL_64_after_hwfram=
e+0x44/0xae
>>>>> [=C2=A0=C2=A0 75.640307][ T3602] RIP: 0033:0x7f94c25df427
>>>>> [=C2=A0=C2=A0 75.644533][ T3602] Code: 00 00 90 48 8b 05 69 aa 0c 00=
 64 c7 00
>>>>> 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00
>>>>> b8 10 00 00 00 0f 05 <48> 3d 01
>>>>> f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
>>>>> [=C2=A0=C2=A0 75.663771][ T3602] RSP: 002b:00007ffd06a4acc8 EFLAGS: =
00000246
>>>>> ORIG_RAX: 0000000000000010
>>>>> [=C2=A0=C2=A0 75.671937][ T3602] RAX: ffffffffffffffda RBX: 000055d5=
1e9f72a0
>>>>> RCX: 00007f94c25df427
>>>>> [=C2=A0=C2=A0 75.679671][ T3602] RDX: 00007ffd06a4b108 RSI: 00000000=
ca289435
>>>>> RDI: 0000000000000004
>>>>> [=C2=A0=C2=A0 75.687404][ T3602] RBP: 00000000ffffffff R08: 00000000=
00000000
>>>>> R09: 000055d51e9fa580
>>>>> [=C2=A0=C2=A0 75.695137][ T3602] R10: 0000000000000008 R11: 00000000=
00000246
>>>>> R12: 00007ffd06a4e97a
>>>>> [=C2=A0=C2=A0 75.702868][ T3602] R13: 0000000000000004 R14: 00000000=
00000000
>>>>> R15: 0000000000000005
>>>>> [=C2=A0=C2=A0 75.710600][ T3602]=C2=A0 </TASK>
>>>>> [=C2=A0=C2=A0 75.713445][ T3602] Modules linked in: dm_mod btrfs
>>>>> blake2b_generic xor raid6_pq zstd_compress libcrc32c sd_mod t10_pi
>>>>> sg ata_generic ipmi_devintf ipmi_msghandler
>>>>> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
>>>>> intel_powerclamp coretemp i915 kvm_intel kvm intel_gtt ttm
>>>>> irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel
>>>>> ghash_clmulni_intel drm_kms_helper syscopyarea sysfillrect
>>>>> sysimgblt fb_sys_fops rapl ata_piix mei_wdt intel_cstate drm libata
>>>>> mei_me intel_uncore mei video ip_tables
>>>>> [=C2=A0=C2=A0 75.756460][ T3602] ---[ end trace 0000000000000000 ]--=
-
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>> _______________________________________________
>> LKP mailing list -- lkp@lists.01.org
>> To unsubscribe send an email to lkp-leave@lists.01.org
