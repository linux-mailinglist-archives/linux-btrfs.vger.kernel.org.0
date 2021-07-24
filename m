Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5D3D4886
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGXP0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXP0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 11:26:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7CC061757
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 09:06:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e21so2142894pla.5
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ef1QbYv2Z4GwpSSuoVAw1PT+hfS6KHdDDbOuJkIPzqY=;
        b=p09soylh4QDlMFNY43WitFUCCTCvkTeYCgmfr3gQigJiqxoD/kV7GqrlR1rSK3uPFD
         8kXtudhRivxuf4IJrj2iPA75ucVw4w7jCsqhYlEFUZ4Kp02VV9tmFNpU204JnrDD076j
         zL3fhXvFPUFRx8fUBYodix6r6gFUTB0BgB3r5mTpnBg1OYhT75JWSWhhX93C2WpryHUY
         9/j29yix7MS2f2P8VY0GlyygEimyW2hOZDF2axdXmt79xG9KJ2xuZ2OajY5seSnZ+r77
         ka0Ix9cdowVUDMWg5stW0U9DTy90jY7C4NHTju+y41Vcpb8g/FG9RWnScuT1U6HBYh6t
         aRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ef1QbYv2Z4GwpSSuoVAw1PT+hfS6KHdDDbOuJkIPzqY=;
        b=scVmGTmf0x7mqRyJp7pYNbjml5gpDOH4oL5Ve6tEO6FPIa0wIgav/8Ldz/Fqgqsgds
         uTtxjLLLeost/MnXbu2WbUDCSNE1gIEQU23rexZlwrFtI2BVyK08QE9J5I6l562CRkMi
         jCdhO623UgBMwHlM9VVhfqL2yWU4zm/Oc+iwr8C/LcaFvpfyaVMgepKM3EbFTgZeYtxw
         cGOFbtRXaDX7K7aluRDYa722aEg011JGymf7T88QPj6/Yg/r1/6LwW8MohmipUOClr+P
         5Sk0w3CPehmFmZRuX1/0T6jiygA28djMmvpa4RUeOlmnRsw/V0p4lReOCk9EULSvvOMg
         oRoQ==
X-Gm-Message-State: AOAM532Mkhhp7ShDWAVMGKtyHA6kzJLOouk+UFlpmOGu7ipRmK1GxWAT
        SvaOotvfK9rHsI7xSRgrF81EP2JhAIGqjkL5
X-Google-Smtp-Source: ABdhPJzxeF4nm5dwJcfROSDmQcfrM6MKpYcIBqKF7Vo9n1/dekIapcugoZ1Muxbqb34bUFNWww0zFQ==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr9974926pgk.431.1627142793682;
        Sat, 24 Jul 2021 09:06:33 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d22sm30478628pfl.201.2021.07.24.09.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 09:06:33 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724072223.GA2930@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <718272a2-de67-c849-7c6e-2232f8762b23@kernel.dk>
Date:   Sat, 24 Jul 2021 10:06:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210724072223.GA2930@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/24/21 1:22 AM, Christoph Hellwig wrote:
> On Sat, Jul 24, 2021 at 09:12:39AM +0200, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series fixes up a possible race with the block_device lookup
>> changes, and the finishes off the conversion to stop using the inode
>> refcount for block devices.
>>
>> Note that patch 1 is a 5.14 and -stable candidate.
> 
> Oh, and patch 7 is on its way to Linus via the btrfs tree.

Shall we get patch 1 queued up for next week, and then look at the rest
for the 5.15 block tree once the btrfs fix lands in mainline?

-- 
Jens Axboe

