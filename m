Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CC240829
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHJPHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHJPHr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:07:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61AF5AD1F;
        Mon, 10 Aug 2020 15:08:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AD6ADA7D5; Mon, 10 Aug 2020 17:06:44 +0200 (CEST)
Date:   Mon, 10 Aug 2020 17:06:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error pointer vs NULL check
Message-ID: <20200810150644.GA2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200805095147.GB483832@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805095147.GB483832@mwanda>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 05, 2020 at 12:51:47PM +0300, Dan Carpenter wrote:
> The btrfs_get_subvol_name_from_objectid() function never
> returns NULL, it returns error pointers.  Update the check
> accordinglingly to prevent an Oops.
> 
> Fixes: ca346708eb17 ("btrfs: don't show full path of bind mounts in subvol=")

Thanks for catching it, the patch is in a development branch and the
commit id is unstable so I'll fold the fixup.
