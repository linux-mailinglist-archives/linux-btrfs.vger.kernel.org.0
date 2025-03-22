Return-Path: <linux-btrfs+bounces-12495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE6A6C867
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC48C3BBA4B
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB261D89E3;
	Sat, 22 Mar 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B+1yIMNg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF01AA786
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742633425; cv=none; b=lYeg40x158pCygxitg0tXSwzVaH+Iqkp+UVYldYGgDZZ/0A1MiT2lQrOW17LOe4zgVwyLB1vAm1FLE6CO/8Qw8JZAaQwptWFIr3jK+M7V2O8yj+hjVFQEbgV4WaZq0qQOHPC8PTMSRzJZUjKBqxo/G9TqB6+Ci1qXlcfbe6eZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742633425; c=relaxed/simple;
	bh=E+qg6gp1IBY4LTmU/iDt+m1oCNUJD/QYvTdtTyXzcc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBaAaj0CViv0qzF8vkGjJRssRwxJDSkwP39k181oI/FEym8jkc3K50ZUQ6ayoa6BXddQl/RuyGdljwpsNVIb5r1vV92thl6puWj558dnj63TavEAJxGs36fgENfsIAtJl2H/MeVZ2jBYpe4icOUgPy6v06erRkg85Cx4CvGVSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B+1yIMNg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914a5def6bso1655147f8f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742633422; x=1743238222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M4LBVNl0Zi0mLl4wsm9yahQsGWvOswMhcD0hAY/jR9M=;
        b=B+1yIMNgB9Um6Mbo1GejP6wkccGhWEnQQb5VlQsUyNMWkcGGuAavI0IUS25Wu+guTv
         eRwh3EPTs7Tk53CvLWSjByEqeds6FrnNjdNTF9ymQ4kpEFnLdkvG/XmwCccPCNtUUfIw
         uulxotgftnpgtMAMx4SOe2iT4MeNmqNJzc5jGP4BTu7QGMHgdw9cTl3tA7fjlbPy7KYa
         8pSqJ4T/oXsymPA/mDTsyIIF/RMT2ktXO6GKsF/7h5z8c9xhHGpjJiL5P2a8n6QjFQuN
         olKvcabTUp96Vy1hPIGX1TDrCmgjXa3XAIlPY6k1F0faxnLbjiT6vkq1wFEjWR0k/V0P
         bUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742633422; x=1743238222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4LBVNl0Zi0mLl4wsm9yahQsGWvOswMhcD0hAY/jR9M=;
        b=DpBeyLqKq5RS3gwTOPCJSLkpWm0d+eFwC+GZnX70d2NRCeRgqUidBfBeKhdGeMVe1R
         M+gIWolpYPDxqVVVexTK4IuUvwn68WluUWWTGWNOfmGPA7lYutChPuyWvuuCZLyuSyNb
         /xXQdHwPUhhv34NT2e6TYQtolV0z15AcxE4GzfdkAOG0///IQqii612F1MoJJtJtqDlK
         ppdfgoEAGukVhyCPoJK0V0Qp6iB51fIwP8rMyavf2dBz4vjTmnPupYBbEgP/MXO6S2ic
         C82Ul2s8vwuYmlmtOW3m29aLzJrLHSs8uAqTVmyBStA39r/Xik/K2Z5+txsO0ION+B3H
         aMBA==
X-Gm-Message-State: AOJu0YxBmnGj0/ctAxgf334EDYUTCbD7dqb1T9Mz6h08y017hhvf9apk
	N7XHf8yPxFcnnoREi6+UyX1P6VpYRWNMkApf+REYCMtVgf3AHvi/vxkIUyhqSNYw9KTlKrOYPPP
	L
X-Gm-Gg: ASbGncuWuHrC3KTPwVKEgFaq2cwLev7eGPWkl3fkRehLw6/EfzAQ9FTx7pv05DB6NQJ
	aEB8gHrj8YdbQziXR/7yXVbePSLDt4w5IQO0iPeircrkd7sQ/QfpBRsE8U+61y5SOsrUg4NWfEk
	GCfQDERgUYyOAN6PtAxEHfcEHs/orvtL7pL82HmA4DOKP/lPI0e+GO4LCQ0XRkLt1EQm+fAAE8Z
	n53grHY0se/1X4aAhtJgaanRwSk++br2/cK92FvKqPUJQEza2wBhNXZHMvNl3JTYzubzz5zq5+P
	eCbopXv6p70/aUSQ/HOCB9UGk6vjhJ948UMAqHpdu8Sm6amQIycKqOLqFVEyOUYIkMndefrG
X-Google-Smtp-Source: AGHT+IHQg6YOPsii5NTaNUb8n3suRCn3LTWqoUuTCbNopPOhFa1jESZ/6pL9nCNuf4HWiqsDavVaUw==
X-Received: by 2002:a5d:64a2:0:b0:391:31f2:b998 with SMTP id ffacd0b85a97d-3997f8eeb6amr4575395f8f.6.1742633421447;
        Sat, 22 Mar 2025 01:50:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f613968sm3600200a91.28.2025.03.22.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 01:50:20 -0700 (PDT)
Message-ID: <abcccbad-b761-453d-84a1-691adef6f29c@suse.com>
Date: Sat, 22 Mar 2025 19:20:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: remove force_page_uptodate variable from
 btrfs_buffered_write()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1742443383.git.wqu@suse.com>
 <66698e7eb0589e818eec555abc3b04969dcb48f1.1742443383.git.wqu@suse.com>
 <CAL3q7H7TN7tEuGqS-vsCawUvmLSaDsXWfQZzPjecXmD8mnk-kA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAL3q7H7TN7tEuGqS-vsCawUvmLSaDsXWfQZzPjecXmD8mnk-kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/21 22:30, Filipe Manana 写道:
> On Thu, Mar 20, 2025 at 5:36 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
>>
>> To me, either solution is fine, but the newer one makes it simpler and
>> requires no special handling, so I prefer that solution.
> 
> Ok so this explanation of different behaviour is something that should
> have been in the change log of commit c87c299776e4 ("btrfs: make
> buffered write to copy one page a time").

Yeah, that's in fact an unexpected behavior change, or you can call it a 
bug in this case.

> 
> With the new behaviour, when folios larger than 1 page are supported,
> I wonder if we don't risk looping over the same subrange many times,
> in case we keep needing to faultin due to memory pressure.

There is a small save there, that when we fault in the iov_iter, any 
bytes not faulted in will immediately trigger an -EFAULT error.

So in that case, we should hit -EFAULT more, other than looping over the 
same range again and again.

Although this may be a problem for future iomap migration, as iomap only 
requires to fault in part of the iov_iter.

Thanks,
Qu

> 
>>
>> And since @force_page_uptodate is always false when passed into
>> prepare_one_folio(), we can just remove the variable.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Anyway, this change looks good, and at least with the typo fixed:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>> ---
>>   fs/btrfs/file.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index c2648858772a..b7eb1f0164bb 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -800,7 +800,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
>>    * On success return a locked folio and 0
>>    */
>>   static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64 pos,
>> -                                 u64 len, bool force_uptodate)
>> +                                 u64 len)
>>   {
>>          u64 clamp_start = max_t(u64, pos, folio_pos(folio));
>>          u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
>> @@ -810,8 +810,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
>>          if (folio_test_uptodate(folio))
>>                  return 0;
>>
>> -       if (!force_uptodate &&
>> -           IS_ALIGNED(clamp_start, blocksize) &&
>> +       if (IS_ALIGNED(clamp_start, blocksize) &&
>>              IS_ALIGNED(clamp_end, blocksize))
>>                  return 0;
>>
>> @@ -858,7 +857,7 @@ static gfp_t get_prepare_gfp_flags(struct inode *inode, bool nowait)
>>    */
>>   static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_ret,
>>                                        loff_t pos, size_t write_bytes,
>> -                                     bool force_uptodate, bool nowait)
>> +                                     bool nowait)
>>   {
>>          unsigned long index = pos >> PAGE_SHIFT;
>>          gfp_t mask = get_prepare_gfp_flags(inode, nowait);
>> @@ -881,7 +880,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>>                  folio_put(folio);
>>                  return ret;
>>          }
>> -       ret = prepare_uptodate_folio(inode, folio, pos, write_bytes, force_uptodate);
>> +       ret = prepare_uptodate_folio(inode, folio, pos, write_bytes);
>>          if (ret) {
>>                  /* The folio is already unlocked. */
>>                  folio_put(folio);
>> @@ -1127,7 +1126,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>>                  size_t num_sectors;
>>                  struct folio *folio = NULL;
>>                  int extents_locked;
>> -               bool force_page_uptodate = false;
>>
>>                  /*
>>                   * Fault pages before locking them in prepare_one_folio()
>> @@ -1196,8 +1194,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>>                          break;
>>                  }
>>
>> -               ret = prepare_one_folio(inode, &folio, pos, write_bytes,
>> -                                       force_page_uptodate, false);
>> +               ret = prepare_one_folio(inode, &folio, pos, write_bytes, false);
>>                  if (ret) {
>>                          btrfs_delalloc_release_extents(BTRFS_I(inode),
>>                                                         reserve_bytes);
>> @@ -1240,12 +1237,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>>                                          fs_info->sectorsize);
>>                  dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
>>
>> -               if (copied == 0) {
>> -                       force_page_uptodate = true;
>> +               if (copied == 0)
>>                          dirty_sectors = 0;
>> -               } else {
>> -                       force_page_uptodate = false;
>> -               }
>>
>>                  if (num_sectors > dirty_sectors) {
>>                          /* release everything except the sectors we dirtied */
>> --
>> 2.49.0
>>
>>


