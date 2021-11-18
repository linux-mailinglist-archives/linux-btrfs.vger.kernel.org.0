Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB96456348
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 20:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhKRTSw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhKRTSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 14:18:51 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F388C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:15:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v19so6101663plo.7
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 11:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZojpOZ/BtppyWal440A5hVjBaLigPp+e6JoExU6eie0=;
        b=x5mH1VGf/L7ba00RwOQ2NyyFpFpVYhigMQvkdG5tXPwtUhDxK6+Uwm2CTOuhdYdTfS
         7unazHhAJ+4g4FPqa11/T2BhWQHkOrlBad5s0VlMCJEigMRt3HSz1mDwuqsjhpEzg/sy
         jrUnkhP9lO26TEaUUHLhSbV8gs3yYKG2UaGSFZg9gXdVjOOApztkcsFQasWbmYIZzdu0
         D6EJThIpT4cNd+wx3vpofeIfLFXIfLDgzS6m07SMnJUuhlxUxM+TmYjIhwfvssgdoV52
         ZJynlFqgOV1h3CUctGfGZk7m5bw4RwPsutg77hGdKs0jdqd6pvhxo+3g3ifTQfun7ozd
         XXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZojpOZ/BtppyWal440A5hVjBaLigPp+e6JoExU6eie0=;
        b=grI6NLXFSkMIVEkpLJ8iGzrY9Gxqj5BA1rdHeorGCFUCpqRtCTKUJAQ56Eh+w3wwVo
         2npfQLjQzUxIahFInKvwxDSIdUef3WY1odU9uWONt1wye3W1fMc32OLSGHBZHa3UvFL/
         h+pvpVCNa//27I9lJl0CpzPterAQNPWvQ0pPvUzvPrPKsNNCqeC6VyH4WiiLdfFGsJBn
         XY1uPzyJCN3qBruDZmkwn2st7nygU/5HQVRgeThKCrSXtBm52D02RSHZWLQFE3bjEHom
         xdlRJDjQYMcnMBnN7AYkvVZBmDKYi5r7mKCY5XQs6PMJDG6Pc0jrAG1Pv0QV7VQg2+xo
         Fc9w==
X-Gm-Message-State: AOAM533thVF4XuxCdWbFfFxCKkuqyiAQTeQmfUwZHxCyFd2SDtuX2ZaL
        zdZ4ZmEOWuR3VXqlrpSg6S56Cg==
X-Google-Smtp-Source: ABdhPJxn1ZA+G96VOsHiEEBPsPYZJ4eu0Hqj+KmzM5tmq4SYheS83gVzPPm17YydurUj9SIc2oV6mQ==
X-Received: by 2002:a17:90a:134f:: with SMTP id y15mr13026425pjf.158.1637262950735;
        Thu, 18 Nov 2021 11:15:50 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:174e])
        by smtp.gmail.com with ESMTPSA id p15sm326221pjh.1.2021.11.18.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:15:50 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:15:48 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 01/17] fs: export rw_verify_area()
Message-ID: <YZamZEfaCpaedir+@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <11bc0fc15490afc6ce15c405cca3e16582f2f0ec.1637179348.git.osandov@fb.com>
 <20211118145714.GG28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118145714.GG28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 03:57:14PM +0100, David Sterba wrote:
> On Wed, Nov 17, 2021 at 12:19:11PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > I'm adding Btrfs ioctls to read and write compressed data, and rather
> > than duplicating the checks in rw_verify_area(), let's just export it.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3244,6 +3244,7 @@ extern loff_t fixed_size_llseek(struct file *file, loff_t offset,
> >  		int whence, loff_t size);
> >  extern loff_t no_seek_end_llseek_size(struct file *, loff_t, int, loff_t);
> >  extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
> > +extern int rw_verify_area(int, struct file *, const loff_t *, size_t);
> 
> Do you have an ack from VFS people for exporting a function from
> fs/interna.h to the normal fs.h?

Nope, although I've sent it enough times that they should've nacked it
by now if they cared. I guess I didn't cc fsdevel on this version, so
I'll ping this patch on v11.
