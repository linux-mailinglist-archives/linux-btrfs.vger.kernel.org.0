Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07E18BC33
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgCSQQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 12:16:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgCSQQy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 12:16:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D478DAD78;
        Thu, 19 Mar 2020 16:16:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49EF9DA70E; Thu, 19 Mar 2020 17:16:22 +0100 (CET)
Date:   Thu, 19 Mar 2020 17:16:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/15] btrfs: move btrfs_dio_private to inode.c
Message-ID: <20200319161622.GE12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <7cb31cf9673d1d232e770145924ef779d3681058.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb31cf9673d1d232e770145924ef779d3681058.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:34PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This hasn't been needed outside of inode.c since commit 23ea8e5a0767
> ("Btrfs: load checksum data once when submitting a direct read io").

For ease of merging with Goldwyn's dio-iomap patches, can you please
avoid moving code? In this case it's btrfs_dio_private and some followup
patches that modify it.
