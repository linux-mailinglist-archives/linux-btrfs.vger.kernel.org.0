Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B1362DD9
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhDQFTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 01:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhDQFTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 01:19:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC46C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 22:19:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g8so48027577lfv.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wwwkAb5rNqv8paIW4jdkMxuchTrhRlc4eRl0nXP/J/A=;
        b=Nwq5Ue59InK0/ucaTBsFjvwLiWqm3+Cx+NY/pztd/R1VPg1Y2fyKXr167BE7KOTpfz
         vAh0m/XhC8Wf7TeA2uyF4bez4QRWUh8VgN11/qWSHVnw+6546COxtUQaeAJ4A9IpXaK3
         jl2EFkom1as+REZ4K+cbfgo3VsOtu4525qkENVKE99F8aUqbeCqI3HwJINcZRvEdBKJz
         8MjV8LQ/buIc0UzV+uJ1RUzN/2W3XlV5VZrkRFqbhCILjjrXwgZS/AGZUc2XBFma/+Z0
         bSTf/eg1xUt5zFR/YUeWkO6YpjbXFkQdMd/kqahfWTMa8qFDnU8bUzRTta3jtiMq2Ml7
         pR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wwwkAb5rNqv8paIW4jdkMxuchTrhRlc4eRl0nXP/J/A=;
        b=CYAWqRPKP38n3EiUDB2tLaBql8dfMG6Me8dK84JQFF81Yyuxqn2jqYFv05X8jHdxOS
         MfchHiO67hbO+sdWK4NKn9lEQR0TyDTwHGuaHbGvqOGH/+OHvKhRdqnEIYm36S2dRvyK
         TVygqzObs67jxJmdGk0xzWN6IjHeJkzVBxuUSBWD+flVWUiyH8mdTYF1ne9kqFK8nlm0
         Q8bmiERWzJ4u8wRYo/8sWDR0VxrHl0sGYSnYj+JIWYHxRNC/NoHm+9yixX0wuJCdg0tr
         sCSmcFl4VPcZXc1Ar+8V9IArTErLihC5rid4Ne8PTjzIDA73FL+JwZQQiM3vLstso9Me
         ddaA==
X-Gm-Message-State: AOAM531KZShwKUP5iVRbLrzklrcX8z3DOA+2di4MKQLEEiskQjRTlfKV
        CTgC4LOwAxK1f06So6SUxrPOjK3c4xhQRQ==
X-Google-Smtp-Source: ABdhPJz21X7pcJPHSJx8n+n6ZI+t3JmCVbiSiUgO7jEG0fTQfcgubJs6cBoFO7E6OCNInR4UB7tGfg==
X-Received: by 2002:a19:ee04:: with SMTP id g4mr5083774lfb.395.1618636749706;
        Fri, 16 Apr 2021 22:19:09 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:be19:6dbd:a91:f761:1766? ([2a00:1370:812d:be19:6dbd:a91:f761:1766])
        by smtp.gmail.com with ESMTPSA id y11sm1131950ljy.27.2021.04.16.22.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 22:19:09 -0700 (PDT)
Subject: Re: Design strangeness of incremental btrfs send/recieve
To:     Chris Murphy <lists@colorremedies.com>,
        Alexandru Stan <alex@hypertriangle.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAE9tQ0dr1+TTrALYUGfgx7tViU1tVU00OyAxkP1qsUUkyVsXPQ@mail.gmail.com>
 <CAJCQCtTD+XKZOfOi8dS13qbp7L_MUsSVt1eF6raFjsTEE3-NBg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <99fb1a43-9874-0053-b826-716675093f98@gmail.com>
Date:   Sat, 17 Apr 2021 08:19:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTD+XKZOfOi8dS13qbp7L_MUsSVt1eF6raFjsTEE3-NBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17.04.2021 06:29, Chris Murphy wrote:
> On Fri, Apr 16, 2021 at 9:03 PM Alexandru Stan <alex@hypertriangle.com> wrote:
>>
>> # sending back incrementally (eg: without sending back file-0) fails
>>     alex@alex-desktop:/mnt% sudo btrfs send bigfs/myvolume-1 -p
>> bigfs/myvolume-3|sudo btrfs receive ssdfs/
>>     At subvol bigfs/myvolume-1
>>     At snapshot myvolume-1
>>     ERROR: cannot find parent subvolume
> 
> What about using -c instead of -p?
> 
> 
> 
 Incremental send requires parent subvolume. If "-p" is omitted, it
tries to chose the most suitable as parent from those in "-c". Single
"-c" is absolutely equivalent to "-p".
