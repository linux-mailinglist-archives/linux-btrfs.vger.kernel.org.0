Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCD588CF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiHCN3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiHCN3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 09:29:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3C1572F
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 06:29:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C59421FEEF;
        Wed,  3 Aug 2022 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659533383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoxD2QVsHvL7id4r8JELYx6xiBa/838oD3GI7MeWYlU=;
        b=ESbrQLcqVmRQAar4rwJu7wO0AnthyVSwg2Fmq5CEnasgVFS6a7dL//4mLaQHxu/zJcVmhF
        znS19rDvg1v0In3lEMlfXtIfDVIb9JlrQoB85ymtfPQVBjZkli0YDCrEyhGWrgkYcSCY++
        q/G7p63hBKxrWwCLK3mO7elJleQizPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659533383;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoxD2QVsHvL7id4r8JELYx6xiBa/838oD3GI7MeWYlU=;
        b=fvOeP3CqndLbTCk1FljygzVrdZDzi48XEel8r0ZWfgeUfix5CK/eme4Add6swjJGsediik
        dzKkQCKkNLp9cdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A24E813A94;
        Wed,  3 Aug 2022 13:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5d9IJkd46mLUfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 13:29:43 +0000
Date:   Wed, 3 Aug 2022 15:24:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection
 after mount
Message-ID: <20220803132441.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
 <e9c54ed3-7dc9-e185-491c-aca6b0afe244@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c54ed3-7dc9-e185-491c-aca6b0afe244@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 03, 2022 at 08:22:05AM +0800, Anand Jain wrote:
> On 02/08/2022 20:28, David Sterba wrote:
> > The sysfs file /sys/fs/btrfs/FSID/checksum shows the filesystem checksum
> > and the crypto module implementing it.
> 
> 
> > In the scenario when there's only
> > the default generic implementation available during mount it's selected,
> > even if there's an unloaded module with accelerated version.
> 
> > This happens with sha256 that's often built-in so the crypto API may not
> > trigger loading the modules and select the fastest implementation.
> 
> Hmm ok.
> What happens in the scenario if the accelerated module is loaded? Will 
> the crypto API use the accelerated module?

Yes, each implementation of the hash has a priority and the loading
mechanism goes through all registered implementations and picks the one
with highest priority. Generic is 100, sha256-ni is 250, there are 3
more implementations based on CPU flags, you can see it in
arch/x86_64/crypto/sha256_ssse3_glue.c .

There are some tricks for crc32c that trigger loading the accelerated
module even if there's the generic available, and since sha256 has
become mandatory for some security features (signing) the generic one is
always available. Similar mechanism as for crc32c is not done.
