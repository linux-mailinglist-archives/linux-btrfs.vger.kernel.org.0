Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB0128C7F
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 05:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLVD7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 22:59:43 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33702 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLVD7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 22:59:42 -0500
Received: by mail-wr1-f52.google.com with SMTP id b6so13275653wrq.0
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mslUPSlVc7y8DP5PALCfXVYjMX8WP0R5cl3ZwedhpE=;
        b=KSsfvN1WBlgWGmJ6Rzd00Cxq1YIZrDFmyaHWTTUtnP8g5VLRaN8h5HF1NjfoI3HHnS
         Vghx3AR11r35KAIHivjRwI+kJs95jk5dPoqJCGTgdmi95XVoGJwALB8sJgamS2lxSIAy
         FVKA5DIFip7XvbiWstIZM26Rd5xdj/MLIY2cnAYmzqdUq2P7RYxd4tLhlBBciN0p/+AE
         rWDqgtDQk2s0jc1UIGO1jOC4UBAdViMG1iLy6GI2xOZjrfO4N3HSzbxu18hPJUmaplsd
         YNOzLx7XCJb2s5haOfdWSJhdBc+EIPRrlklaj379yW8fOOO1iojSMjmUR0w4BSEcF16I
         ppGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mslUPSlVc7y8DP5PALCfXVYjMX8WP0R5cl3ZwedhpE=;
        b=F/DzU/eN5N5bDYQrClJl5H9fCY6IG8yvs33Rju3wPnifXvL59XCVnYzNS2Jtet3z7A
         vzOds2nmTuR2ql95tdD3J3gtD5x/KmKNuDy2Uz8KuPreFLaWnvGJvN3CUr4v8BLnNUEU
         aysm1EA8W1fFHr/ow5G/6sX/L9zwB+pHXdk+zvOsS68JQOsenytQGsXsVo4z2Rm7nOJk
         bxx+YTzLIFrZlwri4MyrqI8f3JanPodgoPgkoHiyeVpSz5MfCedqZKGYrSIKkg9GFpYu
         41fJB70GYrJvHHmgVn+o/fGxZniX1HYoFGyJTy2n5erTb2lpWzIAe1vLQgKcNz6H0WII
         xMNQ==
X-Gm-Message-State: APjAAAXAtDp8Ah8SIdNo/6zrs4G2xbmWBILevtPGdWxRdaXz+DO62nWn
        6yy6qzfRxaoabORzc12j3HWxa8MPnvP2AXdjGtNpPau+zElkWg==
X-Google-Smtp-Source: APXvYqwtbd0FS2V62f7Cr3q46m+Pd/Q3ViQprTu74OhK5gl85ITLVR2Ut26+YOXQYmOJk54DJTb9Tac6K9qi6CXKkN4=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr24042227wrc.69.1576987180065;
 Sat, 21 Dec 2019 19:59:40 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c0ec818a-91ca-cfcf-a1de-821b551b19aa@suse.com> <CAJCQCtSOPvuyDLbchpRA+gfeDnD0B5h-CGEKKaUMJjAf25Xk7Q@mail.gmail.com>
In-Reply-To: <CAJCQCtSOPvuyDLbchpRA+gfeDnD0B5h-CGEKKaUMJjAf25Xk7Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 21 Dec 2019 20:59:24 -0700
Message-ID: <CAJCQCtTrbES0RZgyGzFyjB3ii+ejAqq7E8ZFpw8VYcEfGPUJCg@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

nvme0n1p7.blktrace.0.txt.tar.zst
https://drive.google.com/open?id=1IKS6_4Kij1dcRqAezTqMfUwMDggtnrmD

I'm not sure whether this NVMe drive supports queued trim, or if it's
intentionally slow to avoid the pausing problems seen on non-queued
trim drives? I'm offhand not experiencing any hangs while issuing this
trim, including scrubbing this file system while trimming it (seems
ill advised, but I like misery). However I do get a circular lock
warning...


Chris Murphy
