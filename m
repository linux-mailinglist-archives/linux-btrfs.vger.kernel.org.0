Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139B4C7B2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 22:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiB1U7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 15:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiB1U7B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 15:59:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CBE24F22;
        Mon, 28 Feb 2022 12:58:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFAA0210FA;
        Mon, 28 Feb 2022 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646081900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FteZVt9c1MVKPFOCakOdo0gY5PZ/CDEv9TeOnEDnzOQ=;
        b=0BqAyGXLksG7ZI4n7LCThq80eQYwPHuiKuf2eNujA9MT4hKQEc2ClhvKbeK3xznWMQ3LeU
        YYsmOWUHWR+dD7izAeLHqe9F5eOwIb8CvvAGJsrneYclPV2sJcfgDSmqKlIVEr7c9iODLW
        VmzvC1wohnHxF2TRGETCuShJ/UYxSLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646081900;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FteZVt9c1MVKPFOCakOdo0gY5PZ/CDEv9TeOnEDnzOQ=;
        b=3PIPU2vjGWQiJMKrLRdGGaNPg3DvWGNCDbE44h8dAAJpRVg5dtVQD12lOUOeY/5I0GqslI
        xRZH6czIHsz+ITDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9CACA3B81;
        Mon, 28 Feb 2022 20:58:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1FE8DA823; Mon, 28 Feb 2022 21:54:29 +0100 (CET)
Date:   Mon, 28 Feb 2022 21:54:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Niels Dossche <niels.dossche@ugent.be>
Subject: Re: [PATCH] btrfs: extend locking to all space_info members accesses
Message-ID: <20220228205429.GL12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Niels Dossche <dossche.niels@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        Niels Dossche <niels.dossche@ugent.be>
References: <20220225212028.75021-1-niels.dossche@ugent.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225212028.75021-1-niels.dossche@ugent.be>
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

On Fri, Feb 25, 2022 at 10:20:28PM +0100, Niels Dossche wrote:
> bytes_pinned is always accessed under space_info->lock, except in
> btrfs_preempt_reclaim_metadata_space, however the other members are
> accessed under that lock. The reserved member of the rsv's are also
> partially accessed under a lock and partially not. Move all these
> accesses into the same lock to ensure consistency.
> 
> Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>

Added to misc-next, thanks.
