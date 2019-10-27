Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F515E62A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 14:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ0NZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 09:25:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:39685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfJ0NZE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 09:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572182700;
        bh=n6m2yg4hCM3CJPw4eL1di0WkwGSMRE3i5J1EOHKJl9Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JT0RioA8gf5seVQ2tOjuU5gp9L/6INF6t6kAP7hJxoas5bq0PY0rk22iKYs/rPeCz
         i6fzPdLtMEExSzICwVdFx/1BhSdEVbr/uGGo3dzMxbs4peVaRM5AFSd//Rdw+xot5T
         n5TGT/VmHu2Xp+6Kw79/zHa1CKGcOVMzarWORTM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.161] ([34.92.93.240]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYXm-1hiGAf0yqc-00m4iR; Sun, 27
 Oct 2019 14:25:00 +0100
Subject: Re: "BUG: kernel NULL pointer dereference," when unmounting
 filesystem hitted by enospc error
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Peter Hjalmarsson <kanelxake@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALpSwpjVz=F_hb9DbVanECsfWOYog2B7SLY=Dy0NvQx=w9voDA@mail.gmail.com>
 <f4037f43-97fb-5a25-52db-2d69ec69f6ee@suse.de>
 <3acc15f7-fe1e-6672-8a89-fba9a09561d4@suse.de>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <29cae854-b5e2-73d6-fc83-51cf1f162e30@gmx.com>
Date:   Sun, 27 Oct 2019 21:24:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:70.0)
 Gecko/20100101 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <3acc15f7-fe1e-6672-8a89-fba9a09561d4@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKrs0GXQhtqwoikFcpHpUVQbU2vAiMCNXG2HOI/i4v+nAsIDqCk
 Tc7owZkHO221zXxRPKx2XYBzFLPZEbVxzF3uJ34p/x0pTefQneaMnrJTYTYs0dZXNtMvV4u
 ZIBb0MQcCVjNtjYI9dQz6BUD+zzyQlTelVrl0C11WUgBCDm9LDWSZz6vkQ6BuLfu4d/c8FV
 GywcIC+rn8nzpTbOCvgDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ckj/CFFFyUg=:hvRuBMGkh3fZ585wmOniq7
 Y7MSxBPmgys/k2k4RjmlxGj8QPyJx1JWXHWAD4FpfkHr1NQ38cnuc1FArndYj0XUjuDpdJjCi
 3BhSllyQHcjDdWSBvGIkRUjent+aMGgpCYu57o5YFFi6ifFpfvbtX0/AEbzvZYm8fd+cLDkBK
 VbiRYI4ww6nOt32Z7LXOOQE3TFl34Q0iqvhCm+kmtiDTGtbV/JF+kfiEZx1lV8RcQdCWgaIQZ
 SyWkSFwEeRsDCvJnwuvFwenDNmN8MLuSBdnQuotj+iOxOmaVOywa4kYsfo0BpZbzFaLK1S2JG
 UGFNX97onOL5f2PA9yTozwr0AL2M5H/w4mC7iB/MT273KLXULiiiJZds2MZ2whBPtRL70KVvg
 nUzFzLnZnRJWVS+6T5S4TPdt53l3fw73t75J9z5yGP6HTwbyIJqteKKOcygSDsO6/mh22q+gr
 14cSzgJ6etMUbSqx+ts0Wuq0yvEf+d8rsyL6q8NVGZy8/OeZFefi+Drq2Lkx/2La6ioepdQIb
 YXfvG9q7+T5LXgYoIUiV/9xDNjtNhauf00k+W5SzynwU5lr4/U3ayfU3UwOuokSIp2S0h/+/Q
 TM6YbTiZMzT1X6lkVvGye8E9B9mePQubqEHwsGiRrRlciUxbClFWso7U2/uujbki2m5hQCVOp
 q40oV2opYF6So0SrKnWzkyaRKAPYLPd7D6sosIB/OFfgO26CPkGEeHc52lrxji4HBFWbJ3hIt
 lLTzyd3a7rVl2HDmEFoesO0YPJJz/RAwFJgYl2oP0ChbwRhrHZlmP2VHy1WXDqXiaPFZib512
 Ir3kvPtRWwgl6lgs5TifgZHXaeV8nhLKSVhIMCHo9Gol2oKGCEGSMYHboFrXD6JZE41F01Ho5
 4tEOFWqHuGt+EvDege+fwmnwSZjer9wpekQzBbo1MQ7x+E6o6uoA6tR8SBlNyvB9Q5YQB+KzT
 4bf9mjCPfv2r41cWRBf4jlCQJN60Ga3zXAlQ5RQgOhDIS7tzLlKyqXblvo6f+WLAoUG4YKMnQ
 7i9viH0M7Z7PMDfYPcEhnku2UojjUy2c9og7Pc31vHHmsTiJfQVYhalJeddUHM7+woW7Q54S5
 n5tg0AM0QAW4RBtbmDtIzLm1odWW7LSGwEFWmjuex+RSLf1LVk2jAWVFeftgkmNpH+l0nLJki
 BdDJIr8mO7SpdVHcZC41a2DhPCcf5phQPE8TGesJ18azQ/qsh0uaehd0DS0ZQ6l00AHLdX1yN
 w9pUmt6mr6/jvLTzQnWSs8KmElOfMCDtTHHM7ulIR0wt9uxCON3Eu1gM06H4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/21 10:32 PM, Johannes Thumshirn wrote:
> On 21/10/2019 11:17, Johannes Thumshirn wrote:
> [...]
>>> -----
>>> $ cat run-btrfs-test
>>> modprobe -iv zram num_devices=3D8
>>> udevadm trigger
>>> sync
>>> zramctl /dev/zram0 -s 8G && \
>>> zramctl /dev/zram1 -s 8G && \
>>> zramctl /dev/zram2 -s 4G && \
>>> zramctl /dev/zram3 -s 4G && \
>>> zramctl /dev/zram4 -s 4G && \
>>> zramctl /dev/zram5 -s 2G && \
>>> zramctl /dev/zram6 -s 2G && \
>>> zramctl /dev/zram7 -s 4G && \
>>> mkfs.btrfs /dev/zram0 && \
>>> mkdir -p /mnt/btrfs-test && \
>>> mount /dev/zram0 /mnt/btrfs-test && \
>>> echo "FS Mounted" && \
>>> btrfs dev add /dev/zram1 /mnt/btrfs-test && \
>>> echo "Devices added" && \
>>> for int in {1..500} ; do dd if=3D/dev/zero of=3D/mnt/btrfs-test/file${=
int}
>>> bs=3D32M count=3D1 && sync ; done
>>> btrfs dev add /dev/zram[2-7] /mnt/btrfs-test && \
>>> btrfs fi sh /mnt/btrfs-test && \
>>> btrfs fi df /mnt/btrfs-test && \
>>> btrfs bal star -mconvert=3Draid6 /mnt/btrfs-test && \
>>> btrfs bal star -dconvert=3Draid6 /mnt/btrfs-test
>>> btrfs fi sh /mnt/btrfs-test && \
>>> btrfs fi df /mnt/btrfs-test
>
> I'm sorry. I ran this script in a loop for 35 iterations on 5.3.6 and
> couldn't reproduce a single crash.
>

Interesting thing I met too. That's not reproducible on my VM but
host (Archlinux v5.3.6 same kernel config).

What's more interesting is that v5.3.7 seems to have fixed the bug.
After some bisect. The commit is

commit 417d26300214f7b593a99c6bc8badb66492ae322
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon Sep 23 14:56:14 2019 +0800

     btrfs: relocation: fix use-after-free on dead relocation roots

     commit 1fac4a54374f7ef385938f3c6cf7649c0fe4f6cd upstream.


=2D-
Su

>
> Is there anything else needed?
>
