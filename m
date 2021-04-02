Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DD335312E
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDBWa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhDBWa2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 18:30:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D14C0613E6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Apr 2021 15:30:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g25so3078429wmh.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Apr 2021 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse.io; s=google;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3xtgF7c6jPfxcsfdmS1pt2sfprHlw/T+3E9AGPZR9j8=;
        b=PjXfIXdOEH+neidA6xfeZaQxMRebbszv9ubwxEYoodkt83wP+p4T7umQUcXRQSgIKd
         PXEkL3z8pAVCkNxdqhDkszhC6cTmlZ2/nYge/g69wnnhcQ6dMbWok+mVbWKg37D/gMUq
         R9aXeflMvKHjD2ELKR9CMn9a2vHiPwcTRXgQnuS7p4uCzeUGFzwjgnuag8HEpnK6+j+T
         qZXSHiTnGa5hqMe6SJSNrhGxATn/7NmCtJD1A1Ay0swUIZYteT18P/bHCm1/Cmm2KlRf
         znrpklnzc1QdvBNIf9XateJekG2pyGFKO4AqL4lTnAd3IphXXD6qFOgLS6NgG0pDJKUw
         mtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3xtgF7c6jPfxcsfdmS1pt2sfprHlw/T+3E9AGPZR9j8=;
        b=ViqE0hOP6Kezm/8O5Rg/x3so00T0d0tXPsDIzsZAsVOOvMgWzmEhRnY/6Q5KWw2wmW
         E0yh7bsQO7kigJ+sgiYqS7ZCk+KaSeWV4wnJ6xBMag+hP/CVQmlnq8XWgzTMq8MQpj/l
         2dhV+oSA4ImNL+1M/APzQX611AgwJXvNDjk4xRmBYtBTsQApkz+ShPlASOaH3SPTzCKl
         VR4Rka7tEWKUOmgT9U+jnm+VaX0xvuXtKcLoD8mXDBeMsHLpyAU64s88KRxWPmyqVCrQ
         g5yq4h1jEFQmNZim7yXGTIFvs9G0Dbef85jaiinVgYUXB2nz5LKgzM/b+beLBfVHE4eJ
         +Ing==
X-Gm-Message-State: AOAM5334KkC6vFGUir07ec2pDGSnZ+wTeNUxXjvtyQu5Dqp7xrAaKOhc
        CpEd2ohbAIL5+NFDPE9etR4Pd+NVLFxmsNC34NZ4K6MBOZI=
X-Google-Smtp-Source: ABdhPJzOOjmZ4JGM4If3otcPJpSY2eSG4vpi02PidcrJO1i6y6LFtB5ZSKMPPXR1idQIXKXZ7oxWdRvpc/8rwCYKHKk=
X-Received: by 2002:a1c:e341:: with SMTP id a62mr15093425wmh.152.1617402624288;
 Fri, 02 Apr 2021 15:30:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: me@jse.io
From:   Jonah Sabean <me@jse.io>
Date:   Fri, 2 Apr 2021 19:29:45 -0300
Message-ID: <CAFMvigfJMYJVm0jTM9NTosF=FA6B4WsJ5VwJrGtuL7RGqKBycA@mail.gmail.com>
Subject: Autodefrag with nocow Attribute
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My understanding is btrfs will perform poorly with use cases such as
large databases that have a large amount of random reads/writes. As
such, the nocow attribute is usually suggested to allow overwriting to
help reduce fragmentation that would otherwise occur (bearing in mind
the downsides of using the nowcow attribute).

The autodefrag mount option however, helps mitigate this problem
somewhat with smaller databases that may have lower traffic and are
smaller in size, but can be a problem for large files. I assume
because it results in some sort of write amplification?

So my main question is in regards to a filesystem where you may want
to have autodefrag enabled, but also plan to use a large database as
well that may warrant using nocow for the reasons above. Is it okay to
set the nocow attribute while also having autodefrag turned on, or
will autodefrag still be an issue? If so, is it possible to disable
autodefrag on a particular subvolume or to set an attribute to disable
(or enable?) it, or if not, is this planned?  Am I misunderstanding
something here?

Thanks!
-Jonah
