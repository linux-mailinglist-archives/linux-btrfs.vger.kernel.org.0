Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B293D2F5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhGVVIK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 17:08:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:46339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVIK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 17:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626990521;
        bh=uqs68jEoqT5ny/2749YoTES2R50k4Q2SdBz6sIOfML8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZI2A7c1gXI9BEKlVLefV5W7hwi5+8yt9tRd6i+Ux1T3lsZrLQX8BjxEi8/uKC41JW
         HFjjp5M4l+rHbaUHN5cIXR9CiOtxNyWuPlp8+efS4cSJM7dBXQaixlw1xqHAqCKWDN
         jnyzSDZYLtEd2kKNXTp/Kltzknm/qxblhiX0g5k4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bSt-1l77Vb36KB-010ghQ; Thu, 22
 Jul 2021 23:48:41 +0200
Subject: Re: [PATCH] btrfs: make __extent_writepage() not return error if the
 page is marked error
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210720114548.322356-1-wqu@suse.com>
 <e50266bf-db30-9387-9b1a-f3d042d5230a@toxicpanda.com>
 <d9024a88-f072-690e-d9d4-806e0135677e@gmx.com>
 <20210722141858.GX19710@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e4dd4550-e602-28ef-5969-4edbc365a851@gmx.com>
Date:   Fri, 23 Jul 2021 05:48:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722141858.GX19710@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQVUofy9TsQgqhOdHHBEMcMwWRfm3iS4gYP+apKaZy9PBKsJY7c
 eoJlETCWXZjvjNdJ/iiOpOHQFSjRfykKray1dZnoHPeuU/Rexm2yCjJjB2D3wzV04wK9OcG
 7VMrqTb7Tpzf910wXgcDl9LQ7qUOH02nKn1FD7esBnwfw8KLL4+ShEriX7L5LZDYeOnXC3I
 pB0DqdkjefLhwCJfeliiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UIVGlSBz2rs=:mXI6JoZbp4u6O8vizszcJx
 ktAIRSuCjwdisHUqxpuMjupIEZ1puMKSWTjZ19WkM1JTJhNLuJMDwvciTU+qfw00PmFuo/HLn
 BtTbd4q0JiBRRA57+NrOe2uJ1OOflLokznblCRhnSBIxlOtHLffrNtSNh5nhon+zBv+NdH7/d
 DuM5F1k7OPCavn3iI4wan9NUZ/1q5wwyWgKQWuofh89mSRDw29xPk5xNg98NPaGMy8Cc79Fuv
 nPslZEOXoTdW4l79hgQ0J+fuq9NJc9dsZpYoFnGFRqDYhAybDqxIWjUOk8HZJBqbEKgkk7AnG
 AMllX3/Ti1BvT3C62fVAjtPfTJt0KmudiY3PfgeQ1DM4V5S7JyyQvcGcwfLXXEXKZHd2xn+VX
 1ixfEUhsNiQ0jmxhAp4S4vUU7wY+RnMT/apfX7+wEFOPKOsbn5LCiOw0Ujsf6OlgK+FZrsc7R
 iFN7cynjA8oZe/b4flUYqFMd2m+Jdb5WDpFN9tpPNnU3GRm4drj/qzToAkXToNnErfRXBkTBl
 l3SM0FW3yVHPYZvyuAVlMu5umrbY1xUSeMETp5msHu6Zu5Lrk4n43Q8hnzrITZSsCnrShtI/7
 i2EiylX9Nfte59rkXov/6byRmSxFI48z++L+9sRsU0O7j9ZnuWoux7bzowoD3WoaM5aGR3rwJ
 TLXVlqkE2F4EmH7kBqFxLAnuYAqM/QUr66ZJBGU/FX/ugoIRWcvMzZ3M9PV/WCVGVffSUriru
 2ai7p8lFivIFdm/9lzTWIHZo8WH/OFfpLn8dHk7J7Otx4UvskJrHxoh+FtxcfeC+YuH7sTjzL
 AQY5AvoUc8t63oJ6RGYPe33bJROzXmEhRcQRc3pdawiJ2qtqVUc0r+koqD4Yifs11gZMgdOs5
 uMZ78k2pctxEjXcjfSrjBfvIpyzijkcKMSjfIuDhRrP6EmkjSsSJzwjgQTtDa7lR4/JveMeG4
 tYQpC/D0+sJDsrGSTBbTY3hkIIMr3Bcb92zdjwW5cdvysSucb5meJKVeG1X79B7Q2MUJ8k0my
 FaQ8G3BGmaYOifTBwoUhLU4Kpdmu1DmLTC7p4kSPN3gsBZYE7/kWwCpr00etdAIxf6TGfUj09
 EWc2KCUSbCMCzatMRN81LEbbCyHIes1wqWnDTxVu5hH3gdc3zXW6gcvtQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/22 =E4=B8=8B=E5=8D=8810:18, David Sterba wrote:
> On Thu, Jul 22, 2021 at 05:18:19AM +0800, Qu Wenruo wrote:
>>>> For subpage case, we can have multiple sectors inside a page, this ma=
kes
>>>> it possible for __extent_writepage() to have part of its page submitt=
ed
>>>> before returning.
>>>>
>>>> In btrfs/160, we are using dm-dust to emulate write error, this means
>>>> for certain pages, we could have everything running fine, but at the =
end
>>>> of __extent_writepage(), one of the submitted bios fails due to dm-du=
st.
>>>>
>>>> Then the page is marked Error, and we change @ret from 0 to -EIO.
>>>>
>>>> This makes the caller extent_write_cache_pages() to error out, withou=
t
>>>> submitting the remaining pages.
>>>>
>>>> Furthermore, since we're erroring out for free space cache, it doesn'=
t
>>>> really care about the error and will update the inode and retry the
>>>> writeback.
>>>>
>>>> Then we re-run the delalloc range, and will try to insert the same
>>>> delalloc range while previous delalloc range is still hanging there,
>>>> triggering the above error.
>>>
>>> This seems like the real bug.
>>
>> That's true.
>>
>>>  =C2=A0 We should do the proper cleanup for the
>>> range in this case, not ignore errors during writeback.=C2=A0 Thanks,
>>
>> But if you change the view point, __extent_writepage() is only
>> submitting the pages to bio.
>> It shouldn't bother the bio error, but only care the error that affects
>> the bio submission.
>>
>> This PageError() check makes the behavior different between subpage and
>> regular page size, thus this can be considered as a quick fix for subpa=
ge.
>>
>> For a proper fix for both subpage and non-subpage case, I'm trying a
>> completely different way, and will send out a RFC for comment later.
>
> I tend to agree with Josef, the change is conunter intuitive. The proper
> fix would be probably bigger than just a line removing the 'ret'
> updates, so at least a comment explaining what's going on should be
> there incase we decie to take this patch first.

Right, the commit message and missing comment is indeed concerning.

>
> I assume that for non-subpage case it's working as before.
>

Ironically, for non-subpage case, that branch never get executed for bio
error.

For non-subpage case, a page will only be *added* to current bio, but
submission never happens for current page.

Thus that if (PageError()) branch only get executed for fatal errors
like failure to allocate memory.

Only for subpage case that we can have part of the page submitted while
we're still at that page.

Thanks,
Qu
