Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCD1780CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgCCR6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:58:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:33954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbgCCR6x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:58:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95E98AE3A;
        Tue,  3 Mar 2020 17:58:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DDCEDA7AE; Tue,  3 Mar 2020 18:58:29 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:58:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: disk-io: Kill the BUG_ON()s in
 write_and_map_eb()
Message-ID: <20200303175829.GN2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302045509.38573-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302045509.38573-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 12:55:09PM +0800, Qu Wenruo wrote:
> All callers of write_and_map_eb(), except btrfs-corrupt-block, have
> handled error, but inside write_and_map_eb() itself, the only error handling
> is BUG_ON().
> 
> This patch will kill all the BUG_ON()s inside write_and_map_eb(), and
> enhance the the caller in btrfs-corrupt-block() to handle the error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
