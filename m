Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952A29A21C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfHVVV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 17:21:58 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53179 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbfHVVV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 17:21:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id o4so6981843wmh.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fChKrEgDy14PviADacm05oLfTT8UXQ+CAMP+aVeACLk=;
        b=vkIg3klsLgkBoTEZBlyRr96pxpnDUB0iNL6hb9mxUL7hWXkIlsxXrBBaHaBIq65w/z
         deynOq33dWgPo5gdK6RTD8JpG/eI4GupCIincS68HF8sFyAQRKaEq51eG+ZmcOGmpo0p
         iNiv1OXK9HCXgwnjqTc04sQyIDVD+jk5kAnbmcWh6/kgQZUhSgrh1dq/57jE8YkTvEAq
         GGbcyAxxyjmoUzkaa8Hhlnu+VOpZrsB8UdOy9/zH/BNtOmplRfL09i+P22eTJxsfxv8k
         ADgTTf3Ilr9coQCi3vHJdm2o4VaYkKZaFqDETB8jhtPiPJTcousaujgafLgabC1eW3nq
         AkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fChKrEgDy14PviADacm05oLfTT8UXQ+CAMP+aVeACLk=;
        b=McoWHDVRg5DDxITFu1+hUi7bCz1XU4XHZi5fEZDV6p4yRILfcaQ4aoB9sIOovP5q4q
         f8RCewnF7JCV2gEn9/lDP0KFSGfTUDjqeQZw9Uijw42PKZNQxFEh//j63pVkQ04okv/0
         FfNi0ZEM1MQ/sDEYfzeE0qY9cnZNy8Ofu06r/N2uEz+khlbsC6T/yUPk/4z5b3Rdsrxg
         BLtI/MtTH4DMEujaD77qJBII7WWf8VLm2FAD84EEUYuQw1R07SFdRqBOMjSRau6H81yv
         Ck1ShTZ0ZnvB/iRfhvsi4XOOxvUeN48VQNkyRY2vQ1Wk4XD3DL7+Xz0EPUN7RUTlsC2c
         tg4g==
X-Gm-Message-State: APjAAAU0cJGqgqTQ7JBItUmSmxKNw+S3fDYZS1xJpVmKwKrDFxukm8Vg
        Plo0zlcV68NOhIsAg1ElMuWnjhAccAD976P1xBKCXw==
X-Google-Smtp-Source: APXvYqyI3HSO2rjtZ0amlWYDObqFZ5xsStBnHG6b9UUap+tWOAdmbdP2oSIGUZr2AXD9yx+V7mRaUgDL6YsKuRqPXlY=
X-Received: by 2002:a1c:a957:: with SMTP id s84mr1083242wme.65.1566508916227;
 Thu, 22 Aug 2019 14:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRYFtPGn2drNxrcuYFTTvmvRD7iuDNG=i1cDvSu=zcF6A@mail.gmail.com>
 <20190822011219.77d2d8bf@natsu>
In-Reply-To: <20190822011219.77d2d8bf@natsu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 22 Aug 2019 15:21:44 -0600
Message-ID: <CAJCQCtSgBK9KJOf92M8p+2HT33EZcyVVA92qHaQN7gqyDne2Kg@mail.gmail.com>
Subject: Re: Btrfs on LUKS on loopback mounted image on Btrfs
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 2:12 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Wed, 21 Aug 2019 13:42:53 -0600
> Chris Murphy <lists@colorremedies.com> wrote:
>
> > Why do this? a) compression for home, b) encryption for home, c) home
> > is portable because it's a file, d) I still get btrfs snapshots
> > anywhere (I tend to snapshot subvolumes inside of cryptohome; but
>
> Storing Btrfs on Btrfs really feels suboptimal,

Yes, although not having native encryption on Btrfs is also
suboptimal. It leaves separate file system on LUKS for /home.

>good that at least you are
> using NOCOW; of course it still will be CoW'ed in case of snapshots. Also you
> are likely to run into the space wasting issue as discussed in
> https://www.spinics.net/lists/linux-btrfs/msg90352.html

Interesting problem. I think it can mostly be worked around by
snapshoting the "upper" (plaintext) file system subvolumes, rather
than the ciphertext backing file.

> I'd strongly suggest that you look into deploying LVM Thin instead. There you
> can specify an arbitrary CoW chunk size, and a value such as 1MB or more will
> reduce management overhead and fragmentation dramatically.

Yes on paper LVM thinp is well suited for this. I used to use it quite
a lot for throw away VMs, it's not directly supported by virt-manager
but it is possible to add a thinLV using virsh. The thing is, for
mortal users, it's more complicated even than LVM - conceptually and
should any repairs be needed. I'm looking for something simpler that
doesn't depend on LVM.

> > sysroot mkfs options: -dsingle -msingle
>
> This is asking for trouble, even if you said you power-cut it constantly,

In any case, if the hardware is working correctly, the file system is
always consistent regardless of how many copies of metadata there are.
I'm not sure what this gets me even hypothetically speaking, setting
aside the upstream default is single for all SSDs.

The filesystem definitely needs one copy committed to stable media,
two copies doesn't improve the chances of commitment to stable media.
Two copies is insurance against subsequent corruption. There's no such
thing as torn or redirected writes with SSDs. If the first committed
copy is corrupt but the second isn't, true Btrfs automatically
recovers and repairs the bad copy. But I don't see how it improves the
chance of data or metadata getting onto stable media.

If anything, the slight additional latency of writing out a 2nd copy,
delays writing the super block that points to the new tree roots. So
improves handling for corruption but maybe increases the chance of an
automatic rollback to an older tree at next mount?


-- 
Chris Murphy
