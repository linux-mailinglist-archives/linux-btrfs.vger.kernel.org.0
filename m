Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E845D195AC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0QNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 12:13:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgC0QNy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 12:13:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3C20ABE9;
        Fri, 27 Mar 2020 16:13:52 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:13:48 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200327161348.to4upflzczkbbpfo@fiona>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327081024.GA24827@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  1:10 27/03, Christoph Hellwig wrote:
> On Thu, Mar 26, 2020 at 04:02:49PM -0500, Goldwyn Rodrigues wrote:
> > BTRFS direct I/O is now done under i_rwsem, shared in case of
> > reads and exclusive in case of writes. This guards against simultaneous
> > truncates.
> 
> Btw, you really want to add the optimization of only taking it shared
> for all the easy write cases similar to what XFS has done for ages
> and what ext4 picked up now.  Without that performance on someworkloads
> is going to be horrible.  That could be a patch on top of this one,
> though.

Yes, I will work on that. The idea of dropping the lock seems a little
weird.

-- 
Goldwyn
