Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A484C2815
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiBXJbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 04:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiBXJbJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 04:31:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A52649AD
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 01:30:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0434212B6;
        Thu, 24 Feb 2022 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645695037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUCRvTExzQQ8+0sL98uEGvwwsphLJByqMCx6ASOiHW0=;
        b=uucO64kCmeMNrQTND9ihN4sMNY/5SUCXb/1A+zFiMDAq2jo671pXGJq9EoztjEzz8sdEcS
        axe5mCbC2hue44euYqoea5GeF/xTf7T2n0ByJGEo69cjNFEnua4tVXPNTEYGawStZDsM56
        CIh7MYU3uG89AZnOa6f90N/EdqB0iLI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACC6813A82;
        Thu, 24 Feb 2022 09:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDghJz1QF2LQIAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 24 Feb 2022 09:30:37 +0000
Message-ID: <dfb3e621-7331-2733-1735-34d0a252e4d8@suse.com>
Date:   Thu, 24 Feb 2022 11:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
 <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
 <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
 <90be0040-74f9-29fa-4552-57f45dbf0a86@suse.com>
 <5a8a1ecf-d8ef-7db3-7a97-3f9f29b57bb1@tnonline.net>
 <173dc4fc-21fa-1534-9e6e-d1ff4c1b7564@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <173dc4fc-21fa-1534-9e6e-d1ff4c1b7564@suse.com>
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



On 24.02.22 г. 2:33 ч., Qu Wenruo wrote:
<snip>

> 
> OK, this is indeed chunk discard optimization causing the problem.
> 
> @nik, any idea on this problem?

No, so looking at the code it we can exclude a race condition since 
set/clear bit are taking the spinlock for the extent_io_tree. From the 
first screenshot we can see we want to insert an extent whose start is 
after it's end and the difference is 1: 8590983167 - 8590983168


Since we are passing well-formed chunks as the original input into 
add_extent_mapping respectively into discard-related routines.

So in order to be able to debug this we should really find a way to 
reproduce it and dump the state of the in-memory device_alloc tree to 
see how the search logic goes awry.


> 
> Thanks,
> Qu
> 
>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:362 
>>
>> (inlined by) add_extent_mapping at 
>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:413 
>>
>> (inlined by) add_extent_mapping at 
>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:400 


<snip>
