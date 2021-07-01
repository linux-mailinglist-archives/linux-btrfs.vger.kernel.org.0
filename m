Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00FC3B988A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhGAWWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 18:22:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:43935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhGAWWR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 18:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625177985;
        bh=zSZ80HF91K1RkbNsOLW7355e7uUJZr9d+0+tRXyrYyc=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=LzWkpucRPLntwJnTJYEuoqqVtdKeblqYgLmd1vd3ZytTzB8wSPrqqkKgz+O4s/EqO
         rCNmkhjx38eFVy5DR45QMRjTvw7soc9TM1aVFtRIZtdFYOsAF61lyY4KLX/xJ6vqN6
         DZNa9X1s6hqDxASK6BYL/eQ4ZfmeGTzVtIBuNdWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1lCHmU0sCo-014nIb; Fri, 02
 Jul 2021 00:19:45 +0200
To:     Martin Raiber <martin@urbackup.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
 <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
 <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: IO failure without other (device) error
Message-ID: <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
Date:   Fri, 2 Jul 2021 06:19:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:whEuhWbmT8IvFbSSW+A1d24pWX4OUzrUdXvOZV7WgxfIsamH+Vg
 1kv84F3KXmwU/FyQNQlewm1hPE1DHzojSdMIiNx4UOZrol27ptNvku+ZYVu+hwSC42fVGrz
 DFYAVYL28AeLv95riIA8zJzD7rVJJIx5QMpeRh6MeHD9oskQoDZZf8FcdQyg/VT66VB+rU+
 CjWaaVrkihsHHKOgH3mQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/QZMiTq1wg=:O1g1YVg9oMbPBQc2Idz8Qf
 T7fUjvBXKo19GvZyFF9EBSUZRPGswuM2fgrHrMkFe9WYSTaJJytUmetneg7bQsdj+Qhb9NpBf
 ur07AU0UN/XezmT/Xvpf/8p0rYBNoiiXnL6UHWPoPuU/wyvdPJ0u208cN0BKyRYtzBfM6z37r
 sEYbNW1YEoDwiEQjMbveZIB2NUJ0SQLoO8rTlcjo6ztZStsKqI3DLZxNt+S0rjzaR4jXiLOZ2
 lIrI6e2cfjnXibPOEOO4tFsg3uU/PZdxZxHA3NFBoc+ZJRweGqWeRpGvFt+yDRlcm+v0CDUZt
 FSXvUQlCFMsqCdCUYB5hYavIRt6Hv19yC3xCFfR7HWiP9XZjtllbQUdSRSy4FU5uc+FA1WfrQ
 sFBHuhvTe0Iq1EWNBzdx2yWBwsQILrXmdLVvUIR0mE+uRyPXYsT03Uvgx0svjqTw9VN+zVYPK
 +GSwvzfSPKvR4f4d9cEKb3MS3HlXDqNmJAZvZVRH6ALaAXvdCslK3VPa3Da+MOFQz/vMAIB70
 4BinNezOJFW6YsuSOADz9Es0KqY+sOeYEuUC0ijBKKMDs1KnLkNBNe5cnK8cA7F8lAbQGWnOw
 3s11PVjNBsXMfB+hB3iHVek+4J4zRRwlchn+P7zBDPKfsZocnEOuxSDksZcywsh/hXqegQrxl
 d3ovRHEbUgGsjmzzAmMZj3nX5prwWn8AS+eruMGgR3blClubah1VARSfsaWJcHNESPJfXohgm
 SIa3InHwG3RB1H3zgggciLEqT19vC58+iewADooVDQfRZ9Cm2IUX3GK33DfY9lU1YfYAfwQWi
 7H12Et9ltP192L8BtK8kFfosFX2O4pLI5uqZ77hqOIoSrFm+nF1zJI/ku5rrGyvnsoP/+DLu7
 elVIb2Dtavbv7qeNNNhafpDs0ZixkT50D2iO+ToogoG7pRwAacHiQ6gi5GGeQWF33PpRz6e9W
 Upqtw1qUfkhCNcyS1QXzf9DcBc5epwVmLyb+OOKpNKXXD8Jt32YUfGLOuTu82ivACtjEKSG05
 cj5veT2x3+Ayqs7VtWnTwFz0kaCJkvOSLDTOtZ/W8bGKsK87LvyXFVBO05H/Txt/SW6vXM3Ti
 ghW31MSKfFhBdHGGgtG5jQhLWFvpdq29jDHwbLXL/sy4Ejl3L82zLSkJg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/2 =E4=B8=8A=E5=8D=881:25, Martin Raiber wrote:
> On 01.07.2021 03:40 Qu Wenruo wrote:
>>
>>
>> On 2021/7/1 =E4=B8=8A=E5=8D=882:40, Martin Raiber wrote:
>>> On 18.06.2021 18:18 Martin Raiber wrote:
>>>> On 10.05.2021 00:14 Martin Raiber wrote:
>>>>> I get this (rare) issue where btrfs reports an IO error in run_delay=
ed_refs or finish_ordered_io with no underlying device errors being report=
ed. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix o=
r work-arounds for btrfs ENOSPC issues:
>>>>>
>>>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc=
/init.d/exim4' lacks a native systemd unit file. Automatically generating =
a unit file for compatibility. Please update package to include a native s=
ystemd unit file, in order to make it more safe and robust.
>>>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_=
io:2736: errno=3D-5 IO failure
>>>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>>>
>>>>> This issue occured on two different machines now (on one twice). Bot=
h with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (=
where dm-0 is a ceph volume).
>>>> Just got it again (5.10.43). So I guess the question is how can I tra=
ce where this error comes from... The error message points at btrfs_csum_f=
ile_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each=
 location?
>>>>
>>> Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer_p=
ages (this time), this part before unlock_exit:
>>
>> Well, this is quite different from your initial report.
>>
>> Your initial report is EIO in btrfs_finish_ordered_io(), which happens
>> after all data is written back to disk.
>>
>> But in this particular case, it happens before we submit the data to di=
sk.
>>
>> In this case, we search csum tree first, to find the csum for the range
>> we want to read, before submit the read bio.
>>
>> Thus they are at completely different path.
> Yes it fails to read the csum, because read_extent_buffer_pages returns =
-EIO. I made the, I think, reasonable assumption that there is only one is=
sue in btrfs where -EIO happens without an actual IO error on the underlyi=
ng device. The original issue has line numbers that point at btrfs_csum_fi=
le_blocks which calls btrfs_lookup_csum which is in the call path of this =
issue. Can't confirm it's the same issue because the original report didn'=
t have the WARN_ONs in there, so feel free to treat them as separate issue=
s.
>>
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 page =3D eb->pages[i];
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 wait_on_page_locked(page)=
;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!PageUptodate(page))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 -->ret=
 =3D -EIO;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> Complete dmesg output. In this instance it seems to not be able to rea=
d a csum. It doesn't go read only in this case... Maybe it should?
>>>
>>> [Wed Jun 30 10:31:11 2021] kernel log
>>
>> For this particular case, btrfs first can't find the csum for the range
>> of read, and just left the csum as all zeros and continue.
>>
>> Then the data read from disk will definitely cause a csum mismatch.
>>
>> This normally means a csum tree corruption.
>>
>> Can you run btrfs-check on that fs?
>
> It didn't "find" the csum because it has an -EIO error reading the exten=
t where the csum is supposed to be stored. It is not a csum tree corruptio=
n because that would cause different log messages like transid not matchin=
g or csum of tree nodes being wrong, I think.

Yes, that's what I expect, and feel strange about.

>
> Sorry, the file is long deleted. Scrub comes back as clean and I guess t=
he -EIO error causing the csum read failure was only transient anyway.
>
> I'm not sufficiently familiar with btrfs/block device/mm subsystem obvio=
usly but here is one guess what could be wrong.
>
> It waits for completion for the read of the extent buffer page like this=
:
>
> wait_on_page_locked(page);
> if (!PageUptodate(page))
>  =C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>
> while in filemap.c it reads a page like this:
>
> wait_on_page_locked(page);
> if (PageUptodate(page))
>  =C2=A0=C2=A0=C2=A0 goto out;
> lock_page(page);
> if (!page->mapping) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unlock_page(page);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 put_page(page);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto repeat;
> }

Yes, that what we do for data read path, as each time a page get
unlocked, we can get page invalidator trigger for the page, and when we
re-lock the page, it may has been invalidated.

Although above check has been updated to do extra check including
page->mapping and page->private check to be extra sure.

> /* Someone else locked and filled the page in a very small window */
> if (PageUptodate(page)) {
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unlock_page(page);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto out;
>
> }
>
> With the comment:
>
>> /*
>> * Page is not up to date and may be locked due to one of the following
>> * case a: Page is being filled and the page lock is held
>> * case b: Read/write error clearing the page uptodate status
>> * case c: Truncation in progress (page locked)
>> * case d: Reclaim in progress
>> *
>> * Case a, the page will be up to date when the page is unlocked.
>> * There is no need to serialise on the page lock here as the page
>> * is pinned so the lock gives no additional protection. Even if the
>> * page is truncated, the data is still valid if PageUptodate as
>> * it's a race vs truncate race.
>> * Case b, the page will not be up to date
>> * Case c, the page may be truncated but in itself, the data may still
>> * be valid after IO completes as it's a read vs truncate race. The
>> * operation must restart if the page is not uptodate on unlock but
>> * otherwise serialising on page lock to stabilise the mapping gives
>> * no additional guarantees to the caller as the page lock is
>> * released before return.
>> * Case d, similar to truncation. If reclaim holds the page lock, it
>> * will be a race with remove_mapping that determines if the mapping
>> * is valid on unlock but otherwise the data is valid and there is
>> * no need to serialise with page lock.
>> *
>> * As the page lock gives no additional guarantee, we optimistically
>> * wait on the page to be unlocked and check if it's up to date and
>> * use the page if it is. Otherwise, the page lock is required to
>> * distinguish between the different cases. The motivation is that we
>> * avoid spurious serialisations and wakeups when multiple processes
>> * wait on the same page for IO to complete.
>> */
> So maybe the extent buffer page gets e.g. reclaimed in the small window =
between unlock and PageUptodate check?

But for metadata case, unlike data path, we have very limited way to
invalidate/release a page.

Unlike data path, metadata page uses it page->private as pointer to
extent buffer.

And each time we want to drop a metadata page, we can only do that if
the extent buffer owning the page can be removed from the extent buffer
cache.

Thus a unlock metadata page get released halfway is not expected
behavior at all.

>
> Another option is case b (read/write error), but the NVMe/dm subsystem d=
oesn't log any error for some reason.

I don't believe that's the case neither, or we should have csum mismatch
report from btrfs.

>
> I guess I could add the lock and check for mapping and PageError(page) t=
o narrow it down further?
>
If you have a proper way to reproduce the bug reliable, I could craft a
diff for you to debug (with everything output to ftrace buffer to debug)

Thanks,
Qu
