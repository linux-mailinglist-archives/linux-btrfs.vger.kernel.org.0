Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF445358AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 07:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiE0FQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiE0FQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 01:16:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59E2ED44;
        Thu, 26 May 2022 22:16:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B9A521A7B;
        Fri, 27 May 2022 05:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653628560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzbLluQjd6KK6SPAyIUBwWZX3q+gfRKwunO6deMWKos=;
        b=DxD14upKJAXhS7VDN2ninE+oDV5FpbCP8NhDuflCUmSq0nPs46aRf3061A5BjeyBeqbPau
        i/ku45lNjVm1SajGXrLkDwO1t4W6U/5vCIwQCBKBRaEXLdAT2mTnIQZ+dgPxm+Zg5z90qP
        1kk5QikV7uu0T0r+pwLzN2uJ7YBfVKo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 144A81346B;
        Fri, 27 May 2022 05:16:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MD1zAZBekGJfeAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 27 May 2022 05:16:00 +0000
Message-ID: <89806931-08cb-ec8a-b888-a710a7a45a0e@suse.com>
Date:   Fri, 27 May 2022 08:15:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: use PAGE_ALIGNED instead of IS_ALIGNED
Content-Language: en-US
To:     bh1scw@gmail.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220526143539.1594769-1-bh1scw@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220526143539.1594769-1-bh1scw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.05.22 г. 17:35 ч., bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
