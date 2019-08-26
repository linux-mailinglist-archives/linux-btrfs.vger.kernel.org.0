Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AB9D5DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfHZSdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 14:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbfHZSdx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:33:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 528BAADF0;
        Mon, 26 Aug 2019 18:33:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6E17DA98E; Mon, 26 Aug 2019 20:34:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 20:34:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: don't check nbytes on unlinked files
Message-ID: <20190826183415.GC2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190809131831.26370-1-josef@toxicpanda.com>
 <dc439be8-0a2d-458d-c7c9-9558322c8c19@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc439be8-0a2d-458d-c7c9-9558322c8c19@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 10, 2019 at 09:06:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/9 下午9:18, Josef Bacik wrote:
> > We don't update the inode when evicting it, so the nbytes will be wrong
> > in between transaction commits.  This isn't a problem, stop complaining
> > about it to make generic/269 stop randomly failing.
> 
> Would you like to add the same check for lowmem mode?
> 
> Or mind me to do that?

Yes please. Thanks.
