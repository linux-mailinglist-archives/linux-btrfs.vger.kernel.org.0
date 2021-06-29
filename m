Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751713B7725
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhF2R06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhF2R05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 13:26:57 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB4C061760
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 10:24:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id f5so11455496qvu.8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bsoBCoBbWm9paaTgsCw2KJ7dRNoIiIvzwvpYNO6VbeE=;
        b=VUAQZxJ6J2VkeoSockQ8YMVsOM/sTeZFrW+uWBlwlYejBKktw6pbRPzCgJhmV6dP9M
         8uixZFw6+1DvaZfAM38IDqFRWVzAGDXbcVT5V8cUeXHiYh9dvZduGc5DilcYOKY0Aa/n
         CGZdutDcPz8eA9coPZQvoQNzRCxw+nP3YnQ5eR/WESQormYQfgkFSFpqlDA/XS3hOBce
         GpSc9Q1sY7sr11aTyCl1Z9Myhe6WszS9426tJgs4/SK2p7z/JfxtK5EtWpQ33PciGWEd
         D4XdhiipK4OqAtsCdQqppZY765ihVzImMbmfoH4bFoibkGnJgX52sCbdEWjVAgxlDDcr
         3DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsoBCoBbWm9paaTgsCw2KJ7dRNoIiIvzwvpYNO6VbeE=;
        b=tIeuDDMzqBAU7wzHIg/XFPut/VBgnJNmMMy80dqBe4TT7w/LbFOql27ROEdklCyxvZ
         pjOt6/vAuayk5/vNgKLMaNLqMOuqdeoVRCZgW5QStCB6VVbv9UT7yZyHN00tAM0sOHOA
         vU01TvX8RmzYj9tK973sBYPvaKPlchfW+NTGUULCrrQmnzozGNqKeYPc49/IO+68oTVX
         ZYY/efDRhVfgeG+Rcm3LJim7wKEOmT4xZ9GC+Kxv5YfCIq0ndXvhN2EXM2T/UHHnxorP
         sYbvV/SISgqBUKkQ2L0ZA/9sD+32byvx7G2EHI5f1zsSGhB8fVihtqzAYi3/dI28f6NP
         TxKA==
X-Gm-Message-State: AOAM532lRaxczL1nvLsNJasDT0Tbqeii6M1KiMHdtnQqSE5n07JngaKA
        sQFajEZLCZ7hyiJjTZtQA3FsnA==
X-Google-Smtp-Source: ABdhPJxKjXyJMSnDBVoAeREpzwPOHtksXWllHCV11xPEpEVP1OjWafoBcvcWVyZpdnBdWKt5zhz6yQ==
X-Received: by 2002:ad4:4ea7:: with SMTP id ed7mr29830995qvb.1.1624987468822;
        Tue, 29 Jun 2021 10:24:28 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k19sm7930456qta.90.2021.06.29.10.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:24:28 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
Date:   Tue, 29 Jun 2021 13:24:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
> Dear BTRFS folks,
> 
> I am hitting a potential regression of btrfs, visible only with
> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
> instances (x86_64).
> 
> Tested:
> v5.8 (Ubuntu with our stable patches): PASS
> v5.11 (Ubuntu with our stable patches): FAIL
> v5.13 mainline: FAIL
> 
> PASS means test passes on all instances
> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
> fails on 32 and 64 core instances (did not test higher),
> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
> Standard_E32s_v3
> 
> Reproduction steps:
> git clone https://github.com/linux-test-project/ltp.git
> cd ltp
> ./build.sh && make install -j8
> cd ../ltp-install
> sudo ./runltp -f syscalls -s fallocate05
> 
> Failure output:
> tst_test.c:1379: TINFO: Testing on btrfs
> tst_test.c:888: TINFO: Formatting /dev/loop4 with btrfs opts='' extra opts=''
> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file7 size 76896492
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file8 size 72228649
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file9 size 36207821
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file10 size 81483962
> tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
> fallocate05.c:81: TPASS: write() wrote 65536 bytes
> fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
> fallocate05.c:114: TPASS: fallocate() on full FS
> fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
> fallocate05.c:134: TFAIL: write(): ENOSPC (28)
> 
> Test code:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fallocate/fallocate05.c#L134
> 
> See also: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1933112
> 
> Other FS tests succeed on that machines/kernels. Other file systems
> also pass - only btrfs fails. The issue was not bisected. Full test
> log attached.
> 

Also it looks like you're using a loop device, the instructions you gave me 
aren't complete enough for me to reproduce.  What is the actual setup you are 
using?  How big is your loop device?  Is it a backing device?  I had to do -b 
<device> to get the test to even start to run, but I've got a 2tib ssd, am I 
supposed to be using something else?  Thanks,

Josef
