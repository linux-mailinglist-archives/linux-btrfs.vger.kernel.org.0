Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA442977A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhJKTUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhJKTUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 15:20:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A21C061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:18:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so75302903lfk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akSYF39zgtk0a5MnXnEYsYFXQGdJumKzdd6cC0TD2zg=;
        b=A4QzBMlCMcBx5BCw4khuK2ji3v2yerT3KTw/4+qVIbsvo5B70UhvreUPdj9K7tHbQ/
         GM/9M705H033Sm1LVwWfUojU92ep1ICGRa+zBv6ei6WkxxlMd67VsAXa4B2wym1X8LD0
         zK/HaC9as2SgjDwA6dvyPAsfMg3nelTosFWyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akSYF39zgtk0a5MnXnEYsYFXQGdJumKzdd6cC0TD2zg=;
        b=TJPxHONwvrexiR/zqlUuZrkHPiD4BLZRIeNHd7Qkc0SIEdrX0ESQxsLUy92fGkt4Jb
         VUh+7bVVcz78ffdQXdnLrt81GIopezgMHMYk1UnBBvREzEOCG+tRdA+lb1Annm+gaIEc
         21F99VE/5Wq4KZhyxG4b/0hZuKbT1s2uvSFvryPDKuBtI9tGaMrBSPjUKNImKWXYMfSP
         m4F66jihzFYzhZ/B+Ba8nA755IVwI/y9yBchryxBSlj9f5O8o/QYdW5G8ze275YfOhNB
         dNqzQ10b5m8TICMZd2H0V+esGQyJOzMu4uQiw2kDDGZ2V1Y5hYhMUc/Zofn4SBIwZ9iN
         h1MQ==
X-Gm-Message-State: AOAM533sRWC/W+0XckVdTD+sM/nqTFy/UbplHpZu/3Lpi0+pjNCtE+D/
        Yh1oO9k8ct6mEEHEMFipK+0t42RzrnNyRnGP
X-Google-Smtp-Source: ABdhPJwQtUF2gj5+uPH+uwKuK+vyHxztH9s5Vz7TvqgwTZWAxz9s09QFFMjlw4DpbS5+2053xqI/kg==
X-Received: by 2002:a05:6512:13a0:: with SMTP id p32mr29839848lfa.492.1633979909548;
        Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r22sm810999lfm.78.2021.10.11.12.18.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c16so22822447lfb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 12:18:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr6899360lfu.655.1633979908936;
 Mon, 11 Oct 2021 12:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633976241.git.dsterba@suse.com>
In-Reply-To: <cover.1633976241.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 12:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
Message-ID: <CAHk-=whyP7conp58OoJA5wjWdMf8BBek3vw0C3n9HBOw8BHZuw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.15-rc6
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 11:40 AM David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.15-rc5-tag

I see the 'for-5.15-rc5' _branch_, but there is no tag there.

Did you forget to push that out?

              Linus
