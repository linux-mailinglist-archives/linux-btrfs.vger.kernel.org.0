Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0734E2FB63
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE3MDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 08:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726993AbfE3MDJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 08:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55989AEB2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 12:03:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8168ADA85E; Thu, 30 May 2019 14:04:02 +0200 (CEST)
Date:   Thu, 30 May 2019 14:04:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
Message-ID: <20190530120402.GD15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528082154.6450-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 28, 2019 at 04:21:54PM +0800, Qu Wenruo wrote:
> Normally the range->len is set to default value (U64_MAX), but when it's
> not default value, we should check if the range overflows.
> 
> And if overflows, return -EINVAL before doing anything.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The range support of TRIM will be reverted so this patch won't be
needed.
