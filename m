Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04818FFD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 21:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCWUuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 16:50:07 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:50263 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgCWUuH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 16:50:07 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id GU1Lj7pKMa1lLGU1LjA4qb; Mon, 23 Mar 2020 21:50:04 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584996604; bh=QYzU276UbtwqNWwqSapAxtv4QJ0RYFrzYoWvqzpF5Cc=;
        h=From;
        b=ZMZT7TxeBA/CmYsUwebMsh0NhRbqkC/tdtnpXdKo/T1R0hImE8NXCQIYzA9/WAIDd
         vrTN4CDZW/JMsVloN+1NF+eBhbdkNfyqBKJ04+pyCRrJp1+Se7yRF7xQptkvi5ygaU
         YpuH3gVk4DRj9fMf7UhOreXP0t7ymjPhTBFbdK2D3r1MAZv7Ls1h0r0SUQsngmOeyL
         Vj+pYEFTmu7POz3KibpQ5yUpxVBKZtrNYsy3m34IT3EBlpl9wk+fFbUeWjIxRmkafZ
         1aojEtOvzI2smsCC2NxpLQ6h/ZV+e4/X+HYOkIQugheWbWZvYovio86+Uo/pocGPTu
         8HXAN/aROuErw==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=mMVPoZRFA2XhHMHFfKQA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
Date:   Mon, 23 Mar 2020 21:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200322234934.GE2693@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHUJmxi9tan2bm6IP60MkeRCY8e9poVesXLCZOW2r0uHG99/3HGUMzcnL9X4l/bOhTiEmwJXEFNEAK+H21JZq+4p/H7TSoxUn3Cl6HYfNnNjcp/Iq0Ki
 4gdYzMhZL3pEa/762t4mBLvz66762Yf3LY2NYGuFaMv4ZcV2AAsOyxeqWBukLfQC7VoDZ8KRAuhHieiFLSqCKLAGy3lIgKXSMWgx8G4frdEktyVH/iW75+o9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/20 12:49 AM, Zygo Blaxell wrote:
> On Sun, Mar 22, 2020 at 09:38:30AM +0100, Goffredo Baroncelli wrote:
>> On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:
>>
>>>
>>> To me it seems complicated to
>> [sorry I push the send button too early]
>>
>> To me it seems too complicated (and error prone) to derive the target profile from an analysis of the filesystem.
>>
>> Any thoughts ?
> 
> I still don't understand the use case you are trying to support.
> 
> There are 3 states for a btrfs filesystem:
> 
[...]
> 
> 	3.  A conversion is interrupted prior to completion.  Sysadmin is
> 	expected to proceed immediately back to state #2, possibly after
> 	taking any necessary recovery actions that triggered entry into
> 	state #3.  It doesn't really matter what the current allocation
> 	profile is, since it is likely to change before we allocate
> 	any more block groups.
> 
> You seem to be trying to sustain or support a filesystem in state #3 for
> a prolonged period of time.  Why would we do that?  If your use case is
> providing information or guidance to a user, tell them how to get back
> to state #2 ASAP, so that they can then return to state #1 where they
> should be.

Believe me: I *don't want* to sustain #3 at all; btrfs is already too
complex. Supporting multiple profile is the worst thing that we can do.
However #3 exists and it could cause unexpected results. I think that on
this we agree.
> 
[...]

> There could be a warning message in dmesg if we enter state #3.
> This message would appear after a converting balance is cancelled or
> aborted, and on mount when we scan block groups (which we would still need
> to do even after we added a "target profile" field to the superblock).
> Userspace like 'btrfs fi df' could also put out a warning like "multiple
> allocation profiles detected, but conversion is not in progress.  Please
> finish conversion at your earliest convenience to avoid disappointment."
> I don't see the need to do anything more about it.

It would help that every btrfs command should warn the users about an
"un-wanted" state like this.

> 
> We only get to state #3 if the automation has already failed, or has
> been explicitly cancelled at sysadmin request.  
>
Not only, you can enter in state #3 if you do something like:

$ sudo btrfs balance start -dconvert=single,usage=50 t/.

where you convert some chunk but not other.

This is the point: we can consider the "failed automation" an unexpected
event, however doing "btrfs bal stop" or the command above cannot be
considered as unexpected event.

[...]

> I'd even consider removing the heuristics that are already there for
> prioritizing profiles.  They are just surprising and undocumented
> behavior, and it would be better to document it as "random, BTW you
> should finish your conversion now."

I agree that we should remove this kind of heuristic.
Doing so I think that, with moderate effort, btrfs can track what is the
wanted profile (i.e. the one at the mkfs time or the one specified in last balance
w/convert [*]) and uses it. To me it seems the natural thing to do. Noting more
nothing less.
We can't prevent a mixed profile filesystem (it has to be allowed the
possibility to stop a long activity like the balance), but we should
prevent the unexpected behavior: if we change the profile and something
goes wrong, the next chunk allocation should be clear. The user don't have
to read the code to understand what will happen.
  [*] we can argue which would be the expected profile after an interrupted balance:
the former one or the latter one ?


BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
