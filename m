Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA24AFF5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 22:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiBIVmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 16:42:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBIVmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 16:42:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6EC0DE7EB
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 13:42:16 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y6so9934330ybc.5
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBbgDzeKJ+eKFlIghxvjCXbbo22+zDmtwjSXUMymGkA=;
        b=qDzCT5Fwjd7Qji168tBWZR38zcFAWnjrGzKSxoYLoG7FOa73qNwO0+YaFWaZmosVAv
         A5P94/8fihBFdZn+E+/i+H6SE7vrxnPu5B851GZyNxEq12G4A0IvYDExefzrVY0GQk1E
         AEXwTrX2FRspbkUvo2RIzFnvupFMhge6G2QudcUWTMOvzeQy3rean07W0vfnVABdOQ/H
         Elb8OL02kyfoX35qIhxYQ03BJMDnUZ7X8RMu+dQ1QYChsLhXxWz01Mh9gVMvkgBIBUXr
         XvzpZiKmbs3rjubXfYBgPV2PM5/yMUDd/wkslZgpBec7PamM7CmsF4FEBKlo0abBgUWw
         XtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBbgDzeKJ+eKFlIghxvjCXbbo22+zDmtwjSXUMymGkA=;
        b=N6gXhxqd+06O8vrXkNekKtS7GtGTpLKk9or3x9G2Q9Efv6vSMzoeL9UwqCctNZ5E3K
         TDzsKhSEFYi7JuHwYIHFne0iC4Xaxq5BATm4jbz+ni1ogPZV6VO1bWY7ne1KUj706dGa
         5UP0ui5hyx8sWatG9L1ocBrTPLHE4GGIZ4WPM7mMglGRHxROgQO4DN+fzLS0oB1izNN4
         YUEsdD08scE9pjRR3MhrTPYLCMmIqr7JSu8k8JCDCHAZN7QP3STwOkWNwPL2kyCcX8wn
         OEV5TOYIoW3pi62ArYXnXPmI1itCb6sTPjgMQNkAkdGrldUHWQ9WmMwQP4Ve3mhKM6ot
         zJpg==
X-Gm-Message-State: AOAM532r/9uVPBGI/f58GCpA8jaLlBcqFAI15ggu8MfPWSNj3adJWXGA
        Es6xw6sUq9lNDS0gKm7YYJylNjDoIRJC7lDLR973rjLPS4mzGQ==
X-Google-Smtp-Source: ABdhPJxlfr+irjqVBfWog618bl/fGfjfD8ya2dVVaMAXDTRviXiPyra2iDHjn1kA2Bpvr0AwxkenT+XOpYDDIabv4lo=
X-Received: by 2002:a25:e0c7:: with SMTP id x190mr3896307ybg.642.1644442935932;
 Wed, 09 Feb 2022 13:42:15 -0800 (PST)
MIME-Version: 1.0
References: <bd60df7210fdf3ed1dae48a8cb9908a5@vybihal.cz>
In-Reply-To: <bd60df7210fdf3ed1dae48a8cb9908a5@vybihal.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 9 Feb 2022 14:42:00 -0700
Message-ID: <CAJCQCtRs0YgBbzF5qUAqpFZra7wbEjMzeu6zZUo4zNNPxA+YcA@mail.gmail.com>
Subject: Re: failed to repair damaged filesystem, aborting | kernel BUG at fs/btrfs/extent-tree.c:4955!
To:     =?UTF-8?Q?Josef_Vyb=C3=ADhal?= <josef@vybihal.cz>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 4, 2022 at 6:53 AM Josef Vyb=C3=ADhal <josef@vybihal.cz> wrote:
>
> Hello, btrfs failed me big time today. I am using archlinux, linux 5.16.
> My laptop started strangely lagging. I discovered, all of the sudden,
> btrfs was mounted ro. I rebooted and then the system acted very weird. I
> have discovered it was because ANY write operation just hangs
> indefinitely. For example 'touch test' just hangs. removing snapshot
> hangs. I should probably mention btrfs is inside of luks.
> I have cloned the disk and booted ubuntu live from USB and started
> poking around the clone.
>
> I uploaded dmesg and whole result of btrfs check here:
> https://up.jvi.cz/0X.txt

Attached dmesg is 5.13 kernel. Are you using autodefrag mount option
with this file system? If so, I suggest disabling it with 5.16 series
until some bugs get fixed up.


> Is there something I can do to fix it? Whom to send the image with
> metadata? It has 3+ GB.

I'd say if you can reproduce with current stable or mainline kernel,
it's worth going to the trouble. Most of the development work is
predicated on the most recent kernels, either the problem is already
fixed in a newer kernel, or if it's still a bug then it needs to be
fixed in a current kernel before it would get backported. While you
can run into new bugs (like autodefrag issues in 5.16 series), most
everyone on the list and in #btrfs will know about the current issues,
whereas older issues in older kernels, it's a coin toss if someone
remembers or has time to look it up.


>
> Or should I start reinstalling and recovering from backup?

That's surely the fastest option.


--=20
Chris Murphy
