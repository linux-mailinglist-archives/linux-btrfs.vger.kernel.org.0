Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FB292DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgJSSkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 14:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbgJSSkl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 14:40:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72FF2AD0F;
        Mon, 19 Oct 2020 18:40:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C66EEDA8EA; Mon, 19 Oct 2020 20:39:09 +0200 (CEST)
Date:   Mon, 19 Oct 2020 20:39:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: btrfs-sb-mod add devid to the modifiable
 list
Message-ID: <20201019183909.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <8c8c3cbe61cc62d8a5f09ca497d6e88a0a1cd74d.1602065251.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8c3cbe61cc62d8a5f09ca497d6e88a0a1cd74d.1602065251.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 07, 2020 at 06:08:05PM +0800, Anand Jain wrote:
> We need this patch to create a crafted image with bogus devid.
> 
> For example:
> ./btrfs-sb-mod devid =0

This should maintain some parity with the output of 'dump-super', ie.
this should have dev_item. prefix. There's also total_size for a device
and this could be confusing with the superblock total_size. I'll fix it
and add the remaining dev_item members as well.
