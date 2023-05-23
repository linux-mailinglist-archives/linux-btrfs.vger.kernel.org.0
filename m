Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2399D70E75F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 23:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbjEWVbW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 23 May 2023 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjEWVbV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 17:31:21 -0400
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 14:31:18 PDT
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42819E5;
        Tue, 23 May 2023 14:31:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 53B533F4FA;
        Tue, 23 May 2023 23:25:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xWoa5MYq7N-Q; Tue, 23 May 2023 23:25:42 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 61CCF3F414;
        Tue, 23 May 2023 23:25:41 +0200 (CEST)
Received: from [192.168.0.126] (port=60034)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1q1ZVk-000GEM-Nn; Tue, 23 May 2023 23:25:40 +0200
Date:   Tue, 23 May 2023 23:25:38 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        urezki@gmail.com
Message-ID: <26007e3.faed4a1b.1884a80d9e8@tnonline.net>
In-Reply-To: <ZGyVVQxnw6Tn7Xb8@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com> <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me> <ZGyVVQxnw6Tn7Xb8@pc636>
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Uladzislau Rezki <urezki@gmail.com> -- Sent: 2023-05-23 - 12:28 ----

> On Tue, May 23, 2023 at 08:52:21AM +0700, Bagas Sanjaya wrote:
>> On Mon, May 22, 2023 at 09:04:05PM +0200, Forza wrote:
>> > I have a similar experience with kernel 6.3 where vmalloc fails in a similar way. I was able to reproduce it in a QEMU VM as well as on my system. 
>> > 
>> > https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/T/
>> 
>> Thanks for your similar report. Telling regzbot about it:
>> 
>> #regzbot link: https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/
>> 
> It is good that you can reproduce it. Could you please test below patch?

Yes, applied it to my test VM and will let it run over night to see how it turns out. I'll post again tomorrow. 

Thanks. 
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d368b..7a06452f7807 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2957,14 +2957,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         page = alloc_pages(alloc_gfp, order);
>                 else
>                         page = alloc_pages_node(nid, alloc_gfp, order);
> +
>                 if (unlikely(!page)) {
> -                       if (!nofail)
> -                               break;
> +                       if (nofail)
> +                               alloc_gfp |= __GFP_NOFAIL;
> 
> -                       /* fall back to the zero order allocations */
> -                       alloc_gfp |= __GFP_NOFAIL;
> -                       order = 0;
> -                       continue;
> +                       /* Fall back to the zero order allocations. */
> +                       if (order || nofail) {
> +                               order = 0;
> +                               continue;
> +                       }
> +
> +                       break;
>                 }
> 
>                 /*
> <snip>
> 
> Thanks!
> 
> --
> Uladzislau Rezki


