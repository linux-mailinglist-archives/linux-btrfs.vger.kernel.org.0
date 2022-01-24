Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6264976E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 02:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiAXBS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 20:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXBS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 20:18:27 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2FC06173B
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 17:18:26 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id r65so42580005ybc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jan 2022 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=z9iHmGCAS+9eJJD9OwXLYJC67TD/3Dj8uIpRPuIP2a8=;
        b=hPzEroWwH3B3M4Y0bO6eGiZTB0NzDWOufqXPKjdDOgAWoH2SjOtQizggIoAoHEC51c
         gykIy4lG5kZAUe/nBx8mMGQDlc0CfikVuhFbKCRZz0zvWgRTFhE6dlAMD9jo5oPkxdQZ
         A9S1zTGVjcwzcsCLI+wcoeEPwOfO46kQncKIgUbDazOe8BXCzAWS6Lkdd/Rbs+1BP0ZN
         M+0XKFdG6I+uFCLfgXc2hbg5Fr6FsSGhUphKQutgXeUlSd04uvYZKZWEvy1Yftpjejsd
         Yh+oX/Ytq/1iQ7QeR10UYvwOy47nqZW790ceG+Wyg59T3msFKaYYpUxohXBEYat+nr/t
         snQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z9iHmGCAS+9eJJD9OwXLYJC67TD/3Dj8uIpRPuIP2a8=;
        b=iHJ5OIgvvaClUMPoncDBUrz0pAkTMo0h3lIgVlvhrqxPlvpdKxamjW0zoAerBRPAL/
         iS9/NedugH5JaGStYaswq+s2YD1ClFMtfDEG1p39iCQl+5eofqBuJMcUPvXD97MeE/e2
         lj/fxy4aIMa+p423qLOsIAcZLtuIP9MJcYdsa3r3wWVofxMw5LJRnsXsrrUf+Q9Vc9I3
         IrR6FC/qh6djRdVP8HDugVv2WMJB2lKV3A2hKK+SUWAjEHhyjKxQEP4ItlijqUPW56Ug
         JW8p0ihyYQzvDU/utBQpxg8DRr0nCmav50dPoweUwUHBUPCEQ0UOT053lPmzsDyY8bK/
         COsw==
X-Gm-Message-State: AOAM532jz8nkrVCh5j+9W6HjXpPTQVigNspKHh1zX4zytlwl31nTubKL
        rl/baf6VoE/CXQ0hx6vUBi2ZuXx46krxP48M4M8lWAXUTmtU9vNR
X-Google-Smtp-Source: ABdhPJz1d63HniMD5D4zH7Xp/zm352b9lS7xE2kADXjc1fiP9hqKZLaZ/G90DZo0UojZotMHq+N+1kVcbb2B1hZDw3g=
X-Received: by 2002:a05:6902:110:: with SMTP id o16mr19299893ybh.385.1642987105632;
 Sun, 23 Jan 2022 17:18:25 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 23 Jan 2022 18:18:10 -0700
Message-ID: <CAJCQCtQFpM8SLZf54zx1AAp0D1+FKC3MSitQ7pbT144+4jEWCQ@mail.gmail.com>
Subject: btrfs-debugfs in master produces a syntax error 'maxu32'
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running into this today
https://github.com/kdave/btrfs-progs/issues/440

But btrfs-debugfs hasn't changed in 2 years so I'm not sure why...
python3-3.10.2-1.fc35.x86_64


-- 
Chris Murphy
