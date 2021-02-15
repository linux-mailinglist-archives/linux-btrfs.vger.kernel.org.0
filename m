Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1B31BDA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBOPui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 10:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhBOPsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 10:48:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA60C0613D6
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 07:40:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z7so3928942plk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f/c7AxopKhgYq88HVbiWCjUeAUJ0dBNhFHxmGHWwwbM=;
        b=lox8j19K1I2RLIUQAKWZo4RSE0Eim5iLn/iLoRZRo6jme5BlD7Boqsu2md07tsUcmZ
         9JNPfViaalFm/vAoi8fh3JMFlkcdSRZ5OzWFNA4bynzwQ+iuUkVBvneJ7uokkfNEl3mM
         rHA336fWS4dYY2DrciTZEARLxwxrW8ewb3vF9dyMkg9S4XesxmmXSgT/zQobqvuQZxfX
         pDXM75WcCW0x+U+QYN5RWCeGr7ROoa1CX2HG1OQgf+5ywKbF8NyxGTrgenR5wYxq7Hdf
         1VYMW8U40P3AEelYxrjrIhk1qZm50GOY7iPhlsGh1p+9lHC8tTTg4WM0zmJ29Q6jQcOb
         kebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/c7AxopKhgYq88HVbiWCjUeAUJ0dBNhFHxmGHWwwbM=;
        b=NUKFtckJ8JwATEvhNSIOqCFo5pWMnRrqUHTwEqhDYuS3oduvMBdq+CO+JCRu3QB7k2
         7sJ7EffM6ujNZeGptwiKygsob11fho/Noxf5dnq4YlUCykgp9SNPORvGFFqDlGuIwjsG
         t+HqfU9Q1WKBH2ktypU2P1QWfClMnWtGKjSTDKrs2UxWZyXBSM108XzlHNXqY8oPY5yX
         i6ZcZql3rwgk72su78nbk4StsvQBCJkSHFdDc4kK76BJQQO4tGBJ2OWFmtQJlG/p65dL
         dfPNnQJCxvtL92omosWxOjYlZlZF4TkgWqSn58wUh9sub7gALlq8NPg9QmNmSHowwvKD
         mWtw==
X-Gm-Message-State: AOAM532p3UORhAJW7lNkIVG3IdwRkH5VOL6rVfc7f+bYuk4k2TrLLfHu
        QjB9KiYwALDrv9FFHwRTsOvfIRcB36sx3Q==
X-Google-Smtp-Source: ABdhPJwdUr95NCcg5kbIW6KVmAsIJ80h1I+klbqvOnKaiv1Vk1+0vQaSydRrGvkrmrJ8s8D4O68cOw==
X-Received: by 2002:a17:902:f702:b029:e3:5e25:85bb with SMTP id h2-20020a170902f702b02900e35e2585bbmr3618147plo.56.1613403602362;
        Mon, 15 Feb 2021 07:40:02 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b25sm19162358pfp.26.2021.02.15.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:40:02 -0800 (PST)
Subject: Re: [btrfs] 3d6ef82805:
 WARNING:at_fs/btrfs/extent-tree.c:#btrfs_reserve_extent[btrfs]
To:     kernel test robot <oliver.sang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ltp@lists.linux.it, linux-btrfs@vger.kernel.org
References: <20210215132734.GA15834@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fec3d91-fd37-0159-7417-0661659e2e02@kernel.dk>
Date:   Mon, 15 Feb 2021 08:40:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210215132734.GA15834@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/15/21 6:27 AM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 3d6ef82805958611e8ffa0a901c014b6f066c3e6 ("btrfs: relax memory alignment restriction for O_DIRECT")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git dio-mem-align

This patch has been dropped, we did identify last week that btrfs
needs more work to support sub bs memory alignment for dio.

-- 
Jens Axboe

