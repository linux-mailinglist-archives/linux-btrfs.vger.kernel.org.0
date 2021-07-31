Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835EB3DC248
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jul 2021 03:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhGaBTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 21:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhGaBTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 21:19:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85EC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 18:19:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c16so13411837wrp.13
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 18:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1IlCQG2nylzkwBArXiE9b9/tRMvgI4ZSVhwy0Extsns=;
        b=AM3D0/QapFdPd6hbwYGUIPiZEZOOSGRrERo9VYRXa2YVrqWhih6ezqzGUbmcJ9dO+9
         jzZu75u4z9UlZL0TijrNSDA3HTZbx+zI6897zIYp76tKBpspVKvjyA/ChL74+gVkg6jm
         Q6uWbgzgClJKIvshmZz7xl+PXRECCjZZ9xN3Cfo8cqTxBoacWRpZlLHKHZrpTh89mubN
         ef8TvxmKIkcfXy4VEUpLC1F1vsaPN4dGqlqc/G+fpQByeROmS1DoRiabrM7T4rcI7ram
         mOz7jl2w8rUfhx0nq7vmDPD8q/gBvCsv/qvJ9Onq4UG78Srn1rDIn/awkyi9dHYfN1UX
         8gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1IlCQG2nylzkwBArXiE9b9/tRMvgI4ZSVhwy0Extsns=;
        b=OOa9JLiLRGpUUH2u4VdySWd+PvG6GrM1IcOV2SAeJua+ckBkbfv5yvXJzZ2cC0BB7L
         46UqCdabi61YXH9/pd9UXWi8vJcOX7ZYdtO0+r9uDhXdOpBBOPYALZn0wg0BUBIult/x
         AOA/Ndat/CBpBmhMDCpXyEckwUL3t+GzEDyQ7b+qFer7Inq/Bllp2obbRfO0rpvqxH3k
         uLQClo8JQ1wUIGDjUTeKpFH4/7xWYDb8akkpZ9Uxr9armGcCECDGAEKNEbWpetD3Pnyj
         YmJgxbvPDmamrNrvKkdVkYSSsVNcgLtEzo2//m2LYrWNC/kLhqnxatmvvgyC7qFcA93Q
         FCcw==
X-Gm-Message-State: AOAM532DL8P9YymmctG6tq9nfPezVgSmTZtLumhgwotVESKu974a8fyk
        X/8aSIDo81UL3jFGFC5nXLGTySUxewgOIdXp5nIln7rpx/IW2oS4
X-Google-Smtp-Source: ABdhPJzMUEQzKMD/V1GHs25btlkQVIWDtrxW4cJpoHBgVJU+SbgFjgoPe6vYzI2YS3GZM0Y8m5i1n0U2IkfacESYOeA=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr5949973wrq.65.1627694381967;
 Fri, 30 Jul 2021 18:19:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 30 Jul 2021 19:19:26 -0600
Message-ID: <CAJCQCtSvgzyOnxtrqQZZirSycEHp+g0eDH5c+Kw9mW=PgxuXmw@mail.gmail.com>
Subject: 'cleaning free space cache v1' on first mount with mkfs -R free-space-tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-progs 5.13.1
kernel 5.14-rc3

mkfs.btrfs --csum xxhash -O no-holes -R free-space-tree -dsingle
-msingle /dev/loop1
mount /dev/loop1 /mnt/1

[31600.866297] BTRFS info (device loop1): cleaning free space cache v1

Subsequent mount, this message is missing. So it's a pretty small
"bug" and not a regression. I'm not sure if mkfs puts something on
disk that looks like v1 even though '-R free-space-tree' is used.

-- 
Chris Murphy
