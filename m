Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167292DBF07
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgLPKxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgLPKxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 05:53:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4BC06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 02:52:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12so1284314pjn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WNsYL69TRS9t0c21cdI0023eDY+f8eYdfXEtxSEeEbg=;
        b=I+RpAWjrPimHSq2v2YC0L/mT93DBFtJCMt0qO1LYhCxBnySi/RZ3/UH+EktRnZ0ze9
         qYchuvvTxl8YFYC68CbKEOz22JIRJus5h23heCAa1F18HU2dOEm9KbFZNprw9pqr4CcO
         +cJe7/aox3Ef5aFpxOEwAzeCn2Zo5e5QVDQr6ed/30hmO/Vy4v3HZEoKR0W8oQw54uyO
         su7JObedSgVhf5lx9x5de+QOTrOOYgQLLriQspfG/5VIqNKWT7FZrhLAxO3paOB21K37
         e2m4J6ezfDrVtMQQuGpjVwT3jwd5aKjWHr7Q1hpgspyNOtorKjyYKYGieycZ6nloxh4E
         bPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WNsYL69TRS9t0c21cdI0023eDY+f8eYdfXEtxSEeEbg=;
        b=Dkrk4vXvn4H+rMmGQKpN5CR7MtL0xuBc7sJjELKRDxdvDwY8DNnwmskQikf9JCARMs
         RipOvzaB6vo58vttVNzEZHcG9iEIPAgrC4lZZAfJRMzZxqZnQP7ejnExs9cngkEXRcdl
         qCX9J6ZZ4qg+p0ILNpDx7kApfvSOZ364NU4WeRemkNhfufZabEa8Ds/yCHtWewoUAQp0
         NSLG9cJpPYSfM2ZcQYXP7qpF8E5paAOqqtYF1h1RUz5GUExZNHrCpwFZNwB1noMWkcca
         F8n8atWXmOXL3lGYPcXMVTn7vabDWPkV18KrVxRpZSpkH5GYJ214tRA2xHC3+0o8Ckkz
         bUwQ==
X-Gm-Message-State: AOAM532DJHvVet8+kO7M7hGpCkL5lvdTFlXzK9YGsNRcSRQigSmidvai
        DYlt5FtLTiTSksUc+HfmP2owdG6yjldpDA==
X-Google-Smtp-Source: ABdhPJxxHHTHBgRplNREQ795OIve/W0KqLUPWZbX4Yq8yjF4paBxib1HrodsaBiPW98N1YX7mVcWbQ==
X-Received: by 2002:a17:902:9307:b029:d9:d097:fd6c with SMTP id bc7-20020a1709029307b02900d9d097fd6cmr6079794plb.10.1608115941227;
        Wed, 16 Dec 2020 02:52:21 -0800 (PST)
Received: from realwakka ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id i37sm2199908pgi.46.2020.12.16.02.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 02:52:20 -0800 (PST)
Date:   Wed, 16 Dec 2020 10:52:11 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Su Yue <damenly.su@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201216105203.GA14127@realwakka>
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
 <20201211173025.GO6430@twin.jikos.cz>
 <20201211174629.GQ6430@twin.jikos.cz>
 <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABnRu57w3aw=jPBbpSNYfyRKxs1z7onwWzqjg+=r6jQjwNYUXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 02:30:04PM +0800, Su Yue wrote:
> On Sat, Dec 12, 2020 at 3:04 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Fri, Dec 11, 2020 at 06:30:25PM +0100, David Sterba wrote:
> > > On Fri, Dec 11, 2020 at 04:48:12PM +0000, Sidong Yang wrote:
> > > > Example json format:
> > > >
> > > > {
> > > >   "__header": {
> > > >     "version": "1"
> > > >   },
> > > >   "device-stats": [
> > > >     {
> > > >       "device": "/dev/vdb",
> > > >       "devid": "1",
> > > >       "write_io_errs": "0",
> > > >       "read_io_errs": "0",
> > > >       "flush_io_errs": "0",
> > > >       "corruption_errs": "0",
> > > >       "generation_errs": "0"
> > > >     }
> > > >   ],
> > >      ^
> > >
> > > I've verified that the comma is really there, it's not a valid json so
> > > there's a bug in the formatter. To verify that the output is valid you
> > > can use eg. 'jq', simply pipe the output of the commadn there.
> > >
> > >   $ ./btrfs --format json dev stats /mnt | jq
> > >   parse error: Expected another key-value pair at line 16, column 1
> >
> > I've pushed the updated plain text formatting to devel, so the only
> > remaining bug is the above extra comma.
> 
> Another format bug(one extra newline):
> ========================================
> ➜  btrfs-progs git:(314d96c8)  btrfs device stats /mnt
> [/dev/mapper/test-1].write_io_errs    0
> [/dev/mapper/test-1].read_io_errs     0
> [/dev/mapper/test-1].flush_io_errs    0
> [/dev/mapper/test-1].corruption_errs  0
> [/dev/mapper/test-1].generation_errs  0
> 
> ➜  btrfs-progs git:(314d96c8)
> ========================================
> The new line is printed by the change:
> '+       fmt_end(&fctx);'
> 
> and fstests/btrfs/006 fails:
> ================================================================================
> btrfs/006 1s ... - output mismatch (see
> /root/xfstests-dev/results//btrfs/006.out.bad)
>     --- tests/btrfs/006.out     2020-12-16 03:40:19.632039261 +0000
>     +++ /root/xfstests-dev/results//btrfs/006.out.bad   2020-12-16
> 06:25:56.424424113 +0000
>     @@ -15,12 +15,14 @@
> 
>      == Sync filesystem
>      == Show device stats by mountpoint
>     + 1
>      <NUMDEVS> [SCRATCH_DEV].corruption_errs <NUM>
>      <NUMDEVS> [SCRATCH_DEV].flush_io_errs <NUM>
>      <NUMDEVS> [SCRATCH_DEV].generation_errs <NUM>
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/btrfs/006.out
> /root/xfstests-dev/results//btrfs/006.out.bad'  to see the entire
> diff)
> Ran: btrfs/006
> Failures: btrfs/006
> Failed 1 of 1 tests
> ================================================================================
> 
> The new line made filter produce the '+1'.

Thanks for testing this patch.
I checked the fmt_end() and there is an additional newline.
I think that fmt_end() should be used for formatting. so it seems that
the only way to fix this problem is to remove the code that inserts a
newline in fmt_end(). I searched the code that use the function and
there is no code that used this function but this patch. Do you have any
ideas?

Thanks,
Sidong
