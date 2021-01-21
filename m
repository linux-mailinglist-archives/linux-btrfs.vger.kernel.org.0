Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3612FE166
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 06:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbhAUDrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 22:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392194AbhAUBjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 20:39:55 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED01C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 17:28:57 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c12so506558qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 17:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dzA5x2BQcwui1LqdBt7FwPcWJRnAgQkx0oMeMjK8ZSc=;
        b=UBtxCVmmW90m84j6R6Rm+XDCJPPcWijt62pkrpqTteITZn8JLSP7ltdWMponNpgH8H
         3cwrqwByaIp1MywJn1AvUqYJaujyONKUCeo8dbGlJiS+wN4hqpTAMazY5A0uyQl+yAgG
         eS+ucwan0tjB+Ru3KWzReAB3Z2Tdq+lQyh8q3gPrhHSMht7ilZe57KnKXtHLgEKZ6wr9
         yWP3dypHiMstnzMgSmWm/L3AkQckuyaQ3XZiXrw3cxSY07ZlcUv78GhcFiSH4KSliVm5
         Ogd+WUI7pGnj9Irb60XAii9vUWCXBgia3pKMdUaGOuAWxRf45qpHxiUSQbUXuB9hdGSX
         1RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzA5x2BQcwui1LqdBt7FwPcWJRnAgQkx0oMeMjK8ZSc=;
        b=QXdP/Mt12T1/Jq+5zNClZGcbiAMVxzJe9HmskyguCIwIF32ZZDdXh8zmI3dflsDQCp
         x6+QjWP9oOWBzliJAgneb0qcMs8mTubKlgsoFGZbU5idReV2mXlz+Q7NGw6QbT30HcZ9
         TE20KmcVZ7QjoNLnZ2ufGHq81+peyO/0uQkvQB19btSxRCGPJ0cDGLQ0x4kgL8thZ+Bl
         I9cTaYYY42ip0X4PkSmMFD2o9jaY1HWQT9RKOKv3QB/+4N7iN0MB+87iR2Q1P1FSV/vj
         Y8mGKgC/t5NYVM5174Im3LTviyDNC7G172J6kf87CK26kdY96vIXOa5kHSjrr4+xCI8h
         nCGA==
X-Gm-Message-State: AOAM531Wra01TL4T82BrnD/C034vTqRTmIxfvsp0vKNxamB88SBfFxWy
        zP7mUm/TTgr1qpdRtRW4q1R1bMtsftdSFOjC
X-Google-Smtp-Source: ABdhPJxWMav9GaOwpItB/C+U1mjK5RSP6Jd4wC4leaoc9LqKnA7QG6hctEIaKGcHKJJe1/PgxWPzQA==
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr11998370qtw.77.1611192535804;
        Wed, 20 Jan 2021 17:28:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::12ee? ([2620:10d:c091:480::1:6f58])
        by smtp.gmail.com with ESMTPSA id c20sm1517678qke.103.2021.01.20.17.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 17:28:54 -0800 (PST)
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
 <812a4f48-3210-926f-cf59-de63bfcc4c0d@toxicpanda.com>
 <3118cc60-2337-49da-648d-aa3b8cdcd70d@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8ae381e9-2645-9b7c-fec0-a79a7a9f382d@toxicpanda.com>
Date:   Wed, 20 Jan 2021 20:28:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3118cc60-2337-49da-648d-aa3b8cdcd70d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/21 7:49 PM, Qu Wenruo wrote:
> 
> 
> On 2021/1/20 下午11:00, Josef Bacik wrote:
>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>> This patch introduce the following functions to handle btrfs subpage
>>> uptodate status:
>>> - btrfs_subpage_set_uptodate()
>>> - btrfs_subpage_clear_uptodate()
>>> - btrfs_subpage_test_uptodate()
>>>    Those helpers can only be called when the range is ensured to be
>>>    inside the page.
>>>
>>> - btrfs_page_set_uptodate()
>>> - btrfs_page_clear_uptodate()
>>> - btrfs_page_test_uptodate()
>>>    Those helpers can handle both regular sector size and subpage without
>>>    problem.
>>>    Although caller should still ensure that the range is inside the page.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/subpage.h | 115 +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 115 insertions(+)
>>>
>>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>>> index d8b34879368d..3373ef4ffec1 100644
>>> --- a/fs/btrfs/subpage.h
>>> +++ b/fs/btrfs/subpage.h
>>> @@ -23,6 +23,7 @@
>>>   struct btrfs_subpage {
>>>       /* Common members for both data and metadata pages */
>>>       spinlock_t lock;
>>> +    u16 uptodate_bitmap;
>>>       union {
>>>           /* Structures only used by metadata */
>>>           bool under_alloc;
>>> @@ -78,4 +79,118 @@ static inline void btrfs_page_end_meta_alloc(struct 
>>> btrfs_fs_info *fs_info,
>>>   int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>>>   void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>>> +/*
>>> + * Convert the [start, start + len) range into a u16 bitmap
>>> + *
>>> + * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
>>> + */
>>> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
>>> +            struct page *page, u64 start, u32 len)
>>> +{
>>> +    int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
>>> +    int nbits = len >> fs_info->sectorsize_bits;
>>> +
>>> +    /* Basic checks */
>>> +    ASSERT(PagePrivate(page) && page->private);
>>> +    ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>>> +           IS_ALIGNED(len, fs_info->sectorsize));
>>> +
>>> +    /*
>>> +     * The range check only works for mapped page, we can
>>> +     * still have unampped page like dummy extent buffer pages.
>>> +     */
>>> +    if (page->mapping)
>>> +        ASSERT(page_offset(page) <= start &&
>>> +            start + len <= page_offset(page) + PAGE_SIZE);
>>> +    /*
>>> +     * Here nbits can be 16, thus can go beyond u16 range. Here we make the
>>> +     * first left shift to be calculated in unsigned long (u32), then
>>> +     * truncate the result to u16.
>>> +     */
>>> +    return (u16)(((1UL << nbits) - 1) << bit_start);
>>> +}
>>> +
>>> +static inline void btrfs_subpage_set_uptodate(struct btrfs_fs_info *fs_info,
>>> +            struct page *page, u64 start, u32 len)
>>> +{
>>> +    struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>>> +    u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&subpage->lock, flags);
>>> +    subpage->uptodate_bitmap |= tmp;
>>> +    if (subpage->uptodate_bitmap == U16_MAX)
>>> +        SetPageUptodate(page);
>>> +    spin_unlock_irqrestore(&subpage->lock, flags);
>>> +}
>>> +
>>> +static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *fs_info,
>>> +            struct page *page, u64 start, u32 len)
>>> +{
>>> +    struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>>> +    u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&subpage->lock, flags);
>>> +    subpage->uptodate_bitmap &= ~tmp;
>>> +    ClearPageUptodate(page);
>>> +    spin_unlock_irqrestore(&subpage->lock, flags);
>>> +}
>>> +
>>> +/*
>>> + * Unlike set/clear which is dependent on each page status, for test all bits
>>> + * are tested in the same way.
>>> + */
>>> +#define DECLARE_BTRFS_SUBPAGE_TEST_OP(name)                \
>>> +static inline bool btrfs_subpage_test_##name(struct btrfs_fs_info *fs_info, \
>>> +            struct page *page, u64 start, u32 len)        \
>>> +{                                    \
>>> +    struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private; \
>>> +    u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len); \
>>> +    unsigned long flags;                        \
>>> +    bool ret;                            \
>>> +                                    \
>>> +    spin_lock_irqsave(&subpage->lock, flags);            \
>>> +    ret = ((subpage->name##_bitmap & tmp) == tmp);            \
>>> +    spin_unlock_irqrestore(&subpage->lock, flags);            \
>>> +    return ret;                            \
>>> +}
>>> +DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
>>> +
>>> +/*
>>> + * Note that, in selftest, especially extent-io-tests, we can have empty
>>> + * fs_info passed in.
>>> + * Thankfully in selftest, we only test sectorsize == PAGE_SIZE cases so far,
>>> + * thus we can fall back to regular sectorsize branch.
>>> + */
>>> +#define DECLARE_BTRFS_PAGE_OPS(name, set_page_func, clear_page_func,    \
>>> +                   test_page_func)                \
>>> +static inline void btrfs_page_set_##name(struct btrfs_fs_info *fs_info,    \
>>> +            struct page *page, u64 start, u32 len)        \
>>> +{                                    \
>>> +    if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {    \
>>> +        set_page_func(page);                    \
>>> +        return;                            \
>>> +    }                                \
>>> +    btrfs_subpage_set_##name(fs_info, page, start, len);        \
>>> +}                                    \
>>> +static inline void btrfs_page_clear_##name(struct btrfs_fs_info *fs_info, \
>>> +            struct page *page, u64 start, u32 len)        \
>>> +{                                    \
>>> +    if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {    \
>>> +        clear_page_func(page);                    \
>>> +        return;                            \
>>> +    }                                \
>>> +    btrfs_subpage_clear_##name(fs_info, page, start, len);        \
>>> +}                                    \
>>> +static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
>>> +            struct page *page, u64 start, u32 len)        \
>>> +{                                    \
>>> +    if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)    \
>>> +        return test_page_func(page);                \
>>> +    return btrfs_subpage_test_##name(fs_info, page, start, len);    \
>>> +}
>>
>> Another thing I just realized is you're doing this
>>
>> btrfs_page_set_uptodate(fs_info, page, eb->start, eb->len);
>>
>> but we default to a nodesize > PAGE_SIZE on x86.  This is fine, because you're 
>> checking fs_info->sectorsize == PAGE_SIZE, which will mean we do the right thing.
>>
>> But what happens if fs_info->nodesize < PAGE_SIZE && fs_info->sectorsize == 
>> PAGE_SIZE?  We by default have fs'es that ->nodesize != ->sectorsize, so 
>> really what we should be doing is checking if len == PAGE_SIZE here, but then 
>> you need to take into account the case that eb->len > PAGE_SIZE.  Fix this to 
>> do the right thing in either of those cases. Thanks,
> 
> Impossible.
> 
> Nodesize must be >= sectorsize.
> 
> As sectorsize is currently the minimal access unit for both data and metadata.
> 

Ok the consider the alternative, we have PAGE_SIZE == 64k, nodesize == 64k and 
sectorsize == 4k, something that's actually allowed.  You're now doing the 
subpage operations on something that won't/shouldn't have the subpage private 
attached to the page.  We need to key off of the right thing, so for metadata we 
need to check ->nodesize, and data we check ->sectorsize, and for these 
accessors you can simply do len >= PAGE_SIZE.  Thanks,

Josef
