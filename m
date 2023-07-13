Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B1752AB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 21:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGMTEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGMTEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 15:04:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B3E1993
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 12:04:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08E751FD5F;
        Thu, 13 Jul 2023 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689275043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCse67T55A0iM6SzKSS1DLX+0Nlz0ki6r4D86tRFl5k=;
        b=zmG13rwg1zTWy1L4ywFXIhDYDUoEHSdOc+VSpIeN1hZxwfsagr6ath6XzLZtU4hXDKNB9R
        lskPnN0ErckhXvDMMF6g/ruj3Lotj9zmCe6fZ0nnzstLv94B60HgCzrkH/XFpA/ke2QKm3
        QbNyxIffTamwp2CWIft+869ozKxEK2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689275043;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCse67T55A0iM6SzKSS1DLX+0Nlz0ki6r4D86tRFl5k=;
        b=/Ty02J62vgKiwwZSvIw7fMu6WkYwyT2tJze57AaTQuxCnVU5GZTAtvCQE5DPWn08gcvtE7
        lUzu1V0eOSGQn6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4FCF133D6;
        Thu, 13 Jul 2023 19:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DV38NqJKsGT7CQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 19:04:02 +0000
Date:   Thu, 13 Jul 2023 20:57:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs-progs: tune: fix incomplete fsid_change
Message-ID: <20230713185726.GE30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688724045.git.anand.jain@oracle.com>
 <24bef15af8c65da69ab8a3b574e0da7b71295008.1688724045.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bef15af8c65da69ab8a3b574e0da7b71295008.1688724045.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 07, 2023 at 11:52:41PM +0800, Anand Jain wrote:
> An incomplete fsid state occurs when devices have two or more fsids
> associated with the same metadata_uuid. As it can be confusing to
> determine which devices should be assembled together, the fix only
> works when both the --noscan and --device options are used. This means
> the user will have to manually select and assemble the devices with the
> same metadata_uuids.

This is not a good usability. If the user can determine which devices
should be in the --noscan and --device options why can't we do that
programaticaly? If the found devices can be reliably identified as part
of the filesystem (and there are e.g. no ambiguities due to duplicated
devices) then the command should work it out by itself.

The btrfstune commands are supposed to be restartable, namely the uuid
conversions, basically with the same command that was used to begin the
conversion. If there's a problem that needs user interactions then there
should be specific instructions what to check and how to resolve it
manually.
