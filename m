Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8691A1287BC
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLUGYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 01:24:43 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44248 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLUGYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 01:24:42 -0500
Received: by mail-wr1-f46.google.com with SMTP id q10so11402080wrm.11
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 22:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=lIGp1WJqQZR2knsghDJS4+J/5egcahQtQalLhW8uKJQ=;
        b=VEth1XOSGf3RT1Az0kIvVp59gKyMjI+1uvozvw7qO/s4Q0vKD+exQj2sJvU8tFgBf9
         gMJ1Sgf51Vmn+JL5WpSgQf094oxxZ26ua/maWJV8G4kvs/nwniTtnCg1y3LrRyfQeXcq
         5y+cqLmEmQrxTbtv/VDg4A89447KXifr1vI6FETED6lJk6FVQ/bQ9F5Ghy6iHoM5ysVN
         FFXLock+R9xbQwC2G471zNSp7S93h0BE38i0sDOlI2ZD1TNu8E9xVRzZQFGFlgaGebEX
         ygjnTDsAdEbw9mmS4XW8E4/hsrfVgzEe2VbiC0q+lvichN8Xy+IMzKslvxiGjnQXBMr4
         7Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lIGp1WJqQZR2knsghDJS4+J/5egcahQtQalLhW8uKJQ=;
        b=RfXp+YhrATsWkJk02ung3kiTgXlR+kK08GGiERrx7CCZJdhs43bDI2R/aCM7IBiZzr
         L2rPn8t1aaXlu9fDVbWWukM8pl5FF+jdEaIoGW859wkKI2qPQr7tUE/WBWWOdAeR0W97
         tQoxIeVpmmIlz9wGe7s7eIjwIZ4kH+JIcArnJlTTr34SG9lhJdYEnplREYZ8sBkOtfdS
         dR57D4Wgtn63OXJqLp5ISaQDQI1qqdC2tPF5QMquiGq4k+axx/DIxhYxEXtH7pVMPnZ7
         dha8tc6eYleaNcRUGFXo2bdFZ//CeU4SpWFkfEMmAH7yY7/82Sk97PQtxZVv7toaAkA2
         sjug==
X-Gm-Message-State: APjAAAX+pbyWZtmBt1T/AIlt6JRcOu1PRshFqu+jgmF/Gn2w/plKZN7Y
        ZGm8x9Wz81pdx0DGz7UYeTzLfqXcxIeNjQtV+E2t2GFBg2+cLQ==
X-Google-Smtp-Source: APXvYqwquuMMVZimuOIbBR7raJhQBO0Di0Qz5klqok7F0QksOTaajsg9A2Hnn3XzFqwuvQfMKVlTfCU5aUXgwhInn5A=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr18923347wrp.167.1576909480184;
 Fri, 20 Dec 2019 22:24:40 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 20 Dec 2019 23:24:24 -0700
Message-ID: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
Subject: fstrim is takes a long time on Btrfs and NVMe
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Recent kernels, I think since 5.1 or 5.2, but tested today on 5.3.18,
5.4.5, 5.5.0rc2, takes quite a long time for `fstrim /` to complete,
just over 1 minute.

Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p7  178G   16G  161G   9% /

fstrim stops on this for pretty much the entire time:
ioctl(3, FITRIM, {start=0, len=0xffffffffffffffff, minlen=0}) = 0

top shows the fstrim process itself isn't consuming much CPU, about
2-3%. Top five items in per top, not much more revealing.

Samples: 220K of event 'cycles', 4000 Hz, Event count (approx.):
3463316966 lost: 0/0 drop: 0/0
Overhead  Shared Object                    Symbol
   1.62%  [kernel]                         [k] find_next_zero_bit
   1.59%  perf                             [.] 0x00000000002ae063
   1.52%  [kernel]                         [k] psi_task_change
   1.41%  [kernel]                         [k] update_blocked_averages
   1.33%  [unknown]                        [.] 0000000000000000

On a different system, with older Samsung 840 SATA SSD, and a fresh
Btrfs, I can't reproduce. It takes less than 1s. Not sure how to get
more information.


-- 
Chris Murphy
