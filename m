Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1899E1502C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBCIml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 03:42:41 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34250 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgBCIml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 03:42:41 -0500
Received: by mail-io1-f44.google.com with SMTP id z193so15793447iof.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+uD2TsrSjbjbRBC8boiurPo1WUVxtPRe5Lt47XlqUkE=;
        b=nDA97G73cROR5mwNdxB83GPQROWOcsL8h9+BK05gEY+KrfZe2syssisqUQh7Ywk40I
         +j1IJRUdzkMc4RPUGrLT3QD9q7n/yLx49/G+ZIDkp2CnfvQ8lSw4ziHY5DnrN+AFdPc3
         DvqIUoeCKGFmgi/Gk519bMLWA9T8nUjdglrHlVaPK3E2SDJBQxeX6Bi1qbTMy5Jc3IVy
         1lQgdR35nadtyUFcNW0lsIpqJl8rPfmA0UrHUzK5il8cpwNsFMcnYBV5neaZnjYckiYv
         eHtTfgaC+z+mOi7Xp6wszxYbCMsw/hyiIeeYrQx+/hs0EBAz/0swU65FayVAeyCYn+qG
         9QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+uD2TsrSjbjbRBC8boiurPo1WUVxtPRe5Lt47XlqUkE=;
        b=N+Mn5QEROvekoW/P1qNh6U61Wb+2s9VhSri5uNM2n48E3SzCvlR1mbu2+hvEgy0E4o
         bLVvfpM4tMnHx3sHpS4QhwKM3VE43uK7viMUFX98x1pRWt6HELglZ1zM4pziOBB5M8mk
         w7r66Nctbpz0FAk2CEtpTvF2RrAm6YNCp6+ZQMeOUG/pKhhOh1yXiyYuxaKB37G4tno4
         oe+k+c+8qa1dEqRuvYl+bdW3ytyHX1cSJneENkWstOvX9/qHNL4vM7bQ8ZSpC5jgZ98R
         WbuOE0QjQlKtOn5On6YlWo+haR5DCX3l8gqwZaftftSG7nHF9yDPyMDuR5u4EnduVpXW
         gk6w==
X-Gm-Message-State: APjAAAWM1IREOE/IkXKQqcEdhjtHsa5yN+eYLr8NFZbtF5KAUZxWIHzo
        iXQ2p2X03JogOdqlxI/cLYTxrqbFJ9w8JjsjfCM=
X-Google-Smtp-Source: APXvYqwXWKsJnDJNQX62M4t2yK2KscY7Z8GNMlpRsXZlK6cWrRNAHfWTDDoSdy5sOq/AFVIVgtXHZe4En7FmqUnWmBY=
X-Received: by 2002:a5d:9509:: with SMTP id d9mr700718iom.127.1580719360917;
 Mon, 03 Feb 2020 00:42:40 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com> <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
In-Reply-To: <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com>
From:   Skibbi <skibbi@gmail.com>
Date:   Mon, 3 Feb 2020 09:42:29 +0100
Message-ID: <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

pon., 3 lut 2020 o 07:51 Qu Wenruo <quwenruo.btrfs@gmx.com> napisa=C5=82(a)=
:
>
> > I'm beginning to think that my Pi draws more power when used with
> > external drive (I used only pendrives so far) so I need to investigate
> > for power issues.
>
> That also looks promising.
> But since it's a USB hdd, what about try it with regular PC?

I tried on widows and disk worked fine. I replaced Pi power supply and
surprise-surprise my disk is working fine! Btrfs + luks encryption. So
it seems power was the culprit.
However I'm a bit concerned about stability of the filesystem. I would
expect some data loss when drive is disconnected, but why the whole
filesystem is broken?
I can't ensure that power failures will not happen in the future, so
I'm still not sure if I should go with btrfs?

--=20
Best regards
