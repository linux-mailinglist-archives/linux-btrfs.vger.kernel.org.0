Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296453E9CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiFFLYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiFFLYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 07:24:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530495A21
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 04:24:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E09221A4E;
        Mon,  6 Jun 2022 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654514649;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+qPlrVIxO0CpRa7Ct2UCBxj7LlmAzrf3UpPsju4+Vo=;
        b=UpquHHDJHle94tKuafNAA/02tPfkVCne2rSgHfn4ofqcuNChNVwrOkGwfhqJKzrJWrmRDH
        cNt9LY9c4IVOREXBMPrj0JGz/L+m8lk3MkDvdQq0TogK7x7DYC+mXsKUr0+2EKxqzyZMz/
        29552auhPdJmfSfrZdvOouO0bfXGOz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654514649;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+qPlrVIxO0CpRa7Ct2UCBxj7LlmAzrf3UpPsju4+Vo=;
        b=cs28cIy+iLYdk977VpvaDqNrWIFMH78lmZ62af+qElnsKc4ucorK/FBNehJAgCeqSIcYuw
        nx06HvKIg/QA+/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D879813A5F;
        Mon,  6 Jun 2022 11:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwrVM9jjnWJjKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Jun 2022 11:24:08 +0000
Date:   Mon, 6 Jun 2022 13:19:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lucas =?iso-8859-1?Q?R=FCckert?= <lucas.rueckert@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [HELP] open_ctree failed when mounting RAID1
Message-ID: <20220606111940.GB20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Lucas =?iso-8859-1?Q?R=FCckert?= <lucas.rueckert@gmx.de>,
        linux-btrfs@vger.kernel.org
References: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
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

On Tue, May 31, 2022 at 09:50:52PM +0200, Lucas Rückert wrote:
> Hi,
> 
> i run two HHD's(sda;sdb) in RAID1.
> 
> Kernel: 4.9
> 
> Distro: Linux odroid 4.9.277-83 #1 SMP PREEMPT Mon Feb 28 15:16:26 UTC
> 2022 aarch64 aarch64 aarch64 GNU/Linux
> 
> btrfs-progs: 5.4.1
> 
> I created the filesystem with:
> 
> mkfs.btrfs -d raid1 -m raid1 -L somelable -f /dev/sda /dev/sdb
> 
> 
> And added it to my fstab:
> 
> UUID=<uuid>        /mnt/somefolder     btrfs compress=zstd   0       2
> 
> 
> When running:
> 
> mount -a
> 
> i get an error:
> 
> mount: /mnt/backup: wrong fs type, bad option, bad superblock on
> /dev/sda, missing codepage or helper program, or other error.
> 
> 
> and dmesg reports:
> 
> BTRFS error (device sdb): open_ctree failed

I got pointed to this report. First I suspected that there are some
lines missing from the dmesg log, like what was the error but it turns
out that almost all invalid option values lack any message, which makes
the error analysis hard. Thanks for your report, I've sent a patch that
adds the missing messages, there's a lot of them.
