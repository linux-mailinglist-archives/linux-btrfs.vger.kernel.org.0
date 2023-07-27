Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6011E765B66
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjG0Sd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjG0Sdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 14:33:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E42719
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 11:33:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C49051F890;
        Thu, 27 Jul 2023 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690482830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOkN+EOyWg8o4NzDgfHddFdffbUYeB+LQRuQ2GTF89k=;
        b=UfV+1p0qVQvPPLZAcpkAEJ1q9L0yHcgmfdvp3sMU3n8/dVRvTx9XuWJM7ODRJYwE4OJyH+
        pfQzg3eNbckwhY4llzb71mwycGvOqTtWKg26ZujvYOgzy85gxcnltHNYr1BzajE2P1rPPU
        G3xYVDumeb39S+TgPP1ELoHv+5sALEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690482830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOkN+EOyWg8o4NzDgfHddFdffbUYeB+LQRuQ2GTF89k=;
        b=gPlA2Wfn/8lHx7Wiq0mm68XHcCZRN3j6Ssg46+kVLXNB4rj72FCQPlm5mipX7u/3/8kRka
        3HyKmZYJQCW+ffBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A641D138E5;
        Thu, 27 Jul 2023 18:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fY7HJ464wmRYBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 18:33:50 +0000
Date:   Thu, 27 Jul 2023 20:27:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/8] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230727182728.GI17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689418958.git.wqu@suse.com>
 <20230720150621.GA20457@twin.jikos.cz>
 <af4ef0a6-4305-e32e-a903-fa91f2f4c706@gmx.com>
 <03e5a8b7-99de-811d-9723-41012d07172a@gmx.com>
 <20230721151346.GB20457@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721151346.GB20457@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 05:13:47PM +0200, David Sterba wrote:
> On Fri, Jul 21, 2023 at 06:55:49AM +0800, Qu Wenruo wrote:
> > On 2023/7/21 06:15, Qu Wenruo wrote:
> > > On 2023/7/20 23:06, David Sterba wrote:
> > >> On Sat, Jul 15, 2023 at 07:08:26PM +0800, Qu Wenruo wrote:
> > >> [12399.180441]
> > >> ==================================================================
> > >> [12399.183100] BUG: KASAN: slab-use-after-free in
> > >> btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
> > >> [12399.186056] Read of size 8 at addr ffff888029c96c80 by task
> > >> kworker/u8:4/21890
> > >> [12399.188440]
> > >> [12399.188965] CPU: 1 PID: 21890 Comm: kworker/u8:4 Not tainted
> > >> 6.5.0-rc2-default+ #2130
> > >> [12399.191616] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > >> BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
> > >> [12399.193366] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
> > >> [12399.194534] Call Trace:
> > >> [12399.195039]  <TASK>
> > >> [12399.195484]  dump_stack_lvl+0x46/0x70
> > >> [12399.196182]  print_address_description.constprop.0+0x30/0x420
> > >> [12399.197136]  ? preempt_count_sub+0x18/0xc0
> > >> [12399.197858]  print_report+0xb0/0x260
> > >> [12399.198497]  ? __virt_addr_valid+0xbb/0xf0
> > >> [12399.199204]  ? kasan_addr_to_slab+0x94/0xc0
> > >> [12399.199936]  kasan_report+0xbe/0xf0
> > >> [12399.200562]  ? btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
> > >> [12399.201618]  ? btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
> > >> [12399.202667]  btrfs_check_read_bio+0x19c/0x8d0 [btrfs]
> > >
> > > This is werid, as btrfs_check_read_bio() can only happen for data bios.
> > >
> > > Let me double check what's going wrong.
> > 
> > What about the reproducibility? I failed to reproduce here, and I
> > checked the git log, it doesn't has any obvious changes to RAID56 code
> > either (all are already in my code base).
> 
> This was first run, I'll do another one.

With reworked misc-next this patchset does not reproduce the errors so
I'll add it back.
