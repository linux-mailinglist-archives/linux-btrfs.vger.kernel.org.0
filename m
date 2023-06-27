Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033F74030D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjF0SR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0SRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 14:17:24 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2C210D;
        Tue, 27 Jun 2023 11:17:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D66EC601E5;
        Tue, 27 Jun 2023 20:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687889833; bh=ISK3WC7f1l2wOaOMFHmv6Z7JIkw/SwNFhMBbaXzowYQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Xx42ERRRISfNNmdOETgFTWFSxJ3UjszyxRw64dmTf4712Z2xMfh617FajqTG7V/hU
         6U02tQPafJbNffod085mctIGqMzuuBuP3snjs64hA7l+uGF4qeXkwwG6rRp3n7QNRB
         pyFiz2RMUjJzAJc/mKPeo1x0S1MYCyfxzZUrzCXMMnYLKWaQU/Q+b0OUfeXF9mP439
         g+KmavotNI5HOpTGdzk6RtmaSQMZP4brr4XhEeAgEw+67MppQloCVbiMrMMoYWpcQI
         ddG8nDkHJryZ4AdeJeya0wcZALmDeRYPyyAnrShcG/FcBMXapRJtyov2L0yIWGeUEb
         rqshiBUPstm0g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SCEbsrVQbiXl; Tue, 27 Jun 2023 20:17:11 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6710B601CE;
        Tue, 27 Jun 2023 20:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1687889831; bh=ISK3WC7f1l2wOaOMFHmv6Z7JIkw/SwNFhMBbaXzowYQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=v+kSAdB6RJWrNsYkIUcNB8qjZOomA1u5bB/1YTnQarkI1Mnob4INT4G9u/xk3dr4k
         FUTi+NX/P8QN/Q9HeyxcDqeJ3eXMbRuyDUiTOpQ/eR7fsMLObwlLdfIG5bZ9qUhg+J
         Vry3bBQGmRNpU278B+FFHOmEENlTj/I+eQ/kVrHT052B3P2cIJ118X0E1lW7r6JOjc
         FJnPwKVw4iI4yamigMijZfS5Rdc6Hkm6zP+9qV+7bNAC7+W8i7waCtAY7iDFhtDzmE
         xpxHwjOrS78rXDtgpzRsTNy3TKnnJrR68LA7U+9wCE42ubbtol19ziU+pWPWvLBRrF
         FB/yXhRmRroWQ==
Message-ID: <721575ee-4a48-dab1-eabd-32428c20cc72@alu.unizg.hr>
Date:   Tue, 27 Jun 2023 20:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [BUG] btrfs: MAX_LOCKDEP_CHAIN_HLOCKS too low!
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <5ce1e20e-019b-373f-f412-31fdb2c2379d@alu.unizg.hr>
 <ffa970c3-6907-023b-c8fb-7438694b24ef@gmx.com>
 <20230627142739.GB16168@twin.jikos.cz>
 <ca3f483e-38fc-786b-d85b-35d543a701a9@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <ca3f483e-38fc-786b-d85b-35d543a701a9@alu.unizg.hr>
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

On 6/27/23 18:27, Mirsad Goran Todorovac wrote:
> Hi, Qu, David,
> 
> On 6/27/23 16:27, David Sterba wrote:
>> On Tue, Jun 27, 2023 at 08:19:37AM +0800, Qu Wenruo wrote:
>>>
>>> On 2023/6/27 07:40, Mirsad Goran Todorovac wrote:
>>>> Hi,
>>>>
>>>> There is a bug apparently in btrfs file system.
>>>>
>>>> The platform is an assembled box with Ryzen 9 processor and ASRock X670E PG
>>>> Lightning motherboard.
>>>>
>>>> I do not have a reproducer, just kernel log:
>>>>
>>>> Jun 26 20:41:58 defiant kernel: [ 2273.786736] BUG:
>>>> MAX_LOCKDEP_CHAIN_HLOCKS too low!
>>>
>>> This is really what it said.
>>>
>>> The setting is too low for certain workload.
>>>
>>> In fact Fedora is already increasing this value.
>>> If you want lockdep, I guess that's the only way to go.
>>
>> https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#bug-max-lockdep-chain-hlocks-too-low
>>
>> As the reports will probably keep coming until lockdep changes I'll move
>> the answer to a more user-visible page.
> 
> Thank you for your prompt response. It wasn't obvious from the kernel
> message though which .config setting needs adjustment.
> 
> I am yet unable to tell whether the lockdep setting being too low and
> turning off the locking correctness validator caused the kernel crash, but
> I will know more after restarting the kselftest with the new lockdep
> setting ...

P.S.

I heard it is uncool to answer one's own email, but I have been unable to
reproduce the crash of yesterday without or with pcscd smartcard daemon
in debug mode.

This of course doesn't mean that the LOCKDEP setting was a direct cause
of crash, I believe that findings are inconclusive. (IMHO, correct locking
should work even with locking correctness validator turned off.)

FYI, here are the crash logs, in case it could help improve btrfs:

[1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-06-27/

Best regards,
Mirsad Todorovac
