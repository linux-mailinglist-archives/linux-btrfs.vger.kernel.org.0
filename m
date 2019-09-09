Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99434AD4DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbfIII2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 04:28:13 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34661 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbfIII2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Sep 2019 04:28:12 -0400
Received: by mail-oi1-f182.google.com with SMTP id g128so9846155oib.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajJLqri6wucyTkVUdz1/YNbVRy8tdPYBQ0qHFpGLMZ8=;
        b=hyoJfk7P41ekvr/9a+zXqDTBDc30nKtZ4G3ni0Wh9jb8V1ntz9gdGsiCJE1fqKez1I
         6RQkHTumMehJbM3iU7GdS4CYL71LhimQ/lKeBDwNwZXfF4HrMTI4jIzjdum683chXwUf
         8Kp6YLpAM6tDK21niuA5FGuWqYlz/lhFSK/dGuSfKcQIhY1YmNvG5UuchvgKs4ad2UHJ
         mQrYkGS7Y51YlVjaY4Hye8lYp0cXVLTNgwWCjPpx0YIKjQKMzaOqtJYYXgRd2/D2f6FZ
         vNAf6RJfpJdVwgXQhKzXHkxgVh/y0C/FWXMdS3eRpUql5vQDS/y4KP5a/AJJkO8GYOVS
         qJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajJLqri6wucyTkVUdz1/YNbVRy8tdPYBQ0qHFpGLMZ8=;
        b=nWq7ZOGrs3SoWzIgmNMw8YqcokfXPBvbObKW/7cwGwgWc3ywdmfA++3tD74XfLtfvg
         9nzMUT+NWEEls2cNjzoYOnawn32kr7jY/pLpvr6LvTwk80qTykBNYgHbgfBDCpKB+ovC
         ugjVLDXoHGkAj3s/qoCTzncA8uwE87Nv2naium4h8VQ0KkC5ngBlELSuctplnQfYY+3R
         yHJF9ExpGRFeZx3qML46l/NUyMn5YNkTkDRqRPCyyxLjD3bMOSNMv9tSCSf6F2QdLq6i
         9py/Fy337NurjhPqEER6dXQZF6RMLbCEUEW3aUF/MNz/jsqxdjuQzX4vblKx0MjWbS6M
         vC6g==
X-Gm-Message-State: APjAAAW2ctlpc2PwUTV5f5BUPYeLpjVKxKvj0++Ba/Acmb9fpOIOodA+
        iI0QBMZgmpY6RnhU8MbQQRsWZbwB0iHUWuecprYTeoyD
X-Google-Smtp-Source: APXvYqxJUKf4MkxyaUHCJZo1CtgIdr/WQic1Nr2Tj+w3Bgg/Z+j5Etv45tWDOmYFOjJravcEm1qeN0QoSvC5bzHz5zM=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr15573919oif.2.1568017691920;
 Mon, 09 Sep 2019 01:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
In-Reply-To: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 9 Sep 2019 11:28:00 +0300
Message-ID: <CAA91j0W1V0oRTKNy8BYDBbUbZEfbTZaxpqQnUm2tZBGxV1nV+Q@mail.gmail.com>
Subject: Re: Balance conversion to metadata RAID1, data RAID1 leaves some
 metadata as DUP
To:     Pete <pete@petezilla.co.uk>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 9, 2019 at 11:03 AM Pete <pete@petezilla.co.uk> wrote:
>
> I recently recovered created a fresh filesystem on one disk and
> recovered from backups with data as SINGLE and metadata as DUP.  I added
> a second disk yesterday and ran a balance with -dconvert=raid1
> -mconvert=raid1.  I did reboot during the process for a couple of
> reasons, putting the sides on the PC case, putting it back under the
> desk and I updated the kernel from 5.3.9 to 5.2.13 at some point during
> this process. Balance resumed as one would expect.  Balance has now
> completed:
>
> root@phoenix:~# btrfs balance status /home_data
> No balance found on '/home_data'
>
> However, some metadata remains as DUP which does not seem right:
>
> root@phoenix:~# btrfs fi usage  /home_data/
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              4.69TiB
>     Device unallocated:            6.23TiB
>     Device missing:                  0.00B
>     Used:                          4.61TiB
>     Free (estimated):              3.15TiB      (min: 3.15TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>
> Data,RAID1: Size:2.34TiB, Used:2.30TiB
>    /dev/mapper/data_disk_ESFH      2.34TiB
>    /dev/mapper/data_disk_EVPC      2.34TiB
>
> Metadata,RAID1: Size:7.00GiB, Used:4.48GiB
>    /dev/mapper/data_disk_ESFH      7.00GiB
>    /dev/mapper/data_disk_EVPC      7.00GiB
>
> Metadata,DUP: Size:1.00GiB, Used:257.22MiB
>    /dev/mapper/data_disk_ESFH      2.00GiB
>
> System,RAID1: Size:32.00MiB, Used:368.00KiB
>    /dev/mapper/data_disk_ESFH     32.00MiB
>    /dev/mapper/data_disk_EVPC     32.00MiB
>
> Unallocated:
>    /dev/mapper/data_disk_ESFH      3.11TiB
>    /dev/mapper/data_disk_EVPC      3.11TiB
> root@phoenix:~#
>
> root@phoenix:~# btrfs --version
> btrfs-progs v5.1
>
>
> I presume running another balance will fix this, but surely all metadata
> should have been converted?  Is there a way to only balance the DUP
> metadata?


btrfs balance start -m convert=raid1,soft

should do it.
