Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072903AD3A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhFRUej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbhFRUej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 16:34:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32BC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 13:32:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e1so5279843plh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MP8s4FFElC8WWGcmncEgNlaYxzX8G52AeS2P/QyZhZo=;
        b=WEZR7yxu3aZtBimEKt/NbIirVN+tze2gPR7BKzmDq5rvITljhzyrpxGS6Cmue71CQu
         0YTMgoPv6wdS93UGdMwvVaCo0/UhuTqVYBYpfEdEabhzIdOitFwzCyG3gXxKBtZ5xGAJ
         DMRXOdLF+hgvdPBRi+eAPi5rWPzOVPDmPmGnKA67rQ1I1w6b/efcbXYXdze4tIJYWJ7Q
         oHC1Zi4GG369KYbIQ6Ii+cTQ1Hp5AgK/NC0rGBxfnsTuCXp7keOuDT4R/oRTMWpEk89O
         fp25QJo7seajIKzDyfl9SHHT/5f+ujxa/eSVfmgml5yJVjmxIGDuWwdvgKGSIvZxcWHE
         mQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MP8s4FFElC8WWGcmncEgNlaYxzX8G52AeS2P/QyZhZo=;
        b=lW8HM657MFHr4SjEnRh7GqhZki6CgacGWLzGdG0DS3WE62ctbTpHrMza98cnoJybh6
         OXEQYjiD0I4zBCVLoR7TvxaGMoR4rQaRARF+55ZNlJNfSO9k9XLLKuNLTquAvvzKx140
         +wSGHJKjZmIVSzRHnK7/Pd8+KV/NEXqXDfZMK++hlVWuw+vPb+iH/ju5b/70DDB71RWA
         FjyXpY+/zw7qqZZooltH4vDgZ78AuxtWjNYMq9a6MbsicEz9wmiA6GceWxB/5MZUp9gy
         wZFyqkVSRSj1S6tIpnomdW2fQcL+/ge8SSngSQYA8Co4o993V2R2aV4EqTt1aGyBQ0g/
         zpgQ==
X-Gm-Message-State: AOAM531v/C/D2ZO8VgWQmjgXl1d8Xv4l/7jbaL8ObfKJQjbxpCbmeC89
        iDDfQzP7daCBDopcpRX+udTiBA==
X-Google-Smtp-Source: ABdhPJy743KWZ0d0NbsuiFsT9v7KrOTXq/Ke2PmKXGT90gHHv2K6dl+2AEBChnWHajAm31QwTV/QMQ==
X-Received: by 2002:a17:902:b409:b029:114:afa6:7f4a with SMTP id x9-20020a170902b409b0290114afa67f4amr6374889plr.56.1624048348764;
        Fri, 18 Jun 2021 13:32:28 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:41cb])
        by smtp.gmail.com with ESMTPSA id 18sm8694174pfx.71.2021.06.18.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:32:28 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:32:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0C2mZfTE0uz3dq@relinquished.localdomain>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 18, 2021 at 07:42:41PM +0000, Al Viro wrote:
> On Fri, Jun 18, 2021 at 11:50:25AM -0700, Linus Torvalds wrote:
> 
> > I think that you may need it to be based on Al's series for that to
> > work, which might be inconvenient, though.
> > 
> > One other non-code issue: particularly since you only handle a subset
> > of the iov_iter cases, it would be nice to have an explanation for
> > _why_ those particular cases.
> > 
> > IOW, have some trivial explanation for each of the cases. "iovec" is
> > for regular read/write, what triggers the kvec and bvec cases?
> > 
> > But also, the other way around. Why doesn't the pipe case trigger? No
> > splice support?
> 
> Pipe ones are strictly destinations - they can't be sources.  So if you
> see it called for one of those, you've a bug.
> 
> Xarray ones are *not* - they can be sources, and that's missing here.

Ah, ITER_XARRAY was added recently so I missed it.

> Much more unpleasant, though, is that this thing has hard dependency on
> nr_seg == 1 *AND* openly suggests the use of iov_iter_single_seg_count(),
> which is completely wrong.  That sucker has some weird users left (as
> of #work.iov_iter), but all of them are actually due to API deficiencies
> and I very much hope to kill that thing off.
> 
> Why not simply add iov_iter_check_zeroes(), that would be called after
> copy_from_iter() and verified that all that's left in the iterator
> consists of zeroes?  Then this copy_struct_from_...() would be
> trivial to express through those two.  And check_zeroes would also
> be trivial, especially on top of #work.iov_iter.  With no calls of
> iov_iter_advance() at all, while we are at it...
> 
> IDGI... Omar, what semantics do you really want from that primitive?

RWF_ENCODED is intended to be used like this:

	struct encoded_iov encoded_iov = {
		/* compression metadata */ ...
	};
	char compressed_data[] = ...;
	struct iovec iov[] = {
		{ &encoded_iov, sizeof(encoded_iov) },
		{ compressed_data, sizeof(compressed_data) },
	};
	pwritev2(fd, iov, 2, -1, RWF_ENCODED);

Basically, we squirrel away the compression metadata in the first
element of the iovec array, and we use iov[0].iov_len so that we can
support future extensions of struct encoded_iov in the style of
copy_struct_from_user().

So this doesn't require nr_seg == 1. On the contrary, it's expected that
the rest of the iovec has the compressed payload. And to support the
copy_struct_from_user()-style versioning, we need to know the size of
the struct encoded_iov that userspace gave us, which is the reason for
the iov_iter_single_seg_count().

I know this interface isn't the prettiest. It started as a
Btrfs-specific ioctl, but this approach was suggested as a way to avoid
having a whole new I/O path:
https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
The copy_struct_from_iter() thing was proposed as a way to allow future
extensions here:
https://lore.kernel.org/linux-btrfs/20191022020215.csdwgi3ky27rfidf@yavin.dot.cyphar.com/

Please let me know if you have any suggestions for how to improve this.

Thanks,
Omar
