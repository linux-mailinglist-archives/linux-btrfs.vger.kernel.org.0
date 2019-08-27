Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543849F1CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfH0Rom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 13:44:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42308 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfH0Rom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 13:44:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so12093704plp.9
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0m/LT6MaiTaxkRHQFuvDYc8nOV1r7xAhL1RfYFqZkl8=;
        b=uQWX7voOyxAA1I3Uhg85ecYRfN6wsrvtfucGPjFqzfSNQ4QVsrkUje7RZN4P7QjB3N
         D64p2yDKyLiJP6ydvC+pBYwPlCYopo2VQpvrTJ3r6pR/LwXheR9Hdv9xKue6dp9UcZ4p
         ngOg77qNxOj3aImsi02OsDghOLvlSuInwvtRaLzFWwryezphm3fnYnQaM7et1yqk/hii
         ixYYD0GSxUtrgUP9Jmo94yRiWdXmGIBFwpMeBNPg71hLNjSPEVkohjnGfL5tMsxpZ5ZC
         tacXv/LcJjigEo0N+EX3Ch2/ZQas1cdem3MFaE8I+kbpoVFWazWu/OWM6EKkseDSzdP1
         hAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0m/LT6MaiTaxkRHQFuvDYc8nOV1r7xAhL1RfYFqZkl8=;
        b=MN5ZI799L422nNQyOXQAiv5FLDnYA/PJdr1nMz0xn+igFp9cGJlh7YAoFY/jyirrCl
         eEuseKJ5XMgU0jrNzqNykB31MLEig6TCoCF3+/by9VLs4jcjos+9ygo4qgVdGBxYPHoS
         7KU1rrA79NqO3ydMFHgpRSNhF1Oweecjbooe4Ix0U4u1KJmwLu9/2iL9ou0DOQ/Zf/tv
         INm5v7A6+C02bSCwNVefOFF7V35YuwAFATel4y4R+c4mZ67ZBflIKKXnCSvgrcdyM7Oi
         M2XxRy1EIbrdb2nnWJR5CNyc+0S8psQSuCXrJ/l7+rYPsFQb3U2/bS+OgFfnwDrNMmcn
         esuQ==
X-Gm-Message-State: APjAAAVmPvC1/mQd1GXsriK8TgTl76sEBVNF8ybzjpZ3+q9z+uZq0rLU
        vs3fPcTaWbPLzkAt83sApKOcJQ==
X-Google-Smtp-Source: APXvYqx/iSwnaF4EBgAtqWz3+NjwIqzZtFcWb3MTUiFtJZWjPwK+3AaNHhoSBqIQxWPw3OUeAs488Q==
X-Received: by 2002:a17:902:8696:: with SMTP id g22mr104705plo.122.1566927880639;
        Tue, 27 Aug 2019 10:44:40 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:56d8])
        by smtp.gmail.com with ESMTPSA id o35sm30573pgm.29.2019.08.27.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:44:40 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:44:39 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
Message-ID: <20190827174439.GA28029@vader>
References: <cover.1565900769.git.osandov@fb.com>
 <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
 <20190827123512.GF2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827123512.GF2752@twin.jikos.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 02:35:13PM +0200, David Sterba wrote:
> On Thu, Aug 15, 2019 at 02:04:03PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In btrfs_file_write_iter(), we treat a write as synchrononous if the
> > file is marked as synchronous. However, with pwritev2(), a write with
> > RWF_SYNC or RWF_DSYNC is also synchronous even if the file isn't by
> > default. Make sure we bump the sync_writers counter in that case, too,
> > so that we'll do the CRCs synchronously.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 4393b6b24e02..27223753da7b 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1882,7 +1882,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >  	u64 start_pos;
> >  	u64 end_pos;
> >  	ssize_t num_written = 0;
> > -	bool sync = (file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host);
> > +	bool sync = iocb->ki_flags & IOCB_DSYNC;
> 
> I'd like to merge the patches 1-3, but have hard time matching the
> changelog to the change here. It's from one set of sync flags to
> another, mentioning pwritev2 but that's a syscall and the function
> itself does not use the sync flags at all. That's probably somewhere
> deep in the vfs calls but that's what I'd appreciate stated explicitly
> in the changelog as I was not able to find it out in a reasonable time.

You're right, there are a few layers here. How about this for the
changelog:


The VFS indicates a synchronous write to ->write_iter() via
iocb->ki_flags. The IOCB_{,D}SYNC flags may be set based on the file
(see iocb_flags()) or the RWF_* flags passed to a syscall like
pwritev2() (see kiocb_set_rw_flags()). However, in
btrfs_file_write_iter(), we're checking if a write is synchronous based
only on the file; we use this to decide when to bump the sync_writers
counter and thus do CRCs synchronously. Make sure we do this for all
synchronous writes as determined by the VFS.


Let me know if you want me to resend with the new changelog.
