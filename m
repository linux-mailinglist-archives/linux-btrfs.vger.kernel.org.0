Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC83D4CC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGYIb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 04:31:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:55219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhGYIb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 04:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627204342;
        bh=8+g2WmuofiNV4FQvZ5aaIrVQ/px3HorMJJPftooY8ro=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOX5WVUbKP9eV/BKuJpQDdmlo2Fu+6kTX12KiIvfdJoof4V+xxQ6jhgpll7Vll8ga
         qhoIpGpsFIBsYBb6mNSir0n9fIkTVWSl6a6QvIgxLtIuNdrob8dyloo/ueWqAyc1DT
         jSLPDEX/0BANJyfISXQbsz2uDx1Oya2d0Y5Br4Zw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1lkqd01LfT-00O1ZI; Sun, 25
 Jul 2021 11:12:21 +0200
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
To:     Su Yue <l@damenly.su>, Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka> <czr7w180.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <84f558c9-03bc-9225-23bc-9219526ee97b@gmx.com>
Date:   Sun, 25 Jul 2021 17:12:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <czr7w180.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQ1u4kTIDDnAmhaXnugHgQZwmDTelfJ+F0r37b+N5Ly6uN9VDhU
 x7EuJgLa7H3Sh5nQ+XE6ZN2Y/zEYx4L8/iosHD5/iNtFf8sEUG+lY71Ebok0jUASYe/rmBN
 wROWSjkqDF5bjHGD4pYlnPqeAdBq6MEHPc6vO+afWo5z8DLoYvoBxogWa9CKEpc5c7i5e5y
 mfrWsewVuUcnIn5YBQ4Uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4GkuVkRR4RM=:O3+Ek5TrJCoq+vVPABxEET
 CrUTJrNYYN5yLdeT/cJXa6nl02A+cWWywk3Ed81jv8Su4IZO4xAuBE6e4/V4XnGcK5vXf2nfs
 RLwNihGp8E5wEiFF/LV8h7klsOIhbJ58/biyiFeHIQEOAkr1jP9TYVy5EWNmOf6meXTYI9/yQ
 QLNsI2qSDfP6KVMXEpmaM+JBKwSwmSHMG6soib8o60ntwPisjIvslyjmHP8DVjasRFTCwV0zL
 bP2V1m1YTeVnG2vPjQXp3ltlJjrfydIzlcaa7O8Xbzy2mP/6Enot6nPldWt+NkBnwPwhBZK7R
 Gv5roHpe7nOcLbAdgTXGbN/lNvAO3WRyWuDsBCRI7WE/EbuBdsn5Xhc6XYMGe3fHat1pq5Vk4
 2O5d7KHtO0osf+4qsd1lSv9A/zaEnWRCkNWnIX1dvtrBffHXWDCEogbBJzmjSDgj1Ta8PDp2+
 8fyFWYvASWMQ/QeBVX9FjAzV8UsSq33qRlRU40P9YTSBUcDmrp2+J1XJXmItrnVhkroa8QpCf
 KbYqNWR7o4cSBzz6ZsiCJwFpFVcJmGcPvVE3GOGZmNd6m/uwuorxNefD2/RBF1gC9se69FlAa
 HExG9HNE1UwwRksyWnn5bwJSQcw9ywhjpdf6nokaX5pOXUBNUwkcKWV+s8ggA4FPoNUXONwOe
 kbsDWxF9hXQCesLHxk9kAKIzOLTtvWvMn/61+yA+eNjSDaQmwmwx0t13FjLx/Hni0u/pZe3HM
 eqb9SEoD9rirhUiTXs/HZi+3WbeziCfteKMk1Ys/hj3xQ8/beQEgR1U1PIpbPlnYjBS+g8epH
 4lXx7kkYzVIDfd6A4G/EBnvPjodQS1Kga4FgWq21hjnDaACm8BKgpuItK9BypIkqUBNJ5/F+v
 Zfjavyvi/8WzymjRybkUyGy9SQSXOdy9cVJ3wUo49+xfDgjAPwsuAlq9HxfWmL88Cn2SXh9tX
 xloRp1E2dV6dBMnxQ7KBN56yIyLeDtBwqvR7KJPYTpsQXxhcoDt4g7Me10aLGEImI/sC9SQYe
 HWlvYTZ+bKK/EqNuLmxUcqx48H03rWzucV7QW2F2LW/pC+whx7ln+izzK+zKmPCvvMeWjnM5u
 G0DJ2AQY/A5UUYXqnMST4w0DHgTDIcU8AOcL+8Tcy5tGyyb/VdFebpbNw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/25 =E4=B8=8A=E5=8D=8810:54, Su Yue wrote:
>
> On Sat 24 Jul 2021 at 16:23, Sidong Yang <realwakka@gmail.com> wrote:
>
>> On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/24 =E4=B8=8B=E5=8D=883:46, Sidong Yang wrote:
>>> > There is some code that using NAME_MAX but it doesn't include > head=
er
>>> > that is defined. This patch adds a line that includes > linux/limits=
.h
>>> > which defines NAME_MAX.
>>>
>>> I guess it's related to this issue?
>>>
>>> https://github.com/kdave/btrfs-progs/issues/386
>>
>> Yeah, It seems that there is no patch for this yet. So I sent this
>> patch. Is this too minor patch?
>>
> Good fix. But there is one PR before the issue creation:
> https://github.com/kdave/btrfs-progs/pull/385

No wonder why I didn't see any automatic mention in that issue, this fix
lacks the "Issue:" tag either...
>
> --
> Su
>
>> Thanks,
>> Sidong
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>> >
>>> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> > ---
>>> >=C2=A0=C2=A0 cmds/filesystem-usage.c | 1 +
>>> >=C2=A0=C2=A0 1 file changed, 1 insertion(+)
>>> >
>>> > diff --git a/cmds/filesystem-usage.c > b/cmds/filesystem-usage.c
>>> > index 50d8995e..2a76e29c 100644
>>> > --- a/cmds/filesystem-usage.c
>>> > +++ b/cmds/filesystem-usage.c
>>> > @@ -24,6 +24,7 @@
>>> >=C2=A0=C2=A0 #include <stdarg.h>
>>> >=C2=A0=C2=A0 #include <getopt.h>
>>> >=C2=A0=C2=A0 #include <fcntl.h>
>>> > +#include <linux/limits.h>
>>> >
>>> >=C2=A0=C2=A0 #include "common/utils.h"
>>> >=C2=A0=C2=A0 #include "kerncompat.h"
>>> >
