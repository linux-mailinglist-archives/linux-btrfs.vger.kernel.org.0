Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991233D24F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhGVNSG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:18:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53976 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhGVNSE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:18:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2951C203C5;
        Thu, 22 Jul 2021 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626962319;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Hd67O75G23YfWOmhHFu7C+rgmpgF20Fm1VD39BX7zo=;
        b=j87buAfj+KghJ6iHu/An74IudeNvT9mFgaHFrs+L3twWoCqE8ZxvfQ/qrUzHfkAZquNWsj
        +7lCgQcqF4o1HlvPq5fwxe9IO88vPJ/TqGTt3jlNCyoj4iV0AZYc/c81PUXLOpZ5s0xDVF
        WUP6t8VtJVa9yzcBH6R0qqhULTl8jEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626962319;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Hd67O75G23YfWOmhHFu7C+rgmpgF20Fm1VD39BX7zo=;
        b=C6YpgefwekooyYZqDkIi7dkai8UaKwqnhRWAQlyckfBMqOqFSvsd6U4NqCGEc+PvayebGm
        ZV0PevVDRCHqTuDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 21082A48FF;
        Thu, 22 Jul 2021 13:58:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D07FDAF95; Thu, 22 Jul 2021 15:55:57 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:55:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: a few fsync related minor improvements and a
 cleanup
Message-ID: <20210722135557.GV19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1626791500.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:03:39PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patches remove some unnecessary code and bring a couple minor
> performance improvements in the fsync path. They are independent of each other,
> but are grouped in the same pathset just because they relate around the same
> code. The last patch has some performance results in its changelog.
> 
> Filipe Manana (4):
>   btrfs: remove racy and unnecessary inode transaction update when using
>     no-holes
>   btrfs: avoid unnecessary log mutex contention when syncing log
>   btrfs: remove unnecessary list head initialization when syncing log
>   btrfs: avoid unnecessary lock and leaf splits when updating inode in
>     the log

Added to misc-next, thanks.

