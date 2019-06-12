Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0803042A10
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439872AbfFLO5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436945AbfFLO5f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92523AE2C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 14:57:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68B95DA8F5; Wed, 12 Jun 2019 16:58:25 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:58:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: Remove "recovery" mount option
Message-ID: <20190612145825.GO3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190612063657.21063-1-wqu@suse.com>
 <20190612063657.21063-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612063657.21063-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 02:36:55PM +0800, Qu Wenruo wrote:
> Commit 8dcddfa048de ("btrfs: Introduce new mount option usebackuproot to
> replace recovery") deprecates "recovery" mount option in 2016, and it
> has been 3 years, it should be OK to remove "recovery" mount option.

Well, that's what we never know if it's ok o not so the deprecated
options usually stay. Eg. subvolrootid is still there.

3 years might sound a like a long time but there are old kernels that
follow the stable branches so I'd rather derive the time to removal from
that. And eg 4.4 still has the 'recovery' option not among the
deprecated, same 4.9 and 4.14.

Since 4.19 it's deprecated so we'll have to wait until that is EOL,
Dec 2020.
