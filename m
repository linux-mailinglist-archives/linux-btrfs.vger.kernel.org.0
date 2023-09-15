Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9617A2138
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjIOOlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIOOlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 10:41:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D11713
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 07:41:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A945A218D6;
        Fri, 15 Sep 2023 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694788866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQ9cvdeTkG4X7+RmDzofJXnnk000CzO0jZOnoFTmr/Q=;
        b=FMu7UNGrCVbecl4HwFmdhfRiVUtoHsJONpwUsvlxV3D8FuBHmybVMAJ2WX7qsHPItFRsRk
        DpvfkNo0ozSiKt2Loby9se0+lB33/X2G51UOl8hehTSO3XEDg93OWY7oTDqvjTNI/dg4wJ
        AGJfnk7b8hQv7LzNROtVErtOdPjUEp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694788866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQ9cvdeTkG4X7+RmDzofJXnnk000CzO0jZOnoFTmr/Q=;
        b=iszyU1GqYOlBW5V7RvbKnVz7UJq/hTjYuOHtUX+eS6pyW18Q+QsuyhfpOCjlmE6MJEjSA0
        C/LDDMVwWgMioIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E4CB13251;
        Fri, 15 Sep 2023 14:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5j/3HQJtBGWtBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 14:41:06 +0000
Date:   Fri, 15 Sep 2023 16:34:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] btrfs: fix smatch static checker warning in
 btrfs_scan_one_device
Message-ID: <20230915143432.GB2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <81fd5fbda9772cde786d60b3cecf7d60d5a378f0.1694765532.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81fd5fbda9772cde786d60b3cecf7d60d5a378f0.1694765532.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 04:17:21PM +0800, Anand Jain wrote:
> Commit d41f57d15a90 ("btrfs: scan but don't register device on
> single device filesystem") might call btrfs_free_stale_devices() with
> uninitialized devt.
> 
> To fix bring the btrfs_free_stale_devices() under the else part which
> will ensure devt is initialized.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-btrfs/32e15558-0a3f-418a-b3ae-8cfbddbff7af@moroto.mountain
> Fixes: d41f57d15a90 ("btrfs: scan but don't register device on single device filesystem")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> David,
> 
>   Could you pls fold this fix into the commit d41f57d15a90 ("btrfs: scan
>   but don't register device on single device filesystem")

Folded, thanks.
