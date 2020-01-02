Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9D12E7D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgABPEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 10:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgABPEU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 10:04:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCD5AAF38;
        Thu,  2 Jan 2020 15:04:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10CFCDA790; Thu,  2 Jan 2020 16:04:11 +0100 (CET)
Date:   Thu, 2 Jan 2020 16:04:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: tree-checker: Clean up fs_info parameter from
 error message wrapper
Message-ID: <20200102150411.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191209105435.36041-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209105435.36041-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 06:54:32PM +0800, Qu Wenruo wrote:
> The @fs_info parameter can be extracted from extent_buffer structure,
> and there are already some wrappers getting rid of the @fs_info
> parameter.
> 
> This patch will finish the cleanup.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

1-4 added to misc-next, thanks.
