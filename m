Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9F6A9A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfGPN3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 09:29:39 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41859 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfGPN3j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 09:29:39 -0400
Received: by mail-pf1-f178.google.com with SMTP id m30so9127724pff.8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr4DJaURjrQIF1ujy34J+TmCHOKH/RQ6niHUkteTGKA=;
        b=dbG1rHWhSiJIbLH6kWDazrQqaV1WhfFmv6o4fVoRdyov6enLkT8/eyCWzbGFFP6zYx
         TRlPlv/k59HRx0pclcSnmO5X4PxTtHWoyEORX3XX10s4xmzhjOWdg67Q2M437nvBqWWg
         J4USNUZpiJ+j7ZjXXzCkm3Up94bCXkzpeuMkrJsoRVNNwz4sa4V2pVSBqIh1SBvOht31
         iJ0nj9RA5gO2VBtK2Ukl3ckG9zq8HSaMVL/KW+tMusTfAKX47r81R8/T/1TgkrIMTMtj
         dJDYOYUurNrBaVTSk8yLKvd56jUwmQqivKkYrD+Jxo2smQPRTcUXUsRd+9LdNbQIfha/
         Fmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr4DJaURjrQIF1ujy34J+TmCHOKH/RQ6niHUkteTGKA=;
        b=Xx9idd3HD6FQFUthEkvi5tU+/VigqSNuGlwoitgpHKlg/u84aDo6EpkHAipTWeAt4Q
         G/5zt9LccQOnUgQNzMye9w4HQStq6Ot7LVrX206+ZNvWLxx8BKhdeQZghn0EH55ph/Bp
         6GDiltFuSaS0+8mRPFkIVUXeP4ex4TeUJWXGeGkL5lH91WADtsfTDCU8gYphHIQZwTh3
         ClSHXg+K9tPWe0IMlre8vZs39dkabaNTigf5k6BSpuKOsELZLumzUABXv7zEgJ+PaML8
         ooKqyqZJuVs9mLNLOdT4tDVulcT8cWNEdrcMmomyEywn4KHB7b/Jzid0UbRKlFs2fj88
         j7+Q==
X-Gm-Message-State: APjAAAV/6/SudMC+dL0tgV9ThxTGODfU2J5xZrJqJz+pl7rk6eq4F3Tg
        cZB0xSkBTu8MfWNvEv4dprPuqzcfM7tP/+qS920=
X-Google-Smtp-Source: APXvYqy3r7v3RErnj8iMdrS7MttETTqknVBKBOyeZMoNucCdz7oCqemcIX80xBankMnjJTsJlGbDMzwxBfwTtTqz1J8=
X-Received: by 2002:a63:1020:: with SMTP id f32mr2549012pgl.203.1563283778855;
 Tue, 16 Jul 2019 06:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VcjxDjCy3JhZHEFjBcNX_L60J8pWOQX=8_5BxyW3bN6ag@mail.gmail.com>
In-Reply-To: <CAHp75VcjxDjCy3JhZHEFjBcNX_L60J8pWOQX=8_5BxyW3bN6ag@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Jul 2019 16:29:27 +0300
Message-ID: <CAHp75Vdb6uJ6Fkw43UrgLv=4vVx5k_g-f=fZ5KNnETfWo9G+ng@mail.gmail.com>
Subject: Re: Compilation breakage
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 4:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> The following commit broke compilation
>
> commit d5178578bcd461cc79118c7a139882350fe505aa
> Author: Johannes Thumshirn <jthumshirn@suse.de>
> Date:   Mon Jun 3 16:58:57 2019 +0200
>
>    btrfs: directly call into crypto framework for checksumming
>
> ERROR: "crc32c_impl" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "crc32c" [fs/btrfs/btrfs.ko] undefined!
>
> Obviously if we call directly libcrc32c, we may not remove a dependency.
>
> Moreover, module soft dependency works only on most, but all module
> init tools (for example, busybox).
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
