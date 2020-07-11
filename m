Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA221C459
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGKNGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgGKNGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 09:06:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118BAC08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 06:06:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j4so8537423wrp.10
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9Pq6mQK2apl1eA3e0cHXSBEkWi8DhwW86IDdfsOPUM=;
        b=JfT9R+5oGWojrsqMVQxh+01pm1bhtpXhJkYagEyQDkLwAXil3JoB5Zl+CoLBWypQSj
         e/Ss2uZZkdU82pgcYAtZNMk7l+NyFwUYUTS38T+qA+XuhKL2FWRor5DrY6KTBVlMxR0y
         aLl/LrejBr8sOQcPQG2rYAjVrrXlp4doDfb9pZ0YrZ4QJYxHNgsqf2LTMdARO799bWH6
         Wc02tjQgPmMiG8y8xJlrA27TXdwwBJUv/KBlmvx/B9RaPg7dlIs/2SzhYDgt4sAFMdc3
         BdNUoWvUM56idX0rwFjml0twhj+agxWfcI+RBQYViaptSsHDR/2fglJJS1v2mHJsD52T
         0wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9Pq6mQK2apl1eA3e0cHXSBEkWi8DhwW86IDdfsOPUM=;
        b=M1Q0yDBrEk79zVFtoWjc8vgVmGRDTvZA0xDbCGM7r5G4WqBL/abzwhL2cN+hlgVR9q
         xO0fYR6hyjtJjMYrgHXrz+eSUpZy/fTtT4EadLm2AD9f4FUVpHObsq35veAJw5bl/6DK
         CvU0/yclGjYfKivtk9sNUw1cGDdAPTEZdJvP77hyqLiB03U5i5xKcPpBoATmhjB7KezN
         43geP2ySzxLsNwGc9g8QR4SUNOKyNYlOYe6NR8rRynw0qHyBcalkKQGaADUM5p13U6bc
         qFO28GY2G/sTSdEtcs2bJY1G/WZL1HxqN54Qag1pgJ43riyfsJ0fPYjq7FE8RS+ygOlx
         eg7g==
X-Gm-Message-State: AOAM531ld++8j/hl8xKq9VNpjwXJ5A7n/pPu508S41bTZFJoc6kq9/Qt
        QDN5+Qe9m4faliB2m55++4UwrT1k/+Jk7yhGoi9OdA==
X-Google-Smtp-Source: ABdhPJydQTunpWZFoao0TURnx8a6nqz2xewNMquMyKLk25Z5RVLoB3qbm43zQwIdJhtzFhk8bOAduBT7QfYYVau6XY8=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr70116629wrt.236.1594472766577;
 Sat, 11 Jul 2020 06:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
 <7f9a8467-6b03-6699-f124-2833fffef4ab@gmail.com>
In-Reply-To: <7f9a8467-6b03-6699-f124-2833fffef4ab@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 11 Jul 2020 07:05:50 -0600
Message-ID: <CAJCQCtSW5BVyY8jCnof17C01cV3w1bNFgrUkbZ4reQmrAC_zyQ@mail.gmail.com>
Subject: Re: raid0 and different sized devices
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 11, 2020 at 12:28 AM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 11.07.2020 04:37, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Summary:
> >
> > df claims this volume is full, which is how it actually behaves. Rsync
> > fails with an out of space message. But 'btrfs fi us' reports
> > seemingly misleading/incorrect information:
> >
> >     Free (estimated):          12.64GiB    (min: 6.33GiB)
> >
> > If Btrfs can't do single device raid0, and it seems it can't, then
> > this free space reporting seems wrong twice. (Both values.)
> >
>
> This space can be used with single or dup profiles so it is actually
> correct (second number being for dup). It would of course be nice to get
> extended output "how much space for each profile", but as "estimation of
> theoretical free space" it is absolutely correct.
>
> Of course I do not know whether it is correct by design or by coincidence=
 :)

It's correct, in any case, in the context of conversion. The
difficulty is that it's not correct when it comes to strictly data
with the current profile.


--=20
Chris Murphy
