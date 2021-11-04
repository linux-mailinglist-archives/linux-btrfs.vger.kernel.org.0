Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9205445423
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhKDNnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 09:43:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhKDNnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 09:43:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26D10218A9;
        Thu,  4 Nov 2021 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636033244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJg64CbAnTl1j4J98GnzEkHbVetdY4gPeJJv4OQ53hs=;
        b=iKuD3rNcZP1Pd27+9+W9OAi+qyrpb3yrDPFFz1tH3wcp4B0y5ttwydYgiY/8Xmd+dQ+AjH
        vrvDbvb+XPMfcIDyC2f+MF19SlSeqcQ0U95XjcmZYzHW+AoK7jxaxkHwrMTu/12TvHl3Px
        /Hj6fLT2rYum9rmcd2rbUlr81qXYOow=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB7FF13C68;
        Thu,  4 Nov 2021 13:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TE4GN9vig2HwMwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 13:40:43 +0000
Subject: Re: [PATCH 4/4] btrfs: change root to fs_info for
 btrfs_reserve_metadata_bytes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1635450288.git.josef@toxicpanda.com>
 <8027647184fd9180b25055df007ff5476004b62b.1635450288.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <fd152656-d3ec-3d07-cad6-ebc24b3d1dc7@suse.com>
Date:   Thu, 4 Nov 2021 15:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8027647184fd9180b25055df007ff5476004b62b.1635450288.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 22:50, Josef Bacik wrote:
> We used to need the root for btrfs_reserve_metadata_bytes to check the
> orphan cleanup state, but we no longer need that, we simply need the
> fs_info.  Change btrfs_reserve_metadata_bytes() to use the fs_info, and
> change both btrfs_block_rsv_refill() and btrfs_block_rsv_add() to do the
> same as they simply call btrfs_reserve_metadata_bytes() and then
> manipulate the block_rsv that is being used.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
