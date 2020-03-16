Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B926718695F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 11:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgCPKsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 06:48:35 -0400
Received: from verein.lst.de ([213.95.11.211]:53723 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgCPKsf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 06:48:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C28368CF0; Mon, 16 Mar 2020 11:48:32 +0100 (CET)
Date:   Mon, 16 Mar 2020 11:48:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 03/15] btrfs: look at full bi_io_vec for repair decision
Message-ID: <20200316104831.GA14886@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <c0f65f07b18eee7cef4e0b0b439a45ae437a11c6.1583789410.git.osandov@fb.com> <20200310163319.GC6361@lst.de> <20200311090747.GE252106@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311090747.GE252106@vader>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 02:07:47AM -0700, Omar Sandoval wrote:
> That works for me. I was microoptimizing here since I can stop iterating
> once I know that the bio is greater than one sector, but since this is
> for the rare repair case, it really doesn't matter.
> 
> On the other hand, a bio_for_each_bvec_all() helper would feel less
> intrusive into the bio guts and also support bailing early. I'm fine
> either way. Thoughts?

I don't really care too much as long as we don't open code the bi_io_vec
access.
