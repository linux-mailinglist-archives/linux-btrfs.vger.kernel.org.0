Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5F1BFD25
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgD3OKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 10:10:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgD3OKi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 10:10:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37EF2AC24;
        Thu, 30 Apr 2020 14:10:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF1BCDA728; Thu, 30 Apr 2020 16:09:50 +0200 (CEST)
Date:   Thu, 30 Apr 2020 16:09:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
Subject: Re: [PATCH 1/3] btrfs: drop useless goto in open_fs_devices
Message-ID: <20200430140950.GO18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428152227.8331-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 11:22:25PM +0800, Anand Jain wrote:
> There is no need of goto out in open_fs_devices() as there is nothing
> special done at %out:. So refactor it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

As this is independent cleanup, I'll add it to misc-next, thanks.
