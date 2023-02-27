Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2450D6A4DDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0WRx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjB0WRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 17:17:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6D1B0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 14:17:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p20so7164717plw.13
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 14:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPM2MT4l22bSLqZbp1zzdMjwuCto4MQv4gVU0GLg09o=;
        b=c3RRuHU2onk5Ll4yH0rWp94BqSk4DSJw35QyBkGUaFa0WGN4tgO2TcNVzhoYIx+7PH
         DVLzen85rSVguCwv9NApLo93L2laz9K6tOeBUBJvz486/ZLlTL5qVvC6kpnmwOCm9Pjr
         LVfvQcT4dxC4qxQBqbsYuUqwvU50L5wJerBgWIDGMGeV+E1BQas6rvjFc65e3rs3IA2q
         9KlezrP7s25qLNC2O8rGQ2Rf2lu7RDsHCfqiwB1XmqR6ubPxGCE+79xQ8nWxaEf4u+wc
         m298ViMCUknvpjJh5377alzfmmeSpITHNi140aNl0erKfh0vAWKeHCIOR2TY7vPLFA8N
         4R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPM2MT4l22bSLqZbp1zzdMjwuCto4MQv4gVU0GLg09o=;
        b=2sAvJ0ycC/6Nx1HePHAiHr/y0bYG0HaYIqLVMPTDWsOsdrhFcZt6/PiZdQIeNak9wl
         gEOLvpH1goeG/N7cnbdhR9H5D4vEr1qNASDaNKQjcDuUUs8RKTsdo2TRcqc9FW8lhQlQ
         /mmworqA0abgZk60vWO7LzSXNxCp2rBLGFFRIl/ueniVizsTQR+LUkIrPdTH9CEnq7Dp
         /dh0N+FRE/b31rvRizY97e+MRW9X5L7pUvgrWpHgzCZdBfJKNKux/jjiC1mD+LtwgF80
         Bv4JvXatXYnGRezjFSiBqLQsepWq7e9v/CuLxY3SoGIFV4OAI84sWSUJneDkOez2ArZV
         niRQ==
X-Gm-Message-State: AO0yUKXa96Amwf+D6wPpYNC3OQ4LXF0Z7X0OfKlVeWL2sI94+Np22fVq
        Cb7PBNG8mHVefG2ylHOnumaWQw==
X-Google-Smtp-Source: AK7set/UWLuA22t/X7nw5ppBZa0/KoERUzGb05/5qRp1Ftv4fGoo0pk3i5p98gZJeVqpUqkw9mF5YQ==
X-Received: by 2002:a17:903:22cf:b0:19d:1686:989 with SMTP id y15-20020a17090322cf00b0019d16860989mr490126plg.59.1677536269102;
        Mon, 27 Feb 2023 14:17:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00198e7d97171sm5059718plm.128.2023.02.27.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 14:17:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWloX-002tUp-Ps; Tue, 28 Feb 2023 09:17:45 +1100
Date:   Tue, 28 Feb 2023 09:17:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for
 btrfs
Message-ID: <20230227221745.GI2825702@dread.disaster.area>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 26, 2023 at 11:02:53PM +0700, Ammar Faizi wrote:
> ## Test wq_cpu_set
> sudo mount -t btrfs -o rw,compress-force=zstd:15,commit=1500,wq_cpu_set=0.4.1.5 /dev/sda2 hdd/a;
> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
> sync; # See the CPU usage in htop.
> sudo umount hdd/a;

This seems like the wrong model for setting cpu locality for
internal filesystem threads.

Users are used to controlling cpu sets and other locality behaviour
of a task with wrapper tools like numactl. Wrap th emount command
with a numactl command to limit the CPU set, then have the btrfs
fill_super() callback set the cpu mask for the work queues it
creates based on the cpu mask that has been set for the mount task.

That is, I think the model should be "inherit cpu mask from parent
task" rather than adding mount options. This model allows anything
that numactl can control (e.g. memory locality) to also influence
the filesystem default behaviour without having to add yet more
mount options in the future....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
