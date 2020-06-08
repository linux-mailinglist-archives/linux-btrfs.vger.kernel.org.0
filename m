Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A511F111C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFHBkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 21:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHBkM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Jun 2020 21:40:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB0C08C5C3
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 18:40:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so13743754wme.3
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jun 2020 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9KU/jv51vUEaDS06ZrNDtLPaCUGQ15KA+0hOiq3UC3E=;
        b=B4Txc8hCD0gywAr74eJHXjTvUabT9tyt4nGf13JREnPSDnR1FgB8GcrEqkaMWqg9u7
         hkmGSpW7Oc/ePjTL8GlaR2k7Avv+lEuLDXesmpWbPBo81zjzyXr11LeA7/nFibcQ3/5T
         zZXZ1ZXhzJFtgTQt2upBPrsRwk798095QXsDpfwhUNoEQQqJqnjKR8+hFdIe/SpwLGDK
         1c6LszrM68XpTJV2x4ZrXBJA82c+hQ1hW25cBFhko5Na2+zr6TAoTVfi1YW5zRwNFToV
         t7zBYQ5VpRnpMoXZAxP+NlMs60nljl+JWwJxWDB1eW7rmMSQ21Dku+t0CL2TIJPartyK
         RP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9KU/jv51vUEaDS06ZrNDtLPaCUGQ15KA+0hOiq3UC3E=;
        b=sAr1JSKh2aPyy0af712RvXDxZjF/UafD7tPUFcWl96EU9D0DWN8FxBU0ZH5QI8FJ8z
         x4iYWzp/LPNhZQDaC8/um6LTt2RAGOm9P7TVfxKeec8mT4C919cUIFghjFY9NaVw55AV
         jXdFaJWQKbHtLUiLmQCmuS4q5jC0TXDEyCBKJPypyl3DlC1a3PB1w2Svz97XniXyKJeW
         ZAWiwS5hG8Za1Om6PqgFDKWBt2ZIUxawDUtZ4b2i/eiGMJ472nIrjF4BTGHaIzHF8qfp
         OGBHaMzcKf7qmN2VFQkSUAVaWJsS63DUQABtXj8lSXv8sPEWJcMEDvw11uFuCm+3xLdk
         +hQw==
X-Gm-Message-State: AOAM531urfpYqck4NXagWmywivCp63pybdVcRBsBr95Ik0/eUM6mDRKX
        n35xF+NFOHNpKWL41hklo8EhzmicLNzfmib3uCsyhYIc
X-Google-Smtp-Source: ABdhPJyfSZTEQdf9TH84r/4gwtzdZAjtq1KH7bvChSuwu2IOxaKWnk/kYcIWnW2FGs0apJw2eZAuoUKOxGkhUV1txqU=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr9240358wmc.116.1591580409296;
 Sun, 07 Jun 2020 18:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <YTXPR0101MB1902BC1A12C18F9670DA3EBFF9840@YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM>
 <alpine.DEB.2.22.395.2006071353410.13291@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.22.395.2006071353410.13291@trent.utfs.org>
From:   Walter Feddern <wfeddern@gmail.com>
Date:   Sun, 7 Jun 2020 21:39:57 -0400
Message-ID: <CANVx8XGRWeVmUMrc+Ki=UpGg9iWJzUF1P_5mCp1TgmpNqGybZA@mail.gmail.com>
Subject: Re: Help with repairing BTRFS system root volume
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Going with the suggestion from Christian (thanks Christian), I was
able to attach the 3 drives making up the system root volume to a
CentOS 7 system. From there I was able to mount the volume with no
issues, as RW. Looking at dmesg on that box shows no errors.

Is there something further I can run at this point to scan the
filesystem for problems? Or will it have automagickally fixed it when
I mounted it on this system?

On Sun, Jun 7, 2020 at 5:10 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Sun, 7 Jun 2020, Walter Feddern wrote:
> > I have a system that is running opensuse (42.3), that will now only mount its root file system in read only mode.
> > I know this is an old opensuse, which means old kernel and btrfs version, but it was required by a third party to run a specific software package.
> > This is a VMware virtual machine, which gives me the luxury of making a clone and performing repair attempts on the clone.
>
> This being a virtual system, did you attempt to attach the disk to a more
> recent Linux system, and see if it's able to mount/repair the file system?
>
> In there you could also setup networking to get more precise strack traces
> instead of OCR :)
>
> Good luck,
> C.
> --
> BOFH excuse #282:
>
> High altitude condensation from U.S.A.F prototype aircraft has contaminated the primary subnet mask. Turn off your computer for 9 days to avoid damaging it.
