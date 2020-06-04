Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88391EE8F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgFDQ4Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 12:56:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgFDQ4Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jun 2020 12:56:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 729D6ACB1;
        Thu,  4 Jun 2020 16:56:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32FE4DA818; Thu,  4 Jun 2020 18:56:19 +0200 (CEST)
Date:   Thu, 4 Jun 2020 18:56:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: minor block group cleanups
Message-ID: <20200604165618.GE27034@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200603101020.143372-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603101020.143372-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 06:10:17PM +0800, Anand Jain wrote:
> Minor cleanup patches.
> 1/3 cleansup the return value of btrfs_return_cluster_to_free_space().
> 2/3 and 3/3 together cleanups block group reference count.
> 
> 2/3 and 3/3 are related. However 1/3 is independent to the rest of the
> patches in this set.
> 
> Anand Jain (3):
>   btrfs: fix btrfs_return_cluster_to_free_space() return
>   btrfs: rename btrfs_block_group::count
>   btrfs: use helper btrfs_get_block_group

1 and 3 applied but I don't recommend to spend time on cleaning up
free-space-cache.[ch] as it's going to be phased out.
