Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69344D00F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhKKCcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 21:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhKKCco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 21:32:44 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726AC061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 18:29:56 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id b3so9044241uam.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 18:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=e7vrNzHW6Nrp7HXEaQ6a0UFlEl2RCaC6DPSPVN+/5lw=;
        b=Q0sfqnpwDGmTIdq+lUzrqPvHwf5ZmwQ+LTsFtfhC9Ufi7s0Y/8lthBZHRPs2gn8T0j
         zG2bndgCerl1R4SMkcfa5kgNh6DAHNtsJHyVSSGui+LAuAOywayd849bYQLU//kEdiQd
         9j05R0jHmsZVeR5EvBbqXfsdtzpRUdzesG0XSbnewObJ7xdlwAhRjwEFKVLuIL4KTSze
         d8UCteycyHRHBTKBaPUUOkel2yzE7WwJ+6ebs5qhLqTiqM7FYTBro+RWu77H27FfKMUd
         dSUcnvJynisYlh41CRcyN/F94q6WNu9G4y2UfOivmXWFzBQ+SxL/SR+9hGWv4Mr1GpX7
         xj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e7vrNzHW6Nrp7HXEaQ6a0UFlEl2RCaC6DPSPVN+/5lw=;
        b=d+SGoQ475FqgUnVyMsUCIBGNg5aEih1bQ/PWuSx2ohkVG5YRghLoxzDLcr5d/oMEsP
         A34P/crVW0yoeoY2UqKXspny92BNtB6/7PMYqoYc8NSWq78rKfbmG3fpM1D5IuQhy1H/
         /lq72IF2e/nofUBQ+a3Zq7cMnR1XrSIG5BOX83u+zFNgMAtIFO2qEB7JOmvOTsXh7lP5
         8P9aeEqxznarMX+iBA4tHGbVysN/WgYKul7qOTcndj8+kJqS4te3JmcTDMPA8dNtODn4
         qvnMjiHS+1slf/iP8iStaT1TtonQ4QrqfqO6GH4n52sREN4ewyvl6UUA6LTu+hO3xlF7
         7nSw==
X-Gm-Message-State: AOAM532aUzmnjE62YCTsMy2AtM5eHBAOSi2VcPPHMDQpUa73ztX9m+Q0
        Zd8RYxyX7MM2Vh/Xdp3gGSjxY9MqRFs=
X-Google-Smtp-Source: ABdhPJzHPY6qbzOd2pYXULwjyq0D0HcUSzjtm163U+amPg1QyoZ0xDrmmLfSGES2hOru91S8y6yOQQ==
X-Received: by 2002:a67:dd12:: with SMTP id y18mr6328529vsj.56.1636597795009;
        Wed, 10 Nov 2021 18:29:55 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id m15sm1111139vkl.40.2021.11.10.18.29.53
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 18:29:54 -0800 (PST)
Message-ID: <91310d39-78ca-4434-86d0-a03e23bf86fb@gmail.com>
Date:   Wed, 10 Nov 2021 21:29:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
 <4f7be37a-502c-6ee1-2519-29b84810999c@gmail.com>
 <725543aa-029d-c22e-0ac8-bc77637c0474@suse.com>
From:   "S." <sb56637@gmail.com>
In-Reply-To: <725543aa-029d-c22e-0ac8-bc77637c0474@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks very much Qu! I just sent you the two mirror files to your personal email.
