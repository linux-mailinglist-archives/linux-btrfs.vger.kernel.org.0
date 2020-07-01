Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AE210FBC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGAPvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbgGAPvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 11:51:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC0C08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 08:51:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so20145082qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IH7nZ4+3iRONEdDmR73F0wMVvYsS4cI7lP3VE/8Z/gc=;
        b=IAMEOWajeoZBPaoBmGDTHdMW8YwYg2bTX/cmR6pwBe4i1liMsu+RE5Rm09JPhaq+Uj
         hyIPCNIynlzuk5n+dczZW2EHyMCkU0QrMPxQyL9WPKJEzN9O5sSLZ1QqPz5jjBgo3U1b
         EC8vq4StITBPve0EH55KCh/wxlHlQpq20Y9yP2w1q1vaDrR2TzRZhfLkPJG+yLLRcBw+
         MaIGaOl0+F+x04lXmM0XSEmo/eAgHbtdQBJj190VYg1wLHsQzBw/V70d9H/r2v/A+HZl
         GfxH06jAM8hUCObn0f5ehcXV7TCC/++ezfr/hxZnHuxfONKxzFDESCWNjMsLMVpeKJXP
         ieGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IH7nZ4+3iRONEdDmR73F0wMVvYsS4cI7lP3VE/8Z/gc=;
        b=FcNE9RHyvK1iRM0ep3vXXcfb0sh2CEt92g2oT2/UgAD8aolshq0vKbH9lhIJUcs2rP
         VgfR0eBHlnYzCtwzSRiAZaNcu++58sNRrRBqEww3cOf7txgN2WcCsTDG270vpwWbuAHV
         KJrEqhli9ArSb8eiXrJnws79tcEvLromtRTwAZlNq6SH1bFvJa3MaigptICg2kU55ED9
         TBzqIZk/fqcNvx3KE9slGvNDorkOVCiZlo8EO7MFXF6ZKbBj5BYLQYCFormDBDL3OXcp
         0xo1wZ7RrgiUvA1VfjNijL+NLUika2iyJYrKhiB5EWOIz906HRWCml6aPj5A7L5NYTiz
         UV/A==
X-Gm-Message-State: AOAM530KlEbtv7uqvfFznS1QIO5i73Pz0HvNEimg2l4YVhJ8RKYgCe20
        npzzDpG/XaxWZhoQYydyu2ua+XH2bh7Tvg==
X-Google-Smtp-Source: ABdhPJwL/3pMEBxEILGKXzNsFeBxBFCpMxjZOohU8jq9Pabnj1w12tENYYwiDbYcagm6+EL149KEGw==
X-Received: by 2002:a37:46d3:: with SMTP id t202mr24651835qka.483.1593618699116;
        Wed, 01 Jul 2020 08:51:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v28sm5226648qkv.31.2020.07.01.08.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:51:38 -0700 (PDT)
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     dsterba@suse.cz, Lukas Straub <lukasstraub2@web.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200701172218.01c0197d@luklap> <20200701153919.GD27795@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e2ba925d-024a-5749-1424-af846bf36717@toxicpanda.com>
Date:   Wed, 1 Jul 2020 11:51:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701153919.GD27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 11:39 AM, David Sterba wrote:
> On Wed, Jul 01, 2020 at 05:22:18PM +0200, Lukas Straub wrote:
>> On Wed,  1 Jul 2020 10:44:38 -0400
>> Josef Bacik <josef@toxicpanda.com> wrote:
>>
>>> One of the things that came up consistently in talking with Fedora about
>>> switching to btrfs as default is that btrfs is particularly vulnerable
>>> to metadata corruption.  If any of the core global roots are corrupted,
>>> the fs is unmountable and fsck can't usually do anything for you without
>>> some special options.
>>>
>>> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
>>> what it really does is just allow you to operate without an extent root.
>>> However there are a lot of other roots, and I'd rather not have to do
>>>
>>> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
>>>
>>> Instead take his original idea and modify it so it just works for
>>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>>> to read just gets left empty and we carry on.
>>>
>>> Obviously if the fs roots are screwed then the user is in trouble, but
>>> otherwise this makes it much easier to pull stuff off the disk without
>>> needing our special rescue tools.  I tested this with my TEST_DEV that
>>> had a bunch of data on it by corrupting the csum tree and then reading
>>> files off the disk.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>
>>> I'm not married to the rescue=onlyfs name, if we can think of something better
>>> I'm good.
>>
>> Maybe you could go a step further and automatically switch to rescue
>> mode if something is corrupt. This is easier for the user than having
>> to remember the mount flags.
> 
> We don't want to do the auto-switching in general as it's a non-standard
> situation.  It's better to get user attention than to silently mount
> with limited capabilities and then let the user find out that something
> went wrong, eg. system services randomly failing to start or work.
> 

To elaborate further on this, systemd is still working on (and maybe can now) 
boot a box with a read only fs.  This is the sort of thing we want to make 
really clear to the user, so I'm all for giving them the abilities to get to 
this rescue mode, but as a policy it needs to be handled in userspace, either 
via systemd or some other mechanism if people want it to be automatic.  Thanks,

Josef
