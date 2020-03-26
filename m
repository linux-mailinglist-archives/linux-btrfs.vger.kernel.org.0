Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B1194813
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 20:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCZT65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 15:58:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36026 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgCZT65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 15:58:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id d11so8285686qko.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdSqxekhkGVFiq5ENiJViku0KP98PSI8s9w6s0Xaw5Y=;
        b=yU14cBiDah9VsJn5qs/HHHvOtApW0Nt8gjdj8cP+/d3CD/mb4A+O8FkOlnPADeX3dv
         vaGEnyHa4yMyJ6Lbud7AXT2jUGAg+/pf4EXF6TbyZx9CjLss02O15RCXwl6jMARhsby7
         46F3jVpff9bV26d/nJb4/70wWYTjqeuRS/Lh4IQRf6410NhuFeBm0Q4ZaAqam6ruKbbu
         HEp0139VkYxpdjR5rSZI8Yzn0cp33r8axoBfl/ASJNoB8RZ8UvAIMR+d9Ay4yqEawb6P
         hQoKZD36kwFIqlskaggnkcYHw7zJzBXAXzIOCFtm1d0TBur8zBJeu4mzXQMVOzsIYZc2
         w1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdSqxekhkGVFiq5ENiJViku0KP98PSI8s9w6s0Xaw5Y=;
        b=mMJBEFBrIoTvDQbPRlNfO71UP4KyQKhBwSxMjRv8ETrtcnUGsEZ/wsMg2s1ObX4z5o
         hgP+W+KhUBThlMNp75bhBTMivyQ7WqCjI3IeKYrfP8bRFSXlXmnghBzHQdU6T2K4w11n
         WvVtlStc63pdrcfbRWEWT9e9WzFFOiUk+0jEZVOey2VxiwY68/wtbMQiokRdjDyM62gQ
         776s9hEYapZ3F5J0owJ8JAjIuLI7GncTa42Sg4aC8aXfvncPtCAbhXCjMug0gsAoIC6F
         tEWL4Kagkz3K5R+POg+qIV8miazqXTiWzrztLNoTsoI5UdmWrrhTbrfG8qCb5EmJKKiM
         zMCg==
X-Gm-Message-State: ANhLgQ05NB8o3/NVWc6SxHOk0KTk2G4REUHcQ8ukYo55mhRdZlTzNOwi
        3vo9MGedl1xDgnRqvqlAtBIZyJAM/BHsYw==
X-Google-Smtp-Source: ADFU+vsPm4NcXk/caQB7DcUwikI+tMiWXLVkdc7aJVn+DtzmkDoGFZ6ThLHDsoep9gZrsd+85hgc6Q==
X-Received: by 2002:a37:95c6:: with SMTP id x189mr9860802qkd.19.1585252734343;
        Thu, 26 Mar 2020 12:58:54 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m67sm2043363qke.101.2020.03.26.12.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 12:58:53 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix up some stupid delayed ref flushing behaviors
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200313211220.148772-1-josef@toxicpanda.com>
 <20200325135146.GA5920@twin.jikos.cz>
 <e28e8818-bd8e-707f-c749-d00f7a5c913a@toxicpanda.com>
 <20200326153603.GY13306@hungrycats.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2f15a973-1f2e-33fa-aefd-93a1f7dce683@toxicpanda.com>
Date:   Thu, 26 Mar 2020 15:58:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326153603.GY13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/20 11:36 AM, Zygo Blaxell wrote:
> On Wed, Mar 25, 2020 at 10:12:30AM -0400, Josef Bacik wrote:
>> On 3/25/20 9:51 AM, David Sterba wrote:
>>> On Fri, Mar 13, 2020 at 05:12:15PM -0400, Josef Bacik wrote:
>>>> While debugging Zygo's delayed ref problems it was clear there were a bunch of
>>>> cases that we're running delayed refs when we don't need to be, and they result
>>>> in a lot of weird latencies.
>>>>
>>>> Each patch has their individual explanations.  But the gist of it is we run
>>>> delayed refs in a lot of arbitrary ways that have just accumulated throughout
>>>> the years, so clean up all of these so we can have more consistent performance.
>>>
>>> It would be fine to remove the delayed refs being run from so many
>>> places but I vaguely remember some patches adding them with "we have to
>>> run delayed refs here or we will miss something and that would be a
>>> corruption". The changelogs in patches from 3 on don't point out any
>>> specific problems and I miss some reasoning about correctness, ideally
>>> for each line of btrfs_run_delayed_refs removed.
>>>
>>> As a worst case I really don't want to get to a situation where we start
>>> getting reports that something broke because of the missing delayed
>>> refs, followed by series of "oh yeah I forgot we need it here, add it
>>> back".
>>
>> Yeah I went through and checked each of these spots to see why we had them.
>> A lot of it had to do with how poorly delayed refs were run previously.  You
>> could end up with weird ordering cases and missing our flags.
>>
>> These problems are all gone now, we no longer have to run delayed refs to
>> work around ordering weirdness because I fixed all of those problems.  Now
>> these are just old relics of the past that need to die.  The only case where
>> I didn't touch them is for qgroups, likely because it still matters for the
>> before/after lookups there.
>>
>> But everywhere else it was working around some deficiency in how we ran
>> delayed refs, either in the ordering issues or space related.  Both those
>> problems no longer exist, so we can drop these workarounds.
>>
>>>
>>> The branch with this patchset is in for-next but I'm still not
>>> comfortable with adding it to misc-next as I can't convince myself it's
>>> safe, so more reviews are welcome.
>>>
>>
>> Yeah I'm targeting the merge window after the upcoming one with these,
>> there's still a lot more testing I want to get done.  I mostly threw them up
>> because they were no longer blowing up constantly for Zygo, and I wanted
>> Filipe to get an early look at them.  Thanks,
> 
> No longer blowing up _constantly_, but there was definitely a 2-3 day
> cadence between blowups last time I rebased.  Test runs were ending in
> splats due to KASAN UAF bugs and bad unlock balances.  It doesn't seem
> to be corrupting on-disk metadata, but my test VMs can't get anywhere
> close to a week uptime under the full stress load yet.
> 
> I'd like to keep a test VM pointed at this as it makes it way upstream.
> It's an important set of changes, but it has a high regression risk.
> There are some big changes here, and that's going to expose all the gaps
> in developers' knowledge of how stuff really works.
> 
> Do I just keep rebasing on for-next-<date>?
> 

I think so, I'm not sure what Dave has merged so far.  My own long term tests 
have uncovered a few bugs that I've been busy running down.  Once my long term 
tests no longer fall over I'm going to rebase everything onto the most recent 
devel branch and we can go from there.  Hopefully I'll have this last corner run 
down by tomorrow or early next week.  Thanks,

Josef
