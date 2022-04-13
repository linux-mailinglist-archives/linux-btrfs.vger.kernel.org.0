Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633274FFA02
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiDMPZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiDMPZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:25:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469255BD29
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:22:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02468210DD;
        Wed, 13 Apr 2022 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649863358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5tuu1b6JRNx+afZdtWZtmRr8Km/7GOZfjmrXlhJV+Y=;
        b=aJO6+ZF79GmSg9BNZO9OAwlKp2ziitxsV9EV0sp/NN8FWFhoD0r4zBnrBawSF8DJr3ATFt
        GRUs7Ichr6jLQ45OA/yfAERdJMju3agFLgqRWbxjW1chraG4B6/1r5A7aq+I0ffgnOIZA0
        AOboQyMh5UfwaCPzMQQHtj/t73mUjC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5ADA13AB8;
        Wed, 13 Apr 2022 15:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+kzLL3qVmL8LwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 15:22:37 +0000
Message-ID: <da5d1ec7-45cc-0222-acab-ff378ed69b6f@suse.com>
Date:   Wed, 13 Apr 2022 18:22:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: use BTRFS_DIR_START_INDEX at
 btrfs_create_new_inode()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <ce76cc1a4fb3c2b4d6051c6d900286d6171885a3.1649862992.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <ce76cc1a4fb3c2b4d6051c6d900286d6171885a3.1649862992.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.04.22 г. 18:20 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are still using the magic value of 2 at btrfs_create_new_inode(), but
> there's now a constant for that, named BTRFS_DIR_START_INDEX, which was
> introduced in commit 528ee697126fd ("btrfs: put initial index value of a
> directory in a constant"). So change that to use the constant.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
