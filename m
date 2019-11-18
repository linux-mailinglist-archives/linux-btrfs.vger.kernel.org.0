Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA426100B6F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 19:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRS1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 13:27:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40715 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRS1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 13:27:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so10245031plt.7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PQArg8ii+d7jcay/LVYm/vjuhGZ8e1nmI8CbJlMaR7Y=;
        b=ki370t77YFqBFau5o+ekErLMolLm/itaeTKqf2qIocuR1hhX6N9Q+2CLqULFeIHCNt
         BceRX15oj6ueXCIdyw1qoiXb/iExpRKolS9zu1twfKFabsHUpRRIyUFfqHVObIXdvZBI
         hGK1TbUoXW7Y67kBtX6GH/uM4u1mPSGWuzuEtFpueS5y2rcBwol6Xo3bf2nSXVLlm/Vm
         ykATJ37O7+2iua/px/WDWrooP/3V1+OjNBn5onwNqONewxY6wf6LneTTWj7rw9APk+LQ
         IOSkNaKZ9ERX9IGfmaGS34ApxQHxXtnbZLp4U8nv9qdqAVdgUouLb5c5Wd1LpZj1mrs9
         0Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PQArg8ii+d7jcay/LVYm/vjuhGZ8e1nmI8CbJlMaR7Y=;
        b=We26kpZ4s7wEl/7ZGxtMzHPXFxVhvOMC+tr/AdmEwUdmxGd8onWxbZK+/q2zTojOGG
         uzJeNrCVHwQfzfW/gu/TA2CM6D3w2YdhvfCpe1BE38cUVYNSqljIMN6JEAmPgkXggLEQ
         CsR49jSDnpQxrXdnni+ISrFkb9CUa038/siEn2z2fjD12h7tulX2iOSL9GH1ubwEce0t
         gHiJ1GbkOsoDluElvLfYx/4O7TbBbmRXt50nNtSi4TOVVAUandwhHZNKeCJpw5gk5rSN
         h5J+OnHC+/AjoQw1YdvwzFqj01X4imWj7vSF41XVYJlqtM5/pNL9vBViNDZvDs5XRrxf
         zTPw==
X-Gm-Message-State: APjAAAUwFe+uwJJjRtAn51+eoPUZ2iRkH0oHZBMDfyHxNEIxrr5QIQpJ
        9mo4jvpzxWtzBukr1sLj+2OjE3ncRBA=
X-Google-Smtp-Source: APXvYqwlaLfdvCLG9Mr96h1yd1wRMHq/VeCH+NxHgFqRvrzxP9DdDAu043CHyVRuU2qr4SaWmC317w==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr467104pjb.118.1574101665460;
        Mon, 18 Nov 2019 10:27:45 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2:1faa])
        by smtp.gmail.com with ESMTPSA id x2sm21088563pfn.167.2019.11.18.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:27:44 -0800 (PST)
Date:   Mon, 18 Nov 2019 10:27:42 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: Compiling warning fixes for devel branch
Message-ID: <20191118182742.GA215993@vader>
References: <20191118063052.56970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118063052.56970-1-wqu@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 02:30:48PM +0800, Qu Wenruo wrote:
> We have several compiling errors, in devel branch.
> One looks like a false alert from compiler, the first patch will
> workaround it.
> 
> 3 warning from libbtrfsutils are due to python3.8 changes.
> Handle it properly by using designated initialization, which also saves
> us quite some lines.
> 
> Qu Wenruo (4):
>   btrfs-progs: check/lowmem: Fix a false alert on uninitialized value
>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
>     BtrfsUtilError_type
>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
>     QgroupInherit_type
>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
>     SubvolumeIterator_type
> 
>  check/mode-common.c             |  2 +-
>  libbtrfsutil/python/error.c     | 49 ++++++++-------------------------
>  libbtrfsutil/python/qgroup.c    | 43 ++++++-----------------------
>  libbtrfsutil/python/subvolume.c | 44 ++++++-----------------------
>  4 files changed, 30 insertions(+), 108 deletions(-)

Thanks for fixing the libbtrfsutil parts. For some reason, the
convention for Python C extensions is to not use designated
initializers, but after this breakage it's definitely safer to use them.

I guess Dave already merged these, but FWIW,

Reviewed-by: Omar Sandoval <osandov@fb.com>
