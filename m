Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E638A3F8786
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhHZMbw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 08:31:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55932 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbhHZMbv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 08:31:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 669C7222EC;
        Thu, 26 Aug 2021 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629981063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoJy1aMcnGz2d5BI1Oq7+rN51mM6Kykn/IiK3JHfpQc=;
        b=GmrnlHNpdeoNTre8EFkdNjHGJYxa+5nJJl7KodVeGOB4fwJljnLy5X2fY3PdwQxXPHkJ9m
        oRf9j6r7LDcfvJ+HvyNmTIwb3J29uoIHN6nrgLMdi7RGWcJrMoKB5de6gIGEpzDgIB+3Lk
        rWSV+f8G8eaA8KX5UHGTOaiyba/y9ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629981063;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoJy1aMcnGz2d5BI1Oq7+rN51mM6Kykn/IiK3JHfpQc=;
        b=VQleSbXDrc6Y5yl8+WndMVutLTut54Kx/ZR5X8A7JDA5f6ccQBqwujZC0myHOb7q+JbLw0
        OH6snjycsrLRgfCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 608B6A3B8B;
        Thu, 26 Aug 2021 12:31:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A8F1DA7FB; Thu, 26 Aug 2021 14:28:15 +0200 (CEST)
Date:   Thu, 26 Aug 2021 14:28:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: check: enhance the csum mismatch error
 message
Message-ID: <20210826122815.GL3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210826064036.21660-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826064036.21660-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 02:40:33PM +0800, Qu Wenruo wrote:
> This patchset will change the csum mismatch error message for data csum
> mismatch, from the old almost meaningless output:
> 
>   [5/7] checking csums against data
>   mirror 1 bytenr 13631488 csum 19 expected csum 152 <<<
>   ERROR: errors found in csum tree
> 
> To a more human readable output:
> 
>   [5/7] checking csums against data
>   mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625
>   ERROR: errors found in csum tree
> 
> Qu Wenruo (3):
>   btrfs-progs: move btrfs_format_csum() to common/utils.[ch]
>   btrfs-progs: slightly enhance btrfs_format_csum()
>   btrfs-progs: check: output proper csum values for --check-data-csum

Nice, added to devel, thanks.
