Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187BD228549
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgGUQ1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 12:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgGUQ1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 12:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9105AD79;
        Tue, 21 Jul 2020 16:27:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 632F0DA70B; Tue, 21 Jul 2020 18:27:10 +0200 (CEST)
Date:   Tue, 21 Jul 2020 18:27:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use nofs for device sysfs creation
Message-ID: <20200721162710.GO3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721141750.1793-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721141750.1793-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 10:17:50AM -0400, Josef Bacik wrote:
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1278,7 +1278,9 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
>  {
>  	int error = 0;
>  	struct btrfs_device *dev;
> +	unsigned long nofs_flag;

	unsigned int

Fixed and added to misc-next, thanks.
