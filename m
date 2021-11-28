Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4E4607D8
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358550AbhK1RNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 12:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358698AbhK1RLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 12:11:07 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598BC0613F1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Nov 2021 09:07:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 15so5446609ilq.2
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Nov 2021 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pglzJ720DlhMAP9C/Tocfhp3xcWSKlfz+h/x/mdk5vw=;
        b=d1kLHvnUQoNqWgvD6WcTyct3vnxqRUmt+Hg2cT+vOTZuxG05ElN8CcJmV79qr6u6rr
         uVGv0M2ojVbxvhN3ViLpqNpP5cvtAE4kKhWBATxbyLIO7L7ufqfqhEjDFN8qghM689yg
         SSiCNV9Np0KEwawaORYCM+on/ikEMCwDfFRR0a7yAZi3jtKt5JxAcnJJFP/AznK7oVD8
         69BpASjnTnO4C+PfBpo7RqBUBW4Um33aFUpEB+fSJwTD83a5YO3uR/bRNTcsR5WTecaU
         7Z0KZO+mnoodbyiWfauYkEDBi3VodboUtrsVAjBtZ5WxO5wpdO2dU+kzTxOZDErHBCVu
         XCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=pglzJ720DlhMAP9C/Tocfhp3xcWSKlfz+h/x/mdk5vw=;
        b=wYKxGz/6hVr9tjRzu4wcNFcNJQEXWeiZY7HAwIrfLrCLvMDrbX7jMZURVbSXPPMDJ3
         q/hRJjib6W3VNXjeFXOdqYylMhk00B+DSbNoZS/zGRSq1wUsGjzNjQ2Zhxejyidk4VcR
         Hi7AILkF8Q6/IwJgMpEXcgjY5J+l/6AD80kpYRaqTKcSXo1XE5Ml+b6QEVRaLmkN/ajO
         YsvgZoMoZbahpbpM9Xl6nYaPUScY1RyydT3UOmzDvu72aw/bopOHJODGXhTUIbriyb+d
         u0MUkI/Rk3wVKG15x7/YMXuZfnC1jlTqItdsH2thC2HeOm5OAextKNKb9/ulTxfNoIxy
         nwOQ==
X-Gm-Message-State: AOAM533gVjsDzq0cY8Jv06yIwNrcydHyqhkAPg1MlejZwnaPEvxYSr5U
        aEICGjrYpFDrWq9MaL5t5VtbkYHxuYhSMKiZmI4=
X-Google-Smtp-Source: ABdhPJxn0/nFqvQtQw+pLKKl9DK4HPXBU+AFfK8Fhlzv9tmieSTJs393NXBoW0p/3qaNxwmqH5fkoulmgvZAKOslLOQ=
X-Received: by 2002:a92:c26c:: with SMTP id h12mr5309840ild.179.1638119220152;
 Sun, 28 Nov 2021 09:07:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:3784:0:0:0:0 with HTTP; Sun, 28 Nov 2021 09:06:59
 -0800 (PST)
Reply-To: db.bankdirecttg@gmail.com
From:   "db.bankdirecttg@gmail.com" <mdialo008@gmail.com>
Date:   Sun, 28 Nov 2021 17:06:59 +0000
Message-ID: <CAFmzXQSyS-y76iCbSkFFvzSe09L3r4sRajVvVG+p9LgrHt2y_Q@mail.gmail.com>
Subject: wu
To:     mdialo008@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LS0gDQogINCa0L7QvdGC0LDQutGC0L3QvtC1INC70LjRhtC+INC90LDRiNC10LPQviDQvtGE0LjR
gdCwOiAyNTU0IFJvYWQgT2YgS3BhbGltZSBGYWNlIFBoYXJtYWN5DQpCZXQsINCb0L7QvNC1LCDQ
t9Cw0LvQuNCyLg0KDQrQrdGC0L4g0LTQuNGA0LXQutGC0L7RgCDQsdCw0L3QutCwIFdVINC/0YDQ
uNC90L7RgdC40YIg0LLQsNC8INGD0LLQtdC00L7QvNC70LXQvdC40LUsINGH0YLQviDQnNC10LbQ
tNGD0L3QsNGA0L7QtNC90YvQuQ0K0LLQsNC70Y7RgtC90YvQuSDRhNC+0L3QtCAo0JzQktCkKSDQ
stGL0L/Qu9Cw0YLQuNC7INCy0LDQvCDQutC+0LzQv9C10L3RgdCw0YbQuNGOINCyINGA0LDQt9C8
0LXRgNC1IDg1MCAwMDAsMDANCtC00L7Qu9C70LDRgNC+0LIg0LfQsCDRgtC+LCDRh9GC0L4g0L7Q
vdC4INC90LDRiNC70Lgg0LLQsNGIINCw0LTRgNC10YEg0Y3Qu9C10LrRgtGA0L7QvdC90L7QuSDQ
v9C+0YfRgtGLINCyINGB0L/QuNGB0LrQtQ0K0LbQtdGA0YLQsiDQvNC+0YjQtdC90L3QuNGH0LXR
gdGC0LLQsC4g0JLRiyDRhdC+0YLQuNGC0LUg0L/QvtC70YPRh9C40YLRjCDRjdGC0L7RgiDRhNC+
0L3QtCDQuNC70Lgg0L3QtdGCPw0KDQrQnNGLINGBINC90LXRgtC10YDQv9C10L3QuNC10Lwg0LbQ
tNC10Lwg0LLQsNGI0LXQs9C+INC+0YLQstC10YLQsC4NCg0K0KLQvtC90Lgg0JDQu9GM0LHQtdGA
0YINCtCR0JDQndCa0J7QktCh0JrQmNCZINCU0JjQoNCV0JrQotCe0KANCldoYXRzQXBwLCArMjI4
OTMwODU0NzkNCg==
