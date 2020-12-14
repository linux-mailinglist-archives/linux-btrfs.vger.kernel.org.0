Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E678F2D9CB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440298AbgLNQ3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439790AbgLNQ3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 11:29:06 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7524C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 08:28:25 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 143so16086496qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8tHqTCbWCJMC2xkdujEjoupjQA3AkqGP4lG2voQNXBU=;
        b=hKi3MYgNBQS4O4wePeErF+bb83/+JTZ7yVfA/D2x39BiSBVFVge48ZuvDAbicEBoUX
         7kW2HeLWYPbSgWW73tQANl+HSiJiAXJNZDFO/c8at143XubOMdmavYPU/tTfDL8XAsEg
         eWU7HGCBxyiUyFIIk/UWjLarwqNbdAQ1oKC27ZXJYNCvw29P+DtwwSe+e/tZGaJYQcH4
         nIGvYcB/XFVCuixEbvLRFGiGyCiTWL0kp/oveJFbbC2ERa2RrJtJSLx6vsFYu5cJB5XF
         a76/XSHXU86ZwY6T427x2DnCuby5tvfUl2dlTbJV34a0UzjSZY0FwyxTlYspJoElNx5D
         h1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8tHqTCbWCJMC2xkdujEjoupjQA3AkqGP4lG2voQNXBU=;
        b=MGrGuolcojNCpVJP/9KruIuEVpJxqGb2I2k4R3cGr51dEU7B5YufxoKnorT5mwd4P0
         gY/5uA/Iv6D50o4DODjQLZE2WFKDT/wzfAJHjBsfwA9UG1NWqKyoB3znfc+lky927KJo
         cPYd6G/8qaB2u6GIuG3WpAsq2CtpV8XBAuiYaupZkGoFZbcu4N1mKajftAbZPu59ZWrA
         2RJk+CSZLetFZRAnnh0DoeFWTB1kfG/Q3nhT9xXZXPVjywpGDDM3UDv1ubPve3U6Jw8u
         /66bTKX9DVvPYIGqZ+6G/tEC/SX5s9mtuij5V0zNmUgD7MacaBVqEM24BRk5I0tB2XCh
         l6XQ==
X-Gm-Message-State: AOAM532eXRANaRALdpPi7lZqOO3TsnJ+Zyj+17eS7KgulB++pojeR4L5
        pgfGvbarpLmzldpW8QT1W0aZmrY+IjxDB2jpHniq7HCkoeyo4m23
X-Google-Smtp-Source: ABdhPJwmTo/hKOEX3IMv4wgxwXqqnS85ve2Qbny4FL73seSH01MUBnxuXZrJtBjaXJcttXC0ZQ/Wt8YEE1H6VCpOTY8=
X-Received: by 2002:a37:506:: with SMTP id 6mr32744091qkf.168.1607963304770;
 Mon, 14 Dec 2020 08:28:24 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 14 Dec 2020 17:28:13 +0100
Message-ID: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
Subject: Odd filesystem issue, reading beyond device
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Upgraded from 5.9.6 to 5.10 and now I get this:
[  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3e33
devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
[  589.602444] BTRFS info (device dm-0): use lzo compression, level 0
[  589.602459] BTRFS info (device dm-0): enabling auto defrag
[  589.602465] BTRFS info (device dm-0): using free space tree
[  589.602470] BTRFS info (device dm-0): has skinny extents
[  589.603082] attempt to access beyond end of device
               dm-0: rw=4096, want=36461289632, limit=10971543296
[  589.603108] attempt to access beyond end of device
               dm-0: rw=4096, want=36461355168, limit=10971543296
[  589.603125] BTRFS error (device dm-0): failed to read chunk root
[  589.603412] BTRFS error (device dm-0): open_ctree failed
[  834.619193] BTRFS info (device dm-0): use lzo compression, level 0
[  834.619209] BTRFS info (device dm-0): enabling auto defrag
[  834.619214] BTRFS info (device dm-0): using free space tree
[  834.619219] BTRFS info (device dm-0): has skinny extents
[  834.619825] attempt to access beyond end of device
               dm-0: rw=4096, want=36461289632, limit=10971543296
[  834.619844] attempt to access beyond end of device
               dm-0: rw=4096, want=36461355168, limit=10971543296
[  834.619858] BTRFS error (device dm-0): failed to read chunk root
[  834.620205] BTRFS error (device dm-0): open_ctree failed

Any ideas?
