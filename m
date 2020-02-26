Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65016F62D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 04:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBZDif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 22:38:35 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40649 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZDif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 22:38:35 -0500
Received: by mail-wr1-f47.google.com with SMTP id t3so1166934wru.7
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2020 19:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95exJZ0dQz7t1QXcRx255WQ7vzmRhS4d/5HCKr1B5B0=;
        b=H6tzF5+TE/qYoIY7qWOfBdA9VbRGKKPef76Nj+jLcTBO618v6QXfQHxpIUUzhyTmZq
         m4guiHIxqphcU2oMLxVJ1voYIT7x0AxCr9+SP5oob2ifKQF0Fytd/e+hKLJIorq1lGOg
         bd9m6WtYzd6WokOkG0X1K7E2OnuUjXylWkiJAAUIRNOGYFYqAgGqaOniSQ53kQa1Pp9G
         2JxqHwsgXgL10tl7Xckd0xmskPzAs+RLxUS/tDpAhjSdHaDuIXNIAyFPk6tRlY9P7lN8
         Onnx55FWKqPPTUzQKTy0MaXhLzKlouALj+UzogAKuR3DOtWVAyX3RMdNexD49CHoI/mM
         fWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95exJZ0dQz7t1QXcRx255WQ7vzmRhS4d/5HCKr1B5B0=;
        b=Ol7NqUNdSOwqutBJ3Sv9AgdWUouxnwE/krgOsPgvRnklvfI3RarmGO+s20YP7egqQv
         UnKXNORm9HOcAXL0QPao3A2EGbHnccQGGQ2OQoOnOppNXoYFm21Y45DZFZPXXxekEwpf
         AFezftr/KywvVwOQL3Lf0vEE3Tw8wRIaggDzaDKJTaBSa+2aYkYK2lIlRfZsK2KMIM7j
         tOty3N1flIjpDNhH10AEg+WFzyeAzeVck5D+49ysXnbHExa1RPCwmHurjRUGVWZDbowz
         /QSmsXdDlsvDSkZ8L/cxvctGyOunJHomj9xc8oWVZW3SjbkGJ3NvyxOaQ2dJhda3lTx+
         PBCg==
X-Gm-Message-State: APjAAAUNpH3VT+kYA3GzVW6LsheFMrFQ/nXt3I5PK7PbGtXjJTQ6z9KG
        A6fejzXhNfl3aemNnEpDHIjdBInjBpT/FZNuuhz85Rg=
X-Google-Smtp-Source: APXvYqypJadVu8Ex3hOE5YafMOgrOVcpeSzbwkFqdqByN59ISxtHzYiCmMkCee/Ke26RR+RlxV1kKmk8m0XQmK5OJdY=
X-Received: by 2002:adf:9486:: with SMTP id 6mr2647198wrr.341.1582688312969;
 Tue, 25 Feb 2020 19:38:32 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
In-Reply-To: <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
From:   Jonathan H <pythonnut@gmail.com>
Date:   Tue, 25 Feb 2020 19:38:06 -0800
Message-ID: <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 3:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/26 =E4=B8=8A=E5=8D=884:39, Jonathan H wrote:
> > Hello everyone,
> >
> > Previously, I was running an array with six disks all connected via
> > USB. I am running raid1c3 for metadata and raid6 for data, kernel
> > 5.5.4-arch1-1 and btrfs --version v5.4, and I use bees for
> > deduplication. Four of the six drives are stored in a single four-bay
> > enclosure. Due to my oversight, TLER was not enabled for any of the
> > drives, so when one of them started failing, the enclosure was reset
> > and all four drives were disconnected.
> >
> > After rebooting, the file system was still mountable. I saw some
> > transid errors in dmesg,
>
> This means the fs is already corrupted.
> If btrfs check is run before mount, it may provide some pretty good
> debugging

Here is the output from "btrfs check --check-data-csum": http://ix.io/2cH7

> Also the exact message for the transid error and some context would help
> us to determine how serious the corruption is.

Unfortunately, I can't reproduce the transid errors, since they seem
to have been fixed. However, I do recall that the wanted and found
generations numbers differed by less than a hundred?

> > I noticed that almost all of the files give an I/O error when read,
> > and similar kernel messages are generated, but with positive roots.
>
> Please give the exact dmesg.
> Including all the messages for the same bytenr.

Here is the dmesg: http://ix.io/2cH7

> Although I don't believe it's the hardware to blame, but you can still
> try to disable write cache on all related devices, as an experiment to
> rule out bad disk flush/fua behavior.

I've disabled the write cashes for now.
