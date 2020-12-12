Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4572D85DF
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbgLLK1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 05:27:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:53113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgLLK1n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 05:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607768769;
        bh=Nxjo73CJJ1q0powZX9rdfue+QKteYv6yUmrXYz6Pb7M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dv2rHKk7ZcKS5D55CeVlnqnqe0VRUZUmIoaCI8U/Lw+DWepzSa0PVWUiIpCyNLYfD
         Ll8f/Zgl+pa5eQoTwt4rY35whvdZFPT8TgAUbU0/ibePd18duETJcRSGIRzU3w4mrj
         pEYmHsc8BIrbLu8fHq4RTJh3iaKUjOl5HoLBFWek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1kNo6T2U0v-00iQs9; Sat, 12
 Dec 2020 11:26:09 +0100
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
 <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
 <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
 <00601760-4e7d-935a-e2bb-056593ff5a39@gmx.com>
 <f793704e-fdb5-d79e-7a16-bf6e182bb707@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4b312517-0d21-a155-3203-be67585f7d2f@gmx.com>
Date:   Sat, 12 Dec 2020 18:26:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <f793704e-fdb5-d79e-7a16-bf6e182bb707@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iy/lCugZaWV4mUqqWQgYt2ZFkWgLy4h3AWtH3kxCksUl+Rxf3FB
 /JahSSt0mFgJOBZkoalO8+pqQEGQrDQmnzvyGl9HUsZZongn1sVA8U4bUE8BpiIyTUrrFwW
 38re6Nb/kn16vc4+JInzO0GnCGC+reKu5ux+ae4lHc1VsDHyGG3RxdafvAmHWSvmL3Us7pw
 uJGGaMe24UChRxgIsEPDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sf6V62jqM2E=:nzOmR3RchDzM/uobE8G8su
 l8KVgBvQidNIsrzrP2sn2MA5H/tBW16Qt//FD6EytY6iO1DkKjlMOvV7hg9PYAX4Ohkz5ibwQ
 u3QgYj8V5imjK3VVh2MzhUbGoYcak+yEDpJdkhACDS786gGYLpOFgeffLr0HdWM8S8TQunyWn
 1LbXrJOjTmkXicTTVdJOsvZeS6H+ZhhgtEMYnTKny3wHn9YUq4388VYoez+jWdnZEDbJh7b9t
 ffOheyyc0AJEhiipUxBNccXfnrZhYIGk0y7mYZlj6laSm/iPpgrZILsiEmXN93YklWrhkg1Ti
 io2+J5xtffpCQtb/8jS1aPCMeMvh88jmPSWYARQL5ZbbxvdPD2elia421RZ4eQIqcRCG2829h
 S117sscwkBLMdMDGnK3egd4xgJNZccvnBymyEkyLvP79WaSwne7HJ9fdT1jC05UEJevlb+SF5
 XAPg+c/t4g6JDY024j2zPYQukbZIAkNrAprZT3SxRvz6trIb+O81WKO9MgL1qTM3esT6URDfF
 eNY+8sVaVGrYEfWXkWUIbWyMNkAse8boBTlp4CK4+BVim2HmR6vrVK5H8MBOuTWMKIOShlJgw
 JBiudKsaXRbr3Vk+xtNAKcmwpnwSzbgbFN/HKFVt0nuILGloKZjO7mcrxctdwJKsKVfrCiAro
 579VaOUFt5etO8eTrTGD766HYQV8peQVPlll2EPaCryeIN9MkiZNDF+8OKu7r8VD6sIM9lug/
 F1kJSKTE79XrvglwEV5mtYdQHeT1vGk99oELNN8U1RG1wzmlxjrzztZwV/otFic7P121Zxl4S
 JwvRBziu4V8+8Y0y+MWs8GrArzwSNetrp1qaVrR3Z0kBXgijXkUOLoN/68CoTrwG11Xct4nmA
 hBtzEUUGNTdZQwkThrag==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/12 =E4=B8=8B=E5=8D=885:26, Nikolay Borisov wrote:
>
>
> On 12.12.20 =D0=B3. 3:28 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/12/12 =E4=B8=8A=E5=8D=8812:57, Nikolay Borisov wrote:
>>>
>>>
>>> On 11.12.20 =D0=B3. 14:11 =D1=87., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/12/11 =E4=B8=8B=E5=8D=888:00, Nikolay Borisov wrote:
>>>>>
>>>>>
>>>>> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>>>>>> Unlike the original try_release_extent_buffer,
>>>>>> try_release_subpage_extent_buffer() will iterate through
>>>>>> btrfs_subpage::tree_block_bitmap, and try to release each extent
>>>>>> buffer.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>  =C2=A0 fs/btrfs/extent_io.c | 73
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>  =C2=A0 1 file changed, 73 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>>>> index 141e414b1ab9..4d55803302e9 100644
>>>>>> --- a/fs/btrfs/extent_io.c
>>>>>> +++ b/fs/btrfs/extent_io.c
>>>>>> @@ -6258,10 +6258,83 @@ void memmove_extent_buffer(const struct
>>>>>> extent_buffer *dst,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0 }
>>>>>>
>>>>>> +static int try_release_subpage_extent_buffer(struct page *page)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D
>>>>>> btrfs_sb(page->mapping->host->i_sb);
>>>>>> +=C2=A0=C2=A0=C2=A0 u64 page_start =3D page_offset(page);
>>>>>> +=C2=A0=C2=A0=C2=A0 int bitmap_size =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>>>>>
>>>>> Remove this variable and directly use BTRFS_SUBPAGE_BITMAP_SIZE as a
>>>>> terminating condition
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 int bit_start =3D 0;
>>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 while (bit_start < bitmap_size) {
>>>>>
>>>>> You really want to iterate for a fixed number of items so switch
>>>>> that to
>>>>> a for loop.
>>>>
>>>> The problem here is, it's not always fixed.
>>>>
>>>> If it finds one bit set, it will skip (nodesize >> sectorsize_bits)
>>>> bits.
>>>>
>>>> But if not found, it will skip to just next bit.
>>>>
>>>> Thus I'm not sure if for loop is really a good choice here for
>>>> differential step.
>>>>
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subpage *s=
ubpage;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *e=
b;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tmp =3D 1 << bit_st=
art;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure the p=
age still has private, as previous run can
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * detach the priv=
ate
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>
>>>>> But if previous run has run it would have disposed of this eb and yo=
u
>>>>> won't find this page at all, no ?
>>>>
>>>> For the "previous run" I mean, previous iteration in the same loop.
>>>>
>>>> E.g. the page has 4 bits set, just one eb (16K nodesize).
>>>
>>> Isn't it guaranteed that if you iterate the eb's in a page if you meet
>>> an empty block then the whole extent buffer is gone, hence instead of
>>> doing bit_start++ you ought to also increment by the size of nodesize.
>>>
>>> For example, assume a page contains 4 EBs:
>>>
>>> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
>>> x|x|x|x|0|0|0|0|x|x| x|x |0 | 0|0 |0
>>>
>>> So first bit is set, so you proceed to call release_extent_buffer on i=
t,
>>> which clears the first 4 bits in tree_block_bitmap, in this case you'v=
e
>>> incremented by nodesize so next iteration begins at index 4. You detec=
t
>>> it's unset (0) hence you increment it byte 1 and you repeat this for t=
he
>>> next 3 bits, then you free the whole of the next eb. I argue that you
>>> also need to increment by nodesize in the case of a bit which is not
>>> set, because you cannot really see partially freed eb i.e you cannot s=
ee
>>> the following state:
>>>
>>> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
>>> x|x|x|x|x|0|0|0|x|x| x|x |0 | 0|0 |0
>>>
>>> Am I missing something?
>>
>> It's not for partly freed eb, but nodesize unaligned eb.
>>
>> E.g. if we have a eb starts at sector 1 of a page, your nodesize based
>> iteration would go crazy.
>> Although we have ensured no subpage eb can cross page boundary, but it'=
s
>> not the same requirement for nodesize alignment.
>>
>> Thus I uses the extra safe way for the empty bit.
>
> Which of course cannot happen because the allocator ensures that
> returned addresses are always aligned to fs_info::stripeize which in
> turn is always equal to sectorsize...

Nope again.
Think again, sectorsize is only 4K, while nodesize is 16K.

So it's valid (not really good though) to have eb bytenr which is only
aligned to 4K but not aligned to 16K.


> So you add extra complexity for no
> apparent reason making code which is already subtle to be even more subt=
le.
>
> <snip>
>
