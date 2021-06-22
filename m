Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE93AFB64
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 05:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFVD2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 23:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFVD2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 23:28:41 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423EC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 20:26:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i68so36007683qke.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdtM9blo/tEGQT5+zNJ8sjUuvpzwBhWJnSDrRc3rQvg=;
        b=Lz9334n8kJeDOpmcsZoHjt84I3A4eQbiJ3V6KIgBeuhJAXDDGX3j/2IShK+V4kHvbf
         tKwFsjn+/6hlMGVyOvcozco31RyYNXUW01abhQOQj6oIg52AynLPYFdLxM0Bm8cbNK+V
         YbkQWwx1XvnJjx9SoeQOTSFf3x2Of0rFCU106hyDz75LitZqF2Y98Qyp4Ds7AS7R6usS
         LTI81NQ3Rb9m5tySsicgKFydyLl3zbekty7T9utfHqB0q21q1fWEPngcpPHUmFG8R7A4
         8+jjKbN7EoEWmG7PJtzR4aZPV935y3VgtG7H/+bdu6olV2gM5VoVw4o0Zjo7DYWQhco6
         dnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdtM9blo/tEGQT5+zNJ8sjUuvpzwBhWJnSDrRc3rQvg=;
        b=LmQbYC+U91jbHUpDX4rIcjnlr8T6/zdv250wW/CZpMW47lQPu6jA/SrJILeAu4walM
         m2azIUNY0iMoDq/a6IlxtdUmMoQLFPA5feSG2RyGwd9ywMlP6MfmNM9SNhITA61BZfCU
         g90jBEypVB+rqSINrE02G4TnIRtJzSp5mePnWHQFiyB3ZKsGA7clDeWcz+qKi5AR2nq8
         LfsnOPon9fvxRcozPxleO2+KebBqTCNO8wA9AdHqXiRHJiRdbg9O3CDCmPhfyON3GfR3
         6JO0NOGVXmIgLGPmrlDaqzy1CiDBdp4kSYQi4tqsSQLoTMJcVYqnKkS9YH6D+PECdqOr
         9djw==
X-Gm-Message-State: AOAM533ZO/334uZcbJl3IEvVg/b9YhefNS6YehvzkIoK1fJ4pcsyZuJ5
        Tc8BsxemSeCopZEmZKlK4L4AQLfkoOO1j66nUWY=
X-Google-Smtp-Source: ABdhPJx6w7BRPoHnH9QA09h8sSrjrcYe4tBNj/8+yCoLIpzRoAIoyIVJ9uqOBsSPmr1xvUutGjocvq1F0dfD+ylD39k=
X-Received: by 2002:a25:1f02:: with SMTP id f2mr910297ybf.25.1624332384190;
 Mon, 21 Jun 2021 20:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
 <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com>
 <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com> <CAJCQCtQUF9Sp=f3rrd5MMe4tLkDoh8GYFXSRTECxKqtRFwgUzw@mail.gmail.com>
In-Reply-To: <CAJCQCtQUF9Sp=f3rrd5MMe4tLkDoh8GYFXSRTECxKqtRFwgUzw@mail.gmail.com>
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Mon, 21 Jun 2021 22:26:13 -0500
Message-ID: <CAEEhgEvYwTcTQJfT88QZSzgwtVm=TOySsP9yzbJ2HVeU0OzLEA@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I couldn't figure out how to salvage the filesystem, so I wiped it. Oh well.


On Sun, Jun 20, 2021 at 5:53 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Jun 20, 2021 at 3:31 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
> >
> > >Was bcache in write back or write through mode?
> > Writeback.
>
> Ok that's bad in this configuration because it means all the writes go
> to the SSD and could be there for minutes, hours, days, or longer.
> That means it's even possible the current supers are only on the SSDs,
> as well as other critical btrfs metadata.
>
> My best guess now is to assume one of the drives is bad and spewing
> garbage or zeros. And assemble the array degraded with just one SSD
> drive, and see if you can mount. If not, then it's the other SSD you
> need to assemble degraded. There's a way to set a drive manually as
> faulty so it won't assemble; I also thought of using sysfs but on my
> own system, /sys/block/nvme0n1/device/delete does not exist like it
> does for SATA SSDs.
>
> Next you have to wrestle with this dilemma. If you pick the bad SSD,
> you don't want bcache flushing anything from it to your HDDs or it'll
> just corrupt them, right? if you pick the good SSD, you actually do
> want bcache to flush it all to the drives, so they're in a good state
> and you can optionally decouple the SSD entirely so that you're left
> with just the individual drives again.
>
> I think you might want to use 'blockdev --setro' on all the block
> devices, SSD and HDD, to prevent any changes. You might get some
> complaints from bcache if it can't write to HDDs or even to the SSDs,
> so that might look like you've picked the bad SSD. But the real test
> is if you can mount the btrfs. Try that with 'mount -o
> ro,nologreplay,usebackuproot' and if you can at least get that far and
> do some basic navigation, that's probably the good SSD. If you still
> get mount failure, it's probably the bad one.
>
> If you get a successful ro mount, I'd take advantage of it and backup
> anything important. Just get it out now. And then you can try it all
> again with everything read write; but with the bad SSD still disabled
> and md array assemble degraded with the good SSD; and see if you can
> mount read-write again. You need to be read write at the block device
> layer to get bcache to flush SSD state to the drives, which I think is
> done by setting the mode to writethrough and then waiting until
> bcache/state is clean. HDDs need to be writable but btrfs doesn't need
> to be mounted for this.
>
> The other possibility is that there some bad data on both SSDs, in
> which case it fails and chances are the btrfs is toast.
>
>
> --
> Chris Murphy
