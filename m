Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F7B3027
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfIONZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 09:25:43 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:33525 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIONZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 09:25:42 -0400
Received: by mail-vs1-f48.google.com with SMTP id p13so2858256vso.0
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2019 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9OFiszplI7nrXea7aSir198IUgHZUosUF+dRRSWikus=;
        b=SazAOL8K+jRQob2oHP2g3gfHZ9AmI+YufZfxWrTWtMVfHMm/rQKH3rWbkRV2+Pl0na
         dmt8W/9TwSawGV0iTxk0vOflH7BStLGBVvyrQt3d8q8K6doVdHJfVdltf3fmER3pOQQk
         /fYQHPp5e7Mj6pAk0d1WabzF1HwrPc6jQXdM5wZE55tOV+VKnYIsu9FSb3WRqSXLK1rf
         KPz80zcZpPCHx8LAmDCJza810xCignrNecCJkf+9ZylTXA7AtOKlX4/tGf6FW40gLOUt
         8YH6AEUxyQgZbrgELY1ehz47fLa9GiPyhs1Bb0Gg/gaSlETaRiKpCVEWDOVOEx+Wo6wk
         oShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9OFiszplI7nrXea7aSir198IUgHZUosUF+dRRSWikus=;
        b=Ip4jPqph58VA7FT6rQI/ypngii9Kk1nWhUdElrfvl4j8oQsJk53PNB9FF6eebnzy1a
         As9AkeQA+jADl3zT9diIHgqBL/tsYUZ2E8f5ShTVsjxY5GHUelvPcbDs/t2PSW0JP007
         lqx6V9q9B15tb1UiAtfphYI1MbacShAONJ4Xp+6ZkW5x91vp0vFTz8vDDwrLF219naJl
         hObesHpQ1xDzY+7xyg4c9PbfTYIOHr3nspHPhuEF1XiQy+yCI22wzarPs8OUrO6ntcNA
         k9FUgeur4kGWr6axCwNAEBODi3vqwZxXoXOoLA69HXPch9zBIlOPhh+GhkjeWCaIIwRy
         z7JQ==
X-Gm-Message-State: APjAAAXWYsU0JzAw7tDeOzkN3cCj9T1JYhL9rQY5mw1n+jND3YtLtd9A
        +HnmfSh27YoyZE6pTm26u0X9WRKix1kvqRWlUYIBNQ==
X-Google-Smtp-Source: APXvYqzfM1ale5qAj+nuXRaxWRrIxCpPfD7dj3lQeMZlq0AuZl4XfOde/5vlkwn6RZfd975fgpKFMdMTJNlRKzHtW2w=
X-Received: by 2002:a67:2d95:: with SMTP id t143mr31449998vst.47.1568553941848;
 Sun, 15 Sep 2019 06:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
In-Reply-To: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Sun, 15 Sep 2019 09:25:30 -0400
Message-ID: <CA+X5Wn5XbuTGoSYh4h8hdhsGf-JnHTP61G_rFLwLFRL=PUicyg@mail.gmail.com>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 15, 2019 at 8:46 AM James Harvey <jamespharvey20@gmail.com> wrote:
> ...
> Because the heavy I/O involves mongodb, and it really doesn't do well
> in a crash, and I wasn't sure if there could be any residual
> filesystem corruption, I just decided to create a new VM and rebuild
> the database from its source material.
> ...

P.S.  Originally, I was running mongodb's volume nocow, which of
course turns of checksumming.  On this new VM, I left cow on.  btrfs
scrub and check are both clean.
