Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48243E1EF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 00:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhHEWlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhHEWlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 18:41:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA8C0613D5
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Aug 2021 15:40:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c137so11352079ybf.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WPoSqGJrI2GoI+BveCQTbl1Z59EhF1nnHcXsjWwryXQ=;
        b=AY3PvXbcrNUT4iCQS5Ra36IeKRbhm0GDhXJ8FZLwXRZua38BB9RR5aYL3F9gnTJBWr
         JSiuNh4QtRedUFEsx0HuY3cg/ZSXB4MQmlUpbtlvxl+yGLRpNWLPm+suPGO2as7ovikc
         1InMeOv+bgPU8lipogKKMOXj354W5U0Nu773JYErZaP8Bbwbmh9dTO9knl6O++vQqFUk
         6hDYkXfBvtva4wBAACmxy150sN/UjfkFRlZHv9R/ORvWrg+XfjK+6NxYcSCQkSuL/xQh
         m5fth2K6fMR8o9gC523/qKqTA5ihU+53gRWkUo+mlKKI/RDiZ7XLz2qqz5RTeiMDs5dw
         4fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WPoSqGJrI2GoI+BveCQTbl1Z59EhF1nnHcXsjWwryXQ=;
        b=Tz2/DRMbeJ2LZNqcR9wmNhFPHIOjNayzAlvWHHEwREfY25X3Xw8kE0PtcBp4NihXYQ
         lhIPDQ2ZYyIKiFp8P306AEoQNIyJFMrsLLEABvXQOSTSN9LbOlA4IjVvhNje6a/DJm17
         gFI70GtQ5B8KgmfKonsw3CKGhECd1Gw2RLvA2odSZObk+M+1YqTvmS9a5xJy2yT2Kn46
         D6Yr32OrFH+6GjKZvwnKKW2L2kixfSfTCFzKPEZ+nAYBhlxQszjHj4LLgHWdU1NoQ3Qa
         XKw0v/gvptX6cmhlanjqi5kKU0BbF8MD5XPSbE+8y0O0ZDB0UQluHFmTREUZTDCTfRVQ
         WFTw==
X-Gm-Message-State: AOAM533/01KfBzL4bDDfxdcA43RrKJRG5HFRHAHA330eanNshkW4No8s
        kGDRJtJgRvLRwqJlo/tQLs7dDTCLZpEO2wa5nX9iC4qGqdaVzA==
X-Google-Smtp-Source: ABdhPJyVpfqGqDpS/63C1JpQ7uT0ZE0/rx042iYpoe7LN/2mfvrw+Ljw3MaEJd06CohiLBeV5kXlPwoD7WJd91cFuRw=
X-Received: by 2002:a25:d312:: with SMTP id e18mr9290147ybf.14.1628203246870;
 Thu, 05 Aug 2021 15:40:46 -0700 (PDT)
MIME-Version: 1.0
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Thu, 5 Aug 2021 19:40:36 -0300
Message-ID: <CAO1Y9wqaEkE1XLjtFj0siLD4JMqTmJZfWJFNcQ26DOu7iir3Bg@mail.gmail.com>
Subject: Serious issues with scrub and raid56
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been discussing this in IRC at #btrfs for a while now, but I've
done enough testing that it's past time I've brought it to the list.

First the problems, then I'll give some background on my configuration:

1 - The current scrub procedure completely ignores p/q stripes unless
the data csum has problems and it's trying to recover them. This means
scrub is completely useless for recovering from bitrot on the p/q
stripes, and given enough time/bad luck, even a single device loss can
bring down raid5/6. This is not really a bug, more of a design
oversight that I'm surprised nobody mentioned/noticed so far.

2 - Some weird condition is causing scrub to miss csum errors. I
currently have 156 files (out of about 30M) with unrecoverable csum
errors (found by checking every file), after scrubbing every disk in
the array twice, the last pass which didn't detect any corruption.
Those files were damaged from deleting and overwriting other
uncorrectable files that were sharing the stripes with them, and now
have the p/q stripes consistent with the csum errors. I've tried
replicating this situation on a test fs and scrub worked fine, so it's
something else. The scrubs have an unusually high number of
no_csum/csum_discards, so I imagine it's something related to that,
though I can query the csums of the files without any problems through
the python btrfs library. Any ideas on what I could try to diagnose
what's going on are welcome.

I have a raid1c4 metadata and raid6 data array with 12 8TB disks,
currently running kernel 5.12.12, and in the last few months I had 2
(not simultaneous) disk hardware failures. First disk died while I was
scrubbing it after it started showing errors, the replace had some
rebuild failures and afterwards I've had scrub recovering errors all
over the disks. I have since replaced memory and a SAS controller on
the machine, but I don't know if either had any issues or it was just
accumulated errors on the disks (I wasn't scrubbing the disks). I left
about 1k uncorrectable files linger for too long, and got hit by
another disk failure, which caused another ~1.5k  files to get
uncorrectably damaged, mostly files nearby the previous damaged ones
(which had been deleted/overwritten by then, and possibly helped
corrupt their neighbors).
Scrubbing the disks after deleting that last batch of files still
uncovered a few more uncorrectable files, but after deleting those
(~4) the uncorrectable csum errors stopped showing up. Last round of
scrubs repaired a bit over 100 csum errors, but the 156 files
mentioned above remain, and undetectable by scrub. I haven't seen any
corrected reads in dmesg while scanning the files, so I think I
probably won't damage anything else after cleaning up this last batch
of files, but I might just fix their csums instead, and do a data
rebalance afterwards to rebuild the possibly damaged p/q stripes that
scrub isn't checking. But before that I'd like to try to find out why
scrub is failing to see those.

Thanks,
Thiago Ramon
