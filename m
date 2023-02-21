Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1669EB7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 00:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBUXx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 18:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBUXxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 18:53:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF42F79C;
        Tue, 21 Feb 2023 15:53:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1585C5CE5C;
        Tue, 21 Feb 2023 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677023623;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JvwipWBbvNXKZxyc+VzyulXYZxTkQxKieCPNzJOCWs=;
        b=qc16rQyUz2cPxEuiSur1cs6mmQPcaX2WwzWtCBPR/kAQ3EwQuup2AaFpsmqNOEK3AJPgbK
        SChqaUFVQoywuR4E1LBE5p10PXdCqidCernYOVZtPH1EPhzoF2lprnCfV9Fs14MtayIQZX
        +MnRP/9/1Mr7mHT5Rb6Hp/9JU0pyPJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677023623;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JvwipWBbvNXKZxyc+VzyulXYZxTkQxKieCPNzJOCWs=;
        b=rqnz+6slx1SuVmpW2JbsdD7dOeqDoYei/lvxmX3cK9IFGTOTOPdSGYoCQuWhzMKNSiLTch
        javdJzfMb6cIUlDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0F6913223;
        Tue, 21 Feb 2023 23:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGo2MoZZ9WMXZwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 23:53:42 +0000
Date:   Wed, 22 Feb 2023 00:47:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: next: 32-bit: ERROR: modpost: "__aeabi_uldivmod"
 [fs/btrfs/btrfs.ko] undefined!
Message-ID: <20230221234746.GT10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CA+G9fYsQZrpiLRN1=zW-VRGZ57smV5OW5ZAF4rbLPFA05F5zYg@mail.gmail.com>
 <CA+G9fYuijdvK5ikvchj5_XxfimNeTzzWv1DL05458W3C7C0TvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuijdvK5ikvchj5_XxfimNeTzzWv1DL05458W3C7C0TvQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 01:47:24PM +0530, Naresh Kamboju wrote:
> On Mon, 20 Feb 2023 at 16:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > [Please ignore this email if it is already reported]
> >
> > Following build error noticed on 32bit arm and i386 with kselftest merge
> > configs with gcc-10/12 on today's Linux next-20230220 tag.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build regression:
> >   - gcc-10-lkftconfig-kselftest
> >   - gcc-12-lkftconfig-kselftest
> >
> > Build error:
> > ERROR: modpost: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> > make[2]: Target '__modpost' not remade because of errors.
> > make[1]: *** [Makefile:1980: modpost] Error 2
> 
> Anders ran the bisect and found the first bad commit,
> 
> # first bad commit:
>   [4a8c6e8a6dc8ae4ce2adb1f807b61b6d99088293]
>   btrfs: replace btrfs_io_context::raid_map with a fixed u64 value
> 
> The reported build issues still noticed on today's Linux next-20230221.
> 
> Related threads are found in lore,
> https://lore.kernel.org/lkml/CAMuHMdVwXB4YsCFEpLoTm8pxyjMty6tAT7joNj2EME4ynY8keQ@mail.gmail.com/

The for-next from today does not contain the patches anymore, they
weren't intended for this merge window but were left there from last
week.
