Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5B64C80E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 12:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiLNLcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 06:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiLNLc3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 06:32:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09F11816;
        Wed, 14 Dec 2022 03:32:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9A2F22289;
        Wed, 14 Dec 2022 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671017546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zeLFl9gcdPCJ0Huj5C5N8ESv3K7b/0mCljOQLsoUn0=;
        b=m/Knqkhvcgc6SX39rYPpQMCizGchblCMV4eSn8zqlnY810rEARLSXyhtA1pcMbbEO+SeC8
        2aWqyo61LRphCMKTLwnJ1WgSDUybPdZeb/6fnz0NsZJR2d169d8YnTTdiXV1D1IPY+K1OH
        bNJ/FKn1ETGvjulbIarU2W28EwQCxkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671017546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zeLFl9gcdPCJ0Huj5C5N8ESv3K7b/0mCljOQLsoUn0=;
        b=Wl6Emedd1tBwUwro9M5vB8YL0w0e2D07zSF3vkxE8saj4G2gQxKO2EJzZLCtJCCvNo2U7f
        Erpfbotd3jbAHCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B06FE138F6;
        Wed, 14 Dec 2022 11:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xo6tKUq0mWPNRAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 14 Dec 2022 11:32:26 +0000
Date:   Wed, 14 Dec 2022 12:33:16 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] check: call _check_dmesg even if the test case failed
Message-ID: <20221214123316.4c26cc69@echidna.fritz.box>
In-Reply-To: <e8b3ba5973d9b24f33cbdbf99dc894f0ca656e02.1670976506.git.wqu@suse.com>
References: <e8b3ba5973d9b24f33cbdbf99dc894f0ca656e02.1670976506.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On Wed, 14 Dec 2022 08:08:31 +0800, Qu Wenruo wrote:

...
> index d2e5129620bd..487da43537ad 100755
> --- a/check
> +++ b/check
> @@ -950,6 +950,9 @@ function run_section()
>  			_scratch_unmount 2> /dev/null
>  			rm -f ${RESULT_DIR}/require_test*
>  			rm -f ${RESULT_DIR}/require_scratch*
> +			# Even we failed, there may be something interesting in
> +			# dmesg which can help debugging.

Nit: "Even though we ...", although the comment is probably unnecessary.

> +			_check_dmesg
>  			tc_status="fail"
>  		else
>  			# The test apparently passed, so check for corruption

Makes sense.
Reviewed-by: David Disseldorp <ddiss@suse.de>
