Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D130484586
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiADPzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 10:55:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiADPzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 10:55:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8F3C221108;
        Tue,  4 Jan 2022 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641311702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRGfq/dG0mgTawz4CV0izOTWLV7TeVr/NHsLZTWzG+g=;
        b=UNjopWRPCEUKbQPHspa4PrNJIPxizIzUsX4u3bAUTYmF1W6f8uh2LrMrHSZokLgC2Fc6vu
        q7OCnjMspGL7LFE9ImRyxrR28yfyU3n5w8+9zsI8I1pSIDqBDJJzKGtvIbwwUtliuXQ2rV
        Yn6Q9QsltZD71hMJCorPSNym6142V4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641311702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRGfq/dG0mgTawz4CV0izOTWLV7TeVr/NHsLZTWzG+g=;
        b=TL+hMMrjTvou48cEBe0iM1KvtFRhO4x9AXyqU9aHMCdhhqBkYVsQEZ7gOkfyOHLuapnOe0
        /V1WMDb/VSNP4JDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 888D0A3B8A;
        Tue,  4 Jan 2022 15:55:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E6B8DA729; Tue,  4 Jan 2022 16:54:33 +0100 (CET)
Date:   Tue, 4 Jan 2022 16:54:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove write and wait of struct walk_control
Message-ID: <20220104155433.GT28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <a67495dc1ec5616c5ad09d6a0a761ae1d518ab06.1641300202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67495dc1ec5616c5ad09d6a0a761ae1d518ab06.1641300202.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 12:53:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The ->write and ->wait fields of struct walk_control, used for log trees,
> are not used since 2008, more specifically since commit d0c803c4049c5c
> ("Btrfs: Record dirty pages tree-log pages in an extent_io tree") and
> since commit d0c803c4049c5c ("Btrfs: Record dirty pages tree-log pages in
> an extent_io tree"). So just remove them, along with the function
> btrfs_write_tree_block(), which is also not used anymore after removing
> the ->write member.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
