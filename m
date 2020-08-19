Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3245024A7C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHSUeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 16:34:02 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F9C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 13:34:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d14so22863040qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fdb9cUOMIGbW4jOLth+VWCyIP9chpoR+Ak18p+80IeA=;
        b=RFEvJRkmWkkjd2FhdkoPmk9H9S4G6PXXLOajunBeRswFKTBc4mcQSn5AhiX3jTTP2i
         Ua3jk0VkP8sQkpx3CynZSTIpgkkK5tlvF4vd104FTVZP72in9FqS7z14zyjGYn5J6Z+t
         FjWGz6Mf1iw5LJQa+W0A72YArlG/bR4wG11q2nxopznkmiLuimYI61agDRvgV0WVwZWt
         +tBlIGL15RB41x0DCkblM6ZcaZxp2bAOdE6YNxXDGKFb2WXGQWrhXi3876OirGnfwA3C
         U9EejKQqLXUQuEF8UXfLaQckQ5vG1zvERqUXhR26M+e5+i8kWst506Xj8J4JaVDO7JNs
         kQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fdb9cUOMIGbW4jOLth+VWCyIP9chpoR+Ak18p+80IeA=;
        b=iceEbknIwQYUD08QsleMkNFt60xClLzzq/bGamiFFOhL7RW3FaXgzrZW7hQ1YB3jix
         sTOXVPoeElHxYwfAN710pZxsLHYAnjkpbYQ9J7k1XhN82GX5fgSWLDUSaZZ7w9IEnPqp
         I2JsF/QocUOlhMTdBq36sy6oTy0fmJ0RyK0Xrtv37C+N7KAKNptMzWsPEY4rM9i7Qv55
         PuWkoxd6T7qktjO6PUpLQTpVBMEn9/Km3EPlyzOeeamE35DD2YfqdDh84fWlHbmQrckS
         sAPnfWmH1gQWUxBdCEFuXl/+44jgAlEBI88K4MW4oNRsf23g1ZSNOlOn35nFOGFm2Mws
         Holw==
X-Gm-Message-State: AOAM532HtcGnzvyyOf1p3e7XklGq46019AgnOA7gTZl7UHd6/F/bkAoL
        MzqxHyDw5AIEX5PYN6jxDxNHXuW5YxiSjfGf
X-Google-Smtp-Source: ABdhPJwZp0x50rnyQ5DlFSiyykBwYDAar82oJCI3LWjnKocMhqn/cPSsUucjRpy7CxZ0lGa83sJoNQ==
X-Received: by 2002:a37:a746:: with SMTP id q67mr23124700qke.93.1597869240837;
        Wed, 19 Aug 2020 13:34:00 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1212? ([2620:10d:c091:480::1:4a8d])
        by smtp.gmail.com with ESMTPSA id c9sm24280975qkm.44.2020.08.19.13.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 13:34:00 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
Cc:     "kernel-team@fb.com" <kernel-team@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: [RFC] Tying in github issues into our workflow
Message-ID: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
Date:   Wed, 19 Aug 2020 16:33:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

As we discussed last week, we'd really like to have a way to better track the 
status of outstanding patches.  One of the suggestions Dave made was to use the 
"Projects" feature inside github, because we're not going to be able to get away 
from having patches on the mailinglist any time soon.

I've mocked up a couple of helper scripts and some documentation on how this 
would work.  I've tested the workflow (not with real patches yet because my 
develbox is down for maintenance ATM) and it seems reasonable and pretty 
straightforward.  There are two scripts

https://github.com/josefbacik/debug-scripts/blob/master/btrfs-send-patches
https://github.com/josefbacik/debug-scripts/blob/master/btrfs-create-issue

I'll explain my thought process and such here, but if you don't care and just 
want to look at the workflow then skip to the PREREQUISITES section at the bottom.

The project exists here

https://github.com/orgs/btrfs/projects/1

and has a few columns.  When we submit patches we'll create an issue and it'll 
go into "Needs review".  This is straightforward, we're waiting on reviews for 
these patches.  From here it's a little manual unfortunately, but once the 
patches are reviewed you can move the issue to "Ready to be merged", and from 
there Dave can decide if he's actually going to merge it.  If he does then he 
can close the issue and it moves to the "Merged" state.  If he has comments he 
can make those and move it to "Needs work".  Likewise if any reviewer has 
comments then the issue can be moved to "Needs work" by the reviewer.

To reiterate we're not getting away from mailinglist interactions (yet), so we 
should keep all patch related discussion on the list for now, we simply use 
these issues so patch series don't get lost.  This will also help reviewers know 
what is left to be reviewed.

Let me know what everybody (preferably just those of us who actually write 
kernel patches) thinks about this.  None of this is set in stone, trying to work 
out the easiest way to help track patch review status.  Thanks,

Josef

PREREQUISITES

You need to have the github cli tools installed, you can find packages for them here

https://github.com/cli/cli/releases

YOU MUST INSTALL THIS ON A BOX THAT CAN OPEN A WEB BROWSER.  This is important 
because the first time you run the gh command it sets up the 0auth stuff, so it 
must be able to open a browser.  The steps are

1) Install the gh package
2) run `gh repo view`.  This will launch the browser to do the 0auth stuff,
    follow the prompts.
3) [OPTIONAL] If you are like me and submit from a headless machine, you need to
    copy the ~/.config/gh/hosts.yaml file to the machine you are going to use,
    and everything will work fine.

WORKFLOW

DEVELOPER

1) The --thread option with git format-patch is is required for this to work
    with the tools I've written

    For a patch series: mkdir patches; git format-patch --thread -o patches -#
    For a single patch: git format-patch --thread -1

2) ./btrfs-send-patches <patches|0001-<whatever.patch>

    This does the git-send-email (which will ask you questions) and then creates
    the issue with the Message-Id that was generated with the appropriate links.

3) If you get feedback and your reviewer doesn't move the task to "Needs work"
    please do that, and then address any feedback.  Once the feedback is
    addressed you can change the issue to "Needs review" and update the
    description with the new Message-id information.

REVIEWER

1) Check the project page

    https://github.com/orgs/btrfs/projects/1

    for anything in the "Needs review column".  Review those patches on the list.

2a) If you are satisfied, change the status of the issue to "Ready to be merged"
     by dragging it into that column.  Alternatively, if you are in the issue
     itself, you can click the drop-down menu under the "Projects" section on the
     right and assign it to "Ready to be merged".

2b) If you have feedback, move the issue to the "Needs work" column in the same
     way as described above.

DAVE/MAINTAINER

1) Anything in the "Ready to be merged" is what you care about, do what you
    want.  If you merge it, close the task and it'll be automatically moved to
    "Merged", otherwise kick it back to whichever stage is appropriate.
