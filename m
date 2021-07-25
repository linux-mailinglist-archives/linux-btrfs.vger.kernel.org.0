Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867C3D50AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGYXKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 19:10:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:35919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGYXKv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 19:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627257077;
        bh=Y7tGCmkXPNlojXylk4iC2Xy35JHIFDxLrrMC07yE3tA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B4kTBawWZqRtTM/DuiBAEsoWXCbQD6nDTCiuj7Mjs9/gfNQk6tzy8Jyfof2FTmSNP
         EtY8K/siTIIoJAZqeWQAKc+xbzGM4bXBYbKMISzyUo3Rjv4Yd1wExoqfk5xbqER5Yo
         YZuLQuxtLqD7Dgm6vo5O2RERj8hZbqzMa651s4tk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1l9dCU1loE-00zG8y; Mon, 26
 Jul 2021 01:51:17 +0200
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Dave T <davestechshop@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
 <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
 <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
 <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
 <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com>
 <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
 <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com>
 <CAGdWbB7XqoJaVsdbG7VkvSj78hVPt-HnZxOw_nvX7GaTziaiwg@mail.gmail.com>
 <062c20ad-ea9f-f83f-ce49-0a82668c3c6c@gmx.com>
 <CAGdWbB6KmDgsd2jKn65=H9W76aHNSVP_kZzqXMU8hV13R6seJw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c2e346de-4f07-80b9-3b40-75fe0481f09e@gmx.com>
Date:   Mon, 26 Jul 2021 07:51:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB6KmDgsd2jKn65=H9W76aHNSVP_kZzqXMU8hV13R6seJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5SMjMDy2D5SKYPaOq/exeO259dB5afTli6uhUbHWfU534FpNRw
 jD7Y4ouZ4UTkTCDnV5+87Syt8TvnB4cRo7Gqq7uhBrzRi38DrXInhebFy6ZS/VZVL2vVzvg
 8WgXaz8Xb7eU+QZ/coXj+KbwDbDE5Srup8iPLyx6Pi31u6cEwFVyR09by720CqOfn0n15+x
 ffrwzI5c1QFgnlo2oCh2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OX6R8r3ioGY=:5cVhHrNxKcoHwCWn11ydNA
 konMYRh2pgAa5k8hwebzXiXdCkU48V5b7t+5dkIZljh/UUYfGukcfTJiJ8dJEMaTckIGqgi1+
 ttb2nCB5DqkQ920OmprUEkw7lz95DxHnpA3tduDyulxZDl4+E1KW8tGF6KKXwEJqZNE5e+KCy
 eB7Cd2wQJJMVA7bE4OM3WwcSozdS86ylAgSL4uJjVtc1J8Zr6Or5XAgIPHF8FrumFgoGF5386
 n4Bjm9BqNjjcGUU73qBbJMF5SBlYkBglYAnV3Y+Lveu3GN/9aIY0DQZsXkiKGLceJA/DRBY0w
 YdeBo9ZnenlrmOEu4T1zPXI1kYnf1O7+BqU6Hlc5Y9TJ/7qK5q0TMkTLjbfFelSv8A+OUOgh6
 taO52HGfScPnRKhL6SOLIR9jXinJ3o3GWsX5FjddY0laaVqj/kGcdRduh1+aErfL9JXhFrb+L
 bI3KWORf92ZPZ5y2PK9R4MgkdUthquiD9XNsOdY12HbT9Km/jSTyqA9r1OJb0QiAgN5qW9fgH
 zsL+Zrg5UbgXVF5sXezV+JK7MjlKl6lrB4xWO60IvgPhKj1dxgBJA1aII5RVhKFfFnawnsLe+
 R7ZAqulR3dzUvFk3E9//y8u1xF6e8GmnMg4Rs/gVMqrIv/WI5pCtW+G0RCosrB1u6TXB00oJi
 KI2xXFRuWpbaa/56e/uZo8YrLDEqmLaEHBtJPm3sYdJqtAQkX4RKGZf9d4j5sI9iP2fHPUh+f
 u+Cba8uhz23A5yg70yFJmV21JKzhHXi0i7n6mWcAucnu9YrRrp77nVCqFPpHH0zbBJoQjVR/Y
 NPfN1mmURygjOxTGjwwOQJ2Dcqs8VmdWrdIB5kSW6xl34oRtmxMaAY+tYKkv3XqTJHbriAV8v
 r/6Ej1BPP4KDYYVJK6NVnwIkuHtRsGJPePGNzT8jnIBN8qi32lIsO4P3A97adeZAHPkJ0LgJm
 y0bV4G8Bm7nK1bkdVl7r2GBm6fTIv6rAP9ko2bb7vvPNqr/dy1v6F3QaYida9MUvq4eNtISsG
 dGbtOvmv3ATGTH0Iczr44xvROHVyN644WVT+V0DhAQAZPggxHEZz2/54QEwFq5Ksi2xWn/MTr
 02NsHBeCyN9z3iU+VfKvtpM5XRvJc6eXoPT4m9jyQ4zgclhaYyUAxkczQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8A=E5=8D=881:34, Dave T wrote:
> HI Qu. Was the information I sent helpful? Is there any final lesson I
> should take away from this? Thank you.

Sorry, nothing much less can be provided.

It mostly looks like btrfs check --init-extent-tree is doing a pretty
bad rebuild of extent tree.

Thus I won't recommend it for future repair.

Thanks,
Qu

>
> On Fri, Jul 16, 2021 at 9:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/7/17 =E4=B8=8A=E5=8D=888:57, Dave T wrote:
>>>> But before that, would you mind to run "btrfs check" again on the fs =
to
>>>> see if it reports any error?
>>>
>>>> I'm interested to see the result though.
>>>
>>> First I will send you the full output of the command I ran:
>>> btrfs check --repair --init-csum-tree /dev/mapper/xyz
>>> It's a lot of output - around 50MB before I zip it up.
>>> How about if I send that to you as an attachment and mail it directly
>>> to you, not the list?
>>
>> It works for me either way.
>>
>>>
>>> Next step: I have remounted the old fs and I'm going to run a scrub on=
 it.
>>
>> Scrub shouldn't detect much thing else, but it won't hurt anyway.
>>
>>>
>>> Then I will unmount it and run btrfs check again and send you the
>>> output. Again, I'll send it to you privately, OK?
>>>
>>
>> That's fine to me.
>>
>> THanks,
>> Qu
