Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11D3449C9E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhKHTnh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:43:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbhKHTng (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:43:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E2CE921976;
        Mon,  8 Nov 2021 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636400450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAB0U75QvAzJcXdBI8Etmwczx88oAyl77uinvtsVVxI=;
        b=b3PsBicHeDKMjgazAeWZcTGYhSfP9zCSrVqu6Oq+PuzRJ+TmAshNMDI9THXX9/kIg3KapO
        VPawdlHlbNQoxCyd1/rcLvIkC7TuDs9ACJh842W4r24a1cEBlCv222F0vRZK9ZN3PE9jh7
        IXDfHJk0nbFiBeFjXbYvVOBmBXmerwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636400450;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAB0U75QvAzJcXdBI8Etmwczx88oAyl77uinvtsVVxI=;
        b=FcaL1DzLnlVmI3sNkomKA4mCBzltvbfQNh5rs621U9vHqge5PKcYd5WkrVofg94HFKPCiN
        8zqYu+SC7S//PaAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D8971A3B84;
        Mon,  8 Nov 2021 19:40:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44DBADA799; Mon,  8 Nov 2021 20:40:12 +0100 (CET)
Date:   Mon, 8 Nov 2021 20:40:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: send: two tiny unused parameter cleanups
Message-ID: <20211108194012.GM28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636070238.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636070238.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 05:00:11PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> I encountered some places where we pass around btrfs_dir_type()
> unnecessarily while I was working on fscrypt support. I might need to
> stuff a flag in btrfs_dir_type() for fscrypt, so using dir_type in less
> places makes it easier to audit that change. Either way, these are
> unused parameters so we should just drop them as a cleanup.
> 
> Omar Sandoval (2):
>   btrfs: send: remove unused found_type parameter to
>     lookup_dir_item_inode()
>   btrfs: send: remove unused type parameter to iterate_inode_ref_t

Added to misc-next, thanks.
