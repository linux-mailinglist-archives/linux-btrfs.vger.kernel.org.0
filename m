Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37420F755
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgF3OgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:36:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgF3OgP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1E46B613;
        Tue, 30 Jun 2020 14:36:13 +0000 (UTC)
Date:   Tue, 30 Jun 2020 09:36:11 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/8] btrfs: Move FS error state bit early during write
Message-ID: <20200630143611.26v5chluocc2mmrk@fiona>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
 <20200622162017.21773-3-rgoldwyn@suse.de>
 <20200630082248.GR27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630082248.GR27795@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10:22 30/06, David Sterba wrote:
> On Mon, Jun 22, 2020 at 11:20:11AM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > We don't need the inode locked to check for the error bit. Move the
> > check early.
> 
> This lacks explanation why it's not needed. I've checked history of the
> code and it seems the error state flags has been after all other checks
> since long, starting in acce952b0263825d. But it's part of a bigger
> patch and is not specific about this call site.
> 
> If something checks state and changes the location, we need to make sure
> the state is not affected by code between the old and new location.

This is a filesystem state bit as opposed to a file level state bit. The
bit states that you don't let writes proceed because of a filesystem
error. Why would you need a inode level lock for that? It is better to
return -EROFS early enough rather than take a lock, check for filesystem
failure, release the lock and then return an error.

The other check is in start_transaction, which perhaps is for
writes-in-flight.

-- 
Goldwyn
