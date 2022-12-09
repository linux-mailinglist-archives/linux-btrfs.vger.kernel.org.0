Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E34647F63
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLIIjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 03:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLIIjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 03:39:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F02F4D5C6;
        Fri,  9 Dec 2022 00:39:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBFFE1FE95;
        Fri,  9 Dec 2022 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670575152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKoT7BgiNHVQfcynSO54/bGdBA+IOGji+zSe9yDp/6k=;
        b=O6pQU9TfkELUNhJYSDMM+aNqfO9G2HamVoGVgjGboF1lWF2GlCIwUcs+EAFwE5d77o8WoP
        odcEPRTN+Y2pCYfD6e+kj9hynroKAQCtMpX4IhCqZucgZCwKEuj6WYzaik5/SsjRBNoVO+
        RC6fDcFu2U2beUlthie77Eb40+5nXvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670575152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKoT7BgiNHVQfcynSO54/bGdBA+IOGji+zSe9yDp/6k=;
        b=rzUGFdHDZQ6hXjqIK4E9dDXC+baKZYInh5ZyCk3elyWn0a3Cqa93G+yU4/VYD+F/NrPAKK
        m2FzH8xXJKtUggAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEA5313597;
        Fri,  9 Dec 2022 08:39:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VVcRLTD0kmPjSQAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 09 Dec 2022 08:39:12 +0000
Date:   Fri, 9 Dec 2022 09:40:01 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/080: fix the stray '\'
Message-ID: <20221209094001.5c5f1bce@echidna.fritz.box>
In-Reply-To: <20221209061901.30511-1-wqu@suse.com>
References: <20221209061901.30511-1-wqu@suse.com>
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

On Fri,  9 Dec 2022 14:19:01 +0800, Qu Wenruo wrote:

...
> --- a/tests/btrfs/080
> +++ b/tests/btrfs/080
> @@ -76,7 +76,7 @@ workout()
>  # created fs doesn't get that feature enabled. With it enabled, the below fsck
>  # call wouldn't fail. This feature hasn't been enabled by default since it was
>  # introduced, but be safe and explicitly disable it.
> -_scratch_mkfs -O list-all 2>&1 | grep -q '\bno\-holes\b'
> +_scratch_mkfs -O list-all 2>&1 | grep -q '\bno-holes\b'
>  if [ $? -eq 0 ]; then
>  	mkfs_options="-O ^no-holes"
>  fi

Looks good. I think I've hit this one too...
Reviewed-by: David Disseldorp <ddiss@suse.de>
