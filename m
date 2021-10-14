Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9810A42DE33
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhJNPfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:35:55 -0400
Received: from verein.lst.de ([213.95.11.211]:50646 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhJNPfy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:35:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E31C68B05; Thu, 14 Oct 2021 17:33:47 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:33:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: update device path inode time instead of
 bd_inode
Message-ID: <20211014153347.GA30555@lst.de>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 11:17:08AM -0400, Josef Bacik wrote:
> +	now = current_time(d_inode(path.dentry));
> +	generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);

This is still broken as it won't call into ->update_time.
generic_update_time is a helper/default for ->update_time, not something
for an external caller.
