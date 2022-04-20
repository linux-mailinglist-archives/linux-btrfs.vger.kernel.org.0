Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57E508CB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355522AbiDTQE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355484AbiDTQE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 12:04:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460EE10FE7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 09:01:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F157C21115;
        Wed, 20 Apr 2022 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650470500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08xdQnkHQ7zg17IqP2l0rbFhrP7Q7YY/ZdcRnyq81Gs=;
        b=M/5ysDMzXtK4FJPm8DXmLEsGVAGaPQtr764ocjlZ2x1ikrXyvySRU06RF493I+j6c7lM0e
        ABQjUYOSp8to7uGfHJm42f/CTciZvcBoTQHaCOMDj/ZbpTxl4hVihmEozayEaST5IE3xmM
        Aij1h+URhvv/xJXLtknbRI95NoV+HlA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C419813AD5;
        Wed, 20 Apr 2022 16:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kpvkLGQuYGIRQwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Apr 2022 16:01:40 +0000
Message-ID: <5e41366f-c257-cc82-288e-4cf6cc9ca20a@suse.com>
Date:   Wed, 20 Apr 2022 19:01:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Improve error reporting in
 lookup_inline_extent_backref
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220420115401.186147-1-nborisov@suse.com>
 <20220420155445.GH1513@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220420155445.GH1513@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.04.22 г. 18:54 ч., David Sterba wrote:
> On Wed, Apr 20, 2022 at 02:54:00PM +0300, Nikolay Borisov wrote:
>> When iterating the backrefs in an extent item if the ptr to the
>> 'current' backref record goes beyond the extent item a warning is
>> generated and -ENOENT is returned. However what's more appropriate to
>> debug such cases would be to return EUCLEAN and also print the in-memory
>> state of the offending leaf.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   fs/btrfs/extent-tree.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 963160a0c393..5a53bcfdca83 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -895,7 +895,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>   	err = -ENOENT;
>>   	while (1) {
>>   		if (ptr >= end) {
>> -			WARN_ON(ptr > end);
>> +			if (WARN_ON(ptr > end)) {
>> +				err = -EUCLEAN;
>> +				btrfs_print_leaf(path->slots[0]);
> 
> This gives a warning, the slots array does not contain the extent buffer
> pointer so this should have been path->nodes[0] but this is already in
> 'leaf', fixed.
> 

Ah you are right... should have been ->nodes[0] not slot...

