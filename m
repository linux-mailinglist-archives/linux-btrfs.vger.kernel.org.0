Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA18A18CFC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgCTOLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 10:11:44 -0400
Received: from verein.lst.de ([213.95.11.211]:47780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTOLn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 10:11:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 41AB168B05; Fri, 20 Mar 2020 15:11:42 +0100 (CET)
Date:   Fri, 20 Mar 2020 15:11:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200320141142.GA25658@lst.de>
References: <cover.1583789410.git.osandov@fb.com> <20200320141041.GA25256@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320141041.GA25256@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 20, 2020 at 03:10:41PM +0100, Christoph Hellwig wrote:
> Btw, while you touch this code:
> 
> It seems like btrfs_dio_private.subio_endio is rather pointless,
> as it is always set to one function for reads and otherwise never
> set.  De-virtualizing this call could help making the code a little
> faster and easier to understand.

Doh, one of the later patches actually kills it.  Time for more coffee..
