Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77D4E4578
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiCVRuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbiCVRuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:50:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5326132
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:49:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AEA851F387;
        Tue, 22 Mar 2022 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647971349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yHo16l93jgECwkiIpDQMsEsceOdsUz+Mwe0rqx5pMs=;
        b=MJ9KBHLyyyecvLtpPVdzE0mRh0P5CSixkH2Zu5JqBsAxQ01Kk6ByyksAf8tMvCx5x5hMC0
        PN8MhXlWn56soBSBuDaxn1CPnk6ZeeyJv+gOeh4m2WAk2QOgYNUIjU6uT0OiEQ0dyFHJst
        FQYhiVwJLFrdkL/qGw+uwcYFU24pKCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647971349;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yHo16l93jgECwkiIpDQMsEsceOdsUz+Mwe0rqx5pMs=;
        b=Bgu6heQu2P+EpiNG7vNHZiFQssozJOofCYHfOT3bxVfAAwxRzLUl843pJEUNt84KwBF3vp
        Gv/aqsbOpB/wKpAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A1AC5A3B81;
        Tue, 22 Mar 2022 17:49:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 14680DA818; Tue, 22 Mar 2022 18:45:07 +0100 (CET)
Date:   Tue, 22 Mar 2022 18:45:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v1 1/2] Add Btrfs messages to printk index
Message-ID: <20220322174506.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jonathan Lassoff <jof@thejof.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>
References: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957b1f70097b44c3fba4419bc96c262f720da500.1647539056.git.jof@thejof.com>
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

On Thu, Mar 17, 2022 at 10:45:08AM -0700, Jonathan Lassoff wrote:
> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage this printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
> 
> So that detailed Btrfs messages are captured by this printk index, this patch
> wraps btrfs_printk and btrfs_handle_fs_error with macros.

So this is just a change in how the printk API is used, right? With this
patch we don't need to do anything else in btrfs and there are some
tools that can generate the list that's in patch 2 and post-process it.
