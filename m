Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B439C8917
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfJBM6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 08:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfJBM6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 08:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78C77AC11;
        Wed,  2 Oct 2019 12:58:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DE01DA88C; Wed,  2 Oct 2019 14:58:56 +0200 (CEST)
Date:   Wed, 2 Oct 2019 14:58:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mark Fasheh <mfasheh@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Relocation/backref cache cleanups
Message-ID: <20191002125855.GM2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Fasheh <mfasheh@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906171533.618-1-mfasheh@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171533.618-1-mfasheh@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 06, 2019 at 10:15:30AM -0700, Mark Fasheh wrote:
> Hi,
> 
> Relocation caches extent backrefs in an rbtree (the 'backref cache').  The
> following patches move the backref cache code out of relocation.c and into
> it's own file.  We then do a straight-forward cleanup the main backref cache
> function, build_backref_tree().  No functionality is changed in these
> patches.
> 
> These patches are part of a larger series I have, which speeds up qgroup
> accounting by using the same backref cache facility.  That series is not
> quite ready, however I wanted to see about getting these cleanup patches
> upstreamed as they are nicely self contained and benefit the readability of
> the code.

Patches 1-3 moved to misc-next.
