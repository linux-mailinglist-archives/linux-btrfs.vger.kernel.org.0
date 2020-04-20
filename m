Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A11B0635
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDTKGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 06:06:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82EC061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 03:06:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f18so3218853lja.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4zynTPqENvMXrmtdk+pxlaqK5qkqzg9d6n6SDaO5ilg=;
        b=a3286pdwtdsMqGPKBAx1oFObxh96RQgcRT+7/2M5XtJuQ7YK39J0bwH5HhHhXnXtBa
         t7GakHfT0BNLhXkHHPkrlF5Yl9KTs68UV475xUXenHOQW1daOYx5cuUkf0mYROSfNe+w
         gLYa5omEbql7NR6Pc0rRZpKpZPjLMMFKgcEpk5An8DHjfuQFxdtUF3NewGzJblvFbrll
         P7oyLfEMtqIBNTX0W3j9XIH9PH24ThTbLw8xx+yvXYq06X7AoqA24cXY4zSA5eMcWGhO
         h2wE9EKsckb02DeF+Dvi/qugvOdaq9x7VXsUvgIyasC6yRVDWRK27CiZcrCGnal75PX4
         KYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4zynTPqENvMXrmtdk+pxlaqK5qkqzg9d6n6SDaO5ilg=;
        b=l91UC7Nz5LRCz+2QurHLy4d/0KpU85nuWo6acQacAYcuRCT5SebjQguNDFUSenlHuD
         VrvXJBqKaPOB3GobUwYksuGEverYjrcivH81sMBVpQA3YjrpF1wRvyT5SPdKPvK+NaoO
         kIliPl6SguKpLUEEVqx2CfVbTuROzPRXlSA9IVuioLGka3uAlkGgKHnJqgXg2hEhNtlH
         ibgsHMXm/PdCq5/q0qAvKf3LKWBpfRmHzp7kWdidu5a/WN+KStIuJt6aZ86C754rmkkr
         l02kK4uF59eoR3QZuIMtquy9dnhfvr9856AgWF2/mDYMez0rBBIdR6P6wALvPa5urxQf
         5XjQ==
X-Gm-Message-State: AGi0PuYJ62rJwcyAeX1iJrp+/DJXKwOuwHlD+4hkhyuJhCheuwVTHjPX
        4B3b2AxaJ9ZQA1Pe1GFcpFxXXG/ZLCVfFYjEnwaLwhir
X-Google-Smtp-Source: APiQypLPFvUZ1WnrQeWfQPc049GfXQnmVAYtlJYH2nSejGwkE5PI+eW7Rxthd/5mNjf6Z3ed4fmLyotpLZuswn9L+wU=
X-Received: by 2002:a2e:82d6:: with SMTP id n22mr5006637ljh.100.1587377194020;
 Mon, 20 Apr 2020 03:06:34 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Gilmour <nickeforos@gmail.com>
Date:   Mon, 20 Apr 2020 12:05:58 +0200
Message-ID: <CAH-droy1qkV0mfWY5ojRVej7fGnznmSiN9+sPoxvPF2Oy5JSLA@mail.gmail.com>
Subject: ERROR: Could not destroy subvolume/snapshot: Directory not empty
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I'm trying to delete some older broken subvolumes, but I'm getting
following error:

# btrfs subvolume delete /tlsv5/@.broken.20190830a

Delete subvolume (no-commit): '/tlsv5/@.broken.20190830a'
ERROR: Could not destroy subvolume/snapshot: Directory not empty

The output of my subvolumes list looks like this:

# btrfs subvolume list -a /
ID 257 gen 1097743 top level 5 path <FS_TREE>/@.broken.20190830a
ID 258 gen 1097611 top level 5 path <FS_TREE>/@snapshots
ID 259 gen 1097759 top level 5 path <FS_TREE>/@opt
ID 260 gen 1097808 top level 5 path <FS_TREE>/@tmp
ID 261 gen 1097806 top level 5 path <FS_TREE>/@log
ID 262 gen 1097612 top level 5 path <FS_TREE>/@pkg
ID 263 gen 1047152 top level 5 path <FS_TREE>/@machines
ID 264 gen 1097706 top level 5 path <FS_TREE>/@usr_local
ID 272 gen 116 top level 258 path <FS_TREE>/@snapshots/1/snapshot
ID 301 gen 22476 top level 258 path <FS_TREE>/@snapshots/2/snapshot
ID 302 gen 22481 top level 258 path <FS_TREE>/@snapshots/3/snapshot
ID 324 gen 54829 top level 257 path
<FS_TREE>/@.broken.20190830a/var/lib/portables
ID 351 gen 268851 top level 257 path
<FS_TREE>/@.broken.20190830a/var/lib/docker/btrfs/subvolumes/641bd5ec86e1c5e1f2d504a0656da736bafb858551067aca7f1b84c24c1e7d33
...

Am I doing it wrong or how can I force the deletion of this subvolume?
Thanks.

Regards,
Nick
