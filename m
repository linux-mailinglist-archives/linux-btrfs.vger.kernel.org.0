Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B513127C5
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Feb 2021 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBGWHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Feb 2021 17:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGWHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Feb 2021 17:07:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A286EC06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Feb 2021 14:06:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g10so15061197wrx.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Feb 2021 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8bl05qGj7Um2PamNex0n58olpfNCvFM3i23wSkNoRKM=;
        b=LBYwJdBh5X6kV8j//AX1e0PgwgebQNUuWgatOwDqF3yGi+GF8lG+GxRJg3t6qn84o8
         RUM4SpPKcmM5eB4WhskEte5jT82iyL8oUaA9x90K0h/3w7CryhUDvhNusQq72i1HBM4h
         HtkXBpOknrA5Nf4y2d/vFtEGJxHEi4dcvgChaTmuch/GZqumtoyXCrgAgMRxcaVYY9yS
         MSFDdaDq6/FzLvjyMerk+tr706ig/xK9raq4GexQvI7n5rdbADQZNgm3QjnmmkAb4BAV
         AsI/hDN6La6t22UfMZvmEvDmFEa6a9s8RL9m1qHC32utrkQnnU0Xc0jLx93IxLT1NMP3
         Hd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8bl05qGj7Um2PamNex0n58olpfNCvFM3i23wSkNoRKM=;
        b=fwppg1ItIf3HEONwrfThCgILkgIZ81zlzEumGBRRLBbjS6bMcpVB6qqjqlG8j4qXO2
         HpSfn5BItvxTHisGma5xf/zH2/7lXHEKXsU44whATFsoNgGUYPW30hLJUL398Hxliifu
         wWtyILUhaj3rA3B6Ne/fKVZZghIB7SeL7illFQHmqyMTB/a1kaBgt39tKUgxKb7/NkyO
         YuY2MpFZqISQH8IVWZXVR/PrncPzDrBTK5+6CO7DP90U/O9yYUA4AsMWmj54Q/z+PhT0
         BbzJdLm04p/VABgDldQ5OpyTRnnDkbqdNNsB8muto0OmCNKgzynRz18iAV3LVA2XHNAz
         8YYQ==
X-Gm-Message-State: AOAM532jIukCXZgQHQhW01QFVCAVCKcELSsFQWh42wzq8UfGL1G5usGV
        UgcJahGw8UMZOLsy/QQKf2GOhK0XURXfravtwpG54HkoXy8m75Ht
X-Google-Smtp-Source: ABdhPJzoC3qnaze++wI8AAGbcyZ07KwcJ/Y8h+98ERkAnCaFbpF5kj8E19A1mAPVjCwCF2yC7bcciR2HxdltMZj87cs=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr16902857wrq.42.1612735602107;
 Sun, 07 Feb 2021 14:06:42 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 7 Feb 2021 15:06:26 -0700
Message-ID: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
Subject: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

systemd-journald journals on Btrfs default to nodatacow,  upon log
rotation it's submitted for defragmenting with BTRFS_IOC_DEFRAG. The
result looks curious. I can't tell what the logic is from the results.

The journal file starts out being fallocated with a size of 8MB, and
as it grows there is an append of 8MB increments, also fallocated.
This leads to a filefrag -v that looks like this (ext4 and btrfs
nodatacow follow the same behavior, both are provided for reference):

ext4
https://pastebin.com/6vuufwXt

btrfs
https://pastebin.com/Y18B2m4h

Following defragment with BTRFS_IOC_DEFRAG it looks like this:
https://pastebin.com/1ufErVMs

It appears at first glance to be significantly more fragmented. Closer
inspection shows that most of the extents weren't relocated. But
what's up with the peculiar interleaving? Is this an improvement over
the original allocation?

https://pastebin.com/1ufErVMs

If I unwind the interleaving, it looks like all the extents fall into
two localities and within each locality the extents aren't that far
apart - so my guess is that this file is also not meaningfully
fragmented, in practice. Surely the drive firmware will reorder the
reads to arrive at the least amount of seeks?

-- 
Chris Murphy
