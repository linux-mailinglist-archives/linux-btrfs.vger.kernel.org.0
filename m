Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6E1FB145
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgFPM4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 08:56:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPM4t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 08:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD400AEF6;
        Tue, 16 Jun 2020 12:56:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CCC18DA7C3; Tue, 16 Jun 2020 14:56:38 +0200 (CEST)
Date:   Tue, 16 Jun 2020 14:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: remove no longer used log_list member of
 struct btrfs_ordered_extent
Message-ID: <20200616125638.GZ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200615093648.287105-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615093648.287105-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 10:36:48AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The 'log_list' member of an ordered extent was used keep track of which
> ordered extents we needed to wait after logging metadata, but is not used
> anymore since commit 5636cf7d6dc86f ("btrfs: remove the logged extents
> infrastructure"), as we now always wait on ordered extent completion
> before logging metadata. So just remove it since it's doing nothing and
> making each ordered extent structure waste more memory (2 pointers).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
