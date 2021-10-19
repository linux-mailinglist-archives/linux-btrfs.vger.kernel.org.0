Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628B6433A8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJSPf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhJSPfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC7C061746
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 08:33:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x123so300141qke.7
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/ezdIifNTpwDDole8t/Kkigo3n7qeGlfyyQf8+0av2k=;
        b=HLrpBE4jgwCZnfmwPa3IBOhVRUZI7VefUNH5jtM6RVCW4N8i55uhU1fPF3W6GOVMFf
         /XiXlnnMLgyUeQTojsXirNC15dwgrePCd+b95Qczmt1bgLYjbJKyIWNjDWcX2jypsRz7
         Q2aCAZzYzwETZcDvWIwOWv2eCEwoJ02SCnlGKivzzo5ix0PzhSCqi2n+omj3XbXpE1r9
         MUnsjxIwLaXUoBu3dOG9CUb0kEWmFwPjkj19AL8k9OscWtoWK3acF1By1NWEo8zTxzI3
         QZarZTqiGMXtvxeLyut3y3AiuGtnFkbIVZXPjXUDNS9aKV5pIMrkQ8AobeonImmDckDS
         pcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=/ezdIifNTpwDDole8t/Kkigo3n7qeGlfyyQf8+0av2k=;
        b=rFZI573b/yga7lKGZdc6kDMuW+9l5fCAwZRTyADMkrZk0t7lMSzaijLfBQoYtZpJdC
         xFgrGc/FytyfDwRvlS+Nt6R3Lng05LydjERHVBbTvaJHVp6pYtaL6LPJHR97AdyfmQWY
         6Y1D4W7NqCgqA4sNLnFB0MiLdncHRMnC7YI+WN4AghPxpD1ijwU4U3/mdtu1FArzdxGI
         xF7sMh6BXd0CeH1P6gtqK4EQRgaXnK72SvPsCKTDpPow0uPyA2mUTtxJLeMhzGM7ctap
         NOhNaF5GivdkneHJic2bUMxJkUi/f1+RvPxpKAyMeVjVXxfQS0ZFuMOXnw4zo/G80I1y
         Kiqg==
X-Gm-Message-State: AOAM532DQv1grMe2fFmX+5toPrFHW/d6wCTT06S5oVIQ62hdRTlCP903
        smu+K1OetxAha5z5cNVwJgo9tM6+RPW1Jzflsuw=
X-Google-Smtp-Source: ABdhPJzyoGJK0mmYs5kSwxAiJpdADoARvUqiN9A7y1ylJokM4OKmiuoyCy4J6R9H2OdlXfXW0cCxsnKDUrwjsnr4Gdg=
X-Received: by 2002:a37:2c86:: with SMTP id s128mr514590qkh.516.1634657582040;
 Tue, 19 Oct 2021 08:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211018173803.18353-1-dsterba@suse.com> <YW3nBs4cr99TcyRL@localhost.localdomain>
 <20211019145412.GT30611@twin.jikos.cz>
In-Reply-To: <20211019145412.GT30611@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 19 Oct 2021 16:32:25 +0100
Message-ID: <CAL3q7H4_BVH=CHJADV4k7QGeRYcZDi9wcMKNvPm7O5znHByVxA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add stub argument to transaction API
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 3:57 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Oct 18, 2021 at 05:28:38PM -0400, Josef Bacik wrote:
> > On Mon, Oct 18, 2021 at 07:38:03PM +0200, David Sterba wrote:
> > > Why the stub/context argument is needed: the NOFS protection is per c=
all
> > > site, so it must be set and reset in the caller thread, so any
> > > allocations between btrfs_start_transaction and btrfs_end_transaction
> > > are safe. We can't store it in the transaction handle, because it's n=
ot
> > > passed everywhere, eg. to various helpers in btrfs and potentially in
> > > other subsystems.
> >
> > So the plan is to instead pass the tctx around everywhere to carry the =
flags?  I
> > thought the whole point of memalloc_nofs_save() is that we don't have t=
o pass
> > gfp_t's around everywhere, it just knows what we're supposed to be doin=
g?
>
> Nothing needs to be passed around, it will be hidden inside the
> transaction start/end, the only thing the caller needs to do is to
> define the variable and pass it to to transaction start call. The NOFS
> section will then apply to any calls until the transaction end call.
>
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1232,6 +1232,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>         struct btrfs_path *path;
>         struct btrfs_block_rsv *block_rsv;
>         int ret;
> +       DEFINE_TCTX(tctx);
>
>         if (!delayed_node)
>                 return 0;
> @@ -1244,7 +1245,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>         }
>         mutex_unlock(&delayed_node->mutex);
>
> -       trans =3D btrfs_join_transaction(delayed_node->root, NULL);
> +       trans =3D btrfs_join_transaction(delayed_node->root, tctx);
>         if (IS_ERR(trans)) {
>                 ret =3D PTR_ERR(trans);
>                 goto out;
> @@ -1271,7 +1272,7 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_i=
node *inode)
>         btrfs_free_path(path);
>         trans->block_rsv =3D block_rsv;
>  trans_out:
> -       btrfs_end_transaction(trans, NULL);
> +       btrfs_end_transaction(trans, tctx);
>         btrfs_btree_balance_dirty(fs_info);
>  out:
>         btrfs_release_delayed_node(delayed_node);
> ---
>
> This is what needs to be done per caller.
>
>
> > So
> > the trans should be able to hold the flags since we only care about sta=
rting it
> > and restoring it, correct?  Or am I wrong and we do actually need to pa=
ss this
> > thing around?  In which case can't we still just save it in the trans h=
andle,
> > and pass the u32 around where appropriate?  Thanks,
>
> I had to dig in my memory why we can't store it in the transaction
> handle, because this is naturally less intrusive. But it does not work.
>
> There are two things:
>
> 1) In a function that starts/joins a transaction, the NOFS scope is from
>    that call until the transaction end. This is caller-specific.
>    Like in the example above, any allocation with GFP_KERNEL happening
>    will be safe and not recurse back to btrfs.
>
> 2) Transaction handle is not caller-specific and is allocated when the
>    transaction starts (ie. a new kmem_cache_alloc call is done). Any
>    caller of transaction start will only increase the reference count.

I'm having trouble understanding this.

The transaction handle, struct btrfs_trans_handle, is caller specific
and once allocated we make current->journal_info point to it.

Any task calling start/join/attach transaction, always allocates one,
which gets freed once it calls end_transacton() or
commit_transaction() and then current->journal_info is set to NULL.

I'm not seeing why can't the flags returned by memalloc_*_save() be
stored in the transaction handle itself.
Care to elaborate?

Not that I care much if this goes into the upcoming merge window or
the next one, but since this is an internal API, that does not affect
users or features, why the urgency to have this merged before there
are any real uses of it?

Thanks.

>
> So, on each refcount_inc, we'd need to store the nofs_flags, on each
> refcount_dec to restore it.
>
> It is possible that the NOFS context is also needed outside of the
> start/end region, but it depends and has to be done case by case. For
> the transcation start/end we're sure the NOFS must be set.
>
> The NOFS scope should be also more fine-grained to where we know we
> really need it, so it's not "GFP_NOFS everywhere" just implemented by
> other means.
>
> There is (and will be more) code adding assertions and additional checks
> to verify the invariants. For anybody who's interested I can share the
> WIP branches, but I haven't worked on it since 5.6.
>
> Getting the API parameter extension would help to shorten the
> start-again time, it's possible I'm missing something and it can be done
> in an easier way but I don't see it right now.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
