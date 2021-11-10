Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC57744BAA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 04:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhKJDhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 22:37:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:33907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhKJDhc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 22:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636515284;
        bh=l3Dh/dyvXy8bdifd/XBIPMdl4oEDCc/dpjDnwYMy2TY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RB1F2SEVIqRHToUBRsrqcul2OoXRSVF84VcrGsU3TlFlKOCREZ1Djq7rqcPwbs3o1
         TVeUHg98+c6wevaQn6CUR/7qEPHYFZ/3QHlICsm58cDkSXEd/vkpFD93ON9MsRmth9
         cwloKeOMC6bh8aWCmPqNRlgkoUx4nH2KVbfzu5Gs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDp4-1mVQmR0rCS-00xXJ0; Wed, 10
 Nov 2021 04:34:44 +0100
Message-ID: <fe797f87-c39f-9c24-26f4-e85a1c0eaad3@gmx.com>
Date:   Wed, 10 Nov 2021 11:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pfd9ZLCh8sqJO63JawXXCe7LXhQTRfZk0IsxRmJ1WISafnWbZlr
 f9HrRT5Y7ExEc2u5dvA2GWEzz7A/30Uamt2Sutj1py9mHoTV5HYRAPce24lxvx1UakgcQ4c
 1xd7tAdyHad4N763f3dZIrw17lnf8YMQFepwJE7SkpbJWLCvyUTUleXqxLpJ0vW27Simaps
 K73xb8dDSzAsEuMEM4JKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sVAIVMGqi0=:2UKvujKh3RfF4NmqSLddYF
 oYypf8tOIqItIzArZ1PZaRI1vwTJT4lMy8bwQvwNHRFBjHuufcwIx+gjjsVBnrZV47BxIHYim
 gBK2L+8a3oa8qmGVoKWfr5UIRKRs9XA4rPlZr16/85OQL69BUISt3APP8CcF1P6bHNknQgSd9
 ujn9LsLnOgaNlav76LI+JE7yVdMSvebnStsPExUI2trIiHmRqpMYUt5FOKlCQ3/7bMiCfh4EA
 ht2ff2CjiE9Fw/+huj1/zdwhHCbVD9W8xyfWjBzyEI6JcdxNzTHIBwovfXo+s7KI7bTwjD7SL
 sgQWaZikMrHnsqMQUAC9GJhiAd7zOBtgqScAKZDpI4TIrKw6B+kZMGsHerKo11mvlj1g4IEhJ
 Do4aMPAQlW2OtvBtKUxlRq6UJvyZa0dA2kM8XW4Qk46mhSFuvFWvvL3iNvxCwG5bWdHkxL7En
 sjZpqD5weV615sWxYk7GwYbNBAk1o7qrbVOYNVv1+e9K4d3jONi071nDub9pYXRwVLeDG9gsm
 /NqXbperlGB1kZZeY5lKrLMUI2nD4FNUWpPHmwCyXEs8zz/WYmyinMYm5/d8uFHpOKPVQh9UW
 VrPj09sfhz/UtwMKyQDvTRAbK7TCNVgJC4UNCZL38JQazRkhbz2b621YuPrArJGKWY4NyzkZZ
 9TbXAVV6HLlFRIJag3k92pGo+5SyWzyyphyzpyW74fQHxCjzky+AOuNB6hP/vrgAziiWqk0i9
 hww7bGngg6jiX3vMVN18TAWMI1fkfiDbqtKn4kpmummioFrVYJfD0zqAj20VGDJvUgin6YL6D
 csVcB7xR/KAMHXi1Lwp6l6lG8J80wo7CN4w83zssu0tpC6xRlTRC3iMgKru/gj9YwF+Ihx2jb
 Z0u4nMEb74/JqGC1igQaPj3IYepahHFJM9IyGg5L8bVYkKC7e21BgQftp8M3EGlT4Oa2pG/G+
 cz7LhaZ2vG99UV8Cyh18ImdfW4BceiJgYYAnHl77/sto3XHDVloaLlHPE9pf8pGaBQJtVBSaS
 NXYpi00R9Kbr3rsDklWfIL3k/SeRAh7uN2bE9r3PNfyzOGAPAC6MDQOhe7YPTuAFrspZs6VvA
 JbJN+xFMHgbB/o=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/10 10:55, S. wrote:
> Hi Qu, thank you very much for your fast response!
>
> Regarding memtest, normally in Linux I have never been able to run it
> from inside an installed Linux system because it needs access to
> protected kernel memory, and instead it has to run from a live USB or
> from the memtest86 live testing image. But since this system is a
> proprietary NAS with uboot and no video interface I don't know how to
> run a memtest.

There is a user space tool, memtester, which pins down a large chunk of
memory, and do tests in user space.

It would not be able to test memory space used by kernel, but it would
be mostly enough for memory test use case.

>
>> To be extra safe, please provide the dump of your UUID tree:
>
> ------------------
> root@OpenMediaVault:~# btrfs ins dump-tree -t uuid /dev/sda3
> btrfs-progs v5.10.1
> uuid tree key (UUID_TREE ROOT_ITEM 0)
> leaf 170459136 items 4 free space 16151 generation 366 owner UUID_TREE
> leaf 170459136 flags 0x1(WRITTEN) backref revision 1
> fs uuid 4a057760-998c-4c66-aa6a-2a08c51d5299
> chunk uuid 54b2fa0f-9907-49d1-af33-e172581cd25e
>  =C2=A0=C2=A0=C2=A0=C2=A0item 0 key (1101835439474057344 EXTENT_ITEM 561=
68916570538915)
> itemoff 16275 itemsize 8

Yep, exactly the problem.

>  =C2=A0=C2=A0=C2=A0=C2=A0item 1 key (0x0f4a817e92c9a080 UUID_KEY_SUBVOL =
0xc78d54ff9b03a3a8)
> itemoff 16267 itemsize 8
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subvol_id 5
>  =C2=A0=C2=A0=C2=A0=C2=A0item 2 key (0x421cfa6924ef510d UUID_KEY_SUBVOL =
0xc8423812cf31288b)
> itemoff 16259 itemsize 8
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subvol_id 269
>  =C2=A0=C2=A0=C2=A0=C2=A0item 3 key (0x45a64f82bc9152f1 UUID_KEY_SUBVOL =
0x3859efe8688d6ea4)
> itemoff 16251 itemsize 8
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subvol_id 274

And you haven't yet recevied any subovlume, it would be way much easier
to rebuild the tree.

Thanks,
Qu
> total bytes 1990110658560
> bytes used 704343715840
> uuid 4a057760-998c-4c66-aa6a-2a08c51d5299
> ------------------
