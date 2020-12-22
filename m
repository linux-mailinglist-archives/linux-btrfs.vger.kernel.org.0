Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1410B2E0573
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 05:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLVEkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 23:40:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:51459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgLVEkR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 23:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608611922;
        bh=RJ/WdlAqLo7vQZ70ouabegnL74KeqUE+gGFsUzUwzM4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=BUC0eOJah2udRtWtr9sSEeaSBvxgGNi/iSF8tJqBQSGPrCglJV2/z6zLWEaERCeLV
         kcNWMTGi0jGQbIrHsPLKchUNvXlJD+Z5XgonX8Gx1hsx9hVmIKt4s1aHt9RzSQxm8O
         qXR7gAlgn3hvvBxXOXB5rPoDP5fSycxCucst7XQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY6Cl-1kYTOu2GcP-00YUP1; Tue, 22
 Dec 2020 05:38:42 +0100
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-5-wqu@suse.com>
 <CAL3q7H7WTScxZmAwaNCztp-Q=zP6NSkRzh==quQS5mqxxbto2Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 4/4] btrfs: inode: make btrfs_invalidatepage() to be
 subpage compatible
Message-ID: <7013d0b6-0ce1-9ee6-7cbf-955126053e10@gmx.com>
Date:   Tue, 22 Dec 2020 12:38:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7WTScxZmAwaNCztp-Q=zP6NSkRzh==quQS5mqxxbto2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gHOwOeoLEhXQZKd850S0/jkNJZt/tNeTkosPekBI6c/t9Cw2mZA
 eVjID8EmSBXsGNpNAL0jLcRm2R2x98xK829V5ivQnJnLBiO1ZRSh++52/+38x74RxYkr8bs
 SnhBNFcZ/uqcSGlMxokD8AyO4BQ2emg6LP1+jMJRdADZzD7d8V795e00UXRCAH9uftiN2MU
 gxO40IdMvU6uMXHGGAMhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:49cII+A2aSM=:f87IK6aqPVhNdPqCWN/zhQ
 Iji2lenguLcxx77BH5xuWqerGb7YXKUThaJs+4UZ4Ghu+BajM1DHxOM7l+6HJ8Uao9TX68MYC
 iPqGC7n6hv3H4sBX213mgGpvHpUyYAIz+3Ja+cNrHEZpCMcrMe5KaCEDTTaBcAXrf3T/OVi6N
 AN7MKjOpypB30n7RF6Yfvqx/OtRHCNfWnlKAn1IBpfGsj9WdSsGL/uSv5bssBmLfuYmJx887U
 gOh/JeFvVOiqkqBn2ycNK4HKILtkOB2lqR0wgEVRsS8ohFONXp+SGVdOE1UvALxzLU/feB5+/
 QpvwjtSmLroeX8T8zqDANFXrDp20k21+7Rbb394MdvrQ/kTj+/YaqkFRSfji7GKsJYa0KrR88
 eeVLvv9K0GS/vg717uc28NVp+tywtIicf2ZYHHxP32Vf+B5puLk4mSIt65/rLl2qo2QQydfwq
 E/MtQBak5/k3GZJHlxsxAh75XkI2e0Q68azknE8h1hfOq5a2MvwX2vL90RoOEJ2T8G7CP4OAW
 f5kNYkvzvIYMqZyUhVbWzrmehAyFapWufRVrH+Hr/UiQuXaekO7rL1qPsFzdIDAyZ/TcSOrzX
 RUupSp7mKFopIYDLbJhCXkRBevU0SFpWpN+pp/csvLZGwI+kgKBqrSc3i6T7F7tYjjOoqXWmG
 uJZl55AWv6N0J7P744kuPxYLBP23aa+liPFlQAj1V6rSd5lPMKB87grSMjex5XeLmeSOrcVSY
 6bjR3A+sjHHhNpK60iyTc5oVNAT8/bOiPII0BMRn0zdHQGUplk9CW77c8MloAroPjezAHpvXM
 cobUmqz/WqrWsyAXPxQM3MsBff2feiWI+XDfmCLJXXAoK6mOAWwNGfPanY8E9LuVipuxBsGJT
 kM5m8ZCtioIzy1VKUh/w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/17 =E4=B8=8B=E5=8D=887:20, Filipe Manana wrote:
> On Thu, Dec 17, 2020 at 5:03 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> With current subpage RW patchset, the following script can lead to
>> filesystem hang:
>>    # mkfs.btrfs -f -s 4k $dev
>>    # mount $dev -o nospace_cache $mnt
>>    # fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt
>>
>> The file system will hang at wait_event() of
>> btrfs_start_ordered_extent().
>>
>> [CAUSE]
>> The root cause is, btrfs_invalidatepage() is freeing page::private whic=
h
>> still has subpage dirty bit set.
>>
>> The offending situation happens like this:
>> btrfs_fllocate()
>> |- btrfs_zero_range()
>>     |- btrfs_punch_hole_lock_range()
>>        |- truncate_pagecache_range()
>>           |- btrfs_invalidatepage()
>>
>> The involved range looks like:
>>
>> 0       32K     64K     96K     128K
>>          |///////||//////|
>>          | Range to drop |
>>
>> For the [32K, 64K) range, since the offset is 32K, the page won't be
>> invalidated.
>>
>> But for the [64K, 96K) range, the offset is 0, current
>> btrfs_invalidatepage() will call clear_page_extent_mapped() which will
>> detach page::private, making the subpage dirty bitmap being cleared.
>>
>> This prevents later __extent_writepage_io() to locate any range to
>> write, thus no way to wake up the ordered extents.
>>
>> [FIX]
>> To fix the problem this patch will:
>> - Only clear page status and detach page private when the full page
>>    is invalidated
>>
>> - Change how we handle unfinished ordered extent
>>    If there is any ordered extent unfinished in the page range, we can'=
t
>>    call clear_extent_bit() with delete =3D=3D true.
>>
>> [REASON FOR RFC]
>> There is still uncertainty around the btrfs_releasepage() call.
>>
>> 1. Why we need btrfs_releasepage() call for non-full-page condition?
>>     Other fs (aka. xfs) just exit without doing special handling if
>>     invalidatepage() is called with part of the page.
>>
>>     Thus I didn't completely understand why btrfs_releasepage() here is
>>     needed for non-full page call.
>>
>> 2. Why "if (offset)" is not causing problem for current code?
>>     This existing if (offset) call can be skipped for cases like
>>     offset =3D=3D 0 length =3D=3D 2K.
>>     As MM layer can call invalidatepage() with unaligned offset/length,
>>     for cases like truncate_inode_pages_range().
>>     This will make btrfs_invalidatepage() to truncate the whole page wh=
en
>>     we only need to zero part of the page.
>
> I don't think you can ever get offset =3D=3D 0 and length < PAGE_SIZE
> unless this is the last page in the file, the one containing eof, in
> which it's perfectly valid to invalidate the whole page.

You're right.

After more testing, it indeed shows except setsize call which could pass
unaligned range, all other call sites are using sector aligned ranges.

Thus the existing code won't cause any problem for current code base.

Either we're invalidating the last page of the inode, or we're
invalidating sector (PAGE) aligned range.


But for subpage support, we can have cases like
btrfs_punch_hole_lock_range() which only passes sector aligned range in,
and since sector size is smaller than page size, we can have offset =3D=3D=
 0
while length < PAGE_SIZE and it's not the last page.

Further more, the page can have dirty range not covered by the
invalidatepage range, causing the problem.

I'll update the commit message to explain the case more, and only put
the fix into the subpage series, other than sending it out without
subpage context.

>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 23 ++++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index eb493fbb65f9..872c5309b4ca 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -8180,7 +8180,7 @@ static void btrfs_invalidatepage(struct page *pag=
e, unsigned int offset,
>>          int inode_evicting =3D inode->vfs_inode.i_state & I_FREEING;
>>          bool cleared_private2;
>>          bool found_ordered =3D false;
>> -       bool completed_ordered =3D false;
>> +       bool incompleted_ordered =3D false;
>>
>>          /*
>>           * we have the page locked, so new writeback can't start,
>> @@ -8191,7 +8191,13 @@ static void btrfs_invalidatepage(struct page *pa=
ge, unsigned int offset,
>>           */
>>          wait_on_page_writeback(page);
>>
>> -       if (offset) {
>> +       /*
>> +        * The range doesn't cover the full page, just let btrfs_releas=
epage() to
>> +        * check if we can release the extent mapping.
>> +        * Any locked/pinned/logged extent map would prevent us freeing=
 the
>> +        * extent mapping.
>> +        */
>> +       if (!(offset =3D=3D 0 && length =3D=3D PAGE_SIZE)) {
>>                  btrfs_releasepage(page, GFP_NOFS);
>>                  return;
>>          }
>> @@ -8208,9 +8214,10 @@ static void btrfs_invalidatepage(struct page *pa=
ge, unsigned int offset,
>>                  end =3D min(page_end,
>>                            ordered->file_offset + ordered->num_bytes - =
1);
>>                  /*
>> -                * IO on this page will never be started, so we need to=
 account
>> -                * for any ordered extents now. Don't clear EXTENT_DELA=
LLOC_NEW
>> -                * here, must leave that up for the ordered extent comp=
letion.
>> +                * IO on this ordered extent will never be started, so =
we need
>> +                * to account for any ordered extents now. Don't clear
>
> So this comment update states that "IO on this ordered extent will
> never be started".
> That is not true, unless some other patch not in misc-next changed
> something and I missed it (like splitting ordered extents).
>
> If you have a 1M ordered extent, for file range [0, 1M[ for example,
> and then truncate the file to 512K or punch a hole for the range
> [512K, 1M[, then IO for the first 512K of the ordered extent is still
> done.
>
> So I think what you wanted to say is more like "IO for this subpage
> will never be started ...".

This is indeed much better.

>
>> +                * EXTENT_DELALLOC_NEW here, must leave that up for the
>> +                * ordered extent completion.
>>                   */
>>                  if (!inode_evicting)
>>                          clear_extent_bit(tree, start, end,
>> @@ -8234,7 +8241,8 @@ static void btrfs_invalidatepage(struct page *pag=
e, unsigned int offset,
>>                                                             start,
>>                                                             end - start=
 + 1, 1)) {
>>                                  btrfs_finish_ordered_io(ordered);
>> -                               completed_ordered =3D true;
>> +                       } else {
>> +                               incompleted_ordered =3D true;
>>                          }
>>                  }
>>
>> @@ -8276,7 +8284,7 @@ static void btrfs_invalidatepage(struct page *pag=
e, unsigned int offset,
>>                   * is cleared if we don't delete, otherwise it can lea=
d to
>>                   * corruptions if the i_size is extented later.
>>                   */
>> -               if (found_ordered && !completed_ordered)
>> +               if (found_ordered && incompleted_ordered)
>
> I find this naming, "incompleted_ordered" confusing, I think
> "incompleted" is not even a valid english word.
>
> What you mean is that if there is some ordered extent for the page
> range that we could not complete ourselves.
> I would suggest naming it to "completed_all_ordered", initialize it to
> true and then set it to false when we can't complete an ordered extent
> ourselves.
>
> Then it would just be "if (found_ordered && !completed_all_ordered)
> delete =3D false;".
>
> Also, I haven't checked the other patchsets for subpage support, but
> from looking only at this patchset, I'm assuming we can't set ranges
> in the io tree smaller than page size, is that correct?
> Otherwise this would be calling clear_extent_bit for each subpage range.

For current subpage implementation, we have to support sector aligned
writeback.

The requirement comes from data balance, we have to be able to write new
data extents exactly the same size as the originals.

Thus here we support range smaller than page size for subpage.
The extent io tree itself can support it without problem.

Thanks,
Qu
>
> Thanks.
>
>>                          delete =3D false;
>>                  clear_extent_bit(tree, page_start, page_end, EXTENT_LO=
CKED |
>>                                   EXTENT_DELALLOC | EXTENT_UPTODATE |
>> @@ -8286,6 +8294,7 @@ static void btrfs_invalidatepage(struct page *pag=
e, unsigned int offset,
>>                  __btrfs_releasepage(page, GFP_NOFS);
>>          }
>>
>> +       ClearPagePrivate2(page);
>>          ClearPageChecked(page);
>>          clear_page_extent_mapped(page);
>>   }
>> --
>> 2.29.2
>>
>
>
