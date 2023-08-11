Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591167796C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjHKSIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 14:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbjHKSIL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 14:08:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0623584
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 11:08:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB1771F8AF;
        Fri, 11 Aug 2023 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691777283;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ffsxo88rm8Po21alnOCcNmYgGSLNkrqyHSU0k1DEbCA=;
        b=fK59y5/xSUb+NtAYX6RPu+nhDVpDJgjqTkunDpfZ/WK/GPXK0Suhft2mmPD+Zb+jF9PU7V
        fQ11SXHN5VwG1DFdaARcbcs1tRf04+HD+ARoQGlWc8blNFF6N65TAc/nYLo4eSLVmYSn0M
        8O5AZqZ1OTC6mSuRAcb9nFVenjTBHZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691777283;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ffsxo88rm8Po21alnOCcNmYgGSLNkrqyHSU0k1DEbCA=;
        b=2G3oxcDNHg/oCFJ11PGwMP+owRXN4eRkjpVBcoyimutQp8WAd3knStVlWIIYyOwK5Jw0f9
        wkV1yh8FGU9PjUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0B2D13592;
        Fri, 11 Aug 2023 18:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hcZNKgN51mSDbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 18:08:03 +0000
Date:   Fri, 11 Aug 2023 20:01:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: register device after successfully changing
 the fsid
Message-ID: <20230811180138.GB2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4b7b4c651700247046a32fce3148e510877ccdc6.1690448585.git.anand.jain@oracle.com>
 <e41a8748-bcf0-f0dd-0f06-d8ee9c261cd1@oracle.com>
 <960295cf-0f4f-8337-f2b2-7167cf78bcba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960295cf-0f4f-8337-f2b2-7167cf78bcba@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 28, 2023 at 05:15:32PM +0800, Anand Jain wrote:
> 
>    My SOB is missing in the devel branch. Should I resend?

No need to resend unless you have something more to update in the patch,
otherwise for such fixups to changelog or code it's sufficient to reply
to mails, I'll get to it eventually.
