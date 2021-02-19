Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855BC31FA6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 15:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBSOPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 09:15:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhBSOPA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 09:15:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2BDAAC6E;
        Fri, 19 Feb 2021 14:14:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 659F6DA82A; Fri, 19 Feb 2021 15:12:22 +0100 (CET)
Date:   Fri, 19 Feb 2021 15:12:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests: check the result log for
 critical warnings
Message-ID: <20210219141222.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201109053952.490678-1-wqu@suse.com>
 <20201109053952.490678-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109053952.490678-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 09, 2020 at 01:39:52PM +0800, Qu Wenruo wrote:
> Introduce a new function, check_test_results(), for
> misc/fsck/convert/mkfs test cases.
> 
> This function is currently to catch warning message for subpage support,
> but can be later expanded for other usages.

That sounds very useful, thanks.

Added to devel.
