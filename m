Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63044A9D94
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376858AbiBDRUy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 4 Feb 2022 12:20:54 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiBDRUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 12:20:54 -0500
Received: from [192.168.177.41] ([94.31.101.241]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1M730b-1n8e0R2jpX-008d0N; Fri, 04 Feb 2022 18:20:52 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re[2]: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx errors
 1, no inode item
Date:   Fri, 04 Feb 2022 17:20:53 +0000
Message-Id: <em596e7e6e-2b32-4c1e-b568-736fa23fd402@envy>
In-Reply-To: <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
References: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
 <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.2.1659.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gSab+zG5GKt8VGcbpw3YG4vQ/3nPzGFExiP05Jrl30uqAIGfi0y
 2eelxMaRhGCzG78A9gEx34JoCrR/zaRD+Mp7+zJuxm+ADhcCLiPyUecCNKoHwhrjmE9bOT5
 VTJho47nJIWw5UuHeCRiHsTGmkm/ZRoVIE5+M424xAbMTT7uGoYlrj91xTewZQmCRADPrAC
 sHuU6q4RLX4tX0F/sm26w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:96zaokPUON8=:w2P/C7wtwcLSmC5UemDa7H
 7MxfLxQ7Nmq4wBl5eAjLsBceBuw2XarLJgKtMaUOXzDq9kXglKrI3p+56/M75996QQh6bNnXG
 z0vDoZWDuDloZ83t8jTyQW0nE8ykdHuAXZva9luSkyvLb8RvvU6qHmEavf4j8v3j7rH9qOmed
 opETCLGkK9FS9pvo4O0ZIs6181d5UvwNcqDHD1UjTlKQyNU7Y2rSQuWIIM2nfv+FJjInlOi1s
 pDecl3WuWmDGDYVU7xREdqiYJ/ZPoEoWUolnUPPHWpLh+3RE+wS370dHuGf/vUAPJWZ96E0nb
 wlTK6/AkQbwfYKlr5pwayiGAoUsb0vYWqRdPweq3btBq2BHl0Mfjb7iCWuZp0wUtb/h0vNW9E
 n74btb1bpQIgJaQKiJkVYaRKbFQSHxEDuvuGS3URUJmBW+ogkYND7uxdMv0ugLozmGbT6+5QV
 ykBsoDBKSVwhaxrin84EZQ/BeuO7XEG5yKxQFMoZtdmqYFu5m/hensCQR9rnIFcvEg7j/+t1t
 sAv/Tn4nLcsTV+Lv5kxblDZDZ4uS5/P9VxOhgGluTKPtE1gGu2W6Ubt59Ja1DgBP4BGdM0hcO
 aCznriYMYknG7bpDFR4nLu9lyx5aLeNZJv6IO26GMee/npszNol86adVKPX6OWmOe8bolWxUR
 3E73/lacvVEmhdcZmxU537M0y0AoCrKgtjKAlTPZDGN/76xNtcf5vo+0D+xnsFu2T6SaZug84
 6qHWrzfIi82yUZnB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello again,

I guess it is not normal, that it btrfs check is now running since 
hours... iotop is showing no disk read going on.

Best regards,
Hendrik

------ Originalnachricht ------
Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
An: "Hendrik Friedel" <hendrik@friedels.name>; 
linux-btrfs@vger.kernel.org
Gesendet: 04.02.2022 14:47:45
Betreff: Re: root 5 inode xy errors 200, dir isize wrong and root 5 
inode xx errors 1, no inode item

>
>
>On 2022/2/4 21:30, Hendrik Friedel wrote:
>>Hello,
>>
>>I found some files for which ls -l gave me odd output (??????) instead
>>of mtime etc.
>
>And have you checked your dmesg to see anything wrong?
>
>My guess is, tree-checker reports something wrong.
>
>>
>>So I ran btrfs scrub without errors and then btrfs check with these errors:
>>[1/7] checking root items
>>[2/7] checking extents
>>[3/7] checking free space cache
>>[4/7] checking fs roots
>>root 5 inode 79886 errors 200, dir isize wrong
>
>This is pretty easy to fix, --repair can handle.
>
>But I guess it's mostly due to the offending dir items.
>
>>root 5 inode 59544488 errors 1, no inode item
>>          unresolved ref dir 79886 index 199 namelen 11 name global.stat
>
>No inode item is a weird one, it means the inode 59544488 doesn't have
>its inode item at all.
>
>
>>filetype 1 errors 5, no dir item, no inode ref
>>root 5 inode 59544493 errors 1, no inode item
>
>On the other hand, there are some other dir refs which doesn't have dir
>item.
>
>From the inode numbers, it doesn't look like an obvious bitflip:
>
>59544488 = 0x38c93a8
>59544493 = 0x38c93ad
>59544494 = 0x38c93ae
>59544495 = 0x38c93af
>
>And, mind to run "btrfs check --mode=lowmem --readonly" to get a better
>user readable output?
>
>Thanks,
>Qu
>
>>          unresolved ref dir 79886 index 200 namelen 10 name global.tmp
>>filetype 1 errors 5, no dir item, no inode ref
>>          unresolved ref dir 79886 index 203 namelen 11 name global.stat
>>filetype 1 errors 5, no dir item, no inode ref
>>root 5 inode 59544494 errors 1, no inode item
>>          unresolved ref dir 79886 index 202 namelen 9 name db_0.stat
>>filetype 1 errors 5, no dir item, no inode ref
>>root 5 inode 59544495 errors 1, no inode item
>>          unresolved ref dir 79886 index 204 namelen 10 name global.tmp
>>filetype 1 errors 5, no dir item, no inode ref
>>ERROR: errors found in fs roots
>>found 62813446144 bytes used, error(s) found
>>total csum bytes: 43669376
>>total tree bytes: 665501696
>>total fs tree bytes: 329498624
>>total extent tree bytes: 240975872
>>btree space waste bytes: 119919077
>>file data blocks allocated: 4766364479488
>>   referenced 60131446784
>>
>>How do I fix these?
>>I am runing linux 5.13.9 (about to update to 5.16.5).
>>
>>Best regards,
>>Hendrik
>>

