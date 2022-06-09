Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F6544C3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiFIMhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiFIMhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 08:37:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867A22BCF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 05:37:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9CDD21F42;
        Thu,  9 Jun 2022 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654778237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpFIPRsw7CvtFIdP9pG7YP/0yI5yYuTPyuSPy+RwlX0=;
        b=YpTj072rtdMbTg9F5wvPWkJn1MXHtve0IvYqHvSajaEDr+BzxiO97yJioaYQHl4OdoPQSy
        VSqLSWr6m1yg4Rvii1zRk16OM0ISK14WnOwAZ9NasTY4Xs9gubetUaiLESBDAV62TJTfxW
        TB+gVn9ppkuqlPkb631K42970E6fdNk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728BF13A8C;
        Thu,  9 Jun 2022 12:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JpgsGX3poWIfQAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 09 Jun 2022 12:37:17 +0000
Message-ID: <0a6872d8-889a-eff2-cce2-4a81b7aa4594@suse.com>
Date:   Thu, 9 Jun 2022 15:37:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220607154229.9164-1-dsterba@suse.com>
 <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
 <YqHpOSWedxnjPWfP@casper.infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <YqHpOSWedxnjPWfP@casper.infradead.org>
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



On 9.06.22 г. 15:36 ч., Matthew Wilcox wrote:
> On Thu, Jun 09, 2022 at 10:30:06AM +0300, Nikolay Borisov wrote:
>> nit: I think it's important to remark in the changelog that with this change
>> sb writing becomes sequential as opposed to parallel with the old code. This
>> also means that wait_dev_supers can be simplified because the max_mirror's
>> loop is not needed, at least for waiting, since for each device we at most
>> need to wait for the last write to it, as all previous ones have been
>> serialized by the pagelock.
> 
> I've just re-read the patch very carefully three times, and I don't
> see the change that makes this happen.  Can you explain to me how it
> happens?

We now have a single page -per device, whereas the old code got a page 
from pagecache based on the offset where the sb is written. SO what 
happens now is that we send the first sb down the disk, then on the 2nd 
iteration we'd block on lock_page etc.
