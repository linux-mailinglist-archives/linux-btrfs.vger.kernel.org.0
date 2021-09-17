Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0340940F6CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhIQLko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:40:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhIQLko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:40:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F04422412;
        Fri, 17 Sep 2021 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9rOqj49iQc+2znGhedPbmSyAxUB1GTT37J9JxG95bY=;
        b=Z2uxnxDTACdcnTnjL5McFRi9YlM2Zd+gVNl6KvoHI5x86UWz9+9BuCuKy2kiUtHd9Qs9Wc
        ZGuyjwNEOP3XjKVif+XERk/TQuWZVE78LLs+dsVBVtHlhoGjTgWJ6GeKlSNbqgTO9FC7gw
        OroAnlqBfgumAlhM6FbgIIWtDpLbal8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D9rOqj49iQc+2znGhedPbmSyAxUB1GTT37J9JxG95bY=;
        b=vjiTRm+qODttl1OS4od9gZRcVNsTO5UQe2M2Owbs30hj59b9jsB0wBZkbHqytGfzM1BvN+
        zLXUvzDdVuYr7FAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 98099A3B90;
        Fri, 17 Sep 2021 11:39:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10699DA781; Fri, 17 Sep 2021 13:39:12 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:39:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: rename struct btrfs_io_bio to
 btrfs_logical_bio
Message-ID: <20210917113911.GQ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915071718.59418-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 15, 2021 at 03:17:18PM +0800, Qu Wenruo wrote:
> Previously we have "struct btrfs_bio", which records IO context for
> mirrored IO and RAID56, and "strcut btrfs_io_bio", which records extra
> btrfs specific info for logical bytenr bio.
> 
> With "strcut btrfs_bio" renamed to "struct btrfs_io_context", we are
> safe to rename "strcut btrfs_io_bio" to "strcut btrfs_logical_bio" which
> is a more suitable name now.
> 
> Although the name, "btrfs_logical_bio", is a little long and name
> "btrfs_bio" can be much shorter, "btrfs_bio" conflicts with previous
> "btrfs_bio" structure and can cause a lot of problems for backports.
> 
> Thus here we choose the name "btrfs_logical_bio", which also emphasis
> those bios all work at logical bytenr.

After reading through the whole patch I agree with the naming, though
yeah it's a bit long, but we've been using this wordy naming. For
identifiers it's fine to use lbio and it's now clear from the context
that it's about the btrfs-specific features.
