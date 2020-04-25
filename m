Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B841B8424
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Apr 2020 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYHOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Apr 2020 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYHOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 03:14:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D16C09B049
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=2KmsjLmRIWoWd5NScCrKnfEnemb5bapOuuTufQa/Sbk=; b=d4iD5Yokfd/zqPHQdgzjmFtx9v
        /AP9odsAONlJcXIyWK8Oep7fYzgviWY+LPvUH/4QPAZOFQL8h2waVh3pCHWQNrbeDasVf2FLXymQK
        +RQ5+1sm5v5YTdQNUgP6IUYi7d7DhnTr2eLmUVs+arGg0ZOvsTo6RxhOhTVb/1nKAXiWuepXdkyt2
        cMJGs0YcYIs+m9MR445TGLIpk8dwOK6F3o72kYh3ppu5qfvp+bc/LDlINzbAIhCL21iy6YKRoSA4a
        cQeSjkaS5KmP9d40gBOPUCqRtkOXAfKaKFJl7r0fRHISctro0VJ+LVAeU8TrCwMkmV5uPbq8rJ8DS
        Lt+6wkTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSF0y-0008Eu-Q0; Sat, 25 Apr 2020 07:14:16 +0000
Date:   Sat, 25 Apr 2020 00:14:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
Message-ID: <20200425071416.GA30673@infradead.org>
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com>
 <20200421113138.GA10447@infradead.org>
 <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
 <20200424202445.GY18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424202445.GY18421@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 24, 2020 at 10:24:45PM +0200, David Sterba wrote:
> On Tue, Apr 21, 2020 at 07:41:40PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2020/4/21 下午7:31, Christoph Hellwig wrote:
> > > On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
> > >> These structures all are on-disk format. Move them to btrfs_tree.h
> > >>
> > >> This allows us to sync the header to different projects, who need to
> > >> read btrfs filesystem, like U-boot, grub.
> > > 
> > > Please use a separate header for that.  btrfs_tree.h is a UAPI header
> > > with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
> > > can be copied into the projects where is needed.
> > > 
> > Doesn't on-disk format itself need strict ABI guarantees?
> > 
> > Thus it looks like the perfect location for on-disk format definitions.
> 
> Right now I'm not sure if it's a good idea to put the on-disk format to
> the UAPI path or not. The exported code is to support the ioctls,
> there's an overlap with the on-disk format but providing all the on-disk
> structures for general might become an unnecessry burden.
> 
> We know that there's a small number of projects that want to sync the
> on-disk format so I don't think it's going to be a problem for them to
> use a private header.

And the usual way is to just ensure the format header is self-contained
and suitably licensed that they can easily copy it and rely on the
version they checked in.  That avoids the problems of

 a) the tools relying on installed kernel headers new enough for the
    feature they want to support
 b) ifdef magic for newer features in the tools
 c) the need to keep changes to the kernel format header to be backwards
    compatible at the compiler level (as there can be disk format
    compatible changes that still break users, e.g. introducing a named
    union, or splitting / merging struct definitions)
