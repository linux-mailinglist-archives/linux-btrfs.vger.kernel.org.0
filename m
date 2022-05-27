Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2948F535792
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiE0C3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 22:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiE0C3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 22:29:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADCE52B7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 19:29:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id 2so2239509ilg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu2mBh/8+QJbqWebT+3lLsGGXBu95OMNo2AiFq70Xac=;
        b=UOfYZjWaDzTb+PH0rqnOXP6d5qRiihdIDMG72CeVEtfpIII7bBEEMg+Qy+A7NmNRiC
         QHNvPleXrQiyX7g46ihaXea1dqBsdalV89U8mSoATJZP+h90I/l75LpFrVztFhHBr3ll
         dkc8rD5mpRxh1Ctuzw7Lyqr18yp34WjOmPRZPbkAt6bNX3WaRGA/rGosVhD+//s8AvGQ
         Ryy2Dl+V2TzKQvR8b3zLd149yS7NqQ0mN2DZ5UmGz8guGkUo8faAxBBpsclnuac5j5Rm
         YZJQ9DFHioOvT7Xtq2t/vjHTp+t0EJwAyDpxoWG8yA0xiQ/IHB7l+glKmk5m8aiE09Wz
         bFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu2mBh/8+QJbqWebT+3lLsGGXBu95OMNo2AiFq70Xac=;
        b=fClVPl3/4gUZdm8Bu+Eotehg0ohe7kExaQmOKLd9HBQ+GWBBh4YmZ09xTJm55ieLgI
         rwFqHPz3qsGMKi/1dANFX1jqPqOEKfMYH8WUDNSDpGjJbKmWPAw9/CcJ7kZDBecD/n7E
         0EMa44+nutGjdx+bP+YQB+1iSixv6DkTK9YFPf2Z0EC3yYluTyLIUjnBy2out7xFo8A1
         NGRhi/EyVcGnWPWWq7K0Vbv3NxFy3ckJKc8KEMkjnwRZxynEi6kB6qiS+oE3ATxVLFUQ
         Pn7M33FnGP+c4o3JDNdnmTEQDr6R6etuSGZEvklt5LRmNberlS3osZeVrtYYlOe+d7ut
         pjMg==
X-Gm-Message-State: AOAM533VwyBUojhWrhxLjc7Z1DN4ZLULANGBhIL202v55OR0dtmRJEYm
        DwAqzFRC7foW5tldXzBzH/HhApTpFVaU4bTvG3RuBT96nLs=
X-Google-Smtp-Source: ABdhPJx+0dlJir3NyF535uvsuX5PRB+K8FFAbVdx0BXgPJMOvbeqbslmvuHwiW4KCd7HB/LUbm69QYIAAyC8I1gonjU=
X-Received: by 2002:a92:cbd0:0:b0:2d1:48cb:1739 with SMTP id
 s16-20020a92cbd0000000b002d148cb1739mr20019968ilq.10.1653618547763; Thu, 26
 May 2022 19:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRVCvZ4BDGK3gfD3WgC0VZFh1accyHFoZO+P0rX1mvt6wPoNw@mail.gmail.com>
 <CAJCQCtRNkLZHvUynEuD7_LC4dPyNJr9HmkGL73gAq1_YhkH8kA@mail.gmail.com>
 <CAHRVCvYOhOEyBKLYFC3Q+maoeyU16BMtcLdu+RQgC+=mD8=oxg@mail.gmail.com> <CAJCQCtQFaRBQ1h99oOrS18NhfOTe4J4ORi7wt7u+t4hi0w6_Fw@mail.gmail.com>
In-Reply-To: <CAJCQCtQFaRBQ1h99oOrS18NhfOTe4J4ORi7wt7u+t4hi0w6_Fw@mail.gmail.com>
From:   Gabe <felixnightshade@gmail.com>
Date:   Thu, 26 May 2022 19:28:56 -0700
Message-ID: <CAHRVCvbfkkOYmRZ5sPzFTJgTNa+Mnt7w5wjZqa8_CWvsqG_8NQ@mail.gmail.com>
Subject: Re: Trying to recover pair of drives after sudden power off
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the reassurance that a recovery was possible, Chris. After
coming back to it a few times and squinting hard at the documentation,
I found what I needed.

Just using the bare
"btrfs-find-root /dev/sda1" or
"btrfs restore -l /dev/sda1" listed very few blocks which weren't
fruitful when passed into
"btrfs restore -t <block-id> /dev/sda1 <restore-point>". However,
using the -a option in
"btrfs-find-root -a /dev/sda1"
listed all(?) of the blocks*. Passing the first id into restore copied
around 1.4 terabytes, which sounds about right.

So now that I have the data, is my only option to recover the drives
to format them and copy the files over? No way to recover in place?


* There is a typo in the docs for the -a option:
"Search through all metadata extents, even [if] the root has been
already found."
https://btrfs.readthedocs.io/en/latest/btrfs-find-root.html
(Would this be the place to bring that up?)

On Wed, May 18, 2022 at 10:06 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, May 16, 2022 at 11:10 PM Gabe <felixnightshade@gmail.com> wrote:
> >
> > Okay, updated btrfs-progs to 5.17.
> >
> > # btrfs check --readonly /dev/sda1
> > Opening filesystem to check...
> > parent transid verify failed on 1436734291968 wanted 13636 found 13639
> > parent transid verify failed on 1436734291968 wanted 13636 found 13639
> > parent transid verify failed on 1436734291968 wanted 13636 found 13639
> > Ignoring transid failure
> > ERROR: root [4 0] level 0 does not match 1
> >
> > Yep, same output as  btrfs restore -viD /dev/sda1 /mnt/Alpha2
> >
> > Something that might be of note is that the drive pair was passed
> > through directly to a virtual machine (bad idea for many reasons; now
> > I know). In Proxmox the default option for the disk cache is no cache
> > (which I hadn't changed). If this error stems from a write cache issue
> > then I'm thinking this could have been the cause.
>
> It's a reasonable suspicion. You'd need to dig into what exactly no
> cache means. Does it mean writes can be reordered, violating flush/FUA
> imposed write order? This might not be a problem if the guest crashes,
> because the host will still write everything that was pending. But if
> anything physical happens to the host including the drives, then all
> bets are off and it can be really bad.
>
> However, I'd like to think even in this case that btrfs restore can
> still do a recovery because not everything can be so badly damaged
> that it's impossible. I'd look at the options for specifying older
> root trees. e.g.
>
> btrfs-find-root
>
> And then use the root tree block address in descending order with the
> btrfs restore -t option. Also helpful if you can point to a particular
> subvolume using the --root option. This is easier to figure out with
> newer versions of btrfs progs by using the btrfs restore --list-roots
> option by itself (not attempting a restore otherwise). The more you
> can narrow the tool, the greater the chance of success.
>
> https://btrfs.wiki.kernel.org/index.php/Restore
>
>
> --
> Chris Murphy
