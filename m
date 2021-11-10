Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50D44BAD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 05:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhKJEdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 23:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhKJEdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 23:33:04 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6ADC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 20:30:17 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p2so2134485uad.11
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 20:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=288SklEmePNUjDw6X58uCbfu5jCc+wuf60uAAW5AEKE=;
        b=nd0eJBJCpQ7fAQJkf1OqnpwN9irrF0CbB1vM4Dd5ax7moMoXTPPApOfQ2+EM1wZ1Zg
         wiG4dEsWh79Ja2gw3aPareqUgk4iiyeLhCIXbe6sHr1Ky7zrdLta29VZb2T+izqqZhSH
         J+GOd9BEoNk2D1wLQM58+jTs+A19Y3quNB9wzBn6t8O8M+5mHSqQHrxHTpqzEyTX/h14
         zM1ViRDximDyyt9D7yJEs7tc3GA8xnhXl8rGdGN24kIzZqMSQa6axSi8Ina9iZn4hlDf
         c/GivDx71k11P/pyWSqbjvDFqhtrgpLSbb13TrcfYIIg/NmbnBrpLDRgtrWg1MzugNwZ
         TnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=288SklEmePNUjDw6X58uCbfu5jCc+wuf60uAAW5AEKE=;
        b=ScPWvAsteaqBmeo4H8n3LdF2JqgEpUzjWXLwIx2a7uVpWVsehMDgov/2fjKp9rxPhB
         XrsQv4hoDRu1mc9TsRa0R6GTRcx+MngnVVteYtbdOtFoqIXheAizgvqbeebeh5u+pFfq
         w+gVK3Gssq4OwexezX1FU7oXL7Z6DtJ0025H2OLgEnXSyWt9Rk3NPETmo35hDnUStxyt
         NMF1ixYVgJDnFAdoOQECMLQCPnWOINuelY8WnZd6VQ8AeMZY9kK0UIV+moJuSvmOGzJm
         S1oIlqWG0jSz2gosz5bNnkCHLmkenoa75pgyC1bnrPdWAJ6j6hdcY6KMVDzXCzQdYI//
         t+8w==
X-Gm-Message-State: AOAM532sdhdNwGKQLBR+Ge09VDugvzobqU0G/f4qwMPDwkd44EYt19DT
        r/LuyS+WLUGt+sHhBKg2ZBYfOW3BBJM=
X-Google-Smtp-Source: ABdhPJwgKgkPNFb0CDdpe9nxzd7dprorjPdUxKxJN69WauMBdb7TMNaPXK+Pt+xwIkIyZuzLg0qyMw==
X-Received: by 2002:a67:e0d6:: with SMTP id m22mr20027644vsl.15.1636518616375;
        Tue, 09 Nov 2021 20:30:16 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id d22sm3547473uan.15.2021.11.09.20.30.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 20:30:15 -0800 (PST)
Message-ID: <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
Date:   Tue, 9 Nov 2021 23:30:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
From:   "S." <sb56637@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
In-Reply-To: <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks again for your help Qu.

> There is a user space tool, memtester, which pins down a large chunk of memory, and do tests in user space.

I see, thanks, I'll try that and report back.

> Yep, exactly the problem.

I'm not very familiar with the low level functions of Btrfs. Could you please help me understand what went wrong? Assuming that this isn't a bad RAM issue, is the the filesystem in the same state as it was before the OS upgrade, just with a more strict kernel now that doesn't like the bad blocks? Or did the tree get damaged during the OS upgrade process?

> And you haven't yet recevied any subovlume, it would be way much easier to rebuild the tree.

So should I wait for a btrfs-progs update? I'm not sure how to build it for armel. Any idea on the timeframe?
I assume that `btrfs check --repair` is not an option?

Thanks again.
