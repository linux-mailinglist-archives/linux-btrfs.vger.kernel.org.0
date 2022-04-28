Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99377513A00
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350156AbiD1QmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350135AbiD1QmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 12:42:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791DB1AAE
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 09:39:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECCF32186F;
        Thu, 28 Apr 2022 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651163945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2TmFmSIL53uabjQebuz6tYD9bn6oz029GAhw5r8YT0=;
        b=rD0fjXH7VHHh7pcEtZutWJDn8sLLVVJc6ygwiopYGr14OenDzL8IJOgILmJ1pYeZUSfvbr
        tNv4uilq3ZXBOC3pwD4bGMZZW0dD6dqM5LoOZWtVlBhhir2giLQHPwezcsPNkqfDVFAatD
        I3FyGamncJ1+Nd3GtCU4h2CoJNsDMWs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBD9213AF8;
        Thu, 28 Apr 2022 16:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIj6KinDamI3JwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Apr 2022 16:39:05 +0000
Message-ID: <ee0f90b6-5980-e628-add0-daa6ac0bb525@suse.com>
Date:   Thu, 28 Apr 2022 19:39:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] btrfs: improve error reporting in
 lookup_inline_extent_backref
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20220428131449.792353-1-nborisov@suse.com>
 <YmqvviNRmr+N8NFJ@debian9.Home>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <YmqvviNRmr+N8NFJ@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.04.22 г. 18:16 ч., Filipe Manana wrote:
> On Thu, Apr 28, 2022 at 04:14:49PM +0300, Nikolay Borisov wrote:
>> When iterating the backrefs in an extent item if the ptr to the
>> 'current' backref record goes beyond the extent item a warning is
>> generated and -ENOENT is returned. However what's more appropriate to
>> debug such cases would be to return EUCLEAN and also print identifying
>> information about the performed search as well as the current content of
>> the leaf containing the possibly corrupted extent item.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>
>> V4:
>>   * Also print the value of 'parent' as it's pertinent when metadata inline backrefs
>>   are being searched (Filipe)
>>   * Print the leaf before printing the error message so that the latter is
>>   not lost (Filipe)
>>
>> V3:
>>   * Fixed format for the btree slot
>>   * Removed redundant argument passed to format string
>>
>>   fs/btrfs/extent-tree.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 963160a0c393..cae2ef560f3f 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -895,7 +895,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>   	err = -ENOENT;
>>   	while (1) {
>>   		if (ptr >= end) {
>> -			WARN_ON(ptr > end);
>> +			if (ptr > end) {
>> +				err = -EUCLEAN;
>> +				btrfs_print_leaf(path->nodes[0]);
>> +				btrfs_crit(fs_info,
>> +"overrun extent record at slot %d [%llu BTRFS_EXTENT_ITEM_KEY %llu] while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
>> +				path->slots[0], bytenr, num_bytes,
> 
> The key being printed is misleading, as it will often be incorrect.
> 
> First the type is not always BTRFS_EXTENT_ITEM_KEY, it can also be
> BTRFS_METADATA_ITEM_KEY.
> 
> Secondly, the offset's value is not always 'num_bytes', it can also be 'owner'.
> 
> So it's better to just print the key as "%llu %u %llu" and using key.objectid,
> key.type and key.offset. Or just leave the key from the message since we have
> printed the slot, and therefore it's redundant. Either option is fine for me.

Fair enough, I'd go with the slot since it will make the string line 
shorter in any case.

> 
> Sorry, I missed this before and I hate to have to make you send another version.
> 
> With that fixed,
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>> +				root_objectid, owner, offset, parent);
>> +			}
>>   			break;
>>   		}
>>   		iref = (struct btrfs_extent_inline_ref *)ptr;
>> --
>> 2.25.1
>>
> 
