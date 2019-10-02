Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2930DC8952
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfJBNKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 09:10:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfJBNKT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 09:10:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31EF4B03C;
        Wed,  2 Oct 2019 13:10:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 780AFDA88C; Wed,  2 Oct 2019 15:10:35 +0200 (CEST)
Date:   Wed, 2 Oct 2019 15:10:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: transaction: Cleanup unused
 TRANS_STATE_BLOCKED
Message-ID: <20191002131035.GN2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190822072500.22730-1-wqu@suse.com>
 <20190822072500.22730-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822072500.22730-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 03:25:00PM +0800, Qu Wenruo wrote:
> The state is introduced in commit 4a9d8bdee368 ("Btrfs: make the state
> of the transaction more readable"), then in commit 302167c50b32
> ("btrfs: don't end the transaction for delayed refs in throttle") the
> state is completely removed.
> 
> So we can just clean up the state since it's only compared but never
> set.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>
