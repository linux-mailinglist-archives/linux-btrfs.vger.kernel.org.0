Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0C33DA02
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhCPRBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 13:01:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237040AbhCPRAx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 13:00:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BC6DAC23;
        Tue, 16 Mar 2021 17:00:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D5DE6DA6E2; Tue, 16 Mar 2021 17:58:50 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:58:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/9] btrfs: bug fixes for the tree mod log and small
 refactorings
Message-ID: <20210316165850.GK7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 02:31:04PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes a couple bugs, in the two first patches, with the tree
> mod log code. The remaining patches just move all that code into a separate
> file, since it's quite large and ctree.c is huge as well, and do some small
> refactorings and cleanups.

Great, thanks. Patchset moved from for-next to misc-next.
