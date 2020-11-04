Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54522A6BEE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgKDRmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 12:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgKDRmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 12:42:32 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD36C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 09:42:32 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 9so23004089oir.5
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BW/LMfF+1FqMkqjmN+XfkeasbRI7j1OiAR3z8Mi2j3M=;
        b=Psi3Q/fbbTO5x9lzBgEFSedg7XetgkWshqAYYmfNxv1jYVveGuWaUb+nISTsxfYzLg
         hE2jGlxFxlSihAIw6LvzlYmx9p2HjlFH+dieNQBC7dVSD58298N/6yyq/8l5ANliST7h
         u6i3JGf+bXawzkVAdN/jfz4fXbFeXK/wX/KzLS+osN6vxqzC7UwOdLUBhAsR1Jihtb4O
         6N5c0JlFNfnziPbD2fCJcPIuoTAeuGgf2iiW8n9ydZ/5bWOXi6ge6c50RPOEDavo7No4
         759VakAedLuVfmwAd+VpGB4U8Dohx2CQLebPgo30PFtIAHQqYzgiO01/uHGOofqxM7Cr
         SHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BW/LMfF+1FqMkqjmN+XfkeasbRI7j1OiAR3z8Mi2j3M=;
        b=RNqPNHxlLh3p9bvL+1Srh4JAWiW8rwwPXDbZcCWcMvYam8PpxbAElM5yFCmvO7vOrR
         zq39T4ayID2w5cjUEy0YO9UcQ+Dbm/bdVYTt5ds0fLcb5GAtZriPEDmpPBjasJQ5W8jv
         7YAupqOVfojfl1nXSQLO8r4Llm7moA4oi59ekcmfBBtOsO3d2knmRBJAk9/sHnlIjaZw
         923bdFNS5XQWZ87gAnhKq+whMpdL2VGVh50vke+2RC3ZzsGCT1/wARg4Wu+gNcZkKXK0
         fBb1ZhcDXIRE22rQ16y0KQ3x9jTzPwnyBa7XyMCIdBIMGG4a6dMj1YNYjIUGZBsnv/HH
         VnsQ==
X-Gm-Message-State: AOAM532AB4kHBf4xZF23d0HbLjb3hWLTmeuUKI9ZD4UcsemDpfOSMP8i
        JVELrnEZk4z5NetSg6zGHIUkhTlWvtw9fnWtQKpu1a27Xio=
X-Google-Smtp-Source: ABdhPJyTwCYWOPujWRk0Urod73YlTVQO+uMSphJuT5nhHHH9QygY4CRpwLTwgvYLEqZtbRiMKlq+bTCKRgyLKDRA048=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr3039885oig.161.1604511751508;
 Wed, 04 Nov 2020 09:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20201103211101.4221-1-dsterba@suse.com> <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
 <20201104155354.GG6756@twin.jikos.cz>
In-Reply-To: <20201104155354.GG6756@twin.jikos.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 09:42:20 -0800
Message-ID: <CAE1WUT5xuR--a=0QdK=nG7NpW6=nX=JvcOUik1c-RO5XaqNCeA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 7:59 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Nov 04, 2020 at 07:44:33AM +0800, Qu Wenruo wrote:
> > On 2020/11/4 =E4=B8=8A=E5=8D=885:11, David Sterba wrote:
> > > After the rwsem replaced the tree lock implementation, the extent buf=
fer
> > > got smaller but leaving some holes behind. By changing log_index type
> > > and reordering, we can squeeze the size further to 240 bytes, measure=
d on
> > > release config on x86_64. Log_index spans only 3 values and needs to =
be
> > > signed.
> > >
> > > Before:
> > >
> > > struct extent_buffer {
> > >         u64                        start;                /*     0    =
 8 */
> > >         long unsigned int          len;                  /*     8    =
 8 */
> > >         long unsigned int          bflags;               /*    16    =
 8 */
> > >         struct btrfs_fs_info *     fs_info;              /*    24    =
 8 */
> > >         spinlock_t                 refs_lock;            /*    32    =
 4 */
> > >         atomic_t                   refs;                 /*    36    =
 4 */
> > >         atomic_t                   io_pages;             /*    40    =
 4 */
> > >         int                        read_mirror;          /*    44    =
 4 */
> > >         struct callback_head       callback_head __attribute__((__ali=
gned__(8))); /*    48    16 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         pid_t                      lock_owner;           /*    64    =
 4 */
> > >         bool                       lock_recursed;        /*    68    =
 1 */
> > >
> > >         /* XXX 3 bytes hole, try to pack */
> > >
> > >         struct rw_semaphore        lock;                 /*    72    =
40 */
> >
> > An off-topic question, for things like aotmic_t/spinlock_t and
> > rw_semaphore, wouldn't various DEBUG options change their size?
>
> Yes they do. For example spinlock_t is 4 bytes on release config and 72
> on debug. Semaphore is 40 vs 168. Atomic_t is 4 bytes always, it's just
> an int.

These are pretty big differences in byte size. Probably not worth
shifting everything
just for debug configs.

>
> > Do we need to consider such case, by moving them to the end of the
> > structure, or we only consider production build for pa_hole?
>
> We should optimize for the release build for structure layout or
> cacheline occupation, the debugging options make it unpredictable and it
> affects only development. There are way more deployments without
> debugging options enabled anyway.

We could always just leave a comment there noting that it's unpredictable
under debug, and that debugging will require a temporary user-end shift.
Optimizing for production is best, yep.

>
> The resulting size of the structures is also bigger so this has
> completely different slab allocation pattern and performance
> characteristics.

Yeah, another reason we should just focus on production.

>
> Here's the layout of eb on the debug config I use:
>
> struct extent_buffer {
>         u64                        start;                /*     0     8 *=
/
>         long unsigned int          len;                  /*     8     8 *=
/
>         long unsigned int          bflags;               /*    16     8 *=
/
>         struct btrfs_fs_info *     fs_info;              /*    24     8 *=
/
>         spinlock_t                 refs_lock;            /*    32    72 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
>         atomic_t                   refs;                 /*   104     4 *=
/
>         atomic_t                   io_pages;             /*   108     4 *=
/
>         int                        read_mirror;          /*   112     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct callback_head       callback_head __attribute__((__aligned=
__(8))); /*   120    16 */
>         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>         pid_t                      lock_owner;           /*   136     4 *=
/
>         bool                       lock_recursed;        /*   140     1 *=
/
>         s8                         log_index;            /*   141     1 *=
/
>
>         /* XXX 2 bytes hole, try to pack */
>
>         struct rw_semaphore        lock;                 /*   144   168 *=
/
>         /* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
>         struct page *              pages[16];            /*   312   128 *=
/
>         /* --- cacheline 6 boundary (384 bytes) was 56 bytes ago --- */
>         struct list_head           leak_list;            /*   440    16 *=
/
>
>         /* size: 456, cachelines: 8, members: 15 */
>         /* sum members: 450, holes: 2, sum holes: 6 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
>         /* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));

Best regards,
Amy Parker
(they/them)
