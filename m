Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D15520D42
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 07:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiEJFqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 01:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiEJFqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 01:46:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6655131D
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 22:42:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8567B21B85;
        Tue, 10 May 2022 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652161358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OIk00LXGSvXFMwu0J12Iga44/VVWxQGubWkepoD8Tg=;
        b=ll7bFUz2LK7WU7zOzRSmTCjPfLn+ExP1aSp3G6kzty7isoT6nRMgLYS4WwzGI+mLFi7eVm
        K322TWI17wOzslJmg5aat7/Bn8MwqQHGzTGF5yl0AWgAdfmKSbDC2G0D4XuB/1UAqTT0oT
        Hl6EiT6ogdFOHwoVI5zVGWzIxaMurWU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 477B8139F5;
        Tue, 10 May 2022 05:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k/XQDk77eWLTSwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 10 May 2022 05:42:38 +0000
Message-ID: <bf19be5b-ce93-463b-f4f0-f72a75480503@suse.com>
Date:   Tue, 10 May 2022 08:42:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220504152501.GQ18596@twin.jikos.cz>
 <20220505070825.1218337-1-nborisov@suse.com>
 <20220509195104.GF18596@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220509195104.GF18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.05.22 г. 22:51 ч., David Sterba wrote:
> On Thu, May 05, 2022 at 10:08:25AM +0300, Nikolay Borisov wrote:
>> This eliminates 2 labels and makes the code generally more streamlined.
>> Also rename the 'out_bargs' label to 'out_unlock' since bargs is going
>> to be freed under the 'out' label. This also fixes a memory leak since
>> bargs wasn't correctly freed in one of the condition which are now moved
>> in btrfs_try_lock_balance.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>
>> V2:
>>   * Removed extra call to kfree(bargs) which resulted in a double free
> 
> Where does this patch apply to? It's using btrfs_try_lock_balance but that
> does not exist in code nor in the patch.
> 

Well this is v2 2/2 so it's part of the same series just an update to 
the 2nd patch.
