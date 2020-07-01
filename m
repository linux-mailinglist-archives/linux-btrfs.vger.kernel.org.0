Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E783B211360
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGATQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 15:16:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F696C08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 12:16:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so21737120eje.7
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wgIhaEgqjw8OzwFOKiWfntI/d98sGwOv6lEX5b0H3i4=;
        b=HOJtApZC+rgSd3Atiw+XUejksafDOHAreYro+eWsAzTbVgK3p4xgwpp0WKlsWUJ38Y
         /h1lU4oV3IIk6Z8drxkKrZZgDhc/cndHfpW4iUDs54j0CIrMM+xJRMPX87h0GLXgI1sU
         IbE9WOsprR+NGk6miWY5nHNaYxZTqkKYIbAq7K54Wwj1084Z1K6uYDSf96JNDex5ZL2Q
         h8rTH4/A4krvMgdCt7PKoPLGrILcZaoEwfnohOES6I9zk0C6P2DunL0lmLsesD/3mEDi
         8Nac+3QcrRS+SUKjftrreRKb3B4V5nULQbscVZw0OxyJOOtJQc6PahjuhGsNHVV/usK2
         NBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgIhaEgqjw8OzwFOKiWfntI/d98sGwOv6lEX5b0H3i4=;
        b=JC1fecx7l6r7dYjX+yH6fb34GBJnT24iNCvtvOxmWrpSarp9ntvmC3xDNUxGPYHxPO
         b7RH291SumDRz0XEdvcVWgWvHXq0I+Kxzvy0Rrpci5lzjmGa2TrR4om/8qxmX6VqasvJ
         7q0iEiikQbf1Ie0VQMpfxKs+E7Djm/sQy5vIxV9ZCA5mqr/fV3MH0yX4irHz7SQh4uMa
         /rPSuMNCyapithuKOSiT55gtV/bevgTBnolPVWsk+Bk50cvszvuxRJtsja5wvxKzDBAH
         teosC6fUIbdPr1ZFukBts2nwNyFJOM7L18Lnt90irUPs1Y/HN0QFVZc5QjBwYuw9PqhY
         hIPQ==
X-Gm-Message-State: AOAM531ZOqH7/qZ8CFzZbYkRa7tQaBKdDn4JGtJV1vqThrb6QVilSMek
        VBk3e/wxM2PLnaFdcpuNNCY=
X-Google-Smtp-Source: ABdhPJxq1OShxcYa26dlh0tmlCau0SS7jtO/boX+MdYu9jevHDmQCLKeRhPwrdVEP8qZ1rxKWcACzg==
X-Received: by 2002:a17:906:1751:: with SMTP id d17mr8008969eje.140.1593631017339;
        Wed, 01 Jul 2020 12:16:57 -0700 (PDT)
Received: from [192.168.1.230] ([151.68.150.40])
        by smtp.gmail.com with ESMTPSA id t21sm5083376ejr.68.2020.07.01.12.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:16:56 -0700 (PDT)
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     dsterba@suse.cz, Lukas Straub <lukasstraub2@web.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200701172218.01c0197d@luklap> <20200701153919.GD27795@twin.jikos.cz>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <17ef97b5-ef27-f56c-7b86-c22f9036d253@gmail.com>
Date:   Wed, 1 Jul 2020 21:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701153919.GD27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 01/07/20 17:39, David Sterba wrote:
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

Eh. I'm sure stopping boot and dropping to initramfs shell is a great 
way to get someone's attention.

Afaik in mdadm or hardware raid the main way to notify the administrator 
of issues is sending an email, or send the error through the server 
fleet management software.

-Alberto
