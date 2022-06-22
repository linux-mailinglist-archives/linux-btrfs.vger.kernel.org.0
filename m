Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6744455481D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiFVInV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiFVInT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 04:43:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFE33E97
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 01:43:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E35BB21C5B;
        Wed, 22 Jun 2022 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655887395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrdE3Zl8J8UMxnQw+zyoZTL9sLJlIu6Z96/NVJdc5qs=;
        b=D/V67hjgTq/XJgBl5NB79JcWIHqdFSlfJVaMHj+AxS64RYH9Gwob69nlUKJNng/Bezibpa
        ltK7f+gUQ+J0KziunKeglayx4BwbkawHBO+3GXXraLVBI3xO7CFFhFqdJ8m00eIxHxTMEd
        8ttx5tH5ogqoOzUR0KTL7nIrcTzrzSs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93C57134A9;
        Wed, 22 Jun 2022 08:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yf6HISPWsmLzEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 22 Jun 2022 08:43:15 +0000
Message-ID: <b245d5ec-e959-00ce-08f7-36b8418fcd89@suse.com>
Date:   Wed, 22 Jun 2022 11:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: repair all known bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220622074939.3287300-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220622074939.3287300-1-hch@lst.de>
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



On 22.06.22 г. 10:49 ч., Christoph Hellwig wrote:
> When there is more than a single level of redundancy there can also be
> mutiple bad mirrors, and the current read repair code only repairs the
> last bad one.
> 
> Restructure btrfs_repair_one_sector so that it records the originally
> failed mirror and the number of copies, and then repair all known bad
> copies until we reach the originally failed copy in clean_io_failure.
> Note that this also means the read repair reads will always start from
> the next bad mirror and not mirror 0.
> 
> This fixes btrfs/265 in xfstests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

While still not perfect, I guess it's better than what we had before 
because right we'll fix:
[first bad mirror, first good mirror). Where first bad mirror depends on 
the PID at the time the initial read was issued.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
