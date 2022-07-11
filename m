Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05F457059B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiGKObY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKObU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:31:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A5461D96
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:31:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 205BD1FFD7;
        Mon, 11 Jul 2022 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657549878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGBChuOVsDXfysIbU2c1zuiafHtA5bsz+364RnBFZ18=;
        b=cf7n6SQ/DdugqNZHUYeeexcpiKJ2ooJ71pq98+dgoR1ywGyRO0t1bv9jc7DUf7PUZB1/av
        bkE2+WJKhVAMi6lY4adHty3u0x7chlS/R7yrcBMXODc3Tt4I/Pl4zOGhTQIeKa7IfyD8Lu
        k8qo1gB7JVWpDhP8Z2Zu8iR9HyR1dYk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E160D13524;
        Mon, 11 Jul 2022 14:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ptEPNDU0zGL8SgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Jul 2022 14:31:17 +0000
Message-ID: <022b5a0e-8c1b-873a-e231-8ffd367514d5@suse.com>
Date:   Mon, 11 Jul 2022 17:31:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: set the objectid of the btree inode's location
 key
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1657549024.git.fdmanana@suse.com>
 <92f0a873da8c66fd4b6615a3b2c580d3a410a11f.1657549024.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <92f0a873da8c66fd4b6615a3b2c580d3a410a11f.1657549024.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.07.22 г. 17:22 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We currently don't use the location key of the btree inode, its content
> is set to zeroes, as it's a special inode that is not persisted (it has
> no inode item stored in any btree).
> 
> At btrfs_ino(), an inline function used extensively in btrfs, we have
> this special check if the given inode's location objectid is 0, and if it
> is, we return the value stored in the VFS' inode i_ino field instead
> (which is BTRFS_BTREE_INODE_OBJECTID for the btree inode).
> 
> To reduce the code at btrfs_ino(), we can simply set the objectid of the
> btree inode to the value BTRFS_BTREE_INODE_OBJECTID. This eliminates the
> need to check for the special case of the objectid being zero, with the
> side effect of reducing the overall code size and having less code to
> execute, as btrfs_ino() is an inline function.
> 
> Before:
> 
> $ size fs/btrfs/btrfs.ko
>     text	   data	    bss	    dec	    hex	filename
> 1620502	 189240	  29032	1838774	 1c0eb6	fs/btrfs/btrfs.ko
> 
> After:
> 
> $ size fs/btrfs/btrfs.ko
>     text	   data	    bss	    dec	    hex	filename
> 1617487	 189240	  29032	1835759	 1c02ef	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Cool, that's around 3k of code savings.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
