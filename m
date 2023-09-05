Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABC792B59
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjIEQwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbjIEQuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 12:50:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019B5BB3;
        Tue,  5 Sep 2023 09:30:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 391381FEF8;
        Tue,  5 Sep 2023 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693931383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scDQjkVnkP474Si/VsVHrEoK0XtwyaG7IHpMwnxTK40=;
        b=h9jzS1gnl56U7vScfpMOZDCEgkQtk1zFxW3EnCTfjXT7iuACjq8exIemovXL3Ts0GTZPiH
        ndcMBvvAgI0yMw8qkGYbLae5WG1ZoXukoX1Z9Khaa7PBLxCz9sZbn6IRmK79rKiAvOLpbJ
        0ckLkVw3TPx9JWFh+pKuGMJAp6141mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693931383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scDQjkVnkP474Si/VsVHrEoK0XtwyaG7IHpMwnxTK40=;
        b=Gif/1kHXKHDPOA7rWQngqT/EBKaoOmiEP8AsFS7+phy5buv9Qpc7pGyjhdE9fsxWnqrq6R
        LkOZ7H98ZPuhpICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CADC513911;
        Tue,  5 Sep 2023 16:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6HyTMHZX92QPHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 16:29:42 +0000
Date:   Tue, 5 Sep 2023 18:23:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ardb@kernel.org, kees@kernel.org, linux-kernel@vger.kernel.org,
        enlin.mu@unisoc.com, ebiggers@google.com, gpiccoli@igalia.com,
        willy@infradead.org, yunlong.xing@unisoc.com,
        yuxiaozhang@google.com, qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Weigang Li <weigang.li@intel.com>, Chris Mason <clm@meta.com>,
        Brian Will <brian.will@intel.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] crypto: qat - Remove zlib-deflate
Message-ID: <20230905162302.GD14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7x-009Bvo-IM@formenos.hmeau.com>
 <ZPcqALQ0Ck/3lF0U@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPcqALQ0Ck/3lF0U@gcabiddu-mobl1.ger.corp.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 05, 2023 at 02:15:44PM +0100, Giovanni Cabiddu wrote:
> Hi Herbert,
> 
> On Wed, Aug 30, 2023 at 06:08:47PM +0800, Herbert Xu wrote:
> > Remove the implementation of zlib-deflate because it is completely
> > unused in the kernel.
> We are working at a new revision of [1] which enables BTRFS to use acomp
> for offloading zlib-deflate. We see that there is value in using QAT for
> such use case in terms of throughput / CPU utilization / compression ratio
> compared to software.
> Zlib-deflate is preferred to deflate since BTRFS already uses that
> format.
> 
> We expect to send this patch for 6.7.
> Can we keep zlib-deflate in the kernel?
> 
> Thanks,
> 
> [1] https://patchwork.kernel.org/project/linux-btrfs/patch/1467083180-111750-1-git-send-email-weigang.li@intel.com/

The patch is from 2016 and zlib though still supported has been
superseded by zstd that is from 2017. It would be good to see numbers
comparing zlib (cpu), zlib (qat) against relevant zstd levels. The
offloading might be an improvement and worth adding the support
otherwise I don't see much reason to add it unless there are users.

I can see there's QAT support for zstd too,
https://github.com/intel/QAT-ZSTD-Plugin, can't find one for lzo but in
case ther's QAT for all 3 algorithms used by btrfs I wouldn't mind
keeping the QAT support for zlib for parity.
