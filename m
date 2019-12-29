Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C462E12CB58
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 00:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfL2XVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 18:21:11 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50335 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2XVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 18:21:11 -0500
Received: by mail-wm1-f42.google.com with SMTP id a5so12751003wmb.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYO4DC74SwrtlKrQnOQuAcENPe2Q57fIpyminFup3UQ=;
        b=pAmUzcF025UgGSn5bAg2ZlKeeUeJ0evF+SiV+rFrGKX/VE47jQvxL4FqJvt4TmCm9w
         N9ohkpMDT+5b4zKYZP+te9JrqiPwJ9tT+uJ+Mu2oMj/2Ufg0Pxx10AXJ+CeyHLNcCn5l
         /Q3tdLnWPn3rq0H0bMhtpo+DXPMRfjXg2+iDMZ64garZO3NIAV4D+wyUmTN5ID7Iakzg
         TZOTK9HaJlSkVNUQZSueqcs47wMxXaoaNNuXb5bwwCo8qnIqGzAH/V8mG1kfcLumVd5G
         elue6tqrILLG6uTyKkxmFoWo4LQI/0/zBHc8BOIJT8cwj8Zq7D6nQ2SG2D8wb9Htr+28
         Jidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYO4DC74SwrtlKrQnOQuAcENPe2Q57fIpyminFup3UQ=;
        b=szdNHEqjFuMl3zFsIi3T+NZ3uzRn258k4gBHV9n1/lnUDdDRacOCh5w57iNkpV8dhT
         +Cawrq5lC32aitnnpi3W+FV3+blFMmLJ5i0/GQcSmJvzXcBlXGipsOOSTlRszhX2VwBZ
         14/9BB13gGoT6Zy/pZCab+2YrxMkkx51U9oYZ5PMA/1lOzRG1fQSk8oQ/2zvch5l/Gr5
         7oh7c+vyKv7EpxBjdZS+XQOW3KEo3OuVvCqEE80jCHlOY8ElSnH9JgEscFaP3cUXHMKV
         Egha5G3DUxMZ0WiSNK+vHYvUl6tGp0ySAGx2a4+5CraeVVatF2YyMg7A492MaI8WV0Ye
         Q0LA==
X-Gm-Message-State: APjAAAVYIQetrgaZv+JJ7zAEMCCzS3l1i47+rVBrfNMw+TP4UDlJXdPU
        /wZaE8q/QhXpN3Wo24zIHRSPysr8maG/5thYewAgQuInoHcZlA==
X-Google-Smtp-Source: APXvYqwId9aiT6vV90R6t4U+FXEBC6rVrMP7dlOVFOYL+a2cEAb1g2A9WCPPXGFXo9inkMKBSdT6mrjd2miXrtqsJLQ=
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr30791775wmk.97.1577661669332;
 Sun, 29 Dec 2019 15:21:09 -0800 (PST)
MIME-Version: 1.0
References: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
In-Reply-To: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 16:20:53 -0700
Message-ID: <CAJCQCtQQkWmwcCYtUGMNwFUDB-yKiMwZzTBShK0MTRJX9kNxYQ@mail.gmail.com>
Subject: Re: Intregrity of files restored with btrfs restore
To:     Alexander Veit <list@nezwerg.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 4:05 PM Alexander Veit <list@nezwerg.de> wrote:
>
> Hi,
>
> btrfs restore has recovered files from a crashed partition.  The command
> used was
>
> btrfs restore -m -v /dev/sdX /dst/path/
>
> without further options like -i etc.
>
> Are the recovered files consistent in the sense that if the file was
> committed to disk and was not open during the crash, then the content of
> the file would be the same as before the crash, and that damage to files
> during the crash (e.g. by random writes) would result in the file not
> being recovered by btrfs restore?

In theory they're fine. But in practice it depends on how the
application is updating those files. It's possible the updates are
part of separate transactions, so some of the files may be updated and
other files not updated, depending on when the crash happened. But
since there are no overwrites in Btrfs (so long as the files haven't
had chattr +C set), and if the hardware is honoring barriers,  what
should be true with a crash is that a restore recovers the most recent
fully committed version of that file.

For example, a directory of 50 files that somehow relate to each
other, and some of them are being updated for some minutes prior to
the crash, it's possible some of those files have committed updates
and others don't. Some buffered writes may not get committed to stable
media for several transactions, depending on the application's fsync
strategy and how well tested it is.

See 'man 5 btrfs' and read about flushoncommit mount option for more info.

-- 
Chris Murphy
