Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90C3058E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhA0Kzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:55:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:51115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236116AbhA0Kxm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611744728;
        bh=wpySErLW0zjX0k/T6YfV37VIAX7hVhNQDZEfURZlA+o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kGwT/MDNyjzNd0AqDdv2fpJQyB+MbXpg/1tIxyJ92NvmLmqRw3XZjPBOaj/Epbx3d
         2KpZ4ETFjQbkyswWU8tLeh1nvs6RsNwojb5JlNGRG/NWQ326YZdEP9vTGzTCCWMrHW
         e+UkWnr5x3Us1x8S4AzbwFatYOhwTT3Li3qgnN+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1lbbGo1KcT-00gG9u; Wed, 27
 Jan 2021 11:52:07 +0100
Subject: Re: [PATCH] btrfs: fix a bug that btrfs_invalidapge() can double
 account ordered extent for subpage
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210127063848.72528-1-wqu@suse.com>
 <CAL3q7H4kBWVewu8-yof-xzEZ1q24Xrz_h7hZHrOPEj_=9Lh1zA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d4a1aae2-6941-0e7b-fbd4-30d28d58b6f5@gmx.com>
Date:   Wed, 27 Jan 2021 18:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4kBWVewu8-yof-xzEZ1q24Xrz_h7hZHrOPEj_=9Lh1zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3H2LPnsMUFMPhxrdVJs10WawR10dSEVJ6387CmmRDw6GVNLkZlY
 SBZNzwr5D3XjIrCN75YUKt0LZpsSaRdZRuvSr4iR6T9K8b+eWmAja5jEAfS59iUN/G9BsoI
 R0PkdVR7Yw1XcmZWPyo7eVvxY5abpYwpLILY+xLykO+trZxLG+exQAOuQt8//p6rhIVQU7M
 hw5ljBOH0ztcWo+SIdHjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aS7Juk4XpcU=:uErtYT2GHn+obDgPAhgRPM
 EZXlR53INLSUf2bccZiQxLtsCtUSNYvF7pL7I53a6goxWrRA3Nw8eI44BCV+eDLowovCo1FGv
 sAUIDCm+Mg84qpH97XH9ea/MJFu5JFjzBp3JsKv3WTmj/A22/PPgmmSbPFsRJoTXdaHmY1nbB
 iiYi98XTzh1YgGkbURXoCQ5YipiCDa4C3bxZ9V+UCSgtYPx1MvOa2yihJJyiIJsxOjFB/xNZ5
 HuIbWhyE+kS8AfUNDawF3TDu7IbMeDUsGSwVw8zk5Us/t6C3GujGv6zROG/tmuPEUbnpuMis0
 BQgQkD/TF8aDwmNFQBRjWl7F9mUMB63egVIcql+FLqh9TvZmhyCPLkCe+zFuZL5dFB3BGocUD
 cktEKK5tdWKIPiBptGSoVqNM4QM/0CzYFCNvJ8DiafaJmIVfNn5eqsIKLyWzWq7ZP2CRXij9g
 2PPavlOwQqnut309fiv01BCl0V2/Q1fIYO3c1hYAP7Xp3YP0k69O9Sd3jS6qeT0kcGxBb8Cme
 JRflaIN1LJDzkq1B8vDqcM6IkqqrhryyIUjOXc07blJmb58Eu6MeKTqDpgMObAq+nzwaFCI8R
 nBkHFQLme1jp1q66BLK/BcOVJ3pRTHmIGw/Jq0yX8Ar6LvOBB+4Ib7oiz8yqNhXHgJF5t6QrE
 IWrGgDmzQ1jQIYL9wSfJJr8hqXL/8x6hf+ozq/w3Q/I/doV005fKWLp1LbcHxJpuIaCrYE7hN
 p5bEQ8leeV0IrBnDJ527Zi+RbEbGP1sUxfoZ7X4ierAN97l7tBLh7kWqnQ8xjU+UynqbWvIBQ
 yzw2dEdBo96UuudG9ukPxoX7nXtipBh/u3ym+MyVlT9x7T+/mDAIT6WF4VHvWiXjQXYKOu4Af
 dIdN/hJ8GCzk9xuDznPA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/27 =E4=B8=8B=E5=8D=886:44, Filipe Manana wrote:
> On Wed, Jan 27, 2021 at 8:29 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Commit dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could
>> span across a page") make btrfs_invalidapage() to search all ordered
>> extents.
>>
>> The offending code looks like this:
>>
>> again:
>>          start =3D page_start;
>>          ordered =3D btrfs_lookup_ordered_range(inode, start, page_end =
- start + 1);
>>          if (ordred) {
>>                  end =3D min(page_end,
>>                            ordered->file_offset + ordered->num_bytes - =
1);
>>
>>                  /* Do the cleanup */
>>
>>                  start =3D end + 1;
>>                  if (start < page_end)
>>                          goto again;
>>          }
>>
>> The behavior is indeed necessary for the incoming subpage support, but
>> when it iterate through all the ordered extents, it also resets the
>> search range @start.
>>
>> This means, for the following cases, we can double account the ordered
>> extents, causing its bytes_left underflow:
>>
>>          Page offset
>>          0               16K             32K
>>          |<--- OE 1  --->|<--- OE 2 ---->|
>>
>> As the first iteration will find OE 1, which doesn't cover the full
>> page, thus after cleanup code, we need to retry again.
>> But again label will reset start to page_start, and we got OE 1 again,
>> which causes double account on OE1, and cause OE1's byte_left to
>> underflow.
>>
>> The only good news is, this problem can only happen for subpage case, a=
s
>> for regular sectorsize =3D=3D PAGE_SIZE case, we will always find a OE =
ends
>> at or after page end, thus no way to trigger the problem.
>>
>> This patch will move the again label after start =3D page_start, to fix
>> the bug.
>> This is just a quick fix, which is easy to backport.
>
> Hum? Why does it need to be backported?
> There are no kernel releases that support subpage sector size yet and
> this does not affect the case where sector size is the same as the
> page size.


Hmmm, right, there is no need to backport.

Hopes David can remove that line when merging.

Thanks,
Qu

>
>>
>> There will be more comprehensive rework to convert the open coded loop =
to
>> a proper while loop.
>>
>> Fixes: dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could =
span across a page")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Anyway, it looks good to me, thanks.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
>> ---
>>   fs/btrfs/inode.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index ef6cb7b620d0..2eea7d22405a 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -8184,8 +8184,9 @@ static void btrfs_invalidatepage(struct page *pag=
e, unsigned int offset,
>>
>>          if (!inode_evicting)
>>                  lock_extent_bits(tree, page_start, page_end, &cached_s=
tate);
>> -again:
>> +
>>          start =3D page_start;
>> +again:
>>          ordered =3D btrfs_lookup_ordered_range(inode, start, page_end =
- start + 1);
>>          if (ordered) {
>>                  found_ordered =3D true;
>> --
>> 2.30.0
>>
>
>
