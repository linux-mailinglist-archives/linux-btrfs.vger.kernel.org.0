Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B225495DF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiAUKtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 05:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380041AbiAUKtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 05:49:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E30C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:49:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3E76CE232E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2143EC340E3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642762177;
        bh=KQxCN55wxlHZUQL/poZ7YDIGPS5NAYxSvSmh/RXfY0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqWE/thUf4IFdhg28RHBmvLNAk6D70X+qRWuzMbnTWk5g/wM7zQCNnxtXtM6Vz4KR
         qpaBXhxItFiu4zB7UlrRdnL0aJZtBbIjs8cXj51XfGEx8dZhYvXywIF/Qm1nb/c83V
         coivlqziI4Y0dtKAKTcnOJxR9tXb/EYxi7LvTIXBuONAMS+8lewuwawDKGEUt+EsWi
         CsZuDWd/W5WY9N8A8gFbhuu1D6+mlHXDZ3jmUp1v5zXkKpYOvnHAfVRImmFz3uJKN4
         IJBV/aACqwBOQdms3R4xVQ3m8nRvCIIf9kWJG6VzqTnSAmx9X0ldWn5aJ04cGooRDc
         ISf/BX6y9lv0g==
Received: by mail-qt1-f179.google.com with SMTP id x8so9457996qta.12
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:49:37 -0800 (PST)
X-Gm-Message-State: AOAM5310jo+C9jmR8uF77yQHKVHJw/wLpWnoty66Rb/p71yGp2iIKauB
        KeEE5w/4la41ksr7ow0D7ZQhXL4h0yKb2r4r4jo=
X-Google-Smtp-Source: ABdhPJySd/UqoSk50K/Za7XHNr2sQ4hUWByJy5Jh6tTpk8OfzWgqyy55ubPL7dcN5GXgnHli9oy2y+oRg+PtatrPhUw=
X-Received: by 2002:ac8:5e0a:: with SMTP id h10mr2630810qtx.522.1642762176209;
 Fri, 21 Jan 2022 02:49:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com> <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
In-Reply-To: <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 21 Jan 2022 10:49:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
Message-ID: <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 6:21 PM Fran=C3=A7ois-Xavier Thomas
<fx.thomas@gmail.com> wrote:
>
> > Ok, so new patches to try
>
> Nice, thanks, I'll let you know how that goes tomorrow!

You can also get more one on top of those 6:

https://pastebin.com/raw/p87HX6AF

Thanks.
