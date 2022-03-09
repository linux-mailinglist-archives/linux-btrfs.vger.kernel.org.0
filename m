Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6A4D309C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiCIN4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCIN4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:56:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403B17C430
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:55:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 961B51F380;
        Wed,  9 Mar 2022 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646834115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5RWriiFzNj9iUYj6CaBMs+l+SmUOTR3Wr2be8kLdTE=;
        b=cmgdu7M8Rlyok8pu1pGjNKlhME2MJ9dLw4Oa/yn3ghFfpQuCPDFp6fxnLSg5JsqkMdqzk1
        aMbkV/Okffct7NFhmVXyRRjwNE5yj1giGJt0aQxU1vKwTUv3nYXnCXJhGo3H0Ec8zHMDmS
        hi4i2Qr6D98ggDqYtp+/jwlq+UKG/r8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DDD713D7A;
        Wed,  9 Mar 2022 13:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2UvsE8OxKGLTLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 13:55:15 +0000
Message-ID: <842d1d16-f23a-d0d1-538c-24d42b04d992@suse.com>
Date:   Wed, 9 Mar 2022 15:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/12] btrfs: pass eb to the item_nr_offset helper
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1646692306.git.josef@toxicpanda.com>
 <66a242c07bd5ac14e8418984a849c340ab82301a.1646692306.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <66a242c07bd5ac14e8418984a849c340ab82301a.1646692306.git.josef@toxicpanda.com>
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
> This helper needs to know what version of the fs we're looking at to
> return the proper offset into the leaf where the item starts, so pass in
> the eb so we can get the proper offset.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Perhaps a patch can be included before this one which converts asll 
btrfs_item_nr_offset(, 0) into calls to BTRFS_LEAF_DATA_OFFSET as there 
seem to be a couple of those.

<snip>
