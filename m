Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5A401665
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 08:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbhIFGbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 02:31:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:54711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhIFGbb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Sep 2021 02:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630909825;
        bh=tcWx+rI8nzx4rhwjp9tdnrII8ivW/sY7wDDrHGJL/wE=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=d5SBm8OR0XXD1RfiabHwhIiGXk0e0YCIRMXpLCVt2Hu/Tf/rji8ygMAPWZtJXIcSJ
         jECNYPGTT4jb9GTp8VAg9P9lIjaOtPfvhplgGhK0RFtBpqDG5bk+p2FmueCMCt/oyG
         9Q+FEM5JctWkMOkVJNKNqMJOs5Cw3Y1GErMrJUYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXXuH-1mSvbb2p39-00YxPg; Mon, 06
 Sep 2021 08:30:25 +0200
To:     Sidong Yang <realwakka@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210905121417.GA1774@realwakka>
 <526c81c1-1362-e24d-6664-2028c46f6353@gmx.com>
 <20210906055704.GA2467@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: An question for FICLONERANGE ioctl
Message-ID: <3544e1ef-7723-0de2-471b-658bc1ba145e@gmx.com>
Date:   Mon, 6 Sep 2021 14:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906055704.GA2467@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W8t1Hsy4Cze8mMDPDBOBp1mjgP102XkLdMLV1TeuoatixpFhxuQ
 i5CfrENZZxGsHCYBJdL7dCtsGRjKHOeB9NCjXYI6dnVNNLXsuDWIxpESEbLGSxwjga7A5c7
 TRWr6vVQsrpjcorKSlhTLznwesaGbcvpBdixn6eldRMwi7Dj9oAWiNtq581oMKuDTA7JL6I
 gMUO+pSg0eO9ot6yCq6ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sj1F7QYPZdI=:DLGU7dx47CxaadP4ZRTwbV
 ZHie7/gIfoXbjTjY9aI4zrZlOomEsXGFXruPftWg7ox/01cesk6vpe/PMsT+8Y2B19257Rr60
 TIrd4+Fg82ZejofkCVeGpDLfiRBQcijDIyVN1C0iBtH1NwXWyHI9fdU7B4Diwt02bXCLqMLSJ
 mksmgCoeOOmuJTpBocjKfZUYIAnq9zsFs/oFIIGABZXQ76QAfcIjroaiBLEOOa6FNHHOhcpm5
 Q7miQ9zlt9zIugiawGAGETMxr8Mt7aDk//gyWJFwUDkvK8kxw7ZR7bbeBt8QmvOSPlMDTP3Jc
 8Ly8ggsmMH9PF52KNrDTAKApCU134jfd/p5tUEo8BsOl24b6zrdF44AA8Oa7uwDGCh4vw+erj
 XYbV+NRcj1MP19rP96VLiPfiIJrCf4IQpeTWRresL78V+hG7E+MHL8SsOodC6F2NHH6BNPX5A
 8U6+9ngG9khlC+A4pOOZ0AM1pnM6gLnmYlp9XrT3qgRmRm9KBFQpa/oFAt+ll2D1kZnC7/I1M
 b/MOBiFcUgaf2cVGIQYFK/jaq+TPRzTNQbzfzSAHXsKALknQYB+wcU6wq889ootBfgYPXzGFl
 lFWT0HcdMwLWQ8LEa5bQ0K1l9IbZocmTaS4QDLFteDBi0ltixBi1HjB1NFUSuwHx58mLPyE8m
 5CswnZe064vggJcCe2agXK0rL4D1nuHO7nhSWP0a0PlOucuf5AG6wADoeaYbaMlZoha0QvCmY
 AVDSPQk2pZZqF5dAk5JczQBOgJGr6j4URJQYSz1vUBMd8Ho5lbeK/VYmg90DEhZRjOZRvuxr/
 LIpYG7CKaR7ywU9DxX3n0Ko3PWmzv4L14FucP+O6768MaQkAuP2/pdgkohehmIFbLKkfhi+wJ
 ttlpBJd9YXqdp/1kfPxjQXKs4VLfwY7TLx9VwNMDbzgtPKsOxC1sIzjZsDMnp8WSzsBI9sf+6
 rupGpL/4Yg6ossk/UmfqQuOE4o5TPxPU9wzov4d7L5Xaz6ewGBZyJX2WVsV4XC34ikHhwJidb
 fI1Lc5xURMscH+Sb6Cc0XSVpWO+hNTeuO7ofnOJ23d1U71hquM07xy1AiO9SFZi4OMuwcXIJZ
 3AmEB5NDcdVxWdQSS+AxIT76L5jczVbJ8H24vYIQzVLRLzXYpY69y75fw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8B=E5=8D=881:57, Sidong Yang wrote:
> On Mon, Sep 06, 2021 at 09:13:06AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/9/5 =E4=B8=8B=E5=8D=888:14, Sidong Yang wrote:
>>> Hi, All.
>>> I've tried to handle btrfs-progs issue.
>>> (https://github.com/kdave/btrfs-progs/issues/396)
>>>
>>> And I tested some code like below.
>>>
>>> src_fd =3D open(src_path, O_RDONLY);
>>> if (src_fd < 0) {
>>> 	error("cannot open src path %s", src_path);
>>> 	return 1;
>>> }
>>>
>>> dest_fd =3D open(dest_path, O_WRONLY|O_CREAT, 0666);
>>> if (dest_fd < 0) {
>>>       close(src_fd);
>>>       error("cannot open dest path %s", dest_path);
>>>       return 1;
>>> }
>>>
>>> range.src_fd =3D src_fd;
>>> range.src_offset =3D src_offset;
>>> range.src_length =3D length;
>>> range.dest_offset =3D dest_offset;
>>
>> Mind to give an example of the value?
> It was src_offset =3D 0, src_length =3D 10, dest_offset =3D 0.
Oh, that's the case.

>
>>
>> One quick hint to the invalid arguments is:
>>
>> - Range alignment
>>    The src/dst offset must be aligned to the block size of the
>>    filesystem.
>>    For btrfs, the sectorsize is currently the same as page size,
>>    thus both src/dest and length must be aligned to 4K for x86.
>
> I think it's because of this. I set too small value. It works with
> length 4K. If reflink cmd in btrfs-progs exists, Users should set the
> length aligned?

Reflink/clone/dedupe all work based on block size.

Currently all these major files systems (ext*/xfs/btrfs/f2fs) in linux
are block filesystems, which means block size is their minimal unit of
read/write.

For data stored on-disk, they are all aligned to block size and smaller
ranges are padded to meet block alignment.

So is such ioctls (and things like direct IO).

Thus no matter what the user-space wrapper is, the kernel ioctl still
requires block size alignment.

Thanks,
Qu

>
> Thanks,
> Sidong
>>
>> Thus a more detailed example can be much better for us to understand th=
e
>> problem.
>>
>> Thanks,
>> Qu
>>>
>>> ret =3D ioctl(dest_fd, FICLONERANGE, &range);
>>>
>>> And this ioctl call failed with error code invalid arguments when leng=
th!=3D0.
>>> I tried to understand FICLONERANGE man page but I think there is no cl=
ue
>>> about this. I traced kernel code and found out it goes fail in
>>> generic_remap_checks(). There is an condition checks if req_count is
>>> correct size and it makes test code fails.
>>>
>>> I don't know about this condition but it seems that it can be passed f=
or
>>> setting REMAP_FILE_CAN_SHORTEN. Is there any way to setting remap_flag=
s
>>> in FICLONERANGE ioctl call?
>>>
>>> Also it would be pleased that if you provide some documentation about
>>> this.
>>>
>>> Sorry for writing without thinking deeply.
>>>
>>> Thanks,
>>> Sidong
>>>
>
