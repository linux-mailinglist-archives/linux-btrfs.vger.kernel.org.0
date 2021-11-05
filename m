Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072944461FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhKEKQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:16:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51862 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhKEKQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 06:16:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EA091FD36;
        Fri,  5 Nov 2021 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636107236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmJxL+Y3cqu3AzD1ZVpTkUW9QquBrP+Me1L15mSYl6w=;
        b=jBaOzUeuzR1/SRYjTKoUvOPpiy9y81vZ+moZsQCD121m9xzKaaAOvp1OtSuFtw0CDPKaLI
        e3Hrl1BxrMiX1bR+wHiiVpXM5IrdhVo0jWl5rP1QCZw5tjEBZeXo3tec+g0P59Lq1pBsMy
        kIBObQVwQq+AHRPmOIuyWxF0wIQTPis=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E52B13FE2;
        Fri,  5 Nov 2021 10:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CxzTCOQDhWEpfQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 10:13:56 +0000
Subject: Re: [PATCH 0/2] btrfs: send: two tiny unused parameter cleanups
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1636070238.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3b0340a8-5f3a-d116-cdcb-b5e44d2f3990@suse.com>
Date:   Fri, 5 Nov 2021 12:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1636070238.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 2:00, Omar Sandoval wrote:
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
> 
>  fs/btrfs/send.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
