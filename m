Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66551752EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 05:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCBE6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 23:58:48 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:41357 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBE6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 23:58:48 -0500
Received: by mail-il1-f177.google.com with SMTP id q13so2026256ile.8
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 20:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9FPi3QR1tjWxth9RpKAF9B/Rn1MM24eJhio9Jo5EF8=;
        b=YCWJLwPC76naFVqxdEAyNQnPSgAVXmGqvpQCxf16QGWIvsmOH1Bg2v4G3VsbINFEui
         B4y+MtNisrwIXywwhB0Ed7i6Mz9umPnULpQjuoR0k/qfn8wZd9ChsndV6HSKm+LkP+uK
         Lusrs0qKNssul8eEIgyLpKerDB0Iyo0IChfMFYEkyH6Bt8iQhaMrilIgycA+k8+J3mqT
         T1M+NSGajE7j4vKiLf8sArTBpQni8vURcjkRHCWmZiikk4xzge2QfbvN92la/Mp1DPM1
         GmkIDDYmWCsGT/fDCNZkgpBCJOfo8sNgl3h+R6rmrAS/4J05hptzHCaL78Rl4zE4bzx5
         ZFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9FPi3QR1tjWxth9RpKAF9B/Rn1MM24eJhio9Jo5EF8=;
        b=EvsHl+dGmKsySsEoLAa1R4B+Ei8DKWp2x+1tCpagpJg0pAGHjSjWPCUAOIZ2NQ7dkW
         muUROQFJzZf4NIrk/HiYDrgnPYTiumi8z2dNF/IXBIpt6XMdpfNVLotO7CytIUHHZ5I8
         zHmiwHNYRd8C6RiaZyzM+cpPRkNkc4/7cCxWlrfq7rLkZc74+GledkcVoRn0pqoWYMzP
         U69l0yPV0/DNI0h5vyWfP+KFozeefeIf9FQWkkMSCuPJEZZ0A0owHBaueOSSUib+KJ28
         FUha7LdTaobIAFGlfKuPRCKO+9sMSiFdK/v8YnMY8ZHkYuH3glxLCS255SJ0+C1+dzDb
         Y29Q==
X-Gm-Message-State: APjAAAVpI+U3P22ent2XZPpEn42f5Zo1fwrtmoAlyrLRJsVbIiNkuwej
        4WD3D/COFf+UuRChN7ON1A4wOh8eZNYL/FCCuC3CVfVnvKM=
X-Google-Smtp-Source: APXvYqxD++ZyaznWKhAN+eighbk5+tUeuXmmEd5tIWv+L9ysONFBHKWrGZDD0oAn6VRZwyoh18fEP4NxqojtGQwa8tk=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr14481368ill.150.1583125127767;
 Sun, 01 Mar 2020 20:58:47 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
 <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
 <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
 <CAG+QAKUuLz0jewrrBOxuQQUvbSBBBrxBZgfabFzn7moJ9Ka55A@mail.gmail.com> <CAJCQCtTROLooGiR4OixEqJKEqMHiOq_Hwndw6EvK2mam1vvG0Q@mail.gmail.com>
In-Reply-To: <CAJCQCtTROLooGiR4OixEqJKEqMHiOq_Hwndw6EvK2mam1vvG0Q@mail.gmail.com>
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 20:58:36 -0800
Message-ID: <CAG+QAKWS6RD5uUPsas3Q7k6_iNP+KHRVkJt42oGmpbCj_bc9Jg@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, we're making balance progress now...  thank you for the help.  The
COW aspect makes sense regarding why the rebalance was stuck.

$ sudo btrfs fi usage /.BACKUPS/
Overall:
    Device size:                  10.92TiB
    Device allocated:              7.19TiB
    Device unallocated:            3.72TiB
    Device missing:                  0.00B
    Used:                          7.18TiB
    Free (estimated):              1.87TiB      (min: 1.87TiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:3.59TiB, Used:3.58TiB
   /dev/sda1       1.78TiB
   /dev/sdb1       3.59TiB
   /dev/sdc1       1.79TiB
   /dev/sdj1      17.00GiB

Metadata,RAID1: Size:4.00GiB, Used:3.83GiB
   /dev/sda1       1.00GiB
   /dev/sdb1       4.00GiB
   /dev/sdc1       2.00GiB
   /dev/sdj1       1.00GiB

System,RAID1: Size:32.00MiB, Used:720.00KiB
   /dev/sdb1      32.00MiB
   /dev/sdj1      32.00MiB

Unallocated:
   /dev/sda1      38.07GiB
   /dev/sdb1      44.03GiB
   /dev/sdc1      24.00GiB
   /dev/sdj1       3.62TiB
