Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF25528AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 02:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiFUAkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 20:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiFUAkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 20:40:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79C10FE8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655772010;
        bh=eYm9YZfaQMqP2mc66Z4QDw8dlHQD4b3EDBB7D0wepvs=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=d8Ls5Fnilz7CD7mm4u3HtkW3dJOUyjMAYtBavfwyLpMd+3tbrWcqUmEgma+pHtW6U
         LLC5SO9YCwOvlV46RZOUENVJDUuIVJQLXYFLixOpgrM6UiaHBGAbPb2ky73aUYw7j1
         B33rZlK3WRLGmJCp/1bmpgsFxPhmaVkiHtVw4zfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOA3F-1oIdH63Lo1-00OYIu; Tue, 21
 Jun 2022 02:40:10 +0200
Message-ID: <7bd3daa0-234d-4843-0f04-2b020f1c7b0e@gmx.com>
Date:   Tue, 21 Jun 2022 08:40:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
 <20220620160806.GS20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
In-Reply-To: <20220620160806.GS20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gu8Oke/Gh8c4iyYypejJbt8mz5UlfKUS0EU9HzF05ma9bITek65
 kzvRBcBUgP7J5/RKxzO7lxvLnnP5bERW4AY2ME/oDnwaPQVfxyDzDiPYkpbE1+9VTtWXc8Y
 V9f535AmOqQwZ3PGZHt4QlmfJdH4exRuPwPdgrWugNpJqIxD1veGdcq6FifgEztL6YBHIQY
 7dZuYud+VfPQTiGm+6tSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jIrYRa6TZs4=:DLI8hDK+B+K5xyk9LK1ZHo
 9jb3Up0wkx/f21Ui9owop+vUdyRnsGBf+XBzYpXmPEmAx51HGFNl02bmzc4oPhYmwd6s+wQeY
 Oh8dAo63dIwRBOrp4F6EGot9cBHK/91wRrMnPT2qNaXEEIJWbj1euAajsCIhhUCLg9IO3+M8o
 sNMiwikEU0YDplPQSWe1VMGmMtDU+xbBs58b6ArbSAoULoYUDYLXOnAtxqhlP2tOs8Fmm+ELz
 lJ8dSv9CC40oG3NciuyM3DzTh1A/at9zHi7PSMXC1k4lIcBbqRif1yTStfNk1C1t/PchC90Oz
 JSWG70emGzXGJab2sFFzeIE3a5Rb5uOiMvE9WEPvhQldPIzSMJVJV4YP3gqDXf9iU2l3WDUZc
 wc/pDevi43pdCMlb1pfsK6W/L20S7wbbhdVBd4V7Tma1hd6TQC47KGmNOqCF7A9LG1Ru9Z5TE
 T7OuwMGPlf7WIyILyePvTK4PmAzgWs2WbGr+yBE8iJhdHFcWK2ggPW3c+rUI6LsqE540JfwBd
 +gyEYErMyLLSQkP6Trtf6fnYMqR1/NamRmCOgWcGAonjPmB4lA4eY1C8TJvkdcFyN6xy1muGr
 huTmIF7n13jmBC0/tPZL2NVqpcdTJlZeKQ0JHeQuB8Zr7kRtsXfpU9XdMvu+rYVcSdSmO5l2T
 p+4OPx0qh+Zd85/wGSRzaam9X25WJyz9kv2bjNt83zNPn2irOrgq75NXz4WDs8b7Bb17+FcIR
 Hz4p2Xx7XtI4wYCIC2zYdY9d2Nwj0x3RbOGCKkx9QvsoE+HSYEMfTVzuXHaNS3H7n3icBeDg0
 yTJWhJpXLKsVVuz29tDSaTVl8FrN1W7KrEJglAIKjoJ2r6ACjIccVxNJX7RaNbb/1wsLJt9nu
 MTq/ZrvLTEr5R0Ut/08iBhjdLkxvUdZ26MMpBq0XFRKN0XXHjqMkOvlRTdrv7um8NdjOIIFba
 AAWu6gKCBTprJFXFcMa9m8Q7gogQ+GgdSw9t4Br/K20Dl1tsoQVpNc86Kf4hxC/fMrXnw4iQ4
 s5WfhjAFb/yyYe9IHV4DyGrw11oka0Z6HWVqP/LFjmnR3zL5JCX64jt0UIEu/lYA48xHQseny
 0nNQxZFLHfGVjEak3H6QUFyRBBCdttO0DF3spp2hU9iTxUvfHZ40EKJRQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 00:08, David Sterba wrote:
> On Sat, Jun 18, 2022 at 10:39:28AM +0800, Qu Wenruo wrote:
>> Inspired by recent kmap() change from Fabio M. De Francesco.
>>
>> There are some weird behavior in zlib_compress_pages(), mostly around h=
ow
>> we prepare the input buffer.
>>
>> [BEFORE]
>> - We hold a page mapped for a long time
>>    This is making it much harder to convert kmap() to kmap_local_page()=
,
>>    as such long mapped page can lead to nested mapped page.
>>
>> - Different paths in the name of "optimization"
>>    When we ran out of input buffer, we will grab the new input with two
>>    different paths:
>>
>>    * If there are more than one pages left, we copy the content into th=
e
>>      input buffer.
>>      This behavior is introduced mostly for S390, as that arch needs
>>      multiple pages as input buffer for hardware decompression.
>>
>>    * If there is only one page left, we use that page from page cache
>>      directly without copying the content.
>>
>>    This is making page map/unmap much harder, especially due the latter
>>    case.
>>
>> [AFTER]
>> This patch will change the behavior by introducing a new helper, to
>> fulfill the input buffer:
>>
>> - Only map one page when we do the content copy
>>
>> - Unified path, by always copying the page content into workspace
>>    input buffer
>>    Yes, we're doing extra page copying. But the original optimization
>>    only work for the last page of the input range.
>>
>>    Thus I'd say the sacrifice is already not that big.
>
> I don't like that the performance may drop and that there's extra memory
> copyiing when not absolutely needed, OTOH it's in zlib code and I think
> though it's in use today, the zstd is a sufficient replacement so the
> perf drop should have low impact.

My bad, I didn't check buf_size which is conditionally assigned to
PAGE_SIZE or 4 * PAGE_SIZE.

So changing it to memcpy() is going affect all archs other than S390.

I'll change the mapping start and end part to re-enable the old behavior.

Thanks,
Qu

>
>> - Use kmap_local_page() and kunmap_local() instead
>>    Now the lifespan for the mapped page is only during memcpy() call,
>>    we're definitely fine to use kmap_local_page()/kunmap_local().
>>
>> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Only tested on x86_64 for the correctness of the new helper.
>>
>> But considering how small the window we need the page to be mapped, I
>> think it should also work for x86 without any problem.
>> ---
>>   fs/btrfs/zlib.c | 85 ++++++++++++++++++++++++------------------------=
-
>>   1 file changed, 41 insertions(+), 44 deletions(-)
>>
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index 767a0c6c9694..2cd4f6fb1537 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -91,20 +91,54 @@ struct list_head *zlib_alloc_workspace(unsigned int=
 level)
>>   	return ERR_PTR(-ENOMEM);
>>   }
>>
>> +/*
>> + * Copy the content from page cache into @workspace->buf.
>> + *
>> + * @total_in:		The original total input length.
>> + * @fileoff_ret:	The file offset.
>> + *			Will be increased by the number of bytes we read.
>> + */
>> +static void fill_input_buffer(struct workspace *workspace,
>> +			      struct address_space *mapping,
>> +			      unsigned long total_in, u64 *fileoff_ret)
>> +{
>> +	unsigned long bytes_left =3D total_in - workspace->strm.total_in;
>> +	const int input_pages =3D min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
>> +				    workspace->buf_size / PAGE_SIZE);
>> +	u64 file_offset =3D *fileoff_ret;
>> +	int i;
>> +
>> +	/* Copy the content of each page into the input buffer. */
>> +	for (i =3D 0; i < input_pages; i++) {
>> +		struct page *in_page;
>> +		void *addr;
>> +
>> +		in_page =3D find_get_page(mapping, file_offset >> PAGE_SHIFT);
>> +
>> +		addr =3D kmap_local_page(in_page);
>> +		memcpy(workspace->buf + i * PAGE_SIZE, addr, PAGE_SIZE);
>
> The workspace->buf is 1 page or 4 pages for x390, so here it looks
> confusing that it could overflow and no bounds are explicitly checked
> wherether the i * PAGE_SIZE offset is still OK. This would at least
> deserve a comment and some runtime checks.

The check is just above, @input_pages is calculated using
workspace->buf_size / PAGE_SIZE.

So it should be OK.

Although the real problem is subpage support, we should not just copy
the full page.

But thankfully, btrfs subpage only support full page compression for now.

Thanks,
Qu

