Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26AE241C25
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 16:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgHKON6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 10:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgHKON6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:13:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0C46AECB;
        Tue, 11 Aug 2020 14:14:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7498ADA83C; Tue, 11 Aug 2020 16:12:55 +0200 (CEST)
Date:   Tue, 11 Aug 2020 16:12:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs: super.c: Set compress_level=0 when using
 compress=lzo
Message-ID: <20200811141255.GR2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200803195501.30528-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803195501.30528-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 04:55:01PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Currently a user can set mount "-o compress" which will set the
> compression algorithm to zlib, and use the default compress level for
> zlib (3):
> 
> relatime,compress=zlib:3,space_cache
> 
> If the user remounts the fs using "-o compress=lzo", then the old
> compress_level is used:
> 
> relatime,compress=lzo:3,space_cache
> 
> But lzo does not exposes any tunable compress level. The same happens if we set
> any compress argument with different level, even with zstd.
> 
> Fix this issue by resetting the compress_level when compress=lzo is specified.
> With the fix applied, lzo is shown without compress level, even after remounting
> from zlib or zstd:
> 
> relatime,compress=lzo,space_cache
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  I found this issue while testing mount options. Should we tag this fix for
>  stable since the introduction of the compress_level, or is it no worthy?

I'll tag it for stable, it's user-visible and confusing. Thanks.
