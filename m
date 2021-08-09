Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011693E4625
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhHINJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhHINJG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 09:09:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CFC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Aug 2021 06:08:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u25so23399101oiv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Aug 2021 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xT4WxKQe8p/95d8+Ocu4mu/XYlIgkRcpYK162NqG2mU=;
        b=DKJTFxV28FCA6xUSWsfubXelRqlzcPIGcsH/k+g0dXI/9mjBzzqQqP7zPmW5ytQvsN
         U+buBNZcQJfE9cc1y9DlwF/BugiTcYBN36c2XuSQMi1tRpQJLk+iQvMX5noUQzEvdqXM
         JNvT0nrxkpkDl14RtH4HPd4Z9/m7N0aRa7ProW2uGCmj10YDXAsZVXs1+APbXCgpbUTj
         SxGppEOxcFS0qlU9S28QQzFZSt7C0+sUsmcXIWIj/DDfIWjVeGygP/y0nUUJY2It+376
         CcOvt55H/IQMMO53CmuK24gzdIvG9/akGzi3ONrNNdmC/XPXaPCK3+0EAZzt38A5cr0F
         S3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xT4WxKQe8p/95d8+Ocu4mu/XYlIgkRcpYK162NqG2mU=;
        b=P0dDSkGnUahZeW4Ft1zrLBli39SEdz/EhBB0HeLspMVFxnXpIPqB2rTA97DKXhKXBW
         0FIzygxTpDwRyqGNRqCJKoKfBh04jgN3tghqIkD0q6QvyZg1VaVN56qqWzpksqfQReYQ
         i+x2DvW+fMPkHVf5P4SYN+5Add180SxBcPH+i9O7yYCL7Gx9oxcmwt3yS9yZCggAKhGk
         Yiojc/XNZyBTjOAiPGeXjpl8dNuaW9bIPGyjfHWfUl15NhleW5YKuFQPQgliKcUxt1F3
         tK3GX313FubBzVfn+YZBUVhpmSEoYE/Zsb0kc8xxTDtv4BCZOlUiJ5zzJYS255LMwY/m
         aDhA==
X-Gm-Message-State: AOAM5303bOVW/YgVtAUDiRUPSlSyTFB3PODWMoDZcD3GKCALREwFzlEF
        fcN5tj5P2vC4dVlVh2oWM4VaA7uztLfeyd5Th3O+k8cW+jNC6Q==
X-Google-Smtp-Source: ABdhPJyA1632JhF3YBex1Z6OaG3fKY7dJCXPuflgZ9/fuwganrYl6V3xZVh7ZkQJRb6CwmDZKQxtE1ErW2A9Ae1t+QU=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr4746986oib.44.1628514525488;
 Mon, 09 Aug 2021 06:08:45 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Mon, 9 Aug 2021 09:08:34 -0400
Message-ID: <CAGdWbB7nnKK-KOO2rFn336eCHZoo8skj2VpdSy3wemDk8kvbnQ@mail.gmail.com>
Subject: How should we submit logs to this mailing list?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

How should we submit logs to this mailing list?

- paste as plain text directly into email?
- attach as plain text document?
- attach compressed file?
- other?

Thanks
