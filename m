Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD83C7362
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhGMPls (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPls (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 11:41:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE890C0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 08:38:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j3so9382855plx.7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=qJ5owaXAd78045AnSEQx0LymH3w47IzTfo7HQQyJpDY=;
        b=N8sO8qPoKiueGMMw6rju6QzxKiAXWw9CrEsr2WaszzpuGR1Iiw8bFls3S+jxqnBWZf
         LHpAYi8XVVG9TEnmpkWOjoGK/UhxKc7wOkaIcOm26q1y9vJzGuRKzb5t5B3Y1+bOCshk
         QlLTA4knoVi5rylOXuM8yFBkPbqdN62hJPQKnKlmC0XkWvGqVs12cNvGlALHW+0WdSJL
         f19Y6N8yxE5L6wILpbnylaalW8ZrBSV5lQ3sN9NDwnLP22OJOPSnoCEMv793cFa8Bf4G
         YWhalqhqEkECZ0PlPHq1mDbavVwBOzusO8B1mPGKoKZi3YbdM/drUAImsS2Pii/bdw3E
         nV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=qJ5owaXAd78045AnSEQx0LymH3w47IzTfo7HQQyJpDY=;
        b=ePgtTywFEzTl99vmxqnSpDqPiKsuHhYVJmF7vOqUwOv7zz4vfURBbt+xu/0HraPqwS
         G56qvxtTQJaoB8WwBykL7SS8Co6tSPxnP4gGt1Ce4XThEvRYyfoYPZSwNrFoLVlyD9BO
         gwKpx9JfbNrRY0aoRpPrB7hddb0fyR0/z/j9KHdhdrowaL1QOzfKcB4oYn8LF+UmcY/4
         DklWVR2Uv0bUXeDf7JdETu2m+XcD0BLXcyOrcfhELLvyDpN/pmTpdfyf0pgAkROA5QZY
         zrqJlfycRhQS4wSQ+NorKwb2qqpH2UGw3+NDe7P9vJE+rwuA9RDQTLcO64/lqnNjtC91
         xGEw==
X-Gm-Message-State: AOAM532+iudTwfsKx0P8x7zO89kIO0+PojeWQdd6O64gC5g+VlilWS6S
        Z6Us1NFglfcZhcTAeOSD0MU=
X-Google-Smtp-Source: ABdhPJzzuc/Y/LNQZuBPImtl7osecA0eHz8TGud5ONhC/yK6m1Z2v/XLHRaFvrWBKfI/RxXBLnPWnw==
X-Received: by 2002:a17:902:ea0f:b029:12b:2395:62da with SMTP id s15-20020a170902ea0fb029012b239562damr3929027plg.39.1626190738336;
        Tue, 13 Jul 2021 08:38:58 -0700 (PDT)
Received: from [192.168.178.53] (14-203-78-180.tpgi.com.au. [14.203.78.180])
        by smtp.gmail.com with ESMTPSA id u7sm22757852pgl.30.2021.07.13.08.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 08:38:58 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
Cc:     danglingpointerexception@gmail.com
From:   DanglingPointer <danglingpointerexception@gmail.com>
Subject: migrating to space_cache=2 and btrfs userspace commands
Message-ID: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
Date:   Wed, 14 Jul 2021 01:38:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're currently considering switching to "space_cache=v2" with noatime 
mount options for my lab server-workstations running RAID5.

  * One has 13TB of data/metadata in a bunch of 6TB and 2TB disks
    totalling 26TB.
  * Another has about 12TB data/metadata in uniformly sized 6TB disks
    totalling 24TB.
  * Both of the arrays are on individually luks encrypted disks with
    btrfs on top of the luks.
  * Both have "defaults,autodefrag" turned on in fstab.

We're starting to see large pauses during constant backups of millions 
of chunk files (using duplicacy backup) in the 24TB array.

Pauses sometimes take up to 20+ seconds in frequencies after every 
~30secs of the end of the last pause.  "btrfs-transacti" process 
consistently shows up as the blocking process/thread locking up 
filesystem IO.  IO gets into the RAID5 array via nfsd. There are no disk 
or btrfs errors recorded.  scrub last finished yesterday successfully.

After doing some research around the internet, we've come to the 
consideration above as described.  Unfortunately the official 
documentation isn't clear on the following.

Official documentation URL - 
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)

 1. How to migrate from default space_cache=v1 to space_cache=v2? It
    talks about the reverse, from v2 to v1!
 2. If we use space_cache=v2, is it indeed still the case that the
    "btrfs" command will NOT work with the filesystem?  So will our
    "btrfs scrub start /mount/point/..." cron jobs FAIL?  I'm guessing
    the btrfs command comes from btrfs-progs which is currently v5.4.1-2
    amd64, is that correct?
 3. Any other ideas on how we can get rid of those annoying pauses with
    large backups into the array?

Thanks in advance!

DP

