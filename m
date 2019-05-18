Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15F224B6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfERTnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 15:43:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40831 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERTnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 15:43:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so9674773otq.7
        for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2019 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/q+t5dxbZeB0kHXGWCk/grOpvqkLidN4BPAMkP4+IBM=;
        b=qFnl/+vQQ52TknKIIboXZ2l7owIXReLu68/tACuJwwMxJrlVmhXdHsJV402jYQkz7K
         8MB9ZV3XubsILodtTpRDx8+9eEFm8bmUs5yINwqfwxcTjWP4yIYkYG+b/kYWHqvusoBo
         I7gPpr0xqO6KLsP+92gMOKX5c6CehF9Biag8FAnR/e5njYZQvm6QVn9qBiOo/qJXhcMc
         2lUm7ukwlKWCeUi55ijObi0FAtsf4LZC1f8iOjywGV/uWn/3blW3BtVB6qIDEq5ldBz/
         7OUaN62xaZJKZJpzlx4Q2apMNzBh3K88cT59ZJXMudzNWJtqnZ6Ic2l50zo34WvLTtZv
         hHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/q+t5dxbZeB0kHXGWCk/grOpvqkLidN4BPAMkP4+IBM=;
        b=DTMpba4y6X/Jsa+tF47xNhBpsatqZjM8XFD3yU8Ahxy2SsRTH/6PZ0DEI8x0I9Vzjc
         foxhiLs+wOwj02GKhSeT0HgHv8GCTK9zoOeWeBmdfVHdG275GA7sK0M4cb6nNIUiR744
         ptkHQze4MWFu8ycIsQ/sVY8+9PVBU4i1oxbck7KFGvTnML5WBxuZrvHar14kYhkSqNOZ
         FUzg6OYuO+N1tCOsuM30eviFBt48VYvrLSobBjHJe2fie8wfcR64pq69BZdiFY/lULAH
         ZaZrV3svlsxJ3cB6c4s7oWnYr+SCrkavvqf+FjcXLjqYcBIOQmoWsx2HQN9pK4OT3s/n
         xizA==
X-Gm-Message-State: APjAAAVW/QJLghu9SlNMK36tKN2O5mlv+jvp+tJ8APi9xakX5RD0NRUx
        kxuSZiHwIE66/VukoZeGAhZx9vIRe/c/TnBvtGcsT2HO
X-Google-Smtp-Source: APXvYqz3kxUIFskv/Ix+BZm5jES+HX6L2HCCLpJ6gsWic7QL/genG9bIn1KnkW7Pfkqtrp4gTYcPKWuh5fOJa+BsmlM=
X-Received: by 2002:a9d:5e02:: with SMTP id d2mr20498083oti.222.1558208601828;
 Sat, 18 May 2019 12:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
 <CAJCQCtTmZY-UHeNYp=waTV8TWiAKXr8bJq13DQ7KQg=syvQ=tg@mail.gmail.com>
 <CAKS=YrMB6SNbCnJsU=rD5gC6cR5yEnSzPDax5eP-VQ-UpzHvAg@mail.gmail.com>
 <CAJCQCtQhrh8VBKe11gQUt5BSuWCsDQUdt_Q4a4opnAYE5XoEVQ@mail.gmail.com>
 <2571b502-737b-05b5-633b-cf198c0e6764@pobox.com> <CAJCQCtSDBGwCJrgLkEON-0miT2KxzHDo5+SFg=V1sUe0djkCgA@mail.gmail.com>
In-Reply-To: <CAJCQCtSDBGwCJrgLkEON-0miT2KxzHDo5+SFg=V1sUe0djkCgA@mail.gmail.com>
From:   Lee Fleming <leeflemingster@gmail.com>
Date:   Sat, 18 May 2019 20:43:13 +0100
Message-ID: <CAKS=YrM8EKLa+ubvoZdEJUHywra7a8_Yk18bwcA2vx+ZXpVGrg@mail.gmail.com>
Subject: Re: Unbootable root btrfs
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Robert White <rwhite@pobox.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No. It was the host. I've nuked the filesystem now. I'm sorry - I know
that doesn't help you diagnose this problem. There wasn't anything
important on this drive. I just wanted to see if it could be recovered
before reinstalling everything. But I wanted to get it back up and
running now.

On Sat, 18 May 2019 at 20:28, Chris Murphy <lists@colorremedies.com> wrote:
>
> On Fri, May 17, 2019 at 10:39 PM Robert White <rwhite@pobox.com> wrote:
> >
> > On 5/18/19 4:06 AM, Chris Murphy wrote:
> > > On Fri, May 17, 2019 at 2:18 AM Lee Fleming <leeflemingster@gmail.com=
> wrote:
> > >>
> > >> I didn't see that particular warning. I did see a warning that it co=
uld cause damage and should be tried after trying some other things which I=
 did. The data on this drive isn't important. I just wanted to see if it co=
uld be recovered before reinstalling.
> > >>
> > >> There was no crash, just a reboot. I was setting up KVM and I reboot=
ed into a different kernel to see if some performance problems were kernel =
related. And it just didn't boot.
> > >
> > > OK the corrupted Btrfs volume is a guest file system?
> >
> > Was the reboot a reboot of the guest instance or the host? The reboot o=
f
> > the host can be indistinguishable from a crash to the guest file system
> > images if shutdown is taking a long time. That megear fifteen second ga=
p
> > between SIGTERM and SIGKILL can be a real VM killer even in an orderly
> > shutdown. If you don't have a qemu shutdown script in your host
> > environment then every orderly shutdown is a risk to any running VM.
>
> Yep it's a good point.
>
>
> >
> > The question that comes to my mind is to ask what -blockdev and/or
> > -drive parameters you are using? Some of the combinations of features
> > and flags can, in the name of speed, "helpfully violate" the necessary
> > I/O orderings that filesystems depend on.
>
> In particular unsafe caching. But it does make for faster writes, in
> particular NTFS and Btrfs in the VM guest.
>
>
> > So if the crash kills qemu before qemu has flushed and completed a
> > guest-system-critical write to the host store you've suffered a
> > corruption that has nothing to do with the filesystem code base.
>
> For Btrfs, I think the worst case scenario should be you lose up to
> 30s of writes. The super block should still point to a valid,
> completely committed set of trees that point to valid data extents.
> But yeah I have no idea what the write ordering could be if say the
> guest has written data>metadata>super, and then the host, not honoring
> fsync (some cache policies do ignore it), maybe it ends up writing out
> a new super before it writes out metadata - of course the host has no
> idea what these writes are for from the guest. And before all metadata
> is written by the host, the host reboots. So now you have a superblock
> that's pointing to a partial metadata write and that will show up as
> corruption.
>
> What *should* still be true is Btrfs can be made to fallback to a
> previous root tree by using mount option -o usebackuproot
>
>
>
> --
> Chris Murphy
