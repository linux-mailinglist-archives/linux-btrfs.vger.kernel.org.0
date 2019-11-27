Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877E010B1EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0PLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 10:11:12 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37324 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PLM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 10:11:12 -0500
Received: by mail-ot1-f50.google.com with SMTP id k14so3668225otn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 07:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0qtodSRCiXepx7Tjoavti29284BmHUtJ6tnz5IjtUo8=;
        b=DFcXYBCQsEUxbMfbUfMAkLzyB5v1EZApo00E9j1PkvhHYyOlxis4Y+9U09wmHdPaFv
         tl6sLKiLE6WEmXv4SpPUmFvVf8B0XnzipzkbyZMR9FZVW7AdClkvqYAqTWmElIDadMgo
         Lv62ok3uTqI80SrrhEKeEoWMsEcs48yNtR1tC9uuUVZmLKIoiLjeG2NYrBcB4UOB87cE
         cNmlCYUkOv1iIwHU7IzWxr6/dATmMisPAYmpdMmS6g/VbqKTMmYBAOPGKTzi3YRMRP/2
         MbrX0gExCTSCLvx2WpXFmMLbLiH7NA8tJwOhhldoR+mND9HmlM062WyQEyDKfFnk/mF1
         xQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0qtodSRCiXepx7Tjoavti29284BmHUtJ6tnz5IjtUo8=;
        b=sWvgd4e3W7phCu6l/Tal1EJ8jrSvkSMTWBcqLaxMFqpoEo3P1yxUxJwwQOmcoe6tNn
         Obid2gUfLNCWz+V1HmhtTiQ8O4d9w0pxLxSfPPiyKFTshi8AfdO+WapacBr//VSvoh0u
         4RuD5/sdawiGaWmVdRkby65CHnk0/hXRv72LJE9WcHuJBh0DooHaFY4Brm9JpO6e1fSV
         pgZK47cS+28eBoOgkwRwROwWeJ6puZaG8PafNyB3D8sdXmCEW0yy8hu+qNOyF+zEkyce
         CcTnG+EVfC87/uxL/3vGXGKd9wpGPJvD/mEdVJwq//ARUF6bkSSybirZmDO0Qf1yb4R7
         tFgw==
X-Gm-Message-State: APjAAAXPrNTqMbmSgMq8LENcP3hYOBEJH9DRge1XuhBott5tma3J+ATd
        K3DRS5E9V5LvOn0pxpvgWRtVzL7Y7Oak2Lf/jmERYwWR088=
X-Google-Smtp-Source: APXvYqydWe35kxjUGPtIXOIeRoFkRkGBAgVCU5cAjALjd8ktpyNSQpIuynv3qBagKsVjHobw4C6lTYB1T0Wrdhkk1Ko=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr3855186ote.2.1574867471022;
 Wed, 27 Nov 2019 07:11:11 -0800 (PST)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Wed, 27 Nov 2019 15:11:00 +0000
Message-ID: <CAHzMYBTXvY1VgcoFDUvc2NFmVKq2HJRHuS0VXzoneUMh79cySA@mail.gmail.com>
Subject: RAID5 scrub performance
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I believe this is a known issue but wonder if there's something I can
do do optimize raid5 scrub speed, or if anything is in the works to
improve it.

kernel 5.3.8
btrfs-progs 5.3.1


Single disk filesystem is performing as expected:

UUID:             9c0ed213-d9c5-4e93-b9db-218b43533c15
Scrub started:    Tue Nov 26 21:58:20 2019
Status:           finished
Duration:         2:24:32
Total to scrub:   1.04TiB
Rate:             125.17MiB/s
Error summary:    no errors found



4 disk raid5 (raid1 metadata) on the same server using the same model
disks as above:

UUID:             b75ee8b5-ae1c-4395-aa39-bebf10993057
Scrub started:    Wed Nov 27 07:32:46 2019
Status:           running
Duration:         7:34:50
Time left:        1:52:37
ETA:              Wed Nov 27 17:00:18 2019
Total to scrub:   1.20TiB
Bytes scrubbed:   982.05GiB
Rate:             36.85MiB/s
Error summary:    no errors found



6 SSD raid5 (raid1 metadata) also on the same server, still slow for
SSDs but at least scrub performance is acceptable:

UUID:             e072aa60-33e2-4756-8496-c58cd8ba6053
Scrub started:    Wed Nov 27 15:08:31 2019
Status:           running
Duration:         0:01:40
Time left:        1:40:11
ETA:              Wed Nov 27 16:50:24 2019
Total to scrub:   3.24TiB
Bytes scrubbed:   54.37GiB
Rate:             556.73MiB/s
Error summary:    no errors found

I still have some reservations about btrfs raid5/6, so use mostly for
smaller filesystems for now, but this slow scrub performance will
result in multi-day scrubs for a large filesystem, which isn't very
practical.

Thanks,
Jorge
