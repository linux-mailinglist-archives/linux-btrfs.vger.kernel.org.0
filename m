Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958EE11033D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 18:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCRQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 12:16:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:49232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfLCRQn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 12:16:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DDA2B2039;
        Tue,  3 Dec 2019 17:16:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20E6ADA7D9; Tue,  3 Dec 2019 18:16:37 +0100 (CET)
Date:   Tue, 3 Dec 2019 18:16:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] 3 misc patches
Message-ID: <20191203171637.GQ2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191121120331.29070-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121120331.29070-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 21, 2019 at 02:03:28PM +0200, Nikolay Borisov wrote:
> Here are 3 misc patches. First one is an optimsation to prevent issuing discards
> for reserved but not written extents. The other 2 simply get rid of
> __btrfs_free_reserved_extent by moving its relevant parts to the two wrappers.
> 
> Nikolay Borisov (3):
>   btrfs: Don't discard unwritten extents
>   btrfs: Open code __btrfs_free_reserved_extent in
>     btrfs_free_reserved_extent
>   btrfs: Rename __btrfs_free_reserved_extent to
>     btrfs_pin_reserved_extent

Added to misc-next, thanks.
