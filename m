Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BAFCE7FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJGPlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:57148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfJGPlK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50D81AD5D;
        Mon,  7 Oct 2019 15:41:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0D98DA7FB; Mon,  7 Oct 2019 17:41:24 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:41:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v6] btrfs-progs: add xxhash64 to mkfs
Message-ID: <20191007154124.GD2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190925133728.18027-6-jthumshirn@suse.de>
 <20190926101123.19486-1-jthumshirn@suse.de>
 <493f3622-e650-59bd-0684-b79a2cb263d4@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <493f3622-e650-59bd-0684-b79a2cb263d4@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 07:11:17PM +0800, Qu Wenruo wrote:
> On 2019/9/26 下午6:11, Johannes Thumshirn wrote:
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> 
> Not related to the patchset itself, but it would be pretty nice if we
> check the sysfs interface to guess if we can mount the fs.
> 
> And if not supported, a warning (at stdout) will not hurt.

We don't do that with any other feature that's selected at mkfs time and
not supported by the running kernel so this would have to be done more
thoroughly, not just for checksums.
