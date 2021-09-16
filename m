Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1140D21F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhIPDqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 23:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhIPDqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 23:46:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC82C061574;
        Wed, 15 Sep 2021 20:45:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a22so6207730iok.12;
        Wed, 15 Sep 2021 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PandIsADvqsUupHjnSGXxhHD/qBHusaqiIcrYmYtH/4=;
        b=P1vsn6ifdxH7RpFXkSK6CUHK9RFHfhmfm8/RZLjtc+Cw+iI5Dff46aXEZHD+9GHIXA
         ipNW+YJpUBOPigSQ+OaWKyAPkt3aPZOex41CPL0d7rxDT0WvniHD5Qg+O20p+lh3fJOf
         o0pXeDQXY+cdJlaKrBltTP/A1vWgqaKjufmaxZxk0rLrNNwJErwETImQ+1m9ulWbU00Q
         je2oWDAHAY327lq6MhnqyrJ+33jwwDLX/RFxMvBjppyzDKuV/i//5+ahXtSMJsVHgB03
         4eFyfpwMADNu8lgK8lpm9yKnDUz60aaZY2qiPfXX9O2tM3qXq7KDkhibBJ35ht/eiath
         QSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PandIsADvqsUupHjnSGXxhHD/qBHusaqiIcrYmYtH/4=;
        b=4Mrok4obJHWLpP7YCKdoUPgY7VWiwtBX43dBqGvioQTsOm8tK6VtjxceiPvnHehSrG
         O2tJKM1bbEs8Xq4Rhl5u8N8IWBMnnaLgXMUhKk6sDxqFB7/SSWTv+XTWPzsPskNit2yD
         EIqdlxr1ocGp0kbkgOY3PHqlraQbjJgDXr9ylMYln3cDKt9eFxsLD+sP5zVqwYjUblDi
         TMxaAQoszzaHzSdPEMG6rx1V0G87P6s0NsLlWp8BAK/vYuEk0ceAt4XlYwTgAPWTncju
         6wiADFsfPY85crjve3xdsA/FrOEKhKRgKHw+/daqBb/nRdM6/skNIAknfZ7f16T0o5D5
         NqjQ==
X-Gm-Message-State: AOAM532TanGwIuIiMBn3C/PtEjG9PcdNpgR5dW3YDNfiyccP3W+4slbu
        niyN0ZHR2ZKuQD7E97lxPf/x74yEoCMggRWUcZI=
X-Google-Smtp-Source: ABdhPJxAz0aGqVeUQgpt7k92eRjZYuoYezk42H4eflVKJFVEcmoA9ZlyR4NdfsWpPrEJAOruBNvy1QASlPCZuN53qEo=
X-Received: by 2002:a5e:d70a:: with SMTP id v10mr2750143iom.10.1631763927102;
 Wed, 15 Sep 2021 20:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210906012559.8605-1-baptiste.lepers@gmail.com>
 <20210906122747.GG3379@suse.cz> <CABdVr8Rfd3jXvaa_GYzSqpqUs3Fy7AVHou5z8vHXBhn-YenZfg@mail.gmail.com>
 <CABdVr8SfdsxmfgBPBbt70Ci8C=a+8__2f5AeZ7KnpQ6-X6dg7w@mail.gmail.com>
In-Reply-To: <CABdVr8SfdsxmfgBPBbt70Ci8C=a+8__2f5AeZ7KnpQ6-X6dg7w@mail.gmail.com>
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Date:   Thu, 16 Sep 2021 13:45:16 +1000
Message-ID: <CABdVr8QLZ7vHh=Prt_W0LLOLMMJQJySyjZ3cw04HR7O4nfq1_Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: transaction: Fix misplaced barrier in btrfs_record_root_in_trans
To:     dsterba@suse.cz, Baptiste Lepers <baptiste.lepers@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just curious about the status of this patch. :) Let me know if you
need further information.

Thanks!

On Tue, Sep 7, 2021 at 10:44 AM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
> No, they need to be between the reads to have an effect. See
> https://www.kernel.org/doc/Documentation/memory-barriers.txt =C2=A7SMP
> BARRIER PAIRING ("When dealing with CPU-CPU interactions..."). You
> will see that the barriers are always between the ordered reads and
> not before.
>
> I think that Paul, the barrier guru, can confirm that the barrier was
> misplaced in the original code? :)
>
>
> On Tue, Sep 7, 2021 at 10:43 AM Baptiste Lepers
> <baptiste.lepers@gmail.com> wrote:
> >
> >
> >
> > On Mon, Sep 6, 2021 at 10:27 PM David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Mon, Sep 06, 2021 at 11:25:59AM +1000, Baptiste Lepers wrote:
> >> > Per comment, record_root_in_trans orders the writes of the root->sta=
te
> >> > and root->last_trans:
> >> >       set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
> >> >       smp_wmb();
> >> >       root->last_trans =3D trans->transid;
> >> >
> >> > But the barrier that enforces the order on the read side is misplace=
d:
> >> >      smp_rmb(); <-- misplaced
> >> >      if (root->last_trans =3D=3D trans->transid &&
> >> >     <-- missing barrier here -->
> >> >             !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
> >> >
> >> > This patches fixes the ordering and wraps the racy accesses with
> >> > READ_ONCE and WRITE_ONCE calls to avoid load/store tearing.
> >> >
> >> > Fixes: 7585717f304f5 ("Btrfs: fix relocation races")
> >> > Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> >> > ---
> >> >  fs/btrfs/transaction.c | 7 ++++---
> >> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> >> > index 14b9fdc8aaa9..a609222e6704 100644
> >> > --- a/fs/btrfs/transaction.c
> >> > +++ b/fs/btrfs/transaction.c
> >> > @@ -437,7 +437,7 @@ static int record_root_in_trans(struct btrfs_tra=
ns_handle *trans,
> >> >                                  (unsigned long)root->root_key.objec=
tid,
> >> >                                  BTRFS_ROOT_TRANS_TAG);
> >> >               spin_unlock(&fs_info->fs_roots_radix_lock);
> >> > -             root->last_trans =3D trans->transid;
> >> > +             WRITE_ONCE(root->last_trans, trans->transid);
> >> >
> >> >               /* this is pretty tricky.  We don't want to
> >> >                * take the relocation lock in btrfs_record_root_in_tr=
ans
> >> > @@ -489,7 +489,7 @@ int btrfs_record_root_in_trans(struct btrfs_tran=
s_handle *trans,
> >> >                              struct btrfs_root *root)
> >> >  {
> >> >       struct btrfs_fs_info *fs_info =3D root->fs_info;
> >> > -     int ret;
> >> > +     int ret, last_trans;
> >> >
> >> >       if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
> >> >               return 0;
> >> > @@ -498,8 +498,9 @@ int btrfs_record_root_in_trans(struct btrfs_tran=
s_handle *trans,
> >> >        * see record_root_in_trans for comments about IN_TRANS_SETUP =
usage
> >> >        * and barriers
> >> >        */
> >> > +     last_trans =3D READ_ONCE(root->last_trans);
> >> >       smp_rmb();
> >> > -     if (root->last_trans =3D=3D trans->transid &&
> >> > +     if (last_trans =3D=3D trans->transid &&
> >> >           !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
> >>
> >> Aren't the smp_rmb barriers supposed to be used before the condition?
> >
> >
> > No, they need to be between the reads to have an effect. See  https://w=
ww.kernel.org/doc/Documentation/memory-barriers.txt =C2=A7SMP BARRIER PAIRI=
NG ("When dealing with CPU-CPU interactions..."). You will see that the bar=
riers are always between the ordered reads and not before.
> >
> > I think that Paul, the barrier guru, can confirm that the barrier was m=
isplaced in the original code? :)
