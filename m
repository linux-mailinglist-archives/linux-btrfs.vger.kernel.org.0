Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A055769E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiFWJa2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFWJa1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:30:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4C47570
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:30:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA2E1F904
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655976625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHTk+jPWIDHZeel+mTUHn7cgKSgn0B8VBFjjfsg3DIY=;
        b=mx8URh04x/H3KRvNiqWPq/cl4CbLz1HJDACRcwLZyV/JI4VHZaUXVGXvvvsV9z/Mw3no0h
        HT6O1wuDIaI4PySH0sEqNEzQo9LOOIx24+nHN0v+TRfUrjda7bR1ynqHg5Djr1xeqepe7H
        In+8RJ5AbgVqIu+oDCYEalNY7XNxSss=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5076A13461
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vl37ELEytGLDJwAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 09:30:25 +0000
Message-ID: <2c34331c-45a6-2dd6-f517-1e4b77af82d8@suse.com>
Date:   Thu, 23 Jun 2022 12:30:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220623080858.1433010-1-nborisov@suse.com>
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



On 23.06.22 г. 11:08 ч., Nikolay Borisov wrote:
> Skinny extents have been a default mkfs feature since version 3.18 i
> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
> make skinny-metadata default") ). It really doesn't bring any value to
> users to simply remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Disregard this, I see you've sent a patch demoting it to debug level.
