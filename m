Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E52E2179
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 21:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgLWUfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 15:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLWUfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 15:35:14 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7EC061794
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 12:34:34 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id u21so187277qtw.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9T3wKGRitBAV2Lp4QivasLLJhzL4dE3mETmQRZxob5U=;
        b=OHqRIr+h9EmbMG3EvIAz9FngHewcOUBfo1/b+LW+1oHeV8VW48WVdStTB3c8JVj4Ip
         qS+7AT5mP/CkyR0QAXsEqnfeDAZV61CxzVS2i5TKYnTJK3vNAN/SFeVK6rxBHmrmrige
         OxQ8wLmYbx95P0TmeusLg7acr2ro4C31Fo6tPN9rkcmfw4DqbNrBHXgwcTm5wE0SDWg1
         caKIqCG751W04hhEvlc2jxipZsHhnfmnC7C35lSIQN9C127EZIzrjVAEVwXKv5YsXasI
         /BeBoisJfOdFk3R+vBQW+ufx4cvUofGFJULIX9agSROlXf1XpjthPn5NvREiHPiOHHx6
         XBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9T3wKGRitBAV2Lp4QivasLLJhzL4dE3mETmQRZxob5U=;
        b=Ddb55ad24NbgQfVoSCmnMNFoO9zaJ2nzyvTtAPVGLF8UtP4MJzQEceQkDOoNIcKNBI
         aUWbNgfOztHp3voZ4KOmPJTev9TaCQoDAzvstfI4eUKYKiFpA4IpEBD892m7wqqdBaup
         6zKeGGRHryY2PcDAuZYcoTpKz54sZ2YgXMulePmxFPQtKD0tDDGUQOgWzyrEQcG1P4Id
         9Pb80GEnChwjP57L0Wr4SDV3veGKniRCD9qXdRNWOP99GM8TLLks0cvejilhJfqP1OcK
         KvX4i4WLGHFLlUqhoQMq7gMbz0xsRBm7ZvXnfNRaFg9kXhkB0kZc7lebtPUQDh1s0J0c
         bV+A==
X-Gm-Message-State: AOAM532SLWtgwPf6yL605B7v6abedtRfgqi7Zj+MPA6bI0dU6pESAsOH
        onxrNYefBjMCxC7x1jtM55ef1UlVSVkV+tRR
X-Google-Smtp-Source: ABdhPJx+C5Z++JYZ9URsWM3SwYzbF4mOt8EM0QraagPUPQk4gP7tS5ShyuOrhQpMZP1/0Y2d31m0FA==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr26594443qtr.155.1608755672821;
        Wed, 23 Dec 2020 12:34:32 -0800 (PST)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r128sm16031269qke.94.2020.12.23.12.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 12:34:32 -0800 (PST)
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        rene@exactcode.de, linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
 <0382080a1836a12c2d625f8a5bf899828eba204b.1608752315.git.josef@toxicpanda.com>
 <276b374f-57fe-f354-9571-9f76d743785d@applied-asynchrony.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <908523cc-e5df-490c-4735-302e11f841c1@toxicpanda.com>
Date:   Wed, 23 Dec 2020 15:34:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <276b374f-57fe-f354-9571-9f76d743785d@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/23/20 3:31 PM, Holger Hoffstätte wrote:
> On 2020-12-23 20:41, Josef Bacik wrote:
>> Could you give this a try?  I'm not able to reproduce the problem, but 
>> I'm
> 
> Since I wanted to rule out NVME/block layer/scheduler etc. I tried and
> could reproduce it immediately, see below. Didn't notice it earlier since
> most of btrfs is read-mostly.. :(
> 
>> testing inside of a VM.  I'm in the middle of Christmas stuff, but 
>> I'll get
>> ahold of a giant machine at work tomorrow and see if I can reproduce 
>> there.
>> Meanwhile can you give this a shot?  I have a sneaking suspicion why 
>> it happens
>> on your baremetal and not in VM's, and this will be a partial enough 
>> of a revert
>> of the patch you bisected to validate what I'm thinking.  THanks,
> 
> The patch doesn't apply to 5.10.x since btrfs_start_delalloc_roots() 
> does not
> have the trailing true/false argument yet. I removed it, which seemed to 
> have
> worked. :}
> 
> Results using -dsingle/-msingle/space tree, all on tmpfs:
> 
> Unpatched:
> 
> kernel tree, ~1.1G:
> $time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
> ( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.37s 
> user 3.26s system 6% cpu 52.144 total
> 
> -> slow as hell since it's thousands of small files. Writeback runs at 
> ~5-10 MB/s.
> 
> large file:
> $fallocate -l 2G /tmp/largefile
> $time (cp -a /tmp/largefile /tmp/butter && sync -f /tmp/butter)
> ( cp -a /tmp/largefile /tmp/butter && sync -f /tmp/butter; )  0.00s user 
> 0.91s system 75% cpu 1.215 total
> 
> -> OK-ish since it's just one big file.
> 
> With your patch & the 'true' arg to btrfs_start_delalloc_roots() removed:
> 
> kernel tree:
> $time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
> ( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.28s 
> user 2.44s system 60% cpu 4.475 total
> 
> rewrite:
> $time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
> ( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.28s 
> user 2.87s system 93% cpu 3.357 total
> 
> Clearly better.
> 
> Hope this helps :)
> 

Oops I built on top of our devel branch and not 5.10, my bad.  This does 
help and validates my theory.  I'll work out a proper fix soon for 
everybody to test, probably tomorrow so I don't risk being murdered by 
my wife.  Thanks,

Josef
