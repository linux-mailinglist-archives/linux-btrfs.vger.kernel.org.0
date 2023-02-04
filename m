Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0D68A888
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Feb 2023 07:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjBDGK1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Feb 2023 01:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDGK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Feb 2023 01:10:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09507677A8
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 22:10:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so20921273ejc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Feb 2023 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZsP/A5W//NSQmt+dXNo7kJJYSdEoEWn3CqfY8Jhze0=;
        b=QtO/3mFI5hEHu422omNXgQ3X00xzScI/IOekvrUAGTgny8hUvqsaCOPO1qikN5aSWv
         aEujRUtvuP66YoUCmWc9WdVDAZNvJK6MP7MDq0O6rfYVwOkBzTeShlN5bo8E78Op8rPe
         1ies6Nzbe2wqmkcQP92xsA38rs09W+g7Y88H195XGhnGqSOTaoY7thyr6ZqWHW349Fz5
         0YUuui6eUuwuuZiFCn/tQueoszto5ug7stC8usdnUyNGbExuk+1SHimqTpNFEy+i8Rdz
         kYouxujt97aAFBnDey7IMKKQjZzTbAKXCYPcWfq45OABfTMxOkb3cEprWZMwHJAJ0q4h
         Ca6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZsP/A5W//NSQmt+dXNo7kJJYSdEoEWn3CqfY8Jhze0=;
        b=4Kbfo0SECNO37eTlKIklVJW4Ticgf64bre3kC/jR/Fxers8dlb2jFFv64CYP3SbwND
         +sWYlwI5fm3vZ8Lv6B8EjpEb9qD09GikSopwpkT/2odrayb1R5D1GdRrc4OaOIDwjNBa
         H1YNJk4USYAVA9jSlZ9ig0pL3i/VOzH6ePlNJQ4RGRExaJjFtFqSK6hSaiuUQ4kTCwUT
         wahK++Ptc+OkBFAL7MbHhl4E6dCZd//25Af6t8Ka1aONXku4vFDokmgRfKIb0O1l5geJ
         hwGT9KcE+ZIo1tW9LG7nKCtVPLxMbsQB483WTkpyqY26RDID8o5IC0ZUhGWSwSonNQIh
         soZA==
X-Gm-Message-State: AO0yUKU9bDQPd8SNfdvlQ+B/zCjHSRHFVx/BAcEqleAZMdm/4FvJe8Lc
        n38KMvIzUF/MVqLuAIzTr0Plhs+SfjA=
X-Google-Smtp-Source: AK7set84uYIk3eQ4zbJKTlSB4pf3wWQJc2QZD2VHw0VArJxH7CVDXI3Wxm8Qcg4byokWHRL6DjjaRg==
X-Received: by 2002:a17:906:6b1b:b0:88f:1255:59c with SMTP id q27-20020a1709066b1b00b0088f1255059cmr9110992ejr.1.1675491023456;
        Fri, 03 Feb 2023 22:10:23 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:2aaa:4bd4:1a4f:38f3? ([2a00:1370:8182:1876:2aaa:4bd4:1a4f:38f3])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b00880d9530761sm2363467ejr.209.2023.02.03.22.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 22:10:23 -0800 (PST)
Message-ID: <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
Date:   Sat, 4 Feb 2023 09:10:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: back&forth send/receiving?
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.02.2023 19:42, Christoph Anton Mitterer wrote:
> Hey.
> 
> I've had asked[0] this a while ago already and back then the conclusion
> seems to have been that it wasn't (yet) possible but could in principle
> be done.
> 
> The idea was that one main usage of btrfs' send/receive is probably
> making incremental backups.
> 
> So one might have a setup, where a master is send/received to multiple
> copies of that like in:
> 
> master-+-> copy1
>         |-> copy2
>         \-> copy3
> 
> with those all being different storage mediums.
> 

Then you do not have incremental replication and your question is moot. 
Incremental btrfs send/recieve is possible only between the same pair of 
filesystems.

> At some point, master's HDD may e.g. break or at least reach an age
> where one wants to replace it with a new one.
> So either one would make e.g. copy1 the new master, or buy new HDD for
> that, while keeping all the other copyN.
> 
> Problem is now, how to best continue with the above schema?
> 
> Either one just uses dd and copy over the old master to the new one
> (keeping the very same btrfs).
> This of course doesn't work if the old master really broke. And even if
> it didn't it may be impractical (consider e.g. a 20 TB HDD which is
> only half filled - why copying 10TB of empty space).
> 
> 
> What one would IMO want is, that send/receive also works like that:
> a) copy1/new-master-+-> copy2
>                      |-> copy3
>                      \-> copy4 (new)
> 
> b) once:
>     copy1 ---> new-master
> 
>     following that:
>     new-master-+-> copy1
>                |-> copy2
>                \-> copy3
> 
> 
> Did anything change with respect to v2 send/receive? Or would it be
> possible to get such feature sooner or later? :-)
> 
> 

You seem to misunderstand how btrfs send/receive works. There is no 
inherent relationship between copy1, copy2 etc nor between master and 
copy1, copy2, ... As mentioned as each copy1, copy2, ... is on separate 
medium, each one is the complete copy of master and you can make new 
complete copies as you need.
