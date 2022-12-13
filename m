Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7864BCA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiLMTDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiLMTDP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4966567
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:03:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43C1E1FDF1;
        Tue, 13 Dec 2022 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670958193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsIyl+wvgAtOWX5og7Z5J5incanR35cqcskUjMzDZrM=;
        b=t8t34ICVXKUIXl8nGFclnv7KkpfdkN6Yuq6w9UFiXZwmP/ztFlNJeoW3j+O0N0gzBHPtEP
        485QuBt8/3s6ngdVu1F5Qg+8y233HvoE+0jTlL3xm0TC7FYVpf/SAQ7oWIr+oHYNyy3o3C
        XEghiTmW7SYn13eEJikuDRp1HLTUoNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670958193;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsIyl+wvgAtOWX5og7Z5J5incanR35cqcskUjMzDZrM=;
        b=qmFjd65xbuwz15N4i+T2tcW71/coDP1d8XT064O6IH4UpvqdvyiArmLjDZhTUwMroQ1AmX
        eT6tYKQ/CTovm+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27B7E138F9;
        Tue, 13 Dec 2022 19:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gk7bCHHMmGNwBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Dec 2022 19:03:13 +0000
Date:   Tue, 13 Dec 2022 20:02:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: refactor anon_dev with new_fs_root_args for
 create subvolume/snapshot
Message-ID: <20221213190231.GH5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221205095122.17011-1-robbieko@synology.com>
 <20221205095122.17011-2-robbieko@synology.com>
 <CAL3q7H5aX6_ht0DMRg=_XHhBWMeVOYWSNUzvtbiSq+AFEbkA_w@mail.gmail.com>
 <b09892a5-c865-a3a7-1da1-61878e299f4a@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b09892a5-c865-a3a7-1da1-61878e299f4a@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 11:29:09AM +0800, robbieko wrote:
> Filipe Manana 於 2022/12/13 上午1:04 寫道:
> >> +       int err;
> >> +       struct btrfs_new_fs_root_args *args;
> >> +
> >> +       args = kzalloc(sizeof(*args), gfp_mask);
> >> +       if (!args) {
> >> +               err = -ENOMEM;
> >> +               goto error;
> >> +       }
> > if (!args)
> >       return ERR_PTR(-ENOMEM);
> >
> > That's simpler.
> 
> We hope to satisfy the single-exit rule as much as possible to increase
> code readability and uniform resource release.

If there's no cleanup needed the first few checks can do direct return,
and then the part with single exit and errors handled as goto.
