Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1352C161152
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgBQLp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:45:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:43457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgBQLp6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581939951;
        bh=wciXFLfses5Ggrb7o2eJnkMNe9xe19/1Kmye1TbeNBE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WFW+8Zyw4uS+4vZK+qi12n5QXYubHuSLRSufTQpLVwXCZmdtsSzZ2KoTRoet52o1G
         SlSMCCglk6S2TMF9qRBTqnFGJv7wfdwvOcDXW3v8wFCVYwKHQKsqmzsFbr+BTaaAjo
         eHoG2fDYP1epb1ihe/zl8BnL36TrU95wVXs8Y0bQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDywo-1jDWCQ2kQm-00A0G7; Mon, 17
 Feb 2020 12:45:51 +0100
Subject: Re: [PATCH v3 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200217063111.65941-1-wqu@suse.com>
 <20200217063111.65941-3-wqu@suse.com>
 <e5e5ba05-2f9f-d8be-63bb-9bcd3e0c090e@suse.com>
 <2cee1b97-b6a3-bffd-8cb0-cb7d903497ca@gmx.com>
 <696547c7-84ea-d346-cecb-6270c2430031@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3aadef5b-7bd2-b830-869f-67de417a4600@gmx.com>
Date:   Mon, 17 Feb 2020 19:45:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <696547c7-84ea-d346-cecb-6270c2430031@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a4M3Kp9qWf7cwMJIKbEw0nOnCGmp9uIxjKzrxTWnj5TWrDqx0E8
 VHmV505VMP6UB9WjVriyh18d/7kAjwHc8Ir6/M+M7ZEAWw2JsCI+vmcc4AXLSCBZkeR8T1S
 BidnxdI32ryVXLviZMl99k0wkNmVvKhkErYi68KRyQPkjP+LPOYk2mxCSzwnIuJV9v/ADU4
 JEmplRFEQZr3hzFYfp4QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7yMu69tcEA=:d1z5O7vCeKcIMF/bEH2wpz
 3UKM3U1IRB6ZgTCfSQzESKuYNqmq5mzONVSzk+ObN7NuHKK90W8AY+ss/SQAkefEWTio+UuUv
 ELzfs7iYrfTruU01p85EoKO8jHqJiALDoTl5i+RxQTqZ/R+LaZ4BxAEbY9/7VA9ldAL3s3FWj
 C23aj+OgW/3rGeMurSlCycmztsyyKuLNJwGPEatZtgRSE/bWQpShHJEDfgnuXyJf4sE4BWeGW
 MX275YnU0CSTnNhP0QmemzPOueiiVPVZPXYQbo6ZYZ7+NkHw7PH85DxzZoQEY62zpY67AEEes
 D9mdkg0MycDicqNhyulkUGjxJtgYWTDOPrZc/gS9um7UjTSxEVnOHOawB3AyD2oKHn7+U5hRK
 p8S9n0ZGAucMgyZv9BsjFloMIGoPYWKATplLA7ULbku6dw75FAZBjAkeGz+wT5A9SkzpWcyj1
 FxtZOISJrZ4DIT9eqggbi8KWOKDZwElasPFz852k0RTiF0FtiRkCgiZXXywB8EEGJ9d1bzrLy
 1T15Z4oAc4AuAqkfnHHTNMpF0XKobEjQCbKQaqQ4m68cWJlMncu5Lo4i+dTiVac38N/K+zor3
 fs7AeNLv/PIVMm3yNoU7eqOHP/BXjaE+SED7pslfzVxFJ8oNaMeFSDPKa/bHNPtiQfb/hFEjr
 5HzUcwF74kRJregBHr9+/eBaCo86J/fF55QCYL2h1T5mcPmtzsDNhRZPOqq+vZiRKmTqngHQ+
 /MfkGQuLBNrTkrJxKWcjPKFAc+TSYdJt3+1fD2BadbxKkM8nl6gWecbaMLc8ICJkej1E3L/tj
 yxYvjwwUc3pIYjQACSXUyAowmRnrAm/1l7w45Dz2RHQbR1xQfooRXMVNg5aFY9YdfZybA4nHG
 xUpzkCGBAo3jwKrrje9m5hOlOju+49HKsA8serElh2+xQ4exz785CtM4IloAx8esH4oE2zeD/
 ql4qZ+Jj90/zCFjdH1AGd8+L1Txn61FE4lCdMOpS5Cn+LXP0ur5hHwZTwaXC5XAwd+lS+c94K
 /MHWV7Twm0m6pYh0q1Pn/0nKnm9sYyb3fGn2MrBPOjTrVcQlmDmiC2Ei10Du2tCY8ydjq791m
 mMoMyURn3MGWq9hCkXxNL7HwZy/EPd4qKyXQQBP/mxyc0Bw05mUBA6hzDbJVHw4JSg7vSaiAz
 PZIfFNk7Vnstk9uMcPMucHJHV2QQQqYJnLXf7plU4gnJsnAUt4oqPDcMi9SZBDA5klcbEcP/n
 MOr3VTKAa4ZejqY87
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/17 =E4=B8=8B=E5=8D=887:42, Nikolay Borisov wrote:
>
>
> On 17.02.20 =D0=B3. 13:29 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/2/17 =E4=B8=8B=E5=8D=886:47, Nikolay Borisov wrote:
>>>
>>>
>>> On 17.02.20 =D0=B3. 8:31 =D1=87., Qu Wenruo wrote:
>>>> This function will go next inline/keyed backref for
>>>> btrfs_backref_iterator infrastructure.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/backref.c | 47 ++++++++++++++++++++++++++++++++++++++++++++=
++
>>>>  fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++++++++
>>>>  2 files changed, 81 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>>> index 8bd5e067831c..fb0abe344851 100644
>>>> --- a/fs/btrfs/backref.c
>>>> +++ b/fs/btrfs/backref.c
>>>> @@ -2310,3 +2310,50 @@ int btrfs_backref_iterator_start(struct btrfs_=
backref_iterator *iterator,
>>>>  	btrfs_backref_iterator_release(iterator);
>>>>  	return ret;
>>>>  }
>>>> +
>>>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *itera=
tor)
>>>
>>> Document the return values: 0 in case there are more backerfs for the
>>> given bytenr or 1 in case there are'nt. And a negative value in case o=
f
>>> error.
>>>
>>>> +{
>>>> +	struct extent_buffer *eb =3D btrfs_backref_get_eb(iterator);
>>>> +	struct btrfs_path *path =3D iterator->path;
>>>> +	struct btrfs_extent_inline_ref *iref;
>>>> +	int ret;
>>>> +	u32 size;
>>>> +
>>>> +	if (btrfs_backref_iterator_is_inline_ref(iterator)) {
>>>> +		/* We're still inside the inline refs */
>>>> +		if (btrfs_backref_has_tree_block_info(iterator)) {
>>>> +			/* First tree block info */
>>>> +			size =3D sizeof(struct btrfs_tree_block_info);
>>>> +		} else {
>>>> +			/* Use inline ref type to determine the size */
>>>> +			int type;
>>>> +
>>>> +			iref =3D (struct btrfs_extent_inline_ref *)
>>>> +				(iterator->cur_ptr);
>>>> +			type =3D btrfs_extent_inline_ref_type(eb, iref);
>>>> +
>>>> +			size =3D btrfs_extent_inline_ref_size(type);
>>>> +		}
>>>> +		iterator->cur_ptr +=3D size;
>>>> +		if (iterator->cur_ptr < iterator->end_ptr)
>>>> +			return 0;
>>>> +
>>>> +		/* All inline items iterated, fall through */
>>>> +	}
>>>
>>> This if could be rewritten as:
>>> if (btrfs_backref_iterator_is_inline_ref(iterator) && iterator->cur_pt=
r
>>> < iterator->end_ptr)
>>>
>>> what this achieves is:
>>>
>>> 1. Clarity that this whole branch is executed only if we are within th=
e
>>> inline refs limits
>>> 2. It also optimises that function since in the current version, after
>>> the last inline backref has been processed iterator->cur_ptr =3D=3D
>>> iterator->end_ptr. On the next call to btrfs_backref_iterator_next you
>>> will execute (needlessly)
>>>
>>> (struct btrfs_extent_inline_ref *) (iterator->cur_ptr);
>>> type =3D btrfs_extent_inline_ref_type(eb, iref);
>>> size =3D btrfs_extent_inline_ref_size(type);
>>> iterator->cur_ptr +=3D size;
>>> only to fail "if (iterator->cur_ptr < iterator->end_ptr)" check and
>>> continue processing keyed items.
>>>
>>> As a matter of fact you will be reading past the metadata_item  since
>>> cur_ptr will be at the end of them and any deferences will read from t=
he
>>> next item this might not cause a crash but it's still wrong.
>>
>> This shouldn't happen, as we must ensure the cur_ptr < item_end for cal=
lers.
>
>
> How are you ensuring this? Before processing the last inline ref
> cur_ptr  would be end_ptr - btrfs_extent_inline_ref_size(type);

Firstly, in _start() call, we can easily check if we have any inline refs.

If no, search next item.
If yes, return cur_ptr which points to the current inline extent ref.

Secondly, in _next() call, we keep current check. Increase cur_ptr, then
check against ptr_end.

So that, all backref_iter callers will get a cur_ptr that is always
smaller than ptr_end.

Thanks,
Qu
>
> After it's processed cur_ptr =3D=3D end_ptr. THen you will do another ca=
ll
> to btrfs_backref_iterator_next which will do the same calculation? What
> am I missing?
>
>>
>> For the _next() call, the check after increased cur_ptr check it's OK.
>>
>> But it's a problem for _start() call, as we may have a case where an
>> EXTENT_ITEM/METADATA_ITEM has no inlined ref.
>>
>> I'll fix this in next version.
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>> +	/* We're at keyed items, there is no inline item, just go next item=
 */
>>>> +	ret =3D btrfs_next_item(iterator->fs_info->extent_root, iterator->p=
ath);
>>>> +	if (ret > 0 || ret < 0)
>>>> +		return ret;
>>>
>>> nit: if (ret !=3D 0) return ret;
>>>
>>> <snip>
>>>
