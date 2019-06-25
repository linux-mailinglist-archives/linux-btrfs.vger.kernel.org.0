Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3160B55543
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfFYQ6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 12:58:51 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52294 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfFYQ6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 12:58:51 -0400
Received: by mail-wm1-f49.google.com with SMTP id s3so3583157wms.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgkQp+O1hdcbuBBtXbandmL2lI4gbbX0mPWURflfFzg=;
        b=d9i5VGdoOvRkVymvSspZAJFp1l0tPdHjGX9z6AA2VMcx86T5WBrDU4A7h2WwuXn4HD
         0hT8VBuBHmJ2EczIHgnEsSTR6pfCWfpyER9h4OslxcBpNJ9ZjX5xlsEADFY1ZS4ALYjs
         QE/pBMHkz5zmqvcoZOVtYU/eU28Rwu/TOeV3aMM6oTeKLZp+owKc5khmRBY/QxSyVmvl
         BrcTJGkqqCG5/dho6vADKGeSiNNhxUxdt4I3qYf5lKF3qr414AT82wkR2uwu2uK0B0l+
         +LwWM4oBh+Oepsp6JZ7UuhxvaBPL/CLeBJBHTLvayXFJMdMAljrdDMtwficqkxXpHxcz
         Df3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgkQp+O1hdcbuBBtXbandmL2lI4gbbX0mPWURflfFzg=;
        b=IW41UvEj7AoN+ds8wSHx8eY2Ozijhyew29lKTPzK3sHTIrl9JhxUe/xxNBX1dbXnKh
         yxchxv58BwWiRRq1by1c4qZpZTL2Z3KddLyAikmtt1FtfTQg5bmvd/VDmtrpe3ckK1TD
         9uxUPpzjZT25U33dAjciIno4Eo/Br2gPgcDfywzq7iFZXPkZyOOpVOomhONd6G1JSrBJ
         ZG8jqrv9RZev0dUTLPcfANWNOBD64p0+LdFVeiZiJdJkLdlXEWo3s24jZlxJrYyjo8jJ
         7B4H9GdFMijAf8mUPqcv3NZfbdNEWMUyuIsnlRkg6wcFqgMpWY80/S98/d1SFvmTSOQQ
         IP/g==
X-Gm-Message-State: APjAAAXTMWgNlYMpU/mAIK2mDTe5istWK/Q5BY6lYbxoogavaXCVrsYJ
        TZaMPNevt/vPMBkdStU6ZP07ter+Sli1HPkCoTZEgtaaCQsz3g==
X-Google-Smtp-Source: APXvYqwLMSoSv4eNWJNmbOFxxrgQTuMKBGIywdEm5dV9ad2piHh4q8lr+IfXKXr8gLzuWquDhiEtQFI+e3F2/UvMD7U=
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr20517975wms.8.1561481928997;
 Tue, 25 Jun 2019 09:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com> <CAJCQCtT8SE5TYkVniJxhK5ZpE8OoE6c9AVPzs4baHn8C5y5X5w@mail.gmail.com>
 <714f8873-9a38-8886-4262-4d8e43683614@suse.com> <CAJCQCtTvz7c18jE2qdbHke+sp1_=qgRdN6VJBqZu+kB4UEJORA@mail.gmail.com>
In-Reply-To: <CAJCQCtTvz7c18jE2qdbHke+sp1_=qgRdN6VJBqZu+kB4UEJORA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 25 Jun 2019 10:58:38 -0600
Message-ID: <CAJCQCtQQHCkRrk+QE8D3AUM=BmYj5t9BX++uA4fb1eGwZVAmew@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The order I see is:


rename() currentsyslog archivesyslog
openat() currentsyslog
fsync() currentsyslog
fsync() dir of currentsyslog
fallocate() currentsyslog

repeats for the user log

Where I get lost is at

10:04:18 ioctl(103, FS_IOC_SETFLAGS, 0x7ffc6429954c) = 0
 > /usr/lib64/libc-2.29.9000.so(ioctl+0xb) [0xf736b]
 > /usr/lib/systemd/libsystemd-shared-242.so(chattr_fd+0xe0) [0x11da20]

I don't know if that's doing 'chattr -C' on the renamed, now archived,
log. But right after that is

10:04:18 ioctl(103, BTRFS_IOC_DEFRAG)   = 0
 > /usr/lib64/libc-2.29.9000.so(ioctl+0xb) [0xf736b]
 > /usr/lib/systemd/libsystemd-shared-242.so(btrfs_defrag_fd+0x23) [0x130803]

So even if -C can't really succeed on a non-empty file, maybe it
somehow allows defrag to compress on a filesystem that's mounted with
compress option?

Chris Murphy
