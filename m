Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56431B06DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTKt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 06:49:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A7C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 03:49:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so7545432lfc.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Apr 2020 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLvCn1+1RUk9SX+K4vp8xr7PEFw76ACd67lL0lAHJWg=;
        b=tek5226jrNA9A3pnNHqn88ilDykCJVbxOesMbLjGn59Hh1Z6w9cWL4YG2YEbPDTjra
         oIkf/Do4T8IzTnWwCjVD14ZRz6C8ENWQ0Ru39C1MWNvV+EESouLcdKE22PFDEcyO8HWe
         ntpJrWRN2kT5OKpNmXQEB+a0AZd/R6fjefz87ShvtiNOMQStu+7acxBb4DZ4iSJAudb2
         W0JGXqiT27XeeBRGlFcVenMIJGf1/Tylw4Q+aLnJ6YwKTT/rdg6gSiPySojqP1Xn0bj4
         RylUxPkWTdBY/EnBsPHLwbTUphyIAtLWCaorD5aTe+ZyJtQq0PYcVrLGogSTUIzL7G/4
         ZULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLvCn1+1RUk9SX+K4vp8xr7PEFw76ACd67lL0lAHJWg=;
        b=VbsMxH9kv5bHRMOUdSaHD6an0FIDv2b2a78EItnUzbhS8f+2GQcdNVfN1wrkiq1IJW
         kcnpIYy6kkW3Qsx+C2Qud8/vcNQiXYAfTwEDBqhcivHcsvNwb3fkvsD9THxDUTsPxAfZ
         Cw/Rm1syacVtW1MoyFcUtmnSNrBQgot4ku2QVyrNkflGFzLLTo2l0ihiohHByPsjvY57
         f/ZugfQPKabAPRiiOesYuR1Kj94HgOexvNfPhyXhpaYrqhkIEp3eD+fKTMwdaLvg2Ul7
         AzdfS36YcotJMvFPulratFVLIEMm9lONCzPjwJc1AClNxypKRgO0GnV87Ap846bHaEle
         K0xw==
X-Gm-Message-State: AGi0Pua6OrewVD3KScTqwGVLNnisR0EMxTEiovaymyFLZIUaQbxqRhlV
        0hn6qJhnVsWPImFX/XYIa7EJyO0ZhsflhFj8/NQts2hm
X-Google-Smtp-Source: APiQypKLN1krfREQhpSUaaTZSIhXJUbCoWqqDhKEBQbMLPQq/tpt6LOd1SjyEzDAXnPbxB6IWy/lAZctZM8X2QlRypk=
X-Received: by 2002:a19:c356:: with SMTP id t83mr10164141lff.186.1587379793790;
 Mon, 20 Apr 2020 03:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAH-droy1qkV0mfWY5ojRVej7fGnznmSiN9+sPoxvPF2Oy5JSLA@mail.gmail.com>
 <20200420153449.3bd2d339@natsu>
In-Reply-To: <20200420153449.3bd2d339@natsu>
From:   Nick Gilmour <nickeforos@gmail.com>
Date:   Mon, 20 Apr 2020 12:49:17 +0200
Message-ID: <CAH-droxyv5Fg0Wj-7vWOrMuXx5Xpt=yEmOYGmsZvZsPT5vYA5w@mail.gmail.com>
Subject: Re: ERROR: Could not destroy subvolume/snapshot: Directory not empty
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks!

I did:
# rm -rf /tlsv5/@.broken.20200319a
and it took less than 1 minute to finish.

Regards,
Nick

On Mon, Apr 20, 2020 at 12:34 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Mon, 20 Apr 2020 12:05:58 +0200
> Nick Gilmour <nickeforos@gmail.com> wrote:
>
> > # btrfs subvolume delete /tlsv5/@.broken.20190830a
> >
> > Delete subvolume (no-commit): '/tlsv5/@.broken.20190830a'
> > ERROR: Could not destroy subvolume/snapshot: Directory not empty
>
> It appears like it contains a few other subvolumes:
>
> > ID 324 gen 54829 top level 257 path
> > <FS_TREE>/@.broken.20190830a/var/lib/portables
> > ID 351 gen 268851 top level 257 path
> > <FS_TREE>/@.broken.20190830a/var/lib/docker/btrfs/subvolumes/641bd5ec86e1c5e1f2d504a0656da736bafb858551067aca7f1b84c24c1e7d33
> > ...
>
> Even though it doesn't really "contain" them for the purposes of snapshotting,
> for deletion you first have to remove all the nested ones.
>
> I believe in recent enough kernels the regular "rmdir" call is able to remove
> empty subvolumes, so doing an "rm -rf" on the subvolume you want to remove
> will take care of all the nested ones (if any). Or if there's just a couple,
> then just remove them manually first.
>
> --
> With respect,
> Roman
