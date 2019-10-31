Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2359EB1AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 14:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfJaN4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 09:56:12 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42598 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfJaN4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 09:56:12 -0400
Received: by mail-wr1-f45.google.com with SMTP id a15so6341627wrf.9
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2019 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jABzMUS1ximEwPXuff6fg/FSUSeykjfarKskNygbxq4=;
        b=QN1rVkC23ZzhCPYvfAAKfGBKtMiSXuGcRfiym3X1wY9P3hsgLeuY5zuRW39t+O7ghD
         9DZq7D+SoO6qPjpJJE64SAW1/ht/nqih2JUi/GxYhFF6DQp85PpwoQ9Kez+8s7+Miz+I
         dipWqK5fYLuMOR91avOKAscQuQB/DS0SLRS0l5ATgUzK17Up2i/7y2EiqJPHKbBWEBge
         gB1IEqC1SgGVlMiqj11xyXNme+O3l/+xFzOoDm7RyplyXC7ZnLYThdHSDbTVAaG1RiVk
         /he2AyuJVR0krPL9tZEcicIAvADUZKME/OwOGj3ExTpthWHFiv4JHVLg0GeebpjVCliv
         obug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jABzMUS1ximEwPXuff6fg/FSUSeykjfarKskNygbxq4=;
        b=U2zpgyK1gPDnIWgH9VtNpSYIMKdznbj9ZRyI3XWHXWNq0ZNtAx/JoB9ByTRS4WzXZx
         LlDGH/4O0NkaauvnH5u2ftzaK0sHGrK9A4uV2YJ4eyINsIMHc5ONC81nupZFCYyn5EGJ
         aI8iKq8dkERylWtrC2R7we/M3fZHEZQxj4pZEy3JpF1HQ/Sp7+izy0dowvJ+RfJlyiu1
         cYlSmUuRMHl4ymJ1vvyPihvo5X7bsB/z/aEhYAq+4BHMSxSMdV8/xRfmUBJMysO1v3ON
         8ECz4OIr2hS+yoL7xd7NDKVJ1z2nXUrS4yFauZU204Z3cZWJEzT6Nm/KA+0T/RcuYAZl
         cfzQ==
X-Gm-Message-State: APjAAAXW9eV06WSrADNoH31IPDpy1IdNRsciT7USwE/mE69Fj+Kk6xTu
        K8uDXB9gSuq3kWvYWb9E1v2i/3qmFbmlDCrRMhU=
X-Google-Smtp-Source: APXvYqycQP8mzUwm8IKNBt+N5FEAJms27YT6DQuwwbNiPFQclikcHdiftLw/yYPp6JCNLXQ8XNFDX2a65Sxbd00CNtc=
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr6054154wrn.143.1572530169735;
 Thu, 31 Oct 2019 06:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
 <CAE4GHgntuxsoqv5vGMRTy6QYOTpQOocHgA2RxxeN6YKLgr5rNA@mail.gmail.com>
 <CAL3q7H5+xDr=0ZzW0+CnNqBh8ox9=rh8Vpp2aD4-jnXXnWCpgg@mail.gmail.com> <CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com>
In-Reply-To: <CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Thu, 31 Oct 2019 14:55:58 +0100
Message-ID: <CAE4GHgmQTadqg11b1r6GGo9tDFf6Y2UwE4=3PPUW5ToMYE_dJA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> kmalloc-N. N was probably 64 but that I'm not sure about.

Correction: It's kmalloc-32.

-Atemu
