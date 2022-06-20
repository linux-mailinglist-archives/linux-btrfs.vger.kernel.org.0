Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09852551EAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiFTODe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347417AbiFTOBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 10:01:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38F3C72A
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 06:26:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EEDD21B8E;
        Mon, 20 Jun 2022 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655731610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUj7Bx+7CfrdOWT45l3anINdu9qJ5SaSZm3IFd86P0Y=;
        b=fPjlFoxTJa+IXTAaxJ9et4UGdYrc97dIn08BArU6qCYHCqneZLtviBQ8+FNtEQBgg/jJpC
        RJMdLVJxe078lQSP7yMg9Zy/rAZ86GjSbc5+LY6TYAnKopJ2ggTt9JmQJ3Lv9OOu7XM554
        lcHm2VYgQWq3jn1g2n08NYT6LQE4ymY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8B3113638;
        Mon, 20 Jun 2022 13:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3j4+Lpl1sGJSPwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 20 Jun 2022 13:26:49 +0000
Message-ID: <3c253f8f-0298-cff0-84de-0fed5b3c433c@suse.com>
Date:   Mon, 20 Jun 2022 16:26:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: remove the finish_func argument to
 btrfs_mark_ordered_io_finished
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220619060705.1850530-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220619060705.1850530-1-hch@lst.de>
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



On 19.06.22 г. 9:07 ч., Christoph Hellwig wrote:
> finish_func is always set to finish_ordered_fn, so remove it and also
> the now pointless and somewhat confusingly named
> __endio_write_update_ordered wrapper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
