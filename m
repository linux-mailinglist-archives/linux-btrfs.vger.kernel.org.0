Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405DB1ECC97
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFCJbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 05:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCJbA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 05:31:00 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFC320734
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591176657;
        bh=cIOfQp/DVgZYjmq/sfyZNSahtZGVYHRE9w37T+56plI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cxYmd87DM70u2910674ZghGz9CQjBbDvHKhr3kDcGPHgOfHDH6taBLT3sM5sxt+uu
         O/5GrB7nWhdmZKytL9wDNStR2+Nswwo9Ep5bOe71+9Z+eWIVPawlZmemX55AwSE5JJ
         dLDM2WWROKSjGSlLfTJmV6xvU6hcI4WDUHyjwAOc=
Received: by mail-vs1-f41.google.com with SMTP id y123so988301vsb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 02:30:57 -0700 (PDT)
X-Gm-Message-State: AOAM531IOWA3wgWeBnL6XWvzQNhw63my0pAP7HBsL9IgeML1bAeWE3ZA
        B2gKaPDnojOnuilnHqH3XHp7vek2Wpg6xGt8znk=
X-Google-Smtp-Source: ABdhPJwn5HM4BrYuWkWYS7DIkklBbWSGMNuMgXFs1gGQZy2xQ6Q2/EBnOdoIOlsa0vZXJxCq+8+o4Nyw0jasJqcroD8=
X-Received: by 2002:a67:407:: with SMTP id 7mr19795536vse.95.1591176656187;
 Wed, 03 Jun 2020 02:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200601181206.24852-1-fdmanana@kernel.org> <0b010680-f286-f858-8cfd-94dc888ca7a4@suse.com>
In-Reply-To: <0b010680-f286-f858-8cfd-94dc888ca7a4@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 Jun 2020 10:30:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7XMfhH3Z8RCzXGrnMeT9NBNRyAdKRNZAF9n0hFH_xkrw@mail.gmail.com>
Message-ID: <CAL3q7H7XMfhH3Z8RCzXGrnMeT9NBNRyAdKRNZAF9n0hFH_xkrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Btrfs: fix a block group ref counter leak after
 failure to remove block group
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 3, 2020 at 8:32 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 1.06.20 =D0=B3. 21:12 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When removing a block group, if we fail to delete the block group's ite=
m
> > from the extent tree, we jump to the 'out' label and end up decrementin=
g
> > the block group's reference count once only (by 1), resulting in a coun=
ter
> > leak because the block group at that point was already removed from the
> > block group cache rbtree - so we have to decrement the reference count
> > twice, once for the rbtree and once for our lookup at the start of the
> > function.
>
> However I'm having hard time reconciling this. The block group is
> removed from the block_group_cache_tree after we've called
> btrfs_del_item. So if btrfs_del_item or btrfs_search_slot fail the code
> jumps at out_put_group and puts the reference acquired at the beginning
> of the function via btrfs_lookup_block_group.
>
> I think what you meant is if we fail to delete the block group's item
> from the freespace tree, that is if we fail
> remove_block_group_free_space, then we'd have a ref leak.

What I meant is exactly what I wrote:
if we fail to delete the block group's item from the extent tree (the
call to remove_block_group_item()),
we end up decrementing the reference count only once because we jump
to the out label - but we
should have decremented it twice, once for the rbtree removal, which
happened before, and once for
the lookup at the start of the function.

Thanks.

> With this
> modification to the changelog:
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
> >
> > To make things less error prone, decrement the reference count for the
> > rbtree immediately after removing the block group from it. This also
> > eleminates the need for two different exit labels on error, renaming
> > 'out_put_label' to just 'out' and removing the old 'out'.
>
> I agree with this.
>
> >
> > Fixes: f6033c5e333238 ("btrfs: fix block group leak when removing fails=
")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> <snip>
