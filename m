Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513F636DE30
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbhD1RYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:24:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhD1RYy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:24:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95BFBAB87;
        Wed, 28 Apr 2021 17:24:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA787DA783; Wed, 28 Apr 2021 19:21:45 +0200 (CEST)
Date:   Wed, 28 Apr 2021 19:21:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove comment for argument seed of
 btrfs_find_device
Message-ID: <20210428172145.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20210425083504.5187-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425083504.5187-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 25, 2021 at 04:35:04PM +0800, Su Yue wrote:
> Commit b2598edf8b36 ("btrfs: remove unused argument seed from
> btrfs_find_device") removed the argument seed from btrfs_find_device
> but forgot the comment, so remove it.
> 
> Signed-off-by: Su Yue <l@damenly.su>

Added to msic-next, thanks.
