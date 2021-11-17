Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DC454A5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhKQP5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhKQP5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 10:57:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178BC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 07:54:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so10710217lfb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=AXsw+VWTHwMhXKobf3z5qbYiO//wQ/Ia9hPswF/hvds=;
        b=TODPyIwP/fMCux/ZBPwjnPY7ZbrQrXV22rqb1/4J9vU1Ms3yzEFGFpNTGVnZATV3E6
         w3NZuegRqrWGfZ+yJjFhorgfkwlj04K310yFBDjoJhkjtzUNjx7S53bcG5yKPGnVnUIb
         5JImqXP6EhpA3iBxTYPiwnqtu7iAXf8VjXjBym3xfGZ4RX9rFFG+8hB0n/iVelSa51UP
         a59ney9rL6n6ElAmr8BUY4EGp4L01rVWqTtOilh/a6z1B3lB7yZBilrvXaa229gQUCC3
         jqzsOf7ghvH9+cc1zCOPC2KMNYGiyBmEONDSCDEvxTr376PaqY1yUiWm4JF4yF+UsfkR
         v1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AXsw+VWTHwMhXKobf3z5qbYiO//wQ/Ia9hPswF/hvds=;
        b=a9QDeW9gsu+KwcRTKu5z5e8tUxHd0DHL7Zusck59RGAvgS8TxVlMb4i4oHtLmfpVIx
         KZSDP1WBC8ad+pSGSjEnej/x+kQAa91xZLdMxio2TkX08QIih3KhKVb8mXJgWaCJQwle
         1iyG7SbthWkm/L297v3TKjrjEvYmd732O3RaqyKmwMocVvW5T3ReaWwRDh2RRDq+61ak
         UnErWbRjcXAD54LO+kZt0uSYX5uK3fXwbknOR5sfA3URp+OhD8k2NJIJL7uUm/m5sokI
         unQf/SlxJzceNr2oQPLRBkex/jLeUfkAPT6K6sZZesRjs80FoAWtt6cQ0FKTUTiyV9Xi
         ggIw==
X-Gm-Message-State: AOAM531D7x7pUuZanhJHJ1LPm5HwLch16LwniUK3AN5BshkJCsKrERrp
        I8CLySjqVaMBdVAujE4qewJ6iWQg5eJhLlUmGxexqnQM34o=
X-Google-Smtp-Source: ABdhPJxkNEFUpn/i8hwE7BNpZ5GwYlk6wiBJv09/59afJmT8vHn6weTCHHe3M/BIYl+eLe3GYNKmJz7hWStEpnzjk/M=
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr8565037ljj.163.1637164490622;
 Wed, 17 Nov 2021 07:54:50 -0800 (PST)
MIME-Version: 1.0
From:   li zhang <zhanglikernel@gmail.com>
Date:   Wed, 17 Nov 2021 23:54:39 +0800
Message-ID: <CAAa-AG=RYDsVg88t7h=s9Og5Wd+ssPuGU-dTRU8GVp=bKLQvTw@mail.gmail.com>
Subject: Btrfs is allowed to set invalid compression type and level
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I want to solve the problem described
https://github.com/kdave/btrfs-progs/issues/329
https://github.com/btrfs/btrfs-todo/issues/18
First, because the function btrfs_compress_is_valid_type uses strncmp,
it only compares the prefix of the attr value, so it will allow the user
to set invalid compression methods and levels,

Secondly, if the user adds a compression attribute, the following two
steps are required. First, set the struct btrfs_inode member prop_compress
to the compression type specified by the user, and then insert an
xattr in the root tree.
When writing content to the file, the file system will decide to use
the compression method
and level according to the struct btrfs_inode member prop_compress and
the struct btrfs_fs_info member
compress_level (the entire flielsystems has the same value)

I want to solve these two problems, this is my idea

1) In the function btrfs_compress_is_valid_type, use strcmp instead of strncmp,
and strictly check all values set by the user
2) Get the compression method and level from xattr_item, not from the struct
btrfs_inode member prop_compress and struct btrfs_fs_info member compress_level.

I'm not sure if my idea is correct, so I need a little help.

Thanks and best regards,
Li
