Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF939CFF9
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jun 2021 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFFQRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Jun 2021 12:17:22 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:46990 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFFQRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Jun 2021 12:17:22 -0400
Received: by mail-ej1-f45.google.com with SMTP id he7so2977062ejc.13
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Jun 2021 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYsKFgY14WXsyPASl+GzXiQLluRA3lnZgGmCrYNQ3nI=;
        b=CPBc9crKmdAkanrl33XGF2i5Yff7vrKUo7P+W4SUpKnYf28TYwF/gDOyCS2flXc5Ci
         ZYC3GDG5RxRqNV9EoBA4fzezkrvaEnXLtipng0ZmCb5XVuPrSGCl2PGZFvtXFAGvs5tn
         CbmoBHIhV5F0s3LH9baLfO0WLxaVMkdQn9Qvs3SkdgH8XQqJxZqMLnedhrR6mPfonEaS
         E05xiDK6YuM3xIZzUBVbzstiVcK9XhrBomrId7IxEBS6IFlB71pJ7AHB8VQA2Z2MuvMF
         LYQLCo6+5K8UltrB6qu5E7rnMDxNZ9sxkS51I5PpHNMM13ngswLEVD6+0thPfJTeeOCW
         fBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYsKFgY14WXsyPASl+GzXiQLluRA3lnZgGmCrYNQ3nI=;
        b=bPuyv6/+NhK6m8b+j7jCHzhrAhju3OUr6v9V/MPPAboO0svVNDqhIqkUAvjkww9QHg
         0dAwdLYyLjSmSLgO6Um80SE/K8PcdJPc+lwpHj3F2nib+7SGRk96qBqs07WAtcHQ0Sis
         r7x5wDJSQNKR0gtK7rk8C2Jb1Z5+stJsuo0IEdkmTxSQVFj9ihpeUdR1Atsee3d+kR4Z
         Bpg/pW2h7NnfZuJ6oSCp3E2XAQ1DsxcLOPEftO4O/N7rQq0aWZv4VH+FT2TxnJ4Ox3Nk
         hYCLTh7PvIHBl01s3VMokSadx0DJmVedKrVXi3KyI1TrXIjDgFM1vy56PgYVRDHYg6c3
         hwIg==
X-Gm-Message-State: AOAM5335sVNLSGt17/s7M/J/IjIdOBuSuRphb6lURI8fYO7iXGYdUphQ
        zA1BAH02nus5kKQcWdp/V6O9692iggwkDA==
X-Google-Smtp-Source: ABdhPJy89IpVfk7KvvUURVeJF8NpGIWbXIwXTMSrWXnciO3mVlv7+VkkBTQL2FUE6sNaetNn/7t33A==
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr14373420ejs.501.1622996071622;
        Sun, 06 Jun 2021 09:14:31 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:49a8:ce9c:c8c2:9458? ([2001:984:3171:0:49a8:ce9c:c8c2:9458])
        by smtp.gmail.com with ESMTPSA id t18sm6543480edw.47.2021.06.06.09.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 09:14:31 -0700 (PDT)
Subject: Re: Corrupted data, failed drive(s)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
 <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com>
 <5272b826-ec8e-f3a3-6fc1-bb863b698c83@gmail.com>
 <CAJCQCtTdZ6LiYQPi-tb95auE1K1bxJ04iDPbu03k4W-Pu5xbEA@mail.gmail.com>
From:   Gaardiolor <gaardiolor@gmail.com>
Message-ID: <ef0c254b-fd33-97ec-c9eb-c312ba755655@gmail.com>
Date:   Sun, 6 Jun 2021 18:14:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTdZ6LiYQPi-tb95auE1K1bxJ04iDPbu03k4W-Pu5xbEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ok.. the memtest looks kinda bad. I'll replace the memory.

memtester version 4.3.0 (64-bit)
Copyright (C) 2001-2012 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffffffffffff000
want 20480MB (21474836480 bytes)
got  20480MB (21474836480 bytes), trying mlock ...locked.
Loop 1/10:
   Stuck Address       : testing   1FAILURE: possible bad address line 
at offset 0x123547370.
Skipping to next test...
   Random Value        : FAILURE: 0x6f77d4f5f77d938f != 
0x6f77dcf5f77d938f at offset 0x12186fd48.
FAILURE: 0x3c98d79170ce341b != 0x3c98df9170ce341b at offset 0x12186f570.
FAILURE: 0xb4825de59a0a714f != 0xb48255e59a0a714f at offset 0x12186fd48.
FAILURE: 0x2d9a7833948a2798 != 0x2d9a7033948a2798 at offset 0x123547370.
FAILURE: 0x6a2a69b98088822b != 0x6a2a61b98088822b at offset 0x123547470.
   Compare XOR         : FAILURE: 0xa1403b114589b90a != 
0xa14043114589b90a at offset 0x12186d068.
FAILURE: 0x3daddd6882cfbe3a != 0x3dadd56882cfbe3a at offset 0x12186f570.
FAILURE: 0xb59753bcac0bfb6e != 0xb5974bbcac0bfb6e at offset 0x12186fd48.
FAILURE: 0x2eaf6e0aa68bb1b7 != 0x2eaf660aa68bb1b7 at offset 0x123547370.
FAILURE: 0x6b3f5f90928a0c4a != 0x6b3f5790928a0c4a at offset 0x123547470.
   Compare SUB         : FAILURE: 0xde4d93737a22df84 != 
0xde4d83737a22df84 at offset 0x1526bde8.
FAILURE: 0x27a753236cf59e0a != 0xa72b5b236cf59e0a at offset 0x12186d068.
FAILURE: 0x37a9842273eb3b3a != 0xb8257c2273eb3b3a at offset 0x12186f570.
FAILURE: 0x5b272e785db2d26e != 0xdba326785db2d26e at offset 0x12186fd48.
FAILURE: 0x525adbd6a6f91d37 != 0xd2d6d3d6a6f91d37 at offset 0x123547370.
FAILURE: 0x54acab2f98eb914a != 0xd528a32f98eb914a at offset 0x123547470.
   Compare MUL         : FAILURE: 0x00000000 != 0x00000001 at offset 
0x12186d068.
FAILURE: 0x00000000 != 0x00000001 at offset 0x12186f570.
FAILURE: 0x00000000 != 0x00000001 at offset 0x12186fd48.
FAILURE: 0x00000000 != 0x00000001 at offset 0x123547370.
FAILURE: 0x00000000 != 0x00000001 at offset 0x123547470.
   Compare DIV         : FAILURE: 0x7dbef883f67eecb7 != 
0x7dbee883f67eecb7 at offset 0x1526bde8.
   Compare OR          : FAILURE: 0x7db63883667e6c91 != 
0x7db62883667e6c91 at offset 0x1526bde8.
   Compare AND         : FAILURE: 0x7ee6329401ea8682 != 
0x7ee6229401ea8682 at offset 0x1526bde8.
   Sequential Increment:   Solid Bits          : testing   1FAILURE: 
0xffffffffffffffff != 0xffffefffffffffff at offset 0x1526bde8.
FAILURE: 0x80000000000 != 0x00000000 at offset 0x123547370.
FAILURE: 0x80000000000 != 0x00000000 at offset 0x123547470.
   Block Sequential    : testing  16FAILURE: 0x1010101010101010 != 
0x1010001010101010 at offset 0x1526bde8.
   Checkerboard        : testing   0FAILURE: 0x55555d5555555555 != 
0x5555555555555555 at offset 0x123547370.
FAILURE: 0x55555d5555555555 != 0x5555555555555555 at offset 0x123547470.
   Bit Spread          : testing   0FAILURE: 0xfffffffffffffffa != 
0xffffeffffffffffa at offset 0x1526bde8.
FAILURE: 0x80000000005 != 0x00000005 at offset 0x123547370.
FAILURE: 0x80000000005 != 0x00000005 at offset 0x123547470.
   Bit Flip            : testing   1FAILURE: 0xfffffffffffffffe != 
0xffffeffffffffffe at offset 0x1526bde8.
FAILURE: 0x80000000001 != 0x00000001 at offset 0x123547370.
FAILURE: 0x80000000001 != 0x00000001 at offset 0x123547470.
   Walking Ones        : testing   0FAILURE: 0xfffffffffffffffe != 
0xffffeffffffffffe at offset 0x1526bde8.
   Walking Zeroes      : testing  44FAILURE: 0x100000000000 != 
0x00000000 at offset 0x1526bde8.
   8-bit Writes        : /FAILURE: 0xedd92db03fefa26d != 
0xedd925b03fefa26d at offset 0x123547470.
FAILURE: 0xf9f71c7056ff1fdf != 0xf9f7147056ff1fdf at offset 0x123547b30.
FAILURE: 0x8df1a5abeafa39de != 0x8df1b5abeafa39de at offset 0x1238d27e0.
   16-bit Writes       : /FAILURE: 0x7fbaade47b7d6b03 != 
0x7fbaa5e47b7d6b03 at offset 0x12186f570.
