Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17841508D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIVTjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhIVTjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 15:39:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF94C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 12:37:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p29so15990174lfa.11
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 12:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=shk22Bv/ta/xt7MMYtJ23l/I1u1GMnLgl0sa6hC6ab0=;
        b=TVMxLfcMm1I9XSuS/hMehvr4YFWH/ePMw/OpYcuh804BiaRxd0ywHBYEfeeT+qIXdC
         ktJS5NfYoTnHX7kNdSiXisyd5xM5al/dx3li1ZCLBdOXZHEgU2qumQoQYn3v696SD8Gg
         TZsAvNvrQ/SwlacVcE/Suug5W8Q9FO+9z3Me4wyp+zmF3uOBXbxVEIid+1dPGn/G8FNq
         C18YzQKEikxGj4KfI/JEjqkGzLf+3vDQ1FVjJDBdUznJ9A9+BsIDwEk4DxINXPizJ58i
         CkaGjFLKee72Q8+v968LbBxPBPO7GLe8W7/I39/i4Hab9Jz7v5N9anUWVqRLbOdnfgjc
         puwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=shk22Bv/ta/xt7MMYtJ23l/I1u1GMnLgl0sa6hC6ab0=;
        b=yvbJKCsnQ/IJc+1WMPiGcKBYmf+Z4/RZl57k1VF6i56Eqi78uFnDK84uMhxeJWNJxO
         OblCvXuyzRGq6ff/ZeYauKYYMrGaVRMReULo/uHSd6qGEFfIxpWtLf04iu44fXwyJJEj
         FlJJM2tcMAVJVr7dDi1TqZxwKEZam/0yc24v30hF0frc9x0BdZDsQYG2L9TWKN6AqHEj
         4SEYpVRELcZOJ589AQhO4JlgEuCXCry3TjqqAwV2Bp4TXCxNZnB7gGAL7ZtTYTf9qght
         Ou2JLuIPvlDhWRcNQy9NNIlECa8gYYta/eN92Lk5BPnU4HyShdQrXIu8i60vwZRUZKK+
         5T7w==
X-Gm-Message-State: AOAM531ijvoZqrL9Z6vFqqDAVt7Te4tgypWrL+/uJRBQ4AV8slP66RnD
        AjVQ6ZJ6voINBa/vf6yaCX+jP+MvAd8xI88RHXa5YkE855g=
X-Google-Smtp-Source: ABdhPJy70KirA7IyASjD1ZW6maFBnxYbl2KyznLieMa6CmokjZ7AhAEHKGH3mVYa20Uv9xVtwZ1fBXkXoBj2gYvJOIo=
X-Received: by 2002:a05:6512:22c3:: with SMTP id g3mr591660lfu.577.1632339471632;
 Wed, 22 Sep 2021 12:37:51 -0700 (PDT)
MIME-Version: 1.0
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Wed, 22 Sep 2021 20:37:40 +0100
Message-ID: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
Subject: btrfs receive fails with "failed to clone extents"
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

The problem is as the title states. Relevant logs from `btrfs receive -vvv`:

  mkfile o119493905-1537066-0
  rename o119493905-1537066-0 ->
shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
  utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
  clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
- source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
source offset=0 offset=0 length=131072
  ERROR: failed to clone extents to
shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
Invalid argument

stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
on the receiving end:

  File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
  Size: 145904 Blocks: 288 IO Block: 4096 regular file

Looks to me the range of clone is within the boundary of the source
file. Not sure why this failed?

Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
and btrfs-progs 5.13.1

-- 

Regards
Yuxuan Shui
