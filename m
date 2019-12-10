Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503CA119001
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLJSs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:48:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfLJSs5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:48:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE001ACA4;
        Tue, 10 Dec 2019 18:48:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DDB5CDA727; Tue, 10 Dec 2019 19:48:56 +0100 (CET)
Date:   Tue, 10 Dec 2019 19:48:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: make btrfs_ordered_extent naming consistent
 with btrfs_file_extent_item
Message-ID: <20191210184856.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1575336815.git.osandov@fb.com>
 <1a8119f808ba10f315b4b6a37ce27896f1b113a4.1575336815.git.osandov@fb.com>
 <20191210182252.GF3929@twin.jikos.cz>
 <20191210183257.GB204474@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210183257.GB204474@vader>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 10:32:57AM -0800, Omar Sandoval wrote:
> On Tue, Dec 10, 2019 at 07:22:52PM +0100, David Sterba wrote:
> > On Mon, Dec 02, 2019 at 05:34:19PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > ordered->start, ordered->len, and ordered->disk_len correspond to
> > > fi->disk_bytenr, fi->num_bytes, and fi->disk_num_bytes, respectively.
> > > It's confusing to translate between the two naming schemes. Since a
> > > btrfs_ordered_extent is basically a pending btrfs_file_extent_item,
> > > let's make the former use the naming from the latter.
> > > 
> > > Note that I didn't touch the names in tracepoints just in case there are
> > > scripts depending on the current naming.
> > 
> > Ok, though we've changed tracepoint strings as needed, it's sort of ABI
> > but also not. In this case the change would affect 4 tracepoints.
> 
> What would you prefer in this case?

No change of the tracepoint strings for now.
