Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2149F5F540B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJELwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJELvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 07:51:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077EE1F631
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 04:50:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E37F21978;
        Wed,  5 Oct 2022 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664970658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NvPq9uUSJNHTvpNzdUXYjeBb/jfyiJzgd7YpI4gxSbg=;
        b=IwbbS2D/Vfg6XU+AiiS8qzfYCeUGH8tRBsRJ+uY8Wk7Tcu6GVJpFOJP93ISw0oiwa1Sa1P
        NRqsOMXPn7dZcg9UPAYZ6OHV1Vvrb0rMS9+hJVm6zB6zOOt2lsh0esu8pZd128lHNxmeWq
        kHOmgTKe2xECE8eblWt88qTdUdMqJWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664970658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NvPq9uUSJNHTvpNzdUXYjeBb/jfyiJzgd7YpI4gxSbg=;
        b=4etiWiz3b9T1Bfj21XaDK5w/94Tnideic0iImfsjr8BjGsB1tW/ISAHP5j8a8r6N7AID6V
        Lgn7qRWR7dyjn+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6303113345;
        Wed,  5 Oct 2022 11:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B+w4F6JvPWN1WQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Oct 2022 11:50:58 +0000
Date:   Wed, 5 Oct 2022 13:50:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs-progs: mkfs-tests/025: fix the wrong function
 call
Message-ID: <20221005115055.GK13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664936628.git.wqu@suse.com>
 <e89c8122b8b999737e4164467b2b6164daae0575.1664936628.git.wqu@suse.com>
 <20221005144310.DA9C.409509F4@e16-tech.com>
 <3f0ff6ca-76f0-9e4c-7a3d-7c96ccafff57@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0ff6ca-76f0-9e4c-7a3d-7c96ccafff57@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 03:58:47PM +0800, Qu Wenruo wrote:
> On 2022/10/5 14:43, Wang Yugui wrote:
> >>   tests/mkfs-tests/025-zoned-parallel/test.sh | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tests/mkfs-tests/025-zoned-parallel/test.sh b/tests/mkfs-tests/025-zoned-parallel/test.sh
> >> index 8cad906cd5d1..83274bb23447 100755
> >> --- a/tests/mkfs-tests/025-zoned-parallel/test.sh
> >> +++ b/tests/mkfs-tests/025-zoned-parallel/test.sh
> >> @@ -8,7 +8,7 @@ source "$TEST_TOP/common"
> >>   setup_root_helper
> >>   prepare_test_dev
> >>
> >> -if !check_min_kernel_version 5.12; then
> >> +if ! check_min_kernel_version 5.12; then
> >>   	_notrun "zoned tests need kernel 5.12 and newer"
> >>   fi
> >
> > '_notrun' should be changed to '_not_run' too.
> 
> That's right, I forgot this as my previous patch would render the path
> unreachable for newer kernels.
> 
> David, can you fix it when merging?

Fixed and pushed, thanks.
