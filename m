Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E12A6C98
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgKDSVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgKDSVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:21:24 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E16C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:21:24 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id g19so159937qvy.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FPi3rQ5ogFLVuztxsExOPFUO9rfq3ZO0dNDZ3zTGAiY=;
        b=jeMLS5k6b/QcPV5dtAoguRqGbe4jeItv4jj4T03rLdN9avjG4WN+8xfoO1D7xCZDwP
         q7t70IAHmC+p29h+knH6V09Li/OHI2L/Y/IZnQmFc1LL4VMbfYN7tEyYemtGd8q0neBd
         wFncxyIFtCZFCoGvkHt02JFHzoktNSLWx3i7Ese/b9jvKq2bxiAoO8qwtZscGrX9hXJG
         PjcLQDIeOdiffxA9LXVizET40aUEi7wBaQPKytoOwlFAVFQ/XPSH0wHvxQToBcT/omB5
         tdwEl8rh5uv1zQYq1RSnwNlMPqE0/PjTrPbHwvvF8lfeuwXlD+vhgcwGhfAwn263RL7m
         rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FPi3rQ5ogFLVuztxsExOPFUO9rfq3ZO0dNDZ3zTGAiY=;
        b=PNDpnwvqHzWfguvN3aEX5IAPJIvwePzNVWDraBzPFiZqaN8bRMBn0XvM+hrJF9Gr2y
         XZMShrqDuNuAyddUicQd5P7Srn6RFECEMDUTFN2PyAWNb+8CKy11K66uXd3B2J4hznQe
         sWVxe+iPssgBQ+Q5slig5b7aGa6QI+/3o5GZDl/xUD/Q6oWRhX68IP+KZUO/PNo0XSsk
         08TPAgugFdWEGC4jQluap/KOPhFAFFS5nODAfXBUCvpUQ+PBEQm4CLksTS6iA5H2tj4B
         9UKl9LL1pN3RyBRCC5HfGOoukZw/XtLR1aZlUMaViWIZrhZNdEXkr4VHHLUYUywkfNIA
         EuSw==
X-Gm-Message-State: AOAM530ihRNultTzd/FZr/7xS08tpsIdt8n0C9v4kP+gXz8RX9JCfj/t
        nL/9Zy0/JxNx1Nc6rx7SFwjkUmCJVZilGw==
X-Google-Smtp-Source: ABdhPJwQGWGoh7RbgWVpXrZTHiRszH2VGQwOg44zkek3vVAK+7K8ush8BFlTWZJR227HrWxcz/jYvA==
X-Received: by 2002:a0c:f205:: with SMTP id h5mr25411812qvk.27.1604514083443;
        Wed, 04 Nov 2020 10:21:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:8f29])
        by smtp.gmail.com with ESMTPSA id o8sm750055qtm.9.2020.11.04.10.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:21:22 -0800 (PST)
Subject: Re: [PATCH 4/8] btrfs: cleanup btrfs_discard_update_discardable usage
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <cover.1603460665.git.josef@toxicpanda.com>
 <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
 <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fd63e33b-49ea-2150-eaef-e3fd19e5372a@toxicpanda.com>
Date:   Wed, 4 Nov 2020 13:21:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 10:54 AM, Filipe Manana wrote:
> On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> This passes in the block_group and the free_space_ctl, but we can get
>> this from the block group itself.  Part of this is because we call it
>> from __load_free_space_cache, which can be called for the inode cache as
>> well.  Move that call into the block group specific load section, wrap
>> it in the right lock that we need, and fix up the arguments to only take
>> the block group.  Add a lockdep_assert as well for good measure to make
>> sure we don't mess up the locking again.
> 
> So this is actually 2 different things in one patch:
> 
> 1) A cleanup to remove an unnecessary argument to
> btrfs_discard_update_discardable();
> 
> 2) A bug because btrfs_discard_update_discardable() is not being
> called with the lock ->tree_lock held in one specific context.

Yeah but the specific context is on load, so we won't have concurrent modifiers 
to the tree until _after_ the cache is successfully loaded.  Of course this 
patchset changes that so it's important now, but prior to this we didn't 
necessarily need the lock, so it's not really a bug fix, just an adjustment.

However I'm always happy to inflate my patch counts, makes me look good at 
performance review time ;).  I'm happy to respin with it broken out.  Thanks,

Josef
