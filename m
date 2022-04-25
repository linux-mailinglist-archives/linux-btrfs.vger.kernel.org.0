Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281C950EC8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiDYXXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiDYXXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 19:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9551D0F4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 16:19:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46FC4210EA;
        Mon, 25 Apr 2022 23:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650928796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwx0bqXRcyCCSVPskIlWOVSckXKowoNHrhP04PGpN4E=;
        b=nsDQSdD5g2POhgc9o8w544zup+twi/HwDfIMz3NCJrLnouKcTe16oY3t4CirVr6AqGGq1L
        sTx0OLdwwf0NPVI1Mij612rOiYAhnHzZ3z+28G+2rcW6rH2EHl9OPv2NjVsA9Ztbh3SLIZ
        M3fqJkHziUnoDFMR0eVehQnwrU1b69c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650928796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwx0bqXRcyCCSVPskIlWOVSckXKowoNHrhP04PGpN4E=;
        b=IvrdOy1JLxz6ezQz6zSCx7WKoOdaqvQgko13LBulsOEKLvSN2UYKsTWo0OFqOcjbxdFh6k
        cAkeiCiGdVSaBgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14F2713AE1;
        Mon, 25 Apr 2022 23:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cTUgBJwsZ2LSXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 23:19:56 +0000
Date:   Tue, 26 Apr 2022 01:15:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and
 sprouted filesystems
Message-ID: <20220425231549.GV18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
 <20220425170408.GR18596@twin.jikos.cz>
 <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
 <a81220ac-9585-88b0-67eb-14a5a9df2945@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81220ac-9585-88b0-67eb-14a5a9df2945@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 07:06:00AM +0800, Qu Wenruo wrote:
> >>> +prepare_loopdevs
> >>> +dev1=${loopdevs[1]}
> >>> +dev2=${loopdevs[2]}
> >>> +TEST_DEV=$dev1
> >>> +
> >>> +setup_root_helper
> >>> +
> >>> +run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f $dev1
> >>               ^^^^^^^^^^^^^
> >>
> >> It's $SUDO_HELPER, otherwise it does not work, also please quote all
> >> shell variables, everywhere.
> 
> Surprise surprise, it's from my vim's context based completion.
> 
> It turns out that fsck/056 has the same problem...

I see, fixed as well.
