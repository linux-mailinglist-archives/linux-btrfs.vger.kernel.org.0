Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D978B3E4480
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhHILQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhHILQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 07:16:10 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67999C061798
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Aug 2021 04:15:48 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u10so22992404oiw.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Aug 2021 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CbDYf9dY3JI48sPHkjUaEjq8kHKqW0CUt2xBW6NUraQ=;
        b=jZn7UVwPt4CfZiPOOY8GGbIaEe6FLdk+6A/mX5frmrG1Z59DoGPFUDk4j4ouXG7f3c
         6earUJVOZSN4fXfhI+FyVNnC2b9Xz/7UqrX13DZdz2XVobXzxbkkFkOLU4C7Z+Eie2cZ
         UysW7oQMt/Xb/OykKugUOn1Z2AnGUlo7Cx8B+c4QGOkzraUnZ0yMIRKPUY1CwqR+GPwb
         aPrwV7VZXpqxAgf9nmgN8Dl6xSORRBU+ZZcfSnzpeGjrP+6QaSwFKZcPTmjFm3b8vobr
         LM4D5R/ZDuC496eUdjZEjg6VqCRzu3sLYznCLJSB2siz3viY5noGLZ9i5nk73L2tYCfx
         2usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CbDYf9dY3JI48sPHkjUaEjq8kHKqW0CUt2xBW6NUraQ=;
        b=TG+exBisvuNjY6ADaTbZ+hYBkBJphaVVb3KPbTYRbnS6CB1bsrfAgD+FhrGPb0rOpZ
         5z4X/TGZqDq4s+PUTdBOU3uBESHAvDH1gaHXcrqSy/n6A+lj81BKarMuHGnSiHqydAOW
         x9cLhVJhubCV7DSzaoKP5K7RiYqBgn/qUc3i/iNF2MNRnyeQOifiDpFSlWnFav9NDc+q
         caPUE2+eUu2ZJg9+Yl96hEwC+IDY3zum3S72M1xwvXFsrYS+GMll9RJUPDbrR+FfPgvG
         hd6auOkkRBDDjAyH6gUIvsthruz2EFUiySf7UovTxHedOnTSpjsop7TZHTgARI/05VuY
         zzFw==
X-Gm-Message-State: AOAM531h+7tIEPGXNA5DAVA1GKnFM9TNvmvHHiDEFjy9Iz3B2QQoy1wk
        XJFu5BlUuyha8M+LJOJ9NfIf00zt1Fl5/YEowGux/I/ZOKK3Fg==
X-Google-Smtp-Source: ABdhPJwx7t2d4mLMNGn16MZsgMtifENe+5RiXYtIZxSzLXGLLcxIXHJNR365rCWHvLiBORzucRj9uB2rmT3kC8AVoVY=
X-Received: by 2002:aca:bcc4:: with SMTP id m187mr610765oif.164.1628507747651;
 Mon, 09 Aug 2021 04:15:47 -0700 (PDT)
MIME-Version: 1.0
From:   Serhat Sevki Dincer <jfcgauss@gmail.com>
Date:   Mon, 9 Aug 2021 14:15:36 +0300
Message-ID: <CAPqC6xQcJa7y2mPWxRM7_kNtdawFgEtFtGLP0K2A_UXU0X6u8g@mail.gmail.com>
Subject: max_inline: alternative values?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I was reading btrfs mount options and max_inline=2048 (by default)
caught my attention.
I could not find any benchmarks on the internet comparing different
values for this parameter.
The most detailed info I could find is below from May 2016, when 2048
was set as default.

So on a new-ish 64-bit system (amd64 or arm64) with "SSD" (memory/file
blocks are 4K,
metadata profile "single" by default), how would max_inline=2048
compare to say 3072 ?
Do you know/have any benchmarks comparing different values on a
typical linux installation in terms of:
- performance
- total disk usage
What would be the "optimal" value for SSD on a typical desktop? server?

Thanks a lot..

Note:
From: David Sterba <dsterba@suse.com>

commit f7e98a7fff8634ae655c666dc2c9fc55a48d0a73 upstream.

The current practical default is ~4k on x86_64 (the logic is more complex,
simplified for brevity), the inlined files land in the metadata group and
thus consume space that could be needed for the real metadata.

The inlining brings some usability surprises:

1) total space consumption measured on various filesystems and btrfs
   with DUP metadata was quite visible because of the duplicated data
   within metadata

2) inlined data may exhaust the metadata, which are more precious in case
   the entire device space is allocated to chunks (ie. balance cannot
   make the space more compact)

3) performance suffers a bit as the inlined blocks are duplicate and
   stored far away on the device.

Proposed fix: set the default to 2048

This fixes namely 1), the total filesysystem space consumption will be on
par with other filesystems.

Partially fixes 2), more data are pushed to the data block groups.

The characteristics of 3) are based on actual small file size
distribution.

The change is independent of the metadata blockgroup type (though it's
most visible with DUP) or system page size as these parameters are not
trival to find out, compared to file size.
