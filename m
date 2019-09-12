Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50096B09B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfILHuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 03:50:39 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39558 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfILHuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 03:50:39 -0400
Received: by mail-ua1-f65.google.com with SMTP id s15so7684644uaq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UrkrffaHaqGGy48vaWZOcyEMaZruRLQSfbk6V/OnIxE=;
        b=Jqx7db+BhdiRzp+FB6buRLYtdATKGk2ZnvG3JVJ4ZDlmCVMJSfBQPrhXM4QjxYpj6X
         RV73fensLJOrxMSh31KIRmOYY8MFLzRgEgx1R5zFLfScK+B4OjaL3Ad7+cum9F73fxkM
         y1PgRPOwJu9YqRhWnWCV51pDT9blnQvKUZntDUDM1rMkVhF3ZM0sR1TD098Z2xaPumNz
         Lyc+H1myWxyP34ZiUy/12nXcknOqAaWnEBdYy8qvrLV62RJj4P2WEjvzJgyA3ctoV30n
         CzSW5FOkgoO3IwmKw471lcWI9+u1g5az4r7iH3NZVX5w4Oi2YqAsTLYLEp5MVc+W8JqC
         ydxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UrkrffaHaqGGy48vaWZOcyEMaZruRLQSfbk6V/OnIxE=;
        b=AJnsmojxd56Du0qlW+GNERnrWqsU/XwHXcqcqXAEoGY8xktyJkO3Z6+orvIc7okrBr
         sTAqaIfsYmawGgTnkkIAzltRTA/eI51lhom32v+iMi3XLi5C8ysX5wP2VflVikqhlfJM
         Z6ZxgNWRRGiMNIkTSwHVPn6tsQkkP0sZpvGfH0WPAjefWAoc0FzucrpPDnAUFD2zxpU+
         u1+oPMeQlPriZDUDo4HXV4lhPKZoRA6lMzdGMui5rGac39gd7ka06XNOdUDpSy6NX6uC
         zRP75fEiYCgg1G/TRMp1KqzsodOZibdXKbfb+yJLqLGZoYCAKtgsYOLlLI+YKszghT8C
         G53Q==
X-Gm-Message-State: APjAAAWJGwsfkcNlJzzTppM8qiQJidDYFTHyaEE+uZn0NuVi2+eqDQ1t
        Ho7D39ETG4wzuabk0WZJok7/DkFyQt4PG3OhIPtDP7L0nl0=
X-Google-Smtp-Source: APXvYqyvZVtHgG0m9Sg+KEnyPO5TV3Si8U0L3rDE8pyAT7tlGKJfkkMvV3w80yunWcpqOtuoj72qSJfZIMqwZMN6JE0=
X-Received: by 2002:ab0:30ef:: with SMTP id d15mr18706610uam.135.1568274637783;
 Thu, 12 Sep 2019 00:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
In-Reply-To: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 12 Sep 2019 08:50:26 +0100
Message-ID: <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 24, 2019 at 6:53 PM Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
>
> Hey.
>
> Anything new about the issue described here:
> https://www.spinics.net/lists/linux-btrfs/msg91046.html
>
> It was said that it might be a regression in 5.2 actually and not a
> hardware thing... so I just wonder whether I can safely move to 5.2?

So we definitely have a serious regression introduced on 5.2.
I sent out a fix for it yesterday:  https://patchwork.kernel.org/patch/1114=
1559/

Two things can happen:

1) either a hang when committing a transaction, reported by several
users recently and hit it myself too twice when running fstests (test
case generic/475 and generic/561) after I upgradaded my development
branch from a 5.1.x kernel to a 5.3-rcX kernel. If this happens you
risk no corruption, still the hang is very inconvenient of course, as
you have to reboot.

2) writeback for some btree nodes may never be started and we end up
committing a transaction without noticing that. This is really serious
and that will lead to the "parent transid verify failed on ..."
messages.

Until the fix gets merged to 5.2 kernels (and 5.3), I don't really
recommend running 5.2 or 5.3.

>
>
> Cheers,
> Chris.
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
