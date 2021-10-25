Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6232F439725
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJYNIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 09:08:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhJYNIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 09:08:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7634821956;
        Mon, 25 Oct 2021 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635167177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Toiu46mmGfiQkj8/qFED5wEjGPl2I54jligXy3Em5bk=;
        b=aCppBY0Vbv0qmt5nmgdnUyzCTylV+tIFm6pcYs+d6W3wEB65HcS6JKzBpb6FwZEnA/OldR
        EpY5YVVgD6CncgkGLnRYRxaesZ6IlBMrKRG6GLNFPjeALFS63MbrLIuD2Fy8IaNiWlb7nq
        8on4emSP6J+rbfJzbjmdcy6uLVNguWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635167177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Toiu46mmGfiQkj8/qFED5wEjGPl2I54jligXy3Em5bk=;
        b=QvOlz2nEHM/9ZIdZRC2A359Z6JhKI8S5yyWEGZmA+fO2k4MVEkC3rcslhOrKddiZIiXms8
        jz369hRm43pA8RDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66D13A3B8A;
        Mon, 25 Oct 2021 13:06:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C56FDA7A9; Mon, 25 Oct 2021 15:05:46 +0200 (CEST)
Date:   Mon, 25 Oct 2021 15:05:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Ma Xinjian <xinjianx.ma@intel.com>, fstests@vger.kernel.org,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs/091: remove noinode_cache option
Message-ID: <20211025130546.GN20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eryu Guan <guan@eryu.me>,
        Ma Xinjian <xinjianx.ma@intel.com>, fstests@vger.kernel.org,
        Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072019.46609-1-xinjianx.ma@intel.com>
 <20210927072019.46609-2-xinjianx.ma@intel.com>
 <YXVg1xoLIvwxcjbD@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXVg1xoLIvwxcjbD@desktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 24, 2021 at 09:34:15PM +0800, Eryu Guan wrote:
> On Mon, Sep 27, 2021 at 03:20:19PM +0800, Ma Xinjian wrote:
> > inode cache feature has been removed
> > 
> > Link: https://www.spinics.net/lists/linux-btrfs/msg107910.html
> 
> >From above link, the inode cache feathre has been removed since v5.11
> kernel, which is relatively a recent kernel,  but old kernels may still
> need this noinode_cache mount option.  So we'd better to keep this
> check.
> 
> We could add check for inode_cache option as well, and only check for
> noinode_cache when inode cache is supported.

I don't think we should keep the option support in the testsuite. There
was deprecation period before actual removal from kernel and long before
that we discouraged everybody from using it. There were known bugs and I
don't think anybody cares for old kernels anyway.
