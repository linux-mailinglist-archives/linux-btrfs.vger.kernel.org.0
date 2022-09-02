Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90C5AB3DD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiIBOlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiIBOlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 10:41:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0217DDC2
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 07:01:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BF615BF5A;
        Fri,  2 Sep 2022 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662127255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBL730nWnSH04BpiB+sZQ/zAeIp74IdWgQdyIxTwOJU=;
        b=KQ5B6S6Ii+133OM39IHyFaclgcqhYMhO/6hwpZChKNaTkB4KaZbe6ZAM8D6+gjJGrvm/gz
        MJTbz+nmrwdKCT5C2Pd/A9TiJeGKlaDvMIHckqIYks93q10X/0NJ4azf9lOT6nMmjV1+y0
        WgCZ3qS1tooli0RZBzzu4H9opAhWItA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662127255;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBL730nWnSH04BpiB+sZQ/zAeIp74IdWgQdyIxTwOJU=;
        b=aucv45OWBQVOly5qhEaOJKSNuOm8KwTZheYSjSIlUX6mS9La5pCMhlvd7c/vXeu0jwWbRi
        5xkw33uJIvYspqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C2F413328;
        Fri,  2 Sep 2022 14:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jcrzAZcMEmP8EAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 14:00:55 +0000
Date:   Fri, 2 Sep 2022 15:55:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: slience the sparse warn of rcu_string
Message-ID: <20220902135534.GZ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220824051208.19924-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824051208.19924-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 24, 2022 at 01:12:08PM +0800, Wang Yugui wrote:
> slience the sparse warn of rcu_string reported by 'make C=1'
> 
> warning example:
> fs/btrfs/volumes.c:2300:41: warning: incorrect type in argument 3 (different address spaces)
> fs/btrfs/volumes.c:2300:41:    expected char const *device_path
> fs/btrfs/volumes.c:2300:41:    got char [noderef] __rcu *
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

With an updated changelog added to misc-next, thanks.
