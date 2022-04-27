Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43408511410
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiD0JMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 05:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiD0JMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06223F370
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 02:08:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A55611F380;
        Wed, 27 Apr 2022 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651050398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AxJf3WpApJa/1Z597iMtUWW9GrOkjsEKXwHhXEN874=;
        b=Ll8a5F58oz18WQSS4CbPFKA/LQFZU0OUVnX6bh9YK5ALvTSqfVyZf7IrkSKzuZTp+7wka3
        QWJ8UZb5I5ovHuggpw1wf/IYHkzuAMaWDf1smtK0VK5KHXjAP89LS3B3RNQkgrQwJFrmbQ
        k5XOEchIg8/To+joU3eKwMgqK3VNwik=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6399D1323E;
        Wed, 27 Apr 2022 09:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L+MtFZ4HaWJEVwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 27 Apr 2022 09:06:38 +0000
Message-ID: <7deead89-3be0-2ac2-cbb2-05171911cbe4@suse.com>
Date:   Wed, 27 Apr 2022 12:06:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Derive compression type from extent map during
 reads
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
References: <20220426134734.dxxdrf2hutbmimtc@fiona>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220426134734.dxxdrf2hutbmimtc@fiona>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.04.22 г. 16:47 ч., Goldwyn Rodrigues wrote:
> Derive the compression type from extent map as opposed to the bio flags
> passed. This makes it more precise and not reliant on function
> parameters.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

This patch also makes extent_compress_type unused so it can be removed. 
Also extent_set_compress_type also becomes redundant and can be removed.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


<snip>
