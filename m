Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B149E463D99
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhK3SWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 13:22:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhK3SWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 13:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FFEC1FD5A;
        Tue, 30 Nov 2021 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638296359;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xu6G/jIe376af422z5mwXcRCYkU61pgaGW79LNwJjwo=;
        b=ZXhs2qv+ILfgyzqap73uKOhnBecGFd9CT88150EuBlHtMJJX3ThQF6Y8H/wp/EMb5Rf3JA
        sEH5yQ48Hbcqn5aJJk/lMEZLW01GEa35xgGiHE3mhlrUpwPdLP4ARonWjS6jDcpkwZ/bo0
        8OHgqFyIXRnxXoMh19KGCe6ENtibCBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638296359;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xu6G/jIe376af422z5mwXcRCYkU61pgaGW79LNwJjwo=;
        b=VdMmvC6ma/Il61p8lD8Z0Fucx/nAhyNfqbx0q+ZnUe6XEeo/4P1c7QDoeS0MCsPSlYX/v5
        XvAl/cY0lLV8sbCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 28097A3B83;
        Tue, 30 Nov 2021 18:19:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 310CADA799; Tue, 30 Nov 2021 19:19:08 +0100 (CET)
Date:   Tue, 30 Nov 2021 19:19:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: check: change commit condition in
 fixup_extent_refs()
Message-ID: <20211130181907.GM28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20211104141610.48818-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104141610.48818-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 02:16:10PM +0000, Sidong Yang wrote:
> This patch fixes potential bugs in fixup_extent_refs(). If
> btrfs_start_transaction() fails in some way and returns error ptr, It
> goes to out logic. But old code checkes whether it is null and it calls
> commit. This patch solves the problem with make that it calls only if
> ret is no error.
> 
> Issue: #409
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Added to devel, thanks.
