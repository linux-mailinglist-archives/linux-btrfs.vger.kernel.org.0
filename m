Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA141CC2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbhI2S5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346355AbhI2S5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 14:57:43 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C61C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 11:56:01 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a11so3969812ilk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pEmqTf7EKmapl9eN4fcWggm3q5JruPJsBXpfcX1WPU=;
        b=ZMPvq/wYXINeMGNJrXXJnTpMHj+jRx4hWaeql/oQZY/zwwEdJ+D5YIBBr4xBuIvFsW
         8GP3qtf1O/2xqqaz7rmfSkMd7SpMHAER8+OAPaJoWfGRoJ3GfJJijnvTItMbxmJ6mkte
         Tey6cVCpL5R/dk/fnmH5z9GgSifo8yzGAP+rMw/bpTQlnsR+EBqXEbBBMb/uxm+cAM8U
         4cn3OCCEU+eQN78aYB9ck6hsNjUus5DbSuMpiaTOYcZKzMVf8mXe2KOa6ftA1wQxQSXb
         LFoMQtWgJVNfGYodBwaPzY+hBjOMtymc7OZGnu5eDveOLpRX/VsysQw350NkRVoJXCJi
         6qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pEmqTf7EKmapl9eN4fcWggm3q5JruPJsBXpfcX1WPU=;
        b=Qdd8OBQHX7XM6RIb7OdkKagI20Pg7Jk6Xch/8LC02OnoAJk3MSb4GcdlVDkKq/0aN+
         Z0Od95n0kUt0xH7rKv94I+sKnWCsOxV67rQmXPXlVJqTh5ggKQrYX3fov1OCSicvq4X/
         SfxxvZFYAyMYL2G7sZxK+K86ZDSIMCeAPgXlknuzVNxCas6fI3CqhObnKka4KV2JOegv
         wEMTpkTcEKhULwAm2X/dwT8lxYAhC+A9mqKkJiwCo1guFozgv65qkOEU4YAfh0V9IPWX
         gidGC8HCz2cJRN9uoCIp8ZRiU7z3m9T6hZEYtPG/I5gm9j4EKKbdfQdEKghYtAomoxwy
         lBvw==
X-Gm-Message-State: AOAM5331CgyxlXkpnMUklYf9CWzuvwJ0lhnrX9K7CUMu4Z6uKA6a5+AV
        fm8wG1jiSJMghEqQ7bZZja0zrJCAsoh/hN6AWvD0xE8Megl/kg==
X-Google-Smtp-Source: ABdhPJyFnPDWmXxHWRzY/u3U7+z/Vl6u7/SIz+58HKs/Q2MWPss4L53ObpPwSMtomwmQ8Duoz0wh1zzF1KzhAGEIbOU=
X-Received: by 2002:a05:6e02:12e6:: with SMTP id l6mr917587iln.293.1632941761015;
 Wed, 29 Sep 2021 11:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
 <CAK-xaQYo1vRi10ZY09q2=7oCTPy1s_i8-rZV_vyc0AMX1JOQLQ@mail.gmail.com> <7df424c.4dc05cb1.17c326d0fd3@tnonline.net>
In-Reply-To: <7df424c.4dc05cb1.17c326d0fd3@tnonline.net>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 29 Sep 2021 20:55:49 +0200
Message-ID: <CAK-xaQazopi0eshOUgeMt-3mQifOzghUTPH28gBtPWf6XAacQA@mail.gmail.com>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
To:     Forza <forza@tnonline.net>
Cc:     brandonh@wolfram.com, Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mer 29 set 2021 alle ore 18:39 Forza <forza@tnonline.net> ha scritto:

> Maybe autodefrag mount option might be helpful?
It was enabled since beginning.

> Your problem sounds like partially filled extents and not metadata related. Typical scenarios where that happens is with some databases and vm images. A file could allocate much more space than actuall data due to this. Use 'compsize' to determine this.

I confirm is one big file with random writes. I agree about extents.
But I'm quite confident the same approach can fix the original question.

Ciao,
Gelma
