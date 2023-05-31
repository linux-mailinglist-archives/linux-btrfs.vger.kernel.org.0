Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FD17189A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjEaSvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEaSvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 14:51:01 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF119B
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 11:50:40 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.130.244])
        by smtp-17.iol.local with ESMTPA
        id 4Qu5q299UpE874Qu6qovaO; Wed, 31 May 2023 20:50:38 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1685559038; bh=wT1mpxJTWAC7FGev/56gvey4OxbqnnpKVvJ/vRV/e/0=;
        h=From;
        b=R3LrsOvA+b1V+tCE6RrnJyNTYHTS5LxG0buRh/+OAvjGWv5/TEQeJ0uRk+Hz/Rw2T
         J+3xKVDYWOHx/XtwH1p9BGmPHbVoxwthuZgilFbKLxHm4lXW3hzh52nXxXBteed+Sx
         3oaOzIXYy+ESAI0fLEJlQMkCQQyv/HA2eJXmGxbEY1XaqSjHMewebBvTW93INEdWCn
         hR37aXuakz56AhxPWdVdEhJwe2NxKsM/EpqMiP8raw3USfu1LPRJdsyCS4C9tsbrG0
         OLh0TD4E4KbS+yqSUALojbuz0DX3HeMOIfmJBfUvZ85YixilblBPrgY8l/GeDRJGUh
         T0OQA02QIlz+w==
X-CNFS-Analysis: v=2.4 cv=fr4aJn0f c=1 sm=1 tr=0 ts=647796fe cx=a_exe
 a=/wLRv2O41UH3tPl3WKguSg==:117 a=/wLRv2O41UH3tPl3WKguSg==:17
 a=IkcTkHD0fZMA:10 a=UXIAUNObAAAA:8 a=Ye9q-bpsAAAA:8 a=Ikd4Dj_1AAAA:8
 a=SsSpJcFrp-bFvcAm5KAA:9 a=QEXdDO2ut3YA:10
Message-ID: <e2170a4e-0afa-e151-39a8-5c683cf6b02b@libero.it>
Date:   Wed, 31 May 2023 20:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: btrfs raid10 rebalance questions
Content-Language: en-US
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        Todor Ivanov <t.i.ivanov@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAOv4OrX7kxTMrpE+AdqWo+PCsAGpBkrJ9irr9Xj8ZcRrPTvRoA@mail.gmail.com>
 <CAOv4OrUdSBccOiEk_fW2c8wm9YwfYk2vGZtCwHFj_woXKm5NKg@mail.gmail.com>
 <4bd29f45-935d-ef16-9f97-1c48e74a385f@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <4bd29f45-935d-ef16-9f97-1c48e74a385f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEcppZhjuo/fKS0mHWN0h/eDGe9sEHEMv5Xws4t9T4uh0o9jVMHZD7EmQKWXO/LMk+hiLczAlDCnfZ9PmJJqv9JDV0EGVOJ4xTTVO29AXv3MAc/zLixi
 0ANjlZdGHrwdVD+9hda+ubafQb3+BjdDiZWk+q9uG/OwciMUVd4BSXPVz+SmbWTsDMcxRNnay46N/W+h6qvzyjvilesdUj6o1Q5WuYQWfiJmydEY+aLeUVvl
 t7Rd0km7WNDBvYa4wlGUluqgU3Uaj2I8arpNbIAXdQimCGTyNCJvWmh/De8Dq/pN
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

On 31/05/2023 14.48, DanglingPointer wrote:
> Hi Todor,
> 
> Have you tried looking at the new documentation? https://btrfs.readthedocs.io/en/latest/
> 
> Could someone respond to Todor?  Many have similar questions and experiences.  Thanks in advance!
> 

Please don't do top-posting.
> 
> On 22/5/23 23:02, Todor Ivanov wrote:
>>       Hello,
>>
>>       We have a debian10 system with 6x16TB in btrfs raid10. In the
>> past we hit an issue with lack of space, which we resolved with data
>> rebalance, but some questions left unanswered:
>>
>> https://unix.stackexchange.com/questions/743528/btrfs-snapshot-fails-with-no-space-left
>>

If you want support here, please put the relevant information only in the email
body, not in a website or an attachment.

>> We will be very happy if you can answer or give guidelines for at
>> least the following:
>>
>> - How often should we run btrfs balance? Trying to use some logic and
>> looking at https://docs.nvidia.com/networking-ethernet-software/knowledge-base/Configuration-and-Usage/Storage/When-to-Rebalance-BTRFS-Partitions/
>> looks like a good example, but this is not for RAID10. How do we
>> calculate chunk size correctly and should we alter Device Size beause
>> of data duplication?

The criteria exposed in the nvidia website seem reasonable:
a) if you are allocated more of the 80% of the disk(s)
b) and if the differences between the allocated space and the consumed space is
    greater than a chunk
likely a rebalance will free some space.

Because you are using a RAID10 profile, b) becomes:
b) and if the differences between the allocated space / 2 and the consumed space is
    greater than a chunk

where "/2" is because the there are two copies of the data

>> - Is it dangerous and should we rebalance metadata as well, having in
>> mind we use btrfs-progs v4.20.1, kernel 4.19.0-16-amd64 and btrfs
>> raid10? What is an optimal value for musage?

As general advice, the kernel 4.19 is very old. The kernel 4.19.0-16-amd64
is 2 years old. It is strongly suggest a kernel upgrade. It seems that the
latest 4.19 debian kernel is linux-image-4.19.0-24-amd64; almost try to
update to this.

Between the 4.19.0-16-amd64 and the linux-image-4.19.0-24-amd64 I see
something like ~80 btrfs patches/fix.

>> - What does it mean when "btrfs fi us" is showing a lot of
>> "Unallocated" space, and yet we ran into the out of space issue
>> (probably on Metadata data - subvolume snapshot), why isn't Metadata
>> expanding into that Unallocated space automatically?

I don't have a valid explanation. It should not happen because you had
more than 20/6 = 3,3TB un-allocated for each disk.

May be an allocator bug.


>>
>> Kind regards,
>> Todor

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

