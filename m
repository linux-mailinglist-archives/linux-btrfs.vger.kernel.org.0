Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02A51ABDCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504719AbgDPKYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 06:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:52744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504724AbgDPKVP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 06:21:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A3C1AC77;
        Thu, 16 Apr 2020 10:21:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2B68DA727; Thu, 16 Apr 2020 12:20:22 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:20:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 2/2] btrfs: Reformat btrfs_tree.h comments
Message-ID: <20200416102021.GH5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415084113.64378-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 04:41:13PM +0800, Qu Wenruo wrote:
> Since we're here, modify btrfs_tree.h to follow the latest comment
> style.

Well, the point was to make the changes when moving the code so it's not
split into two patches, but this patch seems to update more code so it's
probably fine to have them separate.
