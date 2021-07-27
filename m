Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686E3D7B57
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhG0Qrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0Qrq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 12:47:46 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4AC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 09:47:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so13110316ott.9
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l0wp1PUIKErOH9wMhDBsxTq6XHtAXld+jtcxj9jPxbI=;
        b=QaIWu6ASTzp3Q38Ip0HrN/dSZoA/eU8Exg0A/5fDv9D3lUaF4v6vq53ICcnOi98lXH
         ODalGkabb5hbzhSWYfBEJQZULvxHm+QfmqjlCl/FOt9qhlhiaxlDqXWEt3OXB4YyE253
         x2ryyhI/WFZUpGc/+qrxnSRhCgwDgFl+VYzicguO1V33P5UlixB858pZMEe0UN4fmCu+
         B3PToJ6qSzlCu8hK2svCFk2manrRXE/owSleVREjiuk41jvOQXMBfBP3wv/16PmEQgFT
         MSMkj9TjdcHnnWK3vbmYNFcTd/t2Ng3lBJLVOOiM8EK9NoX1/5ulMz2zm3HUICxdp8wg
         aZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l0wp1PUIKErOH9wMhDBsxTq6XHtAXld+jtcxj9jPxbI=;
        b=TF4ndcAeLck1J+/PQDsCu1l8i3bn2hZldlo89ObCgQToXVpK74UwKKC7uPMbaqEfeh
         dzgbII9URzJ5QUV+AnvQxsusRioiDw9J7zmxzfGpg381RLIpxT35ID8hoi/zXlgawJ6c
         ZDruyruIdAlzfbQpGy6f/DwQ5bzoD/ysPeYwqgbWfM6Rp00sX+igPmIXN5HJL9EiFF0O
         56AzqYwNJlLuPTbuQWzgJKwP3w9pqW0Z3Weyvo32e1Z3bcClFmSjsFTTNnOyZsOZcLVY
         pZXC4BFQjllaUgThlwvy3NX0RePR2E/PQTw13uGhZP5xWuQt0VS3qWeYUUtnONE9oa7q
         OXqg==
X-Gm-Message-State: AOAM533kUdmFF6yULOP5wtbHnQFnXOMozspwNpe8AFiNRYyM6cKRemWc
        Oha1lXzFb4X9s7TEs60a6OZBp7Cz6Uu/UmrmVJqfoGil/I4=
X-Google-Smtp-Source: ABdhPJyvXCQB7lUdN/3a2I/hg/qOZPOl1DS4Dc/sfX1EJsvwfjTFtCTZK7+MCwEpyNNB0GxETFHoD6r3nbqz/H2pQ4g=
X-Received: by 2002:a9d:410b:: with SMTP id o11mr15979936ote.211.1627404464897;
 Tue, 27 Jul 2021 09:47:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 27 Jul 2021 12:47:34 -0400
Message-ID: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
Subject: reorganizing my snapshots: how to move a readonly snapshot? (btrbk)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm using btrbk to create regular snapshots. I see a way I can improve
the organization of my snapshots now that I have more experience with
this tool, but it requires moving existing snapshots to a different
directory.

I would prefer to avoid re-creating the full initial snapshot in the
new location and I would prefer to avoid losing the existing
incremental snapshots. I also want to preserve the existing parent
relationships used by my snapshot tools (mainly btrbk).

I'm thinking about using the solution mentioned here:
https://unix.stackexchange.com/a/149933

> To set a snapshot to read-write, you do something like this:
> btrfs property set -ts /path/to/snapshot ro false

My plan would be to change the ro property to false, move the
snapshots, reset the ro property to true, and change my btrbk.conf to
match the new path.

What are the caveats in this plan?

Thank you.

Dave
