Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1194D2A9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCII2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCII1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:27:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F712B0D34
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 00:26:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0979B1F381;
        Wed,  9 Mar 2022 08:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646814406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2OIPvhj60Ic1F73jZj5w6da5HrrUHVQMZ5FjnWehrQ=;
        b=DAy0YJzTNytEPZWXPJbxoH24VTOQn0vKCP2YwPMBvSRZ5hZmXt5T2Mfte1f68LirAle/yZ
        RpVE325lMzO9SPFTwDi+lEdv/BZvr01GfbC7IXzCbNV1IdPHTY+u8xKNJuFMq3qVV1XMxp
        4bj6coWjRTAYNhO/fxTbweGWnkgwFaI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D135913D79;
        Wed,  9 Mar 2022 08:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X38MMMVkKGI+BAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 08:26:45 +0000
Message-ID: <5f925e03-7e9a-601c-5261-7f568a1f3dd1@suse.com>
Date:   Wed, 9 Mar 2022 10:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Trying to understand duperemove failure to deduplicate
Content-Language: en-US
To:     Andy Smith <andy@strugglers.net>
Cc:     linux-btrfs@vger.kernel.org
References: <20220309065536.djkig3d43c4uts76@bitfolk.com>
 <722c4bfb-514b-05ad-af50-f94908539a0a@suse.com>
 <20220309082303.6uzsrd3r4c2yooy2@bitfolk.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220309082303.6uzsrd3r4c2yooy2@bitfolk.com>
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



On 9.03.22 г. 10:23 ч., Andy Smith wrote:
> Hi Nikolay,
> 
> On Wed, Mar 09, 2022 at 09:58:27AM +0200, Nikolay Borisov wrote:
>> The problem is in duperemove, not btrfs. Basically in the default mode of
>> operation duperemove works based on extents, however those 2 files have
>> identical content but its logical structure is different 1 vs 2 extents.
> 
> Ah okay, thanks.
> 
>> Unfortunately duperemove is not able to cope with this, if you want to
>> dedupe those file you should be using the block-based dedupe mode.
> 
> Is that a mode of duperemove or did you mean to use a different tool?
> 
> I saw duperemove's "--lookup-extents" option and tried with that:

Yes, using lookup-extents=no makes duperemove utilize the block-dedupe 
mode of operation.

<snip>
