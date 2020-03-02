Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A41753F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 07:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCBGnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 01:43:33 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35738 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBGnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 01:43:33 -0500
Received: by mail-wr1-f44.google.com with SMTP id r7so11017055wro.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 22:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJ3gmMDknlOnV/aHsJ9qtXAskojU+R+LLI6rwQqI6LI=;
        b=cGq4XlTd0T1BoAzrQ1Dlzo65SlcTHIGrJLwXdWw2GOrJeE4SelBttAeyBHTYUEZu6V
         8Q2E7y1Om7p7tPwdyzcLJAPzXpsLsb9RRSeMiwisuHDJPEbRVknSzA1lu3mhD8pW48Je
         QcbHVEQTp58t/9MUOjObEcR251OxURwr5+/5fR1dzV8P1aNQIsjI9pUMg58mqmEEnTUd
         ISWue7pi2Rp0NTzCLig6Pcl485k3ukpaUZg5lMuchdnyE0szmfVbJLY112CRNoKAuL2t
         /e9S2epz914zsVtIGEmgK3dC0L3j2WRdYybNHFFMJptgJdyTbhgIlQ8dSU5bkuybE8mT
         pXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJ3gmMDknlOnV/aHsJ9qtXAskojU+R+LLI6rwQqI6LI=;
        b=E2qyEcPVRNBKvXWktfW1DLPOUKpZWLJJrnvfi1Q/N2Qnfva71wTIUadFRcPPPic+hs
         fM0RiA5fBYT0EazOZ1O7k5zY2Zbul8siWIw9W/B4QdS05ohf5c9Hnn8LpKY8TZdr2Cya
         Aoqe6227BDiCxmdnTVhiiVZ0Y9f8vq617uGynTSJbblu2b4M/HTq6QfLAM1PRNLT3NAx
         vz+X3El4knra8VzcmT4Wli/ZLBm1ARgeDoqYOdGTDo6fvNpvnoI2olBOWWaUzDZKwQXb
         6gfuzSC9ksYH6mTyR7LMQlmg2st/hSmAQSZ8qWjQ6LGk4u1JFD//sv+aHDIbQ38wRpqN
         Idew==
X-Gm-Message-State: APjAAAX3Kz9bX9GYgMfC5UU3cjda6iYe+HSaj9nRvmFXt2z1cHadOMWB
        Dcr8io3c6L08qSVAdWkUbzAIQ3/iubJgunJLPGtc1gFxRsI=
X-Google-Smtp-Source: APXvYqx7ABixHa4RXkL0S5IDW/bFIFFmED6UFUOKDkrQRkhkHDN1TP3bXFwFPKLrv/LNmVNSp/x7whN7vWnr2d8DFeY=
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr20124058wru.65.1583131410396;
 Sun, 01 Mar 2020 22:43:30 -0800 (PST)
MIME-Version: 1.0
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
In-Reply-To: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 23:43:14 -0700
Message-ID: <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 29, 2020 at 6:02 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org=
> wrote:
>
> Hi there,
>
> Booting a Linux Mint :
>
> (initramfs) uname -r
>
> 5.3.0-26-generic
>
> (initramfs) mount -t btrfs -o subvol=3D@,noatime /dev/sdb1 /root
>
> BTRFS info (device sdb1): disk space caching is enabled
>
> BTRFS info (device sdb1): has skinny extents
>
> BTRFS error (device sdb1): parent transid verify failed on 8176123904
> wanted 183574 found 183573
>
> BTRFS warning (device sdb1): failed to read root (objectid=3D7): -5
>
> BTRFS error (device sdb1): open_ctree failed
>
> mount: mounting /dev/sdb1 on /root failed: Invalid argument

The transids are close so it might work to try -o usebackuproot. If
not what do you get for:

btrfs insp dump-t -b 8176123904 /dev/

btrfs-find-root /dev/

btrfs check /dev/

btrfs check -b /dev/


I'm not sure about repair yet.

--=20
Chris Murphy
