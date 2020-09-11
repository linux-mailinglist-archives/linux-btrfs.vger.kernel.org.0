Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D037265F31
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgIKMFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 08:05:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgIKME1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 08:04:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21389AB7D;
        Fri, 11 Sep 2020 12:04:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D4BADA87D; Fri, 11 Sep 2020 14:03:10 +0200 (CEST)
Date:   Fri, 11 Sep 2020 14:03:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] fixup: btrfs: simplify parameters of
 btrfs_sysfs_add_devices_dir
Message-ID: <20200911120310.GP18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <202009110113.Eg6BMMot%lkp@intel.com>
 <de807752385624b9ce46bd3a759a3fa4588051ec.1599775651.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de807752385624b9ce46bd3a759a3fa4588051ec.1599775651.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 11, 2020 at 06:09:27AM +0800, Anand Jain wrote:
> Add static to btrfs_sysfs_add_fs_devices()
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Can you please roll this into the commit fd8e11fb8ffc
>   btrfs: simplify parameters of btrfs_sysfs_add_devices_dir
> on misc-next

Folded in, thanks.
