Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00C73D50B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 01:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGYXLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 19:11:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:33803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhGYXLa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 19:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627257115;
        bh=vJ1wV3BecJ07XIDmZBjf2cpZZmGTlrcTIjdeQfbTzj0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZY3ldrxYaYl68dBN9FU70S9MSV+kOJKdpKF2xcGFCBskiS1C3salQQGNbmiuSEGeT
         SHwDvAaB07B5T4YlPajHzvgv0D68rnKBMdwCY1Y9GJIOOaOJRQ99QF8M74uZwd6vgu
         zBc9AGBrjYgejidEGF+eOqfPXAn0hDMmxHRyRKqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1laxBR1GcF-00XwGx; Mon, 26
 Jul 2021 01:51:55 +0200
Subject: Re: [PATCH v2] btrfs-progs: cmds: Fix build for using NAME_MAX
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <l@damenly.su>
References: <20210725152438.70213-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5fc1b673-7d93-2ac1-114e-8e404ab05e76@gmx.com>
Date:   Mon, 26 Jul 2021 07:51:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210725152438.70213-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LoMzosPICoOd+CkIpNLDUrRAFgkIHCQlTOx6c53aUCW0PiRnvjR
 f3/BW4Qolpiva3BFYoasG7Qchc3JoXSyWGNCk2JS/m8C6fWA0hpf9oNhJEtgzN3scxmlJF/
 a317SvYuDaFVfO+rLzw3+LJf3GvQwMYDziD4tK9z/+eFI2M7RQGWdQX1qqtUN8rwzdWdC7I
 k+IIsppZea90rxWfP7l0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Hfwn3jQ4h4=:Kmmq+fbHTsMJ6KIn/VUkFD
 sq7RKMdHFXe5zettxTwmap/ST5WINKAlJOr3WFIyZ70NdSzQQfbQH8IrCLCP+Jp5ukkYH9zv8
 o9SAklRkqaI4xwF6EwUGo5f0zm5qVsigDbOX3Qh3loEmcKRN66M8Ss2BQ/34VNv98KSR3n/6U
 9OJstYH1nYPe1gUa3doxpZ1d5odVgMt8RrFGHqkvGKB4VLwbkU5lRi1QArWL5AawPeuTjWdQn
 nVGnF3smDyCbrZbOplbilzmjFjD1LlP7JTrRIkbnA5qQEL5fUSweVL9zSZYVh+hkxAYMDM50U
 qRRRWmXkVgGyPd6sc/grgwnaSZszwfYGmgKr7E/S4KqQcH+Ilz1oaCJY8LKgjx1NKJgtvriXB
 q2rEGC0uq54JrpHJBbMG3+WEBuBjp+bwW1eP36PkJKKxWu9z1JsPMTcjzjaC6pOaxjfWFTWeV
 0OeXsO8TJszJhpyxxo6VRyF1Y0+GC9t6Y16lX7NFDjr6eGZYclmr/VNfL6oC1GwQUud/a2rUr
 k+XQyHHYa8mGW4W81wC4Cz0Ql7ED43ZKJNVyYwfJWjf1/Wnj30TBql8gMfXDmH5tDkizW5n2H
 zZQsEOFkpZRelRqxv+Hs0ZJX/NG+VF2Uq0L1IVZd0i8dC6dK/0nfMPT11VH93uf+K4JC98h0K
 leGsT8ydzCGKcNlua5w9Lb0hpbANcgONCmeeuDRgjQsjytxf58XXl7ZAyWfp2UJg1SQEa1mrL
 siTL89uW7A21xGbrM32gWPpPjzpDBgJ9Es7hFJeT3nNR7PdzZ5f+1rQBcL495vUqbcRlLFFRO
 G5P9PEnEpNwjVHWaG/cafVduE++lXvj9WpTHzxk+Uadik43GYVtbr61kubBX5jaV8C/3tTTDM
 xDvHHrKhL8dnAL30ie5cZh0jJMSlzSR2lUPAKD/EO7HSg7NDnaBra9caUQWlc9xdcJHYmYz3Y
 xJfNvfY6Xho8/VUdEL01NmlnzYVDihMFBTzYlLs4/Hu4lyZyNQQnRtUk8l5Hg7hujAQjmXXRj
 iPrAx7uR7N6AZjRFnI5ReBycDAWc/0NwL3nkK63Fe81dc/8AxUYmFHKtK9qX1KUav6aqCxUYv
 vK0VXY3qA7pq6aDjvpvoib04C5ca2aPNfMbM5P8xL6hU3C/2+6JOw+Cdg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/25 =E4=B8=8B=E5=8D=8811:24, Sidong Yang wrote:
> There is some code that using NAME_MAX but it doesn't include header
> that is defined. This patch adds a line that includes linux/limits.h
> which defines NAME_MAX.
>
> Issue: #386
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v2:
>   - Added tag for github issue
> ---
>   cmds/filesystem-usage.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 50d8995e..2a76e29c 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -24,6 +24,7 @@
>   #include <stdarg.h>
>   #include <getopt.h>
>   #include <fcntl.h>
> +#include <linux/limits.h>
>
>   #include "common/utils.h"
>   #include "kerncompat.h"
>
