Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B113F3248
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhHTRcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhHTRcR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 13:32:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AEC061756
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 10:31:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so7742034pjb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hausAV75QDfnkXVBVC/RcV475eLvboVMKfHjcdo1TZ0=;
        b=p+XcEkMrdKp6ZS4EVumBBINKww5sw0P4gqnLC5q56jK1VfTqgDaRo1rsqLhwZvydLw
         5j8ppl+MaJcNf43LfLSHPMsJURSRtzZmIYZMhlcAXpsM+ALjlrlhZyOhmCqnIwULb4xF
         6yB3AEhV8cNVUgog4kzuADIS52L84AP+ZgjY6nnwj49NJp2TWjfq1hIPOs54Zu4GK/0j
         oQ3r044con7YQA1FzGM/0pzLB4Ji/kZlKoTbVdMov7ITDwDjCNQpmYadoCr/Wk0w6Rf+
         4i7ohJDZb6Dkw1ZOo4fVGmvj3D4P5JbDUioQ5PBaAHkVrP0QzFI2RKijvZzoF13KctNC
         P/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hausAV75QDfnkXVBVC/RcV475eLvboVMKfHjcdo1TZ0=;
        b=oIfm7XLC9GoikfpWDAzocjagyTqDF1qMLQm9OsR9DpZ8kPKr/enrMJAgKetgxm5XdW
         iWJMOW6mX6Qml6Mc0h/BWFPNusEhj7NKbIZIzWuqbpbTHsUgS+nk6aCAmhxio+fWRuLq
         3JJUhsbJX4wzzgOEJWKML165EygEvPYcRJ8Wy0Qav7V6T7Lp7aYY3fw0sgdUjKHceWm/
         NPTL8OdKD/mrpTtC2y3iP5VLNM1M48B8AoRyhT0bJbO1M23wWgfdE2Vj51Imku8J0cIZ
         qVHSW2LWPGN/jjF9H8qKBFeQFtOUdOwy6O5i1YnH2t6dCqI+AARYz3eeNHGt3JVTC4Xw
         p5EQ==
X-Gm-Message-State: AOAM530UuuyzbvPYFaBGny7SIFPgeWP35t2rnF6pHoEPRHK9fR21Kl2N
        AUhIuGcN2wo1nQw+5ll18FRQlQ==
X-Google-Smtp-Source: ABdhPJxb423S2zbhxthqfJoLTc1GUl5giKYxZDtIxjcBC593fYLmbufbC2vlgZ0rQ8f42OskIWu8Bw==
X-Received: by 2002:a17:902:e891:b0:12d:97bf:b2d8 with SMTP id w17-20020a170902e89100b0012d97bfb2d8mr17144006plg.84.1629480698614;
        Fri, 20 Aug 2021 10:31:38 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id b15sm8763070pgj.60.2021.08.20.10.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:31:37 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:31:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 02/14] fs: export variant of generic_write_checks
 without iov_iter
Message-ID: <YR/m+IxihIBGm6Ps@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <237db7dc485834d3d359b5765f07ebf7c3514f3a.1629234193.git.osandov@fb.com>
 <ae6f8c7e-3b9b-bd95-140d-b556ce04df8f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae6f8c7e-3b9b-bd95-140d-b556ce04df8f@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 10:59:28AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Encoded I/O in Btrfs needs to check a write with a given logical size
> > without an iov_iter that matches that size (because the iov_iter we have
> > is for the compressed data). So, factor out the parts of
> > generic_write_check() that expect an iov_iter into a new
> > __generic_write_checks() function and export that.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/read_write.c    | 40 ++++++++++++++++++++++------------------
> >  include/linux/fs.h |  1 +
> >  2 files changed, 23 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 0029ff2b0ca8..3bddd5ee7f64 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1633,6 +1633,26 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
> >  	return 0;
> >  }
> >  
> > +/* Like generic_write_checks(), but takes size of write instead of iter. */
> > +int __generic_write_checks(struct kiocb *iocb, loff_t *count)
> > +{
> > +	struct file *file = iocb->ki_filp;
> > +	struct inode *inode = file->f_mapping->host;
> > +
> > +	if (IS_SWAPFILE(inode))
> > +		return -ETXTBSY;
> 
>  Missing 'if(!count) return 0' from original code ?

Good catch, thanks.
