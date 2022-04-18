Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65F504FA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiDRMB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 08:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiDRMB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 08:01:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB61A3B2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 04:58:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABE6C215FD;
        Mon, 18 Apr 2022 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650283127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/3ULkhD3b+avmHj58OG46DMLgirdLAKWBbbAS7ItG4=;
        b=KkTommO7y30qrQ9D45rMJ7s1rdj679dWbs6KNpcQUKjrERNzL/+qYkeRH9BufBFjSxMr5y
        0YxRbrFmI7GH25Fyw4XCk7sbARffG3g0XJRc9pkYCtki6IwNGsYrIo4ol6UNuWAZAxsnR2
        th5b4yozLNBPIH7Ay6vgaxKgANLvP/0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D41213A9B;
        Mon, 18 Apr 2022 11:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id loDREndSXWICIQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Apr 2022 11:58:47 +0000
Message-ID: <9db93422-18d8-9978-3247-b90e0fd8717e@suse.com>
Date:   Mon, 18 Apr 2022 14:58:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
 <988fb59d-da07-1419-cfe3-85a5ad0efbca@suse.com>
 <b8438797-164e-989a-6fad-5dc15568ecb8@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <b8438797-164e-989a-6fad-5dc15568ecb8@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.04.22 г. 9:44 ч., Qu Wenruo wrote:
> y way to create a dirty journal.
> 
> But I'm not sure if btrfs-progs really wants a complicated dm based
> solution to do the same thing.
> 
> Or maybe I can just use an raw image for that?


It doesn't matter what way you use to create the journal, what's 
important is that you have a dirty journal and verify a particular 
functionality involving it. You can either encode the steps to create 
the dirty journal image in the test itself, or simply provide an image 
with a dirty journal.
