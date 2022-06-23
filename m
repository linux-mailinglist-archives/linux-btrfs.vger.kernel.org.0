Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10761557DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiFWObY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiFWObV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 10:31:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716345781
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 07:31:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBB6D21D29;
        Thu, 23 Jun 2022 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655994679;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m31A2MiGOAxAp+D58iuCEnDbgmUA3hVQnGyIoQbonFc=;
        b=MTwzfyrlYaEtRpK3Mg+0CsLjOb2r3VdZj/BATdO/HNzNOBTJHuGPG0X02FbYrnki0zH6Yk
        UcEzOwatX/UHKLyccXgVsSNkZxZMlF58T4QrR2ZokUT0Vmm8kCI4ZZJRsd2R7mShHVNj/X
        VnmKZ6ma5Fv1mPGcUcBt0yqzA/EMpqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655994679;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m31A2MiGOAxAp+D58iuCEnDbgmUA3hVQnGyIoQbonFc=;
        b=LDNBQJX4ZvFlCUY4zI01IrK2FRXCyCOGTt9yeolsLQ5WEMaoYRflJYtdlBv34Kd2H20XWq
        YKXts8H9yE8GPiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FD82133A6;
        Thu, 23 Jun 2022 14:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id begGJjd5tGKSTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Jun 2022 14:31:19 +0000
Date:   Thu, 23 Jun 2022 16:26:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Properly flag filesystem with
 BTRFS_FEATURE_INCOMPAT_BIG_METADATA
Message-ID: <20220623142641.GQ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220623075547.1430106-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623075547.1430106-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 10:55:47AM +0300, Nikolay Borisov wrote:
> Commit 6f93e834fa7c seeimingly inadvertently moved the code responsible
> for flagging the filesystem as having BIG_METADATA to a place where
> setting the flag was essentially lost. This means that
> filesystems created with kernels containing this bug (starting with 5.15)
> can potentially be mounted by older (pre-3.10) kernels. In reality
> chances for this happening are low because there are other incompat
> flags introduced in the mean time. Still the correct behavior is to set
> INCOMPAT_BIG_METADAT flag and persist this in the superblock.
> 
> Fixes: 6f93e834fa7c ("btrfs: fix upper limit for max_inline for page size 64K")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
