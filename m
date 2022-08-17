Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD059720B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiHQOsO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiHQOsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:48:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9FB49;
        Wed, 17 Aug 2022 07:48:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CA8D1F8E7;
        Wed, 17 Aug 2022 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660747687;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15A3o8pzw2uvkF+OZu80gJIKsHpWU2h8OmqN7hLoi9c=;
        b=byZ5M6OkqndNJf5cravAAyIk73wnU1evVNDbRHdMR6hAkH2WSadTfZ/Szc9uThaVMfzxso
        QLTLf0YuXJuEtp9RBseB3lcML773Q4ZDEHixMxVMHw+K00fHwvx0qlQnzlACpovkXfKelK
        QpC8pKChdEn2Ic80Adbo7jsTQpq8Q+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660747687;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15A3o8pzw2uvkF+OZu80gJIKsHpWU2h8OmqN7hLoi9c=;
        b=ftmddMI9wXtkN8ie6tQbGQp9dnaD607NHOnj9dTSTyTuou+4snPz1AgVhJNpgbFpZUXtQ2
        kpX7Z/2yg4Q5jfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BB2E13428;
        Wed, 17 Aug 2022 14:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HRqJDaf//GKIfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 17 Aug 2022 14:48:07 +0000
Date:   Wed, 17 Aug 2022 16:42:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] fs: btrfs: fix possible memory leaks in
 btrfs_get_dev_args_from_path()
Message-ID: <20220817144256.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zixuan Fu <r33s3n6@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220815151606.3479183-1-r33s3n6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815151606.3479183-1-r33s3n6@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 15, 2022 at 11:16:06PM +0800, Zixuan Fu wrote:
> In btrfs_get_dev_args_from_path(), btrfs_get_bdev_and_sb() can fail if the
> path is invalid. In this case, btrfs_get_dev_args_from_path() returns
> directly without freeing args->uuid and args->fsid allocated before, which
> causes memory leaks.
> 
> To fix these possible leaks, when btrfs_get_bdev_and_sb() fails, 
> btrfs_put_dev_args_from_path() is called to clean up the memory.
> 
> Fixes: faa775c41d655 ("btrfs: add a btrfs_get_dev_args_from_path helper")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>

Added to misc-next, thanks.
