Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8C115446
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFPaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:30:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfLFPaS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Dec 2019 10:30:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BC75AD00;
        Fri,  6 Dec 2019 15:30:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03A70DA783; Fri,  6 Dec 2019 16:30:10 +0100 (CET)
Date:   Fri, 6 Dec 2019 16:30:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] Btrfs: fix missing data checksums after replaying a
 log tree
Message-ID: <20191206153010.GF2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191129151359.31905-1-fdmanana@kernel.org>
 <20191205165830.18477-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205165830.18477-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 04:58:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
[...]
> V2: Fixed changelog because it stated in the first paragraph that the problem
>     affected only extents shared within the same file, but that's not true and
>     contradicted the last paragraph. So fix that and state explicitly that it
>     happens as well for extents shared between different files.
> 
> V3: Drop existing checksums from the log during the fast fsync path as well.
>     This is also needed to make the test case pass on kernels < 5.4 because
>     on 5.4 the full sync bit is set on the inode whenever we clone, while
>     before 5.4 we don't set it. The tree checker patch for detecting overlapping
>     checksum items detected this during a fast fsync on generic/561 while
>     running it in a loop for several hours.

Patch replaced, thanks.
