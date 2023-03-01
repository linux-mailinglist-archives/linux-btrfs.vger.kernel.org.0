Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FB6A6430
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 01:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCAAVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 19:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAAVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 19:21:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9314C3771E
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 16:21:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2934B1FDA4;
        Wed,  1 Mar 2023 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677630064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhjRhWc5cfpuqji2NfuvIZeZxqxAzUQ1g2cQl+rG05s=;
        b=GXvP8LKcte6C0LzeRNcqAJcJ+suUdT9Pnthv0Vv/Vv5GP+7jHhDoqEdkJVrWvuY8TglVYB
        5Y81X68N4VFWPeUkwJpk0r5ZzBWGJVWdkBjN3EHJQTu2MASNwVgHwXejjLl/eORfT1fZYU
        twPCTWGNqiQjUbCf813zi4BsM1gwOws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677630064;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhjRhWc5cfpuqji2NfuvIZeZxqxAzUQ1g2cQl+rG05s=;
        b=wAdrVMXbIYKt66vOmQNkjk/qNNUEEWlGvUHOmmZDpDVrxtXwXlVGzGpLScr3oYADE9JjFU
        PHZ9YVWx3jORkQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0423313A3E;
        Wed,  1 Mar 2023 00:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8yUO2+a/mOsSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 00:21:03 +0000
Date:   Wed, 1 Mar 2023 01:15:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.2
Message-ID: <20230301001504.GT10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
 <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 08:17:59AM +0800, Qu Wenruo wrote:
> On 2023/3/1 07:07, Tomasz Kłoczko wrote:
> > On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
> cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o 
> cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o 
> cmds/reflink.o mkfs/common.o check/mode-common.o check/mode-lowmem.o 
> check/clear-cache.o libbtrfsutil.a  -rdynamic -L.   -luuid  -lblkid 
> -ludev  -L. -pthread  -lz  -llzo2 -lzstd
> 
> According to the Makefile, it looks like Fedora build is not using the 
> built-in crypto code.
> 
> If using libsodium, I got the same error, as libsodium goes a different 
> name for its blake2b_init (crypto_generichash_blake2b_init).

Oh right, thanks, I can reproduce it now.
