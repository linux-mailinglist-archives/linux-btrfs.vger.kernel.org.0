Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D04021F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 04:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhIGApq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 20:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIGApp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 20:45:45 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93AC061575;
        Mon,  6 Sep 2021 17:44:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so8333993ilm.4;
        Mon, 06 Sep 2021 17:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vDxr7MTqqKSUfCFqjA+zNhlH9fpaOeP/gTRYU5+BByc=;
        b=mtWaSwNow04g6vRuxJL3IYZcg4RrThTXMe2SjTc0NRU0WawPXPqTcFpOHdTNnrPBrw
         KubpkymSbTRaXwcv5shzhtY0HtC174ucUG+dGRiuwAh6d6Fyjs7RfstFhXlthFmo4+R5
         +mS/9btLHLAkHEwFUegVBw+3sRD7pMGvsBarC3WB/2yRVOG5l8CSsnflsIYgoCk4cLD4
         Esb323nR5oK32sEpqPUVXbuJQ9xYNFtCuxiGfS5O3Fyz9WEXsv3bOaQlwFvAhvKEJn9j
         uZMnlpsBWG3B/Uu/3fVHpYLpCy+R6XfKG6p8Hsv1yxSqxnBP6NvIXoDhlnGv9yORphne
         0NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=vDxr7MTqqKSUfCFqjA+zNhlH9fpaOeP/gTRYU5+BByc=;
        b=ti0I1TLrc+rnzYCLT7X1WDY9jYlIpP4PdyENjL7a4PPNkp0jwnLhCrqhZeaE5cDb92
         kpZQzOc7FPCCLq96WGchUCkuX99wMXlWDycnUM78YlGYhX1gq9F06Arbm/4aGdqcgnJO
         Ixs/KJ3IPRJMlVL85FaLb4OjEIazzJ1StKiNWIH195rZfBh4UUNgulSV4thB0w6Tlp8V
         2C7I3YNtV6uuURbBxqvZxbXx2ui3acVMy10EL8zqK4SEe3sAWIbZINqFRBYvsVK679UY
         KbnhXBeUmPHbJNUnpjzIq+D4ZwLVuboSGMRm7rPCpP0TwgME5WGhlvG7AhX+FxzYMmd8
         MPWQ==
X-Gm-Message-State: AOAM532UIo5jIRUcXhRQWDaCUHHxpYlbTDpFUVk3peC+8orKvY+aLbBZ
        p4vdMURmTF94wJNNCl6unFELe1MXBkbQlg8y3mlIygNMWgo=
X-Google-Smtp-Source: ABdhPJy/htOxPBxIiFnZPv0S6mtQPU4yeiZsk+VfBn26t+FduT8dPFuTSpL6xF6PBw8EOSahJ7JNp7D3uGHyw8d7aBk=
X-Received: by 2002:a92:6a02:: with SMTP id f2mr7976160ilc.19.1630975479973;
 Mon, 06 Sep 2021 17:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210906012559.8605-1-baptiste.lepers@gmail.com>
 <20210906122747.GG3379@suse.cz> <CABdVr8Rfd3jXvaa_GYzSqpqUs3Fy7AVHou5z8vHXBhn-YenZfg@mail.gmail.com>
In-Reply-To: <CABdVr8Rfd3jXvaa_GYzSqpqUs3Fy7AVHou5z8vHXBhn-YenZfg@mail.gmail.com>
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Date:   Tue, 7 Sep 2021 10:44:17 +1000
Message-ID: <CABdVr8SfdsxmfgBPBbt70Ci8C=a+8__2f5AeZ7KnpQ6-X6dg7w@mail.gmail.com>
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

No, they need to be between the reads to have an effect. See
https://www.kernel.org/doc/Documentation/memory-barriers.txt =C2=A7SMP
BARRIER PAIRING ("When dealing with CPU-CPU interactions..."). You
will see that the barriers are always between the ordered reads and
not before.

I think that Paul, the barrier guru, can confirm that the barrier was
misplaced in the original code? :)


On Tue, Sep 7, 2021 at 10:43 AM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
>
>
> On Mon, Sep 6, 2021 at 10:27 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Mon, Sep 06, 2021 at 11:25:59AM +1000, Baptiste Lepers wrote:
>> > Per comment, record_root_in_trans orders the writes of the root->state
>> > and root->last_trans:
>> >       set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
>> >       smp_wmb();
>> >       root->last_trans =3D trans->transid;
>> >
>> > But the barrier that enforces the order on the read side is misplaced:
>> >      smp_rmb(); <-- misplaced
>> >      if (root->last_trans =3D=3D trans->transid &&
>> >     <-- missing barrier here -->
>> >             !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
>> >
>> > This patches fixes the ordering and wraps the racy accesses with
>> > READ_ONCE and WRITE_ONCE calls to avoid load/store tearing.
>> >
>> > Fixes: 7585717f304f5 ("Btrfs: fix relocation races")
>> > Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
>> > ---
>> >  fs/btrfs/transaction.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> > index 14b9fdc8aaa9..a609222e6704 100644
>> > --- a/fs/btrfs/transaction.c
>> > +++ b/fs/btrfs/transaction.c
>> > @@ -437,7 +437,7 @@ static int record_root_in_trans(struct btrfs_trans=
_handle *trans,
>> >                                  (unsigned long)root->root_key.objecti=
d,
>> >                                  BTRFS_ROOT_TRANS_TAG);
>> >               spin_unlock(&fs_info->fs_roots_radix_lock);
>> > -             root->last_trans =3D trans->transid;
>> > +             WRITE_ONCE(root->last_trans, trans->transid);
>> >
>> >               /* this is pretty tricky.  We don't want to
>> >                * take the relocation lock in btrfs_record_root_in_tran=
s
>> > @@ -489,7 +489,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_=
handle *trans,
>> >                              struct btrfs_root *root)
>> >  {
>> >       struct btrfs_fs_info *fs_info =3D root->fs_info;
>> > -     int ret;
>> > +     int ret, last_trans;
>> >
>> >       if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
>> >               return 0;
>> > @@ -498,8 +498,9 @@ int btrfs_record_root_in_trans(struct btrfs_trans_=
handle *trans,
>> >        * see record_root_in_trans for comments about IN_TRANS_SETUP us=
age
>> >        * and barriers
>> >        */
>> > +     last_trans =3D READ_ONCE(root->last_trans);
>> >       smp_rmb();
>> > -     if (root->last_trans =3D=3D trans->transid &&
>> > +     if (last_trans =3D=3D trans->transid &&
>> >           !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
>>
>> Aren't the smp_rmb barriers supposed to be used before the condition?
>
>
> No, they need to be between the reads to have an effect. See  https://www=
.kernel.org/doc/Documentation/memory-barriers.txt =C2=A7SMP BARRIER PAIRING=
 ("When dealing with CPU-CPU interactions..."). You will see that the barri=
ers are always between the ordered reads and not before.
>
> I think that Paul, the barrier guru, can confirm that the barrier was mis=
placed in the original code? :)
