Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10A5444D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiFIHaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFIHaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 03:30:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD7A5
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 00:30:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E95B21116;
        Thu,  9 Jun 2022 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654759807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qm+mWvqcD+HQ+6uEqE20y7ie1KictxgSfN8CwLzqOD8=;
        b=hdrmBtmw0kxp737nN47AFoqGn0UXFR4dCHGjsNyCLwFeN5O5N4ITK3rk4nFrr5mPDjBZ3y
        pmv9aSNDhUt7cPKsGrzDro3pTyrBom+SIaJd1HLE9kRpykEAif2+1Mad8hxFoqKkvHyQRT
        rhw1xxM/ZRUejQqJ3FO/inN3IhNfpV4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F61B13A8C;
        Thu,  9 Jun 2022 07:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nVHGCH+hoWLZMwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 09 Jun 2022 07:30:07 +0000
Message-ID: <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
Date:   Thu, 9 Jun 2022 10:30:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220607154229.9164-1-dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220607154229.9164-1-dsterba@suse.com>
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



On 7.06.22 г. 18:42 ч., David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> conversion.  We don't use the page cache or the mapping anywhere else,
> the page is a temporary space for the associated bio.
> 
> Allocate the page at device allocation time, also to avoid any later
> allocation problems when writing the super block. This simplifies the
> page reference tracking, but the page lock is still used as waiting
> mechanism for the write and write error is tracked in the page.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


nit: I think it's important to remark in the changelog that with this 
change sb writing becomes sequential as opposed to parallel with the old 
code. This also means that wait_dev_supers can be simplified because the 
max_mirror's loop is not needed, at least for waiting, since for each 
device we at most need to wait for the last write to it, as all previous 
ones have been serialized by the pagelock.

<snip>
