Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49467231F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jan 2023 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjARQ11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 11:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjARQ0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 11:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F7D4ED1E
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 08:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674059086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H4gPDbXgRwcEu9eRFB58g+gXi6AVjus+QHhs3v57+Uw=;
        b=i9wBzQvmS1XybTdcempgtyA58hSxQzK44qCWx+XNl5N7JoMbcYTF8oRHd8iYhehtIhacZt
        uaQHouDbK1EwkUCPEpXCgdU9PVs6UpT+ElXMeYpBDarA4AGA+lT08FPYRLK8nwcfpjWIOt
        HXgbBObo+IZ1oFWZfhwcAiP7o9Ui/0c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-7H_OICIRPvSvxiwmSnQb2w-1; Wed, 18 Jan 2023 11:24:45 -0500
X-MC-Unique: 7H_OICIRPvSvxiwmSnQb2w-1
Received: by mail-pj1-f72.google.com with SMTP id fy20-20020a17090b021400b00226f0026263so14101189pjb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 08:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4gPDbXgRwcEu9eRFB58g+gXi6AVjus+QHhs3v57+Uw=;
        b=TRLon/rwp/dO3DAt7jAkMu3wv9tA5l2+oE49JmnQuRPHcZ4b9gt1TbgO79KBa1XQtb
         v0O+MK9z8ZvFJaKssqhMFFuHKxwfWprzf0OixveCUaQClwxJg7xheehG0siWDryM4X3A
         VLRj5NxLYtVf9OXAAigISPWUh/Jkya3QcR/e/JiGDtFzw/P0t84U2fPc0wH6foLj4x8/
         QOdIp0jPfWhnA/yQOO2PksUoIhyLRczg69H0zlZtX+GvqTszyVXy7x6R/0z9T3TxVgUK
         9Z5TBOBa+8Z3w2iWdZPmGmumxsSBx9W0x15/uvOF3HykDgauq9xAKKkF8LL2x0/cATkx
         lPug==
X-Gm-Message-State: AFqh2kriF6d8i9jem0YjpHGUgr3i/znCbggUOXLxpXofKCD+ehkUNJSr
        C/3Z1ODq9/N9zYQDwOayL3TBAEnaOD41sxM8XSkS0K/FBbhZEdDycmfyB16tJBY/+HuUOP0kr9w
        yuUpZZiWo3RVFpsnZWxTJfszKmvHZ+AbgujU9rcM=
X-Received: by 2002:a63:5849:0:b0:478:eb77:b104 with SMTP id i9-20020a635849000000b00478eb77b104mr618318pgm.236.1674059084729;
        Wed, 18 Jan 2023 08:24:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtvkaGNY8lVgDyNm0tuarLhfWyFgPfPp/0vXS/hCHoGVIWXwNRYT3XKDintDuiBfiXwyin720mSswN72fFwbPw=
X-Received: by 2002:a63:5849:0:b0:478:eb77:b104 with SMTP id
 i9-20020a635849000000b00478eb77b104mr618307pgm.236.1674059084379; Wed, 18 Jan
 2023 08:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20230118094329.9553-1-hch@lst.de> <20230118094329.9553-8-hch@lst.de>
 <Y8gXodKIUneO+XQb@casper.infradead.org>
In-Reply-To: <Y8gXodKIUneO+XQb@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 18 Jan 2023 17:24:32 +0100
Message-ID: <CAHc6FU7Exz2kr+x7jvK1mi5ENOVCOXruP7qKSdPsyhSwmfMhDA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 7/9] gfs2: handle a NULL folio in gfs2_jhead_process_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Christoph's email ended up in my spam folder; I hope that was a
one-time-only occurrence.]

On Wed, Jan 18, 2023 at 5:00 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jan 18, 2023 at 10:43:27AM +0100, Christoph Hellwig wrote:
> > filemap_get_folio can return NULL, so exit early for that case.
>
> I'm not sure it can return NULL in this specific case.  As I understand
> this code, we're scanning the journal looking for the log head.  We've
> just submitted the bio to read this page.  I suppose memory pressure
> could theoretically push the page out, but if it does, we're doing the
> wrong thing by just returning here; we need to retry reading the page.
>
> Assuming we're not willing to do the work to add that case, I think I'd
> rather see the crash in folio_wait_locked() than get data corruption
> from failing to find the head of the log.
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/gfs2/lops.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > index 1902413d5d123e..51d4b610127cdb 100644
> > --- a/fs/gfs2/lops.c
> > +++ b/fs/gfs2/lops.c
> > @@ -472,6 +472,8 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
> >       struct folio *folio;
> >
> >       folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
> > +     if (!folio)
> > +             return;

We're actually still holding a reference to the folio from the
find_or_create_page() in gfs2_find_jhead() here, so we know that
memory pressure can't push the page out and filemap_get_folio() won't
return NULL.

> >
> >       folio_wait_locked(folio);
> >       if (folio_test_error(folio))
> > --
> > 2.39.0
> >
>

Thanks,
Andreas

