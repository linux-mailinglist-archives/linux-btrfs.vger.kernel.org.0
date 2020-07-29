Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6434232698
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 23:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgG2VGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 17:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2VGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 17:06:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695FC0619D2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 14:06:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so1448678edx.7
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I87fUIB3jW1Ap9Jvzk/GcIhatEkQtaMOon/TETB9VtA=;
        b=Lb5y+h6HgMBCZmzEra1RFNQdb2cMSGgnTDXvDM1xALQmuk/B1Wg1JZ5spC3oJhNplz
         rm/UnnI4A0Usrnb9AWNhKJaHhyb8IMHRZXLi397BtsyWR4ystxAcnYzNTNgUUIR3LlDV
         IOSvbkjdcqafmiFcZy4EMCphUKRS7FxdR+zIaiE43h0b33D+TAryoKp++FOcZ088FRsq
         /k6ReZqg4kfG771bOuz1Eg6YbDi4Cp18iHd8vV+H+tY8v5vNxSuYO8j9RkiQY0d/IWpS
         2qrgsozrutNMH5o4tSf6IJkpuMOQ990JSuHvTACIcHmnVfOVPloSR5XexPU2Y6NPVohN
         i98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I87fUIB3jW1Ap9Jvzk/GcIhatEkQtaMOon/TETB9VtA=;
        b=RPzMZyXhuPK31Nc6ube4qOjimYT33gHHTUCJ3LNwztlhSZ0Xt8ZbFjEKSCZbWZmLyq
         KQGnFNkZn7Wn5G2nRGYp86GMFSm1jW1deZRyx20HXP4qTh+Z6IBuPZqTJKCJnm0xGhLs
         utOt9fGgc75i4U5vvA3POOslw3K7qEOjH/isExNmHnlA2KGhsDY30cx++OAdQeg0BvGE
         tdR+Przq5M0i9ft0/fwic17Onr2s4bv7/YA28uBuN0qdXg+JBlQck9Kuoj9me242TKYv
         pn8pCE7k7fwhnwUON9U6Qa83cLmdliSJnIk6d8EDeUhfGV+CoPhAMRbTfWsGp2FDRBdY
         bWEQ==
X-Gm-Message-State: AOAM5326hpg9Fk2BZAso8O9aZH2Z68IcsQjGnIydmT1PDdjYEidhE0is
        PabgvAg6XkBsrVTJ4uiAPUWBqmkkNWs=
X-Google-Smtp-Source: ABdhPJx3wVG6rl455uP0QYriZY/DjVBLtOtjangIpyuXtnHHwbsuV5Fmiy1lhPJQYvjUUx1k+vfTqQ==
X-Received: by 2002:a05:6402:b4c:: with SMTP id bx12mr139710edb.157.1596056798451;
        Wed, 29 Jul 2020 14:06:38 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4867:e700:c8e8:c32e:dd0d:709? ([2001:16b8:4867:e700:c8e8:c32e:dd0d:709])
        by smtp.gmail.com with ESMTPSA id d20sm3041248edy.9.2020.07.29.14.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:06:37 -0700 (PDT)
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     Michal Moravec <michal.moravec@logicworks.cz>,
        Song Liu <songliubraving@fb.com>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
Date:   Wed, 29 Jul 2020 23:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
> 1. What should be the cause of this problem?

Just a quick glance based on the stacks which you attached, I guess it 
could be
a deadlock issue of raid5 cache super write.

Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in superblock
write") didn't fix the problem completely.  Cc Song.

And I am curious why md thread is not waked if mddev_trylock fails, you can
give it a try but I can't promise it helps ...

--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1337,8 +1337,10 @@ static void 
r5l_write_super_and_discard_space(struct r5l_log *log,
          */
         set_mask_bits(&mddev->sb_flags, 0,
                 BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
-       if (!mddev_trylock(mddev))
+       if (!mddev_trylock(mddev)) {
+               md_wakeup_thread(mddev->thread);
                 return;
+       }
         md_update_sb(mddev, 1);
         mddev_unlock(mddev);


Thanks,
Guoqing
