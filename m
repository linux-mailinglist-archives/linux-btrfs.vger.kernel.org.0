Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A211D3643
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgENQSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 12:18:13 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:55202 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgENQSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 12:18:12 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 00E2B9C3AD; Thu, 14 May 2020 17:18:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589473089;
        bh=Hdvcj4QOB7Q5oqulmFe4Mfvirues02DO567HzSsbw/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GlWMkBQXEogXt83JKlXzkQigZkAFPO+p57zbOUU9zZ8CgipFO5xBxnMyyqrPSg+KW
         2n9wSO3s8tcips/QpkJLNi6DgFZ0fjR/2O8+dhP4SzLJcGCHF+EDq2GgjlFhV83fWO
         KZIFpYAmaGUmqdPzYhzxWCMDC7+v72dEIX8vkADCxtKFIfocf4fACnKjcoDFTci1TP
         Aw0/ffTASwTs+nlnFvIwXbH5UELRcaew1/Iqr08Gdi5c8tkUuWSUHTkRb/kSfwZ9ng
         Z/RW6PUfRfeTYf8Ads87WU4JcjWmDUhQsEV7LwOkoaBDSaNxZlprXOuchT1fltWqow
         zrQmlD6HouPiw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DF8379B7D0;
        Thu, 14 May 2020 17:18:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589473085;
        bh=Hdvcj4QOB7Q5oqulmFe4Mfvirues02DO567HzSsbw/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=voeFsknEhDFyhTZ/m3Ytyc/IS00lEW53IuLxDd4+ZctZvInQQeUgsXX+fyXoTRNFP
         leVJ/2WHBiV2ENFTtcpvInXh1zXo30NElaBOrBOln7I0yVphVG0JkNZr1L8PuqDLhE
         EMq4m1Jdchqjy5ykaOY3ZqmR3ZZdXHl4lvOEoQFisEq9wvR1Ke70+1rc7ilmuOo1M/
         akw5V6sdZ6dsjZBLiZQcdgJnLBk/oTXaO5O5p0+slzfj3ENROYyACm+YACwsJYhCDZ
         5UCCMSEgwcvlvJBVwqn7zE/usXhbKUr6uNaqu8sKUemvRCFd6aOy1JtOdxecvwlbbp
         GGvC71ETn7rBA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 78E9F10417D;
        Thu, 14 May 2020 17:18:04 +0100 (BST)
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>,
        Andrew Pam <andrew@sericyb.com.au>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
 <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
 <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au>
 <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
 <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
 <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
 <b41da576-55b2-4599-10e9-e8aeb0e9ad20@sericyb.com.au>
 <CAJCQCtSWwypfm2xjtJ2vP8O4LT2bFOY=omHMMPe8_Jq6jG_3qA@mail.gmail.com>
 <65cdf796-02f6-d20f-4b7f-b258d1685e2c@sericyb.com.au>
 <CAJCQCtS3OKrM2_bEVVhTEnqtOrV4aN80bpkYa60QfB9dz97anQ@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <17b75152-10c7-d44f-bf0d-38e7cfcd4eb0@cobb.uk.net>
Date:   Thu, 14 May 2020 17:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS3OKrM2_bEVVhTEnqtOrV4aN80bpkYa60QfB9dz97anQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/05/2020 01:13, Chris Murphy wrote:
> On Wed, May 13, 2020 at 12:49 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>>
>> On 11/5/20 2:46 pm, Chris Murphy wrote:
>>> I also wonder whether the socket that Graham mentions, could get in
>>> some kind of stuck or confused state due to sleep/wake cycle? 

Clarification: I originally said that the socket was for communication
between the scrub process and the kernel, but that was wrong.

I tried to correct in a later message but, in any case, the socket is
between the scrub usermode process and the "status" command.

I suppose it is possible that suspend/resume causes some problem with
sockets or with the thread which processes the socket but I would be
surprised. In any case, that should only cause strangeness with "scrub
status".

My case,
>>> NVMe, is maybe not the best example because that's just PCIe. In your
>>> case it's real drives, so it's SCSI, block, and maybe libata and other
>>> things.
>>
>> Could be.  When I start a new scrub and suspend the system, after a
>> resume further attempts to run "btrfs scrub status -dR /home" result in
>> the following:
>>
>> NOTE: Reading progress from status file

This means that scrub status could not connect to the socket and has
fallen back to reading the file (which may be out of date if the scrub
is actually still running). Either there is some strangeness about the
socket or the scrub usermode process itself is not running or the thread
which handles the socket is stuck (it normally sleeps in a "poll"
waiting for connections to the socket).

>> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
>> scrub device /dev/sda (id 1) status
>> Scrub started:    Wed May 13 16:10:12 2020
>> Status:           running
>> Duration:         0:00:22
>>         data_extents_scrubbed: 0
>>         tree_extents_scrubbed: 29238
>>         data_bytes_scrubbed: 0
>>         tree_bytes_scrubbed: 479035392
>>         read_errors: 0
>>         csum_errors: 0
>>         verify_errors: 0
>>         no_csum: 0
>>         csum_discards: 0
>>         super_errors: 0
>>         malloc_errors: 0
>>         uncorrectable_errors: 0
>>         unverified_errors: 0
>>         corrected_errors: 0
>>         last_physical: 0
>> scrub device /dev/sdb (id 2) status
>> Scrub started:    Wed May 13 16:10:12 2020
>> Status:           running
>> Duration:         0:00:23
>>         data_extents_scrubbed: 0
>>         tree_extents_scrubbed: 27936
>>         data_bytes_scrubbed: 0
>>         tree_bytes_scrubbed: 457703424
>>         read_errors: 0
>>         csum_errors: 0
>>         verify_errors: 0
>>         no_csum: 0
>>         csum_discards: 0
>>         super_errors: 0
>>         malloc_errors: 0
>>         uncorrectable_errors: 0
>>         unverified_errors: 0
>>         corrected_errors: 0
>>         last_physical: 0
>>
>> So it appears that the socket connection to the kernel is not able to be
>> reestablished after the resume from suspend-to-RAM.  Interestingly, if I
>> then manually run "btrfs scrub cancel /home" and "btrfs scrub resume -c3
>> /home" then the status reports start working again.  It fails only when
>> "btrfs scrub resume -c3 /home" is run from the script
>> "/usr/lib/systemd/system-sleep/btrfs-scrub" as follows:
>>
>> #!/bin/sh
>>
>> case $1/$2 in
>>   pre/*)
>>     btrfs scrub cancel /home
>>     ;;
>>   post/*)
>>     sleep 1
>>     btrfs scrub resume -c3 /home
>>     ;;
>> esac

Try scrub resume restarts the scrub and backgrounds it. Maybe there is
something strange about background processes created in the restore
script. What happens if you specify "-B" on the resume?

Another potential problem is that the "scrub cancel" cancels the scrub
but the scrub process doesn't immediately exit (it waits to receive the
"cancelled" status and get the final stats, then it writes them out and
does some tidying up). So maybe there is a race: maybe the scrub is
still cancelling (either in the kernel, or the scrub usermode process
itself is still thinking about exiting) when the suspend happens. On
resume, maybe the cancel then completes -- that might even be why the
resume doesn't work without the delay.

It is even possible that the resume could succeed in resuming but using
bad last_physical data if the cancel process is still writing it out. I
don't suppose anyone has really tested races between cancel and resume.

Try adding a sleep after the cancel (or logic to see if the scrub
process has actually exited).

>>
>> Without the sleep, it does not resume the scrub.  A longer sleep (5
>> seconds) does not resolve the issue with the status reports.
>>
>> Maybe this is some kind of systemd problem...  :(
> 
> Oof. So possibly two bugs.
> 
> Well, you could post an inquiry about it to systemd-devel@. And then
> maybe try to reproduce with something that has systemd-245 to see if
> it makes a difference. I ran into something that looked like races in
> 244 with a rust generator I was testing, that didn't happen in 245.
> *shrug*
> 
> But I'm not sure testing wise how to isolate the systemd from the
> socket questions.
> 
> 

