Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD0401267
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 03:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhIFBOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 21:14:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:56903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhIFBOS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Sep 2021 21:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630890789;
        bh=0zOYc/Ouo7jj3B8MZsUCY2NC/8vaDxcP9WKuCzgUKYc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZEsv5+hdVN9lwCJmxrhrY6Ih114o/8U6Dy1jSdVm3fyjmGt4B96jr/6pg+ttLLuyV
         3AcfmMcD27KPKanlCc+Noius+WzbXLjW/A3xvMbWflqEtVwrRPkVwkFm+/Oo1fwifQ
         lHL9rO920bdGFNFGIu4ot3yLw/EgL4Et0/5jjkTI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1nAtxr3EJb-00zWyV; Mon, 06
 Sep 2021 03:13:09 +0200
Subject: Re: An question for FICLONERANGE ioctl
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210905121417.GA1774@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <526c81c1-1362-e24d-6664-2028c46f6353@gmx.com>
Date:   Mon, 6 Sep 2021 09:13:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210905121417.GA1774@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VE/rZdegSelHACAZabG048CePgTn+hEoxRloYu3mmd0EN8cyGrz
 4yw7TIVnWsaT3wUw7F7HbMQznfOFZ9MlJOMPAlK7DkLieNeRObrsBqUXMLTxGLHG132bsgx
 tY39eQU+TCzko9J40nbJ28FkR4bXJqiR6bcXfQxqjd3eQw6707IOInLkDffo1tXQJqiJ1IN
 YX07d5Js98LFNSt5d1V8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Bhw5vc64mY=:Vbt2xxoxUkTuglcJhXfrni
 PBN2dwK8tBJBIoewRX6+Fv0nnOreJ+h00lRgrP07xxDuee/E2jo3pq0KNd1S4OE3yAf43GcGG
 UFIk4AJgJ8tq4Od74LM9f11QVUBWlJe2bu5FI3rpnLAKCsB3l/wKT/GvjPdr7fB5z15+G+vS6
 aCLI7To4JouHgSs3REho5BKKsAfoUH4eNaFT+4B1ubfbSr7zySZggDbiFnztZAVfYgJh68CL7
 QKDoJdpOrURTQ7KANQKQqTFRBW8GU1L3vcUbkfGK1UYT9Z3lcNoyQfSresNZGiSz7XcMgU6oi
 zcBhOObi2r2naDHlaKFFIYcFiYPjP+9Zj0hd0VdckE8ZZ/0lbV3Wi4yZ6NOaqiN9CpDL540rg
 G8iSUWNA6qo4LRZv/Lg3H0LPdc/8n25xy5jYUtdY1N9big6s32goYaRsv5+LZxq7NGA3X7tDI
 a84uHcHGc1ZD74qUFbSFJYSfZtMggrh2RZYpymc02kgxAtKKAreQ1L9PnZsqW8SCIjvj2dijw
 HTN2qpZkyN4vzP3rRu4df9U9HO/WzHowzxkDFTvpHFR8DeoO7Yyv7yxr/vQGe6YdqooETYwT3
 HaGgPBWNMu7y+u1r1zBVYr76m/XtJ0qxe9r63RK6SLzvy9jcwEmqsE/fgV7qyaAlgnOA4IOdi
 bbhGkXVNtBSnq+d/tZts0bDQ4HRXj4sijerZE3Xh/6jmEh6hY3tXTvmOShGtT+hd6+4Y3ae+n
 5yyJunIo1MIp8A5fMR7/mcoxVq6QhUO1lGaCEfNA4KQIC5RMHZz0UrTc+r0cCMnzA53RXd62j
 Sn8b+tdXa4/1R0717mZUU+2fpPAvyplDn4K5L20QPikwKBqSMOV5LBPlUezsdAc2MX06b9wg3
 zvV8ZexythhyprzzdrlTFHMwC3Fz8tmIN6S3kQXXZux8si5yI47rWWyP0xjN0a+MeNml8fpVO
 zsNv+/LVPAj8WE3S9euJ/TM6b1MbALmquD3akVEiZamCaVCLEBF8hF7W6IFo7+lcJaQGDb8FN
 t70iqTnKkJCt7ryoKIeoZZ4v/CT7YKyR1XMnGrULKq6FtMKOZ+77bxX8xFqVY5cdDEebX8IxP
 POs57MySjyFfVSKZERs7Ru8IloPsiHReJBLX9gR0sHK0BYucJElGW3wEw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/5 =E4=B8=8B=E5=8D=888:14, Sidong Yang wrote:
> Hi, All.
> I've tried to handle btrfs-progs issue.
> (https://github.com/kdave/btrfs-progs/issues/396)
>
> And I tested some code like below.
>
> src_fd =3D open(src_path, O_RDONLY);
> if (src_fd < 0) {
> 	error("cannot open src path %s", src_path);
> 	return 1;
> }
>
> dest_fd =3D open(dest_path, O_WRONLY|O_CREAT, 0666);
> if (dest_fd < 0) {
>      close(src_fd);
>      error("cannot open dest path %s", dest_path);
>      return 1;
> }
>
> range.src_fd =3D src_fd;
> range.src_offset =3D src_offset;
> range.src_length =3D length;
> range.dest_offset =3D dest_offset;

Mind to give an example of the value?

One quick hint to the invalid arguments is:

- Range alignment
   The src/dst offset must be aligned to the block size of the
   filesystem.
   For btrfs, the sectorsize is currently the same as page size,
   thus both src/dest and length must be aligned to 4K for x86.

Thus a more detailed example can be much better for us to understand the
problem.

Thanks,
Qu
>
> ret =3D ioctl(dest_fd, FICLONERANGE, &range);
>
> And this ioctl call failed with error code invalid arguments when length=
!=3D0.
> I tried to understand FICLONERANGE man page but I think there is no clue
> about this. I traced kernel code and found out it goes fail in
> generic_remap_checks(). There is an condition checks if req_count is
> correct size and it makes test code fails.
>
> I don't know about this condition but it seems that it can be passed for
> setting REMAP_FILE_CAN_SHORTEN. Is there any way to setting remap_flags
> in FICLONERANGE ioctl call?
>
> Also it would be pleased that if you provide some documentation about
> this.
>
> Sorry for writing without thinking deeply.
>
> Thanks,
> Sidong
>
