Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD81D977C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgESNSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 09:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgESNSm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 09:18:42 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156E22081A
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589894322;
        bh=H/rZtzCoMsQM/ybpgZo3A15DlO4YHiVlYRJajpepvRY=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=aEsLhbp2N7bIhlmOwSI60l7tuJNayXQSjn80VsTTAKYAEUS24NzaHqs9iLFGNpydY
         PyAAWWM/OWMKyuqK72O2/ky8hYfzaK0tA5BkyDiZ3fxKmW22DYUdrau0g5u8Ls+8ZT
         vTwLyaS9dQs5veK/YTQlIq6l2K7Ia/D1TAmaOcD0=
Received: by mail-ua1-f41.google.com with SMTP id 14so3176123uaq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 06:18:42 -0700 (PDT)
X-Gm-Message-State: AOAM5326H+8GDVeOwwR5Dk2Rg5nf9wpQzDWSm84q8ftRRzH/mYDv/6c3
        7/iBbZGTHKcO8+0jfm3IlT9SR2vGxr49N2Hr1Mw=
X-Google-Smtp-Source: ABdhPJw+xn7qNGKcFNLjmEZEV1/rhBUhJFa+Tx7qrbafoXVvNPrI3gTd3gzarbPulHigheZtBahY93Fk79nQXU6Vyqs=
X-Received: by 2002:ab0:15cf:: with SMTP id j15mr7403538uae.123.1589894321064;
 Tue, 19 May 2020 06:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200518163411.18660-1-fdmanana@kernel.org> <20200519130610.GC18421@twin.jikos.cz>
In-Reply-To: <20200519130610.GC18421@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 19 May 2020 14:18:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7meKUXYbKVcayJvZ37NzkNwBNaJs_AZ2EDzEmCD6-Dcw@mail.gmail.com>
Message-ID: <CAL3q7H7meKUXYbKVcayJvZ37NzkNwBNaJs_AZ2EDzEmCD6-Dcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Btrfs: include error on messages about failure to
 write space/inode caches
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 2:07 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 18, 2020 at 05:34:11PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently the error messages logged when we fail to write a free space
> > cache or an inode cache are not very useful as they don't mention what
> > was the error. So include the error number in the messages.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> 1 and 2 added to misc-next, thanks.
>
> As the 2nd patch fixes a problem introduced in this dev cycle it's ok
> push it as a regression fix. But as we're at rc6 I'd prefer to postpone
> it for the merge window time, unless it's really annoying and hinders
> testing.

Agreed. I consider it a very minor thing.

Thanks.
