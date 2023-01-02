Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CA465B465
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjABPrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjABPrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 10:47:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65B6591
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 07:47:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 737D95C1D1;
        Mon,  2 Jan 2023 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672674460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZjZzaVG1Ni24L5EIZfrmAWslN3Os48BAbsppBNpUS8=;
        b=AO5teSRNJZ2ZuFN1+/92M2/+wYTUj4wybUXMmceyB2E+atL33KdhZKxoG4hdMjS4WngvJt
        diJ5Cs9epyqkauQrMSQfxuXw3uaEXDJacaJVFhS3oVCdAmPjEoKcry3TUM3SgQfJklHEQj
        SUh+9av/LrZcgKuqfo/NgZ7mbtA0hJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672674460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZjZzaVG1Ni24L5EIZfrmAWslN3Os48BAbsppBNpUS8=;
        b=8dFsgkj8Sd3coLJj8hjFjhCxnnN8+5pi1vENkPgBk2TB5FJhy8NKdtHowJn1b+jFFiwW1L
        tNNBfHKv3mJvTdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A6B013427;
        Mon,  2 Jan 2023 15:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ktEEZz8smMWcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 15:47:40 +0000
Date:   Mon, 2 Jan 2023 16:42:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs@vger.kernel.org
Subject: Re: Repression on lseek (holes) on 1-byte files since Linux 6.1-rc1
 #forregzbot
Message-ID: <20230102154210.GK11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221223020509.457113-1-joanbrugueram@gmail.com>
 <e46e349f-1eb8-7cc8-f369-8616e6467950@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e46e349f-1eb8-7cc8-f369-8616e6467950@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 23, 2022 at 01:19:59PM +0100, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 23.12.22 03:05, Joan Bruguera wrote:
> > From: Joan Bruguera Micó <joanbrugueram@gmail.com>
> > 
> > Hello,
> > 
> > I believe I have found a regression related to seeking file data and holes on
> > 1-byte files since Linux 6.1-rc1:
> > 
> > Since Linux 6.1-rc1 I observe that, if I create a (non-sparse) 1-byte file and
> > immediately run `lseek(SEEK_DATA, 0)` or `lseek(SEEK_HOLE, 0)` on it, it will
> > act as if it was a sparse file, i.e. as if it had a hole from offset 0 to 1.
> > [...]
> > I've bisected the change in behaviour to commit
> > b6e833567ea12bc47d91e4b6497d49ba60d4f95f
> > "btrfs: make hole and data seeking a lot more efficient".
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced b6e833567ea12bc47d91e4b6497d49ba60d4f95f
> #regzbot title btrfs: seeking file data and holes on 1-byte files since
> Linux 6.1-rc1 acts differently
> #regzbot ignore-activity

#regzbot fix: 'btrfs: fix off-by-one in delalloc search during lseek'
