Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655544D306B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiCINtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCINtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:49:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C1149B87
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:48:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 256791F380;
        Wed,  9 Mar 2022 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0txZEh0UAtAKWm5wtjrcP1o/X/hvYIK9vMJJ/rfhKg=;
        b=luQ5FsPw099bXDhPDp8+R6Tt7lnz/Us9cSm4QDLov5BUT3YxVQVCwVXZo43MhFa+3l3oSz
        QV+w09ztiYXjQS/C4mgetGLJaCOTsv9bAEtUP83/brfDFkkZHHt+Zp5FMvVaO9wRDR9q7w
        51VU6sUBfhTXUMHvbKZPBbye6Bt/yns=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE85813D7A;
        Wed,  9 Mar 2022 13:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t8I4Mx2wKGK5LAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 13:48:13 +0000
Message-ID: <01a3f47e-9471-9a84-2a38-148bda742f6c@suse.com>
Date:   Wed, 9 Mar 2022 15:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 02/12] btrfs: add a btrfs_node_key_ptr helper, convert the
 users
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
 <7c1a75affdac4955ed9430845e9dd7ae30aaff28.1646692306.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <7c1a75affdac4955ed9430845e9dd7ae30aaff28.1646692306.git.josef@toxicpanda.com>
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



On 8.03.22 г. 0:33 ч., Josef Bacik wrote:
> All of the node helpers are getting the pointer offset and then casting
> to btrfs_key_ptr.  Instead do this with a helper similar to how we do it
> with items and change all the helpers to use the new helper.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This patch is already included in the btrfs-progs: cleanup btrfs_item* 
accessors series as patch 12.
