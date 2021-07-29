Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBC3DA1CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhG2LL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 07:11:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43708 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhG2LLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 07:11:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1E639223FB;
        Thu, 29 Jul 2021 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627557112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MV2X2RkNVEW1+r/uH7YFJ8Ll+IjYycBHCKM7QDtiblg=;
        b=cy/YbDJ9P9EExO+y9TqVnT/0R7AVw9lwWeDCQ1nkcjQx9E88F0OydCZYKGQLJZ/5whMziV
        1a1W5kx3PlOIQWq9nkjfl4rBRtRmyvbEqBHuyB9rWGz+QdXk4FJQ71UV6x81sgqkva66wG
        G28Ayuktt6Hro4Qpw1QGZyFhJz7uLXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627557112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MV2X2RkNVEW1+r/uH7YFJ8Ll+IjYycBHCKM7QDtiblg=;
        b=QDx6zWpMMD9VW+JFBSyF428zzirjd9nEzKqPqgIJ++4Zmv/N98dz1+Go3CSjo4vZeCBVg2
        rrdBlQeQbTPdaGCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 14FF2A3B81;
        Thu, 29 Jul 2021 11:11:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C278DA7AF; Thu, 29 Jul 2021 13:09:06 +0200 (CEST)
Date:   Thu, 29 Jul 2021 13:09:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: Introduce btrfs_search_backwards function
Message-ID: <20210729110905.GU5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210729082216.22886-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729082216.22886-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 05:22:16AM -0300, Marcos Paulo de Souza wrote:
> It's a common practice to start a search using offset (u64)-1, which is
> the u64 maximum value, meaning that we want the search_slot function to
> be set in the last item with the same objectid and type.
> 
> Once we are in this position, it's a matter to start a search backwards
> by calling btrfs_previous_item, which will check if we'll need to go to
> a previous leaf and other necessary checks, only to be sure that we are
> in last offset of the same object and type.
> 
> The new btrfs_search_backwards function does the all these procedures when
> necessary, and can be used to avoid code duplication.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to misc-next, thanks.
