Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA06A9A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfGPN3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 09:29:07 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37779 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPN3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 09:29:07 -0400
Received: by mail-pg1-f180.google.com with SMTP id g15so9461001pgi.4
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BYUVkowN17wc9+FQJA7u1ypJb00FXqldZyqIybARl+g=;
        b=PcIJJ0qh06pdS8lHRvK5VK/T6yhIaiKIQ77Yjj1cxFQPTyEytHh8Dzdq7bYCCrXBhw
         sduvME/1OBJ4KFBcTbdF6BA+F7d8wmstmQ35i192HYz55CJqbviwlHFGcECwbDs7SGgx
         p+sIjB4FOeQvD3GbNcs4Ek3tER1x/bNpEQ/uSL09qTGsMtWk76EvRUskoeuTZCf80+8F
         8ay2lCEqr+u2iyzsrd6j0jA42ohR6OZhpW6QDkXLiffUgjymHt/Fzm53K06AO2CDOY1Y
         JddeAugvf2v24SylTiWdhuiOhguEoDpFcPZ7xiU5URpqaSTM+w4mtAzWr3dqvWRr/bcJ
         ZgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BYUVkowN17wc9+FQJA7u1ypJb00FXqldZyqIybARl+g=;
        b=FiRyQ5fzVdtRPwSTjuAEkherXdsZgD20bmQF9UQfhi+PbSKQZnrnnW4KLR5Rs/5oNx
         s6wVIyBIjn45XRtjw6kORVqXsN9BfovqXNkFwA9m7esHnpDJ0PKQH2349jHx6+CSIXVF
         37vZk7hzM2D/cI+EJIX/NE6FTvgdMJSUL08ojO232yq8kRhGivUvmYmiMzPD5nIJ1kZ9
         f2ysB2yoaqurjQ68VUaiMyHptd3bdymPQWNa+zIGZ9YMYNfz9nXJPzrmEE7nLbgqi585
         BUqoZmaD9nhOIv01ur5LXo7EUte9NV+8iMsY5AGK53BmbKYCm95QN8JQewwYuG5oDA3V
         PvcQ==
X-Gm-Message-State: APjAAAVr4luH38aW7H+21hPcJufp3DOYsJC2zNoeUIR3TnQYgPp4Q3T9
        Tv/q/lt8TEQLfWov9deEyEVnTmJGzcPydg84ThdPSPryulJ+mg==
X-Google-Smtp-Source: APXvYqybwpmbx03ny0WaSjsYn1UrhOhGHbwtlNO2I4udiZBzy81zL0RWGfHCazJ7Y26p0MVc0tFgT2NJFV5x1YYjtmk=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr33698622pgj.4.1563283746815;
 Tue, 16 Jul 2019 06:29:06 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Jul 2019 16:28:56 +0300
Message-ID: <CAHp75VcjxDjCy3JhZHEFjBcNX_L60J8pWOQX=8_5BxyW3bN6ag@mail.gmail.com>
Subject: 
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following commit broke compilation

commit d5178578bcd461cc79118c7a139882350fe505aa
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Mon Jun 3 16:58:57 2019 +0200

   btrfs: directly call into crypto framework for checksumming

ERROR: "crc32c_impl" [fs/btrfs/btrfs.ko] undefined!
ERROR: "crc32c" [fs/btrfs/btrfs.ko] undefined!

Obviously if we call directly libcrc32c, we may not remove a dependency.

Moreover, module soft dependency works only on most, but all module
init tools (for example, busybox).


-- 
With Best Regards,
Andy Shevchenko
