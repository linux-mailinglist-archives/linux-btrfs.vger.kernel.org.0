Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287FC7547FC
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGOJb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOJb1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 05:31:27 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 02:31:19 PDT
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD78FC
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 02:31:19 -0700 (PDT)
Received: from [192.168.1.27] ([84.221.16.1])
        by smtp-18.iol.local with ESMTPA
        id KbbTqBZ7NJqGAKbbTqpRM1; Sat, 15 Jul 2023 11:30:15 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1689413416; bh=psxPpFqucHK3NeBYWIi2PnLWHxA/yqH+eylHl455ULc=;
        h=From;
        b=A2+bsNm2J/Sb2BkZ0KbVEaMZgAmZm9sHpF3awN6T9/ZA+nt2EKJGQYeVsLe2B9UZ4
         NApk1PurucyQHFB9pNIe128mQ/UUXd3tD785qnBfO0d+j4QW3Ocq5wYzylNM1OiWAL
         kdIU2K3lXFshY6DKYo/1aj4x0LpIoM5aY+QaU/Qpf+anDXIahnEMLgzYOoInLJ5JZH
         aGtTGhqglPDzr07/yH2x5PV0Zh7UOrfBKHINc5cQEKsUbvyOxBfyqoswPqO3KB5cHI
         yzHbLDJW+525MDXC+H+GhczhUQRuv5d+4E3a27cVxMJtULU+Xd6teY+dkFec2Z/Wel
         4wsdMW7/fTwEA==
X-CNFS-Analysis: v=2.4 cv=BcUekJh2 c=1 sm=1 tr=0 ts=64b26728 cx=a_exe
 a=vr8dJlsG5SImbR3TFHgzaw==:117 a=vr8dJlsG5SImbR3TFHgzaw==:17
 a=IkcTkHD0fZMA:10 a=vTr9H3xdAAAA:8 a=lViJMyulAAAA:8 a=GKGiawnHlGGJMsBqi8gA:9
 a=QEXdDO2ut3YA:10 a=vifOU3kDqgkA:10 a=7PCjnrUJ-F5voXmZD6jJ:22
 a=gb9IC-u5QvZuJU0a8fSk:22
Message-ID: <b332fcc8-b060-8646-775f-f4b52f0363d7@inwind.it>
Date:   Sat, 15 Jul 2023 11:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: kreijack@inwind.it
Subject: Re: btrfs loses 32-bit application compatibility after a while
Content-Language: en-US
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-btrfs@vger.kernel.org
References: <87cz0w1bd0.fsf@oldenburg.str.redhat.com>
 <f393fcb9-2d8b-e21e-f0fb-d30cbbb1ed3b@libero.it>
 <CAEg-Je8EGjyX3CCcAywy7K2osGAj36T_Cbz5+VXfy4XbcemJ4g@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAEg-Je8EGjyX3CCcAywy7K2osGAj36T_Cbz5+VXfy4XbcemJ4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMqzUD1JyUKyDwIajj8vNrOER2E3HwMi1ovseKjGjdus+jCIo/LjqGJ65Wwws/5dSbEsYlV2nQGVjqP2Oufe+0AiOzOOjBxvuxcPZDoy/985Her6rV9b
 jhGI3rnLOR221ryj2YDgjuYRw9PyRBQsnunPCnkjBVMYow8EM1IHX1z0VovjGtHFF8x/p3jYtxtOn3e5xgynZDCVku9zqr1+LbEV3ew6cfTh+l1NbgKh4qBt
 WJrC1iqXKOUVtwcxBE7WgA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2023 11.09, Neal Gompa wrote:
> On Sat, Jul 15, 2023 at 4:32 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
[..]
> 
> It was somewhat common for Fedora users. A number of Fedora 32-bit ARM
> variants used Btrfs until 32-bit ARM was discontinued in Fedora 37[1].
> openSUSE still has 32-bit ARM and x86 support in Tumbleweed.
> 
> This issue is also possible on 64-bit x86 systems where 32-bit x86
> applications run on it. That's what this report is about. We're
> hitting it in Fedora because our 32-bit x86 builds in Fedora
> infrastructure run on 64-bit x86 environments and triggered this[2].
> 

 From what you wrote, it is seems more "it is technically supported" but not
big users. Otherwise I expected that a lot of bugs or complaints happened
when it was deprecated from 5.9 and removed in 5.11.

Despite that, I am curious about what could happen when a 32 bit
application tries to access a 64 bit inode: does the kernel return only
the lower part of the inode number ? How this is handled in
other FS: what happens when an fs hosts more than 2^32 files ?
Unlikely but this may happen. BTRFS makes this more easy to happen.

> [1]: https://fedoraproject.org/wiki/Changes/RetireARMv7
> [2]: https://pagure.io/releng/issue/11531
> 
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

