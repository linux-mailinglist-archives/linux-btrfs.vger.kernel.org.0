Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B93407F0B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhILRli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILRlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 13:41:37 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019AC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Sep 2021 10:40:22 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so10098203otg.11
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Sep 2021 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dpOhBieWJd7i6pLhDg1qu+pk3l7iY6Gmm2MomGaeBHc=;
        b=qelkM5h69rrAs+u73IXStiqxzHajJKEVYbF0dJrkBoRdfXFJmXfWJRZGsJ+LVdixeb
         ukJsb64dGjOwdUATEKM0BisPYkYfWNAdufiuJoYFvgrCIMnZktPe7FmiMcfVZ8V8tUZG
         UKcrN+T6yP9jMWtxFhBh7BI+8y8MIgUGFZPo33h+wKlhqvtYNdX7Pwrdu3WcCzSwc/4L
         3a1eTLCI1/3xsfjbA73+bNld11jI5VmQNFXhlZL0bIlJ7o81pcC15wnlYg3DJfw4k5gl
         kS3fUPVOFUy9qNu2rlIyFgX54hj+6Kmyp35vCRzUHCh446awuOUpeT1hirV62e2MpiD/
         fogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dpOhBieWJd7i6pLhDg1qu+pk3l7iY6Gmm2MomGaeBHc=;
        b=C/wfTTjDI/4jdCRF3oTSveJlsjlzRuWCuXxhPtyVVdyTTNA+pNbtL5um20ftZnQV2I
         9MFqN+ofD6f2NT2LfVaCqG2O4UpDjmIDP6P0H9wOkgNJaA9cVwM4YVzV530+VTD/zHxy
         aYCoRRs9OfF/Tw+ySr96/G49bzWB3wd+i5I+kA9agBnTV53Q+hOkUWp4HXRBnYW58Y7l
         bZqyLSeFwYpOxFKWWQhKs1CTOXMsJB3fF7BqPfHeKYuQDBwUAy40WEEJA6XA373oo3rb
         f5KPno20IfVmcxdEpCrpqHS/kWkTKAecGWmkY0/ajuAm/Dm6x3B2IDS0huPC+VLI2O7w
         /yCA==
X-Gm-Message-State: AOAM5320Axe0k6p5Ubbt28G0mG/gEFK33k33sy7FFFIe733hfRT4jxLd
        tscBP1PVuxJxdMPrckokJa9t2IA7fab8QNlSyAtGMAF5iyw=
X-Google-Smtp-Source: ABdhPJyfnxKyUf1ky8ynKwu5NTvOapiuleLJkFU0H876ZYT/+XPRt/8Vlo7cWJfRZOXR+FDu9O+G54R6j3Nr3U2F0ak=
X-Received: by 2002:a9d:4786:: with SMTP id b6mr6752673otf.329.1631468422003;
 Sun, 12 Sep 2021 10:40:22 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Sun, 12 Sep 2021 13:40:11 -0400
Message-ID: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
Subject: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Are btrbk-specific questions OK here?

I have a small LAN with a fileserver that should store backups from
each attached host on the LAN. What is the most efficient (performant)
way to do this with btrbk?

Each host (laptops, desktops and a few other devices) does hourly
local snapshots with btrbk. Once per day, I would like to send backups
of each volume on each device to the local fileserver. This has to be
done via SSH (as NFS isn't supported by btrfs send|receive, afaik).

The options I'm aware of from the btrbk readme
(https://digint.ch/btrbk/doc/readme.html) are:

1. host-initiated backup to the fileserver from each host

2. fileserver-initiated backups from all hosts

My guess is that the second option is preferred. Is that correct?

Assuming I use the second option, do I need to be concerned about it
initiating a backup on a host while that host is also performing a
local hourly snapshot?

What are the disadvantages of the  fileserver-initiated approach?

If one host is offline, will the backup procedure continue on with the
other hosts it can reach at that time?

Since deleting snapshots can potentially be a costly operation (in
terms of performance), should I split the process into two steps,
where one step would pull the backups from each host without any
deletions, and a second step would then prune the backups according to
configured retention policies?

How many backups (snapshots) can I safely retain for each host volume?
I would like to keep as many as possible, but I know there is a
threshold at which performance can become a problem.

I mount btrfs volumes on the **hosts** with these mount options:

    autodefrag,noatime,nodiratime,compress=3Dlzo,space_cache=3Dv2

And I have the systemd fstrim.service enabled.

The fileserver is a dedicated backup server, not a general-purpose
fileserver. I plan to use most of those same mount options. Do I need
the autodefrag option? Will autodefrag help or hurt performance in
this use-case? The following message from this list caused me some
confusion as I would have expected the opposite:

[freezes during snapshot creation/deletion -- to be expected? November
2019, 00:21:18 CET]

> So just to follow up on this, reducing the total number of snapshots and =
 increasing the time between their creation from hourly to once every six h=
ours  did help a *little* bit.  However, about a week ago I decided to try =
an  experiment and added the "autodefrag" mount option (which I don't usual=
ly do  on SSDs), and that helped *massively*.  Ever since, snapper-cleanup.=
service  runs without me noticing at all!.

Are there any other recommendations?
