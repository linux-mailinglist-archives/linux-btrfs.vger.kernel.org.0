Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D480A67B84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjAYRVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjAYRVF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 12:21:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6090B469;
        Wed, 25 Jan 2023 09:21:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 631632195F;
        Wed, 25 Jan 2023 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674667260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORhrWX64A1XsPKQEs851EVH1VyRA9mPujVOpjZdjl5k=;
        b=n1rFvIkFY217YMH/xJb0DiZsNHjhVgjYbYF/+z7rRuNWJfg/cTSccpYcRvQgaXJALytNsL
        7IDorPedft8db/nUc5XxHwzCTwVYUQynqImWRXQLAvNzQycrbGQAS8VkEqzqkvO9m5Sxs/
        K4PWFxOEkh8vcoE/Y76rL5rFhaTxBcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674667260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORhrWX64A1XsPKQEs851EVH1VyRA9mPujVOpjZdjl5k=;
        b=WZxJOOfpgHUJwBaff7JlafNm0Gt20IdqvsH9/sTIDYstSELR2OqS8p6baHCgFChTppYyu9
        fSGOOVAiAW3U+uAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F2A41358F;
        Wed, 25 Jan 2023 17:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 38iMCvxk0WNRKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 Jan 2023 17:21:00 +0000
Date:   Wed, 25 Jan 2023 18:15:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20230125171517.GV11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsN1rzCoYiB-vN5grzsMdvgm1qv2jnWn0enXq5R-wke8Eg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 01:27:48AM +0500, Mikhail Gavrilov wrote:
> On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
> > > Hi guys.
> > > Always with intensive writing on a btrfs volume, the message "BUG:
> > > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
> >
> > Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
> > tends to work.
> 
> Hi,
> Today I was able to get the message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too
> low!" again even with LOCKDEP_CHAINS_BITS=18 and kernel 6.2-rc5.
> 
> ❯ cat /boot/config-`uname -r` | grep LOCKDEP_CHAINS_BITS
> CONFIG_LOCKDEP_CHAINS_BITS=18
> 
> [88685.088099] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> [88685.088124] turning off the locking correctness validator.
> [88685.088133] Please attach the output of /proc/lock_stat to the bug report
> [88685.088142] CPU: 14 PID: 1749746 Comm: mv Tainted: G        W    L
>   -------  ---  6.2.0-0.rc5.20230123git2475bf0250de.38.fc38.x86_64 #1
> [88685.088154] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 4408 10/28/2022
> 
> What's next? Increase this value to 19?

Yes, though increasing the value is a workaround so you may see the
warning again.
