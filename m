Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E735819AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiGZSZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbiGZSZu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:25:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C232D99
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 11:25:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D04C1FA10;
        Tue, 26 Jul 2022 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658859948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1M5A/Ul03xmPWzwhh+CHJOfMwztH3Ija6UWOYUPLY4=;
        b=Zs17s+w9pOFpFD+2sgF4ernK4fLg3go6rkCLVJ8Ww18fMzb86pzAOBYyBHTOae9c0zRcGq
        MyuO8SJeVi4YYFeQmSGOzyFg09eJHRmbsPSJ5dKjoHcbXacfFZrV2NxTmyDLTHi0QrWTkp
        CTiHXLPDCCuHLDJihaMaKR3U9s28xoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658859948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1M5A/Ul03xmPWzwhh+CHJOfMwztH3Ija6UWOYUPLY4=;
        b=SWT0R2HfFcdrP/06QTh+/oQ+abRLQrKte30hhzjHQ4EV8V4Jk42peAZT/AaPEPwduWMxcy
        zaIWnjgn9QVZ7QCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0503413A7C;
        Tue, 26 Jul 2022 18:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TVMrAKwx4GJVGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 18:25:48 +0000
Date:   Tue, 26 Jul 2022 20:20:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Message-ID: <20220726182050.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
 <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
 <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 09:03:33AM +0800, Qu Wenruo wrote:
> >> @@ -346,12 +346,14 @@ void __cold btrfs_err_32bit_limit(struct
> >> btrfs_fs_info *fs_info)
> >>   __cold
> >>   void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
> >>                      const char *function,
> >> -                   unsigned int line, int errno)
> >> +                   unsigned int line, int errno, bool first_hit)
> >>   {
> >>       struct btrfs_fs_info *fs_info = trans->fs_info;
> >>       WRITE_ONCE(trans->aborted, errno);
> >>       WRITE_ONCE(trans->transaction->aborted, errno);
> >> +    if (first_hit && errno == -ENOSPC)
> >> +        btrfs_dump_fs_space_info(fs_info);
> >>       /* Wake up anybody who may be waiting on this transaction */
> >>       wake_up(&fs_info->transaction_wait);
> >>       wake_up(&fs_info->transaction_blocked_wait);
> > DO_ONCE_LITE(btrfs_dump_fs_space_info, fs_info) from <linux/once_lite.h>
> > seems like a more lightweight way to dump the space infos once upon
> > first transaction abort. Then you don't have to plumb through the
> > 'first_hit' parameter from btrfs_abort_transaction(), and this change
> > becomes even more minimal than it already is.
> 
> Sounds pretty awesome!

But DO_ONCE_LITE stores the status in one static variable, this cant' be
used because we want to track the status per filesystem, and also per
mount. Ie. repeated ENOSPC after umount/mount cycle won't be reported,
also another filesystem hitting abort due to ENOSPC.

The first_hit logic as you have it now that passes the first transaction
abort to the report is correct.
