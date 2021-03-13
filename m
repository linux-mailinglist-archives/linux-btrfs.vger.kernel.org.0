Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101CF339FBC
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Mar 2021 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhCMSDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Mar 2021 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhCMSDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Mar 2021 13:03:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA79C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Mar 2021 10:03:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e10so6508934wro.12
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Mar 2021 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5WONQpAzFjvW+952/Mm3Aoj94g8YP2FHLW5RZLyUnWo=;
        b=wgqDliaqd2dSJ+76MKwQneg4dbLTtXsqiIvk8X5VbmbDwfih+9xfTGahytnscjPqjE
         KYEeNaTH7SD8klAWyiYQemazuRGt1jOyvjaIyMXvswwaLL/zxIq7EHbLoHipG/JfsRit
         D7NQAQv4hy4D1MgDH36uNyVdqTHEcyw3tSU1n2yWGCHFmPNUSbLPcwJnZfaI81hl6z0N
         mtG9Zs4bTlJSgE4LST0QGNNa4EzM0pfkwBp/mc0Z2M1NllPps+IINKwhOTrUjR2tmtk+
         OYvLV1kQ4sbNLaAQs/c/i5ePF4R4oXyxMbyMp60K+WXlJmRY+TY0nUTgVp/ZmGC9LCLe
         fKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5WONQpAzFjvW+952/Mm3Aoj94g8YP2FHLW5RZLyUnWo=;
        b=uJUiefScdIrHpLWbJThI/x/7Z1M0HOjzVEezn6ztPn1z/pTOHt2jEmfX5yTDVdT8wL
         CRAEi4BGKNT+N/boVu90eQ8axllm/oDagGfBeD928bqeNoYXYR6Y6/HYA4fA8Nig7X6G
         48k0iiAxSLHUJKNLKTEfxxNEcp5aYt38s89QE7SZ5xNB9plSPDh21iWSiLQ/S/ZIyw1R
         yNS+agCkQtZg6qBKE1zrdGqjWC6bNWNOADgmXyU1koRhqcdh2XBCPtebuWPRUuNE8qh/
         +a+IogBSgaP/hmY46xujUeukBWqNtkpkkPIuXS40PtfntMP1PYok6JHRUZlme5Lss2yW
         DjNQ==
X-Gm-Message-State: AOAM5328M84n7rjMOP4vZixuEU4KZF/887yqQ6rUHIZ8dtLasGLLPlUu
        MBtGeQcQXimxFnUZQRo8sb3VtZfsDomQP2mmZKzYHA==
X-Google-Smtp-Source: ABdhPJws0+xNnV928hsIBfmtQ3k1ONj7bTQGZTjWSW3JYzwjq4MQjaYgc7k7/HLHgUFeQOyJBVeBy+0IE3r2/U/P4Gs=
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr19754194wrr.274.1615658589685;
 Sat, 13 Mar 2021 10:03:09 -0800 (PST)
MIME-Version: 1.0
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
 <20210313152146.1D7D.409509F4@e16-tech.com> <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
In-Reply-To: <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 13 Mar 2021 11:02:53 -0700
Message-ID: <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
To:     Thomas <74cmonty@gmail.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 13, 2021 at 5:22 AM Thomas <74cmonty@gmail.com> wrote:

> Ger=C3=A4t      Boot Anfang      Ende  Sektoren  Gr=C3=B6=C3=9Fe Kn Typ
> /dev/sdb1         2048 496093750 496091703 236,6G 83 Linux

> However the output of btrfs insp dump-s <device> is different:
> thomas@pc1-desktop:~
> $ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
> dev_item.total_bytes    256059465728

sdb1 has 253998951936 bytes which is *less* than the btrfs super block
is saying it should be. 1.919 GiB less. I'm going to guess that the
sdb1 partition was reduced without first shrinking the file system.
The most common way this happens is not realizing that each member
device of a btrfs file system must be separately shrunk. If you do not
specify a devid, then devid 1 is assumed.

man btrfs filesystem
"The devid can be found in the output of btrfs filesystem show and
defaults to 1 if not specified."

I bet that the file system was shunk one time, this shrunk only devid
1 which is also /dev/sda1. But then both partitions were shrunk
thereby truncating sdb1, resulting in these errors.

If that's correct, you need to change the sdb1 partition back to its
original size (matching the size of the sdb1 btrfs superblock). Scrub
the file system so sdb1 can be repaired from any prior damage from the
mistake. Shrink this devid to match the size of the other devid, and
then change the partition.



> Ger=C3=A4t      Boot    Anfang      Ende  Sektoren  Gr=C3=B6=C3=9Fe Kn Ty=
p
> /dev/sda1  *         2048 496093750 496091703 236,6G 83 Linux
>
> thomas@pc1-desktop:~
> $ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
> dev_item.total_bytes    253998948352

This is fine. The file system is 3584 bytes less than the partition.
I'm not sure why it doesn't end on a 4KiB block boundary or why
there's a gap before the start of sda2...but at least it's benign.


--=20
Chris Murphy
