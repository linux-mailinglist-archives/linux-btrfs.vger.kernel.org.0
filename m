Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB624CE351
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 07:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiCEGsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 01:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEGsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 01:48:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D8369F7
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646462856;
        bh=yIz1WJfQw3tsULKE22ahOvNMz6EBNew3K/pQtOq2ZSM=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=hrk6EsjBaeaNowcbuDB9SNLUBfVCH99UNgiQErhCLMqF+O/ocVd1VYQ8ebn7g9l0i
         R6fMw4bp8VMqzoPJLvwfTz1mafeH6C3/rUVRbKQ/rwWtWPss/Q/DGRiRLNpRvG2U4G
         Q5p8Ba20LLQhcrFdXcUedVmojnrh8hjKo8EBGlyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1nUFoz32H4-004xRz; Sat, 05
 Mar 2022 07:47:36 +0100
Message-ID: <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
Date:   Sat, 5 Mar 2022 14:47:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Remi Gauvin <remi@georgianit.com>,
        Jan Kanis <jan.code@jankanis.nl>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Is this error fixable or do I need to rebuild the drive?
In-Reply-To: <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S9tdIMPSLXzfMasuPMvhroxgdzWBGl8L4IKy1Tq9O4FoGG1jSZA
 xxlJsMF3FOpfkdcjhFjJIBycyrPIuYoxhML+1a72NP8/R1qjyTrE2PWJgCukHTlpUxTGPWL
 mHB+apIb2378HwsgbsfVGheCzPWCEoBFH5dPz/rlAeu2M7bEwtkFGhGvMNbAiB1In1zLAZF
 7qoL2GA4rZ/AY3XcZb0TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EnKCQ7yfji0=:kp+mujKBYKzub8hRfCj0h8
 G0+o4vZzCByT5Q8qmyyL551sLixJL8/lCwN6qpqKpNj/jLQKatPqZL/A7ToLLKtfbqcYliO3p
 IZ7ORI5FhDHTkjoe4BfNOz5GOVZQRZTUcrWrrFOpJKM/aA91oVyuobvnIRohPy0e91JwOIXQ4
 h5yDkGQlxhKWjwuMjl7vaKay2pDcdNzfDCRf/9RX6PNg/p+io4TQkp04RCRsnYZWMEYfj7Qy3
 d3Ood5NAHtNMqmVItXhRkI0M/40PLM8pL1ePVrX+9/ZD6br15XBZdnsdv5vK2DlHjtZzdShUG
 jNybVxb2crf3AAFo/r2N3Pfg6R/sLYtwfY7PP6RCCiyL7kbKKD1CsQ51j2CqHxUyU9kHY72os
 ShxMzogPHWE7RhR+83ZO9qm1wXvFlwfE0fSivedmDAaod++0sH4SWmhg+/ekwnmdnnZJF2tNU
 DVyO0qclLU//N0BmAHommtTCyoVDHVwPIicCo6Acw8owyemLFlQ4rhQnStG9stvBUuDLTPTRa
 K4EpkXFS+TVpz4qNDmVpWNVTRybgCGkUh35GD+Dgl86a4EfJnNT0m3fZF8zFWVf1Q66IuYyxT
 bIdYp9GiSavOjtsR6ddYckijVvRjIT8tZYkmmMEzQcCEelBVpbthYkQko4iUqvI/dIAQeArpc
 c/tAZuHVjL7o+tGZ/SF9F2GTqL0L8CG5UpEKTAzshcjNHi6Yg2v0KFk3Scvui48sZjLZ91IdC
 C99TN6Y6OQV5VZihV1ovL29lkPUIj6ZiCAxnpWnbSPW5/Grik2N69J0GngHrLZ2eOWHJazjc1
 XmH987rtPjcacS8dz8W6qozXTTO1VT8RT+fyTLVaeP1stHjQ/BFS1OWBmtoMNoMmRVP5oCFvG
 YQbHlJ315O1hBfcOOClT2+8j66J2W3RA3nTUwH9Zj9jJ7LMdlxFb+ImTIOOAJQPVUlgkhdTtI
 iZDK01AVc3sL0wq3Tjb9ict+zrWdite5epLewVONiBGVCKYSRFjDcqdHBbGuPKf6xe3RH405b
 H7p8c23prMLKoYQunCyKw80fjjYvtLSIk+XRXuIY56oO3DgxVJ2jynFrlyj+pM7J29YqsojMZ
 78QNgzFo7xftWw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 11:11, Remi Gauvin wrote:
> On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
>
>>  =C2=A0So by now I'm thinking that btrfs
>>> apparently does not fix this error by itself. What's happening here,
>>> and why isn't btrfs fixing it, it has two copies of everything?
>>> What's the best way to fix it manually? Rebalance the data? scrub it?
>>
>> Scrub it would be the correct thing to do.
>>
>
> Correct me if I'm wrong, the statistical math is a little above my head.
>
> Since the failed drive was disconnected for some time while the
> filesystem was read write, there is potentially hundreds of thousands of
> sectors with incorrect data.

Mostly correct.

>  That will not only make scrub slow, but
> due to CRC collision, has a 'significant' chance of leaving some data on
> the failed drive corrupt.

I doubt, 2^32 is not a small number, not to mention your data may not be
  that random.

Thus I'm not that concerned about hash conflicts.

>
> If I understand this correctly, the safest way to fix this filesystem
> without unnecessary chance of corrupt data is to do a dev replace of the
> failed drive to a hot spare with the -r switch, so it is only reading
> from the drive with the most consistent data.  This strategy requires a
> 3rd drive, at least temporarily.

That also would be a solution.

And better, you don't need to bother a third device, just wipe the
out-of-data device, and replace missing device with that new one.

But please note that, if your good device has any data corruption, there
is no chance to recover that data using the out-of-date device.

Thus I prefer a scrub, as it still has a chance (maybe low) to recover.

But if you have already scrub the good device, mounted degradely without
the bad one, and no corruption reported, then you are fine to go ahead
with replace.

Thanks,
Qu

>
> So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is the
> drive that had taken a vacation....
>
> And /dev/sdc1 is a new hot spare
>
> btrfs replace start -r /dev/sdb1 /dev/sdc1
>
> (On some kernel versions you might have to reboot for the replace
> operation to finish.  But once /dev/sdb1 is completely removed, if you
> wanted to use it again, you could
>
> btrfs replace start /dev/sdc1 /dev/sdb1
>
