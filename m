Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5592629E5ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgJ2IMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgJ2IMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 04:12:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432AAC0613D2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 01:11:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r7so1349748qkf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsHN7xDaF34hd9JVoD5sLJUTvtoRrqwlv+3HcrHxXJQ=;
        b=UiPG9CMtlKJmVyiTI4sg3AouEtctR+LDrq+rQfLN6cHjS/5dGQn4v9LeR7FfKQgIjl
         4YYkMG7rRaa1N56URQOp9FJvmTIMitiX6ERhEcdjHDpthpGvAUluxTta5kYJD1QG3q4X
         um26y8TKGQ/rVqg4nri7MWGOq0q7iMQ9FnvTGAPBjHTRV3j0vjYm5XdOvXvz33cbNqvk
         lb3aEcUZjYFj45FVI8UPpWyX7FkRzT+yVgk+T6xR/13VSq3Fn+Oyn6JPnTiWiANiWaXf
         4rNbPfHIVSHLv6zOOTmvm7fU6xaxtlLbcUgs0/Zh30Aell2lWkZquRGrjYsRXYQV7UBD
         FI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsHN7xDaF34hd9JVoD5sLJUTvtoRrqwlv+3HcrHxXJQ=;
        b=aDrgRwMO7MjHUcGEkNvcD1y+qVLPyBhaRZ3xRbNXAbociAxp+0YLB+0QsgwksmbE2p
         suBlnxiNoAfeWzTGIqbls/xOOIkUwQSuQHVVmTEqFF9lT4/WdMODSPy7ZRHTU2oHNYsk
         cyCKcr3i6BOtW6ao15gEyEtUrF6EzqfUjQENtd1/DaiayeNyqX6rIj2/HXRJU9nONQsv
         WiJq1KHZS0R6ZK+tpHZnUWrJVspze8qTFQih+jM6mU7N2RLpEHuv2Grq6luEkvfPC83d
         oH02zV2Ti5ogP3UDK+UnrUTjJ7xbL9oPFe8S9LgtLaKfDBvEx1NvXoTwJdS7EqUwCF/+
         2Qqw==
X-Gm-Message-State: AOAM5339yTmpFtYJFau4oCrjH2vfBKd3IBISfb4nwctqOy+TITgoeDbh
        geaqUY2Vb9nRZMePoiqC//bMUj05k6fVaw5U3N+lK2T7
X-Google-Smtp-Source: ABdhPJz0m6RmDlIu/jskB0+tM8ZkSx0w4gAI0cu8JkROuSSMhZ3yXh4SShUKaBOvn/eMezzhk2np4y63NWhQIF9YTpw=
X-Received: by 2002:a37:4d13:: with SMTP id a19mr2456140qkb.159.1603959117391;
 Thu, 29 Oct 2020 01:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
 <CAJCQCtQtVvOZx9Q-YsrEN1VW_zn_1ipWCahjMAR8hx_pr6b00g@mail.gmail.com>
In-Reply-To: <CAJCQCtQtVvOZx9Q-YsrEN1VW_zn_1ipWCahjMAR8hx_pr6b00g@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 29 Oct 2020 09:11:46 +0100
Message-ID: <CAA85sZsCj2jXsZ9UHSBOkKKhSWVZ87AdyN502TsAnD7bC8cd8Q@mail.gmail.com>
Subject: Re: questions about qemu io_uring/dio
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020 at 5:34 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Oct 28, 2020 at 4:17 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > Hi,
> >
> > From what i understand, DIO is supposed to be supported...
> >
> > But when i switched qemu to use io_uring it seems like the filesystems
> > on the VM:s get silently corrupted... (they also run btrfs, and it's
> > thus detected)
> >
> > The system is mounted as nodatacow, I can't set +C with chattr so I
> > assume that the images are actually noncow
> >
> > Any ideas?
>
> Could be related.
> https://bugzilla.kernel.org/show_bug.cgi?id=208875
>
> I'm not sure if the fix made it into 5.9 but pretty sure it's in 5.10
> but just haven't yet had a chance to test it.

Yeah, i found that bit when googling actually, it will be in 5.10 apparently

But the subvolume mismatch vs root volume is another thing - you can't switch
compression or cow settings and imho, this should be in dmesg as a warning

Started to look at it but i don't really know enough =)

> --
> Chris Murphy
