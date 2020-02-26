Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBF170C6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 00:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBZXPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 18:15:01 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:42121 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBZXPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 18:15:00 -0500
Received: by mail-yw1-f45.google.com with SMTP id n127so1200571ywd.9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VhhTaABA7pe2x5kcWrmSM1l4i08UozkQiRGZYUue9E=;
        b=eeW6L6Tsg+xZhCXyG7vO5dXOYvazbiPnLIuh3/pHVwS8SzhumN2/wBkRrvjR8xNFN8
         DBi6t/dmD1CT7HWzHoPeTkAIrI1PVKR5621GNMUCFx42cs+USlrqvp331bu60IMnfzj/
         zv/yZXXzFcoqmuvM9Ri1Z7Yz4uyOeymsE4IdQU1EtPI+PTLjX2lEHm4wGgp2NQ0QnyRf
         MiRRchaSBhDCtiMSfQ1W6zSA83MabJvIonNHro+xZjFr/tUaLpDGPeJ51gg9SO1Pjbmp
         XrmAiVxD2QZ/3GeDgV9pRHIeV8Lx338ZKavABFhdKI6vxYY8nspo5XG9SYLbbcXCNKXC
         hlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VhhTaABA7pe2x5kcWrmSM1l4i08UozkQiRGZYUue9E=;
        b=DVUD/5K8HDO9Tmi5uYgve5Y4S8iAY0vN+D3XISQWMNYiDHNmV/IU6Wwscc45rzyHn0
         c/mqpg3jwvb9A2rjkNegVnwtYzB/pSER6uwNR+wj/scbZ4+a9wQ5UyDsHFv/Pk4KeTDP
         +5ij9tLL9+HZ04vaR7RS/zPJn8x7NVFFDYEXmpT6obLGrtA0yahvuO7taxzyxWmdS3/R
         oSx5no6AIW/zLcIAuwpcUlC0lrNU2oSFHqXm71Af0e4jt30sSAJriOTFChTVj7JbcBtL
         z527UJi77hQALGYh7tGo1ReD7+BL66oubPVb7ncnLlHehKsAC6q/IK1muX4JgLJ0Bhd9
         Y0DA==
X-Gm-Message-State: APjAAAUGgHF2WtzrBFO1DytugIHVGDmQYXUu9KYZRJYlZT2DRsWb3LX5
        dAn7UtVPCCQMLv2A0hW0tsD8k6qlZzAv4ZDnt5s=
X-Google-Smtp-Source: APXvYqx6fjEyxXjhxqqCY6nWy/qaY2iEPnF0ZkY+rkxFyhy2h1MKcRXbn5OZv6XtpBaHPdxcRF8VwCBKgczMPnrSx8Y=
X-Received: by 2002:a81:415:: with SMTP id 21mr1593620ywe.432.1582758899685;
 Wed, 26 Feb 2020 15:14:59 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
In-Reply-To: <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Wed, 26 Feb 2020 23:14:48 +0000
Message-ID: <CAG_8rEddjjA2kta486kZ7B9J7s4F5twyqrxL-kff783atxSFXQ@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Jonathan H <pythonnut@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok so the last message wasn't so easy to read due to line wrap so here
it is again with the log output replaced by ix.io links.

To expand on my previous message, I have what was a 3-drive
filesystem with RAID1 metadata and RAID5 data.  One drive failed so I
mounted degraded, added a replacement and tried to remove the missing
(failed) drive.  It won't remove - the remove aborts with an I/O error
after checksum errors have been logged as reported in my last e-mail.

I have run a btrfs check on the filesystem and this gives the following output:

WARNING: filesystem mounted, continuing because of --force
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: a3d38933-ee90-4b84-8f24-3a5c36dfd9be
found 9834224820224 bytes used, no error found
total csum bytes: 9588337304
total tree bytes: 13656375296
total fs tree bytes: 2760966144
total extent tree bytes: 388759552
btree space waste bytes: 1321640764
file data blocks allocated: 9820591190016
 referenced 9820501786624

The filesystem was mounted r/o to avoid any changes upsetting the
check.  I have now started a scrub to see what that finds but the ETA
is Sat Feb 29 07:57:49 2020 so I will report what that finds at the
time.

Regarding kernel messages I have found a few of these in the log
starting before the disc failure:

http://ix.io/2cLX

but I think these may have nothing to do with it - they may be another
filesystem (root) and the timeout may be because that is a USB stick
which is rather slow.  My reason for thinking that is that the process
that gave rise to the timeout appears to be pacman, the Arch package
manager which primarily writes to the root fileystem.

It looks like the disc started to fail here:

http://ix.io/2cM1

This goes on for pages and quite a few days, I can extract more if it
is of interest.  Next is a reboot - this is the shutdown part:

http://ix.io/2cM2

then on the way back up:

http://ix.io/2cM3

then after mounting degraded, add a new device and attempt to remove
the missing one:

http://ix.io/2cM4

and at that point the device remove aborted with an I/O error.

I did discover I could use balance with a filter to balance much of
the data onto the three working discs, away from the missing one but I also
discovered that whenever the checksum error appears the space cache
seems to get corrupted.  Any further balance attempt results in
getting stuck in a loop.  Mounting with clear_cache resolves that.

Regards.
Steve.
