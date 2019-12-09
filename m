Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5DC117140
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLIQOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 11:14:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfLIQOr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 11:14:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40283ACE0;
        Mon,  9 Dec 2019 16:14:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67BA4DA783; Mon,  9 Dec 2019 17:14:39 +0100 (CET)
Date:   Mon, 9 Dec 2019 17:14:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix removal logic of the tree mod log that leads
 to use-after-free issues
Message-ID: <20191209161439.GK2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191206122739.27195-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206122739.27195-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 06, 2019 at 12:27:39PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a tree mod log user no longer needs to use the tree it calls
> btrfs_put_tree_mod_seq() to remove itself from the list of users and
> delete all no longer used elements of the tree's red black tree, which
> should be all elements with a sequence number less then our equals to
> the caller's sequence number. However the logic is broken because it
> can delete and free elements from the red black tree that have a
> sequence number greater then the caller's sequence number:

Added to misc-next, thanks.
