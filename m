Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE342F50B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhJOOUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 10:20:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhJOOUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 10:20:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 206702196F;
        Fri, 15 Oct 2021 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634307490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tI8Bp6Gb/OCOSV+2k3ZUrOO25GsM3zsjJbs5q5J/2fc=;
        b=bfFP4QsV1R5A5dOBcF1Yz9ojZTyodj+PUOUbtpxBuF59tUdLrmxm0et+IoKhD3DYuA7i+I
        ydtHQPCzB8FB4ihk9tuK5AUv0mR9YJwrm17RqB2SEjQqKgBl2tuUiBrfZwUb22MyFhWdsi
        3owlv0HTLnaQbGNuQkemA8eUFLzaYgE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A622013C29;
        Fri, 15 Oct 2021 14:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dkOJqGNaWHMRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Oct 2021 14:18:09 +0000
Subject: Re: [PATCH] btrfs: Simplify conditional in assert
To:     dsterba@suse.cz, Wan Jiabing <wanjiabing@vivo.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net,
        johannes.thumshirn@wdc.com
References: <20211015103639.21838-1-wanjiabing@vivo.com>
 <20211015105154.GC30611@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <62b235b7-a99d-4244-89cf-e6649fbd3dd4@suse.com>
Date:   Fri, 15 Oct 2021 17:18:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015105154.GC30611@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.10.21 г. 13:51, David Sterba wrote:
> Adding Johannes to CC,
> 
> On Fri, Oct 15, 2021 at 06:36:39AM -0400, Wan Jiabing wrote:
>> Fix following coccicheck warning:
>> ./fs/btrfs/inode.c:2015:16-18: WARNING !A || A && B is equivalent to !A || B
>>
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>  fs/btrfs/inode.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index e9154b436c47..da4aeef73b0d 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2011,8 +2011,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>>  		 * to use run_delalloc_nocow() here, like for  regular
>>  		 * preallocated inodes.
>>  		 */
>> -		ASSERT(!zoned ||
>> -		       (zoned && btrfs_is_data_reloc_root(inode->root)));
>> +		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
> 
> The short form is equivalent, but I'm not sure it's also on the same
> level of readability. Repeating the 'zoned' condition check makes it
> obvious on first sight, which is what I'd prefer.
> 
> Johannes if you'd like the new version I'll change it but otherwise I'm
> fine with what we have now.

Just my 2 cents:

The less code we have the better, i.e !zoned is obvious when it's true
i.e when zoned is false. So the way I read teh assert with the short
form is "we are not zoned OR we are (this is implicit) and this is the
data reloc root". Obviously this is personal preference as you deem it's
better  better to have the !zoned || zoned.


> 
>>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>>  					 page_started, nr_written);
>>  	} else if (!inode_can_compress(inode) ||
>> -- 
>> 2.20.1
> 
