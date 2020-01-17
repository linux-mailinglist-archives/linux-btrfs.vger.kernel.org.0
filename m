Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD814049B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 08:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAQHvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 02:51:14 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:33477 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgAQHvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 02:51:14 -0500
Received: by mail-lj1-f170.google.com with SMTP id y6so25511205lji.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 23:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MuiNCd61mCvS4U0FWf6tnyVqMMQ4eesmXDZ6DmVSqBU=;
        b=tZGKha7qdjxDh/qWvYaKrwp2TR4xagkRKstG/udeUI5iyXYK/MFzTU1XgosHsHDF+c
         QBeGMNMsiGtbHN9EgX3fhYvYPlQyLHmagH07CVMs9ERTlEy6OOqnT6GZWceBS7DOicZZ
         cLr50MqvN3bhsS73y35lPIccPotFVKQYXmgU9O30pquagoxTogPsFi8ta7ghz5qh+SGO
         O0CPLfsFiy7o9vnv9LLbwvFwqJhZEdYsEv5+a/DFSspjocAxc99jIIrZxxwZd2Jzymxz
         GbIO4XBEh7FjoIUItUxSLlYLqNJNAct2e02glGtet+3hiPDEvXkyaH4clqlxpZEr9Y6t
         8qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MuiNCd61mCvS4U0FWf6tnyVqMMQ4eesmXDZ6DmVSqBU=;
        b=CQdZtV12pziq6pagq1ydSpQV7kFjS6JJGB2IYy0l6zi7fqsq2jI9MHB9eVN7qLTeH+
         r9xiug67uav6t6eed9m2Enk2cl9OP13NP3DrX/eByxGyi/gqM9juHg3xpsGusOunIamO
         qXyGajgBoFHNEeGMlhELQZPasMHeteQl36B0uaPNMtZE9imdtsBogaRaU1XYwfwwqKuR
         fmSrj5qUR2+baILrE4iRgCUlnZCFWXKlWGvXH8KTB/+FBgN9dgIbVAxjK1YJ252DdSd8
         5VE75wwEQ8qXQbPQvQ9AxkqY45t4ixN43gLMAwTURP0/sukez4kHu3qzrmgnCEprW92T
         hb9g==
X-Gm-Message-State: APjAAAWZwrB1l+Izw1qewI16UeyI/BrE90aM7UKTslE0Cdubz4C7NNgJ
        iVnjTVbSY+2hLMYg0HDepShta1QCql9kCTnIAlc=
X-Google-Smtp-Source: APXvYqxQ7mDOl6uNmVaXSnwWHjOnpvFGcKXW0hy0TZaMe+coes6/QQ1JlXInGw02V5uq2ilbKHUd7bP+9fC4607bb2s=
X-Received: by 2002:a2e:7c08:: with SMTP id x8mr4987299ljc.185.1579247472548;
 Thu, 16 Jan 2020 23:51:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+ZCqs6w2Nucbght9cax9+SQ1bHitdgDtLKPA973ES8PXh1EqQ@mail.gmail.com>
 <6ba43f60-22d1-52da-0e9a-8561b9560481@suse.com> <CA+ZCqs5=N5Hdf3NxZAmPCnA8wbcJPrcH8zM-fRbt-w8tL+TjUQ@mail.gmail.com>
 <53da4b02-6532-5bb9-391c-720947bac7f1@suse.com>
In-Reply-To: <53da4b02-6532-5bb9-391c-720947bac7f1@suse.com>
From:   Peter Luladjiev <luladjiev@gmail.com>
Date:   Fri, 17 Jan 2020 09:51:01 +0200
Message-ID: <CA+ZCqs4pTKePM4NaStAs=CWYBZbA_btqip1WiU8DC6DL13Eh_Q@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is the output:

btrfs check --force --mode lowmem /dev/mapper/system-root

Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/mapper/system-root
UUID: 9639a3e6-cd08-4270-b4d1-d2946d2b8d2e
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
btrfs: space cache generation (539645) does not match inode (539641)
failed to load free space cache for block group 22020096
btrfs: space cache generation (539645) does not match inode (539641)
failed to load free space cache for block group 1095761920
btrfs: space cache generation (539643) does not match inode (539640)
failed to load free space cache for block group 102161711104
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 53501751296 bytes used, no error found
total csum bytes: 43476196
total tree bytes: 1552203776
total fs tree bytes: 1422196736
total extent tree bytes: 70172672
btree space waste bytes: 276902557
file data blocks allocated: 331882188800
 referenced 105424904192

On Fri, 17 Jan 2020 at 09:34, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 16.01.20 =D0=B3. 18:53 =D1=87., Peter Luladjiev wrote:
> > Hello, thanks for helping, here is the output:
> >
> > btrfs check --force /dev/mapper/system-root
> >
> > Opening filesystem to check...
> > WARNING: filesystem mounted, continuing because of --force
> > Checking filesystem on /dev/mapper/system-root
> > UUID: 9639a3e6-cd08-4270-b4d1-d2946d2b8d2e
> > [1/7] checking root items
> > [2/7] checking extents
> > ref mismatch on [1497018368 4096] extent item 72057183177116417, found =
1
> > incorrect local backref count on 1497022464 parent 51611369472 owner 0
> > offset 0 found 1 wanted 3087007745 back 0x564582174c70
> > backpointer mismatch on [1497022464 4096]
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 53532647424 bytes used, error(s) found
> > total csum bytes: 43476204
> > total tree bytes: 1551368192
> > total fs tree bytes: 1421295616
> > total extent tree bytes: 70238208
> > btree space waste bytes: 276638054
> > file data blocks allocated: 331679563776
> >  referenced 105423634432
> >
>
>
> Right so it seems this the only error. Just to be sure run btrfs check
> --mode lowmem  since it provides more readable output. If this is the
> only error in the filesystem then btrfs check --repair --mode lowmem
> should be able to fix it.
