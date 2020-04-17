Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB01AE408
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgDQRsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:48:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729736AbgDQRsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587145682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Izss2Wk8c6NbM+6CCqaR7BeWdE4zePhdLqBUnnGLKCY=;
        b=ZboNNoo8e/6LPJ/2OPZsTKpPV7Q4K+qtJoReWBXioBA5de1M8O0NNbwr0hvWmttDr0x07o
        0949x6TZeZD8wxMbSMhD9cb7Cg5WDRV0SnbE8Qg4MyyGJudvywVeFBGRi7BsfYtZQBXNyk
        npwzFhdMUiB3/h4we3i1DrpFZcOmLoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-u7aSPfCZPlutmdMKi_swWQ-1; Fri, 17 Apr 2020 13:47:56 -0400
X-MC-Unique: u7aSPfCZPlutmdMKi_swWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751EC107ACC7;
        Fri, 17 Apr 2020 17:47:55 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C16F060BE0;
        Fri, 17 Apr 2020 17:47:54 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:47:52 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/4] fsx: add missing file size update on zero range
 operations
Message-ID: <20200417174752.GG13463@bfoster>
References: <20200408103552.11339-1-fdmanana@kernel.org>
 <20200417171020.GB13463@bfoster>
 <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
 <20200417172606.GF13463@bfoster>
 <CAL3q7H5YSrV6Z+aB=ncSQiUfbACWgMArVRB9xu0Dhx0mTp3bZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5YSrV6Z+aB=ncSQiUfbACWgMArVRB9xu0Dhx0mTp3bZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 06:32:03PM +0100, Filipe Manana wrote:
> On Fri, Apr 17, 2020 at 6:26 PM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Fri, Apr 17, 2020 at 06:20:24PM +0100, Filipe Manana wrote:
> > > On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
> > > >
> > > > On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > When a zero range operation increases the size of the test file we were
> > > > > not updating the global variable 'file_size' which tracks the current
> > > > > size of the test file. This variable is used to for example compute the
> > > > > offset for a source range of clone, dedupe and copy file range operations.
> > > > >
> > > > > So just fix it by updating the 'file_size' global variable whenever a zero
> > > > > range operation does not use the keep size flag and its range goes beyond
> > > > > the current file size.
> > > > >
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > ---
> > > > >  ltp/fsx.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > index 9d598a4f..fa383c94 100644
> > > > > --- a/ltp/fsx.c
> > > > > +++ b/ltp/fsx.c
> > > > > @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
> > > > >       }
> > > > >
> > > > >       end_offset = keep_size ? 0 : offset + length;
> > > > > +     if (!keep_size && end_offset > file_size)
> > > > > +             file_size = end_offset;
> > > >
> > > > Should this ever happen if the caller uses TRIM_OFF_LEN() on the
> > > > offset and length?
> > >
> > > TRIM_OFF_LEN only trims the range, not the file_size.
> > > Or did I miss something?
> > >
> >
> > Right, but TRIM_LEN() does:
> >
> >         if ((off) + (len) > (size))             \
> >                 (len) = (size) - (off);         \
> >
> > ... where size is file_size. Hm?
> 
> That only updates the range's length, not the file_size.
> 

Yes, but it caps the range to within file_size.

> Also, if you check the global style, you'll see that in the function
> for every operation that can change file size we do update file_size
> explicitly (e.g. do_preallocate(), and we call TRIM_OFF_LEN before
> calling it as well).
> 

do_preallocate() (fallocate) passes maxfilelen instead of file_size, as
does write and mapwrite. Insert range uses TRIM_LEN() directly but also
passes maxfilelen.

Brian

> Thanks.
> 
> >
> > Brian
> >
> > > Thanks.
> > >
> > > >
> > > > Brian
> > > >
> > > > >
> > > > >       if (end_offset > biggest) {
> > > > >               biggest = end_offset;
> > > > > --
> > > > > 2.11.0
> > > > >
> > > >
> > >
> >
> 

