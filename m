Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EED44538D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhKDNLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 09:11:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50666 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhKDNLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 09:11:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8707218B8;
        Thu,  4 Nov 2021 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636031315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMbDxkW1516eHARrfuuySotNAiBcRA1buaBI+quzYhQ=;
        b=WpJlAVc9kiCbCzAPZk1fuDxkQItgI1ZMzk5ozDDEQLndTRGi/3DFiezbNUxrg6NnWJYLqB
        ojkIJr/hlECoyCkPKf+DDdYddL/naidWBdgTiR5FrVTlT/OM3ypCMenwcQGoeMUm0m8ydS
        X72E2Y5+d3IJcA9DDIUOssS34yzgmY8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2D3613C68;
        Thu,  4 Nov 2021 13:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dpPCJFPbg2EsIgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 04 Nov 2021 13:08:35 +0000
Subject: Re: [PATCH 3/4] btrfs: get rid of root->orphan_cleanup_state
From:   Nikolay Borisov <nborisov@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1635450288.git.josef@toxicpanda.com>
 <dc82d55bbdf6448b612c49856c5499b5add1bbc5.1635450288.git.josef@toxicpanda.com>
 <3ce2791f-ee93-0e71-b06f-e4952052bba2@suse.com>
Message-ID: <ed886faa-d9a3-f6fa-263e-6f16f0985eca@suse.com>
Date:   Thu, 4 Nov 2021 15:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3ce2791f-ee93-0e71-b06f-e4952052bba2@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.11.21 г. 14:55, Nikolay Borisov wrote:
> 
> 
> On 28.10.21 г. 22:50, Josef Bacik wrote:
>> Now that we don't care about the stage of the orphan_cleanup_state,
>> simply replace it with a bit on ->state to make sure we don't call the
>> orphan cleanup every time we wander into this root.

<snip>

> 
> Don't you need to clear the bit at this stage?

To answer my own question : No, this retain the old behavior where once
orpahn cleanup is set to done the cmpxchg will always fail for the
duration of this mount, same happens when we simply set the flag. So

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


> 
>> -
>>  	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state)) {
>>  		trans = btrfs_join_transaction(root);
>>  		if (!IS_ERR(trans))
>>
> 
