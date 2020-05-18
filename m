Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56241D8996
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgERUvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 16:51:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153FC061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 13:51:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s69so381732pjb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mautobu-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=EhYIquXbO1oGfDW1Y7jHZ+ok5dXDluqz6dk6Sjfl/Ds=;
        b=CtQ1BuUeTEet0cYc4DgLlpQXAveoE5ccCJVuUjKG6EwLCgVnQw0GTNVoHqNAEXGk52
         Hockn+4rIxU4MBkPbR4MlnYlz3sHEqkG3LDOH/A0qss43/3gGys5zs3+roHiSU+9W9lr
         swlLERvYvMUnlAu/8XY6iD/N2I1Dk0TXktTepQfva6P+rHmfc++/JA/y4SmGaSI+5nc2
         Sd2FOTMata/jxHxDu3Spr5Dn5yiO2i1z5V9gzs4/xz/54phx1WZuKtO3k44wbPtQ8ofw
         QZNdVcJASR2JqzgkDfIBxxc4xAM0ikIDZSix9tabwwrSjMcbqMqNnCR9MNu6D6+MJQVF
         PjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EhYIquXbO1oGfDW1Y7jHZ+ok5dXDluqz6dk6Sjfl/Ds=;
        b=I9rYWU3Aj+oor4XJoM+h5K/E+wysqlhJsrHCFb4WHOV/AmRxIp715euKjTTDwqoyLX
         ZjiLzUJamF08l5dTsrsNkEwAUk/yTrPT+eKFCA5gOx7MhN4Aaiz+YNsjCzDJiMSsSRU+
         bhhW26coO5YN5INAtPv/ysQBoE45ooNYgqHlZdgN3dXgj+VyqFgdY+g9zW24/z6ur6DY
         PuLkBZNMGt1MJcOgc7rUeyDbWBq4NpziG2oR9CYj6E4fS6b12glFa/0jdKNzugXZkO/Q
         df2ZZD2EfsNEoEKY99z2yohyLHlfo0/hStNzbyYcnRQmg3J4UogN9JGTMpnQulJ8MGIg
         9DUg==
X-Gm-Message-State: AOAM531AIyjIrYgEO4YPB4+bws27WKlYwLIp9tDhAB6bpU2SI4/tKG3I
        RPL7aHWcgMPH7irCP721ieOQs5BT4OCrs+W3U2IVubWVL+xojA==
X-Google-Smtp-Source: ABdhPJxVlMmY7Ce1dw0FnKgFJgtxpvu+nzAwktiewIocTNcw3isdHvWkqpb3vnTN2sdpoJK8N3TqQSu2N8n9+GjN5E4=
X-Received: by 2002:a17:90a:1303:: with SMTP id h3mr1262083pja.44.1589835073931;
 Mon, 18 May 2020 13:51:13 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Engwer <justin@mautobu.com>
Date:   Mon, 18 May 2020 13:51:03 -0700
Message-ID: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
Subject: I think he's dead, Jim
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm hoping to get some (or all) data back from what I can only assume
is the dreaded write hole. I did a fairly lengthy post on reddit that
you can find here:
https://old.reddit.com/r/btrfs/comments/glbde0/btrfs_died_last_night_pulling_out_hair_all_day/

TLDR; BTRFS keeps dropping to RO. System sometimes completely locks up
and needs to be hard powered off because of read activity on BTRFS.
See reddit link for actual errors.

I'm really not super familiar, or at all familiar, with BTRFS or the
recovery of it.
-- 

Justin Engwer
