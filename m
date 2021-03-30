Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8E34DCCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC3AIV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 20:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhC3AIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:08:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E3BC061762
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 17:08:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g25so7450220wmh.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KumQicIAk27yZFcxgNYxecdr+JYYtdjM2b/QYpDqHI=;
        b=kxTez9frndeUVpBTTjDn1XyMq1V6vPAHHE5QGEzSXgIqlKxydDdwUpYi/pNsyMGPUn
         blWsE8YrHh8MrbqbPp0TdObD5GwJwD14lHY0nIkHrsrZZuj8AEn/6eqgc4kKpX1N0oiL
         R5VkDbtS22RI49f1+Y3E/nvnjz6ta51dh34B95tK2J/iGN5OssuegLmbGHfgtHZ4zsIp
         KYff4ibX+EeUq7s/GfH4JoKTZHD/8rxhsnCIwP9Oe8WmdBPjHbzcqEvxT/gRLVj6V4Sp
         EQLdDiatQUSX+BvUWzd6EqEYmD5JrdBJ+jwDdN8+/WGltVtVrWroc84TaqdKjMJc8Cfa
         Lmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KumQicIAk27yZFcxgNYxecdr+JYYtdjM2b/QYpDqHI=;
        b=m4/60OJRxhdOcrz9kEETe99UrHheIFdUu4YiUnXUMZrjAav084lwgJ+eahJbfdEeW9
         nyFJk+SaQRrZWZ4ALFf20LnHug6tcGQDArIWL4StZGMIO6OXNpc8CVuJQnYQAYN+A+Bn
         Xc2kvLlu4KMl+hrcEBgAv4P4jzyu6T7NstlWGQkAW/vl/x8vJxASpsDE/26Z85MaSqvw
         WivpX5dma2CwGWR8FynvO/IR5T06+mQ8BJY+J385mdkgpMs7Uwu9+rTdBbhVRGTaotLE
         89HygTetUgjJL1eB8AGKdh9rLYs2EQpKEFZJAWcNKgc/sRlBhmj+OlyerLq4W4+5xmPF
         GkMQ==
X-Gm-Message-State: AOAM531IsCBt/XNeiXp+8kkjkp8mEUnolua3u4nzNZ0fUpnd6755tLRw
        XL0TrC19KXLMyhpn8muM+mndT4T3L4lD6amhJbcbRw==
X-Google-Smtp-Source: ABdhPJz9uqPoVFb2NQIJBue+RVbxMc5upDIl7bQnR5cJNdHnh6PhoqylsgL/54dd6SztxRhefcArKemxwaxCzOWmY6E=
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr1260129wmc.168.1617062880675;
 Mon, 29 Mar 2021 17:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
In-Reply-To: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Mar 2021 18:07:44 -0600
Message-ID: <CAJCQCtQWtnjyN88gif-tmA_cxcs+6HPgVxB5XwNmAVj3qMKmfw@mail.gmail.com>
Subject: Re: Help needed with filesystem errors: parent transid verify failed
To:     B A <chris.std@web.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 28, 2021 at 9:41 AM B A <chris.std@web.de> wrote:
>
> * Samsung 840 series SSD (SMART data looks fine)

EVO or PRO? And what does its /proc/mounts line look like?

Total_LBAs_Written?


-- 
Chris Murphy
