Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A746C36A500
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhDYGE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 02:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDYGE7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 02:04:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C5C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 23:04:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m9so39735513wrx.3
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=+Feda9kl0hTbnfyyw2mexF+xbCCw8HIknFPVHV6LAeA=;
        b=spFaIeZYi9Gj33OVIxATkT15/zN2H6Ji4p3B7uSNcrceUWrmfvr2FSWrm4L6LxaT4Q
         wqkrkiQpA6wYjlWui7Q3uiePdn1xkbGV0lvQkidShz1uZcyfBrv7AXri3iMbzv8RwgSH
         D46C9r9gWhofj0Zd/FOUpOWoRtxCCtpp72aHZSVLMlOmHpppINBPn4Z0Pwb/JPQaPXHP
         +TgSO1KorHByVm+LcAT+Anl4zVH3W+culhYQK4hqmobYP4+jjv9CxC/2jnSo8tl4Zv+d
         Rs5EsMcUOrxigCIKUzDQeb6iGObxQXAYiaYTfqH5HniM+c7OUDQwZqZ/Ou2zY926ak+f
         5bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+Feda9kl0hTbnfyyw2mexF+xbCCw8HIknFPVHV6LAeA=;
        b=t+2bQ/V2aVJjThuV6IJb96xmye1CDbv5qbUnHMTzhDX2FMrYzFz2DhyesrU+qR3DfQ
         fRaCQvyX0cVixBF0ARTSrpW+k5I0MJbP/IxFv/gKM8hryH2nPVUO+Wa8xfzQpQJ2FKFC
         4/oLh6CreWxatIxeet7bFqT6Znsse5lYuytQ43ClJQ50AC9hmPg60NifixYLe4Hd3yZB
         1FPH9qv9jKYgH7BX07islb3EW9hFdPxneMxXbSZLpEQKHnM4spKoibh0hFpmy+AcaxYC
         NcB+v34TsZ//wk6kTskTlgcWRB+OIMZB1CBFkPKntJAHb5DFKvJh+M0LKBrRamyPjLfE
         CKeA==
X-Gm-Message-State: AOAM532puOfW2CCZ1hXeddk0cjHXQ0hgum52ugr2e9hNWXoEAd+mhU7h
        qfRNzHIO8ITmF25tmPtOX27Zvy0kBKsiwDIyAcDN/ElEaI9IQvcM
X-Google-Smtp-Source: ABdhPJzWyhgAjxiQuQDLoe/pARq1uxkasKlaktSq6zoFPg0pK1zSs6MBU2QgvvrpE5HhnnFb71MsAfNsB9wqZuqtDXE=
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr14992850wrc.236.1619330658548;
 Sat, 24 Apr 2021 23:04:18 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 25 Apr 2021 00:04:02 -0600
Message-ID: <CAJCQCtSsRXnR3CUqQ8d17=7=_7OS1dSaaT30G1pQrtdO9SwWsA@mail.gmail.com>
Subject: sprout device is never ready, can't be booted from
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filed a bug here:
https://github.com/kdave/btrfs-progs/issues/365

But I think it's a kernel bug. Kernel is 5.11.12, and 'btrfs device
ready' for the sprout always exits with 1. Combined with the systemd
default udev rule for btrfs, this translates into an indefinite hang
and an inability to boot from a sprout so long as its associated seed
is still attached.


-- 
Chris Murphy
