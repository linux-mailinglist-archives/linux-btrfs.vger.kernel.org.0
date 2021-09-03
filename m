Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3594000E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhICODL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:03:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhICODL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:03:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E128E225AC;
        Fri,  3 Sep 2021 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630677728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JX4YmXBXM9tXdQ7SFyABMhbYlPPumW2TGTcOVOnC3mM=;
        b=Nf4ByWELm/jL6FLxTZC6cEFX0w6pjRY5H6DwCIWXScL66VOKb2NMNlz3uHMTKNLvYoDQV6
        2aYCZcKLQYhrcXJTV8SySQHB1QKJgl14bTsQUq6ae09BNAfwd7qVgkh3HpBp3DaK0sA6T/
        izyubMBJApZR9n2PEiVfjA1V0b5o3a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630677728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JX4YmXBXM9tXdQ7SFyABMhbYlPPumW2TGTcOVOnC3mM=;
        b=/J7L68pld99KUq7TSs2kzhVHswowbtFoLTVwt70J483HU/LDZulmzPdRuYZbRO2+0oG/VH
        STx9J8zRaWClBgCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DB3E0A3B97;
        Fri,  3 Sep 2021 14:02:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 295A8DA89C; Fri,  3 Sep 2021 16:02:07 +0200 (CEST)
Date:   Fri, 3 Sep 2021 16:02:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: use btrfs_key for btrfs_check_node()
 and btrfs_check_leaf()
Message-ID: <20210903140207.GE3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902130843.120176-1-wqu@suse.com>
 <20210902130843.120176-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902130843.120176-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 02, 2021 at 09:08:41PM +0800, Qu Wenruo wrote:
> In kernel space we hardly use btrfs_disk_key, unless for very lowlevel
> code.
> 
> There is no need to intentionally use btrfs_disk_key in btrfs-progs
> either.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This fails on fsck/001 test

    [TEST/fsck]   001-bad-file-extent-bytenr
failed to restore image ./default_case.img
basename: missing operand
Try 'basename --help' for more information.
failed: /labs/dsterba/gits/btrfs-progs/btrfs check --repair --force
make: *** [Makefile:413: test-fsck] Error 1
