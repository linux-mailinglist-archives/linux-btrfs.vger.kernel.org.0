Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFC52E7F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347129AbiETIpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiETIpa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 04:45:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7509E9EB
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:45:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6B7C21C75;
        Fri, 20 May 2022 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653036327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJ6D/ttgwstipWdMNofqY1cXsNVI1ZR/KgKArcwj/No=;
        b=DeIXh4TOxL4rTna1hp1Q4itVWmQN+CCPx9+Iu3hOaAj/sx81UKxlmhWJtL7tHlrjCBmBML
        2cx1eG6gTFYG5/GLUyQq81ql7fpHXYG1yTHbLCcZ1BtNm/vhUP9PSBk4DcSd4PFBGv80vG
        a7uouG/8Dlo51X2j+9DnhmnJHHU2bM4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5416513A5F;
        Fri, 20 May 2022 08:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XYEBEidVh2KFWQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 20 May 2022 08:45:27 +0000
Message-ID: <ac460e01-b909-9957-55b8-a841cee37258@suse.com>
Date:   Fri, 20 May 2022 11:45:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/15] btrfs: introduce a pure data checksum checking
 helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-2-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220517145039.3202184-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.05.22 г. 17:50 ч., Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Although we have several data csum verification code, we never have a
> function really just to verify checksum for one sector.
> 
> Function check_data_csum() do extra work for error reporting, thus it
> requires a lot of extra things like file offset, bio_offset etc.
> 
> Function btrfs_verify_data_csum() is even worse, it will utizlie page
> checked flag, which means it can not be utilized for direct IO pages.
> 
> Here we introduce a new helper, btrfs_check_data_sector(), which really
> only accept a sector in page, and expected checksum pointer.
> 
> We use this function to implement check_data_csum(), and export it for
> incoming patch.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: keep passing the csum array as an arguments, as the callers want
>        to print it]
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Though I find the naming of the function suboptimal because we now have 
a bunch of *_check_* function and unless you go in and read the body of 
the new helper you have no idea what 'check' entails and that it is 
about verifying check sums.


For data reads we have:

btrfs_verify_data_csum -> check_data_csum -> btrfs_check_data_sector

I.e the newly introduced function should have csum in its name i.e 
btrfs_check_data_sector_csum.
