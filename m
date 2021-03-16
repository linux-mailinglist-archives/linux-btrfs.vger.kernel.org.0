Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2926333CA41
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 01:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCPAF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 20:05:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:59449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhCPAFl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 20:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615853136;
        bh=JWwl0BAgj9E5Hpct2S497fI5n4cULkwYZ4qz2q7MYfY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UsFk0CMBkfXbxUF++hFothm37yHjwaL7npglsJ6QxGfAfMKaTX8B4onNlh7XK0Rii
         DJ7eIuQflBUZXZrKr9Xlb5WqP/T9jNxb5Zh22UsCNqzkTYDBp492L5mXb3VqTQlWD2
         g1q0uxyQZMS7KW04ArKFqrNxu2gPOn8FrRo9N4Sg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1lxT1k1gf9-00fm7j; Tue, 16
 Mar 2021 01:05:36 +0100
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
 <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
 <59a9ee34-1893-a642-2a00-8cc42ec7a31f@gmx.com>
 <20210315184414.GZ7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
Date:   Tue, 16 Mar 2021 08:05:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315184414.GZ7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5sdgbJ7pxoO+vwMbSKeT/ncngkVTs/29RKbijSjp+K9sp3JkR9l
 KyuKUy6WwhTaHN1nDMnjTNFp1KhUTfUISLal7LCUijFaOKgspLMjGuDQzHRMPAGQQPVrgq2
 vQoRNStlewRG8Tiy3MLadQsfJfSMnOF3Y4+cjq0AVyByQR5ixw9ybKwJinGve4BARJjd7+9
 UplgD0n72CfTGWPoz7Mwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vaqp4xEmshI=:2letO8rg3PkBzYCuj4s2VL
 hL99WSFzPulfWZXKupA+b1WzOf5g6qpO7h8AlTTwyOiPTdLeC6hJ+hjyl4xaGSdz/kM72K7Xd
 /tKTuMgaOXSate4Gwkr8Oc4uNfIoIPkeb9/F0s9IkOwKFsg39Uc1scFCz0+9Sj9tUMI2KcO+X
 QyYXuqjFniqEXRCcQ4xweEP63TkVib1v9CgwI9lOG2cQEchUOA6hN5kVUK0g+Z9BmQi63qiNS
 BzHAPS0dNt4YSE/9EMzBZHYCObM/n/JVMuVY1rTofiuopqXGUpyYCL0c1s0i4APiXx1gElCXk
 AmrLK9HdKR1h3gMba3oF1IH36PIJLvoY1Q+bHZxdFEaVnANcroyDgAOjBczSg4Rn98yBmor7W
 0fknp9M4CgCFGBL5h3AsFeWufpEU09mAbvH+9ule8rf7qdFl4WZbWzSapcV8+CzM5UPAL9Q5M
 R9I7d3G8msnhmTVQkwzxK00/K318mYYL72ro/WPrTI54YSjFJR7Fglsyp83eD0ghnxYT4Zrn4
 y390DmWocWQbOySJLQ5+F6A9vcN6dU3BXDNqxL5v6Y7bXyFgD+lgqqmUJhPWF4y7HFUQjtid9
 Wd8fYGo9vPXllFA4zmWjD+rmFyDFECVyFYlAYgjL4Noeqt8YcYWUAocPDco3DehDgAUjlpbQu
 AWxhDYtN+SA0kOa8tQLhHSUwZrkNsbZhD++u/2p8PrhQJivTrbtyyNulLCsR3N/ZRJarqAKjI
 UboHV369PkGkv6J6gvj4RwtnxorpDdFaW5eDLoh+P9jTkzSJ9MWvcsvFR+/UOu1sH+ztLCgpT
 tNCMZpEaLG4Fhx35DEmlUGnr5ArRdsJcKMqdXdWuEOUn8ml54fpQHMJgXBqBTbZGG4jebsxTJ
 S62HhNIE70MKSA6CgP4w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/16 =E4=B8=8A=E5=8D=882:44, David Sterba wrote:
> On Mon, Mar 15, 2021 at 08:39:31PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/3/15 =E4=B8=8B=E5=8D=887:59, Anand Jain wrote:
>>> On 10/03/2021 17:08, Qu Wenruo wrote:
>>>> Add extra sysfs interface features/supported_ro_sectorsize and
>>>> features/supported_rw_sectorsize to indicate subpage support.
>>>>
>>>> Currently for supported_rw_sectorsize all architectures only have the=
ir
>>>> PAGE_SIZE listed.
>>>>
>>>> While for supported_ro_sectorsize, for systems with 64K page size, 4K
>>>> sectorsize is also supported.
>>>>
>>>> This new sysfs interface would help mkfs.btrfs to do more accurate
>>>> warning.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>
>>> Changes looks good. Nit below...
>>> And maybe it is a good idea to wait for other comments before reroll.
>>>
>>>>  =C2=A0 fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
>>>>  =C2=A0 1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>>> index 6eb1c50fa98c..3ef419899472 100644
>>>> --- a/fs/btrfs/sysfs.c
>>>> +++ b/fs/btrfs/sysfs.c
>>>> @@ -360,11 +360,45 @@ static ssize_t
>>>> supported_rescue_options_show(struct kobject *kobj,
>>>>  =C2=A0 BTRFS_ATTR(static_feature, supported_rescue_options,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_rescue_op=
tions_show);
>>>> +static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct kobj_attribute *a,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
har *buf)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 int i =3D 0;
>>>
>>>   =C2=A0Drop variable i, as ret can be used instead of 'i'.
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* For 64K page size, 4K sector size is supported=
 */
>>>> +=C2=A0=C2=A0=C2=A0 if (PAGE_SIZE =3D=3D SZ_64K) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + =
ret, PAGE_SIZE - ret, "%u", SZ_4K);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 /* Other than above subpage, only support PAGE_SI=
ZE as sectorsize
>>>> yet */
>>>> +=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%=
s%lu\n",
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (i ? " " : ""), PAGE_SIZE);
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^ret
>>>
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +BTRFS_ATTR(static_feature, supported_ro_sectorsize,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_ro_sectorsize_show);
>>>> +
>>>> +static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct kobj_attribute *a,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
har *buf)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Only PAGE_SIZE as sectorsize is supported */
>>>> +=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%=
lu\n", PAGE_SIZE);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +BTRFS_ATTR(static_feature, supported_rw_sectorsize,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_rw_sectorsize_show);
>>>
>>>   =C2=A0Why not merge supported_ro_sectorsize and supported_rw_sectors=
ize
>>>   =C2=A0and show both in two lines...
>>>   =C2=A0For example:
>>>   =C2=A0=C2=A0 cat supported_sectorsizes
>>>   =C2=A0=C2=A0 ro: 4096 65536
>>>   =C2=A0=C2=A0 rw: 65536
>>
>> If merged, btrfs-progs needs to do line number check before doing strin=
g
>> matching.
>
> The sysfs files should do one value per file.
>
>> Although I doubt the usefulness for supported_ro_sectorsize, as the
>> window for RO support without RW support should not be that large.
>> (Current RW passes most generic test cases, and the remaining failures
>> are very limited)
>>
>> Thus I can merged them into supported_sectorsize, and only report
>> sectorsize we can do RW as supported.
>
> In that case one file with the list of supported values is a better
> option. The main point is to have full RW support, until then it's
> interesting only for developers and they know what to expect.
>

Indeed only full RW support makes sense.

BTW, any comment on the file name? If no problem I would just use
"supported_sectorsize" in next update.

Although I hope the sysfs interface can be merged separately early, so
that I can add the proper support in btrfs-progs.

Thanks,
Qu
