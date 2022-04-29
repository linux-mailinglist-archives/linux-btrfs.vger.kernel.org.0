Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86B5141AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 07:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiD2FNP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 01:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiD2FNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 01:13:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC63220C4
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 22:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651208994;
        bh=ZN6Up7v0PkxXh2XStNX5it5bWb1PS4RkHFoSLsHtMGw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=a3X5VktesA5Ikn082yo9YcP1qAgeXlmBekGnLxXlY7PNZzoLjXaHfmlE0BiU+OZwN
         1a1htMb9NwVpQoXR0WxzNS5rvetS6pMbq3ZNhm0eU6lNZB6xj6YhBVxFeDCYuoQRCB
         CR7YTlAN+K4Up/pCMAcxP7GUS3cB99yjF9r5dhtM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjjCL-1o7mna2Fpb-00lENK; Fri, 29
 Apr 2022 07:09:54 +0200
Message-ID: <c2bf3e08-efb2-11fb-940a-b2ca5363da00@gmx.com>
Date:   Fri, 29 Apr 2022 13:09:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: What is the recommended course of action for: Found file extent
 holes
Content-Language: en-US
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4ndWsZQg13dbp2L5uXQUExtV=L0XmWvTEz61nWGzY=tg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGdWbB4ndWsZQg13dbp2L5uXQUExtV=L0XmWvTEz61nWGzY=tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g2Ua/QI9xpCbuoJMpsvq9V6v+57RxvPxPNyTBuS1ITrE6kp0pAY
 esFy6i1zBf8JtB+wpVvO//vcYYko99JI5PlVPAsXIMyRNSWD4R2hNaKFyF3qpuu+qh4W7Ob
 qIftDHCAJ2CcnMxZO8lhT9Ix7hlSQVX11aNhl4rqGIjjGbD2dxrfTHz98xILwywylKbdRST
 tzwevL0WUPP5gJGe+/gUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+gW0xq8p/9g=:wNhCilgKGKwrEeAdaVd7oo
 I/TGz5vM64HDKgRhdBNjb5XfXbt++w2cjCiF30caz5EfNl4OPagHT79Jf3u/pZJ6YpCYexxjx
 SIV03+rRKS31MRZTL4WvwrwQ65dbQRFWPpVip8itxH4+2jwcfIWusaBPIN0qWIQWg4AT1t9Pq
 aDsSpoKGP7WMOA9D//TPfG4iOBQYpUrPJg5xnz+fhc3LvI+v35qrhTw+i/d+KyJlXMzpjQGbZ
 TUl5D5LsLzCyL2XFc4O+UrKST0GF0A/qHWLG1FdC+/l+TzaIFVMu02KPO9inWoF8vTqCCXgiF
 nODrw9Fa+3W3rgdHm4gKqTHWcfSXN1rww3IkVfRZ4GPPJUPyH3giZDZ1NWm9pWId4TwK4vpTf
 mu+8oOwYLbODAjOcq1MLZVWSMh2PxOUwfrfTVlWs/mB0WKgk5dPvIYqNe67RJDEZ4D3ZT23bS
 I1d1G5pFvdOZV4N+tsBnTNnaMMBN8FGwUAb1rW2P1Dl20fklp822uKExkVOAYVWD+48DTTFop
 4veU32ZzFy7Giy274OYGzKjX8ESQj6qzsD4s7GtpYpThxwf4hnN7/oyPWwZGJAijqGsNnjkVw
 za00NtlVGqPx4WOw4mcrFBNE92U5/EhNyXhvkbfeAJNgjH+OkMjIOk3FRgMgsXFMvKQ8W8KlM
 ocHvmAmmDS1z+SwPI0f67vOUVzHYeIUhOJTmBFXdnSEpy78r7OhDeq9G2IlSBoxer+vS2JV8+
 bsq8sq9OpXOAeMUqCB2kY2zBUbN55dyPXeaVRffob1Q1FiSJ6Hq73RHoTQYvRz+v3i48wLp3t
 j9rLTTDmhj1rp+9OvAb7/Vvhi3GF+QFTgb2OYlwl8KwlH6kGKFe8bVeuPLTY6xRlJicS6Ib6I
 xqyQ/rLMNyvl8awOHWWbRO9/YWPrhwkvsAGw1T3QZWz2/kVKgmKfCdFvZo2/3800f7KtkTyW8
 xUX3CIb+yaGEnx3ue0HRKzJutwk8sCXdPB8PvYSvwdSj0pgCUhPFmlFgRjg4d8/UfLab3copD
 AVKlX9lIe7RlCZ/o2lzLF7U7AabIDShZmnvwLSG1LE//WhPwmgCmCWOrvGSQJZqGtgG5Xhq6T
 o4z8dhayhQEn9M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 11:20, Dave T wrote:
> btrfs check found errors in fs roots. What is the recommended course
> of action? I don't care much about the data on the volume.

Nothing at all.

File extent discount is not a deal at all, kernel/progs/btrfs-fuse can
all handle it well without problem.

It's just the schema requires if a hole extent for each hole, for the
old behavior.

Nowadays, we have no-holes feature enabled for newer created fs, and
kernel can handle this case very well.

You can even able the feature on the fs by `btrfstune -n <device>`, and
then btrfs check will never bother you on such file extent discount proble=
m.

Thanks,
Qu
>
> # btrfs check --progress --check-data-csum /dev/mapper/xyz_luks
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/xyz_luks
> UUID: <redacted>
> [1/7] checking root items                      (0:00:23 elapsed,
> 4710592 items checked)
> [2/7] checking extents                         (0:01:03 elapsed,
> 154607 items checked)
> [3/7] checking free space cache                (0:00:00 elapsed, 127
> items checked)
> root 1430 inode 7492 errors 100, file extent discount17 elapsed,
> 121521 items checked)
> Found file extent holes:
>          start: 0, len: 937984
> root 1430 inode 7493 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 5390336
> root 1430 inode 7494 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 4096
> root 1430 inode 7495 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 1392640
> root 1430 inode 7496 errors 100, file extent discount
>
> <removed about 600 more lines like these>
>
> root 1430 inode 7699 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 770048
> root 1430 inode 7700 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 1802240
> root 1430 inode 7701 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 1007616
> root 1430 inode 7702 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 221184
> root 1430 inode 7703 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 380928
> root 1430 inode 7704 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 573440
> root 1430 inode 7705 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 212992
> root 1430 inode 7706 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 802816
> root 1430 inode 7707 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 65536
> root 1430 inode 7708 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 483328
> root 1430 inode 7709 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 172032
> root 1430 inode 7710 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 241664
> root 1430 inode 7711 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 12288
> root 1430 inode 7712 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 86016
> root 1430 inode 7713 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 1171456
> root 1430 inode 7714 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 90112
> root 1430 inode 7715 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 29728768
> root 1430 inode 7716 errors 100, file extent discount
> Found file extent holes:
>          start: 0, len: 741376
> [4/7] checking fs roots                        (0:00:17 elapsed,
> 122659 items checked)
> ERROR: errors found in fs roots
> found 129201229839 bytes used, error(s) found
> total csum bytes: 123927020
> total tree bytes: 2527707136
> total fs tree bytes: 2024407040
> total extent tree bytes: 369098752
> btree space waste bytes: 379740661
> file data blocks allocated: 1630234861568
>   referenced 1662138822656
