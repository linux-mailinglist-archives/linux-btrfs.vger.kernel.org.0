Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800DF3CC015
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 02:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhGQA2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 20:28:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:54863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGQA2t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 20:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626481551;
        bh=fbg2i83pJsFzqZb63E7/GOtb75lp1La/z8S8ysZVYOk=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=LsOzCTbcTU6F15O59yJJ0n8KCwDKsh5ApL3p3Druh/qlCd9JdGy81bA19ir9dxr6u
         IXkHIYriWRuokd5e/GB3zs8PBAFeTcf77AjYeWslXQM7Zq71eJkT8Bhw3Fb2lIGXIS
         Sf4//XgldktM/06AB1pzwJ0ZT4uGrHr2omnL/xro=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYc0-1lPPqS2YkI-00lzbj; Sat, 17
 Jul 2021 02:25:51 +0200
To:     Dave T <davestechshop@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com>
Date:   Sat, 17 Jul 2021 08:25:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z4BYzcRCIbXdrG2kxNB2CHKnVVP3VzHyynOiYrLxWiSQptsqaBr
 1ggDqopb1V/ANQUHfN6ZTbUSjxHkQHgsaLYT/MJre4y6MNOeDIdLVmAbb4eY5YCRhynOCL8
 OD/PpP3gqoqjF6fWUs49Jgt4k9YX5XTCfTeRipj0McApv6m1yxNwc4KQVzpCAoRraHGv5gw
 MyN8oxhAmaCI9rFR2Jj0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/uBakP9ieCU=:r0Y6GESboh/cgbBcV3aaQd
 odDCHB1QKG3ylZT68Fm+OaJiHQpMYotHaYMDdE5APlnA1xnY25UFFCzK8ML+O8hb2LzB2hukq
 XBCa14JBMCHpfQaRGzx3XX8hkRgncO522SZnqBEYJy1P083zfUsIXyUmaqA0YajsEIlOhCnQO
 oLbA4eRgEsmuvlG2iQH5ADdPf8iHCfrTipITmQgxNK5g7IyPIm+/AM+v7nbVJ1LMcaYlQx84l
 8Hqaa+sHVR5pE2dFd77snCa09TOtw1S3eB0rhLuobPwxLcK6S4m+e6Uz2KAbgJZTlwUJ7OioM
 2iodN6AHpcEbKmSY+UVZNNpjMPwOZHoAvE/ej0TE9LOqZYwEzDnqQPYttJ3ntJAEu5jh3vjn5
 dC3JFyDHBg5idloDwDYW3+NZc8mdfU8FgQ9g71bOTgujgpgq/wk2orDymZeWPr/eVWHGEERU/
 hnKeZeSOq66nGmMdTRpUgTpixVaugVPpFij6hYu35NK9v9SF9Pjt6QGdA7DaQQLUjZt5QwQv1
 wtok9yu7fWroyvMiTrSJ9nm0hhnk1MdwpwstfH+RaP3/nmCiNdfGaa6wKdObdHXubm8qEdubQ
 rXauXrvN2Xc1U0AVKIwlYvvByF6qOAtqb3lEB0FLf/rWf1oOd1EjAurNUy6dohpFdi7C6j2kQ
 9wz82CQ7H3GXmoTjnxsgeQtDIKPjrkdNhgIunSuGNYTNxyHg6iwAtzH6pjhu8XiTMecYg52lU
 7a4RlAh2pCJz/RhSBcujYiqi7XwqUqxHsi2XYtxQOZ/6fP1pBuxwIeg22AOaGT0KSvybyoFZE
 JTbLQxChhrzqEZH4R76JuP7MY+2LQgBj6aNTJSU+96r72GEO8TRXme7Ri6W0kE1M34d+LkqUY
 8RK8AaJfXKEa9wVHrDzjXS8FaLbeJOz+n7NhrTG9IFT97p78aYrxnSJZB8t29R+os+vAOoEis
 Hqx6A8Mw5UsbwNNpk6OYs4TVdbS/+ARBLkF83Z/lb5IDfNZn72NKENJo7rMY2mQuToauyrANv
 fwcCXBixYss3OR8zWcRGvhA/To6HeLWaFyymdhLBWljC4nmfKIoKxso0Za9IcVMMjt9lcqFJ3
 Ns0CuWMx31nMAwb+JWt3xUrywg/UX6LmpUcusWhOqnTFSY+iIS1C1Tcrg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8A=E5=8D=888:18, Dave T wrote:
> On Fri, Jul 16, 2021 at 7:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>> So far so good, every thing is working as expected.
>
> Thank you for confirming. I learned a lot in this discussion.
>
>
>> Just the btrfs-check is a little paranoid.
>>
>> BTW, despite the bad file extent and csum missing error, is there any
>> other error reported from btrfs check?
>
> No, there was not. However... (see below)
>
>> It's a pity that we didn't get the dmesg of that RO event, it should
>> contain the most valuable info.
>>
>> But at least so far your old fs is pretty fine, you can continue using =
it.
>
> ... since you don't need me to do any more testing on this fs and I
> don't need the old fs anymore, I decided to experiment.
>
> I did the following operations:
>
> btrfs check --mode=3Dlowmem /dev/mapper/${mydev}luks
> This reported exactly the same csum issue that I showed you
> previously. For example:
> ERROR: root 334 EXTENT_DATA[258 73728] compressed extent must have
> csum, but only 0 bytes have, expect 4096
> ERROR: root 334 EXTENT_DATA[258 73728] is compressed, but inode flag
> doesn't allow it
> The roots and inodes appear to be the same ones reported previously.
> Nothing new.
>
> So I experimented with these operations:
> # btrfs check --clear-space-cache v1 /dev/mapper/${mydev}luks
> Checking filesystem on /dev/mapper/sda2luks
> UUID: ff2b04ab-088c-4fb0-9ad4-84780c23f821
> Free space cache cleared
> (no errors reported)

This is pretty safe, but can be slow on very large fs.

>
> I wanted to try that on a fs I don't care about before I try it for
> real. I also wanted to try the next operation.
>
> # btrfs check --clear-ino-cache  /dev/mapper/${mydev}luks
> ...
> Successfully cleaned up ino cache for root id: 5
> Successfully cleaned up ino cache for root id: 257
> Successfully cleaned up ino cache for root id: 258
> (no errors reported)

Inode cache is now deprecated and rarely used. It should do nothing on
your fs anyway.

>
> I have never used the repair option, but I decided to see what would
> happen with this next operation. Maybe I should not have combined
> these parameters?
>
> # btrfs check --repair --init-csum-tree /dev/mapper/${mydev}luks

This is a little dangerous, especially there isn't much
experiments/tests when used with missing csums.

> ...
> Reinitialize checksum tree
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> ref mismatch on [22921216 16384] extent item 1, found 0
> backref 22921216 root 7 not referenced back 0x56524a54f850
> incorrect global backref count on 22921216 found 1 wanted 0
> backpointer mismatch on [22921216 16384]
> owner ref check failed [22921216 16384]
> repair deleting extent record: key [22921216,169,0]
> Repaired extent references for 22921216
> ref mismatch on [23085056 16384] extent item 1, found 0
> backref 23085056 root 7 not referenced back 0x565264430000
> incorrect global backref count on 23085056 found 1 wanted 0
> backpointer mismatch on [23085056 16384]
> owner ref check failed [23085056 16384]
> repair deleting extent record: key [23085056,169,0]
> ... more
> (The above operation reported tons of errors. Maybe I did damage to
> the fs with this operation? Are any of the errors of interest to you?)

This is definitely caused by the repair, but I don't think it's a big deal=
.

>
> I ran it again, but with just the --repair option:
> # btrfs check --repair /dev/mapper/${mydev}luks
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/xyzluks
> UUID: ff2b04ab-088c-4fb0-9ad4-84780c23f821
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> ref mismatch on [21625421824 28672] extent item 17, found 16
> incorrect local backref count on 21625421824 parent 106806263808 owner
> 0 offset 0 found 0 wanted 1 back 0x55798f5fdc10
> backref disk bytenr does not match extent record, bytenr=3D21625421824,
> ref bytenr=3D0
> backpointer mismatch on [21625421824 28672]
> repair deleting extent record: key [21625421824,168,28672]
> adding new data backref on 21625421824 parent 368825810944 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 309755756544 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 122323271680 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 139575754752 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 107060248576 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 107140677632 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 107212980224 owner 0
> offset 0 found 1
> adding new data backref on 21625421824 parent 771014656 owner 0 offset 0=
 found 1
> adding new data backref on 21625421824 parent 180469760 owner 0 offset 0=
 found 1
> adding new data backref on 21625421824 root 26792 owner 359 offset 0 fou=
nd 1
> adding new data backref on 21625421824 parent 160677888 owner 0 offset 0=
 found 1
> adding new data backref on 21625421824 parent 461373440 owner 0 offset 0=
 found 1
> adding new data backref on 21625421824 root 1761 owner 359 offset 0 foun=
d 1
> adding new data backref on 21625421824 root 280 owner 359 offset 0 found=
 1
> adding new data backref on 21625421824 root 326 owner 359 offset 0 found=
 1
> adding new data backref on 21625421824 root 26786 owner 359 offset 0 fou=
nd 1
> Repaired extent references for 21625421824
> ref mismatch on [21625450496 4096] extent item 17, found 16
> incorrect local backref count on 21625450496 parent 106806263808 owner
> 0 offset 0 found 0 wanted 1 back 0x55798f5fe340
> backref disk bytenr does not match extent record, bytenr=3D21625450496,
> ref bytenr=3D0
> backpointer mismatch on [21625450496 4096]
> repair deleting extent record: key [21625450496,168,4096]
> adding new data backref on 21625450496 parent 368825810944 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 309755756544 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 122323271680 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 139575754752 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 107060248576 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 107140677632 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 107212980224 owner 0
> offset 0 found 1
> adding new data backref on 21625450496 parent 771014656 owner 0 offset 0=
 found 1
> adding new data backref on 21625450496 parent 180469760 owner 0 offset 0=
 found 1
> adding new data backref on 21625450496 root 26792 owner 369 offset 0 fou=
nd 1
> adding new data backref on 21625450496 parent 160677888 owner 0 offset 0=
 found 1
> ...more
> It reported many, many more errors.

At the same time, it also says it's repairing these problems.

> I'm not sure if any of that
> interests you. My plan now is to wipe and reuse this SSD for something
> else (with a BTRFS fs of course).

That's completely fine.

But before that, would you mind to run "btrfs check" again on the fs to
see if it reports any error?

I'm interested to see the result though.

>
> I'm just curious about one thing. Did I create all these problems with
> the repair option or were these underlying issues that were not
> previously found?
>
It's mostly created by the repair, as --init-csum-tree would re-generate
csums, it will also cause the old csum items to mismatch from its extent
items.

It's mostly expected, but normally btrfs check --repair should be able
to fix them.
If not, we need to fix btrfs-progs then.

Thanks,
Qu
