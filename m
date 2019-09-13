Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBDB1BFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfIMLJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 07:09:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36824 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfIMLJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 07:09:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id s18so27769473qkj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 04:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FTkb3yHYwgKj+nqWFeAbW1dWtU7TfSVDwkI2QfsNC4A=;
        b=PLHQ0fMet+Di0XF3vpX/wVkk/pYUdtkFOkTNGNkR395UyD5zKrY+6T6lMSqV7XeGbj
         er6fjGmJka416l54j6+3eJ2NnFtOzbaLNjs0sliqQWnPcjmtZGALCtq74YJbL+2eAIsX
         685NAa5W10W8rdsu3FGk93N4h+2J8zjx1nWSrvM7OQrMOonw6UxtBGb//rTHKt+AIo2T
         ed838p0Nlr+kNJU+16/Ri7TDsWsimUzcUiHKhf9jQoqOpEjImQ1iJAtp5k1DPIaVhO8v
         A5QqtP5Tu+LEARwGg+7T738jeMk72SIcrzYqJfuwgWfgmhS4a7OlOkJngPzUEdijybmE
         bHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTkb3yHYwgKj+nqWFeAbW1dWtU7TfSVDwkI2QfsNC4A=;
        b=lkCQMwVOTLDRDE6UPYMvfu7Uwv+dAnThnTGRmlY8Pw5XCAWC9LCriH2qEZYaky4Vql
         YMR1U9bgCt6wRccLtu7ZE6WEaNdXzm5uaRcpD80l67yZJYuj+cW0RcqUjh58bpo2d8o2
         4TtUbgvVgBh4UoLWh25lKvi+KsPOkUZ4tdNVuODZtcrYLwIXjKlt7gIk/rtISWpIn/5m
         lXwpap2qXfI7TS2O57D/IMLsVCFWRd7noDl8O1ZiV0mJbuNAuR2UEs49JpcDIwGEDdls
         /HbpZtD7mg9pzJyJO6aEmjK4lr7hFA/SkA9Sw34zgp31SgTnkCCXZYY2jTC2Ii+g15/F
         2BYQ==
X-Gm-Message-State: APjAAAWR+/JtiqPoQFj9g9etg7nwr3hGdgMmD/HBdWT8bP1LUVBF7zwx
        /KqksLzQAZFFTljSaUEqQQlJoF3f2xw=
X-Google-Smtp-Source: APXvYqxKHF1vCXr2rnEp70tTfWYKl9hg1f8HRbEYwcqAP1PG7dp5I76j362yuS7Po1ZXXd4ORV2jGg==
X-Received: by 2002:a37:4f55:: with SMTP id d82mr46480740qkb.333.1568372971784;
        Fri, 13 Sep 2019 04:09:31 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id j7sm17032346qtc.73.2019.09.13.04.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 04:09:30 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     General Zed <general-zed@zedlx.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <2d952392-4677-e9f8-7a24-44a617eb5275@gmail.com>
Date:   Fri, 13 Sep 2019 07:09:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-12 18:57, General Zed wrote:
> 
> Quoting Chris Murphy <lists@colorremedies.com>:
> 
>> On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> 
>> wrote:
>>>
>>>
>>> Quoting Chris Murphy <lists@colorremedies.com>:
>>>
>>> > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>>> >>
>>> >> It is normal and common for defrag operation to use some disk space
>>> >> while it is running. I estimate that a reasonable limit would be to
>>> >> use up to 1% of total partition size. So, if a partition size is 100
>>> >> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>>> >
>>> > The simplest case of a file with no shared extents, the minimum free
>>> > space should be set to the potential maximum rewrite of the file, i.e.
>>> > 100% of the file size. Since Btrfs is COW, the entire operation must
>>> > succeed or fail, no possibility of an ambiguous in between state, and
>>> > this does apply to defragment.
>>> >
>>> > So if you're defragging a 10GiB file, you need 10GiB minimum free
>>> > space to COW those extents to a new, mostly contiguous, set of exents,
>>>
>>> False.
>>>
>>> You can defragment just 1 GB of that file, and then just write out to
>>> disk (in new extents) an entire new version of b-trees.
>>> Of course, you don't really need to do all that, as usually only a
>>> small part of the b-trees need to be updated.
>>
>> The `-l` option allows the user to choose a maximum amount to
>> defragment. Setting up a default defragment behavior that has a
>> variable outcome is not idempotent and probably not a good idea.
> 
> We are talking about a future, imagined defrag. It has no -l option yet, 
> as we haven't discussed it yet.
> 
>> As for kernel behavior, it presumably could defragment in portions,
>> but it would have to completely update all affected metadata after
>> each e.g. 1GiB section, translating into 10 separate rewrites of file
>> metadata, all affected nodes, all the way up the tree to the super.
>> There is no such thing as metadata overwrites in Btrfs. You're
>> familiar with the wandering trees problem?
> 
> No, but it doesn't matter.
No, it does matter.  Each time you update metadata, you have to update 
_the entire tree up to the tree root_.  Even if you batch your updates, 
you still have to propagate the update all the way up to the root of the 
tree.
> 
> At worst, it just has to completely write-out "all metadata", all the 
> way up to the super. It needs to be done just once, because what's the 
> point of writing it 10 times over? Then, the super is updated as the 
> final commit.
> 
> On my comouter the ENTIRE METADATA is 1 GB. That would be very tolerable 
> and doable.
You sound like you're dealing with a desktop use case.  It's not unusual 
for very large arrays (double digit TB or larger) to have metadata well 
into the hundreds of GB.  Hell, I've got a 200GB volume with bunches of 
small files that's got almost 5GB of metadata space used.
> 
> But that is a very bad case, because usually not much metadata has to be 
> updated or written out to disk.

> 
> So, there is no problem.
> 
> 

