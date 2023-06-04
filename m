Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E87215D9
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jun 2023 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFDJb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jun 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDJb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jun 2023 05:31:28 -0400
X-Greylist: delayed 627 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Jun 2023 02:31:26 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61158B4
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Jun 2023 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Oto+KgbQOZ5SqEEOJq51otDPiV1zM2KZ3ggxAaEM/M8=; b=NEeUy9c4iAnN5ZG5dsUPEjpCGn
        XBYKmH/0fGNF55U+Gmjnwy9NBN1pn5GxbuqFRG+KU0gIE1dl3+H2t4dNIWv169YYE0Hrr2GvYq3TG
        elsVGjv8kxWKejebk8EE3kWXegxnPJb05KdWhpMFDj+gOnu8fNVgiUXKwrqkb/J9aygthhi5PNSW5
        Vy5ypx6LoFYhGhf369cQTrhQqCx7cQdzSODxR26gk3AAlJqZzyEiGUbyrL6zrDFGICF4ymdz/BA2L
        1Aqq64EJAGLBsGj+6wjigO34IiSPN2ES5dpsGLDTaftKHnvWtc0nzRkgQJJSV3dUNVwhSzVnPif/K
        pzIymxcQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:39100 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1q5juz-003oL1-4F;
        Sun, 04 Jun 2023 11:20:57 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Different sized disks, allocation strategy
To:     iker vagyok <ikervagyok@gmail.com>, linux-btrfs@vger.kernel.org
References: <CANaSA1wZfn5Gxg_dU33WbamchVtWDU4GpXazn8ep-NJKGNaetA@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <d9516e97-f7e1-9728-d6c0-a0be034d356b@dirtcellar.net>
Date:   Sun, 4 Jun 2023 11:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <CANaSA1wZfn5Gxg_dU33WbamchVtWDU4GpXazn8ep-NJKGNaetA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

iker vagyok wrote:
> Hello!
> 
> I am curious if the multiple disk allocation strategy for btrfs could
> be improved for my use case. The current situation is:
> 
> 
> # btrfs filesystem usage -T /
> Overall:
>      Device size:                  32.74TiB
>      Device allocated:             15.66TiB
>      Device unallocated:           17.08TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         15.57TiB
>      Free (estimated):              8.58TiB      (min: 4.31TiB)
>      Free (statfs, df):             6.12TiB
>      Data ratio:                       2.00
>      Metadata ratio:                   4.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
> 
>               Data    Metadata System
> Id Path      RAID1   RAID1C4  RAID1C4  Unallocated Total    Slack
> -- --------- ------- -------- -------- ----------- -------- -----
>   2 /dev/sdc2 4.18TiB 13.00GiB 32.00MiB     4.91TiB  9.09TiB     -
>   3 /dev/sda2       -  7.00GiB        -     2.72TiB  2.72TiB     -
>   6 /dev/sde2       -  6.00GiB 32.00MiB     2.72TiB  2.72TiB     -
>   8 /dev/sdb2 5.72TiB 13.00GiB 32.00MiB     3.37TiB  9.09TiB     -
>   9 /dev/sdd2 5.71TiB 13.00GiB 32.00MiB     3.37TiB  9.09TiB     -
> -- --------- ------- -------- -------- ----------- -------- -----
>     Total     7.80TiB 13.00GiB 32.00MiB    17.08TiB 32.74TiB 0.00B
>     Used      7.77TiB  9.95GiB  1.19MiB
> 
> 
> As you can see, my server has 2*3TB and 3*10TB HDDs and uses RAID1 for
> data and RAID1C4 for metadata. This works fine and the smaller devices
> are even used for RAID1C4 (metadata), as there are not enough big
> drives to handle 4 copies. But the smaller drives are not used for
> RAID1 (data) until all bigger disks are filled (with <3TB remaining
> free). Only then will all the disks take part in the raid setup.
> 

First of all, I am not a btrfs dev, just a regular user.
This "issue" bugs me a bit as well and I remember that there was a 
proposal quite some time ago where someone wanted to use the percentage 
of free space as the allocation trigger. I believe that would have been 
a quite useful change.

On modern kernels (>= 5.15) the RAID10 profile "degrades" to RAID1 
(which is perfectly fine from a reliability perspective) so you would 
spread the data over all your disk a bit better when the filesystem is 
"fresh", the opposite may be more likely when the filesystem nears full 
state, then the three largest devices will be the one in use for writes.

So assuming regular "home use", fill up with data once, read often:
In your case, you roughly have the choice between:
A: RAID1 , use your largest devices first, then spread over all devices.
B: RAID10, use all devices first, then use your largest devices last.

