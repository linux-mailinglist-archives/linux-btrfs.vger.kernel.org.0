Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53875432D4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhJSFiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 01:38:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:33111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhJSFiH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 01:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634621753;
        bh=5GXDVKafFfBUciIErPJo+7yAJHtYtbbRhuiX5XII8E8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=D9+rpKMUcjrJ6NbYFDzHoEMf1H0ho/saTPZBhA//Bo2C711o7t5BA5cfLeZSVcSKB
         Vkt20N6wlB1p7zzmYzhtxp/6HaSzXMbG0vS3T4vEzvRVdOGgoLwYyckTpRjdghxyYH
         UsDb1t6fJb7MLENjUoYfuVjLaj80vX6skA6mm7Mo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1mBj0U3RCc-00R0bA; Tue, 19
 Oct 2021 07:35:53 +0200
Message-ID: <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
Date:   Tue, 19 Oct 2021 13:35:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Errors after successful disk replace
Content-Language: en-US
To:     Emil Heimpel <broetchenrackete@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QyGeHpu9LosFiEGL7oVYYN3ta9MzNZHdQIDpH2B4KdbYQi3md2f
 tz7GN+2scVl9uUy8COSTWHRFuHLoGmsenKf8e41DXVX6gM7k+FzK0+6KnoFSnsfn/SP4DWo
 kLHeguKrfqMzKVfpEno/WT4owLajZlpiJLii9Woq1aVwqjIbKUrS5GxoC0ckBjAryirmnDU
 8LXAkzZxTVbDTXRDOn9hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGGlfckq7Jk=:uHpme1NdQ+0/xLSvHGxIfe
 XfCYzjDEfOB5M99UBUbav+abM0hvNVxNA+tHP3cz6s+1jm6lZnS9GbFrIgz7pZ5bpkjCPP7Kj
 DJxuoTz/fx8goLiLTsp7/IcWf+ruMA08hT0csLnklnD82JOx8y4v72J2Pd3+Qe6hcUfcLXeA+
 h0DFV/l53KXDLzQhRa3zhw/xZyRVXzyagHH28W9UbBUJghWmVFPC/lDFHkliV/ZctTgI8IqWp
 S5OSfNMhi0qVOsE5+w+XBdUYbY+YGvZu+Jb2DgMEjGum+qDEZi7K3bYJ6i9T9qO8J5HW5T4R+
 vaPNXfg9eHCaQxbrfSBmYt0EPnZVOETDhUXtgPhfZMOBKdZbJCOQBiyUfIVJCJL8L5QG0Aecr
 a3zDu8nxIFOEOkhIjI+Hs8DEhElTEhCL47oRhcmPpFVc+54ZGc+0bvltIJ5LcpMk9odBl7ZQz
 SCxRRiu2kLZ3YuVa1O65EA4clvm+LrIiA7bi6XPFY/6pHDDDAWiyNTd0V7gvScapsRkM6KB/8
 sLbGQ8aXY3Mqfj+DJ3iDMoWJdFm2hUqCSeH6ssasVAfKMo2vBgBa/pmewyqCsgUZdR+/85dao
 Pqo9fCbGrSwtZYTYSptFHJL4cIZrnzlCYb4Ba96bpew/SJqdoyMYzNog8O+A8GXCDsfS2sa9D
 22VGMdLBU7TQ2dX3+NsHzviNlCgkJOJeKI107m5pH+i7vWfAAyPAQRIfM/XFwLmYjIne6M/sn
 FXfJ/Cr6G+pAtO1xBy5LQd8wRcdNcMf8pOMMZYV2Nhl5bQ/owadzJ4oQ3L1Qw+Ox3F5IaL5kW
 TEp0hKlec3VeC1Ygsq4ioj6z3m/QGhrFOO6DcCM6eOv4BMnGXJrdKUxf0f2zgVb6aoyZ5eZUp
 R2Zbi3njvpXbLHzQr+yscBl/I2kJS3+nwWcwUU2emOhzcmQNmcc2GMXBwe5myArMbigtPH0Ij
 A25J95DPS84glxbpkF0pep8U3dSxCEEqY6o0C4t+idteyRbkLmsrTn+8DslakkSgmkQHefU/H
 UIfQvHOacJlv7iVPxMZZakxYYKjpOKUuRguG/ebcm2MJ7j8xvqgT82aMfXSKwDhY9omZQ/sj5
 CdN5W/cmZJI4xI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 11:54, Emil Heimpel wrote:
> Hi all,
>
> One of my drives of a raid 5 btrfs array failed (was dead completely) so=
 I installed an identical replacement drive. The dead drive was devid 1 an=
d the new drive /dev/sde. I used the following to replace the missing driv=
e:
>
> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>
> and it completed successfully without any reported errors (took around 2=
 weeks though...).
>
> I then tried to see my array with filesystem show, but it hung (or took =
longer than I wanted to wait), so I did a reboot.

Any dmesg of that time?

>
> It showed up after a reboot as followed:
>
> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes use=
d 20.96TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 si=
ze 7.28TiB used 5.46TiB path /dev/sde1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 7.28TiB used 5.46TiB path /dev/sdb1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 si=
ze 2.73TiB used 2.73TiB path /dev/sdg1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 si=
ze 2.73TiB used 2.73TiB path /dev/sdd1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 si=
ze 7.28TiB used 4.81TiB path /dev/sdf1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 si=
ze 7.28TiB used 5.33TiB path /dev/sdc1
>
> I then tried to mount it, but it failed, so I run a readonly check and i=
t reported the following problem:

And dmesg for the failed mount?

Thanks,
Qu
>
> [...]
> [2/7] checking extents
> ERROR: super total bytes 38007432437760 smaller than real device(s) size=
 46008994590720
> ERROR: mounting this fs may fail for newer kernels
> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
> [3/7] checking free space tree
> [...]
>
> So I followed that advice but got the following error:
>
> sudo btrfs rescue fix-device-size /dev/sde1
> ERROR: devid 1 is missing or not writeable
> ERROR: fixing device size needs all device(s) to be present and writeabl=
e
>
> So it seems something went wrong or didn't complete fully.
> What can I do to fix this problem?
>
> uname -a
> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +00=
00 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.14.2
>
> Regards,
> Emil
>
> P.S.: Yes, I know, raid5 isn't stable but it works good enough for me ;)
> Metadata is raid1 btw...
>
