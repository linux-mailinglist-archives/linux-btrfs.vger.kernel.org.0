Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA133D34B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 12:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhCPLoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 07:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237403AbhCPLnv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 07:43:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2004864FB5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615895031;
        bh=pOlyk4g2gRVVyc1UZQ93ron0PLMLE+5Hj9TYniQSk0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IFghX9bP5LR17YTitjlHUZ1+qtzBjtXah+waEpz+OZD/bMpCSbm/DP/Tg8gftkak1
         Yfp8KGybVhGXs0omScc7QPy8HM7jGVM7fLd5CpBgUp+ciT+MFKJNgIst+0IpB1Chn+
         ilTXVbPmZCiECncY9cCtTT9WETYTvfi13TFcN9QtNzOUSnS69s7U5AZwXASp2e6GVn
         jH9bfFcRkUHKdMz8djnfoIqppcCa1Rl2/QQbo6b+orFSD5okS7Xa869v3/+t9FFFBq
         CQhOvirDyWY7EopWm53P+wFcMyfRLgdEeJel9Qfc9aST5Kam4Ov3g1dlKTmNZTXMkl
         4qeg5CBRr7xxw==
Received: by mail-qk1-f177.google.com with SMTP id n24so4634848qkh.9
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 04:43:51 -0700 (PDT)
X-Gm-Message-State: AOAM532Qe7uuVmGLLZwkTR/ETCOTQIqciiQ41YisegNhCbap7ji3buYD
        V4xV3zyZPrmtOYoM7VKgve/LSoMfcN5jAPSagLk=
X-Google-Smtp-Source: ABdhPJxSHJgD0pv6utJE/kMLsc6IGoqzNWAAGdCVG7anhqhVsdNj2KsrM6kBm/JHgTcMBRvgSEYsppEhD5ndD72iV4o=
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr30735401qke.383.1615895030272;
 Tue, 16 Mar 2021 04:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1607940240.git.fdmanana@suse.com> <d18713e258daa60e986e6ee7c22b4479e0d396c4.1607940240.git.fdmanana@suse.com>
 <b19f4310-35e0-606e-1eea-2dd84d28c5da@synology.com>
In-Reply-To: <b19f4310-35e0-606e-1eea-2dd84d28c5da@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Mar 2021 11:43:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6=VRoBdSnMn03wAYpeBVaD0XoE3FO7ioxEGogHF_LYbA@mail.gmail.com>
Message-ID: <CAL3q7H6=VRoBdSnMn03wAYpeBVaD0XoE3FO7ioxEGogHF_LYbA@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: fix transaction leak and crash after cleaning
 up orphans on RO mount
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 6:49 AM robbieko <robbieko@synology.com> wrote:
>
> Hi All,
>
> The patch delayed find orphan roots.
> Move to after orphan cleanup with tree_root.
> I think this will cause all orphan items to be deleted
> when orphan cleanup with tree_root.
> Afterwards, find orphan roots cannot find
> the subvolume being deleted.

Not entirely able to parse what you are trying to say.

I suppose your concern is that the call to:

btrfs_orphan_cleanup(fs_info->tree_root)

which now happens before calling btrfs_find_orphan_roots(), results in
the orphans for roots being accidentally deleted and therefore cause
no root deletions to happen later?
If that's your concern, than it does not happen because
btrfs_orphan_cleanup() skips deletion of orphan items for deleted
roots.

I've just created a test case to verify it's correct, for RW mounts,
RO mounts and remounts from RO to RW:

https://pastebin.com/raw/zSZjgn48

I couldn't find any regression.

Thanks.


> >   out:
> >       return ret;
> >   }
> > @@ -3383,10 +3384,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >               }
> >       }
> >
> > -     ret = btrfs_find_orphan_roots(fs_info);
> > -     if (ret)
> > -             goto fail_qgroup;
> > -
> >       fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
> >       if (IS_ERR(fs_info->fs_root)) {
> >               err = PTR_ERR(fs_info->fs_root);
