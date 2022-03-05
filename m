Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910104CE422
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiCEKSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 05:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiCEKSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 05:18:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197674755C
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646475446;
        bh=CYl16j/3AY2yUG4mQjHQ6sT6+AHMVnV+k+/ySpAVZMs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Q44q+XXH+W8KRUONJBz3GCsl4geWVOOlFpJSvsHvnrmMMtCa00muqDZ7MnAi+x8e9
         RteW+VSxkbX6scMjHdUURMhTmSSOxaw6dCd0qdx4iJsRUhRszwzhMI1uDG/uDd2WcW
         U8tdce5Weo95t/R5ItCDS/QFhZDhnwFObiCrH2EM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1oJdUq3wzo-00tDtH; Sat, 05
 Mar 2022 11:17:25 +0100
Message-ID: <c76ec07b-4e4b-180c-612f-5a9cceb3f30d@gmx.com>
Date:   Sat, 5 Mar 2022 18:17:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Help on free space cache issue
Content-Language: en-US
To:     matriz windowsboy111 <wboy111@outlook.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <TYAPR01MB6060F10E43889BABC65A3E7FEE069@TYAPR01MB6060.jpnprd01.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <TYAPR01MB6060F10E43889BABC65A3E7FEE069@TYAPR01MB6060.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JD4xuOIJI3kuab191ybjVJIkimDtGxytobKPRUGoo8FDQprt0fP
 KIpQVDm3A9VWp7bhmJUeDNNuz52uEmotkmXXMwHZYouTv4mzL0x+z7qyJsJr/XBYi0igHak
 yLABTAKD+B6ufIS19Ar1B0BMTx0QN+YQ155KycFM0QlYxRULfLYAceJvPZa7O7jgMDlTs8j
 k3FJT/qfDAo0cUutRkQGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+YQk0bl5PE8=:PKo/mTM8TeO7zAzrbgebVC
 EZIod3wGC7OO4/Obl+sKeQHtSTQiwr8uthj8tNTmc31Q5Xh7uxUBlflQgtMJAAGk0s88bdKZ3
 //tQjMh5Mt3hphrWHEcWc8jHR8TsXJj73emZIrQmaPbbS0MmPXDDfrnCBUNbXivpJoUDWTW1O
 sXmeUWlmDgk+1m+XtF11TreIc0sZJ7Rd5l4U6HkWptrnDDFSAbNEK6vRdEW2RGM/yXTFdIRkQ
 g0+yuMJdiNk/0JTmlzYU7XkD9GdM7hguPuI0iivhHesnCAqahO7gDaOkkjQq4hlA5//UEqszc
 rJcLmTzOA6lbwizsZWBN6Sfuv+MhrK9SP/5HGuKnnIf3BtLYowBcjwG6w3yWcE7KCXzofXzpz
 9gK1V/423KQMgJIYGR7aoIEfZU30S2qq+4HKCebv6ws4ID8MB48wIXMrikDuQAgQpF8D3q9Mg
 N4HFuZDH0chCSnfLPJ9427T4rvMwQzhkpsfZQVbshmBm7NBCXG74DFB+pM+3fw1D4TJRob0/W
 oQZ+lX9MoLcilipAS3M+CRgMKFyZnwgh1+yvsBQli9+YpZu+ktiHxvvV//aX/oWMg1snWH+Nd
 S6P8TcRujzctYSZ6F4NpBxLHt1HuI+uVGY4pTrJ2oJsosA3TtwWfedZDjEJf0D5phpyNTl4Rh
 7PtG379YkUSA/CrWp9RqGYuz0+UypAkJQ27LN7WoA0LNoUsiK8GNPQiqdvnQteKHrs4BrD/KK
 cKarf2NVXYCnvPhtUw4rTNEKpZfDO4zwAZ67S4c5Nc4kHTv3UUEijRt9dOQ7IYrnR528AsB5J
 gua0S4BMvLBDj1+e24LvBRNSN5skAUUsLS6T/C5iHDiD8m29EtRG94C4lzez5y2a7XJ8mXW5w
 WHHwHxHRKfqc4TBcGXlmqT/E64OdTZkHy0rTe0zX+FfOB2fQmjFcGJvUp/1LpV4bkHGmnSe6E
 ls/bhnrD66Qypooy9kKGpzzaTsvV9zivz669ADYpnsUTz4wPpt8Ps+YR3Qbyur+5bXJgXycP5
 af9rpl9ajWkyfcAu+fGqnpo9fbMYaVPgYfxf5S0AYGsDqZVLwuLGOqCVeXij6Pcwic8/HQ9/r
 z4OKvAIBE2LSzU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 16:02, matriz windowsboy111 wrote:
> # uname -a
> Linux hostname_here 5.16.12-zen1-1-zen #1 ZEN SMP PREEMPT Wed, 02 Mar 20=
22 12:22:53 +0000 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.16.2
> # btrfs fi show
> Label: none  uuid: 794b6ad2-78a3-4814-9ed2-e605ad66d2cc
>          Total devices 2 FS bytes used 56.03GiB
>          devid    1 size 105.08GiB used 105.01GiB path /dev/sdb3
>          devid    2 size 8.00GiB used 7.00GiB path /dev/sdb2
>
> Label: 'DATA'  uuid: 496b5da8-b16b-4241-88b3-9140272585bf
>          Total devices 1 FS bytes used 333.60GiB
>          devid    1 size 931.51GiB used 604.02GiB path /dev/sda2
>
> # mount /dev/sda2 DATA -o ro
> # btrfs fi df DATA
> Data, single: total=3D592.00GiB, used=3D333.00GiB
> System, DUP: total=3D8.00MiB, used=3D96.00KiB
> Metadata, DUP: total=3D6.00GiB, used=3D618.05MiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> ---
> Basically I found this at first:
>
> # ls -alh
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fi=
le or directory
> total 0
> drwxrwxrwx 1 root root 80 May 29  2021 .
> drwx------ 1 root root 14 May 29  2021 ..
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B1=
7C8436D
>
> This file basically... doesn't exist. `rm -rf` doesn't work, while `touc=
h` says "file exists" and then creates a copy:
>
> # touch 3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D -a
> touch: cannot touch '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': File exi=
sts
> # ls -alh
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fi=
le or directory
> ls: cannot access '3F32BF73FBCEFC1F243A53C9C5643F7B17C8436D': No such fi=
le or directory
> total 0
> drwxrwxrwx 1 root root 80 May 29  2021 .
> drwx------ 1 root root 14 May 29  2021 ..
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B1=
7C8436D
> -????????? ? ?    ?     ?            ? 3F32BF73FBCEFC1F243A53C9C5643F7B1=
7C8436D
>
> I decided to ran a repair (before_repair.png) (after_repair.png) and I a=
m kind of regretting what I did.
> Anyway, I appreciate any help provided.

In fact repair did a lot of (pretty good) work to fix your problems.

The initial problems are all fixed, only free space cache (can be easily
rebuilt) and one inode has missing orphan item.

You can easily remove the v1 cache by:

  # btrfs check --clear-space-cache v1 /dev/sda2

For the orphan inode problem, IIRC it will be addressed in later releases.
For now, it won't cause any problem, except wasting some space (that
inode won't be release, thus only taking space, but can not be accessed)

Thanks,
Qu
