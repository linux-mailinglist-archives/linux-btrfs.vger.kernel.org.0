Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE027B34C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 16:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjI2OUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjI2OUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 10:20:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF01AE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 07:20:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6420C1F6E6;
        Fri, 29 Sep 2023 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695997232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFXGWCKPc9cE9Atv8wNS4qKR7UncYJmVn0iLQPNN56I=;
        b=Co0PZUh8dRdQC97mzUhbzxUFa67L3LOjtOKTJxL5ADzD49V3/aKEvlR0vRbVc/H+1gvPnD
        yb+mJV5eyhcGM3cx8xG0SahaebG2JgDqBD2FZrdAYjEEE+Sl7WH45UXgDb0KIkoGXoYQFs
        7kPx7r+TJ/GrmMjQKCWn95kPEolY7kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695997232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFXGWCKPc9cE9Atv8wNS4qKR7UncYJmVn0iLQPNN56I=;
        b=rxjD1UY9diJCmqpWhOeP/oehdRfnjoXUeR76s4pNIfO30gekayck0y+2Z7E5z7nY1YHhH7
        OH00gOV1bQvTEoAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4701390A;
        Fri, 29 Sep 2023 14:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1DmaBTDdFmUsGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Sep 2023 14:20:32 +0000
Date:   Fri, 29 Sep 2023 16:13:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: reject unknown mount options early
Message-ID: <20230929141352.GD13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
 <8b92ecee-e018-6570-880c-878919260e31@oracle.com>
 <8a89dbf2-c9dc-481a-8fdd-4aa26f86d59d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a89dbf2-c9dc-481a-8fdd-4aa26f86d59d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 08:42:20AM +0930, Qu Wenruo wrote:
> On 2023/9/28 08:26, Anand Jain wrote:
> > On 27/09/2023 09:13, Qu Wenruo wrote:
> >> [BUG]
> >> The following script would allow invalid mount options to be specified
> >> (although such invalid options would just be ignored):
> >>
> >>   # mkfs.btrfs -f $dev
> >>   # mount $dev $mnt1        <<< Successful mount expected
> >>   # mount $dev $mnt2 -o junk    <<< Failed mount expected
> >>   # echo $?
> >>   0
> >>
> >> [CAUSE]
> >> For the 2nd mount, since the fs is already mounted, we won't go through
> >> open_ctree() thus no btrfs_parse_options(), but only through
> >> btrfs_parse_subvol_options().
> >>
> >> However we do not treat unrecognized options from valid but irrelevant
> >> options, thus those invalid options would just be ignored by
> >> btrfs_parse_subvol_options().
> >>
> >> [FIX]
> >> Add the handling for Opt_error to handle invalid options and error out,
> >> while still ignore other valid options inside
> >> btrfs_parse_subvol_options().
> >
> > As discussed, the purpose of my report was to determine whether we still
> > need to return success when the 'junk' option is passed in the second
> > mount. I don't recall precisely if this is intentional, perhaps to
> > allow future features to remain compatible with the KAPI when
> > backported to an older kernel version, or if it may not be relevant in
> > this kernel version.
> 
> This is not intentional, purely a bug.

Yeah it's a bug, we need to split the mount option parsting due to
device and subvoulme to preprocess some things but any invalid option at
the first phase is also invalid in the second one so there's no reason
to skip checking.
