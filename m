Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24773A1D86
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH2Opt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 10:45:49 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44337 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfH2Opt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 10:45:49 -0400
Received: by mail-qt1-f173.google.com with SMTP id 44so3895971qtg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KL4Im+hJWt/lQ3qTjt3a3vc5uINc9kN2Cmjx3Tzs0is=;
        b=dB/tkEVRYP6xZg2t5GCXte3H5Ar9cMgOL5KQeJOR7z6Jrskh5yuUHtzGPzak0jD4mO
         xVBNNaNMLrTtXvBcZ0HevT/ktfkztvbvpS0Aae94qKlHr+hrsotRhVPlS9W9A1rBvSpc
         pouOylLFOIt7sFNRoNJHsnjShAhtLoy6Zi7PbPLIyZP2abTmW0ZMgX25aNYsUT1m3JN4
         B9blEss56IZ/o0qqX60On8x6l7Tu1CAscaeNSzKGi9iWvEWHDob6YhQ9hPgawEvl2p9c
         MY5MCsAjQJVZiBV73PD6pIj2HruE3lgKd9Yeyh0422h4nZBLIc+Nk/Z1JScsPr0fbfoT
         3rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KL4Im+hJWt/lQ3qTjt3a3vc5uINc9kN2Cmjx3Tzs0is=;
        b=B1lI5/1W4KrFSPYC47q3oMm89A+VOZGJtEqveIaxkb76smnWXm5BoryOOsKndt0lhC
         /QVw+aY+MXE1rfBDnfX6xxKcqtFm82rvDW8n/IiHxnqU9ai5tj88ncYmr5MAYEFRZQYs
         IiU4veDbB1NzdMMffZXGZcvHFQWiiz8ccm1hRhztmatoSH0jRCw0ck+dnnJZdH8b+GHl
         rKSyaKcuA12iYd0Z/gPGtFl5/g75/0XEduKkJ3/wCBc1JeCBjX04/Tv3SmchCFytb759
         2qmwwg+uXO/3OiFTOeJ5lpXRyiF0MGso/KAfn4T06KiGw6fsOeXVdqyXPQ62PfLZAb4v
         S7oQ==
X-Gm-Message-State: APjAAAWRv9MHClBVhmzTtpGTwvhZD8+TR4ZTSqeKPS3VbQM3KnK+3T8E
        tfix1rlQhzyEwoP3DNKMkBAbjY0obKqJ4ETcebCw6WpE9S59bw==
X-Google-Smtp-Source: APXvYqy0+7rryh7vFdMnNSflzAZTpnMWoqfYV1pnAJIJymH+oYjUd1t/f3bTLhxPDGFxKaT8i/sxvIr+tbvOhwYSGc4=
X-Received: by 2002:ac8:1866:: with SMTP id n35mr10123446qtk.108.1567089948119;
 Thu, 29 Aug 2019 07:45:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: matianfu@gmail.com
From:   UGlee <matianfu@gmail.com>
Date:   Thu, 29 Aug 2019 22:45:37 +0800
Message-ID: <CAEgruXsjz36vEZhULWneZKY4yD3x2n05yR8qx9eiN-GOVvfiJg@mail.gmail.com>
Subject: Need advice for fixing a btrfs volume
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear:

We are using btrfs in an embedded arm/linux device.

The bootloader (u-boot) has only limited support for btrfs.
Occasionally the device lost power supply unexpectedly, leaving an
inconsistent file system on eMMC. If I dump the partition image from
eMMC and mount it on linux desktop, the file system is perfectly
usable.

My guess is that the linux kernel can fully handle the journalled
update and garbage data. But the u-boot cannot. So I consider to add a
minimal ext4 rootfs partition as a fallback. When u-boot cannot read
file from btrfs partition, it can switch to a minimal Linux system
booting from an ext4 fs.

Then I have a chance to use some tool to fix btrfs volume and reboot
the system. My question is which tools is recommended for this
purpose? According to the following page:

https://btrfs.wiki.kernel.org/index.php/Btrfsck

btrfsck is said to be deprecated. `btrfs check --repair` seems to be a
full volume check and time-consuming. All I need is just a good
superblock and a few files could be loaded. Most frequently complaints
from u-boot is the superblock issue such as `root_backup not found`.
It there a way to just fix the superblock, settle all journalled
update, and make sure the required several files is OK?

Tianfu Ma
