Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D91C055A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD3S4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3S4W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:56:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1403CC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:56:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o27so3078736wra.12
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjgFmu6mPXxgjkPtgS0yFvSj3QbA8zkO219ueyTvEHw=;
        b=nIW+hwLrvytp8l7qujahd1Rm0wUXU1/HE01V2bKsXkCEM9sAmrmdwOnvfoVlsKTlaK
         U9cLCnCe9cXoTteQ1n/j+n2BXbBSB/tUTD4UluD/QPkJVVClo89lTwEWn4BofBGQ7ZqC
         VySl4NhlMuErGqllH3HOBTk6q5VoMZCfcqPSk8FcL9ddEheQ3LH7c54oeNrK7pCtxICi
         7r3KMTmkDQqctaw58vyOqB2Fk+hhTO8fIJY6M/j9ao1qna44fCUgucY/s89Qr4BBqL7E
         9QuXoUi8u5RhDu/Mk6dFUDhoH5jjGy0UJ9sZE8RPCbBGoIwVwbDs6NA02Pu/xSgefez0
         gAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjgFmu6mPXxgjkPtgS0yFvSj3QbA8zkO219ueyTvEHw=;
        b=LAIyKhp8R0edcs7+8FpS5IXS9nJM1Fl5+SqLsGRdU9snEyrfxjWx0FB6ob1Ez4ZJX/
         DW6ReAJYFZi4tE54U93Gg2yA/Oi93KDDIGUTSL+mYNXT/SiERI+HaHWHZAoO/cBLRCmF
         8WnrCN/XfqziO6vkUeoY5o0MdaPJQLfwZFqLXaReXQ9cVrtr/W9/FDDFdys2N8rc2NtU
         xzxTPfXiVnG9heJi4nYCepIHENklHFODkjLz9E3HH0Os+Jr3Tb2ExzLiJb3IayRM1BYr
         jJ4sn5MYFaZekETQxSuSJG8+uzwSX9ClnRD5pt7/4W5KMIwxEeg5fSDwV6M+q8mEdTBc
         qKIA==
X-Gm-Message-State: AGi0PubQlisdt+nAeNpO6TFsArXQW8nxaG8mcZkvu8EOiPyn1kAz5Vwr
        pBxtRY2BVE7VbPv1gKWNt5RgBqkQb1XqRCBQ9w7umQ==
X-Google-Smtp-Source: APiQypLfjzP6nKlKLD3PEzO8twwX03/AZ036MV/MIyDDPIu2E1YqpDoJC7cDhEkoj3FV39j3rKrFIDUinfBySkmKWM4=
X-Received: by 2002:adf:e702:: with SMTP id c2mr5671638wrm.252.1588272980686;
 Thu, 30 Apr 2020 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <8B7A1A74-4AFC-4B85-AF99-5EEDBB3B94ED@cisco.com>
In-Reply-To: <8B7A1A74-4AFC-4B85-AF99-5EEDBB3B94ED@cisco.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Apr 2020 12:56:04 -0600
Message-ID: <CAJCQCtRSt5pi=H5Ohy=zv-pu71Cbc9vWjnQeJSX80HDvkiaLhg@mail.gmail.com>
Subject: Re: Can I create a new fileystem, using Read-only Seed device, to
 change the ownership of the files in the seed device.
To:     "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 12:44 PM Saravanan Shanmugham (sarvi)
<sarvi@cisco.com> wrote:
>
> I have a problem that needs solving and I am trying to understand if BTRFS can solve it.
>
> I have diskimage(currently using ext4).  And I am considering btrfs for,
> Lets call this filesystemA
> This contains a software build tree done by userA and hence all files are owned by userA
>
> I want an almost instantaneous way to create or copy or clone or seed a new filesystem or directory tree filesystem B, with all the content in filesystem A but is owned by userB
>
> Question:
> 1. if I created fileSystemA in btrfs and used it as a seed device in creating filesystem B, What file ownership does the filesystem B have?

You mean unix owner and group? It will still be userA. The only thing
that changes when making a sprout file system is the volume and device
UUIDs.

> 2. Can that be changed to userB with any option.

Yes, you can use chown. The seed is not changed, just the sprout (the
read write device).


> 3. What happens when userB tries to modify a fileX on filesystemB that was seeded with filesystemA and has fileX owned by userA

userB needs permission to make the change, unix owner or group or ACL,
same as any file.


> 3. I understand btrfs supports snapshots and clones. Does the cloned volume and all its files keep the original owners as in the original volume/snapshot, or can it be specified as part of the cloning process.

It's unchanged, you can change it before or after removing the seed device.



-- 
Chris Murphy
