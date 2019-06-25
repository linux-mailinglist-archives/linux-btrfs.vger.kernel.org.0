Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029F555371
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfFYPbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 11:31:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfFYPbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 11:31:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so3313755wma.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UeeT7H3+S/EfjlH2OjEVsLUN0/0ZPu141DEfB94dmrI=;
        b=BcRZQLHaqi4tXkfrP+b54JKKpFsgIWz3T0jiG7iliOo0r7JZkMnSWNxak3c5iMk3a+
         bt5QY7pqdAC8J3xKMR8X/oxT73FFDWPgZaJyC8cCqgnRXIEVwcIlrNLMW5Ke+0XRd/dp
         JcrIOpZT/YPqiVNFDf0IIa9qwlEQ+n6MemmYp+Q7q7FQq6MseQznUBWYrJsW90xpFnIC
         toyai0wb2eNeHa/cLPNmM9TJiULbgLXLsPEfQVBUf1GnTk2N6jHxXoNAODyOpv9YM6Zp
         imJeAUDpB+jprWs68k6nPe7BdUAzGhMiVptaSioY2JwoQqWFW4IA0DE7s9VR1Lar0zXb
         TlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UeeT7H3+S/EfjlH2OjEVsLUN0/0ZPu141DEfB94dmrI=;
        b=QgOy9j6IEfIynAV/O2RITLyR4Q21mxAVBptV/cSAvlS/O2ZslvH3WoWyb9cqik8FKz
         78OKLK+bMyDHTU6SRc6XkSYMciWQ2CyldMDtV6yn+0vaSfKd+sFwuFULNFhyJv5dIpiw
         wjHUrVkC1EA5qawvtjjoCshca1w5m1A50W9eFpfNV2mPXjc0rIZwZ7DqqfqW6ijAxmzc
         /mtf1jSMQw5x1Y/j2gkoLKuxmZ7nyQ7dAo6TmvG9/nkspEuuTEk6alpLcBiZcjn8eOUz
         X/LNzXWbClinLeBfj10KvdWfY38jjAv4GfBpps3nky+9hXYB0JNKPPejKyZuSeZ1uh6P
         7gxw==
X-Gm-Message-State: APjAAAVfuwD62CSECD0xUCONKrl6mQQx0LKnFLz7mIadv9nlS50vUcjk
        XnJCS62rsLIprX/bZEZ6pVLEazKQzRdp6Ne+s0QdfWyHvS2qLA==
X-Google-Smtp-Source: APXvYqxboHljMuyzXKeBvNjrEGsLI+HM704aVJ+VMJRhzNXR2/V8LFz6Fg9CWyBB9BP+CgJNRP32m/dTuyxmQ0rxW9A=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr20337835wmj.65.1561476704161;
 Tue, 25 Jun 2019 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com> <CAJCQCtT8SE5TYkVniJxhK5ZpE8OoE6c9AVPzs4baHn8C5y5X5w@mail.gmail.com>
 <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
In-Reply-To: <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 25 Jun 2019 09:31:32 -0600
Message-ID: <CAJCQCtTbPNmPdXX4pd1Zar8UA5bUiQTpK5MvZ9mg-qyHwe78Lw@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 12:58 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 25.06.19 =D0=B3. 5:49 =D1=87., Chris Murphy wrote:
> > False alarm, not a new issue at all!
> >
> > I have a different system on kernel 5.1.11 using Btrfs as root with
> > persistent systemd-journald storage, and compress=3Dzstd. And I never
> > have problems with it, so I never run btrfs check on it, until now.
> > And yep, same problem. All the journals that have been rotated, are
> > zstd compressed, are nocow, and btrfs check complains about them the
> > same way.
> >
> > root 257 inode 62526 errors 1040, bad file extent, some csum missing
> > root 257 inode 62734 errors 1040, bad file extent, some csum missing
> >
> > Turns out this is just btrfs check noise. There's definitely no
> > corruption. These files still pass journalctl --verify which is
> > checking its own internal checksumming in the journal file.
> >
> > I don't know what's best practice. I think on any kind of flash media,
> > I'd rather not have +C by default, so that the logs compress on the
> > fly, and also rather not have defragment on rotate because that also
> > just increases wear by rewriting everything. Yes the journals are
> > heavily fragmented if they are allowed to COW, but I don't think I
> > really care about legacy files being a little slower on flash. *shrug*
>
> But why are your nocompress files being compressed? I just tested latest
> misc-next branch and a mounted fs with -ocomopress=3Dzstd correctly skips
> compression on a file where chattr +C has been set?

test.journal has +C set and filefrag shows it's not encoded, single extent.

$ sudo btrfs fi def -vf test.journal

Result? No compression still.

$ sudo btrfs fi def -vf -czstd test.journal

Result? It's compressed.

What is systemd doing? I can't really read the code, but in the
comments they say they are unsetting +C and then defragmenting?

https://github.com/systemd/systemd/blob/master/src/journal/journal-file.c

line 371:
/* Be friendly to btrfs: turn COW back on again now,
* and defragment the file. We won't write to the file
* ever again, hence remove all fragmentation, and
* reenable all the good bits COW usually provides
* (such as data checksumming). */

Except all of the logs in /var/log/journal/<machineid>/ have +C set.
So I don't understand that comment at all. They might think they're
unsetting it, but it has no effect because the new file inherits the
+C set on the enclosing directory the journal files are in:
/var/log/journal/<machineid>

There's more btrfs defragment stuff later in this same journal-file.c
code but I don't understand how it relates to "turn COW back on
again", just that they are definitely submitting files for
defragmentation at log rotate time. But possibly they way they submit
it is different than 'btrfs fi defrag' default, and somehow it gets
compressed.

Anyway this isn't new, all three of my cleanly installed systems on
Btrfs behave this way (all have compress=3Dzstd set). Years ago I
mentioned this same behavior on this list with respect to zlib. The
difference back then I think is that btrfs check never complained.

--=20
Chris Murphy
