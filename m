Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C492D7519
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405276AbgLKL54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 06:57:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:49879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgLKL5q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 06:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607687769;
        bh=hRJsWivX3lu/09GO8DcnXJ44eyMwFMf6Xi4tAHWiuq0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hdGbCBJwwNSI8m7uW5eV+Y+2ZifNmAvcmDc2j5xOmC483rqhIhDwwmVdziphJ/jyS
         1yOaot1AIvwfZgWVuXT6/ucpRFKy8JY/T9V7U9PAyZj3xOHvOWhvALBwYmqYoNKrxn
         OouTNdh+gKWUuzdcHFaCXTn6xw6xApxEM73KI1hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1kazAW39E6-00WWm7; Fri, 11
 Dec 2020 12:56:09 +0100
Subject: Re: [PATCH v2 09/18] btrfs: subpage: introduce helper for subpage
 uptodate status
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-10-wqu@suse.com>
 <40aaa304-cf64-806f-e2d0-8bb02b32abdf@suse.com>
 <4ae159e0-25fd-285d-7ec5-5554862c85f1@gmx.com>
 <7e2aee0c-09f9-7555-c77b-707625ea5cf5@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c57f328b-770e-900e-5db5-78f61b91c289@gmx.com>
Date:   Fri, 11 Dec 2020 19:56:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <7e2aee0c-09f9-7555-c77b-707625ea5cf5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uH75c7jOtxQ7lm8Pt0H7Vme5QjmLzrKJMi6ocRZ0AvmOII1mENk
 LH7zEhBF3sFdvXvvx22AKCWk3Y5n8ZHLEDGeZ9J6Eyq2YC2jJKLEjfiYLQQI8butKA4ROqf
 6iVMYFeirp8AetSpTKSjyjmEpnrYg5zhgDvf/zvzVz74Ge+JxTWFs5gak3fslVeQ8y1mIKn
 3PN7IK1aEcnTKg0fVRGPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Xm7NrtGIq4=:8wrcjwosh30pFOHaVghFyA
 9ry+/z8Mu934IEAKKVCFlyvS7kgifBmp+ARNI4Hwj+azn6UwKmeQ/OR12wPqVoi0Qeyp58J9K
 fd1OZkYmA07BBOdAf1AvfTqx+kIYH6Fp7/SyE43Gh1SAOBL+X09lK5ygYlz750QrXffOLQfvb
 cS2TKslTVCeU5W9cjDLsA6ClvmEU9f3s0PtL4MLjo+n9I6vLz6Ahnn4EG67YzPRjyZJKsPztr
 quMIOcV/eq4BEPOhkfzWgEZZi/4WHN5ztX6iFfQCLaUDhQRtiIoAFqESEIsDBPj+iIhkJhq7q
 YGte5Q8PZbsWsSFVKwwBhDxfY7TLJOqR5Djuk9Dvd23GAIf9mTiy0CDSzQ18a+2vfgZCSUct9
 w2lcO6iLaTg7fJlaO1ANiJNybayJ/P/X850X3Jqw46cQbz7wvUimMU1Ni48kDNzKiyvpjntXH
 Yqo71hDMHKkWzmSAo5rB3gVr5nFZ75oPrig4nfU5ND8yf4YrsyuqfbPnN56AN8Wb+n3sV88cQ
 jQfH6qv1xOwPGx5KQgskQv+0fzazmrEvJ2OI2LnqkIN6vdW98TNrVwVZKqo4WiEtOrG2bDgAh
 xlOlAXbN2KUZ4zxfQBwhwTA3EFu8BbES/Q99d6vaFALoba0l2mGJTzqXSZPaBh02uVImqrwEF
 OdWmpCyg1zDCv64+98zaDf92FTKlHzXl7wxiz2lOwa4x9MaTpowDgwDiPaJXzx+QXnwZocaP1
 24587A9DAc9ZHTjjJVpul0IsYK2d5jxnJdvpX9Eu0Gj8v1UUM6uaDqiznjokvqUWNNiLDzzFY
 0rGo0zm0JcTsQ6hHP1Y7WkOE1qKrM8yQcdwUtZ625V0N0DdtcgS7spzsUwe0m1xNoiacXZp7S
 nMWuIvuYMqOMz6Y4445g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/11 =E4=B8=8B=E5=8D=887:41, Nikolay Borisov wrote:
>
>
> On 11.12.20 =D0=B3. 12:48 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/12/11 =E4=B8=8B=E5=8D=886:10, Nikolay Borisov wrote:
>>>
>>>
>>> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>>>> This patch introduce the following functions to handle btrfs subpage
>>>> uptodate status:
>>>> - btrfs_subpage_set_uptodate()
>>>> - btrfs_subpage_clear_uptodate()
>>>> - btrfs_subpage_test_uptodate()
>>>>   Those helpers can only be called when the range is ensured to be
>>>>   inside the page.
>>>>
>>>> - btrfs_page_set_uptodate()
>>>> - btrfs_page_clear_uptodate()
>>>> - btrfs_page_test_uptodate()
>>>>   Those helpers can handle both regular sector size and subpage witho=
ut
>>>>   problem.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/subpage.h | 98 ++++++++++++++++++++++++++++++++++++++++++++=
++
>>>>  1 file changed, 98 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>>>> index 87b4e028ae18..b3cf9171ec98 100644
>>>> --- a/fs/btrfs/subpage.h
>>>> +++ b/fs/btrfs/subpage.h
>>>> @@ -23,6 +23,7 @@
>>>>  struct btrfs_subpage {
>>>>  	/* Common members for both data and metadata pages */
>>>>  	spinlock_t lock;
>>>> +	u16 uptodate_bitmap;
>>>>  	union {
>>>>  		/* Structures only used by metadata */
>>>>  		struct {
>>>> @@ -35,6 +36,17 @@ struct btrfs_subpage {
>>>>  int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page =
*page);
>>>>  void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page=
 *page);
>>>>
>>>> +static inline void btrfs_subpage_clamp_range(struct page *page,
>>>> +					     u64 *start, u32 *len)
>>>> +{
>>>> +	u64 orig_start =3D *start;
>>>> +	u32 orig_len =3D *len;
>>>> +
>>>> +	*start =3D max_t(u64, page_offset(page), orig_start);
>>>> +	*len =3D min_t(u64, page_offset(page) + PAGE_SIZE,
>>>> +		     orig_start + orig_len) - *start;
>>>> +}
>>>
>>> This handles EB's which span pages, right? If so - a comment is in ord=
er
>>> since there is no design document specifying whether eb can or cannot
>>> span multiple pages.
>>
>> Didn't I have already stated that in the subpage eb accessors patch?
>>
>> No subpage eb can across page bounday.
>>
>
> As just discussed during the whiteboard session this function is really
> dead code for eb's because they are guaranteed to not span pages. Even
> for RW support it seems there is only btrfs_dirty_pages which changes
> page flags without having clamped the data i.e. there's only 1
> exception. In light of this I think it would be better to replace this
> function with ASSERTS and handle the only exception at the call site.

You're completely right.

I'll definite change these in next update.

Thanks,
Qu
>
>
> <snip>
>
