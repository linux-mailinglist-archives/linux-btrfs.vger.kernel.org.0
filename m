Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A131DF825
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 May 2020 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgEWQLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 May 2020 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEWQLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 May 2020 12:11:23 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B3C061A0E
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 09:11:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id c187so2803266ooc.2
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GKyWYNkMAg3RS9q0anXXEWsvvUDKg+FdI5mDQ8BiRQ=;
        b=PwXYeIocJMdCnGxfdcJowVfsYfx89PRu3LXcbeqWxwsjEbkoLODxaITOk4WarvMb3j
         NBtQJww4B7QxpN9DQc749ANiXHK/kf0QUed4mYgdnN5mUroEgRmVEa7VYYA6NOkOHBEz
         39nFhyYBqqd4t2cAFqciT6HWQVnxhD+w0JJ9e8R9FbuEJlg8Hcbtc5r7VY0z0CBrRo5X
         U94TsKM3P4J8Ea6gfFzRXxvdz38CFfpU793tFsbfyQpNtRY4EJMny0IZ+WOg0HxppvOp
         sdWGMzVbaa8kKcYWZflUdTOIzInhw2LeJzEnIRWMVhvQUtvyOk+VdFr13gj38jUaai/a
         m11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GKyWYNkMAg3RS9q0anXXEWsvvUDKg+FdI5mDQ8BiRQ=;
        b=DXsb3QU+3ev+eqk8k4JP96sBaf/N+DSgZKCI+xNPt0NppMk2vdlD5uv4OG6IWF0jCK
         c7tqKY/bc/44Y+7IuzyGYzckb1t2l8thveTfIAXoNjwuUrAwIc4Lr8bbzvcuicVgN2hc
         f6MWkfgSBzOFBluV8b3LWse7Q7hTJHNX5iprg6gV+MCPOZ88lmmMwS2HuZi69dldI2Sw
         UVWZ/x3q4jpqafesHjvpaa4cLYnYoWONC6D7IwPqakyfEZ5q6E47R/P3Qzla1Xb+VxnA
         OpSypLD4lUzmWoatyRGtKQCXE0Ko5Wa5IEgAITg3mwNVxKrdHRWUHdoul8Hd63FXNz4x
         PLNg==
X-Gm-Message-State: AOAM532FrjOP6QhT/CHYW8JIlaG5SIeSSA4gulXSkXynw1PKAxUyflKO
        638J2icPQ4P14mIZWEGFFzHXrk0XXhQ0Y8ddLH65KfIfKLA=
X-Google-Smtp-Source: ABdhPJx3AyyhrduXtv2P7EwRc5jeBCNjmLkVyqQXKiPWHjFpcWyps4nqk2+jhTB1JMrToXR6/swfcxK68wfNHPe9jdY=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr7331976oog.20.1590250282229;
 Sat, 23 May 2020 09:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
 <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
 <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
 <CAJCQCtT=rStKTwUc86FyAp8C0D8eoRvgKHWYC3+e=fLJxJNUZA@mail.gmail.com> <CAJCQCtT6zXdNOeTh1YTrWwji_QtK00hhiAP96ysrHdeg-DU3bw@mail.gmail.com>
In-Reply-To: <CAJCQCtT6zXdNOeTh1YTrWwji_QtK00hhiAP96ysrHdeg-DU3bw@mail.gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sat, 23 May 2020 17:11:12 +0100
Message-ID: <CAHzMYBRMqYK4tX5eqoO95=OwZb=uqzWrUE8ngvA1rO2_gqf+Dg@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

I'm also having much lower than normal send/receive performance since
upgrading to kernel 5.6 (currently kernel 5.6.13 - btrfs-progs 5.6),
there's also a very high CPU utilization during it, anything that can
be done for now?

Regards,
Jorge Bastos
