Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB8D4677DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhLCNNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 08:13:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60656 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhLCNNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 08:13:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85CA3218D5;
        Fri,  3 Dec 2021 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638536998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMZ225wBCu0a3V0Jfh7DBupgI9G4QmplnrOWOlPtlGY=;
        b=eQUVGkKBOH42g1Em7rbUvPqmPBPQumAcTUYGs3Kn1rzCi2pQX/iMeZtkazwryogAo3X7wz
        /96WfKUOT54yJaVHfGsqWzuZR2GG6uCNJcASyJyAzyawYdmHdh457P72iVZFXTQX5Usnmc
        OUUTKLCxM568tBsflcz3WlUJWCZAC00=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FF9E13DC9;
        Fri,  3 Dec 2021 13:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AukDCYXqmF0WQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 03 Dec 2021 13:09:58 +0000
Subject: Re: [PATCH v2 0/2] Free space tree space reservation fixes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1638477127.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c74b734d-8586-8d96-2f09-9736d1004189@suse.com>
Date:   Fri, 3 Dec 2021 15:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1638477127.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.12.21 г. 22:34, Josef Bacik wrote:
> v1->v2:
> - Updated the changelog for "btrfs: reserve extra space for free space tree" to
>   make it clear why we're doubling the space reservation per Nikolay's request.
> 
> --- Original email ---
> Hello,
> 
> Filipe reported a problem where he was getting an ENOSPC abort when running
> delayed refs for generic/619.  This is because of two reasons, first generic/619
> creates a very small file system, and our global block rsv calculation doesn't
> take into account the size of the free space tree.  Thus we could get into a
> situation where the global block rsv was not enough to handle the overflow.
> 
> The second is because we simply do not reserve space for the free space tree
> modifications.  Fix this by making sure any free space tree root has their block
> rsv set to the delayed refs rsv, and then make sure if we have the free space
> tree enabled we're reserving extra space for those operations.
> 
> With these patches the problem Filipe was hitting went away.  Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: include the free space tree in the global rsv minimum
>     calculation
>   btrfs: reserve extra space for the free space tree
> 
>  fs/btrfs/block-rsv.c   | 31 ++++++++++++++++++-------------
>  fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 


For the whole series:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
