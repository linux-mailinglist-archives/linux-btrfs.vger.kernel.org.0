Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE53FF1E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbhIBQ53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 12:57:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhIBQ52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 12:57:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 60C1C1FFC5;
        Thu,  2 Sep 2021 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630601787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=df7HzHyVYApHRZEulGEy86znFm2/rkvsmZIQ8fZ3e5Y=;
        b=GXXBbYZfEgu1GrwhEWOWlyk8yvBWfh5NCRmqHQKhF8mW3mxijeEaM+gIA42ffbZR3ogtnO
        R4Be/tzjmnpcH7Q+pGSKfnfi4MB15Vu4wCmoaUvJfgUPBfdaeInNyOsg8NSc23w2bUkqPm
        p4hnnjX24mRb8twnILZYLq97RF4nlGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630601787;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=df7HzHyVYApHRZEulGEy86znFm2/rkvsmZIQ8fZ3e5Y=;
        b=dNZyeRKtH1Lmc7H9/InM1beffsunlmifXKyEIVSVELqP++FJn1s/J6CnFDLWVJ7HlkYCfp
        FbiEOob6A718YwDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 59C65A3BB7;
        Thu,  2 Sep 2021 16:56:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 290CFDA72B; Thu,  2 Sep 2021 18:56:26 +0200 (CEST)
Date:   Thu, 2 Sep 2021 18:56:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: set of small optimizations for inode logging
Message-ID: <20210902165625.GB3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 03:30:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset adds a few optimizations for inode logging, along
> with some necessary refactorings/cleanups to be able to implement them.
> Test results are in the change log of the last patch.
> 
> Filipe Manana (10):
>   btrfs: check if a log tree exists at inode_logged()
>   btrfs: remove no longer needed checks for NULL log context
>   btrfs: do not log new dentries when logging that a new name exists
>   btrfs: always update the logged transaction when logging new names
>   btrfs: avoid expensive search when dropping inode items from log
>   btrfs: add helper to truncate inode items when logging inode
>   btrfs: avoid expensive search when truncating inode items from the log
>   btrfs: avoid search for logged i_size when logging inode if possible
>   btrfs: avoid attempt to drop extents when logging inode for the first time
>   btrfs: do not commit delayed inode when logging a file in full sync mode

Added to misc-next, thanks.
