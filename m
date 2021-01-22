Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2802FF995
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 01:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAVAvD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 19:51:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:44453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbhAVAvA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 19:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611276567;
        bh=4nzfo6CkEZlhMrNYA8FEn1zogEt8jnuhyD/UpcNbjv0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U/53U2UzuH392ONXUtp4sP51q82JBzszPo/gipgoB2jLpPGnN8l+/p41GKtOcOnYs
         890Nho7WZ12L47nRnWLLR3HV9vrMNzP1+Ej/Csw3nrON6tpkxqNqGqKQ385OXvOCUi
         S9hZY5ktavoN9BsOK6BTrIcVgQZ22YkOXJ4DghpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9uK-1lJs5E3V3a-00I9Ur; Fri, 22
 Jan 2021 01:49:27 +0100
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        linux-btrfs@vger.kernel.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
Date:   Fri, 22 Jan 2021 08:49:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/PonhmypvQBobyTnXHWkRs/RpDBaZNTzR1nm6lRS4PC7NZnab0/
 yNZJH9oK47mQIVaGXVSNkb2TkiyeIGPqNf8mo6s74oWpvOi1JpSrmIFNMTY6DsdKyrXfoUC
 yI3VxUq1W15BvSlKzY8IVgibQyvUZ8978jGXIXizqH6g/Y0oGLZ7pI+f5WnkcmlWzHUuSB7
 YiOWuxHLpUu8aNEvgI90w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I94hfk8mw4c=:MpJBrgvlDS8SSy8gF0FDiy
 oAxxoZffZ3rOYuMESLv6s5FRZV81FEAb8Q8Dv06psBei0Sg5rEoeZ1w5Jgzj2ILnAHJOyfWIV
 P+2vxoJ6G8Gurel3T0CJRIdnEdjVh/kl3qmIahWWUOi3+DlUy39u7a9WucamdhGlJMTA/Qbt6
 ryvyivXHkgxrPzaEB4P+Sq0zhkO3/SB9O/eD+5ihLW/kBXbSSP4asCXOrJFmAX0HGPykuASck
 QPsApUDevenCUcNrw4ZxN6MXq/XejOEaCte38sr1xaZ/AziaIov94XCnJqhim5EXWbbShxDND
 SL75Mv2pjtXfzqGvnQbO7kreAmefmk+ZyflXFL+oEIM8H1xomFdo58GA5t1sjPVOqEAhjZ0Tg
 jyUjfeveJoVHSir784YG9KU9FRY0wvRwl7p+hz+jgpEjbma3xAn0o9NN77MK3lQ9gbdOzD+Uc
 wM/WcWWSIVTt+XDG+1yPg55LVx3gkX5kNncXRQ/IsG/VPl6tWkei03BFuDorcofqCbe0gsUsA
 E+29xT7Y+IwA8UQsuZtkb7KZENCtG3mlgelIAxRVlsP3lhaXFTrGO2qzv+JQ4QYcrDKpfjjzi
 kj0zlLIyxdKngdOBBN4avgKbkdYlk8kDORhG1sfrq2QbZ1zBs7RxyLy+KiKWuuOyXwQsWfuPt
 333tq3cAVA5g/DjMuyR4esnXUQZ8ZevKwGy2ry6O2UhnTKsee2v7SG9DFFa+TTCjit+7YE3gZ
 /5j4pkmUyuhVItxOUe3S2yNfDMt+odlY47p0+mo1pQov/LYisLWfjgXBUJ8AOaAcMkXUMubzo
 ELUitFW5706s4M4+5AWmA/U/iIfGBatxJ2W1E0RJr3cDHxCymYMoFDhzVUzY53UNXPJrVrNrv
 sGrtu+5zn0CTrzgRyE8A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/22 =E4=B8=8A=E5=8D=887:55, chainofflowers wrote:
> Hi Qu,
>
> it happened again. This time on my /home partition.
> I rebooted from an external disk and ran btrfs check without first going
> through btrfs scrub, and this is the output, no errors:
>
> ------------------------------------------
> [manjaro oc]# btrfs check /dev/mapper/OMO
> Opening filesystem to check=E2=80=A6
> Checking filesystem on /dev/mapper/OMO
> UUID: 9362ac9d-c280-451d-9c8a-c09798e1c887
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 137523740672 bytes used, no error found
> total csum bytes: 113842816
> total tree bytes: 1740537856
> total fs tree bytes: 1444249600
> total extent tree bytes: 143835136
> btree space waste bytes: 325744995
> file data blocks allocated: 210346024960
>   referenced 172314374144
> ------------------------------------------
>
> Then, I rebooted from my internal disk, everything went well. I ran
> btrfs scrub and also got no errors.

So far so good.

>
> I have dumped the messages from journalctl, and the debug ones related
> to btrfs were only the ones from btrfs_trim_block_group - so, the issue
> is related to free space extents I guess?

Unfortunately, without the crash output, it can be anything.

>
> I have attached the logs.
> You can see that the last line:
>
> ------------------------------------------
> Jan 21 23:57:25 <***> kernel: btrfs_trim_block_group: enter bg
> start=3D26864517120 start=3D26864517120 end=3D27938258944 minlen=3D512
> ------------------------------------------
>
> does not have a second matching line with "ret=3D0", because the kernel
> stopped storing messages in the log. So, I guess the issue occurred
> while btrfs_trim_block_group was working on 26864517120..27938258944.

If you have some machine running 24x7, like a RPi, I would recommend to
setup netconsole to catch the full dying message to be extra safe.

Or setup kdump, to catch the dying message.

Personally speaking, netconsole would be much easier to setup though.

Currently with truncated journal it's really hard to say.

Thanks,
Qu
>
> Unfortunately I did not dump the output of dmesg directly in that
> moment, so all I could get is what was available in the journal after
> the reboot.
>
> In the log you can also see that some time before BTRFS detected that
> the space cache for dm-3 needed to be rebuilt:
> ------------------------------------------
> Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): block group
> 82699091968 has wrong amount of free space
> Jan 21 19:29:17 <***> kernel: BTRFS warning (device dm-3): failed to
> load free space cache for block group 82699091968, rebuilding it now
> ------------------------------------------
>
> Any hint about what I could do now?
>
> Thanks! :-)
>
>
>
> (c)
>
