Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8624D76D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHUOjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOjp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:39:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88F92AC82;
        Fri, 21 Aug 2020 14:40:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61913DA730; Fri, 21 Aug 2020 16:38:37 +0200 (CEST)
Date:   Fri, 21 Aug 2020 16:38:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: check return value of filemap_fdatawrite_range()
Message-ID: <20200821143837.GG2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Alex Dewar <alex.dewar90@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200821124154.10218-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821124154.10218-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 21, 2020 at 01:41:54PM +0100, Alex Dewar wrote:
> In btrfs_dio_imap_begin(), filemap_fdatawrite_range() is called without
> checking the return value. Add a check to catch errors.
> 
> Fixes: c0aaf9b7a114f ("btrfs: switch to iomap_dio_rw() for dio")
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Folded to the patch, thanks.
