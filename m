Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166F1DDFB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 08:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgEVGO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 02:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVGOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 02:14:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76737C061A0E
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 23:14:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id se13so11629480ejb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mons.com.au; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8HtHYPwqc7I84NRjkZdFKFSFpaX/XcWfxEvA99zqfWo=;
        b=cqpiafnSksZN1k4JSODzZKXuzAfJcyr2UF+qP32El7yLIjthbCBlWd+UEvfRC1ADXk
         D+QvvzNj3unsI6lBPC+CiQQrfhkDd0KZZh9y555hX/cBQIEDy5Tq1ANa8yn/csJXFlgn
         A8tqxrj2NCsKTDSuLhPUpeStgfFAecOyxMjMShVpiUF0UMmS+TWpDSt+SCCRp+tlbcSy
         Gic1qB1OwmTwjNXe8K5r/Swjvwj17z9bUjaOifNvBE5DNefuS5xGCQbdbNCNbH/7aNDC
         DHg02Vcdm0gIDy6gj/24+HfKKR6koh/oIEjpanqAbq0cumqfQNSxFTBZlrKk6dzQyaFe
         vHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8HtHYPwqc7I84NRjkZdFKFSFpaX/XcWfxEvA99zqfWo=;
        b=VtoArdqIkKUIN0doyIDHKGA4xXc4MN4MuL2H8gJC0gqRbZldDNKiUenOVj3pFsQ0w6
         gw5lkpFrDtUc3YGj8fk++pWRfhCnBF5w0+ENhkc++FUYh4q8lTg4pgI4s0IxSFfIPvft
         xYYMEhFJkm7UpdOofI/rOFyjGwqW1apGYtaqWVZbL0nYIDB9dqLKq6mbh72ATrU8IQ6A
         0PKfMuElEcMmnEMV97YbvYa8AyPbnvrgB44y5a2JArJDkPAZO6Tv6RXpYl/9bFclptw/
         DC20Ms3Eg7TcBECLqfhwROX7RCSw72aFwfnLwOlz+0Axj8DN2Q1Rzn+5SFtz3w9+btXr
         7uGQ==
X-Gm-Message-State: AOAM530I8Q7Am8CXwYDN/l5hgOEqVI71Y4bwi1ECbk+xRlpWNh/diYaI
        5Gh7So9xO+Qcz/qIXhp/iiYBMrF0CtGWv+XnRYRsRoTOainsHQ==
X-Google-Smtp-Source: ABdhPJyMxmyR32+Jd16f23n4icjuSJfFlvVSoSqT6KD4gE2jzKCNbzqwP8aKT1DnpNBBj+g8zJ05IQTGF17wNpfdR40=
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr6982641ejc.249.1590128063531;
 Thu, 21 May 2020 23:14:23 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Mons <dan@mons.com.au>
Date:   Fri, 22 May 2020 16:14:07 +1000
Message-ID: <CACvBstUrsPPDBEV6UbePKO_p6HWXuc0GgG3KX2yF7uhNO50XCQ@mail.gmail.com>
Subject: tree-checker read errors
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reporting as per the instructions in the BtrFS wiki.

I have a BtrFS RAID1 file system on two 8TB spindle drives.  Was
created fresh on Ubuntu 18.04.2 with the 4.18 kernel, May 2019.  Lives
its life mounted with compress-force=zstd.

No problems with weekly scrubs across upgrades:
* 18.04.2, kernel 4.18
* 18.04.3, kernel 5.0
* 18.04.4, kernel 5.3

Upgraded to Ubuntu 20.04 LTS with the 5.4 kernel in May 2020, and saw
lots (50 instances in syslog) of errors in the next weekly scrub:

May 17 22:31:26 server kernel: [456527.977063] BTRFS critical (device
sdd): corrupt leaf: block=1552203186176 slot=82 extent
bytenr=135271284736 len=4177879734039097329 invalid extent data ref
hash, item has 0x39facf7b95b42ff0 key has 0x39facf7b95b42ff1
May 17 22:31:26 server kernel: [456527.977483] BTRFS error (device
sdd): block=1552203186176 read time tree block corruption detected

Eventually causing the scrub to fail with status "aborted" about one
quarter of the way through its normal run time.

Rebooting back into the 5.3 kernel (uname says 5.3.0-46-generic)
allows a scrub to run completely and exit 0, no errors found or
reported.  File system appears to be working fine under this kernel.

I'll attempt to try some later kernels provided by Canonical's
"mainline kernel" project.  I have debs for 5.6.13 which I'll install
and test when I can get some downtime in the next week.

If there's any other information that can help, please let me know.

-Dan
