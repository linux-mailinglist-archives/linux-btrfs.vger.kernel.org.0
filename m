Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222BA4EDF50
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiCaRD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 13:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiCaRDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 13:03:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D12C1D917E;
        Thu, 31 Mar 2022 10:01:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72EF1210F4;
        Thu, 31 Mar 2022 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648746094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrLcQqsOy2MMUv2jAhQzXmgiWR004Vcrgnce+Xhb8M8=;
        b=oJK10tQpFLGonXUBEZyMymAupUoVt4BgLQEui7nPJ10Q7+eeBbJq9UOaNOs+rtt0owHUvB
        HDYjloPQ/Zh29PVxCrCdJ3ctEjAWiUXVlkUYxOoGPUVFze6shxgsWjuNTaODMWSyKoICPn
        lLt+LE8kj+1w6SZQqZVztvlHZ6vPcNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648746094;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrLcQqsOy2MMUv2jAhQzXmgiWR004Vcrgnce+Xhb8M8=;
        b=LIWaiB8F2zs83JhxtpHY0OzG/Nahi0anq74xIwoCUK2HNbfDCzXxyW7n9p1fskiMDXtRFt
        ULezZvPAeUGOm3CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 35A65A3B82;
        Thu, 31 Mar 2022 17:01:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB1B1DA7F3; Thu, 31 Mar 2022 18:57:35 +0200 (CEST)
Date:   Thu, 31 Mar 2022 18:57:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] btrfs: remove unnecessary type castings
Message-ID: <20220331165735.GD15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yu Zhe <yuzhe@nfschina.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
References: <20220331103408.31867-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331103408.31867-1-yuzhe@nfschina.com>
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

On Thu, Mar 31, 2022 at 03:34:08AM -0700, Yu Zhe wrote:
> remove unnecessary void* type castings.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

Added to misc-next, thanks.
