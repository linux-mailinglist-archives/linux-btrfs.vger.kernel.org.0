Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD134917B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 13:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCYMDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 08:03:46 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:37696 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhCYMDd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 08:03:33 -0400
Received: by mail-pf1-f178.google.com with SMTP id c204so1832110pfc.4
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 05:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DB39sjzlRvGGLDL1XZNi5iVlY2JoR9dCdsBIAZXjgtQ=;
        b=rmRhZaY/zD52BpO60/7RMEf/piyEiAX4FDWt5/JcEw9KpZco5YcnJbT7WbZVoyP4CR
         kMoFZ6f+YbfnozLdkwuNZWe+2Oooi4fq0aHebrQXxf7iFUWd40zjJJyd43cp8HZ3MPcy
         eyZiOyYQtRj3ugPZ4bwSKXKtyOC+EsGkfVkRbu/aioFYVRtbGQw6IkKjOSCi4Mubr2R/
         DkSbQCTlub1DcN1XxUJQIGkL4Tn6MPHaKLGt0Idbfkq7mSuIN/UkO+Wfr6JbulCMeS32
         hsyTjzz5gX6c8KnJSuBAWPeS/Yz9bhfl0Alu1eERf/uTxjkmXoTE7GFnxbfLgRjqCNdE
         X5fQ==
X-Gm-Message-State: AOAM530XqvmLRZp6RTrOj4fo/0QGcGg/09iJdRkbu1gwZ+FmEk5YXWCb
        65yY6S0jbPo2pxG1FgpQijz5+rLcPpsJGp+kVmvQGNZZ8TNfkg==
X-Google-Smtp-Source: ABdhPJz1eSSky950k9wL/tp69ls6czwzkW4osCjVouu98uQJ1I/y/NjblqoREapsH39PMD3c6llkf1IWDXjE06VgEVE=
X-Received: by 2002:a63:2262:: with SMTP id t34mr7466890pgm.303.1616673813194;
 Thu, 25 Mar 2021 05:03:33 -0700 (PDT)
MIME-Version: 1.0
From:   James Freiwirth <james@perfectshuffle.co.uk>
Date:   Thu, 25 Mar 2021 12:03:22 +0000
Message-ID: <CAGaxVV9q-uOYkDxg6_sU6Z8ZShgg3dpoQYHtfZ-Bra9=vo79EQ@mail.gmail.com>
Subject: btrfs incremental send failing. chmod - no such file or directory
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm trying to perform an incremental backup as I usually do but I'm
getting an error:

sudo btrfs send -p /vault_pool/.snapshots/2020-12-31
/vault_pool/.snapshots/2021-03-20 | sudo btrfs receive
/mnt/WDElements/vault
At subvol /vault_pool/.snapshots/2021-03-20
At snapshot 2021-03-20
ERROR: chmod documents/Personal/Accounts/ms.txt failed: No such file
or directory

Kernel details:
Linux office-server 5.11.8-051108-generic #202103200636 SMP Sat Mar 20
11:17:32 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

Any ideas?
