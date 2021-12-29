Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD14817C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Dec 2021 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhL2Xk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Dec 2021 18:40:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:56883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232732AbhL2Xk2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Dec 2021 18:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640821225;
        bh=Rdl7aFeg42O//b6b2v4sjh8M/1BToIsIohmDbiCJlBE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HADEP7DoEo+3Ilss1AY41bg8U129hpQdD6qfsX5KfE0rj2xRgIzETNc8eykAYdufQ
         EtU512Rj7ehoLwqd8tLYcD/OYLbJsonPUG4x1MdShetOzaZ2kym8Fe7R+r0sjZBj42
         1B06FjL2lDehUCQn7TcQHc2DxEINMQZUb9JXg6ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLQxN-1mlsMN1G8R-00IXt1; Thu, 30
 Dec 2021 00:40:25 +0100
Message-ID: <25c48d72-cb30-dc87-ab23-979c78ce2b60@gmx.com>
Date:   Thu, 30 Dec 2021 07:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: BTRFS FS corruption
Content-Language: en-US
To:     Mark Murawski <markm-lists@intellasoft.net>,
        linux-btrfs@vger.kernel.org
References: <41c94bee-eb97-a280-21c3-bcfe216f078d@intellasoft.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <41c94bee-eb97-a280-21c3-bcfe216f078d@intellasoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mahx+GZ/Yk8o7IEg3iCbtPF9gf11OMnbnvZY/cTQ+g1Ma6j7wkT
 DdYG5mPbMLE77dK6J4t+b9jmzHHVBz2nh7mIZX8ltbPS94Vp79EWB57zIYr+Lw6brKZX4yE
 EwvAYacy/tpmCaAktdh3bnCI4hz2JU3zW/HhUGmdEOukl3s70OORtxYLM9taup4jAWkiw8J
 XCfLcldtDS3Y+DQX09C3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MRIWcASOjwA=:HVGwTWRYGse3qcad/5yTlt
 ZquBB/vf+EsyD7O5WvwGs3Ya/nYR3KXQwCBiJ52DvODfsxMkxOrY2yo8B4SA7HtFs8fX4ln9W
 jOJeogn4hq4Wemw0iOlHinwZ5ggR8spD1oDdqAZnnlGmzpDWp3TLyo72Ee2Q+6XeIeIZyeVko
 OUTU7BHdu58st2hfL8muQaqzk2rkNinnEOz93OBANeD3aBthufeUW9GQsJ/RwMIJTByJD/r0G
 6JY+O8fEf9Tx/dF8avHNFqTQhCsUm5vemYupLuvl3ZFC5IoRdi+R1t8tmHYmL8vFIw4143tST
 woa/jAm5O4VJ8bwJmGzbn41tkLdx8stPN4dvDpRxNZ6IHyw/EbVAcsU3sqyj3MaboYXLpSgsj
 pvYzIYR4A2qjci2F6JRJq7ga9U6FKDVYnQ0YECKieuuXtOPKhdx3uThaeLlc7TBYfo2NnT4+d
 HTi3u4ftZtjfYMlIPrJTBE+7VrEfMkBdB7c2QkXoYxbcx2wTpDoP9FltRSFvrEDOjLl0YxDXw
 IP6ba5q4u00bSs13FK89ByrIF0jr7OJedquiLkqsTib4oGRCYAm3i4lIq75kLym5uB5vOomi1
 yO/MtBN7XWRexgEOPsc+EQpiCfjwUK58KM5ZLonhod+TDXGwRpIS2043lKd7XIyfi2RG+vxNR
 aYSoFuV/xlVtjV+vvipGPpTqlfzeGfGn9Q1M4cdJW34L4Se1agt8K384k9x9hmRFVF6aRzrWi
 R/15nk5TkI45wqqQIFKcfjMlaUghysfQ64cDlVjC2gdYgEfoGKCuNpgMKv5kbEj4hsZTUydZ6
 pNZpwPuJGFin4p5C1juW05NYDb7nHo2nPnachZclGU+8HuTiOrycw04S0le2w8n2zQ81siufq
 G6St/igEcQEyZ6+T+YTNgDLrYscqa+g2/6YoSgm1P7rOYKkt8zhGLUzCBjhoVCJGPCMFnhoet
 jtSUhTQ1OHtoFg6j8qSLFivKd7TrdKbNpUxba46PDSVLhY4wJpI8FhnEqqN4HgHpCnD3Qm+2h
 LEhnUOQ7tfF56O0aubmpV/xBfryom1SzVaQ833BEh4kyD31u+s4Y2LwCbNKfbr9IZXBxZLvAL
 Aw0hkCcM0nCPEc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/30 04:30, Mark Murawski wrote:
> Kernel: Debian 5.10.70-1~bpo10+1 (2021-10-10)
>
>
> # ls -al /mnt/var/lib/postgresql/12/main/pg_stat_tmp/
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> ls: cannot access
> '/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file
> or directory
> total 80
> drwx------ 1 1001 1001=C2=A0=C2=A0 94 Dec 29 13:52 .
> drwx------ 1 1001 1001=C2=A0 552 Dec 29 13:51 ..
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001=C2=A0=C2=A0=C2=A0 0 Dec 29 13:52 db_106964.stat
> -rw------- 1 1001 1001 1864 Dec 29 13:52 db_16391.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -rw------- 1 1001 1001=C2=A0 840 Dec 29 13:52 global.stat
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
> -????????? ? ?=C2=A0=C2=A0=C2=A0 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ?=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? globa=
l.tmp
>
> This is a dev/test vm so we can do intrusive operations on it...

Dmesg please.

>
> Should I run btrfsck?

Definitely.

>
> btrfs scrub did not show any errors/fixes and it did not fix the issue.
>
Scrub won't check cross-ref, unlike btrfs-check.

Thanks,
Qu
