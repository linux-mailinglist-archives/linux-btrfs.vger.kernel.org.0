Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586C372E55
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEDQ7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDQ7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 12:59:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A9FC061574
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 09:58:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1801885wmi.5
        for <linux-btrfs@vger.kernel.org>; Tue, 04 May 2021 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9p3/LQdrO3mbLUAu2l7y/3ijFFXuMTzOLNww7MXwZw=;
        b=Y3XugzW/H1uVZI5V+sYaEfM4KBhOjk00i+nEQS9w/eP4har5Rhyy8wkcBUalx3bOn7
         eEhKcpOArWmQqm+gINW0o3x+NEiT0rB4HuPIcK/yO//QisN+0UwkW7OMsa/pjZgFv42E
         opO/puvY2mnHmyTivN/Fm7gOWNSjJJ6NiYDoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9p3/LQdrO3mbLUAu2l7y/3ijFFXuMTzOLNww7MXwZw=;
        b=s91LwQ8DoQ2ZaBSSAsQOecINjNhd2UJ+lSH9NyC3hrZP7FMkP368o8Gz7JkowB+v9y
         K6F/dN9W6CdAiLkGNTC23ocixPNEG+LvU/N2Bz86amu+SRF5wxsi9q0MlaqW7cosnQSm
         7u3FvJxAjht0bS4rKQ6i/BzBobRUkNlmX2KhWRk8zjeeK77NAxXTCD+Y9oj62yDnV58s
         xRlCiOIsYz9dAmZisMmJIwi2rO9rd3zHfXOLuSU5kQeKLNL6g/KPDcq8nrAHYox/nraF
         mAUztSVtxw0oDyPh28hQMO0D7RhP9BXWhM+uWJdnFD08kAt79mpnEuTMrj2TWlxif6dD
         sJEA==
X-Gm-Message-State: AOAM533oTxX55aby7NDKFr41lBEi5N5IPCH2AVJL5/cRlT/GIzQpFwuW
        499jmgNeJH3egF7pbMxfsO1q7o5I+M3JrxwQXdYQeg==
X-Google-Smtp-Source: ABdhPJxLoZptXxTUj5MAemqIyhhEjw8vBJCgui9WzS8bBcZ+WhUBbDMxevTa4RiOTIvsHqwVl4wNyTCQIoiqcGugqIg=
X-Received: by 2002:a05:600c:4b88:: with SMTP id e8mr28151055wmp.74.1620147520301;
 Tue, 04 May 2021 09:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210503231136.744283-1-sjg@chromium.org> <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
 <20210504014527.20fcda60@thinkpad>
In-Reply-To: <20210504014527.20fcda60@thinkpad>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 4 May 2021 09:58:27 -0700
Message-ID: <CAPnjgZ1WrpCTxT_czomfqJLHei3ot9965OgPsPw7nvdWfWzgYw@mail.gmail.com>
Subject: Re: [PATCH 04/49] btrfs: Use U-Boot API for decompression
To:     Marek Behun <marek.behun@nic.cz>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Marek,

On Mon, 3 May 2021 at 17:45, Marek Behun <marek.behun@nic.cz> wrote:
>
> On Mon,  3 May 2021 17:10:51 -0600
> Simon Glass <sjg@chromium.org> wrote:
>
> > Use the common function to avoid code duplication.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Is this tested? Why only zstd?

No, there are no tests for zstd, as I mentioned in the other patch.
Are you able to add some to the compression.c file? It should really
be done if we expect it to keep working in U-Boot.

The other compression algos already have a suitable function, so don't
need to be reworked.

Regards,
Simon
