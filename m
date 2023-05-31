Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB17189E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEaTKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEaTKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 15:10:54 -0400
Received: from libero.it (smtp-36.italiaonline.it [213.209.10.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31F192
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 12:10:48 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.130.244])
        by smtp-36.iol.local with ESMTPA
        id 4RDaqV5ry3z8y4RDaqHjIE; Wed, 31 May 2023 21:10:47 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1685560247; bh=vGeYGGEbdADmG3wz/NTI1cf66NjDHfRiFKPVE/N7Rvw=;
        h=From;
        b=IUIixya5D6zQxQm1XfvM8QLdNuioOqHZEl0LeIqGIyvZILF8pedFD8YHN3/i7Rhai
         sCEpTHLsB9fLvaUBO8JMIO9urp5tLgGG2ZsDvm0u2Ly4yMs2mZQOYglcozhtfSYo6W
         cZwBfsAxE9kxeGGKAb/s7IP2XBNWOHvd2FGlf6SOSPoXwlP4GbiA9vblRmclO6ijvc
         UiXJRZ0+Fd8n3JS6hfkIX5kBEtQpudZ1J1bzwUsXpkZivz54HO6XK6XgPJMxXauEiK
         OAtUGX8jaNBt8VPLHT964FuwefPv4THAJ/hAoLWhoJE1SL7Yi7wMkFJ8yjA/3VMA7Z
         lVoNweJrd0PAQ==
X-CNFS-Analysis: v=2.4 cv=VpPlQc6n c=1 sm=1 tr=0 ts=64779bb7 cx=a_exe
 a=/wLRv2O41UH3tPl3WKguSg==:117 a=/wLRv2O41UH3tPl3WKguSg==:17
 a=IkcTkHD0fZMA:10 a=UXIAUNObAAAA:8 a=Ye9q-bpsAAAA:8 a=Ikd4Dj_1AAAA:8
 a=0Ni6rV8TAAAA:8 a=l7SZrYRvBU6Z3sHQ-zoA:9 a=QEXdDO2ut3YA:10
 a=MEv8DOuCJPEGjlO0Qob3:22
Message-ID: <644c0ac8-2bb2-eac1-1ded-4e9628dd3e97@inwind.it>
Date:   Wed, 31 May 2023 21:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: btrfs raid10 rebalance questions
Content-Language: en-US
To:     Todor Ivanov <t.i.ivanov@gmail.com>
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAOv4OrX7kxTMrpE+AdqWo+PCsAGpBkrJ9irr9Xj8ZcRrPTvRoA@mail.gmail.com>
 <CAOv4OrUdSBccOiEk_fW2c8wm9YwfYk2vGZtCwHFj_woXKm5NKg@mail.gmail.com>
 <4bd29f45-935d-ef16-9f97-1c48e74a385f@gmail.com>
 <e2170a4e-0afa-e151-39a8-5c683cf6b02b@libero.it>
 <CAOv4OrVD7Wv4PefkFYNOY054kWKpZ0OFY=UqZ29sk2VQcYmGgQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAOv4OrVD7Wv4PefkFYNOY054kWKpZ0OFY=UqZ29sk2VQcYmGgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI13im2j720A0D9v7f4mO5t2ucko/crU1OI7dGLXSWCNBYgl/CxN/zbibKw5kho+VXxQpku8YeP7Pp/mmOuPBUsCoO9TpJ4voJudX2yqypP4qphG9Icw
 vg5NJtcMaHYfARloNcQaLjfkkKygwD40q4X76my6+4jKNlqYd/TgzpnzWFy6EyofOUKaSbWutwVy+/Gsg8Qey7SA8ootHzXjpFl6Gj84pY+P8vZ02voUPM0e
 jEarGHiYGLF1hk7uObYTItC4eHLo03BbylZVnaeIZSF4DV/ZPbi2Y5o/6BY0/2LW
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/05/2023 21.00, Todor Ivanov wrote:
>     Dear Goffredo,
> 
>     Thank you for your explanations. I will follow your instructions on the calculation part and the kernel upgrade.

Please, also follow amy advice about avoiding the top-posting :-)

>     To conclude the topic, can you please, tell us if it is okay, to rebalance raid10 metadata as well so space is reclaimed  (after we patch the kernel) ?

I don't think that you had a "No space left" due to a not well balanced filesystem. You had a lot of unallocated space:
BTRFS allocated chunk with a size of 1GB, when you had 3T free for each disk: you had 3000 times free space than you needed.

I think that you faced another problem/bug of btrfs. I don't know if balancing really solved the issue or something else solved the issue at the same time you did the balancing.

My opinion is that it is better to upgrade the kernel and do a btrfs scrub to check if there are others problem (I don't think so, but...).

BR
G.

> 
> Kind regards,
> Todor
> 
> 
> On Wed, May 31, 2023, 9:50 PM Goffredo Baroncelli <kreijack@libero.it <mailto:kreijack@libero.it>> wrote:
> 
>     On 31/05/2023 14.48, DanglingPointer wrote:
>      > Hi Todor,
>      >
>      > Have you tried looking at the new documentation? https://btrfs.readthedocs.io/en/latest/ <https://btrfs.readthedocs.io/en/latest/>
>      >
>      > Could someone respond to Todor?  Many have similar questions and experiences.  Thanks in advance!
>      >
> 
>     Please don't do top-posting.
>      >
>      > On 22/5/23 23:02, Todor Ivanov wrote:
>      >>       Hello,
>      >>
>      >>       We have a debian10 system with 6x16TB in btrfs raid10. In the
>      >> past we hit an issue with lack of space, which we resolved with data
>      >> rebalance, but some questions left unanswered:
>      >>
>      >> https://unix.stackexchange.com/questions/743528/btrfs-snapshot-fails-with-no-space-left <https://unix.stackexchange.com/questions/743528/btrfs-snapshot-fails-with-no-space-left>
>      >>
> 
>     If you want support here, please put the relevant information only in the email
>     body, not in a website or an attachment.
> 
>      >> We will be very happy if you can answer or give guidelines for at
>      >> least the following:
>      >>
>      >> - How often should we run btrfs balance? Trying to use some logic and
>      >> looking at https://docs.nvidia.com/networking-ethernet-software/knowledge-base/Configuration-and-Usage/Storage/When-to-Rebalance-BTRFS-Partitions/ <https://docs.nvidia.com/networking-ethernet-software/knowledge-base/Configuration-and-Usage/Storage/When-to-Rebalance-BTRFS-Partitions/>
>      >> looks like a good example, but this is not for RAID10. How do we
>      >> calculate chunk size correctly and should we alter Device Size beause
>      >> of data duplication?
> 
>     The criteria exposed in the nvidia website seem reasonable:
>     a) if you are allocated more of the 80% of the disk(s)
>     b) and if the differences between the allocated space and the consumed space is
>          greater than a chunk
>     likely a rebalance will free some space.
> 
>     Because you are using a RAID10 profile, b) becomes:
>     b) and if the differences between the allocated space / 2 and the consumed space is
>          greater than a chunk
> 
>     where "/2" is because the there are two copies of the data
> 
>      >> - Is it dangerous and should we rebalance metadata as well, having in
>      >> mind we use btrfs-progs v4.20.1, kernel 4.19.0-16-amd64 and btrfs
>      >> raid10? What is an optimal value for musage?
> 
>     As general advice, the kernel 4.19 is very old. The kernel 4.19.0-16-amd64
>     is 2 years old. It is strongly suggest a kernel upgrade. It seems that the
>     latest 4.19 debian kernel is linux-image-4.19.0-24-amd64; almost try to
>     update to this.
> 
>     Between the 4.19.0-16-amd64 and the linux-image-4.19.0-24-amd64 I see
>     something like ~80 btrfs patches/fix.
> 
>      >> - What does it mean when "btrfs fi us" is showing a lot of
>      >> "Unallocated" space, and yet we ran into the out of space issue
>      >> (probably on Metadata data - subvolume snapshot), why isn't Metadata
>      >> expanding into that Unallocated space automatically?
> 
>     I don't have a valid explanation. It should not happen because you had
>     more than 20/6 = 3,3TB un-allocated for each disk.
> 
>     May be an allocator bug.
> 
> 
>      >>
>      >> Kind regards,
>      >> Todor
> 
>     -- 
>     gpg @keyserver.linux.it <http://keyserver.linux.it>: Goffredo Baroncelli <kreijackATinwind.it>
>     Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

