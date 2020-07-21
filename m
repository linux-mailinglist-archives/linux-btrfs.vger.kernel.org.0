Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244322873F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGURZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgGURZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 13:25:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5DC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 10:25:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k18so20133115qke.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fiDLK+SfKzcs1L04SQJ9mGhO7RcDoC6wQTE5ac8Qu4k=;
        b=a4LNlhpv6p9i9UZOsvlZJNuBl2HbW3atBVZqkG3Q+vomwTg8xntyWD50a1JB3V/eOE
         qwehBH6qwbr1q5FbjDmsZPZeGhHJf03pBW0S4V5fbiFOAhymzDycOzzwEWqcnty6Tvf3
         NKPQikpPRVD4GauG4RAI1Vy6dH3r7VE7IPEPUFECJ8XuMlrZPfEnYnJuOzQ9c9nHmrTz
         7/2Xhh+4VMPPYvSxX+XiuNVWft8Q8jbNFJSL9vN0ulVY9JDqyXfw3znT2bzLxt+HYP6G
         rTNAWzRmyKR+NSxKR+xsOyabEN0W1jw9hACiRtXGoIyGZfuKwLLJHwvl+QUEI7+ZHHKh
         U01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fiDLK+SfKzcs1L04SQJ9mGhO7RcDoC6wQTE5ac8Qu4k=;
        b=ISSae2WGDmCzM1/Z69E5+mGtNAmw7gnF06Qw39JEw+zJvL0QavHZX7WgXlYV/N/sXD
         Ay0zi5bGVhZL5+qRuBt2OE6D7WvhqSsmrQ/ynrZ+BGbkDsy4xDpsRH6rZ4Qn9G8E73Wm
         q7My7uhlPlzBps8ILGSLb/VIFYKlyHzHyrBBBchDh2lPdhmKaCRzULQV12FL4PRvbY/d
         R3NXXaINoUMVgPfHoi0l4IcvIvYDxUvNE2RNdr3RzRki0EaIaXuW5CoRkmMX5fZCcpYz
         o+zkX4YCVkGZSh09apnI0ShLvBUO7sHT3Gb2pi/jmcQgK5x/m8qwcY66AbrAvbWyoq76
         G2TA==
X-Gm-Message-State: AOAM533Nb/BOXHfcjuFd3ZCBlnz+z1DN8Uo/rHLId6r8kj5C9f8vndkd
        nkyuaVYHdjixHFSHE/RyZOV/szouJ8Xhog==
X-Google-Smtp-Source: ABdhPJx1FbMwrzOI1Z9XekzG3JSUsw0WF0PAuiCOW0T59nN8CY5iK2kammT3C39hyh8zAQiY3aPvZA==
X-Received: by 2002:a05:620a:4151:: with SMTP id k17mr28605797qko.305.1595352320696;
        Tue, 21 Jul 2020 10:25:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 6sm2810924qkj.134.2020.07.21.10.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 10:25:19 -0700 (PDT)
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
 <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
 <20200721171626.GP3703@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c2a212c0-3828-5860-2a3e-c190303aabaa@toxicpanda.com>
Date:   Tue, 21 Jul 2020 13:25:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721171626.GP3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/20 1:16 PM, David Sterba wrote:
> On Tue, Jul 21, 2020 at 04:56:55PM +0100, Graham Cobb wrote:
>> On 21/07/2020 16:10, Josef Bacik wrote:
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
>>
>> Am I the only one who dislikes the name? "onlyfs" does not seem at all
>> meaningful to me, as a system manager - the people it is apparently
>> aimed at. I really don't understand what it is supposed to mean and it
>> sounds like some developer debugging option or something.
> 
> No, you're not the only one. Changelog points to 'skipbg' as poor naming
> choice but 'onlyfs' is IMHO just as bad because it's supposed to be used
> by users so the naming need to take that into account.

I'm not married to the name, I think its awful but I had no better ideas nor 
suggestions from the last time I posted, tho I'm partial to 
rescue=allthefuckingthings.  However I'm fine with rescue=max also, is that 
everybody's favorite?  Thanks,

Josef
