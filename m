Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41830546645
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbiFJMGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiFJMGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 08:06:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1A73F333
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 05:06:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1AA01FAC6;
        Fri, 10 Jun 2022 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654862765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+izOUXQCyqMbBf9I9ZjSm01eubKC3R/s7u2kfls5So=;
        b=mbwG8hzHwIgPYUwaOV8cNeAMRHNr2LvRL+goNJdDml5krhzCqwtvFWL5jrwTzK24kxeTJe
        EHtnzpg0eRYrT4MSffRlXMjyZov33DhUlBeR2B2GSRw0Aemomo9/kZe/nhX/8hqfKXvG7p
        yYG3ypFzjXZ1fllczMpDmiL3jDmjd5Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FB0B139ED;
        Fri, 10 Jun 2022 12:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cONzGK0zo2KdJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 10 Jun 2022 12:06:05 +0000
Message-ID: <f35ea030-5652-42b8-84e8-d41a5bd0911e@suse.com>
Date:   Fri, 10 Jun 2022 15:06:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.06.22 г. 19:46 ч., David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.
> 
> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
> 
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
