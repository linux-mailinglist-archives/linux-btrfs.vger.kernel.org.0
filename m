Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6B4CE032
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiCDWXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDWXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 17:23:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4315C18D
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 14:22:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99B9521136;
        Fri,  4 Mar 2022 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646432543;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0DJvdaL+z1TwRUt3OrOPwJ3gfGUj7XjoYm3MpepIy8=;
        b=orAPLRvFnNgdGeL98FiFuR8sxTOi6T/gB6BIsHsAOHCW7QZdcFGdIArbxjMDhbNIwbtMgW
        DMsa8LiuJZp0EMmMwFx6UKK0E2odGbWHG0n4QZeeQkCYlyxoI86edKg7aK1+oljOefe9Jq
        IwyMNOy4zkcYFoxF9Pr5FnryVWoitjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646432543;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0DJvdaL+z1TwRUt3OrOPwJ3gfGUj7XjoYm3MpepIy8=;
        b=3XPWKMMUDeISmoIJZ45KOMxRdigtpUHqa3cYkahokrm8iEghtTNvStL2lRiBgrPmdObdhA
        RT1+7P/5fxMtlKCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 918B7A3B81;
        Fri,  4 Mar 2022 22:22:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A342DA7B4; Fri,  4 Mar 2022 23:18:29 +0100 (CET)
Date:   Fri, 4 Mar 2022 23:18:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/7] btrfs-progs: properly populate missing trees
Message-ID: <20220304221829.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645567860.git.josef@toxicpanda.com>
 <0acd92a3b95f21b89e249fdf2f78e914b6b9c1c0.1645567860.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acd92a3b95f21b89e249fdf2f78e914b6b9c1c0.1645567860.git.josef@toxicpanda.com>
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

On Tue, Feb 22, 2022 at 05:22:39PM -0500, Josef Bacik wrote:
> With my global roots prep patches I regressed us on handling the case
> where we didn't find a root at all.  In this case we need to return an
> error (prior we returned -ENOENT) or we need to populate a dummy tree if
> we have OPEN_CTREE_PARTIAL set.  This fixes a segfault of fuzz test 006.

This unfortunatelly breaks test fsck/001-bad-file-extent-bytenr, seems
that the image can't be properly restored before the test starts.
