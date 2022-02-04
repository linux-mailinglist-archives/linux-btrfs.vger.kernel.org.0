Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446774A9D87
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 18:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbiBDRQq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 4 Feb 2022 12:16:46 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:38779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiBDRQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 12:16:46 -0500
Received: from [192.168.177.41] ([94.31.101.241]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MqJVd-1mU43L2mrj-00nNYE; Fri, 04 Feb 2022 18:16:44 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re[2]: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx errors
 1, no inode item
Date:   Fri, 04 Feb 2022 17:16:44 +0000
Message-Id: <em76f707e8-935b-4885-90a2-63b93fa5f7d6@envy>
In-Reply-To: <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
References: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
 <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.2.1659.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:OtLtBTV9MVQFdTaesft3jvx3O7/PpGdBO5LniSn2o68dSA76WWs
 LFbdNfBaYIIPl44H5I862AmbXhiCIp6dwKMVtQT7VidwYFPpp8FiU4maHWy+2Qn5U0y9buy
 QUdLaJdNK1DgUkMQ9OVl1ijh1lDKV/9uPNlC9S8WV3KUewdZ6oW597moGsbQoUGF1tmdPKQ
 WDl6ZAlacNLYEecj9aqyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HzAnDKQ8NBQ=:P0tUfo58cm2fdSxhAYbcMa
 iXv4wdkmAdh/c7JqJxlHSv9pqVtPOT8UogJCvjJYg8Y6CmLkO8n1k9hdVLoDdGK/RlhRX9JAk
 +NW1pZjS5oKsfrAfbN1cNbp8IEEUjY2TrPCiXLR3AxWipk5T3Mda9hNkm4g+yssckBuIApUIw
 WKGD+gX/iVrc1bWFv8nUhKT+nX0dV1Rsn0d0eFO+fta7pvFyeg+0HnMf/tAL1qxFL6UWNvNtW
 sA3dUhCuiN3H8VxR5YQ5Jh0sCSHl5NTvmT+b4lD387Us3QfFP4MsI5a++JAbGmdBA34IM+paX
 eupNAm5hb/gUQQwsPKrm9BGJXZa3j77r5H1tOJDTxztrs4FRQ2brDNelwIi7P/Y6F8wJU3KoF
 T18IqH3VGKzOpHsy1lhGa5vMC2de7R1gNfgCYycfNPe8VwXK1IYOQKr3uQBzDUmPqXynO3OLf
 J0srIPxUZ6w1F2JnawQS5lHk2SchQ82rfryiQrkTlRdLMDUyAZPb1A7eO/320Wm8hMGXSoPos
 tCgu3Mdx1nmldDdeJKdKptJAozqn3Kh8SlNa2bwJE8FAnXq1QHtvl3rgz+K/aozDgZRKGZJDe
 ClUhCmdo0/jS0c3tocz08r7/DRWX+oyS9ueIt1r2jrPgZvnYzITEUVuxTeP4wbLHdBZDX/RO8
 34p/9C8HxpXP2Bg2T8xSlRiS43rPBvsFWaSPTJeur0awiRBqR9UgEzhvAhCJlTc9gnYzzNsEI
 KXQ+b9Xk1qpmstoH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

thanks for your reply.
In dmesg, I see nothing wrong. No unusual messages from btrfs.
>>So I ran btrfs scrub without errors and then btrfs check with these errors:
>>[1/7] checking root items
>>[2/7] checking extents
>>[3/7] checking free space cache
>>[4/7] checking fs roots
>>root 5 inode 79886 errors 200, dir isize wrong
>
>This is pretty easy to fix, --repair can handle.

But what about the rest?

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
But three are directly following each other (93,94,95)
>And, mind to run "btrfs check --mode=lowmem --readonly" to get a better
>user readable output?

It is running for 3.5h now. Is that normal? Without lowmem and readonly, 
it was done within minutes.
The Partition is a SSD with 80GB. That should be fast...

Best regards,
Hendrik


>
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

