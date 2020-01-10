Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A93137462
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 18:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgAJRGu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 12:06:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgAJRGt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 12:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC29DAD4F;
        Fri, 10 Jan 2020 17:06:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 033D3DA78B; Fri, 10 Jan 2020 18:06:35 +0100 (CET)
Date:   Fri, 10 Jan 2020 18:06:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix error code in btrfs_sysfs_add_mounted()
Message-ID: <20200110170634.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200110055126.4rhhfsotll6puma7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110055126.4rhhfsotll6puma7@kili.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 10, 2020 at 08:51:27AM +0300, Dan Carpenter wrote:
> The error code wasn't set on this error path.
> 
> Fixes: e12ebce8a4a8 ("btrfs: sysfs: make UUID/debug have its own kobject")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, folded to the original patch.
