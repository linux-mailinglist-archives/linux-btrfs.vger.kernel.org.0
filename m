Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2A7C67A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfGaP0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 11:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbfGaP0C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 11:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2124BAE88
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 15:26:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ACC4CDA7ED; Wed, 31 Jul 2019 17:26:35 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:26:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: volumes: Remove ENOSPC-prone
 btrfs_can_relocate()
Message-ID: <20190731152635.GM28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190719065144.15263-1-wqu@suse.com>
 <20190719065144.15263-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719065144.15263-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 19, 2019 at 02:51:44PM +0800, Qu Wenruo wrote:
> [BUG]
> Test case btrfs/156 fails since commit 302167c50b32 ("btrfs: don't end
> the transaction for delayed refs in throttle") with ENOSPC.

The commit that introduced the function btrfs_can_relocate is from 2009
and the commit mentions painc during balance when there's no space. This
was due to lack of error handling that is present now, so we don't
really need to check in advance.

I think it's safe, I'll add the patches to misc-next, thanks.
