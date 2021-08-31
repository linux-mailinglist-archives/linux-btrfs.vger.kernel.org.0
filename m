Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E43FC7D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhHaNEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 09:04:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36674 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhHaNEx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 09:04:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E99021FE7F;
        Tue, 31 Aug 2021 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630415037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40KWdIk9sKnNCDD6PqSzzQ4bAF8KW7ZqtVaeqCuGTO0=;
        b=tHAeuevGn2WI2h6OHStWauHvG4i/FCUmdPPNAECI5X9H3kNAAg+kDP42JVSGEYS1GJIpW9
        8P9IE0Xq+Tc1VsNvhje11k2w8XGjDdD5FaRe2T/n+L4BE6Xczh+AHnRQYkIkNPDTcRtgs4
        KGZdpDk9mdK/7zavuWAlPcXOjBkp/do=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A38D013A7B;
        Tue, 31 Aug 2021 13:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aUbTJL0oLmEmJQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 31 Aug 2021 13:03:57 +0000
Subject: Re: [PATCH RFC V5 2/2] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     l@damenly.su
References: <cover.1630370459.git.anand.jain@oracle.com>
 <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ca0f8867-74ff-9130-f69f-0f7972540be0@suse.com>
Date:   Tue, 31 Aug 2021 16:03:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.08.21 г. 4:21, Anand Jain wrote:
> btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

That's a moot point, what's important is that btrfs_prepare_sprout
leaves the fs_devices in a consistent state and btrfs_init_new_device
also takes the lock when it's about to modify the devices list, so
that's fine as well. While the patch itself won't do any harm I think
it's irrelevant.

<snip>
