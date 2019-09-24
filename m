Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F078CBC0DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 06:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfIXEID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 00:08:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfIXEID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 00:08:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so228559wrw.9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 21:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIpujRMeUEWn20aHGT4yiW1FsOVk4PbhP4W7UzQ33dI=;
        b=Pc6hKfKYHIm9REZzqUiD1NRMS6QC1vbnsEWdEM11XP9Vcq4LxKit9Goqa53g0nILRN
         wU6kNZY7UDD2GT7gPWPMOfmXYpCmWK72BEAmQF4cs/Z3TE7aQ7+OtUNnLq3zNEKXH06s
         eGi2X98i5rXD/nBejppzY4Xrl6n5S37z3oK9RX3O4yoafhWLeQDrUew+HYUUIFAkED/z
         V6PmSLAs9d8KfJEigbgofUlp6TF5jUUV0wU7mpSh/+xW+JPcbdgR7HiXCplwOJV0OfJK
         jHGnPZwA7F56omTqY7TzUQdl5sbEolg7vCCc6FnYKNSSH8iDLeiPAUiBMHteAfVoHIcF
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIpujRMeUEWn20aHGT4yiW1FsOVk4PbhP4W7UzQ33dI=;
        b=aJ6TDAEW22nbFzKgNlqZ7etgZWSN3s05CKXSyUMRpqE5t8qtWqmPfyi7hDVcxB9x8D
         fXhUzzDpsaF2v3/ZT9e08n23elSd80oozWdi760qXWkvkGAPIqNpw1xckqCBzjBb50ow
         nBNlHb4DPmLeAVzF+2lutqiAhfLWojiIKO+UcYfcY7kizodwXXUrSVyShRb7sGYEQZD7
         G46MuWsluyenkxsxsk3b6EaxTrU+ePdFy68Eo3Xw67iyX6XCMD55rwifDOcP1EeBdAPF
         tGhhmbM8WiFS6REagHy6jZSXJKgsExxwCbpL8FgpkvYRX3aGSB8JfiJvSoRcNuA1T2gp
         dUWg==
X-Gm-Message-State: APjAAAXmU0Un+46PSmwNfpiSlRL2EMJPtR0+8G77cf7aOM4yjyOwULKI
        KhGa+k6zbLQSPcj1RiKMk1saHy0Vmo33gkkJAOGZ9g==
X-Google-Smtp-Source: APXvYqz+AiwEP+Pw5C/aDWyDs3UP3RHmwzeVOHmQ4CGJoNYXbc3NBhFdj26Qx+feUY61YVgYVdt8uPsQRmCkWTICnPY=
X-Received: by 2002:adf:efcb:: with SMTP id i11mr511824wrp.69.1569298081601;
 Mon, 23 Sep 2019 21:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
In-Reply-To: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 22:07:50 -0600
Message-ID: <CAJCQCtSUFcpCX_w-iWqsrjK3O5bpT=PMfmQk23mVeYrz1jo8Mg@mail.gmail.com>
Subject: Re: Tree checker
To:     Charles Wright <charles.v.wright@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 6:35 PM Charles Wright
<charles.v.wright@gmail.com> wrote:
>
> if I boot the 5.0.0-30 kernel and enter the "dwhelper" directory and
> do "dmesg" their is this
>
> [  199.522886] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x2d0100
> action 0x6 frozen
> [  199.522891] ata2.00: irq_stat 0x08000000, interface fatal error
> [  199.522893] ata2: SError: { UnrecovData PHYRdyChg CommWake 10B8B BadCRC }
> [  199.522897] ata2.00: failed command: READ FPDMA QUEUED
> [  199.522902] ata2.00: cmd 60/08:78:a8:57:f3/00:00:12:00:00/40 tag 15
> ncq dma 4096 in
>                         res 50/00:08:a8:57:f3/00:00:12:00:00/40 Emask
> 0x10 (ATA bus error)
> [  199.522904] ata2.00: status: { DRDY }
> [  199.522908] ata2: hard resetting link
> [  199.837384] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  199.840579] ata2.00: configured for UDMA/133
> [  199.840771] ata2: EH complete

This is a hardware problem. I suggest swapping out the cable between
the drive and controller.

"interface fatal error"
"BadCRC"

>
> but all works  as in I can access the files as normal

It's not normal to having the ATA link hard reset due to CRC errors.
That blows away the entire command queue on SATA drives. There's
nothing any file system can do about this.



-- 
Chris Murphy
