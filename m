Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16CD3BC3C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 23:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhGEVqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGEVqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 17:46:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ED6C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 14:44:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j34so12202321wms.5
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=nFBZ1j0KnoTG3edhLjZcVyytjngsaLBlsENKAFtdwMU=;
        b=mY52WUqMgrPvPuPZLYLa//5p1X7OKcYwgYIdpeACex9XSnW4RE0wYamR0w6UMRHOP6
         Uwej+o861i2IZPXOQ1b+S2UzHB1Oo3s4jew4cQ81hcV0aO95UI8y0Kqy2daqXd7WFRzg
         OyqPGGbGg5sXkDXezmpC2NZc0J7ovjTL9KXq7T1VHaGVDsfxONj9pJy1UYzPNXugxqHw
         0oVXbLoYj7xpyZg83qVgPLcmCEfvodaW8v+Z2PbjTb2DIuDs90trq5foTDIlH3T++Qpy
         KsRRI7RPihRymwsTap1XNnNGE3eyAFsSKe3uJMSLM2Z7hRq94oY3+ABM+YuLVl/+1ReN
         ukKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nFBZ1j0KnoTG3edhLjZcVyytjngsaLBlsENKAFtdwMU=;
        b=jeXUVz0AeYAUCHiYEj36uShP240wOYI3dMRSYKsyX1O+KzZoV+8R8wopYm+6O8OXsC
         ZHgYb1/ZHP5j0wQh3bdF1zKtYGgSB3yIFNAimaa3n5lorBRkY1Vx+naKOy9VZpsKiBYI
         OS7qbK3Nx+aHoy3IEFx/AYXgxhKDy+tlkH84HskQO9LdSes8B8SxLeYqeaxwdv1PugJm
         hxlDlxtCdjKb77P+9+iWL3uyyx5+DiNENKBatr2wMQf7wbjaeGxwg5Dbnhry7FJRbW0I
         QCQh+Huw3TUEMkIp9raECi7IQ64nTfoYshRG00HfSBO3seRrAmcM+/mtDmwPNwcBqxoF
         eNnA==
X-Gm-Message-State: AOAM532sit7CxT7S8xojx1aq5p3meRdkkEqQXdhWtgI8cGDwcc9H+RL8
        a/eGuc3Kyy/sQMfu13kQMerob6wLU8E/XIDXvcKTZIG1RlCjAYZoE/E=
X-Google-Smtp-Source: ABdhPJw54ucoxdFZJ3YnFrRUQYKjcptV5Hvb/DKDvXA0rLtUOP73Xrl16e2E0QiFQ7pyM8AfQTrlJfR4WF62f8ZhLJI=
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr1073248wmk.124.1625521444670;
 Mon, 05 Jul 2021 14:44:04 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 5 Jul 2021 15:43:48 -0600
Message-ID: <CAJCQCtQjx2xmYvdoGj5+Sx9_R+5SZkXMkUg0kzXnEM5ZvEx9=Q@mail.gmail.com>
Subject: [bug] Conversion of ext4 filesystem to btrfs fails with error.
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream Fedora Rawhide bug report
https://bugzilla.redhat.com/show_bug.cgi?id=1979179

This is kernel 5.13 series, and btrfs-progs 5.12.1. Looks like the
conversion segfaults. What I'm curious about is it seems like
fsck.ext4 shows enough space but btrfs-convert shows there maybe
isn't.

>      7705257 blocks used (58.79%, out of 13107200)

vs

>         free:      578277376 (1.08%)

But regardless it shouldn't crash. The other curious thing is that
total bytes reported by convert is
>        total:     53687091200

but the error before the segfault is:

>btrfs unable to find ref byte nr 54126084096 parent 0 root 2  owner 0 offset 0

Which I guess it can be a valid address if it's a logical one?

-- 
Chris Murphy
