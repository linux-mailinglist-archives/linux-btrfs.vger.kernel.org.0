Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AA4D3081
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiCINtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiCINtp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:49:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B53149BB6
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:48:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1DB0210E6;
        Wed,  9 Mar 2022 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXw1vCU6CJemt/RWfw87TQHRBpPycexdmkox4NnTefE=;
        b=TpzOIgLomgwi32j0rFcOgo38r1wKQJ+KSWO0v14IypVxBjnDMeYfZUqWwaxKBA4Celf2Ij
        S/oysUAOxtHcIeYVyjfeKl697klZFs08W9wAMtLbYJ1Sc48BUzYBOrKDNPX5Q24klvtQza
        t4mLQIwR+8jU/hfAI1kdQ2du+NF6iTA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A53513D7A;
        Wed,  9 Mar 2022 13:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQH4Gj2wKGL1LAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 13:48:45 +0000
Message-ID: <e14d1f42-562c-b17a-bb60-e61cd395623e@suse.com>
Date:   Wed, 9 Mar 2022 15:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/12] btrfs: add a btrfs_node_key_ptr helper, convert the
 users
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
 <7c1a75affdac4955ed9430845e9dd7ae30aaff28.1646692306.git.josef@toxicpanda.com>
 <01a3f47e-9471-9a84-2a38-148bda742f6c@suse.com>
In-Reply-To: <01a3f47e-9471-9a84-2a38-148bda742f6c@suse.com>
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



On 9.03.22 г. 15:48 ч., Nikolay Borisov wrote:
> 
> 
> On 8.03.22 г. 0:33 ч., Josef Bacik wrote:
>> All of the node helpers are getting the pointer offset and then casting
>> to btrfs_key_ptr.  Instead do this with a helper similar to how we do it
>> with items and change all the helpers to use the new helper.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> This patch is already included in the btrfs-progs: cleanup btrfs_item* 
> accessors series as patch 12.
> 

Ah, this is the kernel portion... disregard.
