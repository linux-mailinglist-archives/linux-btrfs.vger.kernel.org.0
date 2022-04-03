Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8254F0CF7
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376668AbiDCXf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 19:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXf0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 19:35:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134902DDC
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 16:33:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cs16so538982qvb.8
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Apr 2022 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OTt0ioEkhQ4K2+CPOM/QtliNNXcdNv1hzoXvueSs7xE=;
        b=lznYRK7+XI57TTnHLhQSEPfDXstPRwr6KPVsgaCzHFImdJ9IVpYZkVCXa4PLVG3LUB
         yBIQbT0b8/Mzf24WLPKVUDQpZCgT9JRnupiQCpXUtCzKabCHsxx9f+43vu3aMpyk0Fzc
         XC3PJVzEWT2czxOJlovOD0VLxHrw22i2d2gCko1PccwiSy6NR4HMr6xakhGMdNpwysig
         iiutE/i8CMOxPVV5bhMKzAdZ7fkaiYNv2XqpmaXmGsWR67tMuyNCk3CTKMyaWyhl4DQn
         3co5f9MqZoKJOfGxEM3c88d55Q9UOfLKBeB2MX84Yu05lSLS4fBDdB2h7LoibIFYzaYg
         dyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OTt0ioEkhQ4K2+CPOM/QtliNNXcdNv1hzoXvueSs7xE=;
        b=3GVzO4ii5BysN1mo1QrdBF9zYo+LLedj9Cyc2rBE9bazVKY5KGAFd7xCX06Mta+TD+
         vhruxTjmJmmDGMNy9Al6zmDzhp/ZcF6kRj6vQE5FOg+cwgboeO+2FR7MwKBYcCL6HMwE
         EslKsG1gAhYDEncvmsr/8XjNyboaNmWkG8ZpMqzIbgIRX5i1L4DX9YcQ/iwy3CW6T5yc
         7RcBV0Jr4sQ0lvVa0Up3ZiSlY6FEmety+BBOMsROTT9ync2tdp2Ap4RNSmKMwxclsIT4
         OtM6o3kvYaYZDW34JCkRpvB6J4ZfLL1+Ql6fC+Nzs+43Tg6UUgEniVmBzawAUwI4xm5V
         uKgg==
X-Gm-Message-State: AOAM532CHADftLQVFMOsa9xJj/HOIg0BeXahAGf/eVPexY/kz/ooo/Px
        rq0XaWyvdBa9P2/FRTumwvZcNg==
X-Google-Smtp-Source: ABdhPJyUFxX1popRCoWal77uTt2gyB30PCHtoh8mhUv3UikCcNnCjPvJzgld+Z4EkxdCIfRIivmN6A==
X-Received: by 2002:ad4:5b88:0:b0:441:5b5:e78e with SMTP id 8-20020ad45b88000000b0044105b5e78emr47503754qvp.14.1649028809102;
        Sun, 03 Apr 2022 16:33:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002e1ce74f1a8sm7134616qti.27.2022.04.03.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 16:33:28 -0700 (PDT)
Date:   Sun, 3 Apr 2022 19:33:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <Ykoux6Oczf6+hmGg@localhost.localdomain>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org>
 <20220331171927.GL1314726@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331171927.GL1314726@merlins.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 31, 2022 at 10:19:27AM -0700, Marc MERLIN wrote:
> I'm going to wait a few more days before I give up and restore from
> backup and will consider whether if I should go back to ext4 which for
> me has clearly been more resilient of disk misbehaviours like I get
> sometimes (of course, nothing will recover from a real double risk
> failure in raid5, but over the last 20 years, it's not been uncommon for
> me to see more than one drive kicked out of an array due to SCSI or sata
> issues, or a drive having a weird shutdown and being able to come back
> after a power cycle with all data except the last blocks written to it).
> 
> If I go back with btrfs (despite it being non resilient to any problem
> described above, btrfs send is great for backups of course), what are
> today's best recommended practices?
> 
> Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
> files (100MB to 10GB).
> 
> 1) mdadm --create /dev/md7 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[abdef]1 --chunk=256 --bitmap=internal
> 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
>    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
>    [writethrough] writeback writearound none
> 3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
> 4) cryptsetup luksOpen /dev/bcache64 dshelf1
> 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1
> 
> Any other btrfs options I should set for format to improve reliability
> first and performance second?
> I'm told I should use space_cache=v2, is it default now with btrfs-progs 5.10.1-2 ?
> 
> Anything else you recommend given that I indeed I have layers in the
> middle. I'm actually considering dropping bcache for this filesystem
> given that it could be another cause for corruption that btrfs can't
> deal with.
>

Sorry shit went real wrong this week.  Can you do

btrfs inspect-internal dump-super -f /dev/whatever

This is going to spit out the backup roots for everything.  I was looking at the
code and realized the backup root code doesn't actually work for the chunk root,
since it's special.  Can you then do

btrfs check --chunk-root <bytenr> /dev/whatever

from whatever the newest backup root is, and then keep rolling back until you
find one that works.  If you find one that does work hooray, I can write
something to swap out the chunk bytenr in your super block and we can carry on.

If not we can go with

btrfs rescue chunk-recover /dev/whatever

and see how that works out.  Thanks,

Josef 
