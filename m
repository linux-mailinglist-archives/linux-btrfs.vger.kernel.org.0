Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF5DF138
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfJUPWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:22:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbfJUPWa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:22:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93F47B155;
        Mon, 21 Oct 2019 15:22:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BEE57DA905; Mon, 21 Oct 2019 17:22:41 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:22:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs-progs: warn users about the possible
 dangers of check --repair
Message-ID: <20191021152241.GN3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191018111604.16463-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018111604.16463-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 01:16:03PM +0200, Johannes Thumshirn wrote:
> The manual page of btrfsck clearly states 'btrfs check --repair' is a
> dangerous operation.
> 
> Although this warning is in place users do not read the manual page and/or
> are used to the behaviour of fsck utilities which repair the filesystem,
> and thus potentially cause harm.
> 
> Similar to 'btrfs balance' without any filters, add a warning and a
> countdown, so users can bail out before eventual corrupting the filesystem
> more than it already is.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v1:
> - Fix grammar mistakes in warning message
> - Skip delay with --force

--force was added for a different reason, to allow check on a mounted
filesystem. I don't think that combining --repair and --force just to
allow repair is a good idea. There's a 'dangerous repair' mode for eg.
xfs that allows to do live surgery on a mounted filesytem (followed by
immediate reboot). We want to be able to do that eventually.

I understand where the motivation comes from, let me have a second
thought on that.
