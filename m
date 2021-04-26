Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CA36BADF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 22:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhDZU4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhDZU4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 16:56:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BEC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Apr 2021 13:55:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so59972211lfa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Apr 2021 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsvd/Qinp/p9KJ8WGTP8ln6jTc3txvxZQ3RZQL+RCH4=;
        b=Mh6fPNjdra5N9zpGupgnZ3bI/RC5dvEZ3srZKHfmekX5dRYuOORb4UfOFcALxnlyQd
         6aAaups4I/YbFe+8howGXUcciIhZfN2kkU/5WUuVH9hjTf0Q0IZvKrYaxGnVJoMP5oem
         SL4I9MhJjUWCPb64VYzex6iw8haAk4vgPW0/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsvd/Qinp/p9KJ8WGTP8ln6jTc3txvxZQ3RZQL+RCH4=;
        b=G7DceI+geM6JGjz+OKezFCSLt2N6t3HXY26AtcKHc1ZV3BcFNG1bOM0zSs5oP3buta
         qQ0bfMpuEfzBl+mVtCHp1TgHstvhmNrTk+f0LdsbaWHxSA7CUVNUHHpTSz/jtqHng132
         REbHniJNX/Cd5t0v60H8i/ZoLGqWRh+/R4yu1TmVXsGBln1fun0pQW/u5aIz4Vxfff1Q
         t303iC2j+CpM58jEV+Bud8JIvWaVByse30akftXFcxj5oNa5RVScizCC4abS+V0tLhXH
         3me6Gf8OUQbiKu18w8W9X1iEGzu6vewGyNWQean1JuubBHRn7bEy9j5xaQKqpp2OYXyK
         ui+A==
X-Gm-Message-State: AOAM531tG6JJ+ajup0HeWmkeU/ulOFZg7UVzXL1gD/8EUo+343AOapK3
        9aNm1IAomuOJL0p6yMcLBTM41ZjcAcg9QYaf
X-Google-Smtp-Source: ABdhPJzYFdphD/JZISc4EZi/Zwqk3aD9mcq+q+edUiAhmHaIXCYwwiTRmYhbNsIAQYiycQaEAZVuwQ==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr1064889lfp.297.1619470519940;
        Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y7sm1510926lfb.62.2021.04.26.13.55.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b23so7770988lfv.8
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3147:: with SMTP id s7mr13714445lfi.41.1619470518895;
 Mon, 26 Apr 2021 13:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619466460.git.dsterba@suse.com>
In-Reply-To: <cover.1619466460.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 13:55:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
Message-ID: <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.13
To:     David Sterba <dsterba@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've pulled this, but:

On Mon, Apr 26, 2021 at 1:01 PM David Sterba <dsterba@suse.com> wrote:
>
> Matthew Wilcox (Oracle) (1):
>       btrfs: add and use readahead_batch_length

This one is buggy, or at least questionable.

Yes, yes, the function looks trivial. That doesn't make it right:

  static inline loff_t readahead_batch_length(struct readahead_control *rac)
  {
          return rac->_batch_count * PAGE_SIZE;
  }

the above does not get the types right, and silently does different
typecasting than the code clearly intends from the return type of the
function.

It may not matter much in practice, but it's still wrong.

               Linus
