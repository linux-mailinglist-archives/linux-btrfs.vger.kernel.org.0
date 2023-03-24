Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5B6C74A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 01:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCXAkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 20:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXAkI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 20:40:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F87227BF
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 17:40:06 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1qRgFW1g0m-00vPgd; Fri, 24
 Mar 2023 01:40:03 +0100
Message-ID: <a385c041-3c54-3832-7af0-c64f6e818826@gmx.com>
Date:   Fri, 24 Mar 2023 08:39:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] btrfs-progs: make check/clear-cache.c to be separate
 from check/main.c
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679480445.git.wqu@suse.com>
 <0230b3efffd148db3e1850ad085dc9ae65dbbea8.1679480445.git.wqu@suse.com>
 <20230323190313.GA10580@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230323190313.GA10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7XaM8dmfbtVLT3HIZeIBSLWfRiScwjiGfgo52TcLEd8w0QhPRTb
 aSYXk8myKl3hIFCNhJc0huDQoQDEs82+XxXGigTOKXeFNketcY6LcivxatMXjsf4gUdnKhI
 gC0k51fZZ6Xago7pOzg4nQ1gqXzS6Do9OJqZDTXDdtT9fSWqroFM5JfOGy4ATLNZNeOGVr0
 jPAdREUkP83wNM7/a9Gjw==
UI-OutboundReport: notjunk:1;M01:P0:GHphK/u7ZQc=;m7NT7OXQ/CL8MC720VBEDCIGoUx
 IZ2uzR70+LvQD4vgmRw+d1XMYZ4sp5lB9cWKDDcjETJuwLmLwKoAn40CNLwUivs1TLtXSb5Vz
 CAotLMrmFYeCSVqC8JYKB8uEHsU81KyXtvfOz46SI3Fk2F7cEId1rXr6efHBSNdNbyQvnNPht
 knIYJ4laiuFflFufBVrOjQYhuNhGBBt7Va72i9Gy02SgrSPjzbfTWPPVBg8ShgqFBMb7ov0wD
 qCpbVoqovw4tmu17rLm2dcodyuXVUeu6o3JJ85jnBpRWxBS91T1TUEaclV+iozXrLglsFvuvo
 F319+HeTnZWF/+cKpD+O0IqFHtep99+ky3PN98Y7ga+VOHcpMzPVpiqUkeNq7iKEgLoHFnZbm
 Cr9//cPVD+ZTPuH6boT0NN8oQUG5ye3n6OFZZtj6rTO8ywmCuNAdIvdTnt31KbORc6V59rZ95
 PLZusab99WZ2+Z6r71dt8N0kTdAHth1mwZruKyYUulfkCI0pXnLNyesh0e/P61H1CShip7KBm
 2LhzgG4wDVwENJTpeOpjQGOea7Q4AMxAHkD6QoDaCWE5WJsCbcysZ8520z85yRutaKsB6tdcK
 ElwH+6kE104B6b7LmeQpH2og4/8N/Ua0MPN3dnI8+VIIeS0PKkMtD5i15VgF04BXuQ4pnlrqI
 PYHjenLroVsnajaGcr6Yb0/h+H2jQXqSK5Qiotl5yjU0kHWcOyWNuk0NWWdOw1HduoKZ6SXYm
 kp54SSmIM7NV/FMGnNEWDHMVAvdYEJ/w5uLuHDiF+qusOARY0simYAkwINWoLFtjbmoL4tXOx
 /AhXshoqb6Qk1q1YxcdEln33Wu7gwredkyTMOap80dq9kRc7pA0HlZQVDwKVlZfqb2+9r3aXr
 /g2pyqavJc23y7pJ6cNavMmCytVqm5ao7ytyyZxggNko+FMq2YroMw+tUKSREvg36I/93l2qN
 gI/q5R5+SRZxgNUe84RCMKrBBIQ=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/24 03:03, David Sterba wrote:
> On Wed, Mar 22, 2023 at 06:27:04PM +0800, Qu Wenruo wrote:
>> Currently check/clear-cache.c still uses a lot of global variables like
>> gfs_info and g_task_ctx, which are only implemented in check/main.c.
>>
>> Since we have separated clear-cache code into its own c and header files,
>> we should not utilize those global variables.
> 
> Why? The global fs_info for the whole check is declared in
> check/common.h and is supposed to be used for all internal check
> functions. This is intentional.

Because I want to use the function do_clear_space_cache().

If we still have any gfs_info usage, it would cause compile error:

/usr/bin/ld: check/clear-cache.o: in function `clear_free_space_cache':
/home/adam/btrfs/btrfs-progs/check/clear-cache.c:46: undefined reference 
to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:56: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:67: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:73: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:84: 
undefined reference to `gfs_info'
/usr/bin/ld: 
check/clear-cache.o:/home/adam/btrfs/btrfs-progs/check/clear-cache.c:85: 
more undefined references to `gfs_info' follow
/usr/bin/ld: check/clear-cache.o: in function `check_space_cache':
/home/adam/btrfs/btrfs-progs/check/clear-cache.c:357: undefined 
reference to `g_task_ctx'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:357: 
undefined reference to `g_task_ctx'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:358: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:365: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:373: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:374: 
undefined reference to `gfs_info'
/usr/bin/ld: /home/adam/btrfs/btrfs-progs/check/clear-cache.c:382: 
undefined reference to `gfs_info'
/usr/bin/ld: 
check/clear-cache.o:/home/adam/btrfs/btrfs-progs/check/clear-cache.c:383: 
more undefined references to `gfs_info' follow
collect2: error: ld returned 1 exit status
make: *** [Makefile:693: btrfs-convert] Error 1

Thanks,
Qu
