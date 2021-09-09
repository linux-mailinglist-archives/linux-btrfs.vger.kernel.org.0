Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18F040425E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 02:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348817AbhIIAtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 20:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbhIIAs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 20:48:59 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FBC061575
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 17:47:51 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id l9so128560vsb.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hj6fo7RhHswmMoROQxBi1Qi00TB4E9nmrvjo5kmco3M=;
        b=bAUiKknjrYkujVH4dlofq7OD9xVjjAABL0Uo7V51N3qJ8NEJ710Nk1A2W++tdop+qD
         lqAQ4S/h3nGG1h9aThnhoeLCxi+VPV5qlwZqAq4FZx0GHsTvEB6gWUWEcWzU+ZHenpmv
         Q0G4i6MZHIna1Js0eCv45pw9GbRDgIER8YwtCOp2l2MASC3pXGS9FtuGjNQEsoPYrTQZ
         zCtAoSSUp9SjQ2ITlsupzicm86wU3qsoEKbLeg9saxTVxDDpNWs9zrGtJy+OwYCmbRIG
         V15Oza4Pe5cEQ4qsN0RI0IKLgdyTRdwvjtbcebDiVpmVOBxMYI/7ZLOKZyLLIL1BLa/q
         enOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hj6fo7RhHswmMoROQxBi1Qi00TB4E9nmrvjo5kmco3M=;
        b=MPV0xmrg+kpM7PybwdWSGsMdz1b6Fw8u9tnZgmCf14Z49k6lV4CPelMeigRbWeNxUG
         S1cwIDVr2cU5nUyoGF9I+jipEkrvd/m5VoqnfIIIa7jIvR9Pu02OjGoZ9b98k9ROyQ/s
         tcSEP3j6ofUac1SseWOwbeNv2HrStrI0HINBi+gQrhdrOhSGexyXKgL+xFkS/hEEPJpK
         uqIMdc+M4GEmXsKSAKoG17Cb+DG8L+b7MM2s+Si8+s+pmupBfxNYdwdj3k/RQZiKqVcm
         RvnvoqKhQq7eYSwCTf+kcTz3CjyhCjAq/ZL9dmrhTnaJPUSaJVR83hMgmk5doESHfaXI
         KI1Q==
X-Gm-Message-State: AOAM532PtngnIQDFlpbIRVDy/4XF88ZNNCZ5v3GOI9gyQyf89f63vt8y
        OfIaF564wg3xx6cyoY7BSpa7y/xmUV5P3re5N1s+GznAIig3gg==
X-Google-Smtp-Source: ABdhPJxoLakCz8MO5RVS7boGK/rHTObZlit61zx63Z3wb+Q6quRqAgC3h60QGoL2ZMFCUvC9mAJQqDU0Ouic0EXZLrA=
X-Received: by 2002:a05:6102:222d:: with SMTP id d13mr135022vsb.2.1631148470334;
 Wed, 08 Sep 2021 17:47:50 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Wed, 8 Sep 2021 18:47:39 -0600
Message-ID: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
Subject: Corruption suspiciously soon after upgrade to 5.14.1; filesystem less
 than 5 weeks old
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

First, I should say that there's no urgency here on my part.
Everything important is very well backed up, and even the
"unimportant" files (various configs) seem readable. I imaged the
partition without even attempting a repair. Normally, my inclination
would be to shrug this off and recreate the filesystem.

However, I'd like to help investigate the root cause, because:
1. This happened suspiciously soon (see my timeline in the link below)
after upgrading to kernel 5.14.1, so may be a serious regression.
2. The filesystem was created less than 5 weeks ago, so the possible
causes are relatively few.
3. My last successful btrfs scrub was just before upgrading to 5.14.1,
hopefully narrowing possible root causes even more.
4. I have imaged the partition and am thus willing to attempt risky
experimental repairs. (Mostly for the sake of reporting if they work.)

Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no LVM)
OS: Gentoo
Earliest kernel ever used: 5.10.52-gentoo
First kernel version used for "real" usage: 5.13.8
Relevant information: See my Gist,
https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
Misc. notes: I have run "fstrim /" on occasion, but don't have
discards enabled automatically. I doubt TRIM is the culprit, but I
can't rule it out.

My primary hypothesis is that there's some write bug in Linux 5.14.1.
I installed some package updates right before btrfs detected the
problem, and most of the files in the `btrfs check` output look like
they were created as part of those updates.

My secondary hypothesis is that creating and/or using the swapfile
caused some kind of silent corruption that didn't become a detectable
issue until several further writes later.

Let me know if there's anything else I should try/provide!

Regards,
Sam
