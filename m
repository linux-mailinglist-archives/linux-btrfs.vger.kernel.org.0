Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8648FA04
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 01:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiAPAj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 19:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAPAj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 19:39:29 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CB0C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 16:39:29 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id j134so9152469ybj.6
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmcYVxveSL+HMosYf9iTVgmRWHZVxi54sfTeU5K6aVs=;
        b=5yuKq1fSsNkRGCElbsNOZgg7GXrkJnDXrG7QAYcnKe4HG9LxNkoF2l1Ip9lFjS3hrk
         EEClbePv73KwDTPeGyjz6ithJTkv4QCIYsSeO7Niiaj2OyHiyqhX+SgtNe78wTUtgap7
         LYdmqyPL7bGXXb8pA2wGHe+1mZspe+Fo+HzDYrvnmdRFoKekuBCHdopTix87C/VGk9pa
         R+2oIFRSEnMqdDf1NSV5DvWB7WHYqnjmpqHGsU8tLtN8Q6ThfBDzxwHA4hpDHeYZUtG8
         g7tpb7N6Db3QFsCABo1p3l5NvF+EDM7zzjDbaTOOYsogbcNQic19eNqN1dEoh5VKwGdQ
         WjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmcYVxveSL+HMosYf9iTVgmRWHZVxi54sfTeU5K6aVs=;
        b=nLQ8formpftFKN6i2SGwvlSWNLYK3HA2pdz5JoKmpmu9IQxOHbRWku013WdVM4aviD
         vcoIULte2M7AmcENiPVAl6V8So53DVU/F5rayaolMt6LQbiwKdrvTBcHyZH+LDD90gkU
         8duiSmaf5r8oOUOAXlW9J/ezBCfLnPLvzVRgvtzvdw8cQ7ziaQS9RzOqFGoHoLdU9Y6Z
         FKKbo6VemCQEi3h1efVIcQzf4ra9O3AekEoue2e0tQLBCdnqetHiOleSg5N1zMsgnBO+
         BmjH4EYO7znq7exwymL0dWaYwuVe68Nu1gtjbwjUrPfhChePndC+hsOyL1LId9B4jpJa
         7tYQ==
X-Gm-Message-State: AOAM531ZjH4qXXk7q3UntSTyjVJrwSJNfqCOxyXwU6eZzVl60nv1gacg
        e5xoJt4CYzeGF7bOi097R6pREnltLcTkzRmCGjuxtA==
X-Google-Smtp-Source: ABdhPJzydgp7vogRMrqVE7V+Tl2gdYcGUZ+M/YGIdOv/eZd+ghRK+Fh3ZCYczMJjQ5nBUS15TiIdKtKFSznRsvTtGGI=
X-Received: by 2002:a25:f211:: with SMTP id i17mr18925548ybe.239.1642293568380;
 Sat, 15 Jan 2022 16:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
In-Reply-To: <20220111072058.2qehmc7qip2mtkr4@stgulik>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 15 Jan 2022 17:39:12 -0700
Message-ID: <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
Subject: Re: unable to remove device due to enospc
To:     Ross Vandegrift <ross@kallisti.us>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 11, 2022 at 12:41 AM Ross Vandegrift <ross@kallisti.us> wrote:
>
> Unallocated:
>    /dev/mapper/backup      7.24TiB
>    /dev/mapper/backup_a    2.55TiB
>    /dev/mapper/backup_b    2.55TiB

You might be running into this bug I mentioned today in another
thread. It's an overcommit related bug where the initial overcommit is
based on a single device's unallocated space, in this case the 7T
device - but then later logic results in ENOSPC because there aren't
two devices that can handle that amount of overcommit. If you  can
remove /dev/mapper/backup, leaving just _a and _b with equal
unallocated, then try to reproduce. If you can't, you've likely hit
the bug I'm thinking of. If you still can, then you're hitting
something different.

However, since these unallocated values are orders of magnitude bigger
than discussed in the other thread, and orders of magnitude more space
than is needed to successfully create new chunks on multiple devices -
I'm not sure. Also I'm not sure without going through the change log
for 5.15 and 5.16 if this is fixed in one of those so the easiest
thing to do is try and reproduce it with 5.16. If ENOSPC happens, then
try to remove the device with 7T unallocated.



-- 
Chris Murphy
