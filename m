Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F338E5F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhEXL7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 07:59:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:37903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhEXL7k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 07:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621857486;
        bh=zECIdJV4SJuO0upFY237qJokgv9E5gXfr0TNJrouF4A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=i2MPiwYY2fAL7gTDdx+N5h4YOg4SpIfkUt67DrjbWnmeFc/C+84KRKdG0BNbqZDn8
         MRt2WP5E85aMPwDfzeAQmKdfDSALwO8BnNV+zMtltjgh/VsdfcUzZNcicq5YhkcbRo
         h5tkeiRPObzmBX6ktbfG2OWBo4CmJPmZ2J2yCPyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSc1L-1lraKN0bSD-00Svav; Mon, 24
 May 2021 13:58:06 +0200
Subject: Re: [PATCH v3 27/31] btrfs: fix a crash caused by race between
 prepare_pages() and btrfs_releasepage()
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210521064050.191164-1-wqu@suse.com>
 <20210521064050.191164-28-wqu@suse.com>
 <CAL3q7H7jC+WL6LnqR+6uQ_fvjBOX2-w82z9ATE8XrkXa34C7gg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <97d5af7a-eb3f-3730-f013-a7890ec76d9b@gmx.com>
Date:   Mon, 24 May 2021 19:58:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7jC+WL6LnqR+6uQ_fvjBOX2-w82z9ATE8XrkXa34C7gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vaDB07YZjlOpU/6+LYuacxbJCUJ6Qef6Bz6qPJ6/F/hulE9/Q/i
 PJbzTlfACMBEJTM521NRPHJniVEpMxqB3DuN2Yz/+oSmXRmUv892FF/s7IhVzVrTx0L0Uet
 2xSBVRLh9617c6P/Cwa37qHUKEOMZkL5OGHDVEQeRwzC25FwtLiwyYSh+6AjwyAfmviOufx
 kDQm4zOCgg5FMOH76htUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+vnFWXx5mv0=:JW9NxG1gE39cQNQAZKq0wC
 P9BVwJEJ09svOASYzMtNHHXeOUOjLItNirpZbqmXNbmMwTXxWt+HjAvEwqw1O6WVhddLZGzYJ
 C9YU+hovabrNp/r3y9tYvtb4aUH38T7yewnnNSliKOQU3HQ92311WYq+aytWQETpND55M5M4K
 YLZZVk60cv5415jpmWTFff2+NxQ6kDt+6723qfSIUZsFyEDvvIibs+hN66DPi5Z6+SxQWL5ax
 dguq77HKFLC5i3w4RPxcH8sccFlnNmyKy1sX6GxZjIAXrroXJWOsxXCGCbrDDEvjzkKjHMpTP
 Jz7YUIeTnDIULarh6lxLecnvKpTU2nmfKzRYBmXuRCRYPpMpcshAmud3Lw9PyhjNn4xQEX0xU
 6IGZiwRgRq71JZDc0c5Pti+6JGph4wvl8dXN6PH0prB2nlc6qW2MXW5iTVZAwJQmGEGIiWE7u
 TTZd57DwE2HUQvQf/tcY3C8wvY2qv6tk0kgircBcrrsTau/ytVHot/dy1oTJBd7jbGO+ovjic
 XZTU3qtj6zqTA88SEY7weHV2pUgyjpmRQi9+bmHCrh0HK1vBnOUKKgSc8nmRWTwgqDiQbU5dW
 Xw4AgVFN2UJRH2/O0QK7OUjoS+iWXxwp5O4Cc28W5JJWcTf1I9LNc7vC1n4siWdu75X3528gM
 vALqOtXhLcPfAGhwxl1n5Vc+rbO2+G2w6HQVtkNrgGc6OgkxJzc+0OxRqwmLyLUhdKxHwyWhY
 0+Oq6wLD/Upy0wdi8S7a/1lH5QbUeb1CpK9OIh/omVy3p8HjyttXqm/S9uopx8C9aOYhO91oM
 7jVyLc4/DMsH1OsHEw0i4KD45YtOYnqDDU9waGKJMaDJvZORvs+U+YMprIlEmfKszaUboPmK6
 PbIT2AwA5RM/Yi1V0RBFW8vcuOuY1CY3ESCDMZMLemC2ceGplBIi0WY7pvds3IL4BGi7xaQ3I
 E5ZVoF/whncEbP2xurwlCtsDQo/8DGB4LPK3YNnc0AnxCuF16XX17Vr0XP2CFgGScWPwKUCqf
 LGPnjMuRQZUbqRYHvjhGW2d9XNP5sJ7MKZ4r2FqNGZv4IsCcZ6+3mso5ddWslZS2+YYXQIfXx
 x0rtJppy4wKtiDy1g5pnJ+Hd7gkkGc+ZkpAGXfkfIVhXZpczWUIVfw3kHL+v80HyF7YYQ4cg/
 kKHDke7QDQEihNBxnBKl9fnBqeyiWkM3z3IJWcbwlL+IjRQwmlclLQPzEQxo/oBQv0ebqvukz
 n9Sx9GiNgxC2uxYkn
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/24 =E4=B8=8B=E5=8D=886:56, Filipe Manana wrote:
> On Fri, May 21, 2021 at 9:08 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When running generic/095, there is a high chance to crash with subpage
>> data RW support:
>>   assertion failed: PagePrivate(page) && page->private, in fs/btrfs/sub=
page.c:171
>>   ------------[ cut here ]------------
>>   kernel BUG at fs/btrfs/ctree.h:3403!
>>   Internal error: Oops - BUG: 0 [#1] SMP
>>   CPU: 1 PID: 3567 Comm: fio Tainted: G         C O      5.12.0-rc7-cus=
tom+ #17
>>   Hardware name: Khadas VIM3 (DT)
>>   Call trace:
>>    assertfail.constprop.0+0x28/0x2c [btrfs]
>>    btrfs_subpage_assert+0x80/0xa0 [btrfs]
>>    btrfs_subpage_set_uptodate+0x34/0xec [btrfs]
>>    btrfs_page_clamp_set_uptodate+0x74/0xa4 [btrfs]
>>    btrfs_dirty_pages+0x160/0x270 [btrfs]
>>    btrfs_buffered_write+0x444/0x630 [btrfs]
>>    btrfs_direct_write+0x1cc/0x2d0 [btrfs]
>>    btrfs_file_write_iter+0xc0/0x160 [btrfs]
>>    new_sync_write+0xe8/0x180
>>    vfs_write+0x1b4/0x210
>>    ksys_pwrite64+0x7c/0xc0
>>    __arm64_sys_pwrite64+0x24/0x30
>>    el0_svc_common.constprop.0+0x70/0x140
>>    do_el0_svc+0x28/0x90
>>    el0_svc+0x2c/0x54
>>    el0_sync_handler+0x1a8/0x1ac
>>    el0_sync+0x170/0x180
>>   Code: f0000160 913be042 913c4000 955444bc (d4210000)
>>   ---[ end trace 3fdd39f4cccedd68 ]---
>>
>> [CAUSE]
>> Although prepare_pages() calls find_or_create_page(), which returns the
>> page locked, but in later prepare_uptodate_page() calls, we may call
>> btrfs_readpage() which unlocked the page.
>>
>> This leaves a window where btrfs_releasepage() can sneak in and release
>> the page.
>>
>> This can be proven by the dying ftrace dump:
>>   fio-3567 : prepare_pages: r/i=3D5/257 page_offset=3D262144 private=3D=
1 after set extent map
>>   fio-3536 : __btrfs_releasepage.part.0: r/i=3D5/257 page_offset=3D2621=
44 private=3D1 clear extent map
>>   fio-3567 : prepare_uptodate_page.part.0: r/i=3D5/257 page_offset=3D26=
2144 private=3D0 after readpage
>>   fio-3567 : btrfs_dirty_pages: r/i=3D5/257 page_offset=3D262144 privat=
e=3D0  NOT PRIVATE
>
> Pasting here the tracing results form some custom tracepoints you
> added for your own debugging does not add that much value IMHO, anyone
> reading this will not know the exact places where the tracepoints were
> added,
> plus the previous explanation is clear enough.

Fair enough, will no longer add custom trace output in the future.
>
>>
>> [FIX]
>> In prepare_uptodate_page(), we should not only check page->mapping, but
>> also PagePrivate() to ensure we are still hold a correct page which has
>> proper fs context setup.
>>
>> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/file.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 6ef44afa939c..a4c092028bb6 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode *i=
node,
>>                          unlock_page(page);
>>                          return -EIO;
>>                  }
>> -               if (page->mapping !=3D inode->i_mapping) {
>> +
>> +               /*
>> +                * Since btrfs_readpage() will get the page unlocked, w=
e have
>> +                * a window where fadvice() can try to release the page=
.
>> +                * Here we check both inode mapping and PagePrivate() t=
o
>> +                * make sure the page is not released.
>> +                *
>> +                * The priavte flag check is essential for subpage as w=
e need
>> +                * to store extra bitmap using page->private.
>> +                */
>> +               if (page->mapping !=3D inode->i_mapping || !PagePrivate=
(page)) {
>
> My comments from v1 still apply here:
>
> https://lore.kernel.org/linux-btrfs/CAL3q7H5P79kEqWUnN2QKG92N3u7+G0uWbme=
C0yT1LypV63MAYA@mail.gmail.com/

My bad memory...

Now fixed and pushed to github.

Thanks,
Qu
>
> The code looks good.
> Thanks.
>
>>                          unlock_page(page);
>>                          return -EAGAIN;
>>                  }
>> --
>> 2.31.1
>>
>
>
