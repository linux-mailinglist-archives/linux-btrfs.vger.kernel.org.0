Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D147D13BD7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 11:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgAOKfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 05:35:06 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40785 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgAOKfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 05:35:06 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so4536148vkh.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4RBVVwruJzGIMo6LzbuydUa1Ki2y8lKKJRoEy2h62Ac=;
        b=clygnSfSgOhuv3e2eArKSMh/dErBjS6KZY2Cz94End4Ky15GXf3oXHrwW1YJMEHXDo
         SvRHJNXgr7umKhwOSn1B6YuUteoWuN8QDhCSY+CrHzqpzX08DltlnrADDKUYKDgIX4ws
         02vKTaGoh8YDYAuXJr8d4lTIJf3P/Q74zziWjYCsFkYNAA78E9sW980K8WB4n705YS/H
         e8VmjepUzpFTpq0l16gspm1hchZvvP6L/Ld7Xhh99M/2anhABX5ppF0YpXBPkebM/t/V
         GiuK/jkzACKuejTCYAkoI/tmbTqRErWafRVsgRXDq9cSn5ypyt53TvIx3TmHJiLc0sK4
         1wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4RBVVwruJzGIMo6LzbuydUa1Ki2y8lKKJRoEy2h62Ac=;
        b=iRHXh+JIm+P6S9B2AWf5UNG+4nivSV0hcqcrhQGuVMLybV8+2oLhVSk61MxqtqtmNs
         U7lVnBCev/t9033AIHm7CvAlcc11VWckKzKQySpgUPT4s5Y38MDqqRPTZ1HT0A/lMPB9
         4ahD60HhH3iiIBQJhGFwjTHE4PF0TtM60a/iD6X+r//6ne8/19/7SlN5kg1X1KDYC0Cq
         ZoyGkoRO3YEBHYB0mtMoLtwZR+C/dNhpFxxc0mCrjTI/sYhWCLUGJE4fEHhRoDFaQBTD
         TOIjAgVmEnutA9rUg+1VACOXL44Zq5CGBIH3PrDVSbwSvd5iL3xeEbZRMuYUzckkG/y1
         cSSA==
X-Gm-Message-State: APjAAAX9+vyvvdZAPzV19VlPtAl+pRUrcsIfZqWfwsQGZeXg6Ov2wxBX
        9NunOevVgUAbSphIyyyBxfXBAs1Tj9o9ld0xccI=
X-Google-Smtp-Source: APXvYqx6qx01sBqVVQOdnyhvR0aQt30FWZ7DUJYgFZ+CsMDNbDsDFavFTKS0p/nwQFbTlhheqYSnH+cbPcapfSrthOo=
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr16676850vko.14.1579084505226;
 Wed, 15 Jan 2020 02:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20200115062818.41268-1-wqu@suse.com>
In-Reply-To: <20200115062818.41268-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 10:34:53 +0000
Message-ID: <CAL3q7H5yLcUsmJVnV4A0UQed+oyQipkQ_cpUPZJLxcXruLcpNw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: relocation: Add an introduction for how relocation works.
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 6:29 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Relocation is one of the most complex part of btrfs, while it's also the
> foundation stone for online resizing, profile converting.
>
> For such a complex facility, we should at least have some introduction
> to it.
>
> This patch will add an basic introduction at pretty a high level,
> explaining:
> - What relocation does
> - How relocation is done
>   Only mentioning how data reloc tree and reloc tree are involved in the
>   operation.
>   No details like the backref cache, or the data reloc tree contents.
> - Which function to refer.
>
> More detailed comments will be added for reloc tree creation, data reloc
> tree creation and backref cache.
>
> For now the introduction should save reader some time before digging
> into the rabbit hole.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..cd3a15f1716d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -23,6 +23,50 @@
>  #include "delalloc-space.h"
>  #include "block-group.h"
>
> +/*
> + * Introduction for btrfs relocation.
> + *
> + * [What does relocation do]

For readability, a blank line here would help.

> + * The objective of relocation is to relocate all or some extents of one=
 block
> + * group to other block groups.

Some? We always relocate all extents of a block group (except if
errors happen of course).

> + * This is utilized by resize (shrink only), profile converting, or just
> + * balance routine to free some block groups.
> + *
> + * In short, relocation wants to do:
> + *             Before          |               After
> + * ------------------------------------------------------------------
> + *  BG A: 10 data extents      | BG A: deleted
> + *  BG B:  2 data extents      | BG B: 10 data extents (2 old + 8 reloca=
ted)
> + *  BG C:  1 extents           | BG C:  3 data extents (1 old + 2 reloca=
ted)
> + *
> + * [How does relocation work]
> + * 1.   Mark the target bg RO
> + *      So that new extents won't be allocated from the target bg.
> + *
> + * 2.1  Record each extent in the target bg
> + *      To build a proper map of extents to be relocated.
> + *
> + * 2.2  Build data reloc tree and reloc trees
> + *      Data reloc tree will contain an inode, recording all newly reloc=
ated
> + *      data extents.
> + *      There will be only one data reloc tree for one data block group.
> + *
> + *      Reloc tree will be a special snapshot of its source tree, contai=
ning
> + *      relocated tree blocks.
> + *      Each tree referring to a tree block in target bg will get its re=
loc
> + *      tree built.
> + *
> + * 2.3  Swap source tree with its corresponding reloc tree
> + *      So that each involved tree only refers to new extents after swap=
.
> + *
> + * 3.   Cleanup reloc trees and data reloc tree.
> + *      As old extents in the target bg is still referred by reloc trees=
,
> + *      we need to clean them up before really freeing the target bg.
> + *
> + * The main complexity is in step 2.2 and 2.3.

step -> steps

Thanks.

> + *
> + * The core entrance for relocation is relocate_block_group() function.
> + */
>  /*
>   * backref_node, mapping_node and tree_block start with this
>   */
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
