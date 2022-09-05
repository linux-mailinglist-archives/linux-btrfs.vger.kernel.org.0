Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98135AD37F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiIENMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiIENMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 09:12:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BC3B976
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 06:12:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE28D1FA17;
        Mon,  5 Sep 2022 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662383558;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNdPGnDlEr62rzwf300MYOoFxCDScD9GJ+4aBbZ3HnU=;
        b=kFk2Htsiyib+0BHOCrXeqHkgGDVoQ7pHiPWXnI/OO0u4V2t2mTYRBtm5zlh6SzGBtbU25b
        P9S1CMyQGfyk75nk1Z3Cpb894kkmRAdTKW/p/GjzjKwz9/rXDgVfdZfteLZewXWjka/X7l
        I0jopyptkuZBJNHr3n40DizMeGo6I9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662383558;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNdPGnDlEr62rzwf300MYOoFxCDScD9GJ+4aBbZ3HnU=;
        b=Sw6xESRZaYwW4sNPsVucQMtJyWEZhtgy3gvJBKb+HuZVYmVEYt4jwl/Jlz0yky1HADv3Es
        wUAmM2WSC9VS0RBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1C4B139C7;
        Mon,  5 Sep 2022 13:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 07KAKsb1FWM3GAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Sep 2022 13:12:38 +0000
Date:   Mon, 5 Sep 2022 15:07:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
Message-ID: <20220905130716.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
 <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
 <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
 <5052c751772dd32713db530191a4fb8a4ad724df.camel@scientia.org>
 <5d2ffc82-8b25-fb3b-4074-bb209747edf2@gmx.com>
 <2895cb80db8794b1bf3ce4fccbb0e5df1ca311b0.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2895cb80db8794b1bf3ce4fccbb0e5df1ca311b0.camel@scientia.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 04, 2022 at 01:06:12AM +0200, Christoph Anton Mitterer wrote:
> Google used to perform better ... I actually searched for the message,
> but it only brought up some quite old patches:
> https://patchwork.kernel.org/project/linux-btrfs/patch/1420444575-23259-1-git-send-email-quwenruo@cn.fujitsu.com/
> https://patchwork.kernel.org/project/linux-btrfs/patch/aa032e11aa2b8667a28a93b90691d6f790711c62.1612449293.git.fdmanana@suse.com/#23954447
> 
> 
> On Sun, 2022-09-04 at 07:01 +0800, Qu Wenruo wrote:
> > Yep.
> 
> As always, thanks :-)

I'll do a btrfs-progs bugfix release soonish, including this fix.
