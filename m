Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6143C940F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 00:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhGNWyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 18:54:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:55463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236148AbhGNWyp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 18:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626303112;
        bh=Y3n3BOO/PVArOtb7dEGBWjbgwccCj8ceg/NiMfpL78s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jXbRBHuMBVm4T6VY+sEz6utpCYHLhtQEprWhXqudyeTYPMMp0DKIilULKvqUzHpcL
         N50thvjPd2WmjMQnDE4H60zah7OaYJjyOy0vQHqqMkC+57BsrUqIyqCJhaTwqWnecG
         puHAlrxiJ2tNFM7SDYJINcTr+0EHrqVIQ3XTJG1g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1l4Etj24n2-00zqVt; Thu, 15
 Jul 2021 00:51:52 +0200
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
Date:   Thu, 15 Jul 2021 06:51:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mx+7YzUYonIc1saefkqas7wZmAIbxA/FiXqLlWXMSO0wllF2ZhW
 Tpwd5FxWoWanh8toAmLVGEfIyEjrZZq39wP5tWcZEo5JVfWLc2PcuSGEb7EEwbfaDql9H7k
 0mgPGm/bhI2vnrv09JHHKqRZy4BGg4Li3Ar/aNX5RPR2QhwkR2WbFTmyr4EaWd8YksnnKZv
 ITA5AQ1XSaSV/lFXjWQ7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCSaO0uBnPw=:vpsA+/GUw9PxHzMbOGEld0
 Lzl+9wjHFLrWkFPdh/FApbfWFwE3Pi3Xs+YA8FyfDG1hnl1K74sPlBhstYVQUFc1z1T/VFbUi
 B3LdIWBBE4TxsQXnh9nHJljb/vaFhhukVOy9Tbo7N0iQYHouk+5284+qqwYsXx/uyOl+W7tYD
 vWTohi7pGpGPh50yyjXFB045aHzuLD5ZIxKWJ68bueIkrrJQMBB2bPDiR5e6YJo3h+vF65TrP
 gDmINBg7B8VxPu+aRMHb+SPEQS6J4xHi22bSnkAXdb43BkYn5mTelppNlwTlM8C67ee8F2+N6
 qIHNFX5EodEvpjTVyYGUjRIFAKjSaVihEjlK9iwyNRYRuB+LOosT8UzWYdYIQG0B5HGKX6Lsp
 G2d98y346eoEL4vxmtn3151o7giKrO9zL65NSTrdGiwsHj3ZsuHm+2nNwMpvi5l07uecF/J6K
 H+um+P/ojZdI76IIbpL/gaDfW03GKPcCWIZKWoYPu1mkekEk9J10c7uSTLTg/05mniZxh89xC
 HZnKIKxu549zHfuyQSlt8k37R8UThrJ10p7imF3tDW4njmgrao1HB+OhJAQ4ms9KZB4R+SOeC
 iKSUidbDt/EUyvEbt9hmrr2a65iXcw/oC3tfWx4m2z6y3x5/Sme7bPJlYwK+7HQq9XawFkxDd
 DZagqqJRpQp0+wSlGlebTF3BsV5CJmFQangzBB2ZZXTfNNxIGUTfcIq8XmuqNe/bnVFYqFiLS
 Q9CzwJBkFp9a2Kud8vVfL97JoxwvIfB7Iyn1kLeks1cnYAEsaPcOgLG0lmorf9C/HoqQArhuW
 JP1QXQIDICnSL9K+9/gNeMgKApHBrzlyIRySGfNQdSG37+zNEJ21644rhcw7bqKudXNInVAca
 ejuSeW3yKLJ9HQJT3ho5QgAb/EWkWl/RrbGGlPy1Fv/+HPQyYO2gf9qs02IOnUfLJbw/d9med
 iziyKTP5c26P2DCSKg4dXTUdauy9+OJVbRdcKG5KuBzAndXHnet4LRium4HxUvgRbO+WGHcWB
 gStmEOA+6JzSOzw/LEgQDFl/sKcoQpeZJihX9GdHKSLUPOAW1f328yWTItaOB9ZaXpIHnIVv3
 q28/qPiKkP2PmD6WjFn1zqNke3idGce/4U5dQ6J4ZSVVQ28r7ARVTHtQw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8A=E5=8D=881:53, Dave T wrote:
> I was running btrfs send | receive to a target host via ssh and the
> operation suddenly failed in the middle.
>
> I ran this check:
>
> btrfs check /dev/mapper/${xyz}
>
> This shows lots of these errors:
>    root 329 inode 262 errors 1040, bad file extent, some csum missing

Normally this is a minor error, normally caused by older kernels.

The original mode did a very bad report format.

You may want to run "btrfs check --mode=3Dlowmem" to get a more human
readable report.
 From that we can get a full view of the problem and give better advice.

Thanks,
Qu

>    root 329 inode 7070 errors 1040, bad file extent, some csum missing
>    root 329 inode 7242 errors 1040, bad file extent, some csum missing
>    root 329 inode 7246 errors 1040, bad file extent, some csum missing
>    root 329 inode 7252 errors 1040, bad file extent, some csum missing
>    root 329 inode 7401 errors 1040, bad file extent, some csum missing
>    root 329 inode 7753 errors 1040, bad file extent, some csum missing
>    root 330 inode 588 errors 1040, bad file extent, some csum missing
>    root 334 inode 258 errors 1040, bad file extent, some csum missing
>    root 334 inode 636 errors 1040, bad file extent, some csum missing
>    root 334 inode 3151 errors 1040, bad file extent, some csum missing
>    ...
>    root 334 inode 184871 errors 1040, bad file extent, some csum missing
>    root 334 inode 184872 errors 1040, bad file extent, some csum missing
>    root 334 inode 184874 errors 1040, bad file extent, some csum missing
>
> I rebooted without any problems, then connected an external USB HDD.
> Then I created new snapshots and used btrfs send | receive to send
> them to the USB HDD.
>
> Next I installed a new SSD and restored the snapshots. Then I ran
> "btrfs check --check-data-csum /dev/mapper/abc" on the new device. It
> shows:
>
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/abc
> UUID: fac54a70-8c27-4cbe-a8d0-325e761ba01d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking csums against data
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 128390598656 bytes used, no error found
> total csum bytes: 124046564
> total tree bytes: 1335197696
> total fs tree bytes: 1140211712
> total extent tree bytes: 50757632
> btree space waste bytes: 168388261
> file data blocks allocated: 127058169856
>   referenced 142833545216
>
> What else can or should I do to be sure my restored snapshots are error-=
free?
> What additional checks would you recommend on the new device?
> The new device is a Samsung EVO 970 Plus.
> The old device was a Samsung 950 Pro.
>
