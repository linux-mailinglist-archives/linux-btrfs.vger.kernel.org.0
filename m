Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677391AE10D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgDQP0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 11:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgDQP0Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:26:24 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBF620857
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587137183;
        bh=fx2Z0WNEmPeDxVaY1Y6PrjvMJTf+H1+0mOQd9zyBbjg=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=SQ9OmGNYFc/8ZcPJtSFNRwxFgsG2aSSihu4ZiPiwBAzcBDAyFlyJAjQmhj5COyDyG
         aXrYvSJNQN/tr9/UfOJg10JRrZnTmOLsSTFebCIC1j8cxCJc9G9BiQYX+AxDrrKtdR
         z2imCTJD2DsUP1DgdIIJh8qu2hCOKc3FayYvdDNM=
Received: by mail-vs1-f47.google.com with SMTP id s2so1380435vsm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 08:26:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuYtPrbLF+0Gy64IP0kxwRrK2AbVpPd/LAe3D+k2ehrz8c38DVNa
        NAJ3FFxCF2I0Marl5CXC62nMiXfY3dvoWeT2jxY=
X-Google-Smtp-Source: APiQypLkhwvMfvzo90wAAY/gmHb6gP4CiU4mqXHLtijI3pli2w8q8E2pUC6+wA2oWE8v1OE8+5yBAnMpcCjZIyDhPJs=
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr2421898vsn.99.1587137182736;
 Fri, 17 Apr 2020 08:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200417144012.9269-1-fdmanana@kernel.org> <20200417152218.GQ5920@twin.jikos.cz>
In-Reply-To: <20200417152218.GQ5920@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Apr 2020 16:26:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4BJUFb6TWCf3EDObHWo25kgzPWvJ7PH=cS0XPp+dTrqg@mail.gmail.com>
Message-ID: <CAL3q7H4BJUFb6TWCf3EDObHWo25kgzPWvJ7PH=cS0XPp+dTrqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Btrfs: fix memory leak of transaction when deleting
 unused block group
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 4:23 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Apr 17, 2020 at 03:40:12PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When cleaning pinned extents right before deleting an unused block group,
> > we check if there's still a previous transaction running and if so we
> > increment its reference count before using it for cleaning pinned ranges
> > in its pinned extents iotree. However we ended up never decrementing the
> > reference count after using the transaction, resulting in a memory leak.
> >
> > Fix it by decrementing the reference count.
> >
> > Fixes: fe119a6eeb6705 ("btrfs: switch to per-transaction pinned extents")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Added to misc-next, thanks.

This is actually wrong, I'll send a v2 soon.
