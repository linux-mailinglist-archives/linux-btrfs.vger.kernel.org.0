Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8B177BF0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgCCQbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 11:31:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCCQbG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 11:31:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1949B36A;
        Tue,  3 Mar 2020 16:31:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59466DA7AE; Tue,  3 Mar 2020 17:30:42 +0100 (CET)
Date:   Tue, 3 Mar 2020 17:30:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/19] btrfs: Move generic backref cache build functions
 to backref.c
Message-ID: <20200303163041.GH2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 03, 2020 at 03:13:50PM +0800, Qu Wenruo wrote:
> The patchset is based on previous backref_cache_refactor branch, which
> is further based on misc-next.
> 
> The whole series can be fetched from github:
> https://github.com/adam900710/linux/tree/backref_cache_code_move
> 
> All the patches in previous branch is not touched at all, thus they are
> not re-sent in this patchset.

The patches are cleanups and code moving, please fix the coding style
issues you find.

* missing lines between declarations and statements
* exported functions need btrfs_ prefix
* comments should start with an upper case letter unless it's an
  identifier, formatted to 80 columns

As this patchset depends on another one I'm not sure if it's right time
to update it now, before the other one is merged as I think the same
code is touched and this would cause extra work.

Overall it makes sensed to add more to backref.[hc] and export that as
an internal API.
