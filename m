Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B333BA32E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhGBQbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 12:31:40 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:36765 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBQbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Jul 2021 12:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1625243345;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=XdOQ12a7RoAYzpnXVzikCYY+yQa4UvshgpIvFhBYY1c=;
        b=Kbao4+S2DlDj4yr6af2a7OfaeMzUUsBcqE/WIECTQvHNN4nV8Z9vy3fYhqtWSs67
        GZYidk3QJa61xxZQqk7dLuV2QvUld/DTv4sgLPfaSJuEqdpQnGzIYbkXGOFa+Jb65ke
        OdNMd0XzX3UhEERjA22pLQ1wPCElYR9K8CGfLa+I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1625243345;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=XdOQ12a7RoAYzpnXVzikCYY+yQa4UvshgpIvFhBYY1c=;
        b=L1boZp/o7DDGiBa3FiIX1hsMZ0sEgqQhoSUfRGcu6wwn6kGLCdJ3hEiAGz3xsN97
        slnb/LQ8B8eFmnacV4HBEIVF7LIx8bATTsBoinXvsA1ql/slNA05pXVjNoIvYdhFt1Y
        eqj8+uwbqJfQnvIrJlNye7jLsCOhQShFu8QcAzaM=
Subject: Re: IO failure without other (device) error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
 <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
 <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
 <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017a680d637c-4a958f96-dd8b-433d-84a6-8fc6a84abf47-000000@eu-west-1.amazonses.com>
Date:   Fri, 2 Jul 2021 16:29:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.07.02-54.240.4.2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.07.2021 00:19 Qu Wenruo wrote:
>
>
> On 2021/7/2 上午1:25, Martin Raiber wrote:
>> On 01.07.2021 03:40 Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/1 上午2:40, Martin Raiber wrote:
>>>> On 18.06.2021 18:18 Martin Raiber wrote:
>>>>> On 10.05.2021 00:14 Martin Raiber wrote:
>>>>>> I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:
>>>>>>
>>>>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
>>>>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
>>>>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>>>>
>>>>>> This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).
>>>>> Just got it again (5.10.43). So I guess the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each location?
>>>>>
>>>> Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer_pages (this time), this part before unlock_exit:
>>>
>>> Well, this is quite different from your initial report.
>>>
>>> Your initial report is EIO in btrfs_finish_ordered_io(), which happens
>>> after all data is written back to disk.
>>>
>>> But in this particular case, it happens before we submit the data to disk.
>>>
>>> In this case, we search csum tree first, to find the csum for the range
>>> we want to read, before submit the read bio.
>>>
>>> Thus they are at completely different path.
>> Yes it fails to read the csum, because read_extent_buffer_pages returns -EIO. I made the, I think, reasonable assumption that there is only one issue in btrfs where -EIO happens without an actual IO error on the underlying device. The original issue has line numbers that point at btrfs_csum_file_blocks which calls btrfs_lookup_csum which is in the call path of this issue. Can't confirm it's the same issue because the original report didn't have the WARN_ONs in there, so feel free to treat them as separate issues.
>>>
>>>>
>>>>       for (i = 0; i < num_pages; i++) {
>>>>           page = eb->pages[i];
>>>>           wait_on_page_locked(page);
>>>>           if (!PageUptodate(page))
>>>>               -->ret = -EIO;
>>>>       }
>>>>
>>>> Complete dmesg output. In this instance it seems to not be able to read a csum. It doesn't go read only in this case... Maybe it should?
>>>>
>>>> [Wed Jun 30 10:31:11 2021] kernel log
>>>
>>> For this particular case, btrfs first can't find the csum for the range
>>> of read, and just left the csum as all zeros and continue.
>>>
>>> Then the data read from disk will definitely cause a csum mismatch.
>>>
>>> This normally means a csum tree corruption.
>>>
>>> Can you run btrfs-check on that fs?
>>
>> It didn't "find" the csum because it has an -EIO error reading the extent where the csum is supposed to be stored. It is not a csum tree corruption because that would cause different log messages like transid not matching or csum of tree nodes being wrong, I think.
>
> Yes, that's what I expect, and feel strange about.
>
>>
>> Sorry, the file is long deleted. Scrub comes back as clean and I guess the -EIO error causing the csum read failure was only transient anyway.
>>
>> I'm not sufficiently familiar with btrfs/block device/mm subsystem obviously but here is one guess what could be wrong.
>>
>> It waits for completion for the read of the extent buffer page like this:
>>
>> wait_on_page_locked(page);
>> if (!PageUptodate(page))
>>      ret = -EIO;
>>
>> while in filemap.c it reads a page like this:
>>
>> wait_on_page_locked(page);
>> if (PageUptodate(page))
>>      goto out;
>> lock_page(page);
>> if (!page->mapping) {
>>          unlock_page(page);
>>          put_page(page);
>>          goto repeat;
>> }
>
> Yes, that what we do for data read path, as each time a page get
> unlocked, we can get page invalidator trigger for the page, and when we
> re-lock the page, it may has been invalidated.
>
> Although above check has been updated to do extra check including
> page->mapping and page->private check to be extra sure.
>
>> /* Someone else locked and filled the page in a very small window */
>> if (PageUptodate(page)) {
>>          unlock_page(page);
>>          goto out;
>>
>> }
>>
>> With the comment:
>>
>>> /*
>>> * Page is not up to date and may be locked due to one of the following
>>> * case a: Page is being filled and the page lock is held
>>> * case b: Read/write error clearing the page uptodate status
>>> * case c: Truncation in progress (page locked)
>>> * case d: Reclaim in progress
>>> *  [...]
>>> */
>> So maybe the extent buffer page gets e.g. reclaimed in the small window between unlock and PageUptodate check?
>
> But for metadata case, unlike data path, we have very limited way to
> invalidate/release a page.
>
> Unlike data path, metadata page uses it page->private as pointer to
> extent buffer.
>
> And each time we want to drop a metadata page, we can only do that if
> the extent buffer owning the page can be removed from the extent buffer
> cache.
>
> Thus a unlock metadata page get released halfway is not expected
> behavior at all.
I see. It mainly checks extent_buffer->refs and it increments that after allocating/finding the extent... No further idea what could be the problem...
>
>>
>> Another option is case b (read/write error), but the NVMe/dm subsystem doesn't log any error for some reason.
>
> I don't believe that's the case neither, or we should have csum mismatch
> report from btrfs.
>
>>
>> I guess I could add the lock and check for mapping and PageError(page) to narrow it down further?
>>
> If you have a proper way to reproduce the bug reliable, I could craft a
> diff for you to debug (with everything output to ftrace buffer to debug)

Unfortunately I can't reproduce it and it is really rare. I could add further output at that location. E.g. checking for mapping presence if the page has an error or if it was submitted for read or was Uptodate before?

For now I'll just extent the retry logic in btree_read_extent_buffer_pages to try the same mirror multiple times (The problematic btrfs filesystems have single metadata). That should do it as work-around.

