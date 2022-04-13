Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85864FF81F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiDMNtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiDMNtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 09:49:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD95FF0F
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 06:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12B451F864;
        Wed, 13 Apr 2022 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649857599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lx6kt70m6qeVV+It0fHKKlHQakj1BwzjPOKZgc9TdI=;
        b=NJIhYTeIgevZC3fWuL3VhZbVi0rT635O7vTyr5qMvNegtAjSKxoMR+6aPZxSA7ORqfP8V6
        hX/zuRfnYZadhW7TonbL0+8aigN+d6EXLEu4d6skvsThHjpfyrv9c4FEeASyxv3UaoYiuX
        aHloqFqu5E+0OJR+e43GdZCQeRMXisA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8A4E13AB8;
        Wed, 13 Apr 2022 13:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6jX0MT7UVmKkBwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Apr 2022 13:46:38 +0000
Message-ID: <bd0049df-d5e6-9157-41c4-fa31c3c97fca@suse.com>
Date:   Wed, 13 Apr 2022 16:46:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: submit_read_repair() cleanup
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.03.22 г. 7:48 ч., Qu Wenruo wrote:
> Cleanup the function submit_read_repair() by:
> 
> - Remove the fixed argument submit_bio_hook()
>    The function is only called on buffered data read path, so the
>    @submit_bio_hook argument is always btrfs_submit_data_bio().
> 
>    Since it's fixed, then there is no need to pass that argument at all.
> 
> - Rename the function to submit_data_read_repair()
>    Just to be more explicit on all the 3 things, data, read and repair.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
