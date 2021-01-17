Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B32F9563
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbhAQVIm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 16:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbhAQVIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 16:08:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE42C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 13:07:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d13so14571346wrc.13
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcHF6bfXZ0xZvdnONBwka75NrIV+7NMu4wlv50YJ0B8=;
        b=zAtdpnMGOqVMP7syia/Ay+dgMdXftEW7QYZYLc0VX6OMMRbW41wecPFnWhgYwyrl+z
         l2TfMMNpMTJx3HqRM3+/zBqzri7qiAL4vKWzmMyfemDXL5C3/C+wbI8KQa0DJDq9CZDv
         PoyKMPT/ArpQ0yrDKI+foeKv/XTgUsUBu3b9cfJT2a4o0eUws3qwD4HqEjP+6n8RqDaz
         qfQSbnUL2mfOPcQjK9jFuE/PuwWjk0dbuXKGkhIDKkoULJ5qv5dh7qmKj487GneMAZir
         pPUtGpUEzydrb7xmR72/IjQ+Uk0LnFqEoJ4J9BElil/ugNvcEyPByUGtvUr0JJWj6zwM
         3Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcHF6bfXZ0xZvdnONBwka75NrIV+7NMu4wlv50YJ0B8=;
        b=n6QacWTRlPa0PmNblwc3VR+C0cYACxGWs8PHzJKaePPYB8IF6lNa5p0NLUWCW0e6E1
         CTB5iyP62WGupQJ8bF37TT9X7pS8WSTkJFu8rGJJ4YnztF9TE4gOdQEHDLxc8BOxF57r
         z9xTDQb82RT7hDnhUVU35EtfTqyXmyDefRwFwg3TlwLeSPo8MdhpQdW5IbJV6iMBGXQT
         s8A40JX1Z+XedKSzBVWuuRtYBv3CFD8CgJz6/mkRH3sOHNCef9jvA/kZHSYpfGFxLEm+
         Bxr27FvVaQDMY4fCSPPgYJQhGYefgG528QMkUoxYIH+2shrekgGCvpHaKAL8BFUnhv9B
         IrtA==
X-Gm-Message-State: AOAM530kQpOE1ubsBjkYn2/sfuDDzJnEkuFObvG7I+IuQjCtMIfe+vXL
        RNhj7VD6mlqdiHu/XLqtiHXKk++/476VcauC763Uxg==
X-Google-Smtp-Source: ABdhPJy5zVwmpiiavQ9MSNBqiYu/RPlUBMhpt1JsE7m3A9F7m4JNqMQ7InTfHhn2vAlQMr/IqnMm6n+VLbwmu7+GCU0=
X-Received: by 2002:a5d:5105:: with SMTP id s5mr16941535wrt.252.1610917678572;
 Sun, 17 Jan 2021 13:07:58 -0800 (PST)
MIME-Version: 1.0
References: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
In-Reply-To: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 17 Jan 2021 14:07:42 -0700
Message-ID: <CAJCQCtRydKSXoYSL15=RHfadWESd_N-ed3eknhbX_95gpfiQEw@mail.gmail.com>
Subject: Re: received uuid not set btrfs send/receive
To:     Anders Halman <anders.halman@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 17, 2021 at 11:51 AM Anders Halman <anders.halman@gmail.com> wrote:
>
> Hello,
>
> I try to backup my laptop over an unreliable slow internet connection to
> a even slower Raspberry Pi.
>
> To bootstrap the backup I used the following:
>
> # local
> btrfs send root.send.ro | pigz | split --verbose -d -b 1G
> rsync -aHAXxv --numeric-ids --partial --progress -e "ssh -T -o
> Compression=no -x" x* remote-host:/mnt/backup/btrfs-backup/
>
> # remote
> cat x* > split.gz
> pigz -d split.gz
> btrfs receive -f split
>
> worked nicely. But I don't understand why the "received uuid" on the
> remote site in blank.
> I tried it locally with smaller volumes and it worked.

I suggest using -v or -vv on the receive side to dig into why the
receive is failing. Setting the received uuid is one of the last
things performed on receive, so if it's not set it suggests the
receive isn't finished.

-- 
Chris Murphy
