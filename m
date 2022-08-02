Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E72587E92
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiHBPHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHBPHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 11:07:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405BDD3
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 08:07:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 797BF2082D;
        Tue,  2 Aug 2022 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659452819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTnE8SBQqOqhHmhpJq6Zkf4/5kKOZkBoM3BnYHDtoqM=;
        b=Bli0oyeRX9sY98NvpzWdkxrSJd48pfwoIsvFj0tPVboT7zP49kdPwW+tsfJ2H6A3T3EUI/
        mWH/BwthtfnjD4KZ+4zRYkYLqhj8SJDJ7HN4lFHzk21uD9fzKJgm9qFEFe0JBJjXf9UZic
        o+p2RwecUtseRTCnubM/2InF5e3CPQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659452819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTnE8SBQqOqhHmhpJq6Zkf4/5kKOZkBoM3BnYHDtoqM=;
        b=m7YD8ke2Q/9Lh9eimYT9mkHUdPmSZ0ja/uHfxPBEuh8fCaO3y6u6XNt9SsZTidhv+wip4A
        wi/AOdIc0Gi9y5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5195D13A8E;
        Tue,  2 Aug 2022 15:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rEz7EpM96WIbCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 15:06:59 +0000
Date:   Tue, 2 Aug 2022 17:01:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: remove duplicated helper
Message-ID: <20220802150157.GQ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220802031110.3373296-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802031110.3373296-1-cccheng@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 11:11:10AM +0800, Chung-Chiang Cheng wrote:
> The helper `check_min_kernel_version` is duplicated and can be removed.
> 
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

Added to devel, thanks.
