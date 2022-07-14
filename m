Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392B5750B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiGNOZA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiGNOZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 10:25:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BD10FDB
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 07:24:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 467B41FB52;
        Thu, 14 Jul 2022 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657808697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xROBxViO2g7SMC1ogBgfjuwurqFibRDm9c+N4NX6/R8=;
        b=PejgWDLAxDa677vD7YLd7FPYo2b3rpqHcLxTTDeMMgDgkJRGOeK3AjdK36yJijhjHvccfa
        noCJGLEHSTe1Zg3+y2wBso8UtuR+566nhvRbftu2Y+jbb/5WCcYaxo8KRCN2qYoHHgIDWO
        1Wto+cvM3ElOcQCrZg8hzCEayEP8N6Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA427133A6;
        Thu, 14 Jul 2022 14:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dchjNjgn0GIVMwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Jul 2022 14:24:56 +0000
Message-ID: <7b341fd2-2766-7c86-6752-2e060751c05a@suse.com>
Date:   Thu, 14 Jul 2022 17:24:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Content-Language: en-US
To:     dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <698582cc-00b2-7cca-f5a2-e8e238de053c@suse.com>
 <20220714131344.GL15169@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220714131344.GL15169@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.07.22 г. 16:13 ч., David Sterba wrote:
> On Mon, Jul 11, 2022 at 04:04:01PM +0300, Nikolay Borisov wrote:
>>> +	rwsem_release(&b->lock##_map, _THIS_IP_)
>>> +
>>>    static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>>>    {
>>>    	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 76835394a61b..4061886024de 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3029,6 +3029,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>>>    
>>>    void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>>    {
>>> +	static struct lock_class_key btrfs_trans_num_writers_key;
>>
>> Shouldn't this variable and its initialization be defined in one of
>> the__init functions (i.e init_btrfs_fs() )for the btrfs' kernel module?
>> As it stands this would be called on every mount of any instance of a
>> btrfs filesystem?
> 
> Yeah I think it should be initialized once for the whole module, however
> a static variable in __init function is not safe as the whole section
> gets removed from memory once all functions get called (module vs
> built-in), either an __initdata annotation or a static variable outside
> of a function (eg. like fs_uuids in super.c).


Actually the code as is makes sense, since the initialization is about 
the lockdep map and not the lock_class_key, as such it needs to be 
called in a place where we have a reference to btrfs_fs_info and since 
this is per-fs, it makes sense to be in btrfs_init_fs_info.
