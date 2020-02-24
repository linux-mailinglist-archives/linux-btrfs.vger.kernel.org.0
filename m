Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4916A8D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBXOvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 09:51:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:54576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbgBXOvV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 09:51:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0FB62AD2C;
        Mon, 24 Feb 2020 14:51:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3035CDA727; Mon, 24 Feb 2020 15:51:01 +0100 (CET)
Date:   Mon, 24 Feb 2020 15:51:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: simplify parameters of
 btrfs_set_disk_extent_flags
Message-ID: <20200224145101.GT2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1582302545.git.dsterba@suse.com>
 <e9483711e6f093259df9488c1d4d9753426fdf0a.1582302545.git.dsterba@suse.com>
 <SN4PR0401MB35988FDCB6B7180E0C2E30129BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35988FDCB6B7180E0C2E30129BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 22, 2020 at 08:45:32AM +0000, Johannes Thumshirn wrote:
> A similar change should work for btrfs_add_delayed_extent_op() as well, 
> shouldn't it?

Yes. Possibly pushing that further down the call chain to the delayed
refs, if all num_bytes is extent_buffer->len then this can be simplified
to fs_info->nodesize.
