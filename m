Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8B4E99EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbiC1OnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1OnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 10:43:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD242493
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 07:41:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DE78210EE;
        Mon, 28 Mar 2022 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648478492;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kN1+TAjSUyz1GVeDFh68U2i4TCtB8OZChdV2q7hqaCQ=;
        b=XIoHa0/Ml13ZPH4GkBPrugltrZRyfhfYDojOwmYnPIC+gr53Wxfolta7TLakNsNYpcfNcM
        8TznU+zZlU+uQvlynTtwDBztA7n/6U6yvL4kWFtuEf3pRbjazSxQZLoegRsP0yh4Unc7Jz
        3aIJOSnhqaNjDGK6ZK9anE4e15vlqas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648478492;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kN1+TAjSUyz1GVeDFh68U2i4TCtB8OZChdV2q7hqaCQ=;
        b=ye/XuzisSVygziApxJnpI6hFagi7hntXmXVcxAXMd5GHjJ1Tc0wlcmffMksb6/frv/SPzs
        h5iq9QJhR8yCj1AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9717A3B92;
        Mon, 28 Mar 2022 14:41:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EEE58DA7F3; Mon, 28 Mar 2022 16:37:34 +0200 (CEST)
Date:   Mon, 28 Mar 2022 16:37:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Message-ID: <20220328143734.GO2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-2-hch@lst.de>
 <PH0PR04MB741622755155D80EAF5CCAC29B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741622755155D80EAF5CCAC29B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Fri, Mar 25, 2022 at 07:33:25AM +0000, Johannes Thumshirn wrote:
> Fine by me, but it was explicitly requested to be this way IIRC.

This was before there was the btrfs_is_zoned helper that now wraps the
condition.
