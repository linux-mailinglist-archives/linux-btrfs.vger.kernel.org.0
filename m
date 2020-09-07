Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95A260538
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgIGTke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 15:40:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:49814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgIGTkd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 15:40:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 375DEAF0B;
        Mon,  7 Sep 2020 19:40:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77FF4DA7CE; Mon,  7 Sep 2020 21:39:17 +0200 (CEST)
Date:   Mon, 7 Sep 2020 21:39:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: improve messages when devices rescanned
Message-ID: <20200907193916.GD28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
 <674264e45246039a7d294415b2e0f42434ec8070.1599139776.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674264e45246039a7d294415b2e0f42434ec8070.1599139776.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 09:30:12PM +0800, Anand Jain wrote:
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> +	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",

> +	"devid %llu device path %s changed to %s scanned by %s (pid %d)",

I haven't found a wording that would make the messages follow the same
pattern, eg. that both describe the change and then print the details.
The path change should keep the devid first and the old/new paths
together. So let it be the way it was sent, with the 'pid' removed.
Added to misc-next, thanks.
