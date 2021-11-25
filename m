Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0A45D6ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbhKYJSG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:18:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42034 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348243AbhKYJQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:16:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F022E21B36;
        Thu, 25 Nov 2021 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vmx7r0dWv8p2rGnJFJU4DJVtdqlNT1Nq40He0bfAjg4=;
        b=DSeYbMx6hN4MwZS7xQnlVFwo8gxqMxkq9U9kw9AXQlm0zjeKPijCoeOzJMhfPC9Bvd4L+N
        ZSVijOaVqsVlf81pcTLfMPmNiCAaIRDoDDnGKhWgucEQUyTNI3eXSG07DfOg5H1Q6NyJwG
        2zTuQI/oq9x78zCODPqUVPjGOLobxQY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEAA113F62;
        Thu, 25 Nov 2021 09:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E6j/K5VTn2EqGwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:12:53 +0000
Subject: Re: [PATCH v2 0/3] Metadata IO error fixes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1637781110.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <68f6c31a-72a7-726a-4eba-eb1fa5395278@suse.com>
Date:   Thu, 25 Nov 2021 11:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1637781110.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.11.21 г. 21:14, Josef Bacik wrote:
> v1->v2:
> - I was debugging generic/484 separately because I thought it was data related,
>   but it turned out to be metadata related as well, so I've added the patch
>   "btrfs: call mapping_set_error() on btree inode with a write error" to the
>   series.
> 
> --- Original email ---
> 
> Hello,
> 
> I saw a dmesg failure with generic/281 on our overnight runs.  This turned out
> to be because we weren't getting an error back from btrfs_search_slot() even
> though we found a metadata block that shouldn't have been uptodate.
> 
> The root cause is that write errors on the page clear uptodate on the page, but
> not on the extent buffer itself.  Since we rely on that bit to tell wether the
> extent buffer is valid or not we don't notice that the eb is bogus when we find
> it in cache in a subsequent write, and eventually trip over
> assert_eb_page_uptodate() warnings.
> 
> This fixes the problem I was seeing, I could easily reproduce by running
> generic/281 in a loop a few times.  With these pages I haven't reproduced in 20
> loops.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: clear extent buffer uptodate when we fail to write it
>   btrfs: check the root node for uptodate before returning it
>   btrfs: call mapping_set_error() on btree inode with a write error
> 
>  fs/btrfs/ctree.c     | 19 +++++++++++++++----
>  fs/btrfs/extent_io.c | 14 ++++++++++++++
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 


This is stable material as well, right?
