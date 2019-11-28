Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8010C7CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1LO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 06:14:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:54936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1LOY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 06:14:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 220A5B189;
        Thu, 28 Nov 2019 11:14:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C438CDAC01; Thu, 28 Nov 2019 12:14:20 +0100 (CET)
Date:   Thu, 28 Nov 2019 12:14:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Rename __btrfs_free_reserved_extent to
 btrfs_pin_reserved_extent
Message-ID: <20191128111420.GE2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191121120331.29070-1-nborisov@suse.com>
 <20191121120331.29070-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121120331.29070-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 02:03:31PM +0200, Nikolay Borisov wrote:
> -	ret = pin_down_extent(cache, start, len, 1);
> +	btrfs_add_free_space(cache, start, len);
> +	btrfs_free_reserved_bytes(cache, len, delalloc);
> +	trace_btrfs_reserved_extent_free(fs_info, start, len);

Unrelated, this patch is only moving existing code, but
btrfs_add_free_space and btrfs_free_reserved_bytes don't have their
errors handled. In many other places too.
