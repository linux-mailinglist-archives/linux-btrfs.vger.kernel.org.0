Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F204D9D247
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfHZPFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 11:05:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732812AbfHZPFa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 11:05:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4414DAEF6
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 15:05:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18B04DA98E; Mon, 26 Aug 2019 17:05:53 +0200 (CEST)
Date:   Mon, 26 Aug 2019 17:05:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v2] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
Message-ID: <20190826150552.GU2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190826141002.GT2752@twin.jikos.cz>
 <20190826143424.10964-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826143424.10964-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 05:34:24PM +0300, Nikolay Borisov wrote:
> Support for asynchronous snapshot creation was originally added in
> 72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
> ceph's backend needs. However, since Ceph has deprecated support for
> btrfs there is no longer need for that support in btrfs. Additionally,
> this was never supported by btrfs-progs, the official userspace tools.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
