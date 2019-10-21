Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CCDEEA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfJUOCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 10:02:25 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:43002 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUOCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 10:02:25 -0400
Received: by mail-yw1-f53.google.com with SMTP id b7so1386041ywc.9
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FIutT0BhzY9EfEuaC7vGx3v+WQmDljBUgsnAgRmkv14=;
        b=LKBhXa1NhJJ2/4xdHunKR0erZfuPE0Zqr/++xifSdzv96PI7/oM4i0AYUJ+1MZhbUy
         s47sOjtr7/+x2Wwov+UbIXzWIZrmpZdLRr/1b1VjjT+GI9hLeofroJPoflz+a0AyE9xa
         WGOyHWB5U5y/huAUKnBQSQXbWbxIQLiHSwnk3Y8fFJ9xoe6qtFshqCSZS1LfL8dQUtoP
         dM5qJnrELawkJ26DApQQiJETqY1SlLvhrxFlMj+U+iPdKAb4ulHp6T+wEMO0+fIETa9r
         FZYcs4xLt+/3iWKttBCjXJrpTRLn7GYegIoj9mzBIsnNaxZpiehGKuDiiOJ350euG52P
         2IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FIutT0BhzY9EfEuaC7vGx3v+WQmDljBUgsnAgRmkv14=;
        b=esRr7OJrXLB3gBkH0JJhvQHZ+gEGJy9sDea1QDhFLPfMb87d7wbJPzPKLD97yK88Ug
         yakOm958W3MHd1GvHv9fykBEBsuVrGu1kw/qhrLFstaMqBdlm+R0TTWNfPnlz9HK1Asn
         xUzacZO3lN7cHpaVLWt5/N6L7dkBBUUasCkiZNB69igpK+KEVf5CG2AVhl3V+1JfDZ2Y
         7hfXcU7ZBXYWg+O4tQDr8sfI21d2V8pt2E4UIWb8WWevJzi85C3futNVaanBAzZDcFfN
         qN2t06qa7yxJrq6jQgF/tdDPGe2PYM260B9R+jlytbS94ERUEQCrQZp1DUKAzmQYrO0T
         osIg==
X-Gm-Message-State: APjAAAW8HygxGSoGoBF7b5RKHQWhRXnvOdHx71QWt4gT3CadD4P0BcDU
        oqcYFZ/5mLfdIKZqPFu3TZcUfHacX7U=
X-Google-Smtp-Source: APXvYqwV2wRQRQeIUvTDOyOiBq+31FLqWcM/P9djaxB3ksgBoIHJrakcNdISTU3YKdX2iFcfpl8ebw==
X-Received: by 2002:a81:7989:: with SMTP id u131mr17095710ywc.335.1571666542770;
        Mon, 21 Oct 2019 07:02:22 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id y205sm3506754ywc.6.2019.10.21.07.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:02:22 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <db934877-4168-81b4-689a-7de1fc34cace@gmail.com>
Date:   Mon, 21 Oct 2019 10:02:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-21 09:02, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
> 
> Am Mo., 21. Okt. 2019 um 13:47 Uhr schrieb Austin S. Hemmelgarn
> <ahferroin7@gmail.com>:
>> I've [worked with fs clones] like this dozens of times on single-device volumes with exactly zero issues.
> 
> Thank you, I have taken precautions, but it does seem to work fine.
> 
>> There are actually two possible ways I can think of a buggy GPU driver causing this type of issue: [snip]
> 
> Interesting and plausible, but ...
> 
>> Your best option for mitigation [...] is to ensure that your hardware has an IOMMU [...] and ensure it's enabled in firmware.
> 
> It has and it is. (The machine's been specced so GPU pass-through is
> an option, should it be required. I haven't gotten around to setting
> that up yet, haven't even gotten a second GPU, but I have laid the
> groundwork, the IOMMU is enabled and, as far as one can tell from logs
> and such, working.)
> 
>> However, there's also the possibility that you may have hardware issues.
> 
> Don't I know it ... The problem is, if there are hardware issues,
> that's the first I've seen of them, and while I didn't run torture
> tests, there was quite a lot of benchmarking when it was new. Needle
> in a haystack. Some memory testing can't hurt, I suppose. Any other
> ideas (for hardware testing)?
The power supply would be the other big one I'd suggest testing, as a 
bad PSU can cause all kinds of odd intermittent issues. Just like with 
RAM, you can't really easily cover everything, but you can check some 
things that have very low false negative rates when indicating problems.

Typical procedure I use is:

1. Completely disconnect the PSU from _everything_ inside the computer. 
(If you're really paranoid, you can completely remove the PSU from the 
case too, though that won't really make the testing more reliable or safer).
2. Make sure the PSU itself is plugged in to mains power, with the 
switch on the back (if it has one) turned on.
3. Connect a good multimeter to the 24-pin main power connector, with 
the positive probe on pin 8 and the negative probe on pin 7, set to 
measure DC voltages in the double-digit range with the highest precision 
possible.
4. Short pins 15 and 16 of the 24-pin main power connector using a short 
piece of solid copper wire. At this point, if the PSU has a fan, the fan 
should turn on. The multimeter should read +5 volts within half a second 
or less.
5. Check voltages of each of the power rails relative to ground. Make 
sure and check each one for a couple of seconds to watch for any 
fluctuations, and make a point to check _each_ set of wires coming off 
of the PSU separately (as well as checking each wire in each connector 
independently, even if they're supposed to be tied together internally).
6. Check the =5V standby power by hooking up the multimeter to that and 
a ground pin, then disconnecting the copper wire mentioned in step 3. 
It should maintain it's voltage while you're disconnecting the wire and 
afterwards, even once the fan stops.

You can find the respective pinouts online in many places (for example, 
[1]).  Tolerances are +/- 5% on everything except the negative voltages 
which are +/- 10%. The -5V pin may show nothing, which is normal (modern 
systems do not use -5V for anything, and actually most don't use -12V 
anymore either, though that's still provided). This won't confirm that 
the PSU isn't suspect (it could still have issues under load), but if 
any of this testing fails, you can be 100% certain you have either a bad 
PSU, or that your mains power is suspect (usually the issue there is 
very high line noise, though you'll need special equipment to test for 
that).
> 
> Back on the topic of TRIM: I'm 99 % certain discard wasn't set on the
> mount (not by me, in any case), but I think Mint runs fstrim
> periodically by default. Just to be sure, should any form of TRIM be
> disabled?
The issue with TRIM is that it drops old copies of the on-disk data 
structures used by BTRFS, which can make recovery more difficult in the 
event of a crash. Running `fstrim` at regular intervals is not as much 
of an issue as inline discard, but still drops the old trees, so there's 
a window of time right after it gets run when you are more vulnerable.

Additionally, some SSD's have had issues with TRIM causing data 
corruption elsewhere on the disk, but it's been years since I've seen a 
report of such issues, and I don't think a Samsung device as recent as 
yours is likely to have such problems.

> The only other idea I've got is Timeshift's hourly snapshots. (How)
> would btrfs deal with a crash during snapshot creation?
It should have no issues whatsoever most of the time.  The only case I 
can think of where it might is if you're snapshotting a subvolume that's 
being written to at the same time. Snapshots on BTRFS are only truly 
atomic if none of the data being snapshotted is being written to at the 
same time. If there are pending writes, there are some indeterminate 
states involved, and crashing then might produce a corrupted snapshot, 
but shouldn't cause any other issues.
> 
> 
> In other news, I've still not quite given up, mainly because the fs
> doesn't look all that broken. The output of btrfs inspect-internal
> dump-tree (incl. options), for instance, looks like gibberish to me of
> course, but it looks sane, doesn't spew warnings, doesn't error out or
> crash. Also plain btrfs check --init-extent-tree errored out, same
> with -s0, but with -s1 it's now chugging along. (BTW, is there a
> hierarchy among the super block slots, a best or newest one?)
AIUI, when they get updated, they get written out in the order they 
occur on disk, but other than that they're supposed to always be 
in-sync.  So if you have an issue when the first is being written out, 
you can often recover by using the second or later ones.
> 
> Will keep you posted.
> 
> Cheers,
> C.
> 

