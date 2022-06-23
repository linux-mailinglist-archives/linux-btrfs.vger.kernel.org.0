Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA65557699
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiFWJaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiFWJaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:30:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E64755A
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08DC721DE1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655976603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIyKb+mz9zQClprMU4dmjmx6tYeLUTYmZS9zgrpE69w=;
        b=ObrzvV05CJA1+ar7B/6mu3cVyYGIWZ2r6X/LSWFaEwuFO51ayLRTKXU0FdbjqAjwerv8F2
        0D4B1YzfG2/Jo6doM4G5+G1r/HDf9jaqJmX5UeYLo0PKoR9/YiCWiK//KvbXxf5xWZV4pi
        p8voDTZkJoV8C+ZJ0OL33FJoF4VdWrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF2F713461
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rZ3pM5oytGKNJwAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:02 +0000
Message-ID: <b9dac829-aa5a-fda8-0d13-4544c88afae5@suse.com>
Date:   Thu, 23 Jun 2022 12:30:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: remove overly verbose messages
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220623075752.1430598-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220623075752.1430598-1-nborisov@suse.com>
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



On 23.06.22 г. 10:57 ч., Nikolay Borisov wrote:
> The message "flagging fs with big metadata" doesn't really convey any
> useful information to users. Simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Disregard this, I see you've sent a patch changing it to debug level.
