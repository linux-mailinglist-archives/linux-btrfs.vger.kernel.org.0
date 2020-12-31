Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E942E8196
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgLaSUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLaSUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 13:20:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC271C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 10:19:29 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d189so22499439oig.11
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naH1+LXp7UqWG8a6oU2wWvyp2gFUCZKEJOQtmpJO7Pk=;
        b=U1FmvAO4F3oejPlJFTPWlseht8pVII3SFf1mP9hPhVcPRKd8XEZn101/9ZYRljqZ/Y
         ZubUDW8rlzdAE4zVqneONC1GH51jVteglTxjXZyqpDyd8zplvaFRltex3lqB7Z4Jad76
         cm4xp7LAHfE3p0BHWOjLJpxeHjC4jIjwyAZDau2HcdR4iud6IHYMVWaMS3DoO0dNDC0l
         bweTlp3C01HXGEKh5d7r6got3jccamBfaX9EZSrup8rxM3OSX9s5awluqhEbTmksU5h5
         S3LBG7W5UAaCgPutLolYBEaFmwyUBu5n0cdIo4BxTasT818H95l4kLvsOiWj4tb6z/zw
         63QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naH1+LXp7UqWG8a6oU2wWvyp2gFUCZKEJOQtmpJO7Pk=;
        b=IXGpgyyN7+ItTlAW0X3Ib8KPH3q0fY3G9TjsUYONVVRCOOUhsJ0PfmCjS9H+x17XgH
         gO5r3y0DBO4Y2kx83bBIW8kDGib6FjBX96xU8gcEYo5AkiSAJHAhz0YHkx+T4ucoSwml
         h8PnNGoS3E0GrSwXbeXfydH7dibT9G75kK0sRsWKY7RoU04rgpdFrjbZzM1Hfx/ghyQc
         /dr+pZS+k48ddXdUH5OkERmAXjrLoI773ML2esWoHBfRxLg6NbNnQs5hFRzbXOyyU0ts
         +HjfY/V0eqP+Fxsr2H1z/pnNCK6PT3tPCwWyABFEvBNZfg93SGRyh9sUTJaC2XLaFENY
         yVog==
X-Gm-Message-State: AOAM533QOCqIluGF+K7A9xte5ynB43UsZqSk7luidZDEIzs0GItTeNxY
        NUoYpQ1mvyYZrZBW9SUGJO0DrZbFPOrtdN1xEOo=
X-Google-Smtp-Source: ABdhPJxRNl4i1F3oV7H1nPtphXlT/11PmxlhfCTOsYBtwgvv0BgC8He9QUpBEfDMrgE5k1HW3DGEZHqJ4uLsILwW3js=
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr8813462oie.118.1609438769060;
 Thu, 31 Dec 2020 10:19:29 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se> <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com> <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
In-Reply-To: <20201231172812.GS31381@hungrycats.org>
From:   john terragon <jterragon@gmail.com>
Date:   Thu, 31 Dec 2020 19:19:18 +0100
Message-ID: <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 31, 2020 at 6:28 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:

>
> I think your confusion is that you are thinking of these as a tree.
> There is no tree, each subvol is an equal peer in the filesystem.
>
> "send -p A B" just walks over subvol A and B and sends a diff of the
> parts of B not in A.  You can pick any subvol with -p as long as it's
> read-only and present on the receiving side.  Obviously it's much more
> efficient if the two subvols have a lot of shared extents (e.g. because
> B and A were both snapshots made at different times of some other subvol
> C), but this is not required.

Can you really use ANY subvol to use with -p. Because if I

1) create a subvol X
2) create a subvol W with the exact same content of X (but created
independently)
3) do a RO snap X_RO of X
4) do a RO snap W_RO of W
5) send W_RO to the other FS
6) send -p W_RO X_RO to the other FS

I get this:

At subvol X_RO
At snapshot X_RO
ERROR: chown o257-1648413-0 failed: No such file or directory

any idea?
