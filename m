Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCCFDE5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKOMxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:53:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:45020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfKOMxC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:53:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E007B012;
        Fri, 15 Nov 2019 12:53:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66E37DA7D3; Fri, 15 Nov 2019 13:53:03 +0100 (CET)
Date:   Fri, 15 Nov 2019 13:53:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs-progs: warn users about the possible
 dangers of check --repair
Message-ID: <20191115125303.GV3001@twin.jikos.cz>
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

For the record, this is on the way to 5.4. Thanks.
