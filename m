Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325ED4B31C8
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 01:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbiBLANo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 19:13:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiBLANn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 19:13:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C26D41
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644624813;
        bh=LJ4CZ1zjl9uKWBKICAP5KFSqiQYL/T9fdloUzxb9/0w=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fo+R3gUyoxdJtJ7ZY7GX4rFM0sJGWXKy4Kv5iijy36zD+Lvz29QwvNysRCyiZWQRP
         Ct9KH9+Rd9MPCZ+ZJcCY0Yqczqg6/4HtYi04stwY6glAQFzdjBNvW4M0JFq/2FzgGv
         DmnyV2PFDqRCNfPQENgo2g2TnO6huclfRLQKEYqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOREi-1nf8LK2syE-00Pygn; Sat, 12
 Feb 2022 01:13:33 +0100
Message-ID: <402c8a70-7589-4a29-6c1c-28e0b75e0716@gmx.com>
Date:   Sat, 12 Feb 2022 08:13:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: qgroup: Remove outdated TODO comments
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20220211134829.4790-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220211134829.4790-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vZT04tHNjOF8LHQINHRDfJyXEayVpti9lA2exWfkUP4XVPaqviE
 XM7obxnLsVqpeXbjL24+wZlvxdLaR0xGX2CvlJjI/Mg+d06L18Plo+rrBSKvJeGYNCNsL1D
 lXPSALJUG0wkx1uwbG0JNoU7CRDX0r5Ni6eK1JvhmQe3l65//ooDelxgVQc+PgzYGohqPMk
 3u5irajsvq2Y/ZSPQc6dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gCdaz1w9X4=:M/JjL0Daq03oDwJ0LQzUoR
 BEvFghQHilm4TR94z3uAfon034BOLWsuy4ivMyDwX8DqvDdLnZ0fwBUamtZ5Lzc4mulO8OhC8
 d1T8qSFi/hNpn0flEscKaewujQTg0dZOH9v5i8tCi+FAPCTTadHx/gMIRsPUFmc+9kC+gfPYM
 8V4gGp0k8pEIk0KlKgwexEZnedCzV7E+QzWaTk3ycFKPVcWBqi+CtVWyppMWwjwdtsQ8IDh3K
 BpbIhFUGokITY+OnWI3jq7+Wm0YviNnGQmkiBdWYnUkvpHIlyMQnRk++zfykYQ8CO4avALWI/
 jqv0q5M1fTyS+UiRsEIdHSSUzjdCZUZ84zS/3GsVB+YsdjvzfqxTkNEniJIfVd/brdF0qxxU3
 RMa1W/2Sy0YNMCNRfKgq+Jqr3xbvRwICuzOFi2yIkXslFcZXdA5IDe3mUfQTxRXEpVmuY/k9N
 V4cD/qWWeYIedPL7EeqQcHGjpM5UHC+XATUz4hhX9uTCuAuRK6DB5pzKgfQgw2fVFAzZxSSNm
 8t+R2Unipv1lyhVZC8e6kDniJyWgOv6bNBC3uxrTuNoXdgf9VsIDr7xUimPKDVvNWbOo1mls4
 6xBmClLElpnjWkJVebATt0IIMfKYb/jSnWTN09aTAJ26VTNoPB7AKIbCG/n0VTC0gvJheqLb2
 nyEvyPEwauJ/RCi+vUo8I7z/zibFdz6w1r7QHKXMXG3Wfu3EHLg+oxxUvKy0vBPvD9PJX1EjX
 fXjsuT+uKS1awkGdPVmlRW7M3kqpfbwQhMbtK7Ah/Ij7FWJ6f+TRWKeKLfi/Ea53OEVzqs3nZ
 +Te8853i4+1g2Z4GJsDQEzqw9jv2pJrtn8fvrhoaFQz4KrsbS0JB5uGLKITPCG+sqvEyqQzYP
 xbvrIiYLhTKLQgB8kPcRzULTKbl42t5XDo7tCxV+nXExbcGEQjOMXau5rTkvI7bpk5rX7pw/T
 uDsXTca5kjArTYu5MBK5Tyu1xr97Zi3iOWui2LINHGuCDE9vjdd2X+B4gCzaXwZk0UF9/eyu8
 Y/7Ui8gnvR6BcU398BRbwibhrbQDZZU+BgoEyEGR/NyVbSPK4kap3HszELmdPTtKjnmbRc3eM
 9LrRwwy6MuWAqs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 21:48, Sidong Yang wrote:
> These comments are too old and outdated. It seems that it doesn't help.
> So we can remove those.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   fs/btrfs/qgroup.c | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index bfd45d52b1f5..db527c277901 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -25,17 +25,6 @@
>   #include "sysfs.h"
>   #include "tree-mod-log.h"
>
> -/* TODO XXX FIXME
> - *  - subvol delete -> delete when ref goes to 0? delete limits also?

This is still under concern AFAIK.

Currently if we delete a subvolume, its qgroup number will changed to 0
but not removed.

Thanks,
Qu

> - *  - reorganize keys
> - *  - compressed
> - *  - sync
> - *  - limit
> - *  - caches for ulists
> - *  - performance benchmarks
> - *  - check all ioctl parameters
> - */
> -
>   /*
>    * Helpers to access qgroup reservation
>    *
