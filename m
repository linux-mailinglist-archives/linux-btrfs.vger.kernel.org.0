Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD17225565
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 03:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGTB13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 21:27:29 -0400
Received: from mail.synology.com ([211.23.38.101]:39298 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTB12 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 21:27:28 -0400
Subject: Re: [PATCH] btrfs: fix memory leak for page count
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1595208445; bh=B5Hkt/94u1IyNjsDzPjxG4T2Dd575IRyIpPHwdTSD+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K+wgoAtqJ6e0uzWO5vdOksEl2PkKHAqM1WZfe2zD1JtA7GkDPFkO2bbSyG70pQlu4
         miCblLM3RhAX5r3m8Q3vlJ2K4b0ZgA+pIUW+Aqg0LEDBwqMcJPCgH89InU2OKko6Yf
         vwSy7RBMH4uCSifpvcwUC0gKw9v8/MP9z9YERjxY=
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200717102240.21742-1-robbieko@synology.com>
 <CAL3q7H4+yzwLm6yhSfmSLbh6d00geGQsM-h6TiZzgAQHWT+yiQ@mail.gmail.com>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <86cdd766-3488-20fa-caf9-037b5bd05308@synology.com>
Date:   Mon, 20 Jul 2020 09:27:25 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4+yzwLm6yhSfmSLbh6d00geGQsM-h6TiZzgAQHWT+yiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Filipe Manana 於 2020/7/17 下午8:00 寫道:
> On Fri, Jul 17, 2020 at 11:23 AM robbieko <robbieko@synology.com> wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When lock_delalloc_page, we first lock the page and then
>> check that the page dirty, if the page is not dirty, we
>> will return -EAGAIN but all pages must be freed, otherwise
>> page leak.
> "When lock_delalloc_page" -> When locking pages for delalloc
>
> We check if it's dirty and if the mapping still matches.
>
> Btw, you can make line length closer to 75 characters, it makes things
> a bit more readable.
>
> The subject is also a bit confusing:
>
> "btrfs: fix memory leak for page count"
>
> something along the lines "btrfs: fix page leaks after failure to lock
> page for delalloc" would be more clear to me at least,
> it gives a clue about where the problem is.

OK, I will resend patch.

Thanks.

>> Signed-off-by: Robbie Ko <robbieko@synology.com>
> The code looks correct, thanks.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
>> ---
>>   fs/btrfs/extent_io.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 68c96057ad2d..34d55b1e2a88 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1951,7 +1951,7 @@ static int __process_pages_contig(struct address_space *mapping,
>>          struct page *pages[16];
>>          unsigned ret;
>>          int err = 0;
>> -       int i;
>> +       int i, j;
>>
>>          if (page_ops & PAGE_LOCK) {
>>                  ASSERT(page_ops == PAGE_LOCK);
>> @@ -1999,7 +1999,8 @@ static int __process_pages_contig(struct address_space *mapping,
>>                                  if (!PageDirty(pages[i]) ||
>>                                      pages[i]->mapping != mapping) {
>>                                          unlock_page(pages[i]);
>> -                                       put_page(pages[i]);
>> +                                       for (j = i; j < ret; j++)
>> +                                               put_page(pages[j]);
>>                                          err = -EAGAIN;
>>                                          goto out;
>>                                  }
>> --
>> 2.17.1
>>
>
