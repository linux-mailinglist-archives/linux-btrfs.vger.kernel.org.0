Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1231B2FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Feb 2021 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBNWMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 17:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNWMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 17:12:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD3C0613D6
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 14:11:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o15so4496636wmq.5
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTpvfseGszp0+sSADygYtb/qArMHgyk30boXn8O+HyQ=;
        b=jdcoxDvtijEB0mE3XLMNnnHyrOAk/7gcs53XPePyTS3Us4yBMqG2bzy9oBasvEU1j2
         DKhzMr5xbqA4vFtMH/Zt7F1dYKRzcge2XY8cRYTMAXZDejO6zKngu6ZRjaDwFYWRDpka
         EcpjmrJyBj0VZSIa/UfCAnSaPXwLWEfuchYG0k41KASRdtdkR0FDDaVV5M7pBTmr1BPZ
         d2Q0tCuxGKd60vpEbJadz1lxRuZLGYGSfhPWJBP12O3RYwN6lySgnHFnRyWgoFRzv2/6
         K5Z+obV2gUvIvn8G8VOAQvD56HfAVJmHXoVwNgZ72m4tZ6iWBeQ4Exb6Qfx8Ffj+bGf+
         Ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTpvfseGszp0+sSADygYtb/qArMHgyk30boXn8O+HyQ=;
        b=FzwVf79hOAmAVPmR9tldp+FKEGLhJ0w/DFD343Pk7f+sYUzm0pXf95Z0qeF5cGhsxw
         ma2TMT3eyGlVC+LIrqInMTSWgnkhk92A8OivjT5b30INi6NvSzNdHI5lRP/S1KGrB64g
         bqirn22RCi6BYQzNvJIJ2BDhC309pytgnspw27m4tT898OeUIEPy25/nOCjOupaCSszX
         MgebAkYI3LFkV2s/KOCj+3Ag1ymAV84OQPkwIBAgIsBFjkpCBiWeZMHRzSXe3RYjnGXx
         PYdWmmX4z5Kf1g1UCtmaT1bq9ADIDOIc4O5+vl216/puWnqw5CUOJgJCkDnTAasIERkH
         f1GA==
X-Gm-Message-State: AOAM531y4j1w2gYhGOZWzdPeg1DYNqiSq+zZUP1nu7nnAMwTQJC9/xyf
        4CAkPP14iNArArnOBA6JUJL056zY4Lngoi40wAUyhQ==
X-Google-Smtp-Source: ABdhPJwgxnL/lp/TUVAWUum9R6wmsVmniHVTRVjavsZYpJ7FKElUcwo98V4T/WJEs+CBfu5dBn899TXrE+8r+7UOkO4=
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr11757205wma.124.1613340712921;
 Sun, 14 Feb 2021 14:11:52 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
In-Reply-To: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 14 Feb 2021 15:11:37 -0700
Message-ID: <CAJCQCtRhxUx3R5_VgWGN0hvpJ=ET6j4Wr73Ph0jKWcCizA=CgQ@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 14, 2021 at 1:29 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> Hey all,
>
> So one of my main computers recently had a disk controller failure
> that caused my machine to freeze. After rebooting, Btrfs refuses to
> mount. I tried to do a mount and the following errors show up in the
> journal:
>
> > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
> > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
> > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>
> I've tried to do -o recovery,ro mount and get the same issue. I can't
> seem to find any reasonably good information on how to do recovery in
> this scenario, even to just recover enough to copy data off.
>
> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
> using btrfs-progs v5.10.

Oh and also that block:

btrfs insp dump-t -b 796082176 /dev/sda3


-- 
Chris Murphy
