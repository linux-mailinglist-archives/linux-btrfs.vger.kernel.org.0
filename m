Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5924102DA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 21:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSUi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 15:38:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34746 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKSUi4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 15:38:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id h13so12479275plr.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n8qHMJYBjsnht/dnrmnlZnqqeqVm3VZYc7Onx50ecYM=;
        b=EUcrEAIyuOcleHSoe+CUggAZXkd9+iNXSFTM+j+gPGe7PgZsIMMIwH+TvjysTXCCFv
         DBsA9cNj03fz8nBuhOG/fjaBWtuzKFxPr0K/gBjJU+sXrxHmfOiGYcnAAmomyWVFjuY6
         CjR7TOTawRWN5d3bgNP4A7iYb+Y/UaQk5ntm7qVqre/v0g9I0EIzeRTj9MVhmv4Gc8TN
         oGcc4StfhdAqWWPz1t6OS+3nhpZzMp7jP4uSkDME3HJb3038cj8iTr7J7L2d5I2YfX+b
         pk8KQRZnoZBbrBxUHCvvGYMRJNXeQrAeAIWjA99B7NdrG5evPSbbrZPjWRcQtL2HwblN
         ZH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n8qHMJYBjsnht/dnrmnlZnqqeqVm3VZYc7Onx50ecYM=;
        b=jWwNm11JZzqlhQ+fzDhgZBQINxHNJrxjD4ba/ea3eePRYK1OnTpdEsYvz12K07l5dc
         7fjdBrZC9mvqtt4SiDEJc37Kvi+WCLSCOhzX7yy5VEzaJiNxT0iaP9sxeRjkgMHQ5yAg
         Cuz0ad5uJc0cKlRn6F2GIQck51aVqPIfYGrDJMNpAZI9UUP8IW7+1L/rLgkMwpIXGKFi
         FfebcnwM6oPrYGhbqT/bvPzMdnwmlwpAGzMIjZdgdTEQaE38WN5vdQju6qalsVqMZdx/
         vtP6wq4IXMgOVkgKqph0+nCJWki7IlqMZ35w+fCNBAFR+/6qq1U1+QcAafk++QYxhnCO
         I9hA==
X-Gm-Message-State: APjAAAW5ogWmjJh1dapg35vPkzTItuW4xZZytXex4f8zm6DfQ3ue+tLi
        OWYtnIx2Je/hgki2m6EjUhcE4g==
X-Google-Smtp-Source: APXvYqwSuhsR9fojswJqLa49cEPlJon4NcdAGb6g88Fv7Q4JCoyyF3jhbukW83C8Sr9R5cxG3tZjaw==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr9097850plt.164.1574195934251;
        Tue, 19 Nov 2019 12:38:54 -0800 (PST)
Received: from vader ([2620:10d:c090:200::c83f])
        by smtp.gmail.com with ESMTPSA id 13sm25290825pgu.53.2019.11.19.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:38:53 -0800 (PST)
Date:   Tue, 19 Nov 2019 12:38:52 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu WenRuo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs-progs: Compiling warning fixes for devel branch
Message-ID: <20191119203852.GA260588@vader>
References: <20191118063052.56970-1-wqu@suse.com>
 <20191118182742.GA215993@vader>
 <a4509699-27c0-d70a-fe6f-033e20d8219e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4509699-27c0-d70a-fe6f-033e20d8219e@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 11:47:41PM +0000, Qu WenRuo wrote:
> 
> 
> On 2019/11/19 上午2:27, Omar Sandoval wrote:
> > On Mon, Nov 18, 2019 at 02:30:48PM +0800, Qu Wenruo wrote:
> >> We have several compiling errors, in devel branch.
> >> One looks like a false alert from compiler, the first patch will
> >> workaround it.
> >>
> >> 3 warning from libbtrfsutils are due to python3.8 changes.
> >> Handle it properly by using designated initialization, which also saves
> >> us quite some lines.
> >>
> >> Qu Wenruo (4):
> >>   btrfs-progs: check/lowmem: Fix a false alert on uninitialized value
> >>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
> >>     BtrfsUtilError_type
> >>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
> >>     QgroupInherit_type
> >>   btrfs-progs: libbtrfsutil: Convert to designated initialization for
> >>     SubvolumeIterator_type
> >>
> >>  check/mode-common.c             |  2 +-
> >>  libbtrfsutil/python/error.c     | 49 ++++++++-------------------------
> >>  libbtrfsutil/python/qgroup.c    | 43 ++++++-----------------------
> >>  libbtrfsutil/python/subvolume.c | 44 ++++++-----------------------
> >>  4 files changed, 30 insertions(+), 108 deletions(-)
> > 
> > Thanks for fixing the libbtrfsutil parts. For some reason, the
> > convention for Python C extensions is to not use designated
> > initializers, but after this breakage it's definitely safer to use them.
> > 
> > I guess Dave already merged these, but FWIW,
> > 
> > Reviewed-by: Omar Sandoval <osandov@fb.com>
> > 
> A small question inspired by this bug, but not specific to btrfs.
> 
> Does this mean each big python upgrade makes all c-binding binary
> incompatible? Or this is just a hiccup for this python3.8 release?
> 
> If it's the former case, that doesn't look correct to me...

In general, each major Python version may change the C extension ABI,
which is why the Python version is encoded in the file name:

/usr/lib/python3.8/site-packages/btrfsutil.cpython-38-x86_64-linux-gnu.so

Usually they maintain source-level compatibility, but it appears that
CPython itself uses 0 for its unused initializers rather than NULL, so
they probably just missed this.
