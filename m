Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73F56B5CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 11:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGHJhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 05:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiGHJho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 05:37:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089660537
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 02:37:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73BBE1FDC9;
        Fri,  8 Jul 2022 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657273060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICqaTOJKz/0JIm3pJ52wxkvqIIm8Qot5BI4cRUmKp+M=;
        b=iuKS5CQ5VODVlgLenRo42j19Hud4G9sO2ks5rmMkIGBVAGnVofxW8UABmgFNAkyn4FtqXJ
        QAevztWi1FGRqxF+RkBCPcdNCqTlOqPu2U88yAPqamwENbVz0AyNBDks/J+nJT+nvozfLd
        ueojMwued5LFaKD0LItZ9B1MGrWVfs8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CAAF13A7D;
        Fri,  8 Jul 2022 09:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n3GUA+T6x2KKTgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 08 Jul 2022 09:37:40 +0000
Message-ID: <fbe18ef7-a75a-4bca-043a-048dcd1cd2e7@suse.com>
Date:   Fri, 8 Jul 2022 12:37:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: fix read repair on compressed extents v3
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220707053331.211259-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220707053331.211259-1-hch@lst.de>
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



On 7.07.22 г. 8:33 ч., Christoph Hellwig wrote:
> Hi all,
> 
> while looking into the repair code I found that read repair of compressed
> extents is current fundamentally broken, in that repair tries to write
> the uncompressed data into a corrupted extent during a repair.  This is
> demonstrated by the "btrfs: test read repair on a corrupted compressed
> extent" test submitted to xfstests.
> 
> This series fixes that, but is a bit invaside as it requires both
> refactoring of the compression code and changes to the repair code to
> not look up the logic address on every repair attempt.  On the plus
> side it removes a whole lot of code.
> 
> The series is on top of the for-next branch, as that includes other
> bio changes not in misc-next yet.
> 
> Changes since v2:
>   - include the previous submitted and reviewed repair all mirrors patch
>     to simplify the stack of patches
>   - include an additional cleanup patch at the end
>   - improve a commit log
>   
> Changes since v1:
>   - describe the partial revert that happens in patch 1 better in the
>     commit log
>   - drop a now incorrect comment
>   - do not add a prototype for a non-existent function
> 
> Diffstat:
>   compression.c |  287 ++++++++++++++++------------------------------------------
>   compression.h |   11 --
>   ctree.h       |    2
>   extent_io.c   |   93 +++++++-----------
>   extent_io.h   |    9 -
>   inode.c       |   34 +++---
>   volumes.h     |    2
>   7 files changed, 146 insertions(+), 292 deletions(-)
>   compression.c |  311 ++++++++++++++++------------------------------------------
>   compression.h |   11 --
>   ctree.h       |    4
>   extent_io.c   |  202 ++++++++++++++++---------------------
>   extent_io.h   |   10 -
>   inode.c       |   39 +++----
>   6 files changed, 203 insertions(+), 374 deletions(-)


For the whole series :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
