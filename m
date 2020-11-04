Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75B2A6CA8
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgKDS2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 13:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDS2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 13:28:25 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A3C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 10:28:25 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id x20so20252432qkn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4nVicJOSxwRVFwu/yRjiwZeQ2vXmDZhskBJDBXsFrjU=;
        b=ehu5JB3RrcffroAutMD8V6indu5iWWgOyIyhXFfL4Fmk2vueTkuo5g+Bv/JAU7cXVO
         fGm5hfJwy0Q4onMEBJSgeFzObKFBCoJ9otNyDMWd3tUF4qAEHnG2kvfUpmF5FMoIkqa3
         Cs7vFhSEO4/pvCfcxiOER3h7XTLWjkrNOupZE9NxRBlZUkXckjRGUz3HbUjrtRrQzLgm
         eqbG0lRYErpJbu9XDmjx3vj5RvVJoEeHqzNVV7OPqUJWLnAfv+pa+fCapc2QUH9iLmna
         hLRlYNP8cU7qj+w398L+SRjDOzqYYxdbCaooAV+0yEr/ukhzjZfHPAxAL6KSdHqaJfqC
         vaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4nVicJOSxwRVFwu/yRjiwZeQ2vXmDZhskBJDBXsFrjU=;
        b=nHKJpGj1qO8BH42RnDZz3+Q1xlIEvg8DkOwP2G/dAxNSO+woN7qnxv2UZ0/cfB3EsJ
         WBHt7ZRQRHho1YItqYtijnPgYOXWQvpacTLpDchPkb5tJ+Le2YgL4iTXeK4nl9lA5FXj
         Ofgp8cPQQtqANIn4l/bsG5DBK6ozXDCf38eiMowXtyzHecKorQUyCQxgEti7EbP48UEr
         VlQ5S7FCDbqadTHadEGKOBEt0/2JNwtn4EdR6pe8YMatp1TEY6HwofKnd1M2U6S0N7OR
         dAC86wDOTjqok5KQbmJf7jTmnVb/TKuojROeg8gvYC28zgx0HDQtXu9grr3X3DQnGP83
         K5wA==
X-Gm-Message-State: AOAM5336kBHZ4kM1Ekm0E3YdvvjIS3XdBZMQhEPR3X1v3kBw19htzi4X
        5/FUKzbrBZPly4X3XkVK3qdIUhXIHC9CTMvvSsE=
X-Google-Smtp-Source: ABdhPJyim+s8H7bp5GiyxKwGWaTonoWLhlBi/FcIfK5XIfkSu1YLLlsK5mEn5mggsWb8sICME80rfuopJag27fQqpOk=
X-Received: by 2002:a37:de08:: with SMTP id h8mr27051234qkj.0.1604514504614;
 Wed, 04 Nov 2020 10:28:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <afb3c72b04191707f96001bc3698e14b4d3400a8.1603460665.git.josef@toxicpanda.com>
 <CAL3q7H5ddLEFbisuFmauK9=XX+sEPy-O4R7X1kp67YH4N1hfcw@mail.gmail.com> <fd63e33b-49ea-2150-eaef-e3fd19e5372a@toxicpanda.com>
In-Reply-To: <fd63e33b-49ea-2150-eaef-e3fd19e5372a@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 18:28:13 +0000
Message-ID: <CAL3q7H6hWx=VZDNZQjxzwEDw0-3TMUPtft5y3Mc-NSU4VBj2dw@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: cleanup btrfs_discard_update_discardable usage
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 6:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 11/4/20 10:54 AM, Filipe Manana wrote:
> > On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> This passes in the block_group and the free_space_ctl, but we can get
> >> this from the block group itself.  Part of this is because we call it
> >> from __load_free_space_cache, which can be called for the inode cache =
as
> >> well.  Move that call into the block group specific load section, wrap
> >> it in the right lock that we need, and fix up the arguments to only ta=
ke
> >> the block group.  Add a lockdep_assert as well for good measure to mak=
e
> >> sure we don't mess up the locking again.
> >
> > So this is actually 2 different things in one patch:
> >
> > 1) A cleanup to remove an unnecessary argument to
> > btrfs_discard_update_discardable();
> >
> > 2) A bug because btrfs_discard_update_discardable() is not being
> > called with the lock ->tree_lock held in one specific context.
>
> Yeah but the specific context is on load, so we won't have concurrent mod=
ifiers
> to the tree until _after_ the cache is successfully loaded.  Of course th=
is
> patchset changes that so it's important now, but prior to this we didn't
> necessarily need the lock, so it's not really a bug fix, just an adjustme=
nt.
>
> However I'm always happy to inflate my patch counts, makes me look good a=
t
> performance review time ;).  I'm happy to respin with it broken out.  Tha=
nks,

Then make it 3! One more just to add the assertion!

I'm fine with it as it is, maybe just add an explicit note that we
can't have concurrent access in the load case, so it's not fixing any
bug, but just prevention.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
