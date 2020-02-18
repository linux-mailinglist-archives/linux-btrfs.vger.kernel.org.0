Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951E01629CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRPt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 10:49:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:51730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRPt4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 10:49:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45028B4DC;
        Tue, 18 Feb 2020 15:49:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 762CEDA7BA; Tue, 18 Feb 2020 16:49:36 +0100 (CET)
Date:   Tue, 18 Feb 2020 16:49:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH] Btrfs: avoid unnecessary splits when setting bits on an
 extent io tree
Message-ID: <20200218154935.GO2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <20200213102002.6176-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213102002.6176-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 13, 2020 at 10:20:02AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When attempting to set bits on a range of an exent io tree that already
> has those bits set we can end up splitting an extent state record, use
> the preallocated extent state record, insert it into the red black tree,
> do another search on the red black tree, merge the preallocated extent
> state record with the previous extent state record, remove that previous
> record from the red black tree and then free it. This is all unnecessary
> work that consumes time.
[...]

Added to misc-next, thanks.
