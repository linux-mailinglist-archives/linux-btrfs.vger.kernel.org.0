Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22D23620DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbhDPN1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbhDPN1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:27:13 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE1C061756
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:26:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 18so7335021qtz.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=u/EIxSahJc2UaAoAAlBWc4BtjsUnpKJHZwezT72iy+I=;
        b=w+/F7HmO95g7UghPpSToITLv4Qq7EpKnlnmJzELzdrL0YEqCInOn4VjgGvpeZPDxOp
         pLpcoWMujWPWOsPsc9KHiP+oVHQyuQujRRtu1XNxKHcLZeQnP3K1BP+14dwUiB4GsPPT
         qfaHYEguCxxsQAUQ/1KjobLqtN4kUi4hzDiJXb7uPCnm6ME1VkdSHxv+yHsp22TNZR9y
         ycbJ3pXFMDj4jkR1JDX6A9PS7yyC80MGUpr7UDDT4aja04oAUavMitgDITmT2Ew9URcN
         8nO1RDTNVGkriCR2ZnuJ5A2hp3/gDyeaojWEWlfT7ardUKyt0tzMuRhJM0vIaeVrXLEv
         krWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/EIxSahJc2UaAoAAlBWc4BtjsUnpKJHZwezT72iy+I=;
        b=b9LkA+ZAv9l9YhaNd0eHeQa/8nOfrPoM5yxC5lkNgjr2U5Q4Rg5sp9orDyWaNDzwL/
         6at3+0ZT0OL3mBwvjOTbtVJfbP7PiXMM3ZrPszyWFTEVhQS/BmKHFdF53ngykHEF/h8P
         TjiVmX1sphA5+aC3wdlCriM473EWfVmF3lF9Ico72NOGymcYo0FYN2xu9yq59J7rPx1a
         BD2tBA9pnotczBwHrO5XCubprnfx2rRndmDOn3r/kVMKfxJYcbP3ngZwxKZjWhk4axWD
         Egd31u/W1ObBQpH1qVBF7k5duF+K74NkuYPAa+eSP9FuyuHunfy7xAeUXdlDgtsY9wwE
         6iNA==
X-Gm-Message-State: AOAM531FspMoO83/v9g9TCHpjtrlPSfDb2gD+n/U7nrWjYS3AQfBsf6v
        xQgEHkUtxXbaV3TqFOREkP48Db2MwK/JyQ==
X-Google-Smtp-Source: ABdhPJxnkVm9ZC6Az7Rm35oNIS9PwZW4v6FPZl1OTuvb4a9u1lnVE1AnWqbXjL8kXmo7frdOLOK2eA==
X-Received: by 2002:ac8:71d8:: with SMTP id i24mr7777300qtp.41.1618579607768;
        Fri, 16 Apr 2021 06:26:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b83sm4177984qkc.97.2021.04.16.06.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:26:47 -0700 (PDT)
Subject: Re: [PATCH 02/42] btrfs: introduce write_one_subpage_eb() function
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-3-wqu@suse.com>
 <7cff2211-b74a-647e-12f5-fb5994d9f3f0@toxicpanda.com>
 <a442f0df-d4d7-50ca-e4c3-224200ef9a70@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fcff95f0-c436-01c3-90b9-88fe659810cd@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:26:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <a442f0df-d4d7-50ca-e4c3-224200ef9a70@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 7:25 PM, Qu Wenruo wrote:
> 
> 
> On 2021/4/16 上午3:03, Josef Bacik wrote:
>> On 4/15/21 1:04 AM, Qu Wenruo wrote:
>>> The new function, write_one_subpage_eb(), as a subroutine for subpage
>>> metadata write, will handle the extent buffer bio submission.
>>>
>>> The major differences between the new write_one_subpage_eb() and
>>> write_one_eb() is:
>>> - No page locking
>>>    When entering write_one_subpage_eb() the page is no longerlocked.
>>>    We only lock the page for its status update, and unlock immediately.
>>>    Now we completely rely on extent io tree locking.
>>>
>>> - Extra bitmap update along with page status update
>>>    Now page dirty and writeback is controlled by
>>>    btrfs_subpage::dirty_bitmap and btrfs_subpage::writeback_bitmap.
>>>    They both follow the schema that any sector is dirty/writeback, then
>>>    the full page get dirty/writeback.
>>>
>>> - When to update the nr_written number
>>>    Now we take a short cut, if we have cleared the last dirtybit of the
>>>    page, we update nr_written.
>>>    This is not completely perfect, but should emulate the oldbehavior
>>>    good enough.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 55 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 21a14b1cb065..f32163a465ec 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -4196,6 +4196,58 @@ static void
>>> end_bio_extent_buffer_writepage(struct bio *bio)
>>>       bio_put(bio);
>>>   }
>>> +/*
>>> + * Unlike the work in write_one_eb(), we rely completely on extent
>>> locking.
>>> + * Page locking is only utizlied at minimal to keep the VM code happy.
>>> + *
>>> + * Caller should still call write_one_eb() other than this function
>>> directly.
>>> + * As write_one_eb() has extra prepration before submitting the
>>> extent buffer.
>>> + */
>>> +static int write_one_subpage_eb(struct extent_buffer *eb,
>>> +                struct writeback_control *wbc,
>>> +                struct extent_page_data *epd)
>>> +{
>>> +    struct btrfs_fs_info *fs_info = eb->fs_info;
>>> +    struct page *page = eb->pages[0];
>>> +    unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
>>> +    bool no_dirty_ebs = false;
>>> +    int ret;
>>> +
>>> +    /* clear_page_dirty_for_io() in subpage helper needpage locked. */
>>> +    lock_page(page);
>>> +    btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
>>> +
>>> +    /* If we're the last dirty bit to update nr_written*/
>>> +    no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
>>> +                              eb->start, eb->len);
>>> +    if (no_dirty_ebs)
>>> +        clear_page_dirty_for_io(page);
>>> +
>>> +    ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc, page,
>>> +            eb->start, eb->len, eb->start - page_offset(page),
>>> +            &epd->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
>>> +            false);
>>> +    if (ret) {
>>> +        btrfs_subpage_clear_writeback(fs_info, page, eb->start,
>>> +                          eb->len);
>>> +        set_btree_ioerr(page, eb);
>>> +        unlock_page(page);
>>> +
>>> +        if (atomic_dec_and_test(&eb->io_pages))
>>> +            end_extent_buffer_writeback(eb);
>>> +        return -EIO;
>>> +    }
>>> +    unlock_page(page);
>>> +    /*
>>> +     * Submission finishes without problem, if no range of the page is
>>> +     * dirty anymore, we have submitted a page.
>>> +     * Update the nr_written in wbc.
>>> +     */
>>> +    if (no_dirty_ebs)
>>> +        update_nr_written(wbc, 1);
>>> +    return ret;
>>> +}
>>> +
>>>   static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>>>               struct writeback_control *wbc,
>>>               struct extent_page_data *epd)
>>> @@ -4227,6 +4279,9 @@ static noinline_for_stack int
>>> write_one_eb(struct extent_buffer *eb,
>>>           memzero_extent_buffer(eb, start, end - start);
>>>       }
>>> +    if (eb->fs_info->sectorsize < PAGE_SIZE)
>>> +        return write_one_subpage_eb(eb, wbc, epd);
>>> +
>>
>> Same comment here, again you're calling write_one_eb() which expects to
>> do the eb thing, but then later have an entirely different path for the
>> subpage stuff, and thus could just call your write_one_subpage_eb()
>> helper from there instead of stuffing it into write_one_eb().
> 
> But there are some common code before calling the subpage routine.
> 
> I don't think it's a good idea to have duplicated code between subpage
> and regular routine.
> 

Ah I missed the part at the top for zero'ing out the buffer.  In that case turn 
that into a helper function and then keep the paths separate.  Thanks,

Josef
