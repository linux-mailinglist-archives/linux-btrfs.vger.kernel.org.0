Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D1423DE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 14:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhJFMlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 08:41:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbhJFMlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 08:41:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8669C1FEB0;
        Wed,  6 Oct 2021 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633523967;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oz4S+EgSjALRj4p34ve87uqJJL+Q7TWz/qOTpOOAYRA=;
        b=IFGQmKJLeayCe+uEqwQAxPATV2PJYeTIdietgSufUs+HV768fxZ/U0U4WzgzIBRh+3jqVW
        ap+Vm4sQKF3pb+N0QXlS6KKPZ3Jhvg+O+VDP+ZsNy+WKdWP/ly3eqVHh7YvSzs4I8OVLcG
        NM7OkfUXtPGZgTVplZCb8ASPy3DR8iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633523967;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oz4S+EgSjALRj4p34ve87uqJJL+Q7TWz/qOTpOOAYRA=;
        b=En1mPjgozmxDb8gsGukk4bgMfcs2mX4RGhSM+NOCBy63m+YJgkQj0I0oX3Z30ZBcR25hHo
        0s4MtzGS4U6r0iAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7BAE1A3B8B;
        Wed,  6 Oct 2021 12:39:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36920DA7F3; Wed,  6 Oct 2021 14:39:07 +0200 (CEST)
Date:   Wed, 6 Oct 2021 14:39:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix missing error handling when replaying
 directory entries
Message-ID: <20211006123906.GP9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1633082623.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1633082623.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 01, 2021 at 01:52:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some places during log replay are ignoring errors when looking up directory
> entries in a subvolume/fs tree. This fixes all those places and makes sure
> we get consistent error hanlding when looking dir items and dir index items.
> 
> Filipe Manana (4):
>   btrfs: deal with errors when checking if a dir entry exists during log replay
>   btrfs: deal with errors when replaying dir entry during log replay
>   btrfs: deal with errors when adding inode reference during log replay
>   btrfs: unify lookup return value when dir entry is missing

Added to misc-next, thanks.
