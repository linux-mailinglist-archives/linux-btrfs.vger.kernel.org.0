Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B55004F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 06:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiDNESW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 00:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNESV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 00:18:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA732EC6
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 21:15:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg10so7743416ejb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 21:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXnNN7pC3MUdsVUNM6oe781dcKiiLYE16DY+rH0mhAA=;
        b=PhY0lx8b8s6n4JMDGGEU3LFFZwPmk9U7a+w/ZMP3V9GZ9w7xbUW6/FAbpWgW+3HyDJ
         BH/EaCQVjagMZjWX7ayiMxRfPp0PfcTL+tVL03Oi0tvgJAVbbsn6RNN8FnfAWjWcJ1Ps
         BA2RFLMbGcLT6k9Vh3fhEeWXepg2ufloq43uPUElQayE04Qrj0xj7OVMeo32PnI1T0wb
         DkUgfK4u7n4CK5wUJ3EhsPJKW21H8b1Iev8Ab0gmEJwLy9TgZz7oE6d9fWkbZm6xKCnQ
         koowPL0Q+cM3B25Y4x4RfnZ2WM/oHTqzU/HpLn2XBfIi32+pZZDL/KART4hYZeBvefvb
         XchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXnNN7pC3MUdsVUNM6oe781dcKiiLYE16DY+rH0mhAA=;
        b=0OUenaAkuTJ/5xOHfqqeY/q5IMIIkZRGSg6Z/Xr+rwD8uZvSV3VNpBFWGNiW5nUXhD
         2+MvOeoPLSFsS7d/5xZJwH2m7wlMsAfS8YFp459G8nLryHbCjVuBnz9jqFxMiQcNHvHZ
         UbBZSzaTtnclGHqZgpkiPu//sKlTOLhX8EDKAUxYoZQTYXADOuif8E3qMTT+oSmu2biK
         LANvpBif2OUy2zdXpLVo29eUqXn5lTb9oA6xMrsl1NnrfC2snaOlTu7gUDZnycVkw50Z
         yQkD/eBvZmdXCMY1x1v8zAlbkSL1L7e6xYQujUXmvBHIbJr6GdFhg5npoTFyRnxjhhOW
         ac0w==
X-Gm-Message-State: AOAM531NpBL0H+Vg/2V2byiDABbHKitxuQjqLvzj9gHA3m/x+ru2RFVX
        bhpkXtq32scu94y4WAnCVbZyq1DrWM4Q+HEE9FtNDRQZHy/RWA==
X-Google-Smtp-Source: ABdhPJx2/Z3+Jp/+yqT41seeoKKE+RayvCvjLFaB//tX+tgkBzkgX3VViLgWPNh0m1w3Kr9cR3BCxOLCVCtqhoF2dQI=
X-Received: by 2002:a17:906:3708:b0:6e8:9459:88f3 with SMTP id
 d8-20020a170906370800b006e8945988f3mr681695ejc.629.1649909756387; Wed, 13 Apr
 2022 21:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220409043432.1244773-1-cccheng@synology.com>
 <CAL3q7H77p6yFhHMu-1kpgh+J5jv_dKeqqwga8mJMRXY6r0wAvg@mail.gmail.com> <CAHuHWt=LB9WvAuEmQe9nM8ZQpUBz6LG4Asr6ss+f2C_G3LNW2w@mail.gmail.com>
In-Reply-To: <CAHuHWt=LB9WvAuEmQe9nM8ZQpUBz6LG4Asr6ss+f2C_G3LNW2w@mail.gmail.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Thu, 14 Apr 2022 12:15:45 +0800
Message-ID: <CAHuHWt=RiaO=1W9LOvXbD1o6qViMF_+Ebtic9R+3=ss+2VaXSA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not allow compression on nocow files
To:     David Sterba <dsterba@suse.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel@cccheng.net,
        Jayce Lin <jaycelin@synology.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 11, 2022 at 10:27 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Sat, Apr 09, 2022 at 12:34:32PM +0800, Chung-Chiang Cheng wrote:
> > -static int prop_compression_validate(const char *value, size_t len)
> > +static int prop_compression_validate(struct inode *inode, const char *value, size_t len)
> >  {
> >       if (!value)
> >               return 0;
> >
> > -     if (btrfs_compress_is_valid_type(value, len))
> > -             return 0;
> > -
> >       if ((len == 2 && strncmp("no", value, 2) == 0) ||
> >           (len == 4 && strncmp("none", value, 4) == 0))
> >               return 0;
> >
> > +     if (!inode || BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)
> > +             return -EINVAL;
>
> I think the nodatacow check should be the first one, before the
> validation of value for "no" or "none", it's logically the same as the
> btrfs_compress_is_valid_type.

if this check is located before the validation of value for no/none, the
following operation isn't allowed. is it ok? although it makes no sense,
it doesn't produce any invalid combination.

      $ touch bar
      $ chattr +C bar
      $ lsattr bar
      ---------------C-- bar
      $ setfattr -n btrfs.compression -v no bar
      setfattr: bar: Invalid argument

Thanks.
