Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8C4047DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhIIJiq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhIIJio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 05:38:44 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3ABC061575
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 02:37:35 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 060779B89E; Thu,  9 Sep 2021 10:37:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631180252;
        bh=9J2g2KEfeDm5uIYQ3aMmJqHPf9xTSJjahFHCiywh0K0=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=hOfM7EGCEZUoQkce67pclx7p1e4MBhNCYPkP3N6PH25oBWRIIaiywPc7ElPvZP5Jk
         xfT/D9wdP3BSCifJO4s+Oijbs50Hlq83+cXocU03FOp8yUCXF7sA25k1MT9xYmjr3T
         tbFIjlPlYloCFxlORhZyf/4v42UM58QXSV0WuD5M7Y3p7486dFDnSYaiwWvMLXK3fS
         vzgZx+Y7tTQx47lMQseApWe4DhlA3Xw7hPK7pCukRbumQe4pUyauXoJv+VplxWShrX
         THaY4wTVrRRs8h9zxVgtQmBn8t3XeQ87elf4CLzu7mIlZYYj355H32avXDffbUNOlv
         28Hz2y5EWDJfg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 602B09B800;
        Thu,  9 Sep 2021 10:37:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631180222;
        bh=9J2g2KEfeDm5uIYQ3aMmJqHPf9xTSJjahFHCiywh0K0=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=jyg1lqYsU2ZWPwgU6kHOiY75xkrIYeBau19QpTE1qtbEl9pZh4lP/3U9GMyJemkKw
         2EtZ4yyqakiLRy2GftIsuC6Shf2EhAnCdKJNuSpNL04b1neurl1P+D/8ovnNC7l4Ql
         RbeT/N7CWY1jYTFpaDSUsFtKXA6FYATpiTYJDc3DKOLF0hVXuob7N9pKaIhHOqjIqA
         2S/P0xG9mDkl0LRm68lVabPljQLtDAgpAncwhUSoQi652njNQJP0hfTXQRPOYSQmXK
         yoQEXOo2S0WsorctVvvXf0hT80mAcp6v5pz+yCOG2HKJGFHKVu8oUlHFIk7cdsuYru
         c6tWyuta9jCoA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 20C5B294B87;
        Thu,  9 Sep 2021 10:37:02 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        Martin Raiber <martin@urbackup.org>,
        linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
 <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
 <50fea163-afe6-bb4a-04c5-f3e4ed4c6bd3@suse.com>
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
Message-ID: <b15813b9-bd23-e2a5-b8a4-1c2fcbb0e019@cobb.uk.net>
Date:   Thu, 9 Sep 2021 10:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <50fea163-afe6-bb4a-04c5-f3e4ed4c6bd3@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/09/2021 07:46, Nikolay Borisov wrote:
> 
> 
> On 9.09.21 г. 0:24, Graham Cobb wrote:
>>
>> On 08/09/2021 19:33, David Sterba wrote:
>>> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
>>
>> <snip>
>>
>>>> For example I had the problem of partial subvols after a sudden
>>>> restart during receive. No problem, just receive to a directory that
>>>> gets deleted on startup then move the subvol to the final location
>>>> after completion. To move the subvol it needs to be temporarily set rw
>>>> for some reason. I'm sure there is some better solution but patterns
>>>> like this might be out there.
>>>
>>> Thanks, that's a case we should take into account. And there are
>>> probably more, but I'm not using send/receive much so that's another
>>> reason why I've been hesitant to merge the patch due to lack of
>>> understanding of the use case.
>>>
>>
>> This seems to be an important change to make, but is user-affecting. A
>> few ideas:
>>
>> 1) Can it be made optional? On by default but possible to turn off
>> (mount option, sys file, ...) if you really need to retain the current
>> behaviour.
> 
> But the current behavior is buggy and non-intentional so it should be
> rectified. Basically we've made it easy for users to do something which
> they shouldn't really be doing, they then bear the consequences and come
> to the mailing list for support thinking something is broken.

Yes, I agree completely. I was disappointed the change wasn't made last
time this was discussed on the list. But it wasn't. And I think that was
because of concern over the impact: the change will break some users'
workflows or scripts and could break some important tools, apps or
things like distro installation/upgrade scripts. That was the purpose of
my suggestions: to break down barriers which might delay making this happen.

>> 2) Is there a way to engage with the developers and user community for
>> popular tools which make heavy use of snapshotting and/or send/receive
>> for discussion and testing? For example, btrbk, snapper, distros.

The point of this suggestion was to address David's concern of not
understanding the use case. This could be useful when discussing the
timing of the fix (and whether it can be backported to stable kernels).

>> 3) How about adding an IOCTL to allow the user to set/delete the
>> received_uuid? Only intended for cases which really need to emulate the
>> removed behaviour. This could be a less complex long term solution than
>> keeping option 1 indefinitely.

And this suggestion was to make it "possible" to work round the change
but, in practice, harder than just doing the right thing :-) I agree
this is probably too far.

Graham



