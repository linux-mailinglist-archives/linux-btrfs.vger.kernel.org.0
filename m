Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC37225C4AE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgICPN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgICPNx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 11:13:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D095AD18;
        Thu,  3 Sep 2020 15:13:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87DC9DA6E0; Thu,  3 Sep 2020 17:12:39 +0200 (CEST)
Date:   Thu, 3 Sep 2020 17:12:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nborisov@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: remove err variable from btrfs_get_extent
Message-ID: <20200903151239.GV28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        nborisov@suse.com, linux-btrfs@vger.kernel.org
References: <20200903092705.GA392335@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903092705.GA392335@mwanda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 12:27:05PM +0300, Dan Carpenter wrote:
> Hello Nikolay Borisov,
> 
> The patch 85b1eebdaf1d: "btrfs: remove err variable from
> btrfs_get_extent" from Aug 3, 2020, leads to the following static
> checker warning:
> 
> 	fs/btrfs/inode.c:6737 btrfs_get_extent()
> 	error: passing non negative 1 to ERR_PTR

Thanks for the report, Nikolay sent a fixup and that's been folded to
the original patch.
