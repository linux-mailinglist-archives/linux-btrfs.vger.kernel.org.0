Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAE73887B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjFUPKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjFUPKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 11:10:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF84ED6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 08:05:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFB0E21C16;
        Wed, 21 Jun 2023 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687359870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyoUXAJ1DerSamQx19C/Qf0QTR8cnmyO8xyuGFA33KE=;
        b=KzXOSaWzBCPhhkXXU56UiWzMWJqYU018JCF3o0EFWR9kIxv+jSFCsc8KtWuzHpzrvEmmJV
        hfdpS3uV7LIezjOrPCHmauucl6/E6vdxdTcfeuxmOIjRH1dczTKVagoAlcV1Bh/7sX4Ib7
        R+0lA7dz/8K7p0E1YPUkU4p7E19EVtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687359870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyoUXAJ1DerSamQx19C/Qf0QTR8cnmyO8xyuGFA33KE=;
        b=0V/8nTzNjNx38AkkFg+NdVqDRLgP/iYyBjR7eG90Z9/3g/+oN+pGG7pkuFq6yFLWcWKrSx
        aMl7noAspVFRmfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B621133E6;
        Wed, 21 Jun 2023 15:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1e1HIX4Rk2TgGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Jun 2023 15:04:30 +0000
Date:   Wed, 21 Jun 2023 16:58:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] btrfs-progs: tests:
 misc/057-btrfstune-free-space-tree check for btrfs acl support
Message-ID: <20230621145806.GR16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687242517.git.anand.jain@oracle.com>
 <4884e218dfb91cd1290d42ec030bd8c1af54bdcb.1687242517.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4884e218dfb91cd1290d42ec030bd8c1af54bdcb.1687242517.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 04:49:58PM +0800, Anand Jain wrote:
> Fix failure due to no acl support in btrfs.
> 
>   $ make test
>     ::
>     [TEST/misc]   057-btrfstune-free-space-tree
>     failed: setfacl -m u:root:x /Volumes/ws/btrfs-progs/tests/mnt/acls/acls.1
>     test failed for case 057-btrfstune-free-space-tree
>     make: *** [Makefile:493: test-misc] Error 1
> 
> Instead, use check_prereq_btrfsacl() to call _not_run().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
> index 93ff4307fca9..d91fe2588c93 100755
> --- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
> +++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
> @@ -10,6 +10,7 @@ check_prereq btrfs
>  
>  setup_root_helper
>  prepare_test_dev
> +check_prereq_btrfsacl

You can do all the test case changes in one patch, the error messages
are basically the same.
