Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54799B1BEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfIMLEd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 07:04:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34670 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfIMLEd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 07:04:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id j1so20603295qth.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D1F5ED08sYMTtwHYpwWjrFOe4JYmZe0WoGLpgZXAbtI=;
        b=BfXrlSOwcwTnMUkmjTAuAUvyIkXG+SWXaQB5RsqujjZeZGa86lAbnKXAxUV91OGpGw
         RfqXgww9FqbzUdI53VZL60ySm2cQGiYZau+lTD/04OOWPBQHOPK4VDdiAzQZudqLfSnC
         AmVK7uurcrJrqvSq+84Qa4bhQNWcah0gN/KtpTHyWvB3NHq+R5xSvJdnu9GeS46PtSUc
         6D2NyjvuoGmKagrnHxOWrQnLIEGzjDMIOmMJgvErB4PCYIUdUWwV7iNQa99NA1NZvj8z
         SdXh//U4UpY9SGht8sgkZpjZzgvdkngZa0lGbhHD8aABxORm9gb9uha/yP6fooIWFcWa
         uovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1F5ED08sYMTtwHYpwWjrFOe4JYmZe0WoGLpgZXAbtI=;
        b=UPo2prhABqniVN8HbBYIbiVld+9jHwUJ84AxQIdyvtzQkpaM0+zrgsgPTBhAgDHiXO
         XgWMOeJZINM4iZJQ2EmcOKA9IrmS4r3e/iWe3nlFKSLqEZRGJ1LuVTm99D0vFNvpnt8U
         9C5XZQ8Ykz1O0NkwxyzkqUa3osUTAPfNW8rhY+hMcnHukiRek7rBtk051JSMEX8qV2JS
         WW0rZQBsoLa7hYJ3sxfuUVMbTIvlZxp0R56445mTWtRGsXhPWyCmIKsw/0F5/tXFvtHw
         Yn6lObppHlaUPJ4n969ZiYHo+n/JucwEa5TGiTKx+rtNKIdKvo5KhGwbT+uSWATotxQE
         3rbQ==
X-Gm-Message-State: APjAAAUpcLxANa4xDVhkvSAcNNuPUI4RZD4EhqAHXjK5HygIWoeVPJND
        PylXLLa63u3GSig+/zXQp+Pm1263Bjw=
X-Google-Smtp-Source: APXvYqziNooBa5hSqcbTrTaclmCqLaJv5USbIc5kvA6PGenk4fIq/srNVoCZ7DQdyuiRUzIldRHRLQ==
X-Received: by 2002:ac8:1a56:: with SMTP id q22mr2287336qtk.386.1568372671331;
        Fri, 13 Sep 2019 04:04:31 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id t199sm13147606qke.36.2019.09.13.04.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 04:04:30 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <fdec5a56-8337-4cfb-4d07-425e8785102d@gmail.com>
Date:   Fri, 13 Sep 2019 07:04:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912235427.GE22121@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-12 19:54, Zygo Blaxell wrote:
> On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
>>
>> Quoting Chris Murphy <lists@colorremedies.com>:
>>
>>> On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
>>>>
>>>>
>>>> Quoting Chris Murphy <lists@colorremedies.com>:
>>>>
>>>>> On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>>>>>>
>>>>>> It is normal and common for defrag operation to use some disk space
>>>>>> while it is running. I estimate that a reasonable limit would be to
>>>>>> use up to 1% of total partition size. So, if a partition size is 100
>>>>>> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>>>>>
>>>>> The simplest case of a file with no shared extents, the minimum free
>>>>> space should be set to the potential maximum rewrite of the file, i.e.
>>>>> 100% of the file size. Since Btrfs is COW, the entire operation must
>>>>> succeed or fail, no possibility of an ambiguous in between state, and
>>>>> this does apply to defragment.
>>>>>
>>>>> So if you're defragging a 10GiB file, you need 10GiB minimum free
>>>>> space to COW those extents to a new, mostly contiguous, set of exents,
>>>>
>>>> False.
>>>>
>>>> You can defragment just 1 GB of that file, and then just write out to
>>>> disk (in new extents) an entire new version of b-trees.
>>>> Of course, you don't really need to do all that, as usually only a
>>>> small part of the b-trees need to be updated.
>>>
>>> The `-l` option allows the user to choose a maximum amount to
>>> defragment. Setting up a default defragment behavior that has a
>>> variable outcome is not idempotent and probably not a good idea.
>>
>> We are talking about a future, imagined defrag. It has no -l option yet, as
>> we haven't discussed it yet.
>>
>>> As for kernel behavior, it presumably could defragment in portions,
>>> but it would have to completely update all affected metadata after
>>> each e.g. 1GiB section, translating into 10 separate rewrites of file
>>> metadata, all affected nodes, all the way up the tree to the super.
>>> There is no such thing as metadata overwrites in Btrfs. You're
>>> familiar with the wandering trees problem?
>>
>> No, but it doesn't matter.
>>
>> At worst, it just has to completely write-out "all metadata", all the way up
>> to the super. It needs to be done just once, because what's the point of
>> writing it 10 times over? Then, the super is updated as the final commit.
> 
> This is kind of a silly discussion.  The biggest extent possible on
> btrfs is 128MB, and the incremental gains of forcing 128MB extents to
> be consecutive are negligible.  If you're defragging a 10GB file, you're
> just going to end up doing 80 separate defrag operations.
Do you have a source for this claim of a 128MB max extent size?  Because 
everything I've seen indicates the max extent size is a full data chunk 
(so 1GB for the common case, potentially up to about 5GB for really big 
filesystems)
> 
> 128MB is big enough you're going to be seeking in the middle of reading
> an extent anyway.  Once you have the file arranged in 128MB contiguous
> fragments (or even a tenth of that on medium-fast spinning drives),
> the job is done.
> 
>> On my comouter the ENTIRE METADATA is 1 GB. That would be very tolerable and
>> doable.
> 
> You must have a small filesystem...mine range from 16 to 156GB, a bit too
> big to fit in RAM comfortably.
> 
> Don't forget you have to write new checksum and free space tree pages.
> In the worst case, you'll need about 1GB of new metadata pages for each
> 128MB you defrag (though you get to delete 99.5% of them immediately
> after).
> 
>> But that is a very bad case, because usually not much metadata has to be
>> updated or written out to disk.
>>
>> So, there is no problem.
>>
>>

