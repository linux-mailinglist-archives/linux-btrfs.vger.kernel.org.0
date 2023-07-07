Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132174AEA8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGGKTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjGGKTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 06:19:11 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE8EF1737
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 03:19:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 6CE5F3F352;
        Fri,  7 Jul 2023 12:13:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.002
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TlpjjCom1bRM; Fri,  7 Jul 2023 12:13:14 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6F23B3F2C1;
        Fri,  7 Jul 2023 12:13:13 +0200 (CEST)
Received: from [192.168.0.122] (port=39158)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qHiSd-000Ayi-34;
        Fri, 07 Jul 2023 12:13:12 +0200
Message-ID: <1d6d0b69-b243-d1a4-d538-d1be778a516a@tnonline.net>
Date:   Fri, 7 Jul 2023 12:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Content-Language: sv-SE, en-GB
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me>
 <ZGyVVQxnw6Tn7Xb8@pc636> <c9db92d.faed4a1c.1884c5550fb@tnonline.net>
 <20230524091357.GH32559@suse.cz> <ZHClGA9szxSqzDf8@pc636>
 <cf07f03.70397026.18918ef7f95@tnonline.net>
 <2063d59.8f9f4a3a.1892a3ec50f@tnonline.net>
 <7336b8ea-64bd-d08d-1d85-bf942d5660e2@leemhuis.info>
From:   Forza <forza@tnonline.net>
In-Reply-To: <7336b8ea-64bd-d08d-1d85-bf942d5660e2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-07-06 12:54, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.07.23 10:08, Forza wrote:
>>>> On Wed, May 24, 2023 at 11:13:57AM +0200, David Sterba wrote:
>> [...]
>> A small update.
> 
> Thx for this.
> 
>> I have been able test 6.2.16, all 6.3.x and 6.4.1 and they all show
>> the same issue.
>>
>> I am now trying 6.1.37 since two days and have not been able to
>> reproduce this issue on any of my virtual qemu/kvm machines. Perhaps
>> this information is helpful in finding the root cause?
> 
> That means it's most likely a regression between v6.1..v6.2 (or
> v6.1..v6.2.16 if we are unlucky) somewhere (from earlier in the thread
> it sounds like it might not be Btrfs).

Agreed, I do not think this specific bug (cpuidle /  default_enter_idle 
leaked IRQ state) is Btrfs related. Some of the virtual machines I test 
on do not use Btrfs.
> 
> Which makes we wonder: how long do you usually need to reproduce the
> issue? If it's not too long it might mean that a bisection is the best
> way forward, unless some developer sits down and looks closely at the
> logs. With a bit of luck some dev will do that; but if we are unlucky we
> likely will need a bisection.
> 

It has varied. Sometimes immediately upon boot, but can take several 
hours or a day before showing up.


Also, I forgot to say I was basing my kernels on gentoo-kernels, which 
has some patches against vanilla. Therefore I will I will compile a set 
of vanilla kernels from 6.1.37 until 6.4.2 and run them in my testing 
machines to see where the problem is happening.

This is not a fast system, so it will likely take several days. But I 
will keep you posted.

Meanwhile, if you think of any specific kernel debug options, tracing, 
etc, that I should enable, let me know

Should we change the Subject line of this email thread?

Thanks

~Forza

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
