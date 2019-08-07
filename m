Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7684E5E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfHGOPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 10:15:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729408AbfHGOPE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 10:15:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E04FB02C;
        Wed,  7 Aug 2019 14:15:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8881DA7D7; Wed,  7 Aug 2019 16:15:34 +0200 (CEST)
Date:   Wed, 7 Aug 2019 16:15:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix sysfs warning and missing raid sysfs
 directories
Message-ID: <20190807141534.GU28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190807102146.28008-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807102146.28008-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 11:21:46AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
... 
> Fixes: 75cb379d263521 ("btrfs: defer adding raid type kobject until after chunk relocation")
> Fixes: 7c7e301406d0a9 ("btrfs: sysfs: Replace default_attrs in ktypes with groups")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for the write up. With the memalloc save/restore it's easier to
handle things inside sysfs callbacks, this was not possible before, the
code simplification is welcome.

The sysfs warnings were the last thing on my list of new problems in
5.3, or at least the most noticeable ones.

Reviewed-by: David Sterba <dsterba@suse.com>
