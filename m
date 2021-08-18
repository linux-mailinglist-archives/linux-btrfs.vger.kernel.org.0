Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1D13F0196
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhHRK1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 06:27:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhHRK1v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 06:27:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ACB871FFA9;
        Wed, 18 Aug 2021 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629282436;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Py6WIz7801K0e4IiAoaq0D1+TSpQ0rbvCigVZ2b/FU=;
        b=YosYNrIBgs0g0M13x1CSGret7Ns5VSq6Jak4XvB2CMfWqGLqxX2EOBUE8CQLCbHL5O1nUq
        FxPyR3anm5vwnfIp0Aa2TdDHGEaaIVWP+XkqYjpodV/wca9vAJtDa5eq8RjkdygVAbcwpu
        boMrY6rptZbEQ/DAwQNfOYbrXlKhSeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629282436;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Py6WIz7801K0e4IiAoaq0D1+TSpQ0rbvCigVZ2b/FU=;
        b=R3kpv9pQwFytDUtRsLdfOD7IPTWFCyG/2INKUP8iYE7a8x1A9pqDmnYJZkx1N4y1HlFJ2D
        rhzOPdIjK0oOY8Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A5BA1A3B99;
        Wed, 18 Aug 2021 10:27:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10FF9DA72C; Wed, 18 Aug 2021 12:24:19 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:24:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
Message-ID: <20210818102419.GQ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210705091643.3404691-1-nborisov@suse.com>
 <eb7458e5-6c4d-c02a-2b81-d12f476822a9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb7458e5-6c4d-c02a-2b81-d12f476822a9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 09:26:54AM +0300, Nikolay Borisov wrote:
> 
> 
> On 5.07.21 г. 12:16, Nikolay Borisov wrote:
> > The user facing function used to allocate new chunks is
> > btrfs_chunk_alloc, unfortunately there is yet another similar sounding
> > function - btrfs_alloc_chunk. This creates confusion, especially since
> > the latter function can be considered "private" in the sense that it
> > implements the first stage of chunk creation and as such is called by
> > btrfs_chunk_alloc.
> > 
> > To avoid the awkwardness that comes with having similarly named but
> > distinctly different in their purpose function rename btrfs_alloc_chunk
> > to btrfs_create_chunk, given that the main purpose of this function is
> > to orchestrate the whole process of allocating a chunk - reserving space
> > into devices, deciding on characteristics of the stripe size and
> > creating the in-memory structures.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Ping

Please refresh the patch and resend, thanks.
