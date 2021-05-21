Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0238C69C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhEUMhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:37:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:47034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhEUMhG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:37:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 293F2AC11;
        Fri, 21 May 2021 12:35:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BDA46DA72C; Fri, 21 May 2021 14:33:08 +0200 (CEST)
Date:   Fri, 21 May 2021 14:33:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: mark ordered extent and inode with error if we
 fail to finish
Message-ID: <20210521123308.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <5b855fadb3c1de5be46d01b23c77e512933de3b9.1621431374.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b855fadb3c1de5be46d01b23c77e512933de3b9.1621431374.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 09:38:27AM -0400, Josef Bacik wrote:
> While doing error injection testing I saw that sometimes we'd get an
> abort that wouldn't stop the current transaction commit from completing.
> This abort was coming from finish ordered IO, but at this point in the
> transaction commit we should have gotten an error and stopped.
> 
> It turns out the abort came from finish ordered io while trying to write
> out the free space cache.  It occurred to me that any failure inside of
> finish_ordered_io isn't actually raised to the person doing the writing,
> so we could have any number of failures in this path and think the
> ordered extent completed successfully and the inode was fine.
> 
> Fix this by marking the ordered extent with BTRFS_ORDERED_IOERR, and
> marking the mapping of the inode with mapping_set_error, so any callers
> that simply call fdatawait will also get the error.
> 
> With this we're seeing the IO error on the free space inode when we fail
> to do the finish_ordered_io.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
