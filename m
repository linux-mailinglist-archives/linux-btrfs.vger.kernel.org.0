Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA652E993
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiETKF0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiETKFZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 06:05:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234CA30BC
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 03:05:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 315E61F45B;
        Fri, 20 May 2022 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653041122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU5wzovnUomvZsjKJmtXUhZ/t5Sv4xwETVxxbT/dmQ0=;
        b=NnEk8ObneQxwFjdMtkzUPsxw4x9H/xeelEtpS0rM6zRNmaVWaN88KXj5CigNUu7euTngec
        xptpybzCwU6Lp+5kb3/ChryoC0puBR7XqDkQbIyLQD3GubtLR6Us9FzrpznUl9VmUZRQnt
        1WnqaSkyK5xjxym8hThB35jWEvaHCWk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2B5C13AF4;
        Fri, 20 May 2022 10:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bf7GMOFnh2KKAQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 20 May 2022 10:05:21 +0000
Message-ID: <97a90ce3-bc2a-dd3a-7a14-61b37900a537@suse.com>
Date:   Fri, 20 May 2022 13:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/15] btrfs: remove duplicated parameters from
 submit_data_read_repair()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-5-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220517145039.3202184-5-hch@lst.de>
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
> The function submit_data_read_repair() is only called for buffered data
> read path, thus those members can be calculated using bvec directly:
> 
> - start
>    start = page_offset(bvec->bv_page) + bvec->bv_offset;
> 
> - end
>    end = start + bvec->bv_len - 1;
> 
> - page
>    page = bvec->bv_page;
> 
> - pgoff
>    pgoff = bvec->bv_offset;
> 
> Thus we can safely replace those 4 parameters with just one bio_vec.
> 
> Also remove the unused return value.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: also remove the return value]
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
