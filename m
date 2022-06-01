Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0053A0A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351266AbiFAJg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351254AbiFAJgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 05:36:25 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A658FFA6
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 02:36:22 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1nwKm4-000258-0R
        for linux-btrfs@vger.kernel.org; Wed, 01 Jun 2022 11:36:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Date:   Wed, 1 Jun 2022 10:36:11 +0100
Message-ID: <t77bub$vp5$1@ciao.gmane.io>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
 <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
 <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
 <CAEg-Je9rr4Y7JQbD3iO1UqMy48j7feAXFFeaqpJc6eP7FSduEw@mail.gmail.com>
 <t752jd$pjm$1@ciao.gmane.io> <24613105-faa7-8b0d-5d55-53d01a7c1172@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
In-Reply-To: <24613105-faa7-8b0d-5d55-53d01a7c1172@libero.it>
Cc:     systemd-devel@lists.freedesktop.org
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote on 31/05/2022 19:12:
> On 31/05/2022 14.44, Colin Guthrie wrote:
>> Hi,
>>
>> Neal Gompa wrote on 01/02/2022 19:55:
>>> On Tue, Feb 1, 2022 at 2:02 PM Colin Guthrie <colin@booksterhq.com> 
>>> wrote:
>>>>
>>>> Goffredo Baroncelli wrote on 30/01/2022 09:27:
>>>>> On 29/01/2022 19.01, Chris Murphy wrote:
>>>>>> On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli
>>>>>> <kreijack@libero.it> wrote:
>>>>>>>
>>>>>>> I think that for the systemd uses cases (singled device FS), a 
>>>>>>> simpler
>>>>>>> approach would be:
>>>>>>>
>>>>>>>        fstatfs(fd, &sfs)
>>>>>>>        needed = sfs.f_blocks - sfs.f_bavail;
>>>>>>>        needed *= sfs.f_bsize
>>>>>>>
>>>>>>>        needed = roundup_64(needed, 3*(1024*1024*1024))
>>>>>>>
>>>>>>> Comparing the original systemd-homed code, I made the following 
>>>>>>> changes
>>>>>>> - 1) f_bfree is replaced by f_bavail (which seem to be more
>>>>>>> consistent to the disk usage; to me it seems to consider also the
>>>>>>> metadata chunk allocation)
>>>>>>> - 2) the needing value is rounded up of 3GB in order to consider a
>>>>>>> further 1 data chunk and 2 metadata chunk (DUP))
>>>>>>>
>>>>>>> Comments ?
>>>>>>
>>>>>> I'm still wondering if such a significant shrink is even 
>>>>>> indicated, in
>>>>>> lieu of trim. Isn't it sufficient to just trim on logout, thus
>>>>>> returning unused blocks to the underlying filesystem?
>>>>>
>>>>> I agree with you. In Fedora 35, and the default is ext4+luks+trim
>>>>> which provides the same results. However I remember that in the 
>>>>> past the
>>>>> default
>>>>> was btrfs+luks+shrunk. I think that something is changed i.
>>>>>
>>>>> However, I want to provide do the systemd folks a suggestion ho change
>>>>> the code.
>>>>> Even a warning like: "it doesn't work that because this, please 
>>>>> drop it"
>>>>> would be sufficient.
>>>>
>>>>
>>>> Out of curiosity (see other thread on the systemd list about this), 
>>>> what
>>>> it the current recommendation (by systemd/btrfs folks rather then 
>>>> Fedora
>>>> defaults) for homed machine partitioning?
>>>>
>>>
>>> I'd probably recommend Btrfs with the /home subvolume set with
>>> nodatacow if you're going to use loops of LUKS backed Btrfs homedir
>>> images. The individual Btrfs loops will have their own COW anyway.
>>>
>>> Otherwise, the Fedora defaults for Btrfs should be sufficient.
>>
>> Thought I'd wait for Fedora 36 to be released with everything I need 
>> to test this setup.
>>
>> Fell at the first hurdle of transferring my data in!
>>
>> I transferred a subset of my data (240Gb) onto an external disk and used:
>>
>>    homectl with colin -- rsync ...
>>
>>
>> The transfer worked but the colin.home file grew to 394Gb. Only about 
>> 184Gb used (I presume due to compression).
>>
>> Ultimately, this was then unmounted and while it said it could shrink 
>> the filesystem with a "Ready to..." message this either didn't happen 
>> or the backing file wasn't shrunk to match it. I did receive a message 
>> later
> 
> 
> I suppose that colin.home is a sparse file, so even it has a length of 
> 394GB, it consumes only 184GB. So to me these are valid values. It 
> doesn't matter the length of the files. What does matter is the value 
> returned by "du -sh".
> 
> Below I create a file with a length of 1000GB. However being a sparse 
> file, it doesn't consume any space and "du -sh" returns 0
> 
> $ truncate -s 1000GB foo
> $ du -sh foo
> 0    foo
> $ ls -l foo
> -rw-r--r-- 1 ghigo ghigo 1000000000000 May 31 19:29 foo

Yeah the file will be sparse.

That's not really an issue, I'm not worried about the fact it's not 
consuming as much as it reports as that's all expected.

The issue is that systemd-homed (or btrfs's fallocate) can't handle this 
situation and that user is effectively bricked unless migrated to a host 
with more storage space!

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited http://www.tribalogic.net/
Open Source:
   Mageia Contributor http://www.mageia.org/
   PulseAudio Hacker http://www.pulseaudio.org/
   Trac Hacker http://trac.edgewall.org/

