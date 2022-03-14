Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC24D8C7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiCNTee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiCNTed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:34:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6E28E28;
        Mon, 14 Mar 2022 12:33:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E09D91F380;
        Mon, 14 Mar 2022 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647286401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/FLynAP77Cdi9cV8yer2GqLxasJJ+PbAyVCnYFohnQ=;
        b=giZDRrrRykOQZtD1zevrZ8E6CMdnic8OwCdy6WajaOtObnz0WlA7ruJBsFw9sy7WkeSjEA
        BAyXi9qgPmzZCIF/lSKXso+7Su8gDBkrA/ZOzsdbIqs8jvSkV+2JHlsOmGeXPV+wqVWqm7
        vBJRoHULNzWeG0AvUri0ZVKIicauGAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647286401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U/FLynAP77Cdi9cV8yer2GqLxasJJ+PbAyVCnYFohnQ=;
        b=rTopnQT7PP4CGAjcxQRV9glbZJ+0ONqZDEZxu10sljQpBDb/uD6m3BN6C5pBTVGvefnYGr
        T9oQHPNZn7ncgkAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D59E7A3B81;
        Mon, 14 Mar 2022 19:33:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91787DA7E1; Mon, 14 Mar 2022 20:29:23 +0100 (CET)
Date:   Mon, 14 Mar 2022 20:29:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: btrfs: update development git tree location
Message-ID: <20220314192923.GP12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220314190907.23279-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314190907.23279-1-sweettea-kernel@dorminy.me>
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

On Mon, Mar 14, 2022 at 03:09:07PM -0400, Sweet Tea Dorminy wrote:
> Patches get pulled into a branch on github as listed, before eventually
> making it into a pull request using the kernel.org git repository.
> Development is expected to work off of the github branch, though, so
> list it in MAINTAINERS as a secondary tree.

We have this documented on the wiki
https://btrfs.wiki.kernel.org/index.php/Btrfs_source_repositories
I don't think it needs to be in the maintainers file.
