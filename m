Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AE4D8BFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 19:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiCNTAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiCNTAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:00:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860813D51
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 11:59:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DE4C821111;
        Mon, 14 Mar 2022 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647284377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTXGw5YFvJ9H0DprQ3eEt6uTztoUC/9Guc1wUW5MS+g=;
        b=OyzEj7CfscyhHmLSfvBOcYFqnYU3xBW++0YPQ9RaAid/hmzS2PlXyffb1V206Q63Nj7ix6
        9+V0XFts4CSV9wuh1i6jOR7Z/1G317BbmbX3lmTuza9QQkQcmbUaHvmK0KFA4FaZ27+mDK
        3B9QEAEPbE4OC0DADN2QJLWXeRo2Wwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647284377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTXGw5YFvJ9H0DprQ3eEt6uTztoUC/9Guc1wUW5MS+g=;
        b=tO3qFwPcKbYSH6mSVfOTh5p1fjOTw50VtfXvVlgEfrVSA7w6Nj6OtMBEhbk+VXN2jEbntO
        rvrceLFWx33TvCCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9D3C1A3B8A;
        Mon, 14 Mar 2022 18:59:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AF6EDA7E1; Mon, 14 Mar 2022 19:55:39 +0100 (CET)
Date:   Mon, 14 Mar 2022 19:55:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Message-ID: <20220314185539.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
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

On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:
> Anand pointed out, that instead of using the rcu locked version of
> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected by
> the chunk_mutex to traverse the list of active deviices in
> btrfs_can_activate_zone().

Why?
