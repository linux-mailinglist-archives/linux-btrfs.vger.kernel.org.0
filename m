Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18E42A44B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhJLM0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 08:26:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:43193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236281AbhJLM0H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634041444;
        bh=nBxlBvI5zdf08QbYAMSi1NXHsDJFb5VaQUYb0PYfl9s=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VXh/7rmQvn/dDtNDv3EeIm/cO7SPKpWuR83Qwy9SLsriOHULhhaELVz0ibi9g5ZRx
         wDNBZC1blbiZBcBCE0LL7PXYSSxU1eAGk6MfZPSGP6xoBxQkxu8JXZp7B9yh4GbC0v
         jzUwXBvLRJyonhwvYbQuRNkmH31xUo68LOJIQsP4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1mu85r18NU-00t9bo; Tue, 12
 Oct 2021 14:24:03 +0200
Message-ID: <0fbd2076-2b6c-4531-01ea-84db37abf621@gmx.com>
Date:   Tue, 12 Oct 2021 20:24:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
 <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
 <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXGHGHhdIneVAJnts1kiDNtEn59lKI8HQ3rHfVF8TgHSj9G7qKN
 GcVdPfpxk6QPQiDHR2Yj0IwSF1caQ2iYlBZlr4bHouNljqc2DGXj69MVXzj46uustWdV3KO
 pPcJKFSji1n7wZmoLNtfaSZ0Zspn1PMx35EKhWG0oXnGXxQuvTV5b6T6qJoK1pRXzXP2+hu
 lF+AlGMwYaC82NTupYSMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/bUiiutR1Uo=:5LiltytojkjVF/Fqa0V4zO
 RV6CrHYPBfQYJSOSULqeHkh5yZHl9NnXRR0Dc1VUmgRvSxcZ88uGg4cfKka1/o1sZmERneqTR
 1V2EPRqwL9dtBmokb0alOPiNLl+CcD81MguO6r93x/rti/dn8wXzXwFlmMM0R1TeJy9g1h3la
 pmuzq7ZD3IlgCwgh7UJKeYnXM8F2aGNXzSiQimQWN1fyI4IR98jUY36Ysdol6W06qQxfQlKg+
 sFJoyIurxq3myBizfUh4rvPekDmX1gcH6UWm1wjxNNvOiRAGWgfxS6W712AGqCWXmE+IndSgw
 cXaFUI8arrUxjHMFdwVqqgsb1YEHI9LQuPAqbGmgjynKMRVvbuVxaNC/e9O6k+4XH0Us36pKo
 iUfEsjkn8lWssxGSpJwiq8NqhmDssrvnlZfqiQVQPC/0jHdg1XLPpHGUCQGuoOluJoRcwbv9n
 54MY5HNETS0WcRH8Yj+e8AxwxLwmBU3q7duNOwlhbWjlgVphBRQfKpxPHNrRRl0N4EFuW+Rwv
 OD/J0CXnl+9111JCoxZocTZMjR2eUvLXRNwrRIvaua91cQFpit7H4xh28QyXWFd2NmBum9Vx4
 3TaOJkjbzEXbziiar8WukLMOF5PzdYI2I8yuSecnABVeC6ruj0mIymi0RqjlGDZrWG2E7jbOu
 vWdi1zSAxHtmqQSZLtK7nvxOzOVzTN5/vbysbBr/a+/AIkxL66Cm501LH9Dyro3dQLDi5pNS7
 zeBSFYgZnJwQA/pEkbBSMkcSPZptgtI5yraD3OK1pzFXSLkNC40LpHiz4DIYKM0tcR1oQgqem
 W2OdOi1IBGTIWVGDBfDH0v+vTcMfyTwGxASSjQe4nOGh2KmUBtPuYLyTZXIinfg6J/i8rUE74
 aCG0Qh2c244x204CTWoum558wV+WliY0GF7LKodX/wnbtL0na0NGbngy1vIZIc1R6oO65ezBG
 5UBURy8UWt0iTz3pDO9E9dnhZ35DRAErfo6pZ8QNvFvBHESKD392g3n883NliGqasJEeJLTdp
 0smYNpML2WCApYeLIMWEYnx0X37iWrczYSg95847o3T133UzjPjhuREsgET7tf2HFvNvT4rBP
 V6CCGpnK56D3G4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 19:56, Nikolay Borisov wrote:
>
>
> On 12.10.21 =D0=B3. 14:42, Qu Wenruo wrote:
>>
>>
>> On 2021/10/12 18:38, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.10.21 =D0=B3. 13:35, Nikolay Borisov wrote:
>>>> <snip>
>>>>
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>  =C2=A0 kernel-shared/print-tree.c | 47
>>>>> +++++++++++++++++++++++---------------
>>>>>  =C2=A0 1 file changed, 29 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>>>>> index 67b654e6d2d5..39655590272e 100644
>>>>> --- a/kernel-shared/print-tree.c
>>>>> +++ b/kernel-shared/print-tree.c
>>>>> @@ -159,40 +159,51 @@ static void print_inode_ref_item(struct
>>>>> extent_buffer *eb, u32 size,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0 }
>>>>>
>>>>> -/* Caller should ensure sizeof(*ret)>=3D21 "DATA|METADATA|RAID10" *=
/
>>>>> +/* The minimal length for the string buffer of block group/chunk
>>>>> flags */
>>>>> +#define BG_FLAG_STRING_LEN=C2=A0=C2=A0=C2=A0 64
>>>>> +
>>>>>  =C2=A0 static void bg_flags_to_str(u64 flags, char *ret)
>>>>>  =C2=A0 {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int empty =3D 1;
>>>>> +=C2=A0=C2=A0=C2=A0 char profile[BG_FLAG_STRING_LEN] =3D {};
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 ret[0] =3D '\0';
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & BTRFS_BLOCK_GROUP_DATA) =
{
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 empty =3D 0;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcpy(ret, "DATA");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(ret, "DATA", BG_=
FLAG_STRING_LEN);
>>>>
>>>> I find using strncpy rather odd, it guarantees it will copy num
>>>> characters, and if source is smaller than dest, it will overwrite the
>>>> rest with 0. So what happens is you are copying 4 chars here, and
>>>> writing 60 zeros. Frankly I think it's better to use >>
>>>> snprintf(ret, BG_FLAG_STRING_LEN, "DATA");
>>
>> Well, you just told me a new fact, strncpy() would set the the rest byt=
es.
>>
>> I thought it would just add the terminal '\0' if it's not reaching the
>> size limit.
>>
>> But you're right, strncpy() would reset the padding bytes to zero.
>
> The thing is strncpy doesn't really set final NULL by definition. I.e if
> source is larger than N, then dest won't be null terminated.
>
> <snip>
>
>>
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
profile[i] =3D toupper(profile[i]);
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 if (profile[0]) {
>>>
>>> Actually profile[0] here is guaranteed to be nonul - it's either
>>> UNKNOWN... or whatever btrfs_bg_type_to_raid_name returned. So you can
>>> simply use the strncat functions without needing the if.
>>
>> You forgot SINGLE type.
>>
>> In that case, profile[0] can be "\0".
>
> How does that happen? If btrfs_bg_type_to_raid_name return NULL then
> prfile contains UNKNWON. OTOH if the 'else' is executed then either
> profile contains "single" or whatever btrfs_bg_type_to_raid_name
> returned. So profile can never be NULL. What am I missing?

There is a special handling for SINGLE:

+               /*
+                * Special handing for SINGLE profile, we don't output
"SINGLE"
+                * for SINGLE profile, since there is no such bit for it.
+                * Thus here we only fill @profile if it's not single.
+                */
+               if (strncmp(name, "single", strlen("single")) !=3D 0)
+                       strncpy(profile, name, BG_FLAG_STRING_LEN);

See, if we hit SINGLE profile, we won't populate @profile array.

Thanks,
Qu

>
> <snip>
>
