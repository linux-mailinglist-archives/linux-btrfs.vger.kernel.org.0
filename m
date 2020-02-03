Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71FD1511FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBCVlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 16:41:17 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38087 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCVlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 16:41:16 -0500
Received: by mail-wr1-f53.google.com with SMTP id y17so20278597wrh.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWG4zl0E2oVjyVtnSncZXLUtPczcWZy9C66UEVs/dyo=;
        b=PsD7xlHqHcXCCN9xMgQ2JO8q4FWBFwcw3Nd6LCDJV1TB1IGua/u4C1lhSGpz2ReLjv
         5bCmF1QiEpVUSXacxWbTosfA+UcPW92se8p/5RNwmvt0VgZ3oOvIRkDKa02q2nBGeQQA
         4Z2+XiDyhOMP4hFY/lq2LXbsdTSpfj4g1ufJVngmGpk6gtKv3X4tqadMBKIsxk7ZJuKI
         jr77CuQNoZ4ZI5+40dEYW3ZOmrztJfwlIUkllnuOg14Ybcy2WEgUusiUm8aJul5DU62m
         sEKTutnw9qbccVClcODYRdAMFCiaTWPKAgHLgcl+NE1tNsK0pBHNPUNhEE4Gif6O87j9
         epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWG4zl0E2oVjyVtnSncZXLUtPczcWZy9C66UEVs/dyo=;
        b=k2EDFR55K2fgshGggiKCxvygoP+aapfFACAdX/dR4qn/9sNDp4T4QvukahKS08mutc
         /u3F3iY1SdpLpUaUvaiTkRHPkQ2bdTczXohUu12NW6xp/w0NoE5t7r40LyeCWgQkmOVC
         qBW6GFoAdJUf7JWlP7guU3mpelTuwIjgZsk72d/djgL8hl4lYPDydlBW6a4BwwdZ/Xf7
         pEWAtr7TvNNddkPQXF0adursMg1gV7NLrfV8W5zEJlTzOWtYtHdpOumhUKt/YPYQwUek
         TNKd6MS1IVSB+NLFZUEegQNY2NQ1AgYfc5Fh1m8M59y/XN/aVGhG5UJOud1txOWolEql
         PfBA==
X-Gm-Message-State: APjAAAVlza0Ei7EsHeB0Uy/FCBKuKAr+KQKP5VFUeE8b4PoxUZJ+HuY9
        faQ4Ft07w7JBe9XxIrtO13PQH1G4J6aXoqipjabhAjSIT5DlkA==
X-Google-Smtp-Source: APXvYqzfJXGt+4RBL86KJLoJtHgsmJblNyIIzymvsT0CM4UPTIzh9m9DB7XNkThHn+fYzjUAjvt7MnHIBByLs8JqN8M=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr17108979wrp.236.1580766075443;
 Mon, 03 Feb 2020 13:41:15 -0800 (PST)
MIME-Version: 1.0
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
In-Reply-To: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 3 Feb 2020 14:40:59 -0700
Message-ID: <CAJCQCtTuKnsQJNKupKbmBxGpkZSqWcYXBD+36v9aT6zZAqmuhg@mail.gmail.com>
Subject: Re: btrfs balance start -musage=0 / eats drive space
To:     Matt Corallo <linux@bluematt.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A developer might find it useful to see this reproduced with mount
option enospc_debug. And soon after enospc the output from:

 cd /sys/fs/btrfs/UUID/allocation/ && grep -Tr .

yep, space then dot at the end
