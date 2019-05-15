Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA1B1F6CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEOOpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 10:45:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35866 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEOOpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 10:45:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so109326vsp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=s01ovO8P1TGhBYJQpuBWPchjN+k0qbM8AeIt8OwXGlI=;
        b=IX3iJ7K55BPXLicrK9fOQ29FWrQXfKjMJTbt0KQxXCHNPQucSJNxCTsU7OCZc3JnDm
         8J7xXcgjEGD8NHewMjyiF0VhDhHkskSvadJ+r/HOaYjXLnLa4ZSB/3BBP89KK5LkN4wx
         YAXZeXk2NXeGgPTHB4lOBZzqBvMzbVXFLQD9GAHW/HjjTIuRB5fCXGqbOSyQ7toZ2B7k
         05ZtbbGiBr5u9GRV6L5AtCn/jJOd113PGD/TqNDWwGTcIuLL3hZ0/mU9hOd3i1SvReJz
         B9j0R8deRN+2twlIFIjABKCZdIVLFQiDBBUYQCQXlYWPU/rC0+HvzdyE8hn9GH3FD3NL
         x0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=s01ovO8P1TGhBYJQpuBWPchjN+k0qbM8AeIt8OwXGlI=;
        b=ExGR7DTXzQLIFbxDCBFjVnwJab67akt3FFdT0Hc+UqOfuniknaQw6+MrrO4C+m7I9/
         QZg3v+vZUtbaWWE70Tf775/7HB38KPAw/CBKi0y558icGdfxc8howgnvUEQeJg4AaDdL
         zF2zvsDB8i91h+vMCwb33r+OaGjGg/C3IX3rPRMhlnsdAday01ECg3iOt/3xSEJIIV/g
         rS9gR02NnQEaDaFkXkT7tRhusHkDLO7clcnaV795bofKOPy6dhuh35oDETd74/6DLMZa
         xSsXOG3UcQsli/HFKiQ+pyMYkaCZ5SztL3NFYX6VVrbdj2hdCDetSICr7h7Q7Khw14Il
         U5KA==
X-Gm-Message-State: APjAAAWT/FMuw8zltPMp6RJ9z9LIjrnrPcl1B3A4t/iLzSPqpNFVzmtH
        ZcWAkGr9WB8taBrxsJqJv7HiRHj7QNnbg9hkHX0=
X-Google-Smtp-Source: APXvYqwCqDHJHdgjV7FCHA0YcNqD5+URe9YnWjTl5+4C+CLuwPdSlJIx3BjzcOfnIvXT7UKPJCDBG/fRusK4b75kXeY=
X-Received: by 2002:a67:8b44:: with SMTP id n65mr6901120vsd.99.1557931524499;
 Wed, 15 May 2019 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190402180956.28893-1-jeffm@suse.com> <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com> <20190515141605.GQ3138@twin.jikos.cz>
In-Reply-To: <20190515141605.GQ3138@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 May 2019 15:45:13 +0100
Message-ID: <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
To:     dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 15, 2019 at 3:15 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Apr 03, 2019 at 10:38:09PM -0400, Jeff Mahoney wrote:
> > On 4/2/19 3:19 PM, Filipe Manana wrote:
> > > On Tue, Apr 2, 2019 at 7:29 PM <jeffm@suse.com> wrote:
> > >>
> > >> From: Jeff Mahoney <jeffm@suse.com>
> > >>
> > >> When repairing the extent tree, it's possible for delayed extents to
> > >> be created when running btrfs_write_dirty_block_groups.  We run
> > >> delayed refs one last time in the kernel but that is missing in
> > >> the userspace tools.
> > >>
> > >> That results in delayed refs getting dropped on the floor, the exten=
t
> > >> records not getting created, and in the next tranaction, when the
> > >> extent tree is CoW'd again, we hit the BUG_ON when we can't find
> > >> the extent record.
> > >>
> > >> We can fix this by running the delayed refs after writing out the
> > >> dirty block groups.
> > >>
> > >> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> > >> ---
> > >>  transaction.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/transaction.c b/transaction.c
> > >> index e756db33..2f19e9c8 100644
> > >> --- a/transaction.c
> > >> +++ b/transaction.c
> > >> @@ -194,6 +194,8 @@ commit_tree:
> > >>         ret =3D btrfs_run_delayed_refs(trans, -1);
> > >>         BUG_ON(ret);
> > >>         btrfs_write_dirty_block_groups(trans);
> > >> +       ret =3D btrfs_run_delayed_refs(trans, -1);
> > >> +       BUG_ON(ret);
> > >
> > > And running delayed refs can dirty more block groups as well.
> > > At this point shouldn't we loop running delayed refs until no more
> > > dirty block groups exist? Just like in the kernel.
> >
> > Right.  This is another argument for code sharing between the kernel an=
d
> > userspace.
>
> Sharing code in this function would be really hard, I've implemented the
> loop in commit in progs.

Shouldn't the new patch version be sent to the list for review?
It doesn't seem to be a trivial change on first through.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
