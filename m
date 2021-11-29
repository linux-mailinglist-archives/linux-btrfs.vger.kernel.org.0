Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AD4619E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378869AbhK2Omk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 09:42:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347867AbhK2Oki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 09:40:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6E421709;
        Mon, 29 Nov 2021 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638196635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAq1M0EfufsYxEj0cGJTIegFHRqYev6kiU/B6mvpyqU=;
        b=oOqk/0e4y6iUgH/83aRt3QYO59jLC5fxx3b/xikcMylkgzk1HSYj1cgYOBoOT0+DT9YSt3
        llV7CRDu7oi1poQ+4t9gdtJ+/hkEmfssB0kEv1apSBY1qbhUVr7726aFaJkqUk4cDGGzy5
        pIOlvYyZRkdHXscPkmDTnF94bBaNMEg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 050BA13B15;
        Mon, 29 Nov 2021 14:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q4ruOZrlpGEGBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 29 Nov 2021 14:37:14 +0000
Subject: Re: [BUG] fs: btrfs: several possible ABBA deadlocks
To:     Josef Bacik <josef@toxicpanda.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <44b385ca-f00d-0b47-e370-bd7d97cb1be3@gmail.com>
 <YaQgFhuaQHsND/jr@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8c1f9493-ef50-635e-4426-61120c4b1a86@suse.com>
Date:   Mon, 29 Nov 2021 16:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaQgFhuaQHsND/jr@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.11.21 г. 2:34, Josef Bacik wrote:
> On Sat, Nov 27, 2021 at 04:23:37PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports several possible ABBA deadlocks in the btrfs
>> module in Linux 5.10:
>>
>> # DEADLOCK 1:
>> __clear_extent_bit()
>>   spin_lock(&tree->lock); --> Line 733 (Lock A)
>>   split_state()
>>     btrfs_split_delalloc_extent()
>>       spin_lock(&BTRFS_I(inode)->lock); --> Line 1870 (Lock B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>   find_contiguous_extent_bit()
>>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When __clear_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> # DEADLOCK 2:
>> __set_extent_bit()
>>   spin_lock(&tree->lock); --> Line 995 (Lock A)
>>   set_state_bits()
>>     btrfs_set_delalloc_extent()
>>       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
>> B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>   find_contiguous_extent_bit()
>>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When __set_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> # DEADLOCK 3:
>> convert_extent_bit()
>>   spin_lock(&tree->lock); --> Line 1241 (Lock A)
>>   set_state_bits()
>>     btrfs_set_delalloc_extent()
>>       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
>> B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>   find_contiguous_extent_bit()
>>     spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When convert_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> I am not quite sure whether these possible deadlocks are real and how to fix
>> them if they are real.
>> Any feedback would be appreciated, thanks :)
>>
> 
> Hey Jia-Ju,
> 
> This is pretty good work, unfortunately it's wrong but it's in a subtle way that
> a tool wouldn't be able to catch.  The btrfs_inode_safe_disk_i_size_write()
> helper only messes with BTRFS_I(inode)->file_extent_tree, which is separate from
> the BTRFS_I(inode)->io_tree.  io_tree gets the btrfs_set_delalloc_extent() stuff
> called on it, but the file_extent_tree does not.  The file_extent_tree has
> inode->lock -> tree->lock as the locking order, whereas the file_extent_tree has
> inode->lock -> tree->lock as the locking order.  Thanks,

nit: did you mean to reverse tree->lock ->inode->lock for the
file_extent_tree?

> 
> Josef
> 
