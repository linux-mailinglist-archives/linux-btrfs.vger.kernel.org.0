Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE33BA60D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jul 2021 00:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGBWtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 18:49:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:41945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233350AbhGBWtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Jul 2021 18:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625265993;
        bh=9uSNEwfOAig3kQU4xhBjXHa1y3JxyCvkPxGBO6+QKEs=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=bF78y9wD6YPMNqH1UBxw/Y/gvOoz6JwCi0KkXCqHEJCStusE7PC+Oh89xCD4FCArf
         nKLMerYO7XpstdYCaHSEI1ApB6TWeDu3IlXlUF8msK2Cc+6l3BIO7N9qI4Y91eZ9au
         W93vfO8UfK3or0kSRH34l0w1H59qGKGmmGQO7xes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mof9F-1lS43t1QQD-00p6pD; Sat, 03
 Jul 2021 00:46:33 +0200
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
 <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
 <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
 <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
 <0102017a680d637c-4a958f96-dd8b-433d-84a6-8fc6a84abf47-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: IO failure without other (device) error
Message-ID: <a5357b44-6c1c-3174-a76c-09f01802386a@gmx.com>
Date:   Sat, 3 Jul 2021 06:46:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0102017a680d637c-4a958f96-dd8b-433d-84a6-8fc6a84abf47-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:41zb8gVxen2a1UpIklfZYRJ/bDfKA4Aq2aWvEBU1D3wsnHbuauW
 fXUyB03pDuM4Fjey+V0yKLEOXdIlpOpe/0Ck+MYE/u7G5rpz/TdL/zqo67Bv6KSuasFRUio
 e4yzQUr32pKd/AX9ifkMYWEgWkReZCEb6fxqzEJuY47OpZBrw2UAcZbjLI7bheH1qPhaQIy
 LDkNX+1UB6XqZXUosUinw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NPdpqHC0i7o=:R3ZvNRIpCWoiYbKUcIqM0m
 y0WMkJrTHQXVxxmGf8cmDX3A5juL8yV3S1BFfH0kbzQb4cu9tK1fyQJck38a7Iw7sh4gOkUjY
 Wf2/9RUxQMwmHwwcRgFUaIPWJLRKVsloV3/Wjn8HQIjAzTLoro3JJwaJaX58PzX6IMN7fVerI
 QkuaGsk19DWGBkFtsJD8I1dVF0UKYrL6FS6NQz3yOGIguaQeEUhzw9PG19wNgN0W6XaMM90iy
 GWOh5J5zkkf545HOuBDHBYIEPC076FAoDiuUwlHuM1jUtnpVjDJCyYqF/TWMenT1uM6JFsiKh
 rsXTwW+M1S8MBqNeLjdODHhCt8lwGUH7u/QIymWOC2aCcnKqUL2ZJzNrWA+Za0nZ4DSe9nkrr
 N22XERpcp1k7D5hRJPKYufxaecY/yTV4HqhcS4MhDiIyN0HucLm0KJ4B2vKqcO+a6+rBCXWae
 wi151sbrnvpgZJoHOZ76ixndtZOJVyBDUT4N9y16gofCLO50ACSNPkJFp49Yw4Bl9GHNzYvjk
 iEelvBa/1WQfV4gN5jHHgEqvzB5buzLojhV9Hm6OSJriVqB4hCOlvoLr6KSeZ2jTJA2kGmKVT
 TeDksCBknqDZL1bxkCrB1tohE5sp6dHAoD2IlWHw1wHGtwImhA8eO9EQFZKIq1QgyLgYLjKcU
 PynvwAExJHyxZAHYCDXb040/fAd/7ZTfqw8eoNP6gBWSg9XTrXEQWKonZIYIfhfJcTd0dAEKb
 oM0RUBhPnlUTnO/XYIAEXDLTOF8TXkDT2ZMs8jnBcBxBxAxaSkoGOt3Frrwo02ZxFOD0XyWtj
 RECkMNBcfVOmartVpZN5eZyMqpCKgTcshgqOAVpSC1eqPCszK0DnC8a3ekhTLYZbH+p4KXVt7
 ZqES8Fk49QKSekfyKc3+I0kYhTd4XyohoXr7sQNas9m0rdO0JaAVex4fPAzR0CKII8bR1dyc3
 Wq17cREAb25LdCHNyT+KRxha6/Q7OQiusp0aPSSk9bsU05+kh3yN1b8945UsPzc1QBQomGIv3
 1oKJo9x3JuV6b/l6WPEY5QPf9+vIDqHp51Asb6ZgpzZYMGZPjftF8x0HtPN+OAIzyNhy+ZXV4
 0wXJ9BfuVW6JxIdPXYjOUCm2y7oC2h7aesqdRb8oAcnF5mkjBkZ3bEY9g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/3 =E4=B8=8A=E5=8D=8812:29, Martin Raiber wrote:
> On 02.07.2021 00:19 Qu Wenruo wrote:
>>
>>
>> On 2021/7/2 =E4=B8=8A=E5=8D=881:25, Martin Raiber wrote:
>>> On 01.07.2021 03:40 Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/7/1 =E4=B8=8A=E5=8D=882:40, Martin Raiber wrote:
>>>>> On 18.06.2021 18:18 Martin Raiber wrote:
>>>>>> On 10.05.2021 00:14 Martin Raiber wrote:
>>>>>>> I get this (rare) issue where btrfs reports an IO error in run_del=
ayed_refs or finish_ordered_io with no underlying device errors being repo=
rted. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix=
 or work-arounds for btrfs ENOSPC issues:
>>>>>>>
>>>>>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/e=
tc/init.d/exim4' lacks a native systemd unit file. Automatically generatin=
g a unit file for compatibility. Please update package to include a native=
 systemd unit file, in order to make it more safe and robust.
>>>>>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordere=
d_io:2736: errno=3D-5 IO failure
>>>>>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>>>>>
>>>>>>> This issue occured on two different machines now (on one twice). B=
oth with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM=
 (where dm-0 is a ceph volume).
>>>>>> Just got it again (5.10.43). So I guess the question is how can I t=
race where this error comes from... The error message points at btrfs_csum=
_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at ea=
ch location?
>>>>>>
>>>>> Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer=
_pages (this time), this part before unlock_exit:
>>>>
>>>> Well, this is quite different from your initial report.
>>>>
>>>> Your initial report is EIO in btrfs_finish_ordered_io(), which happen=
s
>>>> after all data is written back to disk.
>>>>
>>>> But in this particular case, it happens before we submit the data to =
disk.
>>>>
>>>> In this case, we search csum tree first, to find the csum for the ran=
ge
>>>> we want to read, before submit the read bio.
>>>>
>>>> Thus they are at completely different path.
>>> Yes it fails to read the csum, because read_extent_buffer_pages return=
s -EIO. I made the, I think, reasonable assumption that there is only one =
issue in btrfs where -EIO happens without an actual IO error on the underl=
ying device. The original issue has line numbers that point at btrfs_csum_=
file_blocks which calls btrfs_lookup_csum which is in the call path of thi=
s issue. Can't confirm it's the same issue because the original report did=
n't have the WARN_ONs in there, so feel free to treat them as separate iss=
ues.
>>>>
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 page =3D eb->page=
s[i];
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 wait_on_page_lock=
ed(page);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!PageUptodate=
(page))
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 -->ret =3D -EIO;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> Complete dmesg output. In this instance it seems to not be able to r=
ead a csum. It doesn't go read only in this case... Maybe it should?
>>>>>
>>>>> [Wed Jun 30 10:31:11 2021] kernel log
>>>>
>>>> For this particular case, btrfs first can't find the csum for the ran=
ge
>>>> of read, and just left the csum as all zeros and continue.
>>>>
>>>> Then the data read from disk will definitely cause a csum mismatch.
>>>>
>>>> This normally means a csum tree corruption.
>>>>
>>>> Can you run btrfs-check on that fs?
>>>
>>> It didn't "find" the csum because it has an -EIO error reading the ext=
ent where the csum is supposed to be stored. It is not a csum tree corrupt=
ion because that would cause different log messages like transid not match=
ing or csum of tree nodes being wrong, I think.
>>
>> Yes, that's what I expect, and feel strange about.
>>
>>>
>>> Sorry, the file is long deleted. Scrub comes back as clean and I guess=
 the -EIO error causing the csum read failure was only transient anyway.
>>>
>>> I'm not sufficiently familiar with btrfs/block device/mm subsystem obv=
iously but here is one guess what could be wrong.
>>>
>>> It waits for completion for the read of the extent buffer page like th=
is:
>>>
>>> wait_on_page_locked(page);
>>> if (!PageUptodate(page))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>>
>>> while in filemap.c it reads a page like this:
>>>
>>> wait_on_page_locked(page);
>>> if (PageUptodate(page))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> lock_page(page);
>>> if (!page->mapping) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unlock_page(page);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 put_page(page);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto repeat;
>>> }
>>
>> Yes, that what we do for data read path, as each time a page get
>> unlocked, we can get page invalidator trigger for the page, and when we
>> re-lock the page, it may has been invalidated.
>>
>> Although above check has been updated to do extra check including
>> page->mapping and page->private check to be extra sure.
>>
>>> /* Someone else locked and filled the page in a very small window */
>>> if (PageUptodate(page)) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unlock_page(page);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto out;
>>>
>>> }
>>>
>>> With the comment:
>>>
>>>> /*
>>>> * Page is not up to date and may be locked due to one of the followin=
g
>>>> * case a: Page is being filled and the page lock is held
>>>> * case b: Read/write error clearing the page uptodate status
>>>> * case c: Truncation in progress (page locked)
>>>> * case d: Reclaim in progress
>>>> *=C2=A0 [...]
>>>> */
>>> So maybe the extent buffer page gets e.g. reclaimed in the small windo=
w between unlock and PageUptodate check?
>>
>> But for metadata case, unlike data path, we have very limited way to
>> invalidate/release a page.
>>
>> Unlike data path, metadata page uses it page->private as pointer to
>> extent buffer.
>>
>> And each time we want to drop a metadata page, we can only do that if
>> the extent buffer owning the page can be removed from the extent buffer
>> cache.
>>
>> Thus a unlock metadata page get released halfway is not expected
>> behavior at all.
> I see. It mainly checks extent_buffer->refs and it increments that after=
 allocating/finding the extent... No further idea what could be the proble=
m...
>>
>>>
>>> Another option is case b (read/write error), but the NVMe/dm subsystem=
 doesn't log any error for some reason.
>>
>> I don't believe that's the case neither, or we should have csum mismatc=
h
>> report from btrfs.
>>
>>>
>>> I guess I could add the lock and check for mapping and PageError(page)=
 to narrow it down further?
>>>
>> If you have a proper way to reproduce the bug reliable, I could craft a
>> diff for you to debug (with everything output to ftrace buffer to debug=
)
>
> Unfortunately I can't reproduce it and it is really rare. I could add fu=
rther output at that location. E.g. checking for mapping presence if the p=
age has an error or if it was submitted for read or was Uptodate before?
>
> For now I'll just extent the retry logic in btree_read_extent_buffer_pag=
es to try the same mirror multiple times (The problematic btrfs filesystem=
s have single metadata). That should do it as work-around.
>
My recommendation for debugging is to add extra trace_printk() on
btree_releasepage() to see when a metadata page really get freed, and
read_extent_buffer_pages() to see what's the possible race.

Another idea is to add extra debug output in end_bio_extent_readpage()
for metadata pages.

As I'm still wondering if there is something wrong detected by btrfs
module but without any error message.

In that case, we definitely want to add a proper error message.

Finally, it's never a bad idea to run btrfs-check, maybe it can find
some hidden problems.

Thanks,
Qu
