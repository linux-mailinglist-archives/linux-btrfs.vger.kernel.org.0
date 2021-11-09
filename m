Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A044AEB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhKIN14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 08:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbhKIN1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 08:27:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9FC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 05:25:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b4so18451283pgh.10
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 05:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=c8GsJtToV/pDs39tq+dsaJgFOjHAWqKcgsJ6Oth9zmQ=;
        b=lkRjmQBeRiKKHgcYQgq9D/rwVVuLBt0SW3+Cg42zgKs2QOFhJaZnzJtb8gLabCFhXg
         JYy/d5tA2Pejyze+UPrRq38DFsZA57cJi9t0Z7leHVHYV/+dt36sKMggI+awy0CqUUIu
         30wpMdAaI9DQxKjz32RwKv4AOkqaWbPlTytHnVHwjWJ40YI9ZfriO0cyChWSv4Iz9bn0
         LS4LViGDlUjzp2ag3Xyv13lRYT+wbRtkVX/rlu0FeRBYgOkBsD2DC22hAOTzRHMK1xpX
         FK5SABoklkwVd36TnijDgKS+6B9l5RlVszki+9dQIxfkMKJKEkIBYNqm59zYAQHn6kht
         k0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c8GsJtToV/pDs39tq+dsaJgFOjHAWqKcgsJ6Oth9zmQ=;
        b=YR9MXpskvqNUJGxtr3uKObabIqkCLlOa5U7+EhV+U9EjAhVoIJEdeXX4y2Y4Y9kv2o
         4e9vCM+keB+tZKsAHcJVMxUIwovhu2O/twVp/h3i6vSWyyb/IPM5+SwDVDJo35QHRARL
         U8vcy/jqQ4QN9+1TFam6mmawJnvnHwvDLp9FZg55P0PmFRr8Z4ggLxTCiIz2YDKOYRQc
         4dGN5XK35w/uyJiRWhSaYFAUmJPX9N3NS+DX9a45nWvTGjKFw3HTQFcudq8pK3F+apLP
         7VyCqur4pf4d36bQmfSanitmO+G4UlokvwJmoB+SlaiT4ct9+JHQy1rWUSM0feSuAbRw
         7PLw==
X-Gm-Message-State: AOAM532zjVnGBkp1l/p4TVGywU/wmcMMIg1b5KFWLF9kUsyl5Bhw3Z3N
        AX/C28pF0G4ntHvFnuHuiY6mabRQMEfgVg==
X-Google-Smtp-Source: ABdhPJwWkfVIGawyuLQUK5u6dxtEm0Sqb1zbAGwaKGhgLElWo1p6O+nvpr1s+77hK6oHXFCA2l1x+Q==
X-Received: by 2002:a63:e216:: with SMTP id q22mr5907468pgh.3.1636464308990;
        Tue, 09 Nov 2021 05:25:08 -0800 (PST)
Received: from [192.168.178.23] ([61.68.110.20])
        by smtp.gmail.com with ESMTPSA id z1sm15148541pge.4.2021.11.09.05.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 05:25:08 -0800 (PST)
Subject: Re: Serious issues with scrub and raid56
To:     Thiago Ramon <thiagoramon@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAO1Y9wqaEkE1XLjtFj0siLD4JMqTmJZfWJFNcQ26DOu7iir3Bg@mail.gmail.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <4f247bfd-95d6-484b-73a6-3829aa4931c0@gmail.com>
Date:   Wed, 10 Nov 2021 00:25:05 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAO1Y9wqaEkE1XLjtFj0siLD4JMqTmJZfWJFNcQ26DOu7iir3Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Why has no one offered to help Thiago Ramon with his problem?  Or at the 
very least give some advice.

What's in the road-map for once and for all fixing/sorting out RAID56?  
Surely there is a significant amount of Small-Medium-Businesses and home 
users that are interested in the RAID56 use-case!  Why don't those 
responsible for BTRFS do several sprints to sort it out in a kernel release?


On 6/8/21 8:40 am, Thiago Ramon wrote:
> I've been discussing this in IRC at #btrfs for a while now, but I've
> done enough testing that it's past time I've brought it to the list.
>
> First the problems, then I'll give some background on my configuration:
>
> 1 - The current scrub procedure completely ignores p/q stripes unless
> the data csum has problems and it's trying to recover them. This means
> scrub is completely useless for recovering from bitrot on the p/q
> stripes, and given enough time/bad luck, even a single device loss can
> bring down raid5/6. This is not really a bug, more of a design
> oversight that I'm surprised nobody mentioned/noticed so far.
>
> 2 - Some weird condition is causing scrub to miss csum errors. I
> currently have 156 files (out of about 30M) with unrecoverable csum
> errors (found by checking every file), after scrubbing every disk in
> the array twice, the last pass which didn't detect any corruption.
> Those files were damaged from deleting and overwriting other
> uncorrectable files that were sharing the stripes with them, and now
> have the p/q stripes consistent with the csum errors. I've tried
> replicating this situation on a test fs and scrub worked fine, so it's
> something else. The scrubs have an unusually high number of
> no_csum/csum_discards, so I imagine it's something related to that,
> though I can query the csums of the files without any problems through
> the python btrfs library. Any ideas on what I could try to diagnose
> what's going on are welcome.
>
> I have a raid1c4 metadata and raid6 data array with 12 8TB disks,
> currently running kernel 5.12.12, and in the last few months I had 2
> (not simultaneous) disk hardware failures. First disk died while I was
> scrubbing it after it started showing errors, the replace had some
> rebuild failures and afterwards I've had scrub recovering errors all
> over the disks. I have since replaced memory and a SAS controller on
> the machine, but I don't know if either had any issues or it was just
> accumulated errors on the disks (I wasn't scrubbing the disks). I left
> about 1k uncorrectable files linger for too long, and got hit by
> another disk failure, which caused another ~1.5k  files to get
> uncorrectably damaged, mostly files nearby the previous damaged ones
> (which had been deleted/overwritten by then, and possibly helped
> corrupt their neighbors).
> Scrubbing the disks after deleting that last batch of files still
> uncovered a few more uncorrectable files, but after deleting those
> (~4) the uncorrectable csum errors stopped showing up. Last round of
> scrubs repaired a bit over 100 csum errors, but the 156 files
> mentioned above remain, and undetectable by scrub. I haven't seen any
> corrected reads in dmesg while scanning the files, so I think I
> probably won't damage anything else after cleaning up this last batch
> of files, but I might just fix their csums instead, and do a data
> rebalance afterwards to rebuild the possibly damaged p/q stripes that
> scrub isn't checking. But before that I'd like to try to find out why
> scrub is failing to see those.
>
> Thanks,
> Thiago Ramon
