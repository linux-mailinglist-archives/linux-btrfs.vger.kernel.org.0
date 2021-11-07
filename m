Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C082447203
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Nov 2021 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhKGHb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Nov 2021 02:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhKGHb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Nov 2021 02:31:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E1C061570
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Nov 2021 00:28:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o18so28577131lfu.13
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Nov 2021 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EJk4IdAnwncIQY2sZmNIaf8dgnrmcOB3j2X1ApMLi0o=;
        b=QweglcI8uROrlY2XtMz14GBWxrBuamlOCcD1EZoCg4OC6Qea4RcgEVHk7VMRwe/pV6
         qF06HpN2V1/Qh6+rbyIn29OvdNktqZQ3wLGoUDByZwUmAIfX9i4iP7rnnQL1t0tu8Pm9
         emv4KwK5Nigt5Wg0HA48JrmCDYzJgk4FOXGxybzxArLByt7SgiUR03KCU/fC8O4i0xnF
         O6DCh2+MZEWyWto7H67DGFTZ4HVXDuM6QoCJGCWU7YAk6IINB7O78zzkdRIrE8m2mtT/
         1dJYpkX+KLKENm5efpJxx1Ckj7Nq4MCpTsHeKLvqFKDzbiQpPzLE/YmW0X16dpGA9bue
         iZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EJk4IdAnwncIQY2sZmNIaf8dgnrmcOB3j2X1ApMLi0o=;
        b=LTUARpJ9oZqr4Xm9MWU+exBm5lvHGmU9XG9OgpaC8DoHcYuboT6FV7537rWSkG1DtM
         p3pVSWuw7WCi9rombvVmJBqdPaLkX1AoUeIroMVDalHOmYtyaf0TE6gilOCtMY+k2SXS
         gyj7pFt80Wwsh/ktG0vH41SjTzg1kqucgHQsVI8xql3lOrJ1T1jgSnvdixRPQ5gWX58Z
         Kj0vkPwcIR06eAo8NErbEIE2y00+66CqvB1kiLmCfjtuq2pLZtlyyBFilh1VRi8egiAt
         rCvUJwfnEf4ka99h7owLX5JVpDJEPoqvCQxuURsrdzzUi7Evq9jbJxGoO28hDxqd633C
         3rtg==
X-Gm-Message-State: AOAM5316nXTLb8TWGlYQ/TOZ4s22Opc/tzDG0Rlw259/U6WbDzp1BjIp
        jQNS9Qsgg7CYg14tkkvIYSfz50LlGcA=
X-Google-Smtp-Source: ABdhPJz1e9X+Ans54LbM8BULmAq7YNpSkXzjneJCSSg5Ow9O+XdF9HHmBh+6fEYxbI/qrjaiEuILTg==
X-Received: by 2002:a05:6512:239c:: with SMTP id c28mr5330592lfv.502.1636270121375;
        Sun, 07 Nov 2021 00:28:41 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8125:b91a:ea46:b49a:9664? ([2a00:1370:812d:8125:b91a:ea46:b49a:9664])
        by smtp.gmail.com with ESMTPSA id n5sm1388011lfh.65.2021.11.07.00.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 00:28:40 -0700 (PDT)
Subject: Re: Finding long-term data corruption
To:     Alex Lieflander <atlief@icloud.com>, linux-btrfs@vger.kernel.org
References: <C85EE7D2-FC47-4A0E-B7A8-9285CF46C3FC@icloud.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <b341cf51-f747-71b9-e762-89bf6dbb7be2@gmail.com>
Date:   Sun, 7 Nov 2021 10:28:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <C85EE7D2-FC47-4A0E-B7A8-9285CF46C3FC@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.11.2021 20:24, Alex Lieflander wrote:
> Hello,
> 
> All of my files and data were exposed to an unknown amount of corruption, and I’d like to know how much I can recover and/or whether I can detect the extent of the damage. The steps that led me here are a bit complicated but (I think) relevant to the problem, so I’ve detailed them below.
> 
> I use BTRFS for most of my filesystems, and my system recently died. While investigating the issue, I found out that corruption had been detected months earlier (after an unclean shutdown) on one of them. Corruption was detected on another a few weeks later for unknown reasons. The number of detected corruptions continued to grow to about 160 and 30, respectively, before things began to noticeably malfunction.
> 
> During this time I’d been `btrfs sub snap -r`-ing and `btrfs send -p`-ing both to the third BTRFS filesystem as a backup method, with no errors except some warnings about the “capabilities” of particular files being “set multiple times". I reformatted my backup drive a few weeks ago for unrelated reasons (after corruption was detected, unbeknownst to me). Since then I continued to regularly “backup” in this way.
> 
> Once I noticed the corruption (that `btrfs scrub` couldn’t fix) I tried increasingly aggressive actions until both original filesystems were destroyed and unrecoverable. After that I reformatted and “sent” the corresponding sub-volumes back to their original drives (with the newly reformatted filesystems). Now scrub detects no errors on any of the filesystems, but btrfs-send can’t incrementally send on one of the filesystems. The parent I’m using is the one that I sent from the backup drive. On closer inspection, the received sub-volume has a few subtle permission changes from the sent one. These sub-volumes have always been read-only and I don’t think I ever modified them.
> 

That most likely is the result of stale received UUID on the source side.

https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com/

> With the situation now described, I have a few questions that I’m hoping to find the answer to:
> 
> 1. Can corrupt data propagate through sent sub-volumes?
> 

You did not really explain what kind of corruption it was or how you
detected it in the first place. If you are talking about corruption
detected by scrub - it should not, as btrfs should have either used good
copy (in case of redundant profile) or failed btrfs send (if data was
unreadable).

> 2. Can this corruption damage earlier, intact, sub-volumes?
> 

Again - what corruption? Physical media errors may happen anywhere.
RAID5 or RAID6 profiles errors may affect non-related data under some
conditions.

> 3. Does sub-volume sending include the checksums? Would a clean scrub report on the receiving filesystem be an actual indication of uncorrupted data?

As far as I know send stream does not include any checksums. btrfs
receive is logical, it creates/writes files from user space so scrub
results on receive side have no relation to content or state of
filesystem on send side.

> 
> 4. Is there a way that I could detect what data/files are currently corrupted? How so?
> 

For the third time - explain what kind of corruption you are talking
about. If corruption cannot be detected by btrfs, you need to use
data/application specific methods to verify data integrity.

> 5. What might cause a sent sub-volume (with no parent) to differ between two filesystems? Is that a sign of corruption?
> 

You need to show much more details before this can be answered. Full
send is expected to have the same content. If you have evidences that
this is not the case, provide logs/commands output/any facts that show
how you determine that, starting with actual send/receive invocations
you were using.

> 6. Is using sub-volumes in the way that I described appropriate for use as a backup solution?
> 

You did not really describe much. If you refer to

"I’d been `btrfs sub snap -r`-ing and `btrfs send -p`-ing both to the
third BTRFS filesystem as a backup method"

yes, it is. Do not forget received UUID pitfall and never ever (and I
mean really *EVER*) change any subvolume from being read-only to
read-write as part of restore from backup. Always create a clone
(writable subvolume) of read-only snapshot and use it as recovered content.


> Thank you for your work on this interesting and extremely useful filesystem, and for reading this far!
> 
> Regards,
> Alex Lieflander
> 

