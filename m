Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17F450994
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKOQ3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 11:29:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43368 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhKOQ3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 11:29:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A2461FD63;
        Mon, 15 Nov 2021 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636993580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29Qp/aFhzb3VWMvxSIOo0kqD3JexXYu/zo4pN7hkMGM=;
        b=AHptIkpsdXWWDFn1jcZ0y3pHS6Bxs3BGuaCcAlCuggjjloy/xIjbb/ATM3SS8+5of1c/lh
        muzGppepuYqfV8+XEk3O5Uh6SEp1XrcZhjU/Vs/p8CzEC3MDijq681N3hSCnZ2aKjAtz9t
        wZlkWMHEBBHAIgctvkyjWNQ9oxKql+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636993580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29Qp/aFhzb3VWMvxSIOo0kqD3JexXYu/zo4pN7hkMGM=;
        b=NENmsHyf0TFEzht8fFjzg/q2DPcR1a6YmUcoIHXdbmPdUpIGEPdQenp5Z6ajQUxJ0XE6TV
        +DLxJZ4QsYyx1sCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93304A3B81;
        Mon, 15 Nov 2021 16:26:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A83ADA781; Mon, 15 Nov 2021 17:26:17 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:26:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Don't reset ratio to 1 if we don't have
 RAID56 profile
Message-ID: <20211115162617.GK28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211115091542.200657-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115091542.200657-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 15, 2021 at 11:15:42AM +0200, Nikolay Borisov wrote:
> Commit 80714610f36e ("btrfs-progs: use raid table for ncopies")
> slightly broke how raid ratio are being calculated since the resulting
> code would always reset ratio to be 1 in case we didn't have RAID56
> profile. The correct behavior is to simply set it to 0 if we have RAID56
> as the calculation is different in this case and leave it intact
> otherwise.
> 
> This bug manifests by doing all size-related calculation for
> 'btrfs filesystem usage' command as if all block groups are of type SINGLE. Fix
> this by only reseting ratio 0 in case of RAID56.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.
