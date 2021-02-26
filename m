Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B4326655
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBZR3Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 12:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZR3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 12:29:24 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5507CC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 09:28:43 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q14so11495855ljp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=nfhYhhUoR2pCqMTHUNPNgO8uvmAp2Cp7XBHNPpmJIgY=;
        b=dkfCiJ/8641CX/CDdfXQNVBrh8EqPedsdTCS21950ZUqCvOETQUD6+llV8MHDJoFbb
         C04PcGSZ+yTMHmfLX3LO3kFQsOAeD3oc6ajjgwlYcSlAJy3oQRZvuebGLeMxz3R1aFnR
         gNHlnKXacPmmUTYpGCLFHC4un/9oIEgxadbBYpocpBSf9bT84C1GqRN4qu/xAwMTUyHb
         CLYZqPiB1//1sl4S5lYSxEBBBU9pLqxbspxc1ZEqK50dghFhcr1paxIKjUXTWiwBSkR/
         2/Pj9Hr1aaq92ifoVS2VlCBvwsgho7J8CD8+HboKpD7nrPAdxAUQl15ACUWNpslfXpvk
         qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=nfhYhhUoR2pCqMTHUNPNgO8uvmAp2Cp7XBHNPpmJIgY=;
        b=sUXeoVccItu8Lyu93Ky+FmDETabRTS4eJuLO+vK9MKCFOKy6JIry0+13KXHAK3BA0i
         piMUdYuyJl2wH3h1g7pc615mwG45yYN3UCTxMtJ2yeqaLmoz6KJRPXf+1hPEW0DRwDHB
         iGY0MJWcf2T35/JBJKkOnvmmcmeylrqtJ9vhs/WTaw8zqLUzleLTKfwMuxl1X+13+ayI
         G2AgDrVphQ2KrhgVmxlIl/PEVzEZ1jMnLtXgYqSeTbYy+r7tqx4lwaCIPTtY/q2W5Bih
         Dpf9iyAnMDNipJ9x5rVuU4MY2Miaq+yLuYETJ6zZB6Rp9QBBH6I9D5jXWjQzhXn2t9bL
         NO+w==
X-Gm-Message-State: AOAM532BRlETi5GypIGqqaNqRmjqdSvNSUKJ7jEd+vIQe9nes74gCQKd
        BvsDPcIkzlMH92cs8FEbcsNNYROKVoCK4/A2sOQ=
X-Google-Smtp-Source: ABdhPJyqJpDh5uDeg603fu7a/MTZYlBUMlzKJ65p6b8OC+kmvRGHgtZlg0SOibwgWVR1T16psUmAPeVqlhRrvZfL8mw=
X-Received: by 2002:a2e:9b8b:: with SMTP id z11mr1839828lji.432.1614360520523;
 Fri, 26 Feb 2021 09:28:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:5516:0:0:0:0:0 with HTTP; Fri, 26 Feb 2021 09:28:39
 -0800 (PST)
In-Reply-To: <CA+ESkMegOqpbLkM7TzAP6KdayEXeSJMDngn6EGumupei6xrU0g@mail.gmail.com>
References: <CA+ESkMegOqpbLkM7TzAP6KdayEXeSJMDngn6EGumupei6xrU0g@mail.gmail.com>
From:   willson mutanda <ncvbz0291@gmail.com>
Date:   Fri, 26 Feb 2021 09:28:39 -0800
Message-ID: <CA+ESkMdPoDzZu5Jit4OD=ymnNkn4vtQfzvH_acLsVeN3=QBT7Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello my friend

I have sent several emails, have you received my previous complaints?

Willson J. Mutanda

Email:   willsonmutanda.j@gmail.com
