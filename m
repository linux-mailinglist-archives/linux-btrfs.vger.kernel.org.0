Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0453B2468
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFXBMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 21:12:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:43127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFXBMd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 21:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624497011;
        bh=5U8fFO9jLjOm7YJypkGHQk/4fWeZAs8zt4pHSg/RCdM=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=QljhQqfD2Tpdp56zYo/CQGG1vNMjqqdXOIuNjLFyLa4QJ/Fnt3fKwrH8/3DPT8Vpb
         FNGJ8lmu/dJZVTVsqEoNZaamkBhtqhGzTlL3kFbXIqfNesu6FQSsUjoyr50GAst+ud
         NaDz6YjcibpDarpyrGbJ1Ugg1BRcNnRyqaT1pGzE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeQr-1li8xd3YbD-00VfXy; Thu, 24
 Jun 2021 03:10:11 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210623055529.166678-1-wqu@suse.com>
 <20210623212319.GP28158@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/8] btrfs: experimental compression support for
 subpage
Message-ID: <329fc60b-f622-7ddc-1a56-42a9f264cc19@gmx.com>
Date:   Thu, 24 Jun 2021 09:10:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623212319.GP28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ajm7dFF3pS5oHr/VKs/MCwB8TmgLYsdb5cp3ejZjEXmmh5VnJrM
 2LkGAo2Bt9ZxtGZFB0ZYZA8etQlbGeDZjMiFpVyTVZDmjMv2zlOM4xY+vVO6KVNcnJc1lzm
 38k9EsVSZ0ZAiE7tqrLVFHHwZBqNAEnN9Gvap2H7lLOB8rnzsRvaUF36mEh/qxRGByUJZJn
 bp0nboChjz9B/0JTWDXDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4LcBaIsA38=:54EEbLD5O6zZhWlG0KkvUC
 /O0bAjyTL/McW1/PWpjqhDaBSBk1aGmaV8qkx396Y+AOQ32a9Efx1UWyijYdY4m7IONdm8HY0
 mSpZkfQhNKE302+H7RUC/T3fFtLKfq6iFVieGp6q5CpjnHggvElcG8SJN3DWsSUHkR0QaMbEO
 Ib5K0YNJv41l5WRKHng0cS/SJ9AbKhZg4JFzGaXVgCmE15BsSnWVG6ak0L7QJCYYMEpxW/G5t
 W7KmYc0ikCEHUDib8jy7l9D1pAhn9D220jjfjQLFxU5CpvtuYKMQK8sr+ehSv7tY7aSntoefK
 Bl9V3Q7ytzG7SITt/uvjTVaW95151vM0oHAmTS/C2ck8OMnZqV/pnT7BaXPFo0Pftsh3nk3DT
 vUCvjsKqRDgnGKBWPhPb/GRLIGCGCHLF0toc+iHjFft3KUeIWbe0v39Lfqk0Xb21BVtyFk2nm
 ZkESCL2x2nLBzHKHV3NKLG9kPBz3bWMZwBkW1M3BYOTv5mrVqJn3yu4jo+67lj1uFRkjaYGKw
 M0i3j7+b+WV/R2umRSCJp9+bLf5RuZbjWXlRheLFcb2yzzLJyVJhqsInDr+uybXWmgvKKRLQo
 JwzGGQ/LIDlEjAtCAP4YGp+lhYKRuTb56vuKp4BnzBvL9B+hJv+S97rFuegEsUs/9K7LsebZI
 uaAdYvkTupd0BgE0O02BZdKTSe9utz/VE68bfL1cMacLGQER63Hl+cIH2oHXcOQ1dM3yLchFp
 /u3Zf6qahvpXXfzT+bM3BiWVsdDgi1j6bIBfSLq+eg6trtj7zPIRXjUHTJzebQF2bG9MjSyhX
 MozPRCz83n9Uj1eUbpyevwVh/3RDS0PndoZN0HYXXHbFILmcZm6i8CmvdjPvk9Nec2n954OYJ
 uErGdHmra0WxNarB6XSCbL2zPvaJ3imKIGVG5sk4SYDV6UJBWC95csFUo6LeHEBPMRFHB1+Qz
 G9EvqYc6sLhHAxq/aN1ciIDYIZgQJNGNUej+l0Z0kY2vtyRdWfwDOif8H4TAnzJtFXFYnQRx0
 Z089RLgCajVQeu1XDgRLBPmwrUHJfHDvDo7FzIDus3G533pmWuiIJBA3IiSQBScyLrVMhfGQA
 qaKMjinOxif4AusgsIabz/qCbF9fPFwCyl+Sfu+jwAkEStivRN/s7ZwKg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/24 =E4=B8=8A=E5=8D=885:23, David Sterba wrote:
> On Wed, Jun 23, 2021 at 01:55:21PM +0800, Qu Wenruo wrote:
>> This patchset is based on my previously submitted compression refactor,
>> which is further based on subpage patchset.
>>
>> It can be fetched from the following repo:
>> https://github.com/adam900710/linux/tree/compression
>>
>> It only has been lightly tested, no stress test/full fstests run yet.
>> The reason for such a unstable patchset is to get feedback on how to
>> continue the development, aka the feedback for the last patch.
>>
>> The first 7 patches are mostly cleanups to make compression path to be
>> more subpage compatible.
>>
>> The RFC is for the last patch, which will enable subpage compression in
>> a pretty controversial way.
>>
>> The reason is copied from that patch:
>>
>> ```
>> This mechanism allows btrfs to continue handling next ranges, without
>> waiting for the time consuming compression.
>>
>> But this has a problem for subpage case, as we could have the following
>> delalloc range for a page:
>>
>> 0		32K		64K
>> |	|///////|	|///////|
>> 		\- A		\- B
>>
>> In above case, if we pass both range to cow_file_range_async(), both
>> range A and range B will try to unlock the full page [0, 64K).
>>
>> And which finishes later than the other range will try to do other page
>> operatioins like end_page_writeback() on a unlocked page, triggering VM
>> layer BUG_ON().
>>
>> Currently I don't have any perfect solution to this, but two
>> workarounds:
>>
>> - Only allow compression for fully page aligned range
>>
>>    This is what I did in this patch.
>>    By this, the compressed range can exclusively lock the first page
>>    (and other pages), so they are completely safe to do whatever they
>>    want.
>>    The problem is, we will not compress a lot of small writes.
>>    This is especially problematic as our target page size is 64K, not
>>    a small size.
>>
>> - Make cow_file_range_async() to behave like cow_file_range() for
>>    subpage
>>
>>    This needs several behavier change, and are all subpage specific:
>>    * Skip the first page of the range when finished
>>      Just like cow_file_range()
>>    * Have a way to wait for the async_cow to finish before handling the
>>      next delalloc range
>>
>>    The biggest problem here is the performance impact.
>>    Although by this we can compress all sector aligned ranges, we will
>>    waste time waiting for the async_cow to finish.
>>    This is completely denying the meaning of "async" part.
>>    Now to mention there are tons of code needs to be changed.
>>
>> Thus I choose the current way to only compress ranges which is fully
>> page aligned.
>> The cost is we will skip a lot of small writes for 64K page size.
>> ```
>>
>> Any feedback on this part would be pretty helpful.
>
> As another step, progressing towards full subpage support I think that
> the limiting compression to the full 64k page is acceptable. Better than
> nothing and without intrusive changes described above.
>
> There still might be some odd case even with the whole page, I'm not
> sure how exactly it would work with 4k/64k but there are some checks
> inside compression anyway if the size is getting smaller and then
> bailing out uncompressed anyway. So in general fallback to uncompressed
> data happens already.
>

Well well well, just come by a new shinny and maybe perfect idea to make
it better.

- For async cow submission
   The main problem described above can be solved by
   btrfs_subpage::writers and a change in how we run delalloc range.

   Currently we find and lock a delalloc range, then run the locked range
   immediately.
   This makes any submitted async cow can finish before we reach next
   range, thus even we increase subage::writers it makes no sense.

   But if we find and lock *all* delalloc ranges inside a page first, and
   increase subpage::writers according to all the locked range, we can
   ensure the full page won't be unlocked until all delalloc ranges are
   submitted and finished.

   By this we can allow sector-perfect compressed write.

   And for exsting delalloc range handlers like cow_file_range(), we need
   to keep a bitmap to record which range is submitted asynchronized,
   then unlock the remaining ranges manually.

- The bio submission and delalloc range
   Above change makes me thinking, why we don't submit bio when we run
   delalloc range?

   When running delalloc range, we will need to find and lock all pages
   in the range any way.
   Why we can't do the submission at the same time, as we already need to
   do the page operations anyway.

   I guess there is some performance related reason, but I'm not sure.
   Any feedback on this part will be appreciated.

Despite the better solution, I'll still push the current full page
compression, not only as a quick stop gap, but all these preparation
patches will benefit later sector-perfect compression.

Thanks,
Qu

