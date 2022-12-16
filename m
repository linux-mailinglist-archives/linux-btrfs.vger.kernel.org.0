Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355D64F416
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLPW1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 17:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPW0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 17:26:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDD54A582
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 14:26:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 067915F844;
        Fri, 16 Dec 2022 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671229608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqOm0aIcPmZeelNC/HB3Um1RKh8Z/aQMzDBtBVVyamU=;
        b=sIA7r1721ttOM9Do+za2DNdknqxi3T3MtYA74bEqDiLJSG1sY44pirxh0eeJVL6m8BQ39T
        YE4fB9Zq1OZiCe/Fu9Igi6znPwe+ZtRsZNmkm1xP68yoFgbpjwffRa10bX6vqvOzLGxmPW
        4dXouyz0ZDvEUkfiFzR6fQpeih8JkFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671229608;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqOm0aIcPmZeelNC/HB3Um1RKh8Z/aQMzDBtBVVyamU=;
        b=RSTAuXXE5T1BTgEVmY7wWGz4qcF37X+McTwKO51Mv2LvMQIpa5MZtMwe8/BBDu0/g7yitb
        pkMSPVyDTnscTyAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7A07138F0;
        Fri, 16 Dec 2022 22:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3dOqM6fwnGO2MwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 16 Dec 2022 22:26:47 +0000
Date:   Fri, 16 Dec 2022 23:26:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Use pread/pwrite/ftruncate/stat instead of 64bit
 equivalents
Message-ID: <20221216222604.GK10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221215084046.122836-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215084046.122836-1-raj.khem@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 15, 2022 at 12:40:45AM -0800, Khem Raj wrote:
> 64bit functions are aliases to original functions when largefile feature
> is enabled via autoconf or right macro is passed on compiler cmdline

I noticed that there's also lseek64, should this be also converted?
