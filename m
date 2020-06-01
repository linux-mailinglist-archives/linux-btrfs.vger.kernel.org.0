Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D1E1E9DD4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFAGE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 02:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAGE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Jun 2020 02:04:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AAC061A0E
        for <linux-btrfs@vger.kernel.org>; Sun, 31 May 2020 23:04:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so387109pjv.2
        for <linux-btrfs@vger.kernel.org>; Sun, 31 May 2020 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ixIfgR76rR0lA/8CDFY6EhXkzH4KhYv9Hu5igSrAPM=;
        b=uClaMosYP42tfqb9cfhHHkvuXTQvfMuzdTPR6bcQeAXvtuqtWtEkLRGkXV8B4k8xLO
         Z78r8Hy+au+AutR/35/la/8Knv7sYn6TDknHbHhe4jKXwPi36Hju4ag+K78kqN2pbwo4
         I9rxUyxMMRoqo8tN0/MMktSLqaMJBgd538xskgZyBt/SrewdPzjOxNaGp+OMsHgD/zha
         ESrD61QAZR7efs6rsQ1Y/6sIiyoWyDA8QLU5UaDsw0DA5B5aapgB0rHciXirZJAJ24pc
         e4WKop0G58x5+gnGPBq/cUEJftOpk1iXODG2mEJWdTVaNVZRrBoAMgqrZTXRgya0sliY
         otWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ixIfgR76rR0lA/8CDFY6EhXkzH4KhYv9Hu5igSrAPM=;
        b=QQuGWGsN3qp6gE2AfHJEp0lWS8qnFjyrPqGWp4ibuW2yqS7mC1Y/8vbf5DlBcBC1uJ
         FyqdlhXa/e4uCmvHCsnx6cO0LZUd0izImtht/SLq27dbIBVGNtMmWXgyEIYxDgDTCLoE
         PXyYpG/FqsfOUfwzdAbO/eEYGSszZUAIrvpXJ76MAplq45O2fr+hhLB2JQEdfCrC9gx4
         uCQTQffDbVCG0hDg2/h0/l0XyZuBj7/kzu2ecbiOH/juZIeBXy1sUL+byyehkEfb8i1A
         Xj6ghcjGpP9SPnlvtpQ6yXTh9q4+WFO0hulYvqir0WKTOp0a117HJ68769NK0+iR7k/7
         k0nQ==
X-Gm-Message-State: AOAM530Rzjry7CZO4oL02QnVHTeiYr9TO4xHgcUDaUaGKK5m5OM11an6
        io5HNzEzqWmhUCkvrnWGa0o=
X-Google-Smtp-Source: ABdhPJw6kiycKHFCffK70j83498fb2SOL/iB3L9OWlOZOXhE+zIN7a19CaWrkKUH9pT5BZnjSILcKg==
X-Received: by 2002:a17:902:d914:: with SMTP id c20mr5524153plz.269.1590991498581;
        Sun, 31 May 2020 23:04:58 -0700 (PDT)
Received: from ?IPv6:2406:3003:2006:2288:8cce:f943:4082:634d? ([2406:3003:2006:2288:8cce:f943:4082:634d])
        by smtp.gmail.com with ESMTPSA id x77sm6770304pfc.4.2020.05.31.23.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 23:04:57 -0700 (PDT)
From:   Anand Jain <p10sonu@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [BUG][PATCH] btrfs: a mixed profile DUP and RAID1C3/RAID1C4
 prevent to alloc a new chunk
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <20200530185321.8373-1-kreijack@libero.it>
 <fc8f88a4-3812-a0dc-99ab-929b27d7530a@gmx.com>
Message-ID: <c767c663-d6b0-da5a-f065-fc1198fc319e@oracle.com>
Date:   Mon, 1 Jun 2020 14:04:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fc8f88a4-3812-a0dc-99ab-929b27d7530a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> This in facts exposed the long existing bug that btrfs has no on-disk
> indicator for the target chunk time, thus we need to be "creative" to
> handle chunk profiles.
> 

> I'm wondering if we could add new persistent item in chunk tree or super
> block to solve the problem.
> 

  +1. That will also fix the chunk size discrepancy between mkfs and kernel.

Thanks, Anand


> Any idea on this, David?
> 
> Thanks,
> Qu
> 
>>
>> [*] https://lore.kernel.org/linux-btrfs/517dac49-5f57-2754-2134-92d716e50064@alice.it/
>>

