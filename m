Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82B44D30EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiCIOXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 09:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCIOXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 09:23:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9276CD54
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 06:22:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9C2021116;
        Wed,  9 Mar 2022 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646835754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WhoimC66Ho/e2BkJsYVS+3hFd6uxNO+F/9Q9AKiIRs=;
        b=K6qwDrQDfGFQ0Ifr/SnPZKNRa79DYeM0k5vOnpkI1vh6BRFRbtCKcLWOW7VsM3FhVygnfC
        BaXgk/XiGfmzI/5hcbbZEyq7ExiyywOlOZKqH/5Rc1QhfLquCfbji+LCbEA0wSgFm2Quoc
        2+KtbX1m7oEubN5bfm/LPPpc6WORFhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646835754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WhoimC66Ho/e2BkJsYVS+3hFd6uxNO+F/9Q9AKiIRs=;
        b=Ap4VDjwEQhnpeZYWJoEVZ9Q+M9fqP6PjEX0b+Itoa69dwaAa7rZ9AZqh/ACnudLeBzlJdW
        2oeO/nWVlBbWDKAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B7730A3B84;
        Wed,  9 Mar 2022 14:22:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35C53DA7F7; Wed,  9 Mar 2022 15:18:39 +0100 (CET)
Date:   Wed, 9 Mar 2022 15:18:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 04/13] btrfs-progs: convert: use cfg->leaf_data_size
Message-ID: <20220309141839.GV12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1645568701.git.josef@toxicpanda.com>
 <c0abc5a5a87e6e8f22d225185a0fd23cafe0325e.1645568701.git.josef@toxicpanda.com>
 <bb846d2a-26a2-9a8e-be5b-e7c6daf6ab61@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb846d2a-26a2-9a8e-be5b-e7c6daf6ab61@suse.com>
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

On Wed, Mar 09, 2022 at 01:48:08PM +0200, Nikolay Borisov wrote:
> 
> 
> On 23.02.22 г. 0:26 ч., Josef Bacik wrote:
> > The mkfs_config can hold the BTRFS_LEAF_DATA_SIZE, so calculate this at
> > config creation time and then use that value throughout convert instead
> > of calling __BTRFS_LEAF_DATA_SIZE.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> nit: IMO this patch should be squashed into the patch 02.

I don't mind the patch granularity, both ways it's reviewable and clear.
