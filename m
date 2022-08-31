Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92D65A7F17
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiHaNmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHaNmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 09:42:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215FCC304
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 06:42:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54DD6220FC;
        Wed, 31 Aug 2022 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661953325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzvXe78sPpjr8oz/WmwXFoBV+bH0P2JiIvyeRR1mQ7E=;
        b=Fw2cneohqpnBZvarOAbCZumD4O4/iL06RLcm1sYF6hW85tnMD9hVtEmdHEaz8CzmPV+zeG
        XE7H+LSBOdGfajG3aLlv1whUZieiwAx2brqcLG4VKfJekpiNvgWnt3u7vZLew1LfVte5iN
        49868jFmreYGssrQXzy7A9UUzVi5A7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661953325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzvXe78sPpjr8oz/WmwXFoBV+bH0P2JiIvyeRR1mQ7E=;
        b=IL1GfoIpwKqpp9LF/n0PPCXcRzlewX37xwJkYKxWJgkjw8BxgKC+HFIfpcPteGn8RWMk8D
        XgynTJg9gzGR52AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22DA51332D;
        Wed, 31 Aug 2022 13:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XSBBy1lD2OZPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 13:42:05 +0000
Date:   Wed, 31 Aug 2022 15:36:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix eb leakage caused by missing
 btrfs_release_path() call.
Message-ID: <20220831133646.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
 <20220830171730.GB13489@twin.jikos.cz>
 <72b31d43-07fc-6126-b326-5110315ae342@gmx.com>
 <20220830214902.GE13489@twin.jikos.cz>
 <99439be1-d7af-5db6-7eb7-7bac5657ef05@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99439be1-d7af-5db6-7eb7-7bac5657ef05@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 31, 2022 at 06:15:15AM +0800, Qu Wenruo wrote:
> On 2022/8/31 05:49, David Sterba wrote:
> > On Wed, Aug 31, 2022 at 05:49:13AM +0800, Qu Wenruo wrote:
> >>> I do that because that's the preferred style, but not all people respond
> >>> to mailing list comments so we're left with unfixed bug with patch or a
> >>> unclean version committed if there's no followup. Or something in
> >>> between that could introduce bugs.
> >>
> >> Another thing related to this on-stack path usage is, do we need the
> >> same change in kernel space?
> >
> > No, in kernel the stack space is a limited resource.
> 
> Should it be a case by case check or a general recommendation?

Path is not suitable for on-stack storage, it's 112 bytes and used in
may functions called deep from call chains. The safe case for on-stack
storage are typically the ioctl callbacks for the ioctl arguments where
the ioclt is also lightweight (not doing IO).

> As for some call sites which is known to have very shallow stack height,
> can we use on-stack path or just avoid it for all cases?

The on-stack can be considered an optimization so it should be done in
cases where we gain something, eg. removing a potential error case,
otherwise for consistency it can be allocated by kmalloc or from the
slab caches. Using the on-stack storage should be justified and proven
that it's safe and not a first thought trying to be clever.

The stack depth on function entry could be estimated in some cases but
when IO is involved it's best to reduce the consumption when the block
layer or other layers are stacked, eg. MD/LVM/NFS/iSCSI/... Temporary
local variables should be free to use, compiler will know if it's safe
to reuse the memory and we can have readable code, so it's namely for
arrays or large structures.
