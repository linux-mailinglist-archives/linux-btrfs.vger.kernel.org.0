Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95D35B027
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhDJTns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDJTnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 15:43:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D6C06138A
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 12:43:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so6450687wmy.5
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbNXY8Pk/DKf/nAVjWpfCyJHb/drxxFt3BLs/RciLmE=;
        b=uFDdnps6xkxSF1Z9788TAD2ab8huZVrD/mSNs5CUBAFRdgIslYl4wDSaqmeOCuJDFk
         2RW2/fY91dxuawJq28oohniHKxImRVBcwVPgH1cBzpYqGZvKw3hRtY2McpAnKdXHOEm7
         1odwiCLeiQsJPavguWFsNStbfbycvynhCxh/iPTRXH/yNyod5dWIrM0d7JdYt0rsnjYE
         GUb1BvGyStNVtr6YzMtgLU1RchagHz5y2W3cyuXBOBYyDVtDfBgozxTPsLHSIIdqLRjQ
         FWcaqJJ7vQmh7uCPJqaCS8JCaOOJIj3jBYVFT9xfks+W1SgyVhjbkbJK5XkB+o0iyAlL
         4L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbNXY8Pk/DKf/nAVjWpfCyJHb/drxxFt3BLs/RciLmE=;
        b=fWsf2uqxn3goxIOR2j+EbZ/cTMCr8Crr/samhW3Bz4dL5rzaCjw+owKE0gNCr5WqF7
         uihTS0E1+5BMsJgrrKV6hrGVEn024PPXNx7c8iuyPjClNsyIlMu0SE/O9HGet1R6Cyea
         I44SB2o2+mBVj5C+1aZ5ZU3ysDPM9xU2FcEW/RPptQQ9Jof4YUZ9nvC456VDvutlgPWg
         SX/hiMj+FDwlznMOxW+bmJfCA7t/0ovWBlfhGzWYYHYDFrnOPUsp7EcrWqTaNsKv0bGF
         C0hTAi/MPlgzVWI1AgTm/tX2AxGGzDSKGG4UivSjVDLLZ89keh7APzAZ7sW+ClBhWomr
         BY3A==
X-Gm-Message-State: AOAM533MR9ml5e4f4VEbgIOeV5NGM8vz+qSpABx0STJTIJU44kX4ba9q
        6jWqA5okTjz2robdy/tvwruPPgvbDkoPFk38Sq0ynQ==
X-Google-Smtp-Source: ABdhPJzB4HPQRbKMyUbW0WCASVq55PwvGDx1IkwFeNKJtXt+IbU8p0o+lY3LFY5QbskkNDZS/Bz8rFHGZhGJZpeshmc=
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr19384530wmj.128.1618083811376;
 Sat, 10 Apr 2021 12:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
 <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
 <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com>
 <CAOQ4uxhU2KX=jKKL5EZ102z_+6KyVKAOoAzSp2K8i0PMGJUg4A@mail.gmail.com>
 <CAJCQCtTHepsUHjCUAwawC6r6txAZ=XypE5rJOizqxMx9zuR4AA@mail.gmail.com> <CAJCQCtQshgFBvUF2+DLm0=iHhiONu-QCRnB1uNv2dLigT+WfZg@mail.gmail.com>
In-Reply-To: <CAJCQCtQshgFBvUF2+DLm0=iHhiONu-QCRnB1uNv2dLigT+WfZg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 10 Apr 2021 13:43:15 -0600
Message-ID: <CAJCQCtTg5Cz_GdSTCX-rZDmoB-PDGr2iV=quPWSofbL-Xixapw@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 1:42 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Apr 10, 2021 at 1:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > $ sudo mount -o remount,userxattr /home
> > mount: /home: mount point not mounted or bad option.
> >
> > [   92.573364] BTRFS error (device sda6): unrecognized mount option 'userxattr'
> >
>
> [   63.320831] BTRFS error (device sda6): unrecognized mount option 'user_xattr'
>
> And if I try it with rootflags at boot, boot fails due to mount
> failure due to unrecognized mount option.

These are all with kernel 5.12-rc6


-- 
Chris Murphy
