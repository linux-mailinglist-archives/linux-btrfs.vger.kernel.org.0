Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95858740125
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjF0Q2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjF0Q2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 12:28:24 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6635B7;
        Tue, 27 Jun 2023 09:27:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 780A7601CD;
        Tue, 27 Jun 2023 18:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687883236; bh=PpvpQ7qA4SZsupO2UFswYMjPY70xB+TlEdu1lDZnlOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yOFbT+ivfS8OVzT1KzPrTx0u+2Xi/f26URzfunZ3w7VOKWvo4JMKEM5NIQ4X6o2LR
         OLyqF7etUkjuXlXEaEtIwkrg62ySekUDXy9F5/Wpl1f/9ANE/EVnqedqvWvgtXW9A4
         UFBC8T+FXFT7lPm7ZSS0RwBzJVLFXgIizoflVZhFuj8b1e4fVJ2NXa3F1VkffrLdW6
         CthipW7KDfWu3jlH5gjxRVO7Pdd6TFS56AoOjkh3Xqm5o0KJwXQCVHvYqHH4RS6HKI
         1v1rpgrHOkgU9sZU5CAeyDBsUpCAX6jo6PnDrn21SF3WqaffiLlbpHbh8m61RK4BK2
         NvQGOYGiV0RUw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RYpT5lz9rsTX; Tue, 27 Jun 2023 18:27:14 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 4B6DC601CA;
        Tue, 27 Jun 2023 18:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687883234; bh=PpvpQ7qA4SZsupO2UFswYMjPY70xB+TlEdu1lDZnlOE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rzvndaAz2FhgC74skKXy0L7dGqDySYNMvVr0AI9kwMcOhI5q9TRyTwYMA5SyUlOSQ
         nRTGUIfpEyt/BLDylTKRuVKCOlKlxQ7n3HcGPpiGWxPbB2imdg/w5NIgi1K3vizJhz
         lEUtn6TEmL6TkP3j62SQrg44A1lFG4/D9oQbal3UeZFheLF6lmxkm8GqpaAHzA2SUa
         r2cOQj1RS/ILXaYW15zSzE6PvGZyDGN+kbJvN/rlzKrvFunvqSMUXETqIOO9fsQPak
         IjjbX3FV45wPQe7nMqkRr01wmkmk6+fxfTNq/TdRnKBwPkBoMui3H6kLSQfBqms0hZ
         kylSIYc8BD7Qg==
Message-ID: <ca3f483e-38fc-786b-d85b-35d543a701a9@alu.unizg.hr>
Date:   Tue, 27 Jun 2023 18:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] btrfs: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <5ce1e20e-019b-373f-f412-31fdb2c2379d@alu.unizg.hr>
 <ffa970c3-6907-023b-c8fb-7438694b24ef@gmx.com>
 <20230627142739.GB16168@twin.jikos.cz>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230627142739.GB16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Qu, David,

On 6/27/23 16:27, David Sterba wrote:
> On Tue, Jun 27, 2023 at 08:19:37AM +0800, Qu Wenruo wrote:
>>
>> On 2023/6/27 07:40, Mirsad Goran Todorovac wrote:
>>> Hi,
>>>
>>> There is a bug apparently in btrfs file system.
>>>
>>> The platform is an assembled box with Ryzen 9 processor and ASRock X670E PG
>>> Lightning motherboard.
>>>
>>> I do not have a reproducer, just kernel log:
>>>
>>> Jun 26 20:41:58 defiant kernel: [ 2273.786736] BUG:
>>> MAX_LOCKDEP_CHAIN_HLOCKS too low!
>>
>> This is really what it said.
>>
>> The setting is too low for certain workload.
>>
>> In fact Fedora is already increasing this value.
>> If you want lockdep, I guess that's the only way to go.
> 
> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#bug-max-lockdep-chain-hlocks-too-low
> 
> As the reports will probably keep coming until lockdep changes I'll move
> the answer to a more user-visible page.

Thank you for your prompt response. It wasn't obvious from the kernel
message though which .config setting needs adjustment.

I am yet unable to tell whether the lockdep setting being too low and
turning off the locking correctness validator caused the kernel crash, but
I will know more after restarting the kselftest with the new lockdep
setting ...

Best regards,
Mirsad Todorovac
