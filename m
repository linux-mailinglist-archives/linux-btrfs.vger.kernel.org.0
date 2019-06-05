Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18B3610A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 18:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfFEQTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 12:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728666AbfFEQTp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 12:19:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76BF6AD85
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 16:19:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5F05DA866; Wed,  5 Jun 2019 18:20:35 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:20:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: Correctly open filesystem on image file
Message-ID: <20190605162035.GE9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190516131250.26621-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516131250.26621-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 04:12:49PM +0300, Nikolay Borisov wrote:
> When btrfs' 'filesystem' subcommand is passed path to an image file it
> currently fails since the code expects the image file is going to be
> recognised by libblkid (called from btrfs_scan_devices()). This is not
> the case since libblkid only scan well-known locations under /dev.
> 
> Fix this by explicitly calling open_ctree which will correctly open
> the image and add it to the correct btrfs_fs_devices struct. This allows
> subsequent cmd_filesystem_show logic to correctly show requested
> information.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Applied, thanks.
