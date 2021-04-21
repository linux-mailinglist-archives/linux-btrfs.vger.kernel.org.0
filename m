Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6042F366617
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhDUHQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 03:16:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:34015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDUHQC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 03:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618989321;
        bh=yTWat26KhspGtoweE19PKxMfg8KySR1JgoXaTuyiutQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=RPo8bf5J0/n67RVXkKqs8wSmrLaFG+oUVpyo0kYgmbfV9YTnoQ80rmmpvJC5iFxzt
         I+/3uhM4yGmnnxoJ64WKuu6FS2K2NzeAuIk3wngyaCfvhGAyi86VXSW7eRaQTryJgZ
         mbNwXaxjDMr35fup+K9xvWXkiPx7EtCKj/IKE0HI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42nS-1lZ74y4AfA-00078j; Wed, 21
 Apr 2021 09:15:21 +0200
To:     riteshh <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
 <20210421070331.r4enns6ticwpan35@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <b036930e-1596-3db4-fd14-2b329977d64e@gmx.com>
Date:   Wed, 21 Apr 2021 15:15:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421070331.r4enns6ticwpan35@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9dsYxSDNwss+ejAID/FbY6U4yydMX96kyGuxpsB+1+qd6UeBh5H
 NlJn4vv13VbNsRs/M//SYVyyE0k9ZdfaFsnJPM8y6KDmBoVuYPJ8yanI4SHfGPKXEkC3Ech
 WIzKBhLbTec2J2lZj1GXrskpNbyeaZYEpM2G6pueaz/RIrIqPbhFHXr1tJCtMgcqS/MWH53
 3HiJ3USKrnFo9WMv2BgGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nod0DWIaVUk=:B04UxqgsFhfJrXTisu0AjM
 TF5NdME17gMVoCl8T9kO+NEW9W/pRHY6P2tEOT25qISd+siLay8cXQo43KKNbqUMquF+6pprS
 Q3za/PWVfTRCr/fDi0m7kPbEmaFxUoIZt9wSDGaTp363vU3cmwo2jpntOV0V+Ph4VMLyBVPac
 qT17Vfbt9PxuHs7lwsF6BLJj9D6YsFrD9xaV4HtCRWKvBXGqjjMNbMagihv/sdlZxEjj6oBLw
 tqtBH/BNQ1PO6gF5nALITqzNK6P9yhl8ARxUXmZl65LnhbzS9tU41MU81rJ7ZdqAoeJdD0dge
 fs7TbBk+s50nZGsfhWsCW8VksegBrR82wkkTiUNdUyiSk8lRjC/zHZ2swzBC4C7R8e+3yk+hr
 12LH9A5ZZGCoVLHLpmiuoHNGGYkLiem5V093vXWNzzHzyeWFUp3ygJ6cKUYcPj9uwIsyIYrT9
 RPmAE/H49TacInIl1Cr/w979thDU40nAgk3zEpbecYB8HUZ6mYgrYHAv3mqaRq1elwxBkSzjb
 fspQqud5Z/0BBBtlu0UpnvPcTKhY5u6ev4pG/CzhUGnFZp0bUxf4QlJQr95ldxyJDJoa92I9L
 cYv/OP58MUVlrGgxm+vd8UG5f8xApFghP3pY66LN7YmjZ4S1LVI+sK2IuSwbxv52oYQtw8rcs
 9HF9ypRVYXnX8S60xkrqZiuew0flq/xXD8ls4oeTgvfkT8pCjclthfPOFqPt34atwj7L6jubf
 bSUGiySQVoj7xRyoAnYd8WRa21yXGeFrMbkHOrsZE8uGszdXhT+UAfDO1xYnJ62DhWLKFY5TJ
 8J1dzIfn1dJY0PdcbZC0Zx71x7uS/DakIwjyoWIkAtiuwyafk0f3TTqgHR7vvQge3AcSrOQie
 24ososZ459974Nxc1s3mzrDBCHr45X4+CaAP9F7UT3Gk3Eq58xnxVMNLLHdiQxQvqoxRZ+zBS
 H2KBOVuIVVv/YwKoaHN8SSNI3YCafMVL3Kx2BGHhNaFcfw9/H12QHK8fCpSkH9GKMzfcWuVIf
 OqQqeN86Ht0xXIkp96MZARIt2KOesUWfuNYsDQu/LgPsPWBU5xOzJh9H2nNw0e8bPL8n+ghNz
 EGTqm7r8GwRX1IqzA+vDhSTvo3Mw7b7+zFECWKhR6UM3JnsGzfaszyvQ8HWtNu6C22FIY0Fr1
 0KyqHubrgkxaZ+Z6dZNZTVH8iJ66VsvrDEAASRE1047xa0iYQj5BblvRPmabAjNkdBcMyzMKX
 lIsiLItbBMPH+YTwb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/21 =E4=B8=8B=E5=8D=883:03, riteshh wrote:
> On 21/04/19 09:24PM, Qu Wenruo wrote:
>> [...]
>>>>
>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>> index 45ec3f5ef839..49f78d643392 100644
>>>> --- a/fs/btrfs/file.c
>>>> +++ b/fs/btrfs/file.c
>>>> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode
>>>> *inode,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nlock_page(page);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EIO;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping) {
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Since btrfs_readpage() will get the page unlock=
ed, we
>>>> have
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * a window where fadvice() can try to release the=
 page.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Here we check both inode mapping and PagePrivat=
e() to
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * make sure the page is not released.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * The priavte flag check is essential for subpage=
 as we
>>>> need
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * to store extra bitmap using page->private.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping ||
>>>> PagePrivate(page)) {
>>>   =C2=A0^ Obviously it should be !PagePrivate(page).
>>
>> Hi Ritesh,
>>
>> Mind to have another try on generic/095?
>>
>> This time the branch is updated with the following commit at top:
>>
>> commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
>> github/subpage)
>> Author: Qu Wenruo <wqu@suse.com>
>> Date:   Mon Apr 19 13:41:31 2021 +0800
>>
>>      btrfs: fix a crash caused by race between prepare_pages() and
>>      btrfs_releasepage()
>>
>> The fix uses the PagePrivate() check to avoid the problem, and passes
>> several generic/auto loops without any sign of crash.
>>
>> But considering I always have difficult in reproducing the bug with pre=
vious
>> improper fix, your verification would be very helpful.
>>
>
> Hi Qu,
>
> Thanks for the patch. I did try above patch but even with this I could s=
till
> reproduce the issue.
>
> 1. I think the original problem could be due to below logs.
> 	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
> 	<...>
> 	[   83.634710] Page cache invalidation failure on direct I/O.  Possible=
 data corruption due to collision with buffered I/O!
>
> Meaning, there might be a race here between DIO and buffered IO.
> So from DIO path we call invalidate_inode_pages2_range(). Somehow this m=
aybe
> causing call of btrfs_releasepage().
>
> Now from code, invalidate_inode_pages2_range() can be called from both
> __iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as to=
 from
> where this might be triggering this bug. >
> I will try and debug more. But I thought I will update you with above fi=
ndings.

Your finding and testing are really helpful.

BTW, Goldwyn helped me to test the same patchset on power too, but
unfortunately he didn't reproduce the bug either on generic/095.

So I'm afraid the bug is way more complex than I thought.

BTW, have you tried to enable KASAN and to see if KASAN can find the
problem?

Thanks,
Qu
>
> -ritesh
>
