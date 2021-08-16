Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC393EE045
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhHPXTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 19:19:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:56077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhHPXTF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 19:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629155911;
        bh=c1tchjMKJTC95YJ8I/HnObTGjfycL0yB5bPqwDH5izc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TjULnUO2GdaVAf2eyXkl6Si67HTOuUuHEhui5+0fqkLG0VmJPPYXlHdMaI6flDfR5
         nXQp0qpgVIo1ckfgDd/zeOhA+cxR5KWvp3CWqnDwmvEj0B5XRc4M6xpR1y/hj6ECCi
         BCnRejyFYaxCH4ZN6TzFidga4uq9u/7XB7SFZAi8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUowV-1mgLHb1cv3-00QlXx; Tue, 17
 Aug 2021 01:18:31 +0200
Subject: Re: [PATCH 2/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-3-wqu@suse.com>
 <bcda08a2-c014-10d7-64c8-1ac29b0f43ab@suse.com>
 <417cfed7-e7c6-8c51-254b-7a76533b96c8@gmx.com>
 <892a4b32-a2f9-56f4-17b8-a494c287dfc8@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a1377a7e-bb7a-6035-92a4-567b285050f8@gmx.com>
Date:   Tue, 17 Aug 2021 07:18:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <892a4b32-a2f9-56f4-17b8-a494c287dfc8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8RQxW3JJJVcBK5Il872p4i/taTZSubYeUqGmFkEFJGri+6hwl1v
 OwOJqnxcbu5O+W6jiQgKLXDSbbgvU913BnHaliSzrIwCnmL5CO4LToWI2d4ZrYgDj9pb7iV
 I6QB+h2kRJN0PdEx0Vl2pF0hbxvjhYIavL+e6+gJUa9SnBR1yhrB5+r2Av6gj8x+fmS08jk
 w3fCnrlkvakICdgDfukTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZaJFyZxDeKg=:l88p7xuWJZxvg3vDJHm6tc
 jqf9phHCfxmJtG3UkM/l7ZkCc0Io+wAG8FZOutyZco9yDHI/pAmuBCsE23cXNGWSYGmJOVKQ7
 fu8B9tIqs2OJVGRRBdmhKtCzQaqHzo3ED3GsveSwiGtMfQZvaGc2sxxbv71imGStVawzIgqGK
 isOyS+gxjlT7dYcubfxBKfk/u5c0ClxfiPq1zp8zliFl01/0o5hg4h+nXEYuMr4NyFDrB40ka
 82V5zYVW66EfJdFBJXUOx4+z4vIDF3FMSAuI6uF+51+T3DkB4NMAKKN81nsdrOQ6583dzfzrV
 Mx3zZA9NNysQZaD5TQN1KwvBK/h7IUupY17uJx9iDwJj5ejWPspC7JSMD43CpCM7BfFhtN//A
 fm+o3QrLClNbrdPy0iH41Pgp8T/DNRigt2b4WwpZiAxwidRUR2W+Szx7tlNNm7wCdJ3H7Cpv3
 vxHw3LgPO8vkjt9YN4JPOhMb5Ft2Yzyvh41zgYfCT7NGC6MhRC8Xqw9dczHJ9WH0Ne58kl1aA
 JmsaqvJmsm0GKXP3rkyYZkZLOScre5GOK0VJLjsido2nfNmM7aLw6EeTuZdvVYkfxMStByL5+
 l1ygMpqNF6HQgZClHACyOvZ2XZHX+wnr7b6FI9+Nl3KmAHupe687rFuR22kjaHl5d1QD3vAiP
 BKXdBsB0T519/shfaaOw3HiguFWI0YEnB1hXhjFNob9gj7C/Jnh9CwhfRZyJBDSllgsNbg3Yc
 eAZRQGQixWs9eX9A08qHDkfkmwtP3U2pi49Jan+vVa/T/iYJgzkJS2tnIpL2x13wZPZwCNGIS
 jPyShfGMge+hTe3Y8DsAyFCrfozpwy1GCj38EOhvLixgw287cbWnbwymap1vzFSCjN2lulYHQ
 rYay912ZuWt+ELZFgp4NeRGl7WIdWcXFAxWiGY8ZK6lPp4uX8T4mEi453HRfz1VpYsvch9w2Y
 RcCs2bHtOjvQdRS8vDxFt3bk+f9z7Xexi1V+pu4z6typaIXvDn61xtz+h3FXBBoxebZWqn3/c
 fc8fTAKp7LZput6K+XeDY475iLHrSwBZdEpOJmHjdvpE3+qbWshyy8RwCuyBNgKN1/sTqwVY4
 YzHphiWI51mMBjljLgcbLEjyE1gMTmAbmhwKW4SKT2ncWlphwgrVuAHLg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/16 =E4=B8=8B=E5=8D=8810:27, Nikolay Borisov wrote:
>
>
> On 16.08.21 =D0=B3. 16:41, Qu Wenruo wrote:
>>
>>
>> On 2021/8/16 =E4=B8=8B=E5=8D=886:26, Nikolay Borisov wrote:
>>>
>>>
>>> On 16.08.21 =D0=B3. 9:00, Qu Wenruo wrote:
>>>> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
>>>> size.
>>>>
>>>> But this u16 bitmap is not large enough to contain larger page size l=
ike
>>>> 128K, nor is space efficient for 16K page size.
>>>>
>>>> To handle both cases, here we pack all subpage bitmaps into a larger
>>>> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
>>>> subpage usage.
>>>>
>>>> Each sub-bitmap will has its start bit number recorded in
>>>> btrfs_subpage_info::*_start, and its bitmap length will be recorded i=
n
>>>> btrfs_subpage_info::bitmap_nr_bits.
>>>>
>>>> All subpage bitmap operations will be converted from using direct u16
>>>> operations to bitmap operations, with above *_start calculated.
>>>>
>>>> For 64K page size with 4K sectorsize, this should not cause much
>>>> difference.
>>>> While for 16K page size, we will only need 1 unsigned long (u32) to
>>>> restore the bitmap.
>>>> And will be able to support 128K page size in the future.
>>>>
>
> <snip>
>
>>>
>>> offtopic: Instead of having a bunch of those checks can't we replace
>>> them with ASSERTS and ensure that the decision whether we do subpage o=
r
>>> not is taken at a higher level ?
>>
>> Nope, in this particular call site, btrfs_alloc_subpage() can be called
>> with regular page size.
>>
>> I guess it's better to rename this function like btrfs_prepare_page()?
>
> There are currently 2 callers:
>
> btrfs_attach_subpage - this one only calls it iff sectorsize !=3D alloc_=
subage
>
> alloc_extent_buffer - here it's called unconditionally but that can
> easily be rectified with an if(subpage) check
>
> <snip>
>
>
>>> 2 argument of find_next_zero_bit is 'size' which would be nbits as it
>>> expects the size to be in bits , not start + nbit. Every logical bitma=
p
>>> in ->bitmaps is defined by [start, nbits] no ? Unfortunately there is =
a
>>> discrepancy between the order of documentation and the order of actual
>>> arguments in the definition of this function....
>>
>> IT'S A TRAP!
>>
>> Paramater 2 (@size) is the total size of the search range, it should be
>> larger than the 3rd parameter.
>
> It's not even that it's the end index of the bit we are looking for. I.e
> if we want to check bits 20-29 we'd pass 20 as start, and 29 as size ...
> This is fucked, but it is what it is. I guess the documentation of the
> bits function is dodgy...

Well, the size part is not correct IMHO.

Just a simple run could prove that:

number=3D0b0011100010111010101010001010011
find_next_zero_bit(&number, 3, 0)=3D2

In fact, if you pass 29 as size, it will not touch bit 29, and bit 28 is
the last bit to be touched.

As that function will return @size to indicate that there is no matching
bit found.

Thanks,
Qu

>
> <snip>
>
