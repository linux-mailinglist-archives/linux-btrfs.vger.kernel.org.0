Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF21E89560
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHLC1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Aug 2019 22:27:41 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35164 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLC1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Aug 2019 22:27:41 -0400
Received: by mail-wr1-f42.google.com with SMTP id k2so17406337wrq.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2019 19:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8qTR7xng4Zzcw8vKnKxrZ8cKZML4gGjoTfao80fTu6E=;
        b=VX/JzKbAlB/uLFR0k3YZC5jdqcmj2lzL4QF4nIJG6CU9cD9DsbivQEbTfVDAGzKUq4
         HDas1kLyrWbv4lkgNVqh4ZkIe5OWIDeHujywQTJm7vx3DYCk9khhQGHdil1t99Lp3Ssg
         y3djSIbPYYzovw+w4DqjkepsnsO2lxzHv71XGr9bcPYEnQqG22b34HFuwMdizTDYo8ph
         AvXP2S8gw4Ha0MoXFChz/LWqjpUNeEAZXuWOBt6vjUu5K02xa5xFO0AIHsLawHbjJi5Z
         hw14OryzCR9ZPJD1I2jWy9t0dRnutZ02vWN2JJbvzt+HgSi9i0cyEs54s2r9JfwKpVmw
         hbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8qTR7xng4Zzcw8vKnKxrZ8cKZML4gGjoTfao80fTu6E=;
        b=Vupf//J99P6zCy0zC9aljU/y4cjZ3hPMpf1bsXW61oR/tr6EaDT6IXScuN2z5el8In
         zjkVu7Pa6ylpVA/6NdsQF1V49iI0JV57dosOlewHPuVCQ/LwMQI6kI1n5lb/iUG/T8Yj
         wDrSdAmxK49WsKlxwsVlAEM8b3I4Dril8IIrSlJy4JmT8ZJRHNpSmgkgLbEMeqfA0RUi
         bugA/TsmV8nZFsjqtBgPiO0OB2ecovZKreE6ORyhBNjGHNtkrv8Xa8e0NKRIJTBFEGWU
         dSX5Z1TGsp1rYQ0mv+qsmf7l0/yZWC6QnH/EwfL3qVks3dhLuWvWDO83hz0f0Fx/eNrY
         Il/g==
X-Gm-Message-State: APjAAAWRgW7yFfOKQuj2ok/rOs9zWu1RVHOJlZHlQY1YP/cgEjHV0RJO
        pVGFfwMzRKlHziYiCt0JFRi2Xye72MREI3DBamf47DZkJnXXCA==
X-Google-Smtp-Source: APXvYqyrpnZUBVstqCUIMamIKeEGniwF0DOiajXJwcbQUAl6e/KoNuRap7OaJuUjo8l9gWuvCA9v+wgPEuXDZU7MX1I=
X-Received: by 2002:adf:f851:: with SMTP id d17mr12170786wrq.77.1565576858863;
 Sun, 11 Aug 2019 19:27:38 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Aug 2019 20:27:28 -0600
Message-ID: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>
Subject: many busy btrfs processes during heavy cpu and memory pressure
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm not sure this is a bug, but I'm also not sure if the behavior is expected.

Test system as follows:

Intel i7-2820QM, 4/8 cores
8 GiB RAM, 8 GiB swap on SSD plain partition
Samsung SSD 840 EVO 250GB
kernel 5.3.0-0.rc3.git0.1.fc31.x86_64+debug, but same behavior seen on 5.2.6

Test involves using a desktop, GNOME shell, while building webkitgtk.
This uses all available RAM, and eventually all available swap.

While the build fails on ext4 as well as on Btrfs, the difference on
Btrfs is many btrfs processes taking up quite a lot of cpu resources.
And iotop shows many processes with unexpectedly high read IO. I don't
have enough data collected to be certain, but it does seem on Btrfs
the oom killer is substantially delayed. Realistically, by the time
the system is in this state, practically speaking it's lost.

Screenshot shows iotop and top state information for this system, at
the time sysrq+t is taken.

Full 'journalctl -k' output is rather excessive, 13MB uncompressed,
714K zstd compressed
https://drive.google.com/open?id=1bYYedsj1O4pii51MUy-7cWhnWGXb67XE

from last sysrq+t
https://drive.google.com/open?id=1vhnIki9lpiWK8T5Qsl81_RToQ8CFdnfU

last screenshot, matching above sysrq+t
https://drive.google.com/open?id=12jpQeskPsvHmfvDjWSPOwIWSz09JIUlk


-- 
Chris Murphy
