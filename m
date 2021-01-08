Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05A2EEE6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbhAHIRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 03:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbhAHIRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 03:17:18 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DAC0612F4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 00:16:38 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id u21so6035675qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jan 2021 00:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VKbw1ku0v4yst5mfUBn76q6gB6x8uFgjTh/V/B/SRE=;
        b=kqS740iaE+aavWH4D8BLCC1yKS6nDu/iG97EinpGg8nykhxY6K2/q19MykZmls2SY5
         68u4FfWba6hn+YHZvSHN183XoWC7eCGJspiQX9g0//etUuWmLHNc7YA1MSe7QNxvfRr9
         CYmJ5lMx94UsB3TIRFCzECywxQlGqslb4Y/gl908BjKp0JpPbAF/lYr1d6j/xyYvJXTG
         Vd9wHuZF/WT34oIUpVDIQMvdvCx+hUQvBDYQAmuKGafj2sI4ML0MZV9oRA+dpHNxeBnL
         t0QU9I3ESonLAkrPB+4zH8oQuUFW2bmuyYA8GZCF5wJzGNlQxWPVfZjtrFx0G0eNlBKE
         0jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VKbw1ku0v4yst5mfUBn76q6gB6x8uFgjTh/V/B/SRE=;
        b=UeqxByyt0QqgyX3JjcDtEc7/dXqBjVQTWhsk+TUxz2mtiFtv2Q9iDyaygKPiIlEzZp
         sfvKUkrgZtCbCyG24CjcqTZz8ayLqFdEmOVvyk0GrkoYBzT/U79FUKsDh1VRHRkGulwc
         j9fOaWnLWXgnpu/AVO1gJrbgBH+tiCUn/sF68KKXeqAfIzgzU5GCHyXlzGJE8IJEdlpD
         /Dcdo4a9uXN0jKof/ld1QAUgiDfVu0VOi3mgm03azfhBfahKctkc6s97BXfMxTaNjYe4
         c2pIbTo/qIR4J6D74IJQZfw+gQCOgvyam8j0RGV8/FamQxk7QbM/ZzQs+EXMYg4Sxlpo
         HOtA==
X-Gm-Message-State: AOAM5314/nSxN8xmFcx7ERcM74wiEyJCkc+ainVFpZdeDdj7vA8Z+JFV
        jKE2MVLRhulUemiB7Ul5PIwNKd2HQtchn+/0EzfmrPQrccW8TKqd
X-Google-Smtp-Source: ABdhPJzrpDAvBWkSHPOuz4JZGE19Ki0uCPigmOU9RnZAP6dvDYrSlZf30txkUFjg8nUlpNTHnh7dNCSNQaJ1EKRvbs8=
X-Received: by 2002:ac8:4f4c:: with SMTP id i12mr2480011qtw.18.1610093797422;
 Fri, 08 Jan 2021 00:16:37 -0800 (PST)
MIME-Version: 1.0
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
In-Reply-To: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Fri, 8 Jan 2021 09:16:26 +0100
Message-ID: <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
Subject: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize the SSD?
To:     Cedric.dewijs@eclipso.eu
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mar 5 gen 2021 alle ore 07:44 <Cedric.dewijs@eclipso.eu> ha scritto:
>
> Is there a way to tell btrfs to leave the slow hdd alone, and to prioritize the SSD?

You can use mdadm to do this (I'm using this feature since years in
setup where I have to fallback on USB disks for any reason).

From manpage:

       -W, --write-mostly
              subsequent  devices  listed in a --build, --create, or
--add command will be flagged as 'write-mostly'.  This is valid for
              RAID1 only and means that the 'md' driver will avoid
reading from these devices if at all possible.  This can be useful if
              mirroring over a slow link.

       --write-behind=
              Specify  that  write-behind  mode  should be enabled
(valid for RAID1 only).  If an argument is specified, it will set the
              maximum number of outstanding writes allowed.  The
default value is 256.  A write-intent bitmap is required  in  order
to
              use write-behind mode, and write-behind is only
attempted on drives marked as write-mostly.

So you can do this:
(be carefull, this wipe your data)

mdadm --create --verbose --assume-clean /dev/md0 --level=1
--raid-devices=2 /dev/sda1 --write-mostly /dev/sdb1

Then you use BTRFS on top of /dev/md0, after mkfs.btrfs, of course.

Ciao,
Gelma
