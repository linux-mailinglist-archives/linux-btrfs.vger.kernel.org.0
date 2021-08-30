Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5833FB464
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhH3LMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhH3LMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 07:12:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC1C061575;
        Mon, 30 Aug 2021 04:11:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b4so5553149qtx.0;
        Mon, 30 Aug 2021 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Jorg+zRTW/4Qd8VQ2xAuCFDLUayV7AucKvzcuBld7o4=;
        b=KXJox4IZHUj0rrOIRQgsOD2QvEVAzWrYFAPSBhzwBISA34SnAuzxvfgTvG7rH8rM1/
         glxb4PnTJFhvPgU41ggcwKxgriSqTdPyzAhVXsaqyiloSTj0T4PMQ1mCgeqANQwvDE4o
         ju60ZFP2nTL9f0tBc+HmLAfsLshmo6KTMSrmRbZqW+EqHY2gD9jdONxO2/7+QuVgSeHG
         wzjXQ0JiMi/f1QInPdVw549F3cl4CHbiiD5u2E4KQ+7qnVrhascZ8Hxyu6kePcmmaFIb
         sByLI9gZQd8sGG5uRyG7YmTxKevBET3ss+UYP3t3PKxZAVq5RBKAX6ghK5LTJHsN6EdJ
         FqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Jorg+zRTW/4Qd8VQ2xAuCFDLUayV7AucKvzcuBld7o4=;
        b=HH/LRGVQWHDrMpIe9b12J4YWykR/2X3sFY42f0jVly4eBr8YtwWm93QS2VTRe6ZDvi
         2756yK9Qww78xbIk9EQEu+7Gbc9+Do133TORFrjL/u4xmWwuBf2X/VR88deMPbVLVpZ1
         aGMRR/BL8C1RDf0IkfhLt1dY6EsyemddvqnJMDum7cBqXWRifehtPf59aLCUN+uubBJB
         c7p1e7y0yTSrxKtAhXa9/nYBAJeGQ7ItDhpdUaa86ZInt5R05NDURN5H9LgrY0i/dy6U
         rpBHe5UNzkb2tgWbTii7TgyTrhI9wSjUXKMC8e0xOeiXNMXPKYIJbTcxZRaA/OoPM2/z
         9HVg==
X-Gm-Message-State: AOAM531a3O+MmJ3V2XSJJIPYlKqYTSHgnfW/RYFdY34Lm36Ci9hplhA1
        qXQ4ZchezM6/5CCPPweNSmUdY4hNIyHJyqyqcVnhVW5x
X-Google-Smtp-Source: ABdhPJzJMP0DofRAMtBJhxXUicmGWlYTBz+zDyBX1dRMRz7ojBa79gaajnnAJDutdUKw0LDkz7GQyM2Oq5K71319pJ4=
X-Received: by 2002:ac8:424c:: with SMTP id r12mr20257934qtm.183.1630321900982;
 Mon, 30 Aug 2021 04:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210819131456.304721-1-nborisov@suse.com> <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
 <b49f409f-e5cc-6d13-ef6a-2ab25f95d19e@suse.com> <CAL3q7H7WyC9LQXJYYe9DCTPPiL-Q1P_gyNGptEBMH=2br5dE-g@mail.gmail.com>
 <9f83250b-db93-bdf8-5288-0259afdf725b@suse.com>
In-Reply-To: <9f83250b-db93-bdf8-5288-0259afdf725b@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 12:11:30 +0100
Message-ID: <CAL3q7H526ckNLV=+S-mv0tbBJNnL3q=m2cTP04feSVPGzfcSrw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 12:08 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 30.08.21 =D0=B3. 13:56, Filipe Manana wrote:
> > On Mon, Aug 30, 2021 at 8:18 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
> >>
> >>
> >>
> >> <snip>
> >>> Finally, this would also be a good opportunity to test regular rename=
s
> >>> with subvolumes too, as we had bugs and regressions in the past like
> >>> in commit 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
> >>> root when checking for hash collision
> >>> "), and never got any test cases for them.
> >>
> >> What specific tests do you have in mind? Ordinary renames of files
> >> within a subvolume are already tested by merit of generic geneirc/02[3=
45].
> >
> > So besides the case mentioned in that patch's changelog (renaming a
> > subvolume), checking that we can't rename an inode across subvolumes.
> > Something like checking that:
> >
> > rename /mnt/subvol1/file /mnt/subvol2/file
> >
> > fails with -EXDEV.
>
> But this is already checked by merit of using this line:
>
> _rename_tests_source_dest $SCRATCH_MNT/subvol1/src
> $SCRATCH_MNT/subvol2/dst "cross-subvol" "-x"
>
>
> it tests multiple combinations of regular/symbolic/directory/dev/null
> pairs. I.e :
>
> cross-subvol regu/regu -> Invalid cross-device link
>
>
>
> So this is already covered I'd say. Or you mean to test those
> combinations even without rename exchange, which would boil down to
> calling _rename_tests_source_dest without the -x flag.

Yes, without "-x" (that's what I meant by "regular renames").

>
> >
> > Thanks.
> >
> >
> >>
> >> The test in the patch you cited is basically renaming a subvolume with=
in
> >> the same subvolume, that's easy enough.
> >>
> >> <snip>
> >
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
