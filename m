Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92BB37975F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEJTFp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 15:05:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232055AbhEJTFh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 15:05:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BD62AFC8;
        Mon, 10 May 2021 19:04:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A814CDB228; Mon, 10 May 2021 21:01:58 +0200 (CEST)
Date:   Mon, 10 May 2021 21:01:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: return 0 for dev_extent_hole_check_zoned
 hole_start in case of error
Message-ID: <20210510190158.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <145b97e8743f76c436971d3066d94d5073e7ffa0.1620653896.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145b97e8743f76c436971d3066d94d5073e7ffa0.1620653896.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 10:39:38PM +0900, Johannes Thumshirn wrote:
> Commit 7000babddac6 ("btrfs: assign proper values to a bool variable in
> dev_extent_hole_check_zoned") assigned false to the hole_start parameter
> of dev_extent_hole_check_zoned().
> 
> The hole_start parameter is not boolean and returns the start location of
> the found hole.
> 
> Fixes: 7000babddac6 ("btrfs: assign proper values to a bool variable in dev_extent_hole_check_zoned")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
