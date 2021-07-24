Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1343D4629
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhGXHJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 03:09:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:44901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhGXHJ5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 03:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627113028;
        bh=zbatlGJGBY8kzVhJOcQQArL1wp0E79IpzGL1qyuvP+s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R2dltNd2sU3XLw+NR6K6On1c+h4r6DWQvJbNgqOBhsKs371YG8q261AV4pYlsesW7
         iqr4caC/XKJrqDMa4XdMPF6eD0DrNdotyhRGaNATHf8TiPZ0FmoU93U1uIyZsOZdN2
         xW6ufeICu7GaXlHPbkUq4Dv/K+PHFPXxH4/kn52U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfNf-1lEH7s2pTD-00v51t; Sat, 24
 Jul 2021 09:50:28 +0200
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210724074642.68771-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
Date:   Sat, 24 Jul 2021 15:50:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724074642.68771-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HHpuTzzgXLFC4zIPyTw4Qq/NYt03fcLFFmZlr4MUPNql+wkZnRY
 2UgQDN2+rKU6O7tiT+CaeEtYwrmYbIxF5cEbwOIDT3H9OkEm4b2BWzCak6wOGQcWQKE5SaN
 nDzIlwvzQYmtezQC7+am5Bel4PI2tBW8+qMP/Blmnw3VygPSvCAJmV8lJ6m2n5zZy3Rx1j1
 b9OJRzfSZ5c03VMTm/JuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l5SKSHtL15Y=:S2mo79yFpxgnI3oUFb61/K
 wdPJeSzAs6821hihHWRhTkuciYu15fYLeQAwZldj28LzmJb5JmMvpk5J6ikmZaDmYCc1XjIQG
 48grUzarD8nUSZLs+xjYNMkmMb6CeNGgqyujzVK0IKZgncvcQfrl8+x92CJEiqFGf09Y90MlG
 s3YGMx6/t6lzpJIB0PuVzXLO552sZPAMSeQgJ7ro3DeqRfv2Qo+ThQ5u4Ak2+pbxVoPZs0JTd
 3pSgh3FYRLj6Ps1nx0sM6isKgz/OTcyOLDYs092GD6Ni1gJq3Mu47KDbgDvql4HY0JOfSWJfr
 YPDwDe3WTKIfsq+/00OAaTEQkNxrvc8ftPDenpr2evmGwsYh2cwD6Z1VcCF28pav4YhJS2jjO
 vBEkM+sjxG7LGiOOD1+f/jnU9asH6v1TaH5myyGf2gP4lTrJVhRvkWGf5OXdmZJ+TxB/Esq3J
 Gyf3+4DkZRpE+ExJeFe28TwfG7ciqXmrtM3OBTtd7/0ypTmsVA/J4nk+q82L3SaXFr/QA3wwF
 1FuGUFLprX53fp8wyOS/SSG2I3M6ER4thdGmcJvBirBhHzDYkOdPCPlN7at/EaUA1F19ZfXHM
 oCH7Pk/2Qa6xBaMkZuQt6Pm3MwUo7A3kk+5LYLT/GRTmMleMW1e/JZp9s4BYcnvik/+oCP3sd
 gy4TC7p+JHdG1wimE8tK0f7lGrEDmnPGmMv1DE+7//qxWfCPW2Z8m9mcDKq1XZUve2qPk4kaw
 dgBUaNdqOtvoYcb7vLEwfwgZMeQWCBM+RV1ky5WcCbvfSZ4HkLWzzq4AVVfpmTNkJrGN6LKaQ
 PCh5k8VTdp3u6Yhu/Zq3Pdz2a5vPagSNPnFB/gruq1+J+qlLQZFdNldCEllkwjlcZFfK5uOjT
 KxCGTn86Cuzay0VrOtAGAM8e5+2b/iTM6psKEdUPgtw8FndjEGXDIKm5+2SFYgZHxZGIhAbg+
 58LTZ8RlIFmlSxbh07Dpr6h+yNWP0WfzEUlm4iiR1bO+Y8dmwDkJfbebg6SEDCgPJwhsieHFo
 gSAGkubK4WDr1S0OQ/+59fS8EFbWkGYkJQUICCKFlnuIj6oMauKfpTqkUSsYWbYiWQtD4nmYd
 edyukQ+BfcHcsGROYh0gDo2KYafsy4lA6i4zUSrbWtSjTKyLXl27qzgJw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/24 =E4=B8=8B=E5=8D=883:46, Sidong Yang wrote:
> There is some code that using NAME_MAX but it doesn't include header
> that is defined. This patch adds a line that includes linux/limits.h
> which defines NAME_MAX.

I guess it's related to this issue?

https://github.com/kdave/btrfs-progs/issues/386

Thanks,
Qu

>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
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
