Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E238E1F38D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFIK5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgFIK5X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 06:57:23 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A75207C3
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591700242;
        bh=SrcUfnVMah+twTQVEo/DG4WVli2h/AvPgxBmmrY0xow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ubnspg/HZafz7+SjRC35QGAlri9LmEhq8oIYPqJGrKHjEOYjozhos0GJA25/rRGzS
         d3Gr1ng0inmy8FvBiCXSTBTSWhq8WKKMu2XUTUPkjTZxBv/HqzlbqYBnF4/MseW2Hv
         ZMoSXNoOiXyxnXm2hr5YBicmj1oQBDkdN4K3yvl8=
Received: by mail-vs1-f49.google.com with SMTP id q2so11652806vsr.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jun 2020 03:57:22 -0700 (PDT)
X-Gm-Message-State: AOAM5332/yUJBgnMLkQMacR6bPWVa3YdI3PC2YD7fdjiMR1TwaaN8xPa
        qFO3y/o2JsjvWBNrTGGPQ9Gypu9M0uEIJAWIyZk=
X-Google-Smtp-Source: ABdhPJzXPfuTcNcoGPKnVKLaxMxwy+D0IWJw6rNmQXaeLijda2G4zlwbb0iEOfXHaXPItIRnmY6W3hYnyOEwvdSq9xY=
X-Received: by 2002:a67:407:: with SMTP id 7mr2163348vse.95.1591700241386;
 Tue, 09 Jun 2020 03:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200609101953.29559-1-fdmanana@kernel.org> <b7c4a96d-df7c-b0b5-d1c5-aff5c458b032@suse.com>
In-Reply-To: <b7c4a96d-df7c-b0b5-d1c5-aff5c458b032@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 9 Jun 2020 11:57:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6zqxy_8=4vmYH_4mzi_M=tMXj5+0DE9a-KEjkry1V_xQ@mail.gmail.com>
Message-ID: <CAL3q7H6zqxy_8=4vmYH_4mzi_M=tMXj5+0DE9a-KEjkry1V_xQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Btrfs: only allocate necessary space when relocating
 a data block group
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 9, 2020 at 11:50 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 9.06.20 =D0=B3. 13:19 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When relocating a data block group we group extents from the block grou=
p
> > into a cluster and when the cluster reaches a certain number of extents
> > we do the relocation.
>
> We don't reserve more space because the cluster is guaranteed to contain
> contiguous extents, namely in relocate_data_extent we have:
>
> if (cluster->nr > 0 && extent_key->objectid !=3D cluster->end + 1)
> {
>    ret =3D relocate_file_extent_cluster(inode, cluster);
>    if (ret)
>       return ret;
>    cluster->nr =3D 0;
> }
>
> Cluster->end points to the end offset of the last added extent and the
> check above ensures that the one which is currently added is also
> contiguous. So relocate_file_extent_cluster is always called with
> contiguous range of data extents, which might actually be less than
> MAX_EXTENTS.
>
> As a matter of fact this is a rather hard requirement since
> prealloc_file_extent_cluster assumes that since when it iterates the
> extents in the cluster it does:
>
> if (nr + 1 < cluster->nr)
>
>    end =3D cluster->boundary[nr + 1] - 1 - offset;
>
> else
>
>    end =3D cluster->end - offset;
>
> If those extents weren't contiguous we'd be preallocating more space in
> the data reloc inode.

Yes, thanks.
I was biased by the gap detection at prealloc_file_extent_cluster()
and missed that, which in this case can't happen.

So lets drop this.
