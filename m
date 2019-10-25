Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0FE47B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438964AbfJYJrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 05:47:42 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35258 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438883AbfJYJrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 05:47:42 -0400
Received: by mail-wr1-f44.google.com with SMTP id l10so1563010wrb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=RX3dlZUKSdD/mblhXscvsoUL1t0ggHrf1RzAkd1EaeI=;
        b=vytd8p1W5tD99tivoTe2JD7o5UbHqEsG1bOc77sHGJdJHV+mlxjj76m7btOFJcW013
         fXryF6KqkDI3lJv/9WFfaDv3Tfbnz0eExOgmBa0mBhXLErfyld+FUEqaU0ZgnwPY/uMu
         nXailAjR44ZTTFQO4J5SCmTMYpB9YEFkFOu++e8vatfWtUbrKTHlyMFqKTMS/PwBDXNu
         yn/zGZbP3rchqQuyjtnIJfaQHOywTENgwc789Fw9fP5O+RZAP/a9gzieXd8ATP03vwfl
         69n4AJ6yZZI59kQZKcV+9sF7VB8WQhfpA6HCLHYnHs8SsIjc0yfaEQjuUCaTVEiMU3d+
         0rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RX3dlZUKSdD/mblhXscvsoUL1t0ggHrf1RzAkd1EaeI=;
        b=b0vkrN/FLK3wMm8JTHBmDWBVVWPvkrBHhgLeU5lEUWAR0V/CKBIzIIm0IV4jqRamGC
         Gq4cqmY5EZpW1AMloqwkT/5TjiLFab8GKEVAKH3XDTw2NtmfarsXR4UfZsXQ/ey+/6xf
         DeT4epPlfKytw/E6xxXDFFUmUL0isEGNFPkx4OEqY9wxGnYFyaWl7EiEx0khV1lYrYue
         f/SC9RrMrreumymxUz131QHoNvblSOdHLxrVAxJif+66Wn1BmD5c4TKZXdtzudm3FM7Z
         8LptQvSpvTpTWR8MXPUWn48XhABg+agdV28MTDtSJPJmgR/hn+A6xUOyy9xNAC+7N/Cu
         Y/jA==
X-Gm-Message-State: APjAAAVU8XEZUDv36egh/3cMS576OFojTAHpGiDa7VwRKntBjb7XBtWJ
        S3jT0qGZmnzKgYUOmjtn0/2sr62SZzzw6FB5KNr6aJ8RRFqMlw==
X-Google-Smtp-Source: APXvYqz/xUrtoXDCG319onE6P2qOb03E4nGBuflVC6lBQHLrdlj0nCtW1G7hrm5CMWNQEuEeBrSDTiKP6S4jr7mPLwA=
X-Received: by 2002:adf:9799:: with SMTP id s25mr2134560wrb.390.1571996859792;
 Fri, 25 Oct 2019 02:47:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 25 Oct 2019 11:47:19 +0200
Message-ID: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
Subject: Does GRUB btrfs support log tree?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I see references to root and chunk trees, but not the log tree.

If boot related files: kernel, initramfs, bootloader configuration
files, are stored on Btrfs; and if they are changed in such a way as
to rely on the log tree; and then there's a crash; what's the worse
case scenario effect?

At first glance, if the bootloader doesn't support log tree, it would
have a stale view of the file system. Since log tree writes means a
full file system update hasn't happened, the old file system state
hasn't been dereferenced, so even in an SSD + discard case, the system
should still be bootable. And at that point Btrfs kernel code does log
replay, and catches the system up, and the next update will boot the
new state.

Correct?

-- 
Chris Murphy
