Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0072A637
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jun 2023 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjFIWYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 18:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFIWYB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 18:24:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D501359C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 15:24:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 126B11FDFD;
        Fri,  9 Jun 2023 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686349439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STLVpLh7Nb+HpdpsfFWpL5et4C4edjxvMPGQ7afnSO4=;
        b=O6UeddgubhnO2SBRaC2abVbpP5VmB3Ar39owWnp6v5o1B96Au1/+gPn+CtR9Y9azUoLcO5
        yJuatHLbjXMt7JbUxTnERQCBgPwRr4/xTwdycZkbcRuWmUHCrYSt/dfsXn+iJRcgrbg00+
        L8XyorX179bRFi8wT3TImNkRkoXvqkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686349439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STLVpLh7Nb+HpdpsfFWpL5et4C4edjxvMPGQ7afnSO4=;
        b=6DPPPsmrNGbZ72DsQ3Vi/gXMSY886wInNjodXHGpGRjDF+eKYii5R2QJxZGs4kn55Gx4Bf
        YxAmI9JcocS+2gDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E21E42C141;
        Fri,  9 Jun 2023 22:23:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A51ADA85A; Sat, 10 Jun 2023 00:17:42 +0200 (CEST)
Date:   Sat, 10 Jun 2023 00:17:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix iomap_begin length for nocow writes
Message-ID: <20230609221742.GF12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230608091025.104716-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608091025.104716-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 08, 2023 at 11:10:25AM +0200, Christoph Hellwig wrote:
> can_nocow_extent can reduce the len passed in, which needs to be
> propagated to btrfs_dio_iomap_begin so that iomap does not submit
> more data then is mapped.
> 
> This problems exists since the btrfs_get_blocks_direct helper was added
> in commit c5794e51784a ("btrfs: Factor out write portion of
> btrfs_get_blocks_direct"), but the ordered_extent splitting added in
> commit b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
> added a WARN_ON that made a syzcaller test fail.
> 
> Fixes: c5794e51784a ("btrfs: Factor out write portion of btrfs_get_blocks_direct")
> Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com

Added to misc-next, thanks.
