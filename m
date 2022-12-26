Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1C656271
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiLZML6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 07:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiLZMLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 07:11:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C706351;
        Mon, 26 Dec 2022 04:11:46 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfHAH-1ocvLR0fjH-00gqja; Mon, 26
 Dec 2022 13:11:42 +0100
Message-ID: <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
Date:   Mon, 26 Dec 2022 20:11:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:H8Y2J5mMYnNmCyL0kdu3j94VTYaP+t0kzRq0t4j1g3qmuQlMBoc
 d/U0hyz7ZZSqX1L/kzc51nqnZmtVqVTNGr7aJnt/yseboxP3b7XEIfJyl++ziinwwSdnmvy
 o2EN43OxZ9PdJOnHHXAglj7tjknRc3BLZMAdY8x/cFnUHCkDbz8X/gZq4T55KAZmLAqH5VZ
 bDZm3bFg3uKeJ7kQsNaWA==
UI-OutboundReport: notjunk:1;M01:P0:ucXafyvfV0k=;ZOPMiB1lKPrZSkU1hNDwlHFKJIQ
 rc8BS8TbDu+X+Rfzo2uXMk+rvURtadtdja28Cafl/LfPS+WetVQ38Ur4zVzsRrIR3+z9uaN5B
 lL+aUxg/s0HsyY687N0mJzv/C8FgMAo4PlLTY7m9kB40PGiJkiFGVG17msak/6YoeD3Y/w08p
 aO1evmUeqiaC8MhSCHjYEM8ampwDKNXAQ7/8EuPmz2qAG+Qd5w6lNucZ6l0dDSmGUvLwmGjyS
 8mYPSbk8q5SvMk+mCp2eHz41IN6aCZkf6Ji2VhlPY9Qq758oeHw8VnaT3UyHw9bO+WxcAgp1/
 E30ub7H8v3fzgFgrJ4FSxBvICLnZbqEtop3+x631zZLd0WO68qjhdd4svtlF8puDSwXAKba/r
 PfJWt1WNuTJOg4uuTnDPP9Nvbv3ereMW0v0qqZuGwvx/tXu/dtfJhlVsP82D5IxPm7HnFH0/2
 deoHqKTl5P208In8owA5/8Qdmw5OteQaGtGXkSmFP7PJ9MNjb43DvebfZG+BRAhJgXF6060zW
 93Abm8SMvTEPjLKsAZdaO3n6Lj+JjvnUGeV7wVRt1WkSfti54I8NM4prdypYjpZ4FxsItMsHz
 o02mnBqtUzCkEnWt104/eKc9HY3Q6SM5KBUMMxLL/EiBe674Q7f23x3cNgjRXA6NM7hZtWskF
 xzHy/UsNvEqEHZUaoC8n9gxr2BoODTBmnBvOtdmok8cmD5hzsY0LBd3+SFLt1s6rHDP3cV9ho
 +nT1tyl6huzmOJsA6Lianl5sr+AOrmc4I0AaD124PuEL47/IhIOuOyxa5lHgIN3Se/9eUPI6c
 R+cTKHSRdVDmdSmKWbwyOmGKgIuD9EUVyuXJMphyHJZ4gaO70ATcW3WeUzWLzT9a92kA7tk6J
 24kMF5zFpUrehWNR8Si2Dujwbpp35w4pPWAZYkeB2FZ64AGdGSiqvVV06n7K1tUrKQW0o7HuI
 8gbo5d0l6CBTlUpQpPwrDiGWZUA=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/26 19:14, Mikhail Gavrilov wrote:
> On Mon, Dec 26, 2022 at 1:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> With the check output, it's indeed a runtime error.
>> (At least no corruption to your fs)
>>
>> And it can be some call paths not properly initializing the level to check.
>>
>> Here is the new debug patch.
>> It should be applied without any previous debug patch.
>>
> 
> yeah, gotcha trace
> 
> [ 2561.764141] BTRFS error (device nvme1n1p3): level verify failed on
> logical 45170688 mirror 1 wanted 0 found 1
> [ 2561.764220] BTRFS error (device nvme1n1p3): read time tree block
> corruption detected on logical 45170688 mirror 1
> [ 2561.764224] BTRFS error (device nvme1n1p3): check owner_root=0
> transid=0 first_key=(0 0 0) has_first_key=0 level=0

Damn it, some check structure is completely uninitialized.

> [ 2561.764242] BTRFS error (device nvme1n1p3): read failed, check
> owner_root=259 transid=650936 has_first_key=1 first_key=(2221294 1 0)
> level=1

While at the caller, the structure is properly passed in.

So there is something wrong between the endio function and the check.

I have created the v2 version patch to debug, please apply without any 
previous debug patch.

Meanwhile this really looks like a race, thus I'm not 100% sure if my 
debug patch would reduce the possibility to reproduce.

Your bisect should be the determining evidence, for the worst case we 
can revert the offending patch.

Thank you very much for all of the testing, it really helps a lot.
Qu

> [ 2561.764342] CPU: 8 PID: 727 Comm: systemd-udevd Tainted: G        W
>     L     6.2.0-rc1-1b929c02afd37871d5afb9d498426f83432e71c2-btrfs-debug2+
> #3
> [ 2561.764348] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
> G513QY_G513QY/G513QY, BIOS G513QY.320 09/07/2022
> [ 2561.764352] Call Trace:
> [ 2561.764355]  <TASK>
> [ 2561.764360]  dump_stack_lvl+0x5b/0x77
> [ 2561.764369]  read_extent_buffer_pages.cold+0x5a/0x9d
> [ 2561.764382]  ? __pfx_end_bio_extent_readpage+0x10/0x10
> [ 2561.764390]  ? folio_unlock+0x1d/0x50
> [ 2561.764400]  btrfs_read_extent_buffer+0x98/0x150
> [ 2561.764410]  read_tree_block+0x43/0xa0
> [ 2561.764417]  read_block_for_search+0x218/0x320
> [ 2561.764432]  btrfs_search_slot+0x351/0xd30
> [ 2561.764450]  btrfs_lookup_xattr+0x7b/0xe0
> [ 2561.764460]  btrfs_getxattr+0x55/0x110
> [ 2561.764470]  __vfs_getxattr+0x7e/0xb0
> [ 2561.764480]  get_vfs_caps_from_disk+0x7a/0x220
> [ 2561.764492]  audit_copy_inode+0x95/0xd0
> [ 2561.764501]  filename_lookup+0x16b/0x1c0
> [ 2561.764525]  ? _raw_spin_unlock+0x29/0x50
> [ 2561.764534]  vfs_statx+0x8e/0x150
> [ 2561.764545]  vfs_fstatat+0x51/0x70
> [ 2561.764553]  __do_sys_newfstatat+0x2e/0x50
> [ 2561.764571]  do_syscall_64+0x5b/0x80
> [ 2561.764576]  ? do_syscall_64+0x67/0x80
> [ 2561.764585]  ? up_read+0x17/0x20
> [ 2561.764593]  ? lock_is_held_type+0xe8/0x140
> [ 2561.764601]  ? asm_exc_page_fault+0x22/0x30
> [ 2561.764607]  ? lockdep_hardirqs_on+0x7d/0x100
> [ 2561.764613]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 2561.764618] RIP: 0033:0x7f7b1b91e05e
> [ 2561.764639] Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff
> e9 07 00 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 ca b8 06 01 00
> 00 0f 05 <3d> 00 f0 ff ff 77 0b 31 c0 c3 0f 1f 84 00 00 00 00 00 48 8b
> 15 71
> [ 2561.764643] RSP: 002b:00007fffdc4062c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000106
> [ 2561.764649] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7b1b91e05e
> [ 2561.764653] RDX: 00007fffdc406320 RSI: 000055efe7d04bc0 RDI: 00000000ffffff9c
> [ 2561.764656] RBP: 000055efe7e79668 R08: 00000000000000f0 R09: 000055efe7ea85b0
> [ 2561.764659] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffdc4064b0
> [ 2561.764663] R13: 00007fffdc406320 R14: 00007fffdc4064a8 R15: 00007fffdc406308
> [ 2561.764680]  </TASK>
> [ 2561.764684] BTRFS error (device nvme1n1p3): read failed, check
> owner_root=259 transid=650936 has_first_key=1 first_key=(2221294 1 0)
> level=1
> 
> Of course full logs are also attached.
> Thanks.
> 
