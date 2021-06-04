Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED0339BAF1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFDOfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 10:35:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FEC061766
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Jun 2021 07:33:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 131so11857152ljj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BXBYPGhC+y/UipqV9HYLLsVZeU9Jzo7vu3n1eHaaxlI=;
        b=WRzYNR394EMJ3irJwMhGp6z77nng0LTQTkZC3Rw1No2lgJd0eeJ6qrud8eye8QucGx
         ltuiZuAZVv42JIcjDGcr5wSefAzasLSbuzSa3ogIkejd+n2JqDlzXdLcaJf7pIg8RZeY
         gw/RV+VDlf0KFEaZPcfTCUqakXtFVyqWeleTTUU1iKNBkYA/z1nZhjDnIBOP8TZOtY6k
         NzUiC2z82ba6VDELjFxEMELeAhpM7dTIK9KxhpQX/sUzmptWpIc/Gd03t43FgX97bG5d
         lEUXhfWxn+6/oHn1tY4PMRCC5oF1qoYqw5e916we8pKtmffVjbpwYxDLpLNQPOVnevJ/
         /oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BXBYPGhC+y/UipqV9HYLLsVZeU9Jzo7vu3n1eHaaxlI=;
        b=Jf7FlNmD2hdNIZwRw+iJnE+Hc2tE5arS0gJRCU24S2h3c7GsIuLJzUzCxDJfQ+9DUS
         LsbXu8y8Jewmr9xCpqDXg5B5w47ij241NFm+rv5degPOf2vz0ZKCgn/YYxrtqDqELcVR
         tnMTgTqOhtacCOS0jM0eKdZu6D5gASi9SjH8o6KLLSQN2B5D//cJDvGra4EJkc7r5wNF
         B1XmyPNqe6vHzs2KlerhRqBAURaYHHffSf541V9Sxe06LXSV0BomSiZO+kbVR7Aqlwlt
         efqz/RUKsP8vN//kviJbDRMo8cpoh3k/XIQBpo31s/Xst9FvWh+JGyenqFOJf+xafgA0
         BdFA==
X-Gm-Message-State: AOAM533UWW3LPVhlukqdPTRFe2SHcv1/vWX1v2kIcl1DhkdEYoO7l3d2
        oJ8A0aP4tTTcbIjR50AWSl7cUGaoAD9ZmPecBfbQGAnRufSkfQ==
X-Google-Smtp-Source: ABdhPJwxmmG92jsvXLIqtrJ0+IiH/KHE48lLqNnUDuS+SwAkRp9e9wqFak7zBw9XTcC5fIJuVKodnkQGuC5PljkBMIs=
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr3668044ljg.227.1622817207518;
 Fri, 04 Jun 2021 07:33:27 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Fri, 4 Jun 2021 22:33:16 +0800
Message-ID: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
Subject: reflink copying does not check/set No_COW attribute and fail
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I've just bumped into a problem that I am not sure what the expected
behavior should be, but there seems to be something flawed.

Say I have a file that was created with the No_COW attributed
(inherited from the directory / subvolume / mount option). Then if I
try to do a reflink copy, the copying will fail with "Invalid
argument" if the copy has no one to inherit the No_COW attribute from.

For example:
[tom@archlinux mnt]$ sudo btrfs subvol list .
ID 256 gen 11 top level 5 path a
ID 257 gen 9 top level 5 path b
[tom@archlinux mnt]$ lsattr
---------------------- ./a
---------------C------ ./b
[tom@archlinux mnt]$ lsattr b/
---------------C------ b/test
[tom@archlinux mnt]$ du -h b/test
512M    b/test
[tom@archlinux mnt]$ lsattr a/
[tom@archlinux mnt]$ cp --reflink=always b/test a/
cp: failed to clone 'a/test' from 'b/test': Invalid argument
[tom@archlinux mnt]$ lsattr a/
---------------------- a/test
[tom@archlinux mnt]$ du a/test
0    a/test
[tom@archlinux mnt]$ du --apparent-size a/test
0    a/test
[tom@archlinux mnt]$ rm a/test
[tom@archlinux mnt]$ sudo chattr +C a/
[tom@archlinux mnt]$ cp --reflink=always b/test a/
[tom@archlinux mnt]$ lsattr a/
---------------C------ a/test
[tom@archlinux mnt]$ cmp b/test a/test
[tom@archlinux mnt]$

I'm not entirely sure if a reflink copy is supposed to work for a
source file that was created with No_COW, but apparently it is. The
problem is just that the reflink copy also needs to have the attribute
set, yet it cannot inherit from the source automatically.

I wonder if this is a kernel-side problem or something that coreutils
missed? It also seems wrong that when it fails there will be an empty
destination file created.

Kernel version: Linux archlinux 5.12.8-arch1-1 #1 SMP PREEMPT Fri, 28
May 2021 15:10:20 +0000 x86_64 GNU/Linux
Coreutils version: 8.32

Regards,
Tom
