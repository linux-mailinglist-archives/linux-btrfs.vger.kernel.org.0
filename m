Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD824BE7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgHTN1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgHTN1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 09:27:35 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9147C061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 06:27:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k18so1127242qtm.10
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HzEjdz1fbVCZCXHazZlLthU/X3YRM19rK7o0gGY1tmU=;
        b=b3xxKobJJecqFw7wZrQPVTkyBtMk7G5qKHCBvtahp2tc4ORB5PPrsMLYVMA/FRCRSs
         mSm2kBNupelPu50vtokAyrc+pp5uxrG3+nUPAyOrxTg3/aGVVMEatdhiBb7MmhhA3mMO
         ev9aBCAGTabEXW7+NgNL9nGsKNZ+0gSHwfE3x5zczQdD/SUyP9EY3oC8hFTD64N8mUFp
         daNa9yF7HH5Pz3ySmLd+ATHj3zx3xncNT5r5VeQxUUx6civApPk57MoIf/LrWkSYmjXw
         /MQTMQPWj99MG9+0AAsMkpXlaLvRU5wCUBCq798w3vOV9plFf/uZmauvZjPUNo7t9N4j
         bRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HzEjdz1fbVCZCXHazZlLthU/X3YRM19rK7o0gGY1tmU=;
        b=EX/lCIumFR3ZOel+P7PWfEUh0nasHdxpIfjPlm7wR/RK6lLXvn0YW/BTH0aTT5mLS1
         kOwpvGJCanoB8jY80Q+RVqt12NXT+Bsl52fJE3hav9r45xdV/koVmwt8if++R13AylaS
         l6xtZrLYTJvcDBWZzxnIHfcy7tmEXaces4q6bOnyMP7zoPn+gRfRPcoM3cvqrYNWtArb
         Z0aXBGoBSCOn7KdL9BnZjEfaaRNvfy9bJ05IZG3fjfkRDXa+mYR76HMCZqUWOXBmkAQI
         7sCuwYrZOjESE6wyoJkGlMA6GZcjVWe46BULDbqF6VKXL1RaXGQ9l9qdx980ldu5f90T
         W3Eg==
X-Gm-Message-State: AOAM530mA0zWXSIoJV3RT8qgp9JGfITdZ6hWUcN6BYo9faB2auLFEebt
        k5AGzS2SkYw1Dtpy+CnhDQyEUg==
X-Google-Smtp-Source: ABdhPJz1jwHOFlT/iQ6D8q8pet0xGL4XigJJMqK6/KdzkhKUVEEB6wfK0MsaV1d5wfD0rUZW0la2+Q==
X-Received: by 2002:ac8:65c4:: with SMTP id t4mr2732794qto.264.1597930051867;
        Thu, 20 Aug 2020 06:27:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x3sm2105219qkx.3.2020.08.20.06.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 06:27:31 -0700 (PDT)
Subject: Re: [RFC] Tying in github issues into our workflow
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
 <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e457e4d3-1b63-641f-f19d-7d818c46d16e@toxicpanda.com>
Date:   Thu, 20 Aug 2020 09:27:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/19/20 8:42 PM, Neal Gompa wrote:
> On Wed, Aug 19, 2020 at 4:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> Hello,
>>
>> As we discussed last week, we'd really like to have a way to better track the
>> status of outstanding patches.  One of the suggestions Dave made was to use the
>> "Projects" feature inside github, because we're not going to be able to get away
>> from having patches on the mailinglist any time soon.
>>
>> I've mocked up a couple of helper scripts and some documentation on how this
>> would work.  I've tested the workflow (not with real patches yet because my
>> develbox is down for maintenance ATM) and it seems reasonable and pretty
>> straightforward.  There are two scripts
>>
>> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-send-patches
>> https://github.com/josefbacik/debug-scripts/blob/master/btrfs-create-issue
>>
>> I'll explain my thought process and such here, but if you don't care and just
>> want to look at the workflow then skip to the PREREQUISITES section at the bottom.
>>
>> The project exists here
>>
>> https://github.com/orgs/btrfs/projects/1
>>
>> and has a few columns.  When we submit patches we'll create an issue and it'll
>> go into "Needs review".  This is straightforward, we're waiting on reviews for
>> these patches.  From here it's a little manual unfortunately, but once the
>> patches are reviewed you can move the issue to "Ready to be merged", and from
>> there Dave can decide if he's actually going to merge it.  If he does then he
>> can close the issue and it moves to the "Merged" state.  If he has comments he
>> can make those and move it to "Needs work".  Likewise if any reviewer has
>> comments then the issue can be moved to "Needs work" by the reviewer.
>>
>> To reiterate we're not getting away from mailinglist interactions (yet), so we
>> should keep all patch related discussion on the list for now, we simply use
>> these issues so patch series don't get lost.  This will also help reviewers know
>> what is left to be reviewed.
>>
>> Let me know what everybody (preferably just those of us who actually write
>> kernel patches) thinks about this.  None of this is set in stone, trying to work
>> out the easiest way to help track patch review status.  Thanks,
>>
>> Josef
>>
>> PREREQUISITES
>>
>> You need to have the github cli tools installed, you can find packages for them here
>>
>> https://github.com/cli/cli/releases
>>
>> YOU MUST INSTALL THIS ON A BOX THAT CAN OPEN A WEB BROWSER.  This is important
>> because the first time you run the gh command it sets up the 0auth stuff, so it
>> must be able to open a browser.  The steps are
>>
>> 1) Install the gh package
>> 2) run `gh repo view`.  This will launch the browser to do the 0auth stuff,
>>      follow the prompts.
>> 3) [OPTIONAL] If you are like me and submit from a headless machine, you need to
>>      copy the ~/.config/gh/hosts.yaml file to the machine you are going to use,
>>      and everything will work fine.
>>
>> WORKFLOW
>>
>> DEVELOPER
>>
>> 1) The --thread option with git format-patch is is required for this to work
>>      with the tools I've written
>>
>>      For a patch series: mkdir patches; git format-patch --thread -o patches -#
>>      For a single patch: git format-patch --thread -1
>>
>> 2) ./btrfs-send-patches <patches|0001-<whatever.patch>
>>
>>      This does the git-send-email (which will ask you questions) and then creates
>>      the issue with the Message-Id that was generated with the appropriate links.
>>
>> 3) If you get feedback and your reviewer doesn't move the task to "Needs work"
>>      please do that, and then address any feedback.  Once the feedback is
>>      addressed you can change the issue to "Needs review" and update the
>>      description with the new Message-id information.
>>
>> REVIEWER
>>
>> 1) Check the project page
>>
>>      https://github.com/orgs/btrfs/projects/1
>>
>>      for anything in the "Needs review column".  Review those patches on the list.
>>
>> 2a) If you are satisfied, change the status of the issue to "Ready to be merged"
>>       by dragging it into that column.  Alternatively, if you are in the issue
>>       itself, you can click the drop-down menu under the "Projects" section on the
>>       right and assign it to "Ready to be merged".
>>
>> 2b) If you have feedback, move the issue to the "Needs work" column in the same
>>       way as described above.
>>
>> DAVE/MAINTAINER
>>
>> 1) Anything in the "Ready to be merged" is what you care about, do what you
>>      want.  If you merge it, close the task and it'll be automatically moved to
>>      "Merged", otherwise kick it back to whichever stage is appropriate.
> 
> I know you said that you principally wanted feedback from the btrfs
> kernel hackers, but from someone who does the oddball thing here and
> there and is trying to become increasingly active in btrfs upstream, I
> have some thoughts here.
> 
> In general, I like the idea of moving to more contemporary workflows
> for some parts of this stuff. I had actually been contemplating
> setting up such a thing on pagure.io for tracking my own work on this
> front (since I generally prefer to use FOSS platforms if I can).
> Regardless of using GitHub.com or something else, I think it's a good
> idea to have some generally usable way for tracking development and
> allowing people to report issues to the project.
> 
> (It's a shame that kernel.org doesn't have a pagure instance. That
> could be potentially more usable for a lot more people than the
> oft-ignored and unloved bugzilla system, projects don't have to enable
> pull requests with pagure projects, and all project metadata is stored
> as git repositories, which I think would appeal to a lot of folks
> here...)
> 

I'm not strongly tied to github here, we just already have something in place 
for it and are familiar with how it works.  The biggest thing for myself (and 
the rest of us I assume) is ease of integration.  I basically only want to use 
the web interface to check status, otherwise I want CLI tools to handle most of 
the paperwork shuffling.  Does pagure have a CLI for doing this?  I saw some 
haskell thing that's like 5 years old, but nothing newer.  Even a basic JSON 
interface would be ok, I have a curl script that interacts with a JSON thing to 
text my phone for stuff, so I'm not opposed to rigging something like that up 
for our uses.  If Pagure can do exactly the same thing then I don't see a reason 
not to use that instead.  Thanks,

Josef
