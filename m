Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26846E3AE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440066AbfJXSYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 14:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437011AbfJXSYk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 14:24:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78E56B33C;
        Thu, 24 Oct 2019 18:24:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51120DA733; Thu, 24 Oct 2019 20:24:51 +0200 (CEST)
Date:   Thu, 24 Oct 2019 20:24:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: Check item size before reading file
 extent type
Message-ID: <20191024182450.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190902234619.5888-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902234619.5888-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 07:46:19AM +0800, Qu Wenruo wrote:
> In check_extent_data_item(), we read file extent type without verifying
> if the item size is valid.
> 
> Add such check to ensure the file extent type we read is correct.
> 
> The check is not as accurate as we need to cover both inline and regular
> extents, so it only checks if the item size is larger or equal to inline
> header.
> So the existing size checks on inline/regular extents are still needed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I lost track of this patch, now added to for-next. Thanks.
