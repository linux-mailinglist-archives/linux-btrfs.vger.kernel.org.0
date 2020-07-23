Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D922B08B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgGWNcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGWNcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 09:32:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198BC0619DC
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 06:32:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q74so6248026iod.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YeoozvV0kVGFnzD9BzYjqKYRq4ttp4LmQ4kEJFlleNc=;
        b=noKyu78FtrA9K5bNmXZNFKfAF3F6QFbveg6RwXp5tn/AabXRBMCGPDmRqWUAjcJRmC
         aGa4CHHhXq3mvVxGV9eQVNKQ4onP/WTquE7kLA4HgIqXmyPDCLXVIz9Pj+gzzN7hubXs
         PMMYp6hUU3NQaUmm0ZtVx5GSX1te0kjTay0Rp7KGEZOV6apP+J+Dwv+kNKFNUFMdJViN
         /6lnZCOZmj9hJ8B2zfSb07WkauZQsmSQvy1PzA2+WCP+1XUjabn6+8BcPZQDS+oc3CkM
         ZuuEcL+A8HJJHcQ/rI+EEXJcDWK/8qu5z1gNJrrZOLEEaqzAW24D+bLb4AyfDL7YULPA
         naBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=YeoozvV0kVGFnzD9BzYjqKYRq4ttp4LmQ4kEJFlleNc=;
        b=Q9n/o2lfclj0hoLqmVb3yGUGrvmZz+bOmzlB1DE6n2LPvQDyimIC7FyHjsJa8oL2DW
         ZO0bXekEB+eiGRf6efxH02u3e3QB9CINB1+2haxfn1Iqb9P4Da4cjyj/hvxVX7DCE0Ye
         ooqgtC0+xc8XOZeMoStplsg40Zsouvur5P/F3Ly1VCaBLQRXXK0ORvSoBBFsMyaX4LmM
         rNA8vaxHIyhdgU5STwHaGuS3CTyP/OJSJ65AWYuR1h3spT6Ca+9EOL40/c0VHH8B+5Tv
         CgycRW3sQIDuJT1ouGY4JTkoMWGPaTw2uzlM+W/u/r5KOQuilrqQ0FYAGCYIcqxKO7HM
         pg1A==
X-Gm-Message-State: AOAM532yEprSTGj320t5kjOiIPav2TIm4jcxFThqtwxefepSNlkPwYjv
        aCYC00Kn5g9sgnpupkHCi9ch1QK5e+5xvnx97Ws=
X-Google-Smtp-Source: ABdhPJylyIA7Y3R4Vy79A0Ka+IcXXvOdKM+wRRS4EWae0oSanAWt7oU7jV2knaNnoWXPREQOQaWpi8Zz/MwPpe0s1hY=
X-Received: by 2002:a05:6638:1308:: with SMTP id r8mr5011496jad.106.1595511128110;
 Thu, 23 Jul 2020 06:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200720125109.93970-1-wqu@suse.com> <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com> <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com> <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com> <20200722113220.GR3703@twin.jikos.cz>
In-Reply-To: <20200722113220.GR3703@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 23 Jul 2020 09:31:32 -0400
Message-ID: <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for cctx->total_bytes
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Christian Zangl <coralllama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
> > >> Thus casting both would definitely be right, without the need to ref=
er
> > >> to the complex rule book, thus save the reviewer several minutes.
> > >
> > > The opposite, if you send me code that's not following known schemes =
or
> > > idiomatic schemes I'll be highly suspicious and looking for the reaso=
ns
> > > why it's that way and making sure it's correct costs way more time.
> > >
> > OK, then would you please remove one casting at merge time, or do I nee=
d
> > to resend?
>
> Yeah, I fix such things routinely no need to resend.

I have a report[1] that seems to look like this patch solves it, is
that correct?

[1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
