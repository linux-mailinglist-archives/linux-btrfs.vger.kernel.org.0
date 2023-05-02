Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231DB6F3B6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 02:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjEBAfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 20:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjEBAfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 20:35:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF92D61
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 17:35:04 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDbx-1qEsnI0KpZ-00uZtr; Tue, 02
 May 2023 02:35:01 +0200
Message-ID: <b5da52f2-f1ca-cd5a-1647-6fd84cc59afc@gmx.com>
Date:   Tue, 2 May 2023 08:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] btrfs-progs: make check/clear-cache.c to be separate
 from check/main.c
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679480445.git.wqu@suse.com>
 <0230b3efffd148db3e1850ad085dc9ae65dbbea8.1679480445.git.wqu@suse.com>
 <20230323190313.GA10580@twin.jikos.cz>
 <a385c041-3c54-3832-7af0-c64f6e818826@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a385c041-3c54-3832-7af0-c64f6e818826@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DsrJzHy+s6D2uR6KexAj73X6qOJbPwzZoh3LoYXhewSEg+y21mJ
 BrE16q9ZrR79GG4wNjdTI/xcgvSSjfNuqX6qgNbTbyvEwrZgp9q4Ui6N1xyDLXrDN/keZXC
 cIsNqcbgoocV7hwyQ013yN+NqvDHvcqp1uuIvGmrGXhXUZEXPrQ5o+C+1QNffen9vQ5M6oL
 l0jHLZO3MbyOj+keSHInA==
UI-OutboundReport: notjunk:1;M01:P0:dDpLaR4VNmU=;r2+buAKGWwFF6xvn00Gd78/IpE0
 oDU6tI9c2o5kAq1nw16MEbIZyhqB+0uIG9kmTKpLS8kRq1WomaNP9hL4B80UTDc3lbfSZ4Eir
 dCptx0HyJBIOJ/B30vBTf9DhsLfuVGfEkHc0+FHHWpFxC91xyEoFYN31RZCLpQhRs4Mqx/wnY
 jdLCMDlUuwYqVEbQ9T3LbQyPGT4AcGRDTw3QA7RMGxuET+eQsUapEZcKPyBrMW7XGIqc0nhzm
 KF5X5aqUAGbbpc8GUtz+41mSxg2bsvpPW9Fxy2/Q1Ws96RJ2bOr4/GuetH1O7CaW7sb6R3O/R
 1fRZhD6pSQZMoAJvHsNcEIGEDphxDYL0JjlygyRlsqc8WVa+qb9wHa/WGAQHCzCyJQAglrfiW
 a1p3YmYsTKnuCA4eG6QG4gVAT9aFH2UO2dQhrRCxtqMOouEm0/U7czJjR2SxxDDxwi0fsFZzt
 OJBnXZU0sR5h1Ioi5Bc9nsLN5/qByG/RVJLGCiraiQJokAvGEFRsF2i1Y+idtEkCQUoxLsV8Q
 LVIay/7x1VmiXepHoczWbg+a+w04Iwf9D9HiluwdCKScRASu6j725t5LMr7n3tJV5uli5kaTa
 ADzh0CtZ6CgF74r5WC2ybz8xP0UoW0p5UsS/YebMv6+3VX9ZED4UOg4UgPsvcfdf+MxqpIRMD
 FoueTc8izfoI0udYabY7rVlZaOFEb8cSbtGDqczIu5M0Oc4uSxckuH5rWRmCdg3aTn3EchKBo
 aXUOKUPH+fSHocvyQ6MLDhGmRenSvP0l2x21NixOmApIweNfCfJtkXvs04cszG6SNzdBIK8yW
 B0UmCoUO/jecf9/xgEqsfBgzw3qDZiizJMrQm1EBlQ9BQz8270egyliO6tLoyFJPwEDD588cz
 LhtThDU/Oa9i1Ws839gDlAgbrkpZuXLU5EP5RjdT7td0HWoeEEnpI0UxkGfjXv74h+/z6O7M1
 8rXixvbXJeHKVx7KPOGs4nX3lzo=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/24 08:39, Qu Wenruo wrote:
> 
> 
> On 2023/3/24 03:03, David Sterba wrote:
>> On Wed, Mar 22, 2023 at 06:27:04PM +0800, Qu Wenruo wrote:
>>> Currently check/clear-cache.c still uses a lot of global variables like
>>> gfs_info and g_task_ctx, which are only implemented in check/main.c.
>>>
>>> Since we have separated clear-cache code into its own c and header 
>>> files,
>>> we should not utilize those global variables.
>>
>> Why? The global fs_info for the whole check is declared in
>> check/common.h and is supposed to be used for all internal check
>> functions. This is intentional.
> 
> Because I want to use the function do_clear_space_cache().
> 
> If we still have any gfs_info usage, it would cause compile error:
> 
> /usr/bin/ld: check/clear-cache.o: in function `clear_free_space_cache':
> /home/adam/btrfs/btrfs-progs/check/clear-cache.c:46: undefined reference 
> to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:56: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:67: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:73: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:84: 
> undefined reference to `gfs_info'
> /usr/bin/ld: 
> check/clear-cache.o:/home/adam/btrfs/btrfs-progs/check/clear-cache.c:85: 
> more undefined references to `gfs_info' follow
> /usr/bin/ld: check/clear-cache.o: in function `check_space_cache':
> /home/adam/btrfs/btrfs-progs/check/clear-cache.c:357: undefined 
> reference to `g_task_ctx'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:357: 
> undefined reference to `g_task_ctx'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:358: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:365: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:373: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:374: 
> undefined reference to `gfs_info'
> /usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:382: 
> undefined reference to `gfs_info'
> /usr/bin/ld: 
> check/clear-cache.o:/home/adam/btrfs/btrfs-progs/check/clear-cache.c:383: more undefined references to `gfs_info' follow
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:693: btrfs-convert] Error 1

Any comments on this? I didn't see this patch merged.

I have some other patchsets requiring a similar work, and without this 
patch, we can not solve the convert failure on subpage case either.

Thanks,
Qu
> 
> Thanks,
> Qu
