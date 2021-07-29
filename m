Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8C3D9C03
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 05:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhG2DMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 23:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 23:12:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C7C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 20:12:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso5792898wmq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 20:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIyvXWSweTyclQqYELXw3SllTAF8d8Atg81b0p8mC58=;
        b=VgU2JKWvFmhoO84jZrDybodHsHg+Sv7TMh2+8RU/+Tz0P+1Qg4fjNvqGfl98NghlZ0
         opeIKYH/BlD1xV02UgNtLBAeZgTeB5PNHJPUqtDI8TSGZ6O96KG1GBuK/SWOlXKMA/Yx
         9NsLTyDbCWTfymijRZX7BIX/a5xlSY1NgySYUZ1A26iClocG6K8s4daL+JUW1XXSpOJR
         YuCxDOQN8lup2MNKiz9dwlmRAR3pPNK8FfUpzcABgEcY70Jmz8bNNxtg+S2qbRbANPSH
         zClkhIfzm21htO+jswbxlB+qReE1zPrnpY0B9JPp2tiOx8jqNJ4CAOnCrXWg7d5FLVkT
         FpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIyvXWSweTyclQqYELXw3SllTAF8d8Atg81b0p8mC58=;
        b=iMuHLkAD9Hoq2h+jy2ZhZ1UXilyNUMFl3g6FXUEDD1Et9eLy5+l+18h8ddLof6+/8L
         XjwOdCInEXGNc2sFgsuoNmvLBHxOimPQ7Dro5Vwgab/G3yG20EbY9zbdgV1YF/6L5u0j
         A/DGtGafQf4Iir7DFVRJB2ryYcC43WKiEWgJ+eJH4Eb6szFSapw7nv2HnjC4her5VNVD
         z4S2Mey1Zsv7+XNvOtdoNPywAZfyKMJBRT5i1+zrkE4n3SEIY6rCCy2vXrj1ExnTcQnG
         yMaPWEpraeT70mRtrgjWdmkNplyv63F4SykKtVv1rL4MmPF9d0LBfJ8ZVic+JmBtW/t8
         dvzA==
X-Gm-Message-State: AOAM531Og2lAxIJjnP7wgLSesJoTkP2tWIrjCMSJXKAXJuYMpZqJJ4HM
        KPAFliP7wmcBDJqVDl16GUkR5ggcP0tJAVSnKI0Omw==
X-Google-Smtp-Source: ABdhPJxYcyPDEkLkTMGydynTvtwhC9L11DxyX74nW8l3VYsfws9keg86i3EblvCeuOXwBvdkXXIcCvoF+BVXKhRFWqI=
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr12196126wmk.124.1627528339681;
 Wed, 28 Jul 2021 20:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
 <20210727214049.GH10170@hungrycats.org> <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
In-Reply-To: <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 28 Jul 2021 21:12:03 -0600
Message-ID: <CAJCQCtSAtCdZt3c+_qMvDCx0VuSpHf0uG1LU2haSbgKHuokT0Q@mail.gmail.com>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
To:     Dave T <davestechshop@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 9:15 AM Dave T <davestechshop@gmail.com> wrote:
>
> The journal shows:
>
> Jul 27 21:54:39 server kernel: ata10.00: exception Emask 0x0 SAct
> 0xffffffff SErr 0x0 action 0x0
> Jul 27 21:54:39 server kernel: ata10.00: irq_stat 0x40000008
> Jul 27 21:54:39 server kernel: ata10.00: failed command: READ FPDMA QUEUED
> Jul 27 21:54:39 server kernel: ata10.00: cmd
> 60/00:90:98:2f:9f/03:00:a4:00:00/40 tag 18 ncq dma 393216 in
>                                          res
> 41/40:00:20:32:9f/00:03:a4:00:00/00 Emask 0x409 (media error) <F>
> Jul 27 21:54:39 server kernel: ata10.00: status: { DRDY ERR }
> Jul 27 21:54:39 server kernel: ata10.00: error: { UNC }
> Jul 27 21:54:39 server kernel: ata10.00: configured for UDMA/133
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=3s
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Sense Key :
> Medium Error [current]
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Add. Sense:
> Unrecovered read error - auto reallocate failed
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 CDB: Read(16)
> 88 00 00 00 00 00 a4 9f 2f 98 00 00 03 00 00 00
> Jul 27 21:54:39 server kernel: blk_update_request: I/O error, dev sde,

Bad sector. It'll need to be overwritten to be remapped by the drive
firmware. I can't tell if it's 512n or 512e but the write needs to be
the size of the physical sector or else the firmware turns the write
into read-modify-write and you'll just get the same UNC error on the
read.

DUP profile will recover from this automatically. The file system is
informed of the physical sector, it does a reverse lookup to find the
logical block, reads good data from the good copy and overwrites the
bad copy. And either that'll stick or fail with an internal write
failure in which case the firmware remaps to a reserve sector. Once
reserve sectors are gone, you get UNC write errors - and that pretty
much means the drive is toast.



-- 
Chris Murphy
