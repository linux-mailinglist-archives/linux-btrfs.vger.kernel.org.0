Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71EF472B36
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhLMLWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 06:22:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhLMLWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 06:22:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F9AF212B6;
        Mon, 13 Dec 2021 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639394540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBTlYPzoQIemSfEWzHuwhSI/x8bWZptlNGMyOt4tjgY=;
        b=JISBhyZ8cChx4KUHoNiXU2DnUB/Y3hp0ftSGFvhGkvzyzdE+IZb0IPDOLQoMjYsJQsLHVk
        tVpBLjZnJXNWTwqruS+R/gnBAjKhB/ZcnVR13us8XL8qIzEuXXCE5OHWymiQZ3E5JNU10f
        bnWfIcPBVfQ3ehbsfcY4GbWh6CSa5K8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63E5C13AFF;
        Mon, 13 Dec 2021 11:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DnRdFewst2HaVgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Dec 2021 11:22:20 +0000
Subject: Re: [PATCH 0/3] btrfs: fixes for an error path when creating a
 subvolume
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1639384875.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ad13deb8-a5cf-7a4f-9866-046d1413cce7@suse.com>
Date:   Mon, 13 Dec 2021 13:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1639384875.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.12.21 г. 10:45, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patches fix an error path when creating a subvolume, exposed
> by generic/475.
> 
> Filipe Manana (3):
>   btrfs: fix invalid delayed ref after subvolume creation failure
>   btrfs: fix warning when freeing leaf after subvolume creation failure
>   btrfs: skip transaction commit after failure to create subvolume
> 
>  fs/btrfs/ctree.c           | 17 +++++++++--------
>  fs/btrfs/ctree.h           |  7 ++++++-
>  fs/btrfs/extent-tree.c     | 13 +++++++------
>  fs/btrfs/free-space-tree.c |  4 ++--
>  fs/btrfs/ioctl.c           | 18 ++++++++++--------
>  fs/btrfs/qgroup.c          |  3 ++-
>  6 files changed, 36 insertions(+), 26 deletions(-)
> 

For the whole series :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
