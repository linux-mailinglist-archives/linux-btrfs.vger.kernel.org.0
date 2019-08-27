Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05D9EC8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfH0P1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 11:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfH0P1P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:27:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B507CAF06
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:27:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 107ACDA8D5; Tue, 27 Aug 2019 17:27:37 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:27:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: treat btrfs_add_to_fsid as fatal
 error
Message-ID: <20190827152736.GM2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 13, 2019 at 09:03:58PM -0400, Jeff Mahoney wrote:
> When btrfs_add_to_fsid fails in mkfs we try to close the ctree.  That
> complains that we already have a transaction open.  We should be taking
> the error path and exit cleanly without writing.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

I've merged 1-3, splitting some of the patches. Patch 4 is broken for
some of the resize format and can't be trivially fixed. I'll add a test
so we have better coverage for further development.
