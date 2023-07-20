Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7575BAE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGTW4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGTWz7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E511998
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689893753; x=1690498553; i=quwenruo.btrfs@gmx.com;
 bh=SVJUDgWChR9rUkwE8CTm1O0N4TW4FIyoQb4onc1urOE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QRLMgG+x4YaYm8Su7kTDydK+7USMSgd1oQw/Kt3iflOUtfEfslieQpKc3UZ+mXrJ0lGu3ls
 hHBvQvMuh0jOKQhvV4NDBZpYf5mwc5fvEkRCeO4MnMYK5PJOPDEPhiie5agf4AJMN8fVN04Oo
 bh0UDLKWqrMu/R3O5XTj3bki3e9B+OU58bnHmhA8/sbgfEXSjdOL8DhTOf2N/xEBaDrxWwdRM
 TmILAHwFMe0KayO0uXJaCJSn6Ao5ogEZ2QumLr2gJJZbt6CJ3a96c/QCmv/l5PkhPEEGmvvLs
 NpjlJCNudvrZ1JujojGFCNAs6/r+Rv0une/ak7VOGMIejV9WSN0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1qATT22R7c-00EKkO; Fri, 21
 Jul 2023 00:55:53 +0200
Message-ID: <03e5a8b7-99de-811d-9723-41012d07172a@gmx.com>
Date:   Fri, 21 Jul 2023 06:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/8] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1689418958.git.wqu@suse.com>
 <20230720150621.GA20457@twin.jikos.cz>
 <af4ef0a6-4305-e32e-a903-fa91f2f4c706@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <af4ef0a6-4305-e32e-a903-fa91f2f4c706@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8m1vLgMCYIXyGOjv4nMN8fsbD0dfo4NyP5AbRbgOCGkwNIh+CE5
 ngB182UM2JQyV94zZ5UCI5V56UAPq+6xVbr41v6HBGLg9IpJBEPpK+OAJDuCkI91xvTQiyi
 PkCdKljO8CKV4x4vqm12rzgquwnRy/Wj45j2LR7UhMx5EKRU0XX1RRq9rpKN5uP5gFt86IQ
 QUBJDnnd5vJ4k9dRqC1ig==
UI-OutboundReport: notjunk:1;M01:P0:wWenFgWrwKo=;QXpPzlpntRDg//1fT2IPjVL8Hra
 2twNhY3dm3Z+ZDW+ehwtiUDUvcqN9iyInZ9L/qBALhnbMepDgOOUTyxzactitSsgDafyxih8W
 +yD2bZ2x7gNsHU/ukp9jxYMb3dI/sV796pwvIYS9gCUFRmsPFkFnRRhPcUG0xI/RK/xx24Nfc
 tz7KuH+ekg8xs9Sbasuef4oLeImVFbxxU/UadaHDdTMHAbJSnfqTEvMWGGPZsa6pB3u9qfSEL
 54KC2ZLVGmTzHSdR8WuhccaGiRjBKZ4rtFf6Rm7C+17UN6amVoMJ/R5byTz/at+AIGydWw739
 UW7IIzZ2aXPLdjRgCFXa18tx8WPwf/h8KIZtDcngzTBSpxQzkSxWOMfgdHoFH/w0/4Haqz4S+
 yZDNaMIDc1cMcJ/EHhjy1gSTPjT5+WpK3fMyfVLcSAVcmUFQjcy3j0U+40UIEfE/EEx1SSsU3
 vPWgCwvehEhD/buXNp+oEzOgnzZTYuCVaivpOY6XLC1880YPA2XdPjzzuZXeK+xRwMA1k7Uxb
 1Qk25gEEcTPY8MED7PtDKiW6VSl3rUbvKLxjM4dsI9qgq6SWEocqUeOBoAso4VJLNzbP2ROji
 YvP2dcp0+xQc4PsRUlWXTxD2ihTUhrUUDEd9xA/nGTevVnXQuR1XG6L2Ia//fE6/gkqQMKwly
 znRVTAfz9o/9m+TdgzJWb54dKwx/0f10r03BC8SZq1rghFORPJQA1anDDMliirK11iZcCfTNs
 JPZyRb8MCsHTUoQJW3goxCFHclCSEFSrWQyOYBa5vvaBJDdvrEefv3PjOQ8fUvkaHBmHQ7Wlk
 Pl7H+kRhxtvNIKL1bX109iXuPdbLzBv/ysB8DBJEl2Xl2rJiCywAMNMPly5Xh2OtjIiVa0XxJ
 B7rJ1il2Xr+1eMckJs4l3uZVG+1zYtKgfe5nB4DwjHc/x8f3R7uSM9C4TE7UtV9rdJ+xe2E+P
 xuCDF6onT0fGho8Peq7O5qVAxks=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/21 06:15, Qu Wenruo wrote:
>
>
> On 2023/7/20 23:06, David Sterba wrote:
>> On Sat, Jul 15, 2023 at 07:08:26PM +0800, Qu Wenruo wrote:
>>> [CHANGELOG]
>>> v2:
>>> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
>>>
>>> v3:
>>> - Fix an undefined behavior bug in memcpy_extent_buffer()
>>> =C2=A0=C2=A0 Unlike the name, memcpy_extent_buffer() needs to handle o=
verlapping
>>> =C2=A0=C2=A0 ranges, thus it calls copy_pages() which do overlap check=
s and switch
>>> =C2=A0=C2=A0 to memmove() when needed.
>>>
>>> =C2=A0=C2=A0 Here we introduce __write_extent_buffer() which allows us=
 to switch
>>> =C2=A0=C2=A0 to go memmove() if needed.
>>>
>>> - Also refactor memmove_extent_buffer()
>>> =C2=A0=C2=A0 Since we have __write_extent_buffer() which can go memmov=
e(), it's
>>> =C2=A0=C2=A0 not hard to refactor memmove_extent_buffer().
>>>
>>> =C2=A0=C2=A0 But there is still a pitfall that we have to handle doubl=
e page
>>> =C2=A0=C2=A0 boundaries as the old behavior, explained in the last pat=
ch.
>>>
>>> - Add selftests on extent buffer memory operations
>>> =C2=A0=C2=A0 I have failed too many times refactoring memmove_extent_b=
uffer(), the
>>> =C2=A0=C2=A0 wasted time should be a memorial for my stupidity.
>>
>> btrfs/125 kasan complains:
>>
>> btrfs/125=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [01:09:17][12387.34=
0788] run fstests btrfs/125 at
>> 2023-07-20 01:09:18
>> [12389.539422] BTRFS: device fsid b349d2bf-44dc-4990-8e64-c4933de9e42e
>> devid 1 transid 297 /dev/vda scanned by mount (1360)
>> [12389.543907] BTRFS info (device vda): using sha256 (sha256-generic)
>> checksum algorithm
>> [12389.545345] BTRFS info (device vda): using free space tree
>> [12389.568662] BTRFS info (device vda): auto enabling async discard
>> [12393.628549] BTRFS: device fsid 472a6171-cb8b-4916-8353-172e05aa255c
>> devid 1 transid 6 /dev/vdb scanned by mkfs.btrfs (1544)
>> [12393.630846] BTRFS: device fsid 472a6171-cb8b-4916-8353-172e05aa255c
>> devid 2 transid 6 /dev/vdc scanned by mkfs.btrfs (1544)
>> [12393.633042] BTRFS: device fsid 472a6171-cb8b-4916-8353-172e05aa255c
>> devid 3 transid 6 /dev/vdd scanned by mkfs.btrfs (1544)
>> [12393.675240] BTRFS info (device vdb): using sha256 (sha256-generic)
>> checksum algorithm
>> [12393.676651] BTRFS info (device vdb): using free space tree
>> [12393.705607] BTRFS info (device vdb): auto enabling async discard
>> [12393.708477] BTRFS info (device vdb): checking UUID tree
>> [12394.479228] BTRFS: device fsid 472a6171-cb8b-4916-8353-172e05aa255c
>> devid 2 transid 8 /dev/vdc scanned by mount (1573)
>> [12394.481329] BTRFS: device fsid 472a6171-cb8b-4916-8353-172e05aa255c
>> devid 1 transid 8 /dev/vdb scanned by mount (1573)
>> [12394.484821] BTRFS info (device vdb): using sha256 (sha256-generic)
>> checksum algorithm
>> [12394.486018] BTRFS info (device vdb): allowing degraded mounts
>> [12394.486801] BTRFS info (device vdb): using free space tree
>> [12394.495639] BTRFS warning (device vdb): devid 3 uuid
>> 8c6b8e23-2053-4b0a-9d30-0facd2dad945 is missing
>> [12394.499898] BTRFS warning (device vdb): devid 3 uuid
>> 8c6b8e23-2053-4b0a-9d30-0facd2dad945 is missing
>> [12394.523726] BTRFS info (device vdb): auto enabling async discard
>> [12398.021206] BTRFS: device fsid b349d2bf-44dc-4990-8e64-c4933de9e42e
>> devid 1 transid 298 /dev/vda scanned by btrfs (1597)
>> [12398.066913] BTRFS info (device vdb): using sha256 (sha256-generic)
>> checksum algorithm
>> [12398.068414] BTRFS info (device vdb): using free space tree
>> [12398.080629] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40239104 have 31129600
>> [12398.085719] BTRFS info (device vdb): read error corrected: ino 0
>> off 40239104 (dev /dev/vdd sector 19840)
>> [12398.087705] BTRFS info (device vdb): read error corrected: ino 0
>> off 40243200 (dev /dev/vdd sector 19848)
>> [12398.089689] BTRFS info (device vdb): read error corrected: ino 0
>> off 40247296 (dev /dev/vdd sector 19856)
>> [12398.091575] BTRFS info (device vdb): read error corrected: ino 0
>> off 40251392 (dev /dev/vdd sector 19864)
>> [12398.093929] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40255488 have 31145984
>> [12398.097548] BTRFS info (device vdb): read error corrected: ino 0
>> off 40255488 (dev /dev/vdd sector 19872)
>> [12398.099311] BTRFS info (device vdb): read error corrected: ino 0
>> off 40259584 (dev /dev/vdd sector 19880)
>> [12398.101038] BTRFS info (device vdb): read error corrected: ino 0
>> off 40263680 (dev /dev/vdd sector 19888)
>> [12398.102663] BTRFS info (device vdb): read error corrected: ino 0
>> off 40267776 (dev /dev/vdd sector 19896)
>> [12398.105020] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40271872 have 31162368
>> [12398.107479] BTRFS info (device vdb): read error corrected: ino 0
>> off 40271872 (dev /dev/vdd sector 19904)
>> [12398.109094] BTRFS info (device vdb): read error corrected: ino 0
>> off 40275968 (dev /dev/vdd sector 19912)
>> [12398.111111] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40222720 have 31113216
>> [12398.121818] BTRFS info (device vdb): auto enabling async discard
>> [12398.219247] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40288256 have 31178752
>> [12398.233989] BTRFS info (device vdb): balance: start -d -m -s
>> [12398.235327] BTRFS info (device vdb): relocating block group
>> 2365194240 flags data|raid5
>> [12398.310482] BTRFS error (device vdb): bad tree block start, mirror
>> 1 want 40189952 have 31080448
>> [12398.482607] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 1 wanted 9 found 7
>> [12398.489325] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 2 wanted 9 found 7
>> [12398.493394] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 1 wanted 9 found 7
>> [12398.496146] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 2 wanted 9 found 7
>> [12398.499510] BTRFS error (device vdb): parent transid verify failed
>> on logical 39108608 mirror 1 wanted 9 found 7
>> [12398.736591] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 1 wanted 9 found 7
>> [12398.740199] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 2 wanted 9 found 7
>> [12398.907346] BTRFS info (device vdb): balance: ended with status: -5
>> [12399.168513] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 1 wanted 9 found 7
>> [12399.174882] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 2 wanted 9 found 7
>
> Comparing it to my pass runs, the rebuild is not working for metadata.
>
> As my passing bios shows no error on mirror 2 (rebuilt from P).
>
>> [12399.180441]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [12399.183100] BUG: KASAN: slab-use-after-free in
>> btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
>> [12399.186056] Read of size 8 at addr ffff888029c96c80 by task
>> kworker/u8:4/21890
>> [12399.188440]
>> [12399.188965] CPU: 1 PID: 21890 Comm: kworker/u8:4 Not tainted
>> 6.5.0-rc2-default+ #2130
>> [12399.191616] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
>> [12399.193366] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>> [12399.194534] Call Trace:
>> [12399.195039]=C2=A0 <TASK>
>> [12399.195484]=C2=A0 dump_stack_lvl+0x46/0x70
>> [12399.196182]=C2=A0 print_address_description.constprop.0+0x30/0x420
>> [12399.197136]=C2=A0 ? preempt_count_sub+0x18/0xc0
>> [12399.197858]=C2=A0 print_report+0xb0/0x260
>> [12399.198497]=C2=A0 ? __virt_addr_valid+0xbb/0xf0
>> [12399.199204]=C2=A0 ? kasan_addr_to_slab+0x94/0xc0
>> [12399.199936]=C2=A0 kasan_report+0xbe/0xf0
>> [12399.200562]=C2=A0 ? btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
>> [12399.201618]=C2=A0 ? btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
>> [12399.202667]=C2=A0 btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
>
> This is werid, as btrfs_check_read_bio() can only happen for data bios.
>
> Let me double check what's going wrong.

What about the reproducibility? I failed to reproduce here, and I
checked the git log, it doesn't has any obvious changes to RAID56 code
either (all are already in my code base).

Thanks,
Qu
>
> Thanks,
> Qu
>> [12399.203703]=C2=A0 ? lock_sync+0x100/0x100
>> [12399.204344]=C2=A0 ? try_to_wake_up+0x50/0x880
>> [12399.205025]=C2=A0 ? btrfs_repair_io_failure+0x490/0x490 [btrfs]
>> [12399.206116]=C2=A0 ? mark_held_locks+0x1a/0x80
>> [12399.206802]=C2=A0 process_one_work+0x504/0xa00
>> [12399.207530]=C2=A0 ? pwq_dec_nr_in_flight+0x100/0x100
>> [12399.208305]=C2=A0 ? worker_thread+0x160/0x630
>> [12399.208996]=C2=A0 worker_thread+0x8e/0x630
>> [12399.209638]=C2=A0 ? __kthread_parkme+0xd8/0xf0
>> [12399.210331]=C2=A0 ? process_one_work+0xa00/0xa00
>> [12399.211032]=C2=A0 kthread+0x198/0x1e0
>> [12399.211634]=C2=A0 ? kthread_complete_and_exit+0x20/0x20
>> [12399.212432]=C2=A0 ret_from_fork+0x2d/0x50
>> [12399.213087]=C2=A0 ? kthread_complete_and_exit+0x20/0x20
>> [12399.213895]=C2=A0 ret_from_fork_asm+0x11/0x20
>> [12399.214585] RIP: 0000:0x0
>> [12399.215098] Code: Unable to access opcode bytes at 0xffffffffffffffd=
6.
>> [12399.216131] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX:
>> 0000000000000000
>> [12399.217361] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [12399.218442] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> 0000000000000000
>> [12399.219546] RBP: 0000000000000000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [12399.220629] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000000000
>> [12399.221710] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [12399.222811]=C2=A0 </TASK>
>> [12399.223263]
>> [12399.223628] Allocated by task 1621:
>> [12399.224238]=C2=A0 kasan_save_stack+0x1c/0x40
>> [12399.224900]=C2=A0 kasan_set_track+0x21/0x30
>> [12399.225558]=C2=A0 __kasan_slab_alloc+0x62/0x70
>> [12399.226240]=C2=A0 kmem_cache_alloc+0x194/0x370
>> [12399.226920]=C2=A0 mempool_alloc+0xe1/0x260
>> [12399.227573]=C2=A0 bio_alloc_bioset+0x2c7/0x450
>> [12399.228266]=C2=A0 btrfs_bio_alloc+0x2e/0x50 [btrfs]
>> [12399.229208]=C2=A0 submit_extent_page+0x2e0/0x5c0 [btrfs]
>> [12399.230206]=C2=A0 btrfs_do_readpage+0x52a/0xb50 [btrfs]
>> [12399.231188]=C2=A0 extent_readahead+0x1c3/0x2b0 [btrfs]
>> [12399.232141]=C2=A0 read_pages+0x10e/0x5f0
>> [12399.232748]=C2=A0 page_cache_ra_unbounded+0x1ed/0x2c0
>> [12399.233508]=C2=A0 filemap_get_pages+0x218/0x620
>> [12399.234196]=C2=A0 filemap_read+0x1ef/0x660
>> [12399.234825]=C2=A0 vfs_read+0x3b7/0x4f0
>> [12399.235433]=C2=A0 ksys_read+0xc7/0x160
>> [12399.236035]=C2=A0 do_syscall_64+0x3d/0x90
>> [12399.236675]=C2=A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [12399.237505]
>> [12399.237856] Freed by task 1621:
>> [12399.238423]=C2=A0 kasan_save_stack+0x1c/0x40
>> [12399.239084]=C2=A0 kasan_set_track+0x21/0x30
>> [12399.239728]=C2=A0 kasan_save_free_info+0x27/0x40
>> [12399.240435]=C2=A0 ____kasan_slab_free+0x1c2/0x230
>> [12399.241141]=C2=A0 kmem_cache_free+0x13a/0x410
>> [12399.241813]=C2=A0 bio_free+0x76/0xa0
>> [12399.242386]=C2=A0 end_bio_extent_readpage+0x139/0x400 [btrfs]
>> [12399.243434]=C2=A0 btrfs_submit_chunk+0x6e9/0x9b0 [btrfs]
>> [12399.244421]=C2=A0 btrfs_submit_bio+0x21/0x60 [btrfs]
>> [12399.245356]=C2=A0 submit_one_bio+0x6a/0xb0 [btrfs]
>> [12399.246273]=C2=A0 submit_extent_page+0x232/0x5c0 [btrfs]
>> [12399.247268]=C2=A0 btrfs_do_readpage+0x52a/0xb50 [btrfs]
>> [12399.248648]=C2=A0 extent_readahead+0x1c3/0x2b0 [btrfs]
>> [12399.249608]=C2=A0 read_pages+0x10e/0x5f0
>> [12399.250236]=C2=A0 page_cache_ra_unbounded+0x1ed/0x2c0
>> [12399.251006]=C2=A0 filemap_get_pages+0x218/0x620
>> [12399.251688]=C2=A0 filemap_read+0x1ef/0x660
>> [12399.252304]=C2=A0 vfs_read+0x3b7/0x4f0
>> [12399.252880]=C2=A0 ksys_read+0xc7/0x160
>> [12399.253463]=C2=A0 do_syscall_64+0x3d/0x90
>> [12399.254086]=C2=A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [12399.254878]
>> [12399.255239] The buggy address belongs to the object at
>> ffff888029c96c80
>> [12399.255239]=C2=A0 which belongs to the cache biovec-max of size 4096
>> [12399.257027] The buggy address is located 0 bytes inside of
>> [12399.257027]=C2=A0 freed 4096-byte region [ffff888029c96c80,
>> ffff888029c97c80)
>> [12399.258790]
>> [12399.259143] The buggy address belongs to the physical page:
>> [12399.259994] page:ffff88807e872400 refcount:1 mapcount:0
>> mapping:0000000000000000 index:0x0 pfn:0x29c90
>> [12399.261410] head:ffff88807e872400 order:3 entire_mapcount:0
>> nr_pages_mapped:0 pincount:0
>> [12399.262656] flags: 0xa80000010200(slab|head|section=3D5|zone=3D1)
>> [12399.263548] page_type: 0xffffffff()
>> [12399.264144] raw: 0000a80000010200 ffff888001310ac0 ffff88807e099a10
>> ffff888001312b70
>> [12399.265851] raw: 0000000000000000 0000000000070007 00000001ffffffff
>> 0000000000000000
>> [12399.267051] page dumped because: kasan: bad access detected
>> [12399.267900]
>> [12399.268239] Memory state around the buggy address:
>> [12399.268986]=C2=A0 ffff888029c96b80: fc fc fc fc fc fc fc fc fc fc fc=
 fc
>> fc fc fc fc
>> [12399.270092]=C2=A0 ffff888029c96c00: fc fc fc fc fc fc fc fc fc fc fc=
 fc
>> fc fc fc fc
>> [12399.271203] >ffff888029c96c80: fa fb fb fb fb fb fb fb fb fb fb fb
>> fb fb fb fb
>> [12399.272590]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>> [12399.273152]=C2=A0 ffff888029c96d00: fb fb fb fb fb fb fb fb fb fb fb=
 fb
>> fb fb fb fb
>> [12399.274267]=C2=A0 ffff888029c96d80: fb fb fb fb fb fb fb fb fb fb fb=
 fb
>> fb fb fb fb
>> [12399.275385]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [12399.276551] Disabling lock debugging due to kernel taint
>> [12399.277362] assertion failed: bv->bv_len =3D=3D fs_info->sectorsize,=
 in
>> fs/btrfs/inode.c:3441
>> [12399.278654] ------------[ cut here ]------------
>> [12399.279387] kernel BUG at fs/btrfs/inode.c:3441!
>> [12399.280165] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> [12399.280979] CPU: 1 PID: 21890 Comm: kworker/u8:4 Tainted: G
>> B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 6.5.0-rc2-default+ #2130
>> [12399.282353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
>> [12399.283964] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>> [12399.285309] RIP: 0010:btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.288907] RSP: 0018:ffff888049277b30 EFLAGS: 00010246
>> [12399.290022] RAX: 000000000000004d RBX: ffff888015166d80 RCX:
>> 0000000000000000
>> [12399.291074] RDX: 0000000000000000 RSI: ffffffff961007f8 RDI:
>> ffffffff99c9e0e0
>> [12399.292385] RBP: ffff888049277cc0 R08: 0000000000000001 R09:
>> ffffed100924ef0f
>> [12399.293411] R10: ffff88804927787f R11: fffffffffffe37c0 R12:
>> ffff888014bc8000
>> [12399.294446] R13: ffff88804abdc000 R14: 0000000000000655 R15:
>> ffff8880168b3b78
>> [12399.295468] FS:=C2=A0 0000000000000000(0000) GS:ffff888068c00000(000=
0)
>> knlGS:0000000000000000
>> [12399.296693] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [12399.297549] CR2: ffffffffffffffd6 CR3: 000000007288b000 CR4:
>> 00000000000006a0
>> [12399.298577] Call Trace:
>> [12399.299049]=C2=A0 <TASK>
>> [12399.299472]=C2=A0 ? die+0x32/0x80
>> [12399.302753]=C2=A0 ? do_trap+0x12d/0x160
>> [12399.303356]=C2=A0 ? btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.304487]=C2=A0 ? btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.305593]=C2=A0 ? do_error_trap+0x90/0x130
>> [12399.306241]=C2=A0 ? btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.307314]=C2=A0 ? handle_invalid_op+0x2c/0x30
>> [12399.307999]=C2=A0 ? btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.308972]=C2=A0 ? exc_invalid_op+0x29/0x40
>> [12399.309616]=C2=A0 ? asm_exc_invalid_op+0x16/0x20
>> [12399.310302]=C2=A0 ? preempt_count_sub+0x18/0xc0
>> [12399.310988]=C2=A0 ? btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.311976]=C2=A0 ? end_report+0x7a/0x130
>> [12399.312594]=C2=A0 ? btrfs_check_sector_csum+0x210/0x210 [btrfs]
>> [12399.313625]=C2=A0 ? btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
>> [12399.314637]=C2=A0 btrfs_check_read_bio+0x238/0x8d0 [btrfs]
>> [12399.315641]=C2=A0 ? lock_sync+0x100/0x100
>> [12399.316247]=C2=A0 ? try_to_wake_up+0x50/0x880
>> [12399.316906]=C2=A0 ? btrfs_repair_io_failure+0x490/0x490 [btrfs]
>> [12399.317946]=C2=A0 process_one_work+0x504/0xa00
>> [12399.318625]=C2=A0 ? pwq_dec_nr_in_flight+0x100/0x100
>> [12399.319363]=C2=A0 ? worker_thread+0x160/0x630
>> [12399.320023]=C2=A0 worker_thread+0x8e/0x630
>> [12399.320640]=C2=A0 ? __kthread_parkme+0xd8/0xf0
>> [12399.321299]=C2=A0 ? process_one_work+0xa00/0xa00
>> [12399.321990]=C2=A0 kthread+0x198/0x1e0
>> [12399.322564]=C2=A0 ? kthread_complete_and_exit+0x20/0x20
>> [12399.323334]=C2=A0 ret_from_fork+0x2d/0x50
>> [12399.323945]=C2=A0 ? kthread_complete_and_exit+0x20/0x20
>> [12399.324713]=C2=A0 ret_from_fork_asm+0x11/0x20
>> [12399.325364] RIP: 0000:0x0
>> [12399.325855] Code: Unable to access opcode bytes at 0xffffffffffffffd=
6.
>> [12399.326833] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX:
>> 0000000000000000
>> [12399.328007] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [12399.329049] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> 0000000000000000
>> [12399.330095] RBP: 0000000000000000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [12399.331146] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000000000
>> [12399.332197] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [12399.333246]=C2=A0 </TASK>
>> [12399.333679] Modules linked in: dm_flakey dm_mod btrfs
>> blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq
>> zstd_decompress zstd_compress xxhash zstd_common loop
>> [12399.335968] ---[ end trace 0000000000000000 ]---
>> [12399.336714] RIP: 0010:btrfs_data_csum_ok+0x40f/0x530 [btrfs]
>> [12399.340450] RSP: 0018:ffff888049277b30 EFLAGS: 00010246
>> [12399.341276] RAX: 000000000000004d RBX: ffff888015166d80 RCX:
>> 0000000000000000
>> [12399.342337] RDX: 0000000000000000 RSI: ffffffff961007f8 RDI:
>> ffffffff99c9e0e0
>> [12399.343389] RBP: ffff888049277cc0 R08: 0000000000000001 R09:
>> ffffed100924ef0f
>> [12399.349246] R10: ffff88804927787f R11: fffffffffffe37c0 R12:
>> ffff888014bc8000
>> [12399.350585] R13: ffff88804abdc000 R14: 0000000000000655 R15:
>> ffff8880168b3b78
>> [12399.351846] FS:=C2=A0 0000000000000000(0000) GS:ffff888069000000(000=
0)
>> knlGS:0000000000000000
>> [12399.353471] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [12399.354460] CR2: 000055a729c8d000 CR3: 000000003b421000 CR4:
>> 00000000000006a0
>> [12399.357113] BTRFS error (device vdb): parent transid verify failed
>> on logical 38993920 mirror 1 wanted 9 found 7
>> Connection closed by foreign host.
