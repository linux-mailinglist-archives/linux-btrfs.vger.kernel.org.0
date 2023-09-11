Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E479AF8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjIKWAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbjIKRfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:35:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19631B8
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:35:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6482121842;
        Mon, 11 Sep 2023 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694453700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYRYgjntgu6b6mEWldKuccG3gcBVqn6OG8aZTDbKTLk=;
        b=XkZeSMgQOHsmLpNZAPzyar7JdKkVkzywcuWT64/rkjCnlSvriwgmoEXjNhl+VrxziYcaPq
        +O1A82Sfkimm18oXrowbrWMj8chAZkRK2bsAcPEQO2axeW00nnl/ttXImh8tPvtjI9pthV
        yJyBBDx3tpgYr/3HVXo3M2I4YnOrJz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694453700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYRYgjntgu6b6mEWldKuccG3gcBVqn6OG8aZTDbKTLk=;
        b=enYs8R50BKyyN1+J6Uj0v61oS5zuIaFxXhcjYjVH1/EKry0JyCInrGWdJ5clWRsxmo9dqZ
        AEKw79XLdUcVLvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49E3513780;
        Mon, 11 Sep 2023 17:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ZpYEcRP/2SiKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 17:35:00 +0000
Date:   Mon, 11 Sep 2023 19:28:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, ian@ianjohnson.dev,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: updates for directory reading
Message-ID: <20230911172825.GD3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694260751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694260751.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 01:08:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Tweak and fix a bug when reading directory entries after a rewinddir(3)
> call. Reported by Ian Johnson.
> 
> Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/T/#u
> 
> Filipe Manana (2):
>   btrfs: set last dir index to the current last index when opening dir
>   btrfs: refresh dir last index during a rewinddir(3) call

Thanks for the quick fixes, added to misc-next.
