Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180E55779B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiFWKPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 06:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiFWKPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 06:15:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075CC49FA0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 03:15:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBD2321DD5;
        Thu, 23 Jun 2022 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655979304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZT37QIu31BsGHD/T4kb35HTZA4A/TV78VA/vWMI7ByA=;
        b=JUZAIchKpikxeobtMlSsGZDVVMdi4zoV3ck84Lavlyfzp58yIF7uGHDC1TjwVt+MwvbLU6
        eoXgIfBGHUBAJrbMoC+yoPB13YKEQt9XijCn8/EmEKRKBTl7yep27hOvVemenfJwytVAE9
        5NhVfD3t7VX6SqdYkikVgNh2OBWUEzU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91050133A6;
        Thu, 23 Jun 2022 10:15:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YnCeICg9tGJxPwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Jun 2022 10:15:04 +0000
Message-ID: <083b0fc0-d5bc-3beb-d34a-75a76eeda1dc@suse.com>
Date:   Thu, 23 Jun 2022 13:15:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: Properly flag filesystem with
 BTRFS_FEATURE_INCOMPAT_BIG_METADATA
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20220623075547.1430106-1-nborisov@suse.com>
 <4466c55e-7270-7d63-a591-e119fb5e3f8a@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <4466c55e-7270-7d63-a591-e119fb5e3f8a@gmx.com>
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



On 23.06.22 г. 12:57 ч., Qu Wenruo wrote:
> 
> 
> On 2022/6/23 15:55, Nikolay Borisov wrote:
>> Commit 6f93e834fa7c seeimingly inadvertently moved the code responsible
>> for flagging the filesystem as having BIG_METADATA to a place where
>> setting the flag was essentially lost.
> 
> Sorry, I didn't see the problem here.
> 
> The existing check seems fine to me, mind to share why the existing call
> timing is bad?
> 


The problem is that when BTRFS_FEATURE_INCOMPAT_BIG_METADATA is set in 
features then we need to call btrfs_set_super_incompat_flags(disk_super, 
features); so that those flags are put into the superblock and 
subsequently persisted on-disk. However, with the code motion in the 
offending commit features would have BTRFS_FEATURE_INCOMPAT_BIG_METADATA 
set but then it would be rewritten by the call to:

features = btrfs_super_incompat_flags(disk_super);

meaning INCOMPAT_BIG_METADATA never went to disk. It's very subtle
