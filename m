Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4F1AE3C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgDQR0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:26:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728667AbgDQR0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587144372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDAN40yeguM7zJx98CdNUetg8184ljZinxF3eiulLV8=;
        b=H+r+DBWg0JawVwmqYogyjNQwotAT9Nft0lHh06v7tbnipaLWC12jwj82ZfNFYrwhW+1Aw6
        gwG3Ti4s3Jsd9X2bz10Sg+3Iw6lmuAJJg1L5XvsAplwvgLyHA65JNqpMkHvDKFyb8ejOsT
        qrrkVdw2X0klDdLTi6HwMwUkL6Gl5BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Zq3WiIGgOpe_EMB3g6_iTw-1; Fri, 17 Apr 2020 13:26:10 -0400
X-MC-Unique: Zq3WiIGgOpe_EMB3g6_iTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFAB107ACC7;
        Fri, 17 Apr 2020 17:26:09 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BF2318A85;
        Fri, 17 Apr 2020 17:26:08 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:26:06 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/4] fsx: add missing file size update on zero range
 operations
Message-ID: <20200417172606.GF13463@bfoster>
References: <20200408103552.11339-1-fdmanana@kernel.org>
 <20200417171020.GB13463@bfoster>
 <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 06:20:24PM +0100, Filipe Manana wrote:
> On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When a zero range operation increases the size of the test file we were
> > > not updating the global variable 'file_size' which tracks the current
> > > size of the test file. This variable is used to for example compute the
> > > offset for a source range of clone, dedupe and copy file range operations.
> > >
> > > So just fix it by updating the 'file_size' global variable whenever a zero
> > > range operation does not use the keep size flag and its range goes beyond
> > > the current file size.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  ltp/fsx.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 9d598a4f..fa383c94 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
> > >       }
> > >
> > >       end_offset = keep_size ? 0 : offset + length;
> > > +     if (!keep_size && end_offset > file_size)
> > > +             file_size = end_offset;
> >
> > Should this ever happen if the caller uses TRIM_OFF_LEN() on the
> > offset and length?
> 
> TRIM_OFF_LEN only trims the range, not the file_size.
> Or did I miss something?
> 

Right, but TRIM_LEN() does:

        if ((off) + (len) > (size))             \                               
                (len) = (size) - (off);         \

... where size is file_size. Hm?

Brian

> Thanks.
> 
> >
> > Brian
> >
> > >
> > >       if (end_offset > biggest) {
> > >               biggest = end_offset;
> > > --
> > > 2.11.0
> > >
> >
> 

