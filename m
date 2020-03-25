Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA92192AD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCYOMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 10:12:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39657 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgCYOMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 10:12:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so2630813qkf.6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ufFDVApvPozJ2DYBmgGmyIERXzoy2lTnPGVk1DO5tmE=;
        b=yJr98lsFerVwrqbW5ivpfxEJWppGpheyhj/Mp1+0oC5dfvEFqTamkJwzfL67Na4Yl4
         aIOizEUy4BA8XgurLQqkFfkxg6nv15o3WuOUnRfaTASU886LOuaDOu7E1WfItiH//Icf
         Fbymkhxis1G31uPTCSmySodauGN9KuP7LMrupadMQOx2GV/bBaVtLgU+kZMTlXceplDH
         v2pZrgOxFhiQzfAg5tD3nXccPwtwK1m22LX333P3zow1eHvwHA/BbOxxrrIscppLFUbO
         uWELx00uiwj4M5qGhHW4mDKFRbMCPWmiWKQemqQFNBlb7+bbZ7Kyba66k+9ihdtIjcsV
         9Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ufFDVApvPozJ2DYBmgGmyIERXzoy2lTnPGVk1DO5tmE=;
        b=uUXVv8oU/ap7AROf7npP4I2bjSDNl2zr6Bb0HXcZDl/nWq2/B8EIDzAK/f1s4pJ7WO
         861bbeWc6K/VeNBKpvTjQj/oOi0q0JDhI4w3Fi5wK9wVdEcgLY4jgLk9Q/1enwTtlzlK
         5pRhuyrutNbJCYRTlJErlHdjTvsd2UJ4WbJu26p/23/dwkzHWINC1p+Ue2LRWl9zEI2E
         gAEWHnI9Q3n6w7LdeFQR1OGIm1uD5M2QDFPvERWtCKo9kqzQjrB8zqLTkG/kVrPj6sol
         Q7vIsWrFdUcLUbMFhg0fB/4zomoFCW/LMDeoZMxbHpiZH1qP7m1IwY3nsrfPFIGqibYX
         KC2A==
X-Gm-Message-State: ANhLgQ3SC6aw50tO9IAmXru2MUjVBwmiQ1Np+TPFLUN4dvBObHCoRd4+
        CRJiCXuiIY+BNmsaT4ISo1Z3Rw==
X-Google-Smtp-Source: ADFU+vvzWUM4e1dX6mVLkGynYiKJUWCxFqiRfNzcJZ+OD5pZnLbrS0M4qlfJjyctldXKt0IOyDjMqQ==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr3129624qkf.105.1585145553137;
        Wed, 25 Mar 2020 07:12:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::d6b3])
        by smtp.gmail.com with ESMTPSA id c191sm15097985qkg.49.2020.03.25.07.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:12:32 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix up some stupid delayed ref flushing behaviors
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313211220.148772-1-josef@toxicpanda.com>
 <20200325135146.GA5920@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e28e8818-bd8e-707f-c749-d00f7a5c913a@toxicpanda.com>
Date:   Wed, 25 Mar 2020 10:12:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325135146.GA5920@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/25/20 9:51 AM, David Sterba wrote:
> On Fri, Mar 13, 2020 at 05:12:15PM -0400, Josef Bacik wrote:
>> While debugging Zygo's delayed ref problems it was clear there were a bunch of
>> cases that we're running delayed refs when we don't need to be, and they result
>> in a lot of weird latencies.
>>
>> Each patch has their individual explanations.  But the gist of it is we run
>> delayed refs in a lot of arbitrary ways that have just accumulated throughout
>> the years, so clean up all of these so we can have more consistent performance.
> 
> It would be fine to remove the delayed refs being run from so many
> places but I vaguely remember some patches adding them with "we have to
> run delayed refs here or we will miss something and that would be a
> corruption". The changelogs in patches from 3 on don't point out any
> specific problems and I miss some reasoning about correctness, ideally
> for each line of btrfs_run_delayed_refs removed.
> 
> As a worst case I really don't want to get to a situation where we start
> getting reports that something broke because of the missing delayed
> refs, followed by series of "oh yeah I forgot we need it here, add it
> back".

Yeah I went through and checked each of these spots to see why we had them.  A 
lot of it had to do with how poorly delayed refs were run previously.  You could 
end up with weird ordering cases and missing our flags.

These problems are all gone now, we no longer have to run delayed refs to work 
around ordering weirdness because I fixed all of those problems.  Now these are 
just old relics of the past that need to die.  The only case where I didn't 
touch them is for qgroups, likely because it still matters for the before/after 
lookups there.

But everywhere else it was working around some deficiency in how we ran delayed 
refs, either in the ordering issues or space related.  Both those problems no 
longer exist, so we can drop these workarounds.

> 
> The branch with this patchset is in for-next but I'm still not
> comfortable with adding it to misc-next as I can't convince myself it's
> safe, so more reviews are welcome.
> 

Yeah I'm targeting the merge window after the upcoming one with these, there's 
still a lot more testing I want to get done.  I mostly threw them up because 
they were no longer blowing up constantly for Zygo, and I wanted Filipe to get 
an early look at them.  Thanks,

Josef
