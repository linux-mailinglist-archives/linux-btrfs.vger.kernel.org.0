Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515395C0B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGAPzK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 11:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:53672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727589AbfGAPzK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 11:55:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED1AAB10B;
        Mon,  1 Jul 2019 15:55:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 70458DA8A9; Mon,  1 Jul 2019 17:55:53 +0200 (CEST)
Date:   Mon, 1 Jul 2019 17:55:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Btrfs: factor out extent dropping code from hole
 punch handler
Message-ID: <20190701155553.GN20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190627170031.6191-1-fdmanana@kernel.org>
 <20190628221126.31353-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628221126.31353-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 11:11:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Move the code that is responsible for dropping extents in a range out of
> btrfs_punch_hole() into a new helper function, btrfs_punch_hole_range(),
> so that later it can be used by the reflinking (extent cloning and dedup)
> code to fix a ENOSPC bug.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: No changes from V1, only the second patch in the series changed.

Patches 1 and 2 added to misc-next. Further cleanups in that code would
be welcome. Thanks.
