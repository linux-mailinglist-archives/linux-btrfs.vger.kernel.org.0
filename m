Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC341046D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 00:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKTXFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 18:05:17 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44760 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKTXFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 18:05:17 -0500
Received: by mail-wr1-f50.google.com with SMTP id i12so1951947wrn.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XTURUaQEHNncNaojTSIZASIxlhHJh4zlA5pHJLNmdSs=;
        b=lyzipNWcoKhH87L1oCr7pUQotk3yg5S/ZNanrB39ddWP0M0J8vkd4mRn52ASgr2Y05
         2COmeVDUIkRGGeKIb0zZyPzcDj9ShnpUOIsmboD8C/H0yHV78TKXv4vERJsiVR+FlsWO
         /EoNAXwf9HBcs3Fp9Fg+b4JIblkotQbw6DRmuGdqSyiCacObxu1+dU/KsEsLAoYLjxaL
         P97Ulz9Hnatv74nl/RY9p32pz24NMqzJ8ea8l8WvrVPkoG1MVHI1S59f+ckDzzmZng8I
         x4V59VsXQGnHVY1Nwv9irGDnDIEfZYAnOfhWPPoN/GPlGhRARlSAE7a74oV4Ur3mWxl/
         0Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XTURUaQEHNncNaojTSIZASIxlhHJh4zlA5pHJLNmdSs=;
        b=cGhxTZJrc5Wreg7DZ6M5EyZE/aNw98SUb68Up3MxZx1eMzfTpjOmuKJx7yADZjRYht
         5rLmB7WTG9kgcGGlRsZM5k/yoaB4Z+Iz5e+V99eXXgN9yvO6Ib3ZbNZ0tIMP26EaPtj0
         6JQC27mgUK3UR72XYC/hdt+Sgq4iWVtfbBtxmDNlH1o7NwMmxMIdfgyk7LvTciOXDtA1
         q2IkhuMNYz5dxw+O5SRYpZbGskZI/uDUz+lbORtHISf6olYLTs2n0hnnCMDvR/v2z4cT
         0Prn4DO4fiN5HsajTKa0iiGeAB1YcxLkGIYsGCeyiEI2FUivRVoV+Lw/++sp9hZVgVk+
         klLw==
X-Gm-Message-State: APjAAAVsutl4H+LmXEbiggKnEdtZ9iyaSfOxsrTyoiRYeNk896CMMTph
        Ylg3+C5a7aXMbHpNoyaDlX7T6Jh3JyAx1K5EOQmxM7KyLM/f3Q==
X-Google-Smtp-Source: APXvYqyXIYNZof7uedBFh0i14aOsMM3lyjTt7hp1GMwUL0dV0u4aoqt6MqCx205pUBsfdlMGN15zqaAJx834hmcxevY=
X-Received: by 2002:adf:f547:: with SMTP id j7mr6866144wrp.69.1574291115025;
 Wed, 20 Nov 2019 15:05:15 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 Nov 2019 16:04:59 -0700
Message-ID: <CAJCQCtRw7fTBrC8ROu-e+bbE+rL3sz6Av9Q4obXfDFMijNWeow@mail.gmail.com>
Subject: is there a log tree replay kernel message?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In fs/btrfs/tree-log.c I'm not seeing anything that would cause a
message to appear in dmesg upon log tree replay at mount time. I see
in fs/btrfs/super.c

 "disabling log replay at mount time"
 "nologreplay must be used with ro mount option"

But in the case log replay is needed and is performed, causes any info
message to appear in dmesg. At least ext4 and XFS do have such
messages found in dmesg upon log replay. What am I missing?

Log replay suggests a crash, power failure or otherwise unclean
shutdown, and I think it would be useful to have an indicator of such
at the next boot rather than Btrfs just silently succeeding without
giving any indication that there was previously an unclean unmount.

-- 
Chris Murphy
