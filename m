Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92250551B51
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346892AbiFTNj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349005AbiFTNja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 09:39:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F61FA44
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 06:14:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21B9021B8E;
        Mon, 20 Jun 2022 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655730285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hk9laOXTWAV2Cw2RCoaLU2kszMzOx1gVoUw3GfV7qfE=;
        b=qPzBZok3hjEkTsSmeFUFnvLY+zYHHJPSedP87UedQQ6Upb8XHRYdnNy19Og8dJPKJB2dh3
        aDV0Ruj7GRCSwaors231QM2m0blFtFIhYfNzcZe5UgYSq1N2oflIOESPDVz+kAipppwUBv
        ep689XZManoDc0PRWghNzU+Q4PbAzUw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C92A413638;
        Mon, 20 Jun 2022 13:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KKp3LmxwsGJNMwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 20 Jun 2022 13:04:44 +0000
Message-ID: <b7867fdf-9f74-7018-1a7b-06c02c4a0646@suse.com>
Date:   Mon, 20 Jun 2022 16:04:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: cleanup btrfs bio submission v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
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



On 17.06.22 г. 13:04 ч., Christoph Hellwig wrote:
> Hi all,
> 
> this series removes a bunch of pointlessly passed arguments in the
> raid56 code and then cleans up the btrfs_bio submission to always
> return errors through the end I/O handler.
> 
> Changes since v1:
>   - split the raid submission patches up a little better
>   - fix a whitespace issue
>   - add a new patch to properly deal with memory allocation failures in
>     btrfs_wq_submit_bio
>   - add more clean to prepare for and go along with the above new change
> 
> Diffstat:
>   compression.c |    8 ---
>   disk-io.c     |   46 +++++++++----------
>   disk-io.h     |    6 +-
>   inode.c       |   86 +++++++++++++++---------------------
>   raid56.c      |  127 ++++++++++++++++++++++++-----------------------------
>   raid56.h      |   14 ++---
>   scrub.c       |   19 ++-----
>   volumes.c     |  138 ++++++++++++++++++++++++++++------------------------------
>   volumes.h     |    5 --
>   9 files changed, 202 insertions(+), 247 deletions(-)


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
