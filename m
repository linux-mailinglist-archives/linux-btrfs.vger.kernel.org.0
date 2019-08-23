Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1E9A5A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfHWCiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 22:38:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388550AbfHWCiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 22:38:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so7595133wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 19:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=dpcgR0trNDUf12F3u3NBnBE/S2vvo6HeOmbbH9NOKxM=;
        b=ZiYBK8EnAkC6OZ3FtUhllvEH9clLF4F8BXPF4WKQNYUneJgDAasHXhaYvZs9sszAVN
         g33In+wx6KilDhtmC/EEflCBN76pEua7McXE1huFdMWcke/zAiVHQ3WZw+g/nOmxp+mj
         8afzIkVsnMaF3yU09ktdAeT7qmx3dVHsEy0vdl6hLelXfgzuY4Ls+J71Ecbq/veSGuTr
         Q73FGChfKMJKN4cXSXO6HFLfj+c3nTsr8rj2pGnPsyxCrlnqOQWmhUbxUzbhqrNw3LXd
         sMpY1JuyDbDheyTbOZHtCRegLgGZoVkueQdHRUC4bEaf6fZ3Tl5PeJzC2glAEWINUyVz
         Wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dpcgR0trNDUf12F3u3NBnBE/S2vvo6HeOmbbH9NOKxM=;
        b=VrsCzf0ZTDgyTdD1H9FHsDpG8E4YRA+9BuiAuAZw4X7f/HmCwrEN9Nnrq4Ja285y8j
         jtui8rNAh42t3xw4Xs7O6VaFn+py0q/iPh2JcZMlSAmnLClkd7dSHHTeFa730El+bn0Y
         EAbNRzFVJdYP9AsKuMHLC+fG4mEk9ErlPrUqJLghg5d7KzYW9zWpnmj3B711bPq7oVoi
         WbBy+TSS+B2Mhxu6rO1WfH1tE201Zs5o7SFsOZ4QXPxh/dbYN8esgT2G6U+OUFwO3mpP
         82pkzL3wqUkzIdHliR+SNviFg1L2AweRl76LtiDxA/o+eN7MdRWUKwc0XRCIdVlAzP5H
         VSwg==
X-Gm-Message-State: APjAAAWUwq1OOkxfhW+rjlYNsIp9RTuGu3aHUJUhbXbt0NVP741dYqqW
        gexCyggN8awkYu9RlQA+4Ll7N3pb5Lfu3Tib4Xd7EmTHmNr0qA==
X-Google-Smtp-Source: APXvYqx4wEDCn5FGhh7TwljwEIUvSh9LM0hA18mKJeDdHDJRzN/OgenFUASuVqn0fFV4uRTTQue/JVqbGE1hdnHlv2c=
X-Received: by 2002:a1c:a957:: with SMTP id s84mr2058837wme.65.1566527900025;
 Thu, 22 Aug 2019 19:38:20 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 22 Aug 2019 20:38:09 -0600
Message-ID: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
Subject: shared extents, but no snapshots or reflinks
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.2.9
btrfs-progs 5.1.1
File system is pretty new, few months, has only seen kernels 5.1.16+

This is a bit curious. Three subvolumes, no snapshots, no reflinks.

There have previously been snapshots, typically prior to doing system
updates. Is this an example of extents being pinned due to snapshots,
and then extents updated and are now "stuck"? I'm kinda surprised, in
that I'd expect most programs, especially RPM, are writing out new
files entirely, then deleting obsolete files, then renaming. But...
this suggests something is doing partial overwrites of file extents
rather than replacements.

Any ideas?


$ ls -l
total 0
drwxr-xr-x. 1 root root  10 Jun 23 13:36 home
drwxr-xr-x. 1 root root  26 Jun  9 22:27 images
dr-xr-xr-x. 1 root root 144 Aug 22 13:49 root
$ sudo btrfs fi du -s *
     Total   Exclusive  Set shared  Filename
   4.41GiB     4.39GiB    14.51MiB  home
 581.40MiB   552.04MiB    29.36MiB  images
   7.78GiB     7.77GiB     6.71MiB  root
$

-- 
Chris Murphy
