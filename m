Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA52744AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVOtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:49:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVOtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:49:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48DCAACC2;
        Tue, 22 Sep 2020 14:49:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 368AADA6E9; Tue, 22 Sep 2020 16:47:50 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:47:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nborisov@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: clean BTRFS_I usage in btrfs_destroy_inode
Message-ID: <20200922144750.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        nborisov@suse.com, linux-btrfs@vger.kernel.org
References: <20200922110118.GA1297350@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922110118.GA1297350@mwanda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 02:01:18PM +0300, Dan Carpenter wrote:
> Hello Nikolay Borisov,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch ab46388723da: "btrfs: clean BTRFS_I usage in
> btrfs_destroy_inode" from Sep 18, 2020, leads to the following Smatch
> complaint:

Thanks for the report.

There's a fix
https://lore.kernel.org/linux-btrfs/20200921191243.27833-1-a.dewar@sussex.ac.uk/

but now that I see you actually point to the right patch that caused it,
which is still in the pending branch so I can fold the fixup there.
