Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273261B4E76
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDVUpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 16:45:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875EC03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 13:45:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s10so4237325wrr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EH0UcMZ9EGk2MKpR05y7EIrtWI2KIS5eLuh8UMj1M68=;
        b=hg/KZ5/o8+0bLgTdhdof62YS6fAPiZ2tR9yvRAENdFx95CPOxRvF+R9kKGc+JVCPTS
         7NMjykuMxzUAdLaxacm6HxjNU89R5XagTggCr1Vcl7BQCw+AplCOi8HaqbwcPg3VuQjq
         fawMF4MsNSRRH3tkVkbcrMRnacEsiM8IQxiXDePO9KOXTS/unAeF4CMmndvyOkNqBCjY
         xxXXQ1uX14B8t3J65MleIDIDkKqLmmVAy7hOkc/8ftA8uJOBsS0UBERdRoPnTEGjmGNm
         ES0FdfI3WWNsQrZGVONv/L6iZZ3vPJd9XL9f2rPS2G3SRyBaq4xHuq96rJbb5nw+hfc4
         ilmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EH0UcMZ9EGk2MKpR05y7EIrtWI2KIS5eLuh8UMj1M68=;
        b=rkE/uhojXCXOaT1JnifCX3AXDlfDmae3FqgfedvGu/zWtURHk5OO8GFgpRqGROmPlq
         YyGWVNe2vvqKyOW7TMhp0ARGHoMks1GlLG2TtHwGmIzfQB/fPGwb81Aje3rU/z7L9GoB
         XjLGqysmC+54Sr/ixqvZoXJT5S7qRstlLgEUZoYunaW/CKstoFDb29GzgfKnDsfo50JL
         +xzQBBJex5kyjEH+JPgFVyDYX7mSdAlcL/4tdMB63bacb/FUQhnlAdJLWpUnGr1iJi+3
         4t3Gh3LITB7pOwjOSNDqAwTcd3Pav7qFD2qjj3/wScduvW8vfDtSP3JP2GVDerN02SyG
         0UrQ==
X-Gm-Message-State: AGi0PuaBsFaqbd5OGoWAbcG+LJ85C7CaDx4PIdVGqHOUwoSQoqIvbApf
        aFooQ9AP2+/IR+V3IOL66dPe1K7e4Iafqd57G9OloCmtV+c=
X-Google-Smtp-Source: APiQypJ/q3i/jQ4Ue+iLaxgWmkU0+5zQpLU2hxxVt4YHy+AtXddE1fy50Qe9uoKEqrqOlwob3WzK0RFLvG6RJ/tYiLU=
X-Received: by 2002:adf:84c2:: with SMTP id 60mr938368wrg.65.1587588302522;
 Wed, 22 Apr 2020 13:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
In-Reply-To: <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Apr 2020 14:44:46 -0600
Message-ID: <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Marek Behun <marek.behun@nic.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

e.g. from a 10m file created with truncate on two Btrfs file systems

original holes format (default)

    item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
        generation 7412 type 1 (regular)
        extent data disk byte 0 nr 0
        extent data offset 0 nr 10485760 ram 10485760
        extent compression 0 (none)

On a file system with no-holes feature set, this item simply doesn't
exist. I think basically it works by inference. Both kinds of files
have size in the INODE_ITEM, e.g.

    item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
        generation 889509 transid 889509 size 10485760 nbytes 0

Sparse extents are explicitly stated in the original format with disk
byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
extents exist whenever EXTENT_DATA items don't completely describe the
file's size.

--
Chris Murphy
