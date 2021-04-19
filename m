Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4B3644E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhDSNfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 09:35:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:37987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242053AbhDSNeQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 09:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618839220;
        bh=w4f4Rj1ewUgEmju5J4ULc3BklF5mH3EAswGUJrlVifk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QcInqpB4TuFWJtS20cH+chVa3M12k4TXbGiNAl3datxAHYwGgg3f3GKiJsVK+UVnT
         ChzMyM7iZlqCvnuxwgT+xMF0U0CU+xz2zyL9eKCll4k61bhs3rIwweWjOBZwHvmvjl
         uC5VD3yW60ieHx3Tn8Xib/WKZhtE7MtdOLkOshbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWASY-1l2A7l27tS-00XcZ5; Mon, 19
 Apr 2021 15:33:40 +0200
Subject: Re: read time tree block corruption detected
To:     "Gervais, Francois" <FGervais@distech-controls.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
Date:   Mon, 19 Apr 2021 21:33:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CB3t+Cc7R5FMUzjiG3kBn1EHWb0Uhnc2KQRhX1sLEYefbS/PX/n
 uYqffDWUaEIBggTkZORpJIW50mj/wIZsHbpiKh8iuLSV+aZmWZ3iYGJMramxpUcj5dztOKe
 Mr50Yh0FCG1bP6tboJrdzLXfDDY2J9Ef0CC2jb4uEF50/vh3ObkEJxBQbV8YnZtwYRim+E/
 Icx8LyqdLPu2HSwPBh8mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0BPwPPz9RLs=:IsSnFfhti+bv/K93oaRnXP
 EhAqdrxd7UbhzPSCB3D/6tmafBFVjAtI/cvXSlp4FyNedvGyXEAHgr23DRqUQybwo/Om/QwPZ
 tMGM1gWrbPIR3wLFeo5Lsx1hpJThUXu2CH8Au6Ppxibdz0+HeMzdFHYmfneOyPJxJaHgnv6Vc
 ZQDhHVqOx83F+veBCeAk4CxWIQZgEn2lIKWRtM2Cgp+XnUXpW35VfXmaRFz19szPXL9WFOglh
 b6xMvDJxDnRJJPUcgcO13Cc7CD8yIydUjuIRT6I4Ut+tYMonNl+3RE5aN3lpYuG53cfMD6nC8
 HhsT/tgrNWqYvtG2xqiuI5LgidgYAkuOmh7GZ37mo1qhvTcOOuygUbZgViJPgYTY/AS9zN8jF
 GVJRlmiezWm3wmQVWB+30x3QbMSBMmsCC4BOCFlNNPDpaZ4m5/Y9rchYz+sPdLU1JEjOOc+EM
 DD2gTxyKfJB/VscSjD+WxW0FwPZY+SpZEmp5txLzF4PP0VfeK99ksqyhN+T1CDZVWT7QqHKt2
 XrD1YaNs/4rwIy3A32fxNdfJBtOOl50RwpPujJbLh/9SPqoEHjZK1Qyhs9WyD0Lv3aU4g/Qx4
 rTEfUb4ZTljpzEldCtOsRs37wAgojPjsE/5CpNWdDKnLXdDp4RGDI/Dv0HyxjJ1JywWXzYAQM
 jVzMHN7Vq5RPzQE0X5S/5OB2qxP4WNVW2RMiHqGE3PuW3exCIP1WhazFtghaaoqkr0J0HSPtB
 GR/BVBi6F/vDYLO0p3cQFDcPmrczLPDVp/NYMQsBCeHZLBcgtYfKqssNife6/XTp6mGXYJlap
 nUTFJjp5k7dn/WKXxFW9q7e7FQKyqetCliZWAmp0JnI1DGSaKhW1N+JNcPS+IMAhUGMmW9UVZ
 mWojn9UvPiOaoisySH9j8avE0aSCrwqI2tugCTcfAe9fzo4oPyKmCs0Ddvy9ZOmq5L6qsAxvy
 fiGrP+Ho+fkjR3vIp42HnrkmD1+U/FY+9XmDGx8em5iE33whq32zpbBPPYiSWziIjxutWjNds
 WjAbt5IFKkS9fbG00FihgQryv4HvepRBL5kEbC0iKGOIeXb8tDiBwFo/rTg9r+lFITxC8/GIE
 bPXo02S2kF28y3wyhAXuMSXXdGq1SsIMFb95JYmsG5vyYeGHkpBFnvjhQO/ak49LC22YCX3UA
 fS4mNJvpGWX8nqPboAy/NcQoZQegrnTgd83SBjX/I4e9D6Am8gj47bYMqgxTMDUnUdA6PgMuz
 xx9O9pZMqut0+lHKP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/19 =E4=B8=8B=E5=8D=889:20, Gervais, Francois wrote:
>> Please provide the following dump:
>>  =C2=A0 #btrfs ins dump-tree -b 18446744073709551610 /dev/loop0p3
>>
>> I'm wondering why write-time tree-check didn't catch it.
>>
>> Thanks,
>> Qu
>
> I get:
>
> root@debug:~# btrfs ins dump-tree -b 18446744073709551610 /dev/loop0p3
> btrfs-progs v5.7
> ERROR: tree block bytenr 18446744073709551610 is not aligned to sectorsi=
ze 4096

My bad, wrong number.

The correct number command is:
# btrfs ins dump-tree -b 790151168 /dev/loop0p3

Thanks,
Qu
>
> We have an unusual partition table due to an hardware (cpu) requirement.
> This might be the source of this error?
>
> Disk /dev/loop0: 40763392 sectors, 19.4 GiB
> Sector size (logical/physical): 512/512 bytes
> Disk identifier (GUID): A18E4543-634A-4E8C-B55D-DA1E217C4D98
> Partition table holds up to 24 entries
> Main partition table begins at sector 2 and ends at sector 7
> First usable sector is 8, last usable sector is 40763384
> Partitions will be aligned on 8-sector boundaries
> Total free space is 0 sectors (0 bytes)
>
> Number  Start (sector)    End (sector)  Size       Code  Name
>     1               8           32775   16.0 MiB    8300
>     2           32776          237575   100.0 MiB   8300
>     3          237576        40763384   19.3 GiB    8300
>
>
>
>
