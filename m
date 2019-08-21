Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB76E97AA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfHUNYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 09:24:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727696AbfHUNYW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 09:24:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3866FAC7F;
        Wed, 21 Aug 2019 13:24:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23E07DA7DB; Wed, 21 Aug 2019 15:24:47 +0200 (CEST)
Date:   Wed, 21 Aug 2019 15:24:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Btrfs: workqueue cleanups
Message-ID: <20190821132446.GB18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565717247.git.osandov@fb.com>
 <20190821132021.GA18575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132021.GA18575@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 03:20:21PM +0200, David Sterba wrote:
> On Tue, Aug 13, 2019 at 10:33:42AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This does some cleanups to the Btrfs workqueue code following my
> > previous fix [1]. Changed since v1 [2]:
> > 
> > - Removed errant Fixes: tag in patch 1
> > - Fixed a comment typo in patch 2
> > - Added NB: to comments in patch 2
> > - Added Nikolay and Filipe's reviewed-by tags
> > 
> > Thanks!
> > 
> > 1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
> > 2: https://lore.kernel.org/linux-btrfs/cover.1565680721.git.osandov@fb.com/
> > 
> > Omar Sandoval (2):
> >   Btrfs: get rid of unique workqueue helper functions
> >   Btrfs: get rid of pointless wtag variable in async-thread.c
> 
> The patches seem to cause crashes inside the worques, happend several
> times in random patches, sample stacktrace below. This blocks me from
> testing so I'll move the patches out of misc-next for now and add back
> once there's a fix.

Another possibility is that the cleanup patches make it more likely to
happen and the root cause is "Btrfs: fix workqueue deadlock on dependent
filesystems".
