Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED9361735
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 03:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbhDPBf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 21:35:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:50527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236309AbhDPBf0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 21:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618536898;
        bh=ZiDlvjzQ0cGNdUtNjQEbnVFEw5zxHe4mq7cks6mgcoU=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ju/6jimtpQ3UP/hRX7ZmBPXtQPej9TiDcp5WqEE44jdYC6ltuMJfCqEXt6ZLj5Y5S
         lTfJgxx4BW7N0JZ/yUaPTuz6rN1t0OyVpBN/333R+c1e0aSID1V0LmhAs5YoRlPBCU
         nTR7XwG0aUrmfeiR33AQ1HHjBA1uIgB4K7qRDDRk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1lxiNc0jar-00iUHO; Fri, 16
 Apr 2021 03:34:57 +0200
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
Date:   Fri, 16 Apr 2021 09:34:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q5Ocp9m1znlpCc5HaoXT38IjezngEO8EYNKhWSEiaDNOLup2f1M
 n1/TtLtps29Nf1AXEUuW9cce508bm0Gbb4eU8Ix9C7KSfd7/ywAlxckwAkvDkBa1AEkXFEP
 NRWN3ZIj4CB1CjIWWRzJn5xX+cyvzFf+SB9twlf+tmzzf5Ihu5OIL9sQrp1n5Z9Nb+9tw0p
 a1cF56Pib74rS737SazAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C+gB1PJ8Mp0=:NSVmWoYOvxKPRQDAedkH4K
 t39fJri/cOrX+n+P1lpa1gPU+r92KNepOaja8ePJ+A19r0Q+86E4i2bb1khdbYm6O1vvmYmnt
 ruQaBCk4EQzqYbnmGMyVNiGwbVebaE6+pz8tVVcZXJKev1+p2rqzcDrr4fuTInyn/yuuSS/hW
 pu4N9uL6MttCZiCeKSNHUjhpaj5UhVBUWRcHsxew4duhzBwiTGg8xvtJiRS2QVAu8rsxGiV6P
 w9YbhIgY7FNLdZfaLv1rRbSTkxQt2vwsBxPOJE2p8RUK534czlFf8j1n3MESVTaqWsPBNAr3q
 hUPgdKceJKI97srPDfpBtz2DrvtoGAmG9jYf2bCdtVtfUmBq8op26d5hsKAtTc7IbuzKPDIVi
 FKeH+38YDZ4IkwnHrRs1DkXQ8yOAMmvLBt8f5L+zjZSlIJSDLkzYQ7+1hMkRU4NdAzXeytS7Y
 I+TlNi/lpCpoPFCHgNVljOlNKwTTbB5ebUfBZl1+Gtx7MKxdbTxSz/F4TlClLkTsKazWS7UU+
 Di4nXpVFY+RmSmLmWtnftd6B/T6MGqLGOG3fzEXjlgaIkjQCnrLE1ksuqG5wASshkmVsDTM2Q
 HNis047BM2wbbM8eBJ5v9fsfb9x2rEESj0R2I4TZ2tyIweOXSuyW3VeQPsWfMpTk7+fCkogVb
 OhebjYsRASitKr9O3rVwolX/lL7Ly7uE7SAr9OjFo7e6qIFpHO8xIm9exGh1eCK6/ifEuNh1i
 YJErjuR3XsYFMX8K9725SsSmBdN9xLH36j/hrGPTgEUHJctEtgq60JPkZeBQyQY5QvdEFJIwQ
 KUsq5dQUlXnivxhh5wAk3WO/KhtY+2pQlHPPGjrsQ5VERsc2xDC8qA01yf3xHxIBkCRUJPUEo
 XExXNnPz9xYNfmxQdjN+B0lYLAncdnlbRN9Z0WOgCs0zU3FJQXwv4OB34E2oHVcLHMFdeDQud
 ItlhfljKjOYDWmzGZq/jsaBINrgh/UfwjIp/0DhTrP9m15M6h2i2mTBp+2I2/4X3FEFdBOd8e
 lpjVOzJoLStsd/IEPeyJEmqBO1avpfGdg34zgV+VDku1Rj89gIVaHdw/qcUVGk0ONzHs4I7gi
 CLuzdVx9oHkqyYHkWSN7DQVkw7LZq2qsNjezwwpbZcMSZZzzCvD4La+6YLsGLjd3CdBvcE9J4
 UOgzCUIpS1H6yKO2wif9tBG7zymrupLJNVA1r5QyNvlOCeFw5l3iu0C9Yty2PCyPyqUiJkC6A
 AVVpqZl/PdA7iJcrC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/16 =E4=B8=8A=E5=8D=887:34, Qu Wenruo wrote:
>
>
> On 2021/4/16 =E4=B8=8A=E5=8D=887:19, Qu Wenruo wrote:
>>
>>
>> On 2021/4/15 =E4=B8=8B=E5=8D=8810:52, riteshh wrote:
>>> On 21/04/15 09:14AM, riteshh wrote:
>>>> On 21/04/12 07:33PM, Qu Wenruo wrote:
>>>>> Good news, you can fetch the subpage branch for better test results.
>>>>>
>>>>> Now the branch should pass all generic tests, except defrag and know=
n
>>>>> failures.
>>>>> And no more random crash during the tests.
>>>>
>>>> Thanks, let me test it on PPC64 box.
>>>
>>> I do see some failures remaining with the patch series.
>>> However the one which is blocking my testing is the tests/generic/095
>>> I see kernel BUG hitting with below signature.
>>
>> That's pretty different from my tests.
>>
>> As I haven't seen such BUG_ON() for a while.
>>
>>
>>>
>>> Please let me know if this a known failure?
>>>
>>> <xfstests config>
>>> #:~/work-tools/xfstests$ sudo ./check -g auto
>>> SECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs_4k
>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/ppc64le qemu 5.12.0-rc=
7-02316-g3490dae50c0 #73
>>> SMP Thu Apr 15 07:29:23 CDT 2021
>>> MKFS_OPTIONS=C2=A0 -- -f -s 4096 -n 4096 /dev/loop3
>>
>> I see you're using -n 4096, not the default -n 16K, let me see if I can
>> reproduce that.
>>
>> But from the backtrace, it doesn't look like the case,
>> as it happens for data path, which means it's only related to sectorsiz=
e.
>>
>>> MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
>>>
>>>
>>> <kernel logs>
>>> [ 6057.560580] BTRFS warning (device loop3): read-write for sector
>>> size 4096 with page size 65536 is experimental
>>> [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
>>> [ 6058.345127] BTRFS info (device loop2): disk space caching is enable=
d
>>> [ 6058.348910] BTRFS info (device loop2): has skinny extents
>>> [ 6058.351930] BTRFS warning (device loop2): read-write for sector
>>> size 4096 with page size 65536 is experimental
>>> [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbbd
>>> devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
>>> [ 6060.225107] BTRFS info (device loop3): disk space caching is enable=
d
>>> [ 6060.226213] BTRFS info (device loop3): has skinny extents
>>> [ 6060.227084] BTRFS warning (device loop3): read-write for sector
>>> size 4096 with page size 65536 is experimental
>>> [ 6060.234537] BTRFS info (device loop3): checking UUID tree
>>> [ 6061.375902] assertion failed: PagePrivate(page) && page->private,
>>> in fs/btrfs/subpage.c:171
>>> [ 6061.378296] ------------[ cut here ]------------
>>> [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
>>> cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000a9370c: assertfail.constprop.11=
+0x34/0x48
>>> =C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000a93708: assertfail.constprop.11=
+0x30/0x48
>>> =C2=A0=C2=A0=C2=A0=C2=A0 sp: c0000000260d7730
>>> =C2=A0=C2=A0=C2=A0 msr: 800000000282b033
>>> =C2=A0=C2=A0 current =3D 0xc0000000260c0080
>>> =C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003fff8a00=C2=A0=C2=A0=
 irqmask: 0x03=C2=A0=C2=A0 irq_happened: 0x01
>>> =C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 739712, comm =3D fio
>>> kernel BUG at fs/btrfs/ctree.h:3403!
>>> Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
>>> (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu)
>>> 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
>>> enter ? for help
>>> [c0000000260d7790] c000000000a90280
>>> btrfs_subpage_assert.isra.9+0x70/0x110
>>> [c0000000260d77b0] c000000000a91064
>>> btrfs_subpage_set_uptodate+0x54/0x110
>>> [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
>>
>> This is very strange.
>> As in btrfs_dirty_pages(), the pages passed in are already prepared by
>> prepare_pages(), which means all of them should have Private set.
>>
>> Can you reproduce the bug reliable?
>
> OK, I got it reproduced.
>
> It's not a reliable BUG_ON(), but can be reproduced.
> The test get skipped for all my boards as it requires fio tool, thus I
> didn't get it triggered for all previous runs.
>
> I'll take a look into the case.

This exposed an interesting race window in btrfs_buffered_write():
         Writer                    |             fadvice
=2D---------------------------------+-------------------------------
btrfs_buffered_write()            |
|- prepare_pages()                |
|  |- Now all pages involved get  |
|     Private set                 |
|                                 | btrfs_release_page()
|                                 | |- Clear page Private
|- lock_extent()                  |
|  |- This would prevent          |
|     btrfs_release_page() to     |
|     clear the page Private      |
|
|- btrfs_dirty_page()
    |- Will trigger the BUG_ON()

This only happens for subpage, because subpage introduces new ASSERT()
to do extra check.

If we want to speak strictly, regular sector size should also report
this problem.
But regular sector size case doesn't really care about page Private, as
it just set page->private to a constant value, unlike subpage case which
stores important value.

The fix will just re-set page Private and needed structures in
btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
able to release it anymore.

The fix is already added to the github branch.
Now it has the fix as the HEAD.

I hope this won't damage your confidence on the patchset.

Thanks for the report!
Qu

>
> Thanks for the report,
> Qu
>>
>> BTW, are using running the latest branch, with this commit at top?
>>
>> commit 3490dae50c01cec04364e5288f43ae9ac9eca2c9
>> Author: Qu Wenruo <wqu@suse.com>
>> Date:=C2=A0=C2=A0 Mon Feb 22 14:19:38 2021 +0800
>>
>> =C2=A0=C2=A0=C2=A0 btrfs: allow read-write for 4K sectorsize on 64K pag=
e sizesystems
>>
>> As I was updating the patchset until the last minute.
>>
>> Thanks,
>> Qu
>>
>>> [c0000000260d7880] c0000000009c7298 btrfs_buffered_write+0x488/0x7f0
>>> [c0000000260d79d0] c0000000009cbeb4 btrfs_file_write_iter+0x314/0x520
>>> [c0000000260d7a50] c00000000055fd84 do_iter_readv_writev+0x1b4/0x260
>>> [c0000000260d7ac0] c00000000056114c do_iter_write+0xdc/0x2c0
>>> [c0000000260d7b10] c0000000005c2d2c iter_file_splice_write+0x2ec/0x510
>>> [c0000000260d7c30] c0000000005c1ba0 do_splice_from+0x50/0x70
>>> [c0000000260d7c50] c0000000005c37e8 do_splice+0x5a8/0x910
>>> [c0000000260d7cd0] c0000000005c3ce0 sys_splice+0x190/0x300
>>> [c0000000260d7d60] c000000000039ba4 system_call_exception+0x384/0x3d0
>>> [c0000000260d7e10] c00000000000d45c system_call_common+0xec/0x278
>>> --- Exception: c00 (System Call) at 00007ffff72ef170
>>>
>>>
>>> -ritesh
>>>
