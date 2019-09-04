Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05692A8DC2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfIDRgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 13:36:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDRgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 13:36:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so22175674wrt.4
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d44qtIqdHRg7B2Giu7yG0QxOK6Knn2kRmBFh+A/9fTM=;
        b=wbOTFPEageldGTsbCglpapdUoFlsrz+h1H4BXdO0e7aMQQeF/LzC+itdBf5a43njCl
         z/8BVAPN/whY+PsyGxeFKlXJZ0Dywq4mXEQltlJdUHmrWNU3T8GLRg8vy+tQfw/0uHhp
         dxtNe2i9B6kgmq1ZZQbLqv/GnSBbW5TwIrmtkFgkXXha+110Tgi/DiCHFJXBziwrSpX6
         Q8HGsbs5tm7gFdMdJxBXHS/9LvQtlhcvbFrbnGMIQZLVT2JuSHgX11gzYHOpb/Vy6z5B
         80FTpoSliZTPQZSflycbj2puVnGZyGB9XV7KQ3MIqPdSAncGy64SYMiJeLIk5WZ8ZhE5
         DVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d44qtIqdHRg7B2Giu7yG0QxOK6Knn2kRmBFh+A/9fTM=;
        b=tfH302UhGer5QLAbEbLVVDAE4fOg0bDKiDYhnBnQXBIbwxSimgMshg6C1OX33+PQs+
         MPlchF6MWzVRhAoOGM5/MMbWzcIrCOVT9fB9B+60zY3ORVW9CNCHlLw9YNTIIZR3AtNn
         MWWvFcoY96IxBLiDX8aBcOc18e85hll7yBo/ZTlwHQ+EMSuOavUn1HyvhRY/AhyqHP94
         2XyjLBuhgwIBtVjcFew5XbKsXdqiFaAKhX/+QV/8nizINRb5aEg+aKrxbVoYCjbZFAm2
         gnDikQKxrsA5rsXwK4QYj6f+F6cKoaFWrdDpm/3QhoQnFsSL77UHBhUg7qK0KREs8C7y
         kc1A==
X-Gm-Message-State: APjAAAVN5RV02WAtR5zFI+1+j7MbZgEEi0iVCSHoyhEV3B69ycwUyZJp
        YGRdTFa07mVv4RXIR6DIzBtL5mRAkvqmsgNDq1MNqJmZBhY=
X-Google-Smtp-Source: APXvYqw8l9JOPzL9+zzHw7vlADaviRX+QMjpGr8Rv4kEn6JvZ9NDrMGZpjtg/K3fe7b/x7RQ0uFyqh53TrAx4DukvKY=
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr3150068wrs.268.1567618578587;
 Wed, 04 Sep 2019 10:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com> <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
In-Reply-To: <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 11:36:07 -0600
Message-ID: <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
Subject: Re: No files in snapshot
To:     Thomas Schneider <74cmonty@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 8:45 AM Thomas Schneider <74cmonty@gmail.com> wrote:
>
> Hi,
>
> I was thinking of this, too. But it does not apply.
> root@ld5507:~# btrfs su list -to /var/lib
> ID      gen     top level       path
> --      ---     ---------       ----
> root@ld5507:~# btrfs su list -to /var
> ID      gen     top level       path
> --      ---     ---------       ----
>
> And there are files in other directories:
> root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/mgr/ceph-ld5507/
> insgesamt 4
> -rw-r--r-- 1 ceph ceph 61 Mai 28 14:33 keyring
>
> root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/mon/ceph-ld5507/
> insgesamt 12
> -rw------- 1 ceph ceph  77 Mai 28 14:33 keyring
> -rw-r--r-- 1 ceph ceph   8 Mai 28 14:33 kv_backend
> -rw-r--r-- 1 ceph ceph   3 Aug 23 09:41 min_mon_release
> drwxr-xr-x 1 ceph ceph 244 Aug 26 18:37 store.db
>
> Only this directories
> /.snapshots/158/snapshot/var/lib/ceph/osd/ceph-<id>/ are empty:
> root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/osd/ceph-219/
> insgesamt 0
>
> To create a snapshot I run this command:
> snapper create --type single --description "validate
> /var/lib/ceph/osd/ceph-<n>"
>

I don't really know how snapper works.

The way 'btrfs subvolume snapshot' works,  you must point it to a
subvolume. It won't snapshot a regular directory and from what you
posted above, there are no subvolumes in /var or /var/lib which means
trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
it's failing but snapper doesn't show the error. I'm not really sure.

-- 
Chris Murphy
