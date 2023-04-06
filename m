Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392486D9AA3
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDFOkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239258AbjDFOjn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 10:39:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DAB773;
        Thu,  6 Apr 2023 07:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77625211AF;
        Thu,  6 Apr 2023 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680791850;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXx/YVvVLaG9KNLZgPwsZsE7Y1j1neSmNIlwQztqF7Q=;
        b=jb4CetQIbeR7UY0b9ZwgnidWRxAzirB7N/TbUIyDTy+hkyMX+EeVRDEiT41lNTb+0crSVA
        u5APQ1PA3osIyYkGGNSPElcys/DuikhrSIZFeVqaKsigM34Oz7PzjJPgCtwqhaTq32Ck1p
        eRv4raUGjjDPVv5K9Tp4YAj9qRkleow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680791850;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXx/YVvVLaG9KNLZgPwsZsE7Y1j1neSmNIlwQztqF7Q=;
        b=R2l7KOWXDKpmavSGb/d7YWqJLoY9Cef7ZdnyKhoWolnn7SRwJyK7r+2gChZYp00kwtQL5m
        Jw8iAV87TRLTtjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ABC11351F;
        Thu,  6 Apr 2023 14:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R70kESrZLmRqMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 14:37:30 +0000
Date:   Thu, 6 Apr 2023 16:37:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: use safer allocation function in
 init_scrub_stripe()
Message-ID: <20230406143727.GQ19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 06, 2023 at 11:56:44AM +0300, Dan Carpenter wrote:
> It's just always better to use kcalloc() instead of open coding the
> size calculation.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Folded to the patch, thanks.
