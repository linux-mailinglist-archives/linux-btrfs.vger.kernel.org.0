Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D76B3E52D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 07:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhHJFYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 01:24:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:47791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236963AbhHJFY3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 01:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628573045;
        bh=0tdPjI07s5A1s+BI3soF/nLoEa2h2RKy6ulHlApHT+c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SbzBo1fdtUdQGv2SK/AnaDxYUgfmf1BEBlB952HV04mERwhpZczVTJF75iWddR47a
         JdVfPk8VsS3p1kFCa88xMuWj7mcDkZKAQQZDMpDU82cRIcInyl3kLVBw/HSEgdzQaW
         Nk83VX2lUSwx52QB257KAtuc1RZVXqKicfTYu/6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1mL4002JGW-00GaEd; Tue, 10
 Aug 2021 07:24:05 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
Date:   Tue, 10 Aug 2021 13:24:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rzQghr0zMn33gJMGwpI5v1q+CMGTDO4dMhjse1QDA3ag9fkhk+V
 hdGmX5hHL6m1amKPtfuSxP/m+PzUhIc8/mwocZ9EQ7K43bl7kJmv9e1iuCx7ydOL7eyo2Qb
 8zti5rFHpoUBgcV8f5RfVa2IQH8TI64rWxaWmr+F8yBMk0dODGGuIOkKIPM3QGWf02CVj+D
 LYAC6alETNX8Qv79UQUcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AKvhDprw3vc=:qvZZRSQfT856JMMhfjHcwb
 jhFG0gbU5qP/bJia/KLP8eCcGM1wZC/zEyB2zko52KpculMytGZqE79HjNtq1jyVf42qgBBpQ
 RWjTw4vyEC5guQPmWOaY1XWkYid+LiWnr2w0YqdRCQw47I0FJiIsRHrrTxLJtACW8Pt9G4ZwE
 IJQk4A3FbWEC4JIjpIvV3GTKJFrRZtJs8teNtOD73L6pY+xDlywqryhrHjTQWcmxYLJAx972w
 DOguJseGhiA7XGIqpRk4FVhUz911KgHWPOICw5lz99Y52ic5To8iMWo5W2RRpbISBXfveju+x
 1+xy6UddNpC2TkNnUgUHy0WuPVbzHdSTsJFtjewyYLT3sd0UtThBKE0qMvO3BSy7gXm61p/dK
 R8aNvplJHMwzc5EsVsVmC1JYqtaPej1x0nN69X/7SnnYLT0mQO0dALi4UlN/uJflK1iS8gO6E
 bCBslzGVsRPsjsVWnntWh37pfKdFGoO1TJAO52dFQWw7d3rjfQaWQjhK2Cm6uJEFQwBwf/iNx
 LtO29ATozb94P7SbtO0ydijhtmRbQlf+d/PyNCP1A90jVxkuuaDrp44NmBA15TwVtFHOxu2bW
 kWfUlI9lbYtp3d5tmn1vhzi2Z+jOy8woCMIkvEdy+rFD2YfrTWkXVxvJNILm2gLbOlGA8khEj
 YKHMSdOg4PjsOTyXrPnoOdjGD/Kx6UJNFGNd/2IP5b/hBmdiTu/1U0ZtTLJBnkMuExDeIWmyp
 kRZEZe5NuoG5ISPixFqVIhAuDqdJ0rLyllB9MyfnEHAN7U3Jlh5iYA4ekrIM6FGtTgQnMAzQq
 1E1PFaOC/jmizGI1dr1aHzdd7C02KB/N8rA8tlFZMjQoGH8nYht0kFb2Rnltllb/SKBiN0oJW
 vrZwDJEjN4DVUcBxo1xolMY58zmG/v4epQJrR45ojh+KYpNtxlLMgpmCLTrSM3GJkl7dsQZwV
 ORtmwN7sfYY8/vz2PH3TTMP8L9FSSCSLVwAupNMYvuAKhiDzuQcOPHIJGbhpMQKc7KvtmhCXm
 Xgm5usmhu2huQvPS/6wX+e9GVtjlQpoxfAQ4BXkXPq7jk48ALw0PkWfjWp6Q1ryWmNz4L5yE5
 I7pGOhHZzgNjHRYg6Tksu0oIBnJcfOzbiJZbRvxDem8i7c2Db3vUG/siA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/10 =E4=B8=8B=E5=8D=8812:41, Konstantin Svist wrote:
> Not sure exactly when it stopped working, possibly had a power outage..
> I was able to pull most of a snapshot with btrfs restore -s -- but it's
> months old and I want the more recent files from.
>
>
> Testing the SSD for bad sectors, but nothing so far
>
>
> While trying to mount:
> [442587.465598] BTRFS info (device sdb3): allowing degraded mounts
> [442587.465602] BTRFS info (device sdb3): disk space caching is enabled
> [442587.465603] BTRFS info (device sdb3): has skinny extents
> [442587.522301] BTRFS error (device sdb3): bad tree block start, want
> 952483840 have 0
> [442587.522867] BTRFS error (device sdb3): bad tree block start, want
> 952483840 have 0

Some metadata is completely lost.

Mind to share the hardware model? Maybe it's some known bad hardware.

Just a small note, all filesystems (including btrfs) should survive a
power loss, as long as the disk is following the FLUSH/FUA requirement
properly.

> [442587.522876] BTRFS error (device sdb3): failed to read block groups: =
-5
> [442587.523520] BTRFS error (device sdb3): open_ctree failed
> [442782.661849] BTRFS error (device sdb3): unrecognized mount option
> 'rootflags=3Drecovery'
> [442782.661926] BTRFS error (device sdb3): open_ctree failed

Since the fs is already corrupted, you can try to corrupt extent tree
root completely, then "rescue=3Dall" mount option should allow you to
mount the fs RO, and grab as much data as you can.

But I doubt if it's any better than btrfs-restore.

Thanks,
Qu
>
> # btrfs-find-root /dev/sdb3
> ERROR: failed to read block groups: Input/output error
> Superblock thinks the generation is 166932
> Superblock thinks the level is 1
> Found tree root at 787070976 gen 166932 level 1
> Well block 786399232(gen: 166931 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 781172736(gen: 166930 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 778108928(gen: 166929 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 100696064(gen: 166928 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 99565568(gen: 166927 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 97599488(gen: 166926 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 91701248(gen: 166925 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 89620480(gen: 166924 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 86818816(gen: 166923 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 84197376(gen: 166922 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 76398592(gen: 166921 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 72400896(gen: 166920 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 63275008(gen: 166919 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 60080128(gen: 166918 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 58032128(gen: 166917 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 55689216(gen: 166916 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 52264960(gen: 166915 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 49758208(gen: 166914 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 48300032(gen: 166913 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 45350912(gen: 166912 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 40337408(gen: 166911 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 71172096(gen: 166846 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 61210624(gen: 166843 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 55492608(gen: 166840 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 36044800(gen: 166829 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 34095104(gen: 166828 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 33046528(gen: 166827 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 31014912(gen: 166826 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 30556160(gen: 166825 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 777011200(gen: 166822 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 766672896(gen: 166821 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 690274304(gen: 166820 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 175046656(gen: 166819 level: 1) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 766017536(gen: 166813 level: 0) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 765739008(gen: 166813 level: 0) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> Well block 32604160(gen: 152478 level: 0) seems good, but
> generation/level doesn't match, want gen: 166932 level: 1
> # btrfs check /dev/sdb3
> Opening filesystem to check...
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 952483840, bytenr mismatch, want=3D952483840, have=3D0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
>
>
> # uname -a
> Linux fry 5.13.6-200.fc34.x86_64 #1 SMP Wed Jul 28 15:31:21 UTC 2021
> x86_64 x86_64 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.13.1
> # btrfs fi show /dev/sdb3
> Label: none=C2=A0 uuid: 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
>  =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 171.92GiB
>  =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 472.10GiB used 214.02=
GiB path /dev/sdb3
>
>
