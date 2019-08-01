Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452307DE11
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfHAOiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 10:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731530AbfHAOiy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 10:38:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40E04B66E;
        Thu,  1 Aug 2019 14:38:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CDEBBDA7D9; Thu,  1 Aug 2019 16:39:11 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:39:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: remove unnecessary condition in btrfs_clone() to
 avoid too much nesting
Message-ID: <20190801143909.GU28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190702142307.3334-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702142307.3334-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 02, 2019 at 03:23:07PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The bulk of the work done when cloning extents, at ioctl.c:btrfs_clone(),
> is done inside an if statement that checks if the found key has the type
> BTRFS_EXTENT_DATA_KEY. That if statement is redundant however, because
> btrfs_search_slot() always leaves us in a leaf slot that points to a key
> that is always greater then or equals to the search key, and our search
> key here has that type, and because we bail out before that if statement
> if the key at the given leaf slot is greater then BTRFS_EXTENT_DATA_KEY.
> 
> Therefore just remove that if statement, not only because it is useless
> but mostly because it increases the nesting/indentation level in this
> function which is quite big and makes things a bit awkward whenever I need
> to fix something that requires changing btrfs_clone() (and it has been
> like that for many years already).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
