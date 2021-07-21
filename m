Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98823D18E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 23:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhGUUhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 16:37:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:34999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhGUUht (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 16:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626902303;
        bh=A10Kx13nPBEGeZs+/zXkw/i+S5RvSSmy0n+gglKuhL0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N7gCc4PNXr6G7HTrjcSoTBbACDPcX1TdUCk8GcirYnghs6Y3RX9Q2VrqPig/YM3cC
         k3Uxw71BqtHMbndvsnsM1hQjOsHAsjK2eHPJvui3xv9tMLsDuuZuT0OK4NlJOuexe5
         is4lcTTcuu1oo+KdEpGeoO5jQde/cX+4arKwuD+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhjF-1lBLGZ2zrN-00vgTG; Wed, 21
 Jul 2021 23:18:23 +0200
Subject: Re: [PATCH] btrfs: make __extent_writepage() not return error if the
 page is marked error
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210720114548.322356-1-wqu@suse.com>
 <e50266bf-db30-9387-9b1a-f3d042d5230a@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d9024a88-f072-690e-d9d4-806e0135677e@gmx.com>
Date:   Thu, 22 Jul 2021 05:18:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e50266bf-db30-9387-9b1a-f3d042d5230a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CvAeVUJ299gnITXHPdv0BEBjZwX2VHOoGOSWhq2yL4DLJMXm8F2
 szsIHhOBV7xrrukvve6NWQcBaG42xjDWz+NjSG34SfkhyuHRbVyfXRBpDuRIm5lj92Z9/1Y
 dxXEqiyn89ITmt22MK3uXzVW+SiS0yBGVGhvDriOvICAr4uhPcgQWv7PA5I4OT7aNl0LHQx
 UmglWnsu7KXsn+kh2i28g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFobpmaZONg=:6N8rLe7TEfwLTHZc10/slc
 FZwBp+z0+edkbbM7wFL3JmssLalDxtdFqdI0aO1Wkr64WKKGhDvqgesHZcJkACtlwO859ZZ87
 NwrotpRqQxMKirPtvGK/r4xR1UX5YYyWVmSLOs5SDEgAwnjPd1S90Vf6+nYUYAVKyoYWLGvXd
 mvk4PAgGS9XcVV6//jdnicthcFPX08yPw0GTvQSNBrAP+TcdABXibYRbciTruMDG86fByA9aH
 tNMnb5+3rIMT1fC3fd18qKjbdf4vW8YejzfVpFGdhiI9fnyNMH7kND2Bn452eLiz95Q3urcql
 9rsaEZokOhld6NF0vMUW1GVp15HKa9ykWMt14Ai1KAGqtOQwJEvn83cR2G2EyNTnwvpc4JUMR
 Ze1f1ZgVjgDeLEW4NEN4tFMkMPk51fjFaSOjAGgI7uemNiFNm/siTgTKkXpul+5os7KLTshho
 lFOReh2+/cmuGrtj0zHG2rXRdepfxupYKVtYTdtJCkeyVpzIv/YCLSe+mpdp3pAFM+n3T5urA
 vYt1Weth/LJ0CCAQfr8fINsa6AsAfusK6jsg0+KSotmycGC3bXsqoJf9TrUrc1UkZEtLzupNA
 xFIW4max2cE/G0WiEUWinGidLCYNor5SWkwSrLZ3FMZo8q6zwURNmHDPrRzSQ8QvFLkoQJPFk
 TMTcsjzhf8xNnaG+T/4BkkX7DmIWiR/4A1J6raFEAsn3oD8qrUSXRIx2M8rijHQS31q1NTyiE
 qrXi+dADbawG3E64c0wtrZSSJPQORL1MaTgFQ5K4v7PAy+nrEGrhBSP8p2Z/80fujcyCdl/xa
 vr6CRDbSJuH1pCjhuGPygv0Z9bmArwWzlh6e6prGLzR3TQuRLObuy/QAyzVL+KIGMPWg/NcSs
 XxL6OPqHhG7D8OHmCD3DIbzwRt5ZAN1rjT7N5XPV9wC+Z6aiAx7F0vGayV7XGgWFeOFK+K/wk
 80G1QhPWbGbFHhpphzWPTwg32rzUqkbMyL3wEMkYxbnqjA7rl7C6fKT8fN2MlJ5dIRV16jTm2
 TivLK5W6b5S5wMgILaNDHtpdqGlCq2MkygsjVJjQyL5nLgjowPsaYZKg0wYjDUznC7MGWWL8a
 0puTWESt7I8PgiJfmVCv6ukyQfAxEU4zPXNqSeFVJlwfLLz5NoRiPwKTg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/22 =E4=B8=8A=E5=8D=883:30, Josef Bacik wrote:
> On 7/20/21 7:45 AM, Qu Wenruo wrote:
>> [BUG]
>> When running btrfs/160 in a loop for subpage with experimental
>> compression support, it has a high chance to crash (~20%):
>>
>> =C2=A0 BTRFS critical (device dm-7): panic in
>> __btrfs_add_ordered_extent:238: inconsistency in ordered tree at
>> offset 0 (errno=3D-17 Object already exists)
>> =C2=A0 ------------[ cut here ]------------
>> =C2=A0 kernel BUG at fs/btrfs/ordered-data.c:238!
>> =C2=A0 Internal error: Oops - BUG: 0 [#1] SMP
>> =C2=A0 pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>> =C2=A0 lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>> =C2=A0 Call trace:
>> =C2=A0=C2=A0 __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>> =C2=A0=C2=A0 btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
>> =C2=A0=C2=A0 run_delalloc_nocow+0x81c/0x8fc [btrfs]
>> =C2=A0=C2=A0 btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
>> =C2=A0=C2=A0 writepage_delalloc+0xc0/0x1ac [btrfs]
>> =C2=A0=C2=A0 __extent_writepage+0xf4/0x370 [btrfs]
>> =C2=A0=C2=A0 extent_write_cache_pages+0x288/0x4f4 [btrfs]
>> =C2=A0=C2=A0 extent_writepages+0x58/0xe0 [btrfs]
>> =C2=A0=C2=A0 btrfs_writepages+0x1c/0x30 [btrfs]
>> =C2=A0=C2=A0 do_writepages+0x60/0x110
>> =C2=A0=C2=A0 __filemap_fdatawrite_range+0x108/0x170
>> =C2=A0=C2=A0 filemap_fdatawrite_range+0x20/0x30
>> =C2=A0=C2=A0 btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
>> =C2=A0=C2=A0 __btrfs_write_out_cache+0x34c/0x480 [btrfs]
>> =C2=A0=C2=A0 btrfs_write_out_cache+0x144/0x220 [btrfs]
>> =C2=A0=C2=A0 btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
>> =C2=A0=C2=A0 btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
>> =C2=A0=C2=A0 btrfs_sync_fs+0x64/0x1cc [btrfs]
>> =C2=A0=C2=A0 sync_fs_one_sb+0x3c/0x50
>> =C2=A0=C2=A0 iterate_supers+0xcc/0x1d4
>> =C2=A0=C2=A0 ksys_sync+0x6c/0xd0
>> =C2=A0=C2=A0 __arm64_sys_sync+0x1c/0x30
>> =C2=A0=C2=A0 invoke_syscall+0x50/0x120
>> =C2=A0=C2=A0 el0_svc_common.constprop.0+0x4c/0xd4
>> =C2=A0=C2=A0 do_el0_svc+0x30/0x9c
>> =C2=A0=C2=A0 el0_svc+0x2c/0x54
>> =C2=A0=C2=A0 el0_sync_handler+0x1a8/0x1b0
>> =C2=A0=C2=A0 el0_sync+0x198/0x1c0
>> =C2=A0 ---[ end trace 336f67369ae6e0af ]---
>>
>> [CAUSE]
>> For subpage case, we can have multiple sectors inside a page, this make=
s
>> it possible for __extent_writepage() to have part of its page submitted
>> before returning.
>>
>> In btrfs/160, we are using dm-dust to emulate write error, this means
>> for certain pages, we could have everything running fine, but at the en=
d
>> of __extent_writepage(), one of the submitted bios fails due to dm-dust=
.
>>
>> Then the page is marked Error, and we change @ret from 0 to -EIO.
>>
>> This makes the caller extent_write_cache_pages() to error out, without
>> submitting the remaining pages.
>>
>> Furthermore, since we're erroring out for free space cache, it doesn't
>> really care about the error and will update the inode and retry the
>> writeback.
>>
>> Then we re-run the delalloc range, and will try to insert the same
>> delalloc range while previous delalloc range is still hanging there,
>> triggering the above error.
>
> This seems like the real bug.

That's true.

>=C2=A0 We should do the proper cleanup for the
> range in this case, not ignore errors during writeback.=C2=A0 Thanks,

But if you change the view point, __extent_writepage() is only
submitting the pages to bio.
It shouldn't bother the bio error, but only care the error that affects
the bio submission.

This PageError() check makes the behavior different between subpage and
regular page size, thus this can be considered as a quick fix for subpage.

For a proper fix for both subpage and non-subpage case, I'm trying a
completely different way, and will send out a RFC for comment later.

Thanks,
Qu

>
> Josef
