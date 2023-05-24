Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024970F2C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbjEXJaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 05:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbjEXJ35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 05:29:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FF90;
        Wed, 24 May 2023 02:29:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A1A41FDB1;
        Wed, 24 May 2023 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684920594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGQvzW+Ai0N6JzBCRDYD9ANjB+5pdCPWrZ/ZW6bNATU=;
        b=QmaO7/TVEdXRc2ZfW5QqKJSzNMUOmxWIDNB6OGRYC4BOUI6i1qLOjTEYkOSHYIzQ7sUreX
        mIr9MO8/EQ1lobHYc7RfSpu+vaQccIjpuEhrs/ondR/SO5UIbQsQBbqOcvGfTwDjObM6A1
        CumCX5lRKXxKuDWKqoq44uH22oiUs6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684920594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGQvzW+Ai0N6JzBCRDYD9ANjB+5pdCPWrZ/ZW6bNATU=;
        b=Jm2FeBO6CN2J5Qdpaen4fp8Cs5uhaO/2fEkgDQxqFrP+kzx7uw37gi6NTJn+3EpK/YCnxM
        2XGRcs4yVazvXrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5055D13425;
        Wed, 24 May 2023 09:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2t7mEhLZbWQzAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 09:29:54 +0000
Date:   Wed, 24 May 2023 11:23:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Message-ID: <20230524092346.GI32559@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
 <CANubcdVZ4tUZo=HDytwYFTZiQwo8QSABskBfZXL+y_swXvb_DA@mail.gmail.com>
 <20230522215144.GS32559@twin.jikos.cz>
 <409455a1-560f-24d0-e28f-74c665668050@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409455a1-560f-24d0-e28f-74c665668050@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 06:47:39PM +0800, Qu Wenruo wrote:
> On 2023/5/23 05:51, David Sterba wrote:
> > On Wed, May 17, 2023 at 05:07:55PM +0800, Stephen Zhang wrote:
> >> Qu Wenruo <quwenruo.btrfs@gmx.com> 于2023年5月17日周三 15:47写道：
> >>> On 2023/5/16 09:34, zhangshida wrote:
> >>>> From: Shida Zhang <zhangshida@kylinos.cn>
> >>>>
> >>>> This fixes the following warning reported by gcc 10 under x86_64:
> >>>
> >>> Full gcc version please.
> >>
> >> it's "gcc (Debian 10.2.1-6) 10.2.1 20210110".
> >>
> >>> Especially you need to check if your gcc10 is the latest release.
> >>>
> >>> If newer gcc (12.2.1) tested without such error, it may very possible to
> >>> be a false alert.
> >>>
> >>> And in fact it is.
> >>>
> >>> @first_dir_index would only be assigned to @last_range_start if
> >>> last_range_end != 0.
> >>>
> >>> Thus the loop must have to be executed once, and @last_range_start won't
> >>> be zero.
> >>>
> >>
> >> Yup, I know it's a false positive. What I don't know is the criterion
> >> that decides whether it is a good patch.
> >
> > If you have analyzed the code and found out that it was indeed a false
> > positive then please state that in the changelog. Fixing it still makes
> > sense so the compiler version and briefly explaining why you fix it that
> > way makes it a good patch.
> >
> >> That is,
> >> it doesn't look so good because it is a false alert and the latest gcc
> >> can get rid of such warnings, based on what you said( if I understand
> >> correctly).
> >> Or,
> >> It looks okay because the patch can make some older gcc get a cleaner
> >> build and do no harm to the original code logic.
> >
> > In general I agree here.
> >
> >> In fact, I've seen Linus complaining about the warning generated by
> >> some gcc version in another thread.
> >>
> >> https://lore.kernel.org/linux-xfs/168384265493.22863.2683852857659893778.pr-tracker-bot@kernel.org/T/#t
> >
> > I share the POV for warning fixes, I'd rather see new reports after
> > fixing the previous ones than reminding everybody to update.
> 
> Or can we only enable -Wmaybe-uninitialized only for certain builds?
> Like binding it with CONFIG_BTRFS_DEBUG?
> 
> So far all warning are false alerts, and I'm really not a fan of false
> alerts.

Josef found some real bugs with this warning enabled and then we decided
it would be a good idea to have it enabled for all builds. If we don't
do it by default then the chances that people will use it are low.

> The -Wmaybe-uninitialized option doesn't look that reliable on older
> compilers, and for developers we're more or less using uptodate
> toolchains anyway.

Yeah the warning is speculative so the compilers can report more false
positives. I still have some very old test setups and the compiler gets
updated rarely, IIRC I went from 4.x to 7.x and now there's 10.x so I
might send some warning fixes myself.  Over time I'd like to enable more
warnings just for fs/btrfs/.
