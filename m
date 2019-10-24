Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C09E309D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 13:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439065AbfJXLlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 07:41:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34168 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439057AbfJXLk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 07:40:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so17579770qto.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vi/ac9kVFMRQogmQuVZcBh/2XUqfjL308vDg9On+bGQ=;
        b=ZLEWCMQkzEPwrkgMM0ENem+pEbSvrA33mauyoDxzski9gEfkLpBNa/xTuLoCbEje+X
         BkNWeDj2QXngOumkv+waNPVS1qDOnp+YkCaYzMJH+uUuMn439GbtvLrMZIsk1FQfFYb4
         62C2wdnJsZouvV+u5gbiSPFS3Z/gWbkrZtckwwAeLCyTOwBaXYnpy7J2UGlNkHI++XBN
         drzhpGhLQ7tInuaGFMKhfMIjorsOprP+4uGLDf9QcyhP6vxmBuMLP8a3jL1nIgTQmW+6
         aX6z5d6Fl3XDySKWkFV+USJdxNJ66QpV098BrWlwZoV+ckSQDPnHbN1I1NddLXxi1hr+
         frUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vi/ac9kVFMRQogmQuVZcBh/2XUqfjL308vDg9On+bGQ=;
        b=gNE9UtsQ7CO5fdgG5JUGqD6ZzKniLzhDLg1KFfOaKK12hQmwcgZLy4LT9Xi5VEnmN2
         5kFlSLTool7BP7HU+qNFlVEcy9ZHq8TvP8r+8fotr9BxYAD4YjoxfsJe5kN5ILrF6jZU
         1aUCrqsV+FAaR2KNka1h9SRHgYaGVdp21QxaNG2rTmE9KZLv5VziKFX6nQf8m3xmDJEK
         mtItHFwCCSk5X6FgN5K8WlSwaPQVDGve8hwEL1ehpvr8WhUxRMaMnKYetd5RHA8z7P3B
         +MWmChLTrC9Cu5WY/fAmYVd6M+2p61bbXyL5KOejxIVAxmBaMeLNBdTn74v5HylpPhmE
         Giqw==
X-Gm-Message-State: APjAAAVZpt9b+G7leJFyV8ntMnBDlyxEc3C80ZlTcNt+W7TOTOt6bJnD
        DEOijMtGOmMSkus/6zmKwHk8VwvZssg=
X-Google-Smtp-Source: APXvYqzZ2heZ1GkbPXG2wCyinVFWigv7WfThNWiNPC8t55aOQ0TEr5KLV6C2A2GzaZkva1YZYUkDzQ==
X-Received: by 2002:ad4:5345:: with SMTP id v5mr14119249qvs.217.1571917257513;
        Thu, 24 Oct 2019 04:40:57 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id j2sm2240915qth.46.2019.10.24.04.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 04:40:56 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
Date:   Thu, 24 Oct 2019 07:40:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-24 06:41, Christian Pernegger wrote:
> I must admit, this discussion is going (technical) places I don't know
> anything about, and much as I enjoy learning things, I'd rather not
> waste your time (go make btrfs better! :-p). When all is said and done
> I'm just a user. I still don't understand how (barring creatively
> defective hardware, which is of course always in the cards) a crash
> that looked comparatively benign could lead to an fs that's not only
> unmountable but unfixable; how metadata that's effectively a single
> point of failure could not have backup copies designed in that are
> neither stale nor left to the elements, seems awfully fragile -- but I
> can accept it. Repair is out.
> 
> Recovery it is, then. I'd like to try and build this rescue branch of
> yours. Does it have to be the whole thing, or can btrfs alone be built
> against the headers of the distro kernel somehow, or can the distro
> kernel source be patched with the rescue stuff? Git wasn't a thing the
> last time I played with kernels, a shove in the right direction would
> be appreciated.
Trying to build the module by itself against your existing kernel is 
likely to not work, it's technically possible, but you really need to 
know what you're doing for it to have any chance of working.

Your best option is probably to just pull down a copy of the repository 
and build that as-is.  Most distros don't strictly depend on any 
specific kernel patches, and I'm fairly certain that Mint isn't doing 
anything weird here, so unless you need specific third-party kernel 
modules, you shouldn't have any issues.
> 
> Relapse prevention. "Update everything and pray it's either been fixed
> or at least isn't triggered any more" isn't all to
> confidence-inspiring. Desktop computers running remotely current
> software will crash from time to time, after all, if not amdgpu then
> something else. At which point we're back at "a crash shouldn't have
> caused this". If excerpts from the damaged image are any help in
> finding the actual issue, I can keep it around for a while.
> 
> Disaster recovery. What do people use to quickly get back up and
> running from bare metal that integrates well with btrfs (and is
> suitable just for a handful of machines)?
Backups, flavor of your choice.  I used to use AMANDA, but have recently 
become a fan of borgbackup (other than it's lack of parallelization 
support, it's way more efficient than most other options I've tried, and 
it's dead simple to set up). I store enough extra info in the backup to 
be able to rebuild the storage stack by hand from a rescue environment 
(I usually use SystemRescueCD, but any live environment where you can 
get your backup software working and rebuild your storage stack will work).

The trick here is not to ask 'what integrates well with BTRFS', but 
instead 'what doesn't care at all what filesystem I'm running on', and 
then find something that works for you to replicate whatever special 
layout requirements you have.
