Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601EE423DE7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 14:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhJFMoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 08:44:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJFMoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 08:44:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B631B1FEB0;
        Wed,  6 Oct 2021 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633524150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jLFrvbV9bl1rVTmY3I4hXf5P+Ov5/WHPVazuognu1o=;
        b=sWuXp0+IUdb1OK7zCsEs4vbW9VPS5sMaDwn0RJghLbq24OpjSAwDN82k0YDJoB/PB/Fr/c
        3pdEEGxmDnffAs1h8GUSRtuWRfOqZfTOAs1L5aUPsSI+QkuPka+ONM7eUhQ9aSjGPIyJGf
        eHCggNiJeC21OMfPeL1CWzTNzVOD38k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633524150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jLFrvbV9bl1rVTmY3I4hXf5P+Ov5/WHPVazuognu1o=;
        b=RqrSaaS0IAah0LNabcY6jBD+dkXJmNuMjESh8fBq1auTUvb36sDuvTynNSNVaVW3NxLQ9h
        Kw4f5clrh7LmgMCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AF3E4A3B85;
        Wed,  6 Oct 2021 12:42:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5803BDA7F3; Wed,  6 Oct 2021 14:42:10 +0200 (CEST)
Date:   Wed, 6 Oct 2021 14:42:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: check for error when looking up inode during dir
 entry replay
Message-ID: <20211006124210.GQ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <ddfdc77c1d84fecfbbf72811f7eb3a14915610a0.1633091618.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfdc77c1d84fecfbbf72811f7eb3a14915610a0.1633091618.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 01, 2021 at 01:48:18PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At replay_one_name(), we are treating any error from btrfs_lookup_inode()
> as if the inode does not exists. Fix this by checking for an error and
> returning it to the caller.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
