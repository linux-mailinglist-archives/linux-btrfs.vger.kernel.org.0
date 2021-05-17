Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400C382C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhEQMcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 08:32:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhEQMcC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 08:32:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E49CB19F;
        Mon, 17 May 2021 12:30:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5E8EDB228; Mon, 17 May 2021 14:28:12 +0200 (CEST)
Date:   Mon, 17 May 2021 14:28:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs-progs: fix inspect-internal --help incomplete
 sentence
Message-ID: <20210517122812.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <d9905452906eea5e8ac5b569e92df3c48861d734.1616136002.git.anand.jain@oracle.com>
 <0e95dbad99f21a00f5a3b7704196e5bde47bc8db.1616137734.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e95dbad99f21a00f5a3b7704196e5bde47bc8db.1616137734.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 19, 2021 at 03:10:02PM +0800, Anand Jain wrote:
> btrfs inspect-internal --help show some incomplete sentenses. As shown
> below,
> 
>   btrfs inspect-internal --help
>   <snip>
>       btrfs inspect-internal min-dev-size [options] <path>
>           Get the minimum size the device can be shrunk to. The
>       btrfs inspect-internal dump-tree [options] <device> [<device> ..]
>   <snip>
> 
> This patch just fixes it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Drop the idea to fix the period at the end of the single line help
>     statements. Because the fix wasn't sufficient, there are more, and
>     it can be done separately.

Added to devel, thanks.
