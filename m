Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368045395EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346849AbiEaSMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiEaSMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 14:12:54 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC3F4830A
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 11:12:52 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.29.176])
        by smtp-17.iol.local with ESMTPA
        id w6MInEjghdCmNw6MIndtBd; Tue, 31 May 2022 20:12:49 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1654020769; bh=Z2HQ6rD6olnQVIqNCwvsovUUzrvZ+/3A045IJVj36OY=;
        h=From;
        b=r9bhSSHx+a3Ja3mymHqqaHtL9uPqjCNx/CqilCF/mePKEKvO4QZjT9RRvu4W1zwbo
         hpH+8QiNy8XXUvg89xN4lELur0QJIfUaZrL1Yw2rJtj7k2X/KT5OTEFnA5akbvgYRZ
         ASWPGJ+DFwVFmbruA8xmfdE7px/Xc+PMcXG3zizwarPZvaSWM3Q6pD5mrdFK9WuREh
         8M1T4gpN4zjqOwsdkcQMCSpZot1jtvP9FL+YP37fGFDukYQgn/76Fnl+l9qE9PNIk+
         Dq/Vt51a+3DwC7qMDn45vmk1z2bIsiIje/6Ha1pufdyWm7dePBqVQzKyBC2Il3nyud
         cf42mOEZ9IsHA==
X-CNFS-Analysis: v=2.4 cv=f/SNuM+M c=1 sm=1 tr=0 ts=62965aa1 cx=a_exe
 a=j3kPaYAfCNpxz33IBwghmg==:117 a=j3kPaYAfCNpxz33IBwghmg==:17
 a=IkcTkHD0fZMA:10 a=xm1cPhFFAAAA:8 a=Mo9pGrgWjtRv0qrd5nQA:9 a=QEXdDO2ut3YA:10
 a=T4-LoNXZg-JpA6iqeA2L:22
Message-ID: <24613105-faa7-8b0d-5d55-53d01a7c1172@libero.it>
Date:   Tue, 31 May 2022 20:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Language: en-US
To:     Colin Guthrie <gmane@colin.guthr.ie>, linux-btrfs@vger.kernel.org
Cc:     systemd-devel@lists.freedesktop.org
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
 <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
 <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
 <CAEg-Je9rr4Y7JQbD3iO1UqMy48j7feAXFFeaqpJc6eP7FSduEw@mail.gmail.com>
 <t752jd$pjm$1@ciao.gmane.io>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <t752jd$pjm$1@ciao.gmane.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFjFCBKKX89q2SWDzqs6QYYNHF1D8wUs36jU+TImieIXz3F0dEIua6WdDfmbp/td2f6RCPyC81/zb/FzAWT91I/7zfD00pI7Fpg7aoOIJnZIaoZU+zsV
 KLoUi58DyUzRJEQ106Q0n1rl7Xm5vMbhvyb+W8KbjZLS5NqKVEmMy73X6cKkM/g8JVvz1tO3rDplGYwzplfbhpsCix/zlWYbwTUgM3TKB7d4/NvmjBsAlMcy
 LGuJO3IWcPeXbpd3+7OSC5ePYgkefnz/f+Ry5t81pDQ=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/05/2022 14.44, Colin Guthrie wrote:
> Hi,
> 
> Neal Gompa wrote on 01/02/2022 19:55:
>> On Tue, Feb 1, 2022 at 2:02 PM Colin Guthrie <colin@booksterhq.com> wrote:
>>>
>>> Goffredo Baroncelli wrote on 30/01/2022 09:27:
>>>> On 29/01/2022 19.01, Chris Murphy wrote:
>>>>> On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli
>>>>> <kreijack@libero.it> wrote:
>>>>>>
>>>>>> I think that for the systemd uses cases (singled device FS), a simpler
>>>>>> approach would be:
>>>>>>
>>>>>>        fstatfs(fd, &sfs)
>>>>>>        needed = sfs.f_blocks - sfs.f_bavail;
>>>>>>        needed *= sfs.f_bsize
>>>>>>
>>>>>>        needed = roundup_64(needed, 3*(1024*1024*1024))
>>>>>>
>>>>>> Comparing the original systemd-homed code, I made the following changes
>>>>>> - 1) f_bfree is replaced by f_bavail (which seem to be more
>>>>>> consistent to the disk usage; to me it seems to consider also the
>>>>>> metadata chunk allocation)
>>>>>> - 2) the needing value is rounded up of 3GB in order to consider a
>>>>>> further 1 data chunk and 2 metadata chunk (DUP))
>>>>>>
>>>>>> Comments ?
>>>>>
>>>>> I'm still wondering if such a significant shrink is even indicated, in
>>>>> lieu of trim. Isn't it sufficient to just trim on logout, thus
>>>>> returning unused blocks to the underlying filesystem?
>>>>
>>>> I agree with you. In Fedora 35, and the default is ext4+luks+trim
>>>> which provides the same results. However I remember that in the past the
>>>> default
>>>> was btrfs+luks+shrunk. I think that something is changed i.
>>>>
>>>> However, I want to provide do the systemd folks a suggestion ho change
>>>> the code.
>>>> Even a warning like: "it doesn't work that because this, please drop it"
>>>> would be sufficient.
>>>
>>>
>>> Out of curiosity (see other thread on the systemd list about this), what
>>> it the current recommendation (by systemd/btrfs folks rather then Fedora
>>> defaults) for homed machine partitioning?
>>>
>>
>> I'd probably recommend Btrfs with the /home subvolume set with
>> nodatacow if you're going to use loops of LUKS backed Btrfs homedir
>> images. The individual Btrfs loops will have their own COW anyway.
>>
>> Otherwise, the Fedora defaults for Btrfs should be sufficient.
> 
> Thought I'd wait for Fedora 36 to be released with everything I need to test this setup.
> 
> Fell at the first hurdle of transferring my data in!
> 
> I transferred a subset of my data (240Gb) onto an external disk and used:
> 
>    homectl with colin -- rsync ...
> 
> 
> The transfer worked but the colin.home file grew to 394Gb. Only about 184Gb used (I presume due to compression).
> 
> Ultimately, this was then unmounted and while it said it could shrink the filesystem with a "Ready to..." message this either didn't happen or the backing file wasn't shrunk to match it. I did receive a message later


I suppose that colin.home is a sparse file, so even it has a length of 394GB, it consumes only 184GB. So to me these are valid values. It doesn't matter the length of the files. What does matter is the value returned by "du -sh".

Below I create a file with a length of 1000GB. However being a sparse file, it doesn't consume any space and "du -sh" returns 0

$ truncate -s 1000GB foo
$ du -sh foo
0	foo
$ ls -l foo
-rw-r--r-- 1 ghigo ghigo 1000000000000 May 31 19:29 foo



> 
> I'm not sure now where it's at with recovery but as nothing is strictly needed to make this work, I think I'll leave my playing with homed there for now and try again at some later date.
> 
> I love the whole idea but it's still a bit to bleeding edge and quirky for my daily driver just yet!
> 
> 
> I've attached various logs in case they are useful (will post separately if the list removes this!)
> 
> 
> Cheers
> 
> Col
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
