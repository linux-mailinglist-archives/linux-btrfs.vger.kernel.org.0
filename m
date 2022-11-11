Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18025625E9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 16:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiKKPri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 10:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiKKPrh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 10:47:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD772EF28
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 07:47:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB7762240F;
        Fri, 11 Nov 2022 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668181655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20a59pL5O9QZBbCGEGR4Liun1xLh7EHACIYiHKvaWIg=;
        b=OnYgouhK6paKRtKcX2F2cNgqdneaOsp61HNTP58ATZtPlcBnK+4irjyQnLfLZXiO/puEIx
        qaB+FZ4K39cwcbZ1M5xZceU82UrVvQyxdMNHLYe/Zs6O6uiVVrcqekKeHXVu4q3BRtpnVA
        mx6uK26qqxW1mvfesDiUydYj7z12UNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668181655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20a59pL5O9QZBbCGEGR4Liun1xLh7EHACIYiHKvaWIg=;
        b=F6mQQ6n3Ck2MC1ET3VpqUofOyPioeK2e8uhR0A2idkGAm/j/S2nt3WiRPwfn1hjy8rwQV7
        HOHgfk5gL/hGiQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F08513273;
        Fri, 11 Nov 2022 15:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iA3ZJZdubmOPPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 15:47:35 +0000
Date:   Fri, 11 Nov 2022 16:47:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Lionel Bouton <lionel-subscription@bouton.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs-progs] btrfs filesystem defragment now outputs processed
 filenames ?
Message-ID: <20221111154711.GR5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 01:32:03PM +0200, Lionel Bouton wrote:
> Hi,
> 
> I just noticed a change in behavior for btrfs-progs (at least in 6.0-1 
> on Arch Linux). It now outputs the filenames it defragments and I can't 
> find a command line option to disable it.
> 
> I'm using a defragment scheduler which triggers file defragmentation 
> file by file and even recently by offset and size in a file (to limit 
> the IO load spikes that can happen when defragmenting large files on HDD 
> and T/QLC SSD/NVME with small SLC buffers).
> Currently the scheduler forwards the btrfs command's output to its own 
> and it pollutes the logs with superfluous information (when 
> defragmenting in 128MB chunks I get tens of log lines for multiple GB 
> files).
> 
> This isn't a big problem and it is easily fixable in my scheduler but I 
> was wondering if there is any plan to allow silencing it or should I 
> just cleanup the ouput before forwarding it (I prefer to write any 
> unexpected output in logs instead of ignoring everything) ?

Printing file names was unintentional, tracked as
https://github.com/kdave/btrfs-progs/issues/540 and will be fixed in
6.0.2.
