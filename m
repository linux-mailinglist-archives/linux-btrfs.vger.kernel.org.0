Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BCD4D2F4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiCIMna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 07:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiCIMn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 07:43:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4C39B94
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 04:42:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97FA9210F9;
        Wed,  9 Mar 2022 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646829749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KgFF1AHDjE2Vk55ud3Hw1hd6eIrR4xxZIuL3dDSdamY=;
        b=GGx+rFyeqUMPiOMI93D/eEuT0hd8Vkql9teXJ8IoXvL4JgDkMfXiZjn8xTksy38sLpcgXc
        7l+fHnI6lywtGYzHUvSFsu+v8i06x4e4+VEYPu+ncg8FUyuaetbQM5LkX0Fma31e5IoohW
        BfdTlCUrXUZzXtxpiQPqHzUW6I07/pI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CAF313D79;
        Wed,  9 Mar 2022 12:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbSyE7WgKGJmCgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 12:42:29 +0000
Message-ID: <77a50ebb-851b-efbc-b931-2a7e918b8268@suse.com>
Date:   Wed, 9 Mar 2022 14:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 11/13] btrfs-progs: replace btrfs_item_nr_offset(0)
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
 <a597a4dcd96aa815ab999b72af722c37c1eda19e.1645568701.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <a597a4dcd96aa815ab999b72af722c37c1eda19e.1645568701.git.josef@toxicpanda.com>
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



On 23.02.22 г. 0:26 ч., Josef Bacik wrote:
> btrfs_item_nr_offset(0) is simply offsetof(struct btrfs_leaf, items),
> which is the same thing as btrfs_leaf_data(), so replace all calls of
> btrfs_item_nr_offset(0) with btrfs_leaf_data().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


nit: The patch itself is fine, however in the kernel we don't have 
btrfs_leaf_data() func, instead we have BTRFS_LEAF_DATA_OFFSET macro 
which is used in a lot of places in the kernel. So why not make the 
btrfs-progs follow the kernel style to reduce future clashes when we 
start factoring out common code between user/kernel?
