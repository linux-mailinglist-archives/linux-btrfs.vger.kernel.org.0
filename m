Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169622D9695
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgLNKsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:48:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:40691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgLNKsO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607942795;
        bh=y6QQkY5oaBe1r0bP0Oy1+oGKw1EtwT7XgJ7yGpkUjiE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=O/fS6zP5tifgb3DKFoLYSaRg2iX3MeIhltnsgyJUOqoyu/Uc80dr8E13kF34YjhCq
         E5LPZQv69lFq5cWkraajkbzStQIMk1NvdykFK/+iNpBOYcbmTEym1f14od23mmyshF
         RJF/ahRVKZ7VMGhfW2DgGwDkvRoZZrQHMbkeXYZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1kHdXn27EP-00boM2; Mon, 14
 Dec 2020 11:46:35 +0100
Subject: Re: [PATCH v2 14/18] btrfs: extent_io: make
 endio_readpage_update_page_status() to handle subpage case
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-15-wqu@suse.com>
 <615e54a4-0339-830c-a2b7-a0fa1a8fe488@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40be1a1f-8c43-9ae8-1fb9-5678b0682b0b@gmx.com>
Date:   Mon, 14 Dec 2020 18:46:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <615e54a4-0339-830c-a2b7-a0fa1a8fe488@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nCmq7KSSV1aFa8a2YujrofpWpWpYg9zJvtAsXfVdNkFA22fNfaq
 JXkagw4Wv8xcM/S2tfuJxgVcld39qUg1/sq05X2UYXztvB1o8apbqzxKgr5dHgx+ayuTDMo
 R9s2eS9p7hXWJM+s07HmiYWYSJ51sZ5jQFnGV08lnNnbCMpkpSNwudtptzwQv2lVORKDWA4
 iYmtH0W4IFqNQI3RCZkWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kdeHG0wSG1Y=:wYUFeVR+dN+jZ5Mjdd1T2V
 /dL97tRyKsKyahrAWTyO1GggJMqw/MFU2pi1Jjvj4QzS+k+WgmBfJWvdFoV1k6fiHo1fIR105
 M5USpAl3TTSz4xaMu1OuGGgy1oQPprTq1o74MD+oGUUIuKm+wA9BQGVEgBQ6w3iWr9H9tnUvj
 BG7A53uS3n33XAIokI5nlwQfvq/yCDtHM/hllWBuWLqXQGDNMPG8fCfvsArNQcUy5UGc2X//g
 qWGlJ4AZW+p9csUQ980hwb071UuuT1ZlrWW17Qcfm4EEOmTKdsGjGtpScCMfHDG9ro8pYjJ3V
 1evmAv07Rt/47WSet9NDaOOQ6ku1V2cpXWzZNPItnbTtjDJFRbpL6Rr4FveJiRigtfm+xraJo
 G1mPLfxBvteBW8lP0ZsmD4C3NOjeGYCRXqai8n8D+VJ/bGbynq18V+iUZ0nTxYVlE2b9iboHm
 cJMZnk0tpCzuBsqWSLU7cyBDoqL3sO9/NA1MSYZOl5Cj45sjFG6NI+MJucbi7lsAi9v6S0e06
 0LAtPZsUoX+SVZLRV9gDPUW7SFIH0R0pVzgYk0zxxiBFnuI3mXhyqIRPwy/Lt0m2qoh1zZOtu
 LtfzhsfYiOwt+ek04GadJpQ11cd5ZQXLR9T7GqCv+VI1kLfmhJsXILWyDHLHdOYjrfxgVmgdq
 3GrgCxPost0gaReYeAaDpZtT/JvgDjlWQuHDdj6YS6GXE4j7l1jQ/euyJjUz0Jby13haJAq+4
 FkJtqUWg00VimcvFQIQKuahEgt3gUOM/+yjG1RuwU5LlRqBJBEY1qMTvbultGaGINM6406qC1
 6XPAugqlgk0roesaD/UvlM7JSDN03S3ZuJcsmDMYLBEARe4yDmLhvGu/5z56BSPtlQvPRDMmw
 VRAe2ycNWyvnTFEeRvHA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/14 =E4=B8=8B=E5=8D=885:57, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:39 =D1=87., Qu Wenruo wrote:
>> To handle subpage status update, add the following new tricks:
>> - Use btrfs_page_*() helpers to update page status
>>    Now we can handle both cases well.
>>
>> - No page unlock for subpage metadata
>>    Since subpage metadata doesn't utilize page locking at all, skip it.
>>    For subpage data locking, it's handled in later commits.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 23 +++++++++++++++++------
>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 1ec9de2aa910..64a19c1884fc 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2841,15 +2841,26 @@ static void endio_readpage_release_extent(struc=
t processed_extent *processed,
>>   	processed->uptodate =3D uptodate;
>>   }
>>
>> -static void endio_readpage_update_page_status(struct page *page, bool =
uptodate)
>> +static void endio_readpage_update_page_status(struct page *page, bool =
uptodate,
>> +					      u64 start, u64 end)
>>   {
>> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb)=
;
>> +	u32 len;
>> +
>> +	ASSERT(page_offset(page) <=3D start &&
>> +		end <=3D page_offset(page) + PAGE_SIZE - 1);
>
> 'start' in this case is
> 'start =3D page_offset(page) + bvec->bv_offset;' from
> end_bio_extent_readpage, so it can't possibly be less than page_offset,
> instead it will at least be equal to page_offset if bvec->bv_offset is 0
> . However, can we really guarantee this ?

I believe we can.

But as you may have already found, I'm sometimes over-cautious, thus I
tend to use ASSERT() as a way to indicate the prerequisites.

>
>
> You are using the end only for the assert, and given you already have
> the 'len' parameter calculated in the caller I'd rather have this
> function take start/len, that would save you from recalculating the len
> and also for someone looking at the code it would be apparent it's the
> length of the currently processed bvec. I looked through the end of the
> series and you never use 'end' just 'len'

Right, sticking len would be better, I'll stick to start/len schema for
new functions in the series.

Thanks,
Qu

>
> <snip>
>
