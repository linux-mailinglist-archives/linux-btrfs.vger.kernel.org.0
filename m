Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E652AB98
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352544AbiEQTIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352553AbiEQTIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 15:08:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312232C671
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:08:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA0621F916;
        Tue, 17 May 2022 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652814496;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8W+L6ZlVrzgYLUUvcnnjMvMXZRmB14UR9ACXagKClc=;
        b=uC9ISIhs2HD2QstzOySiZj33mlKZAFyau0vUpZ5WSDOLrk4vjdywezZ3HZKCXxQiLnDMie
        LrqnHNnPfYRogEtKYDO7akbShd1MVprgDXsQOxL0OODMxew1fYaP5eSbOTgZaG7rMmuiQX
        wAAyDX7Lheb7mJC+cS5VFlj6oVcufnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652814496;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8W+L6ZlVrzgYLUUvcnnjMvMXZRmB14UR9ACXagKClc=;
        b=JTeFDa4oknqlVA2Qm0OhIgKwocpllZHDoSDgeQNJITX6wHMsZ/X1s9I86KZwLxsI043POQ
        YGgiYPl0BXksh/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D80A13305;
        Tue, 17 May 2022 19:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a3SIJaDyg2KLUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 19:08:16 +0000
Date:   Tue, 17 May 2022 21:03:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs-progs: check/lowmem: fix path leakage when dev
 extents are invalid
Message-ID: <20220517190358.GF18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1652611957.git.wqu@suse.com>
 <4c3548e63a9e42482cbc2c277b15cf3eeae700bd.1652611958.git.wqu@suse.com>
 <53afe0f3-6465-21cf-b7d6-babbadf48860@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53afe0f3-6465-21cf-b7d6-babbadf48860@suse.com>
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

On Sun, May 15, 2022 at 09:15:24PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.05.22 г. 13:55 ч., Qu Wenruo wrote:
> > [BUG]
> > When testing my new RAID56J code, there is a bug causing dev extents
> > overlapping.
> > 
> > Although both modes can detect the problem, lowmem has leaked some
> > extent buffers:
> > 
> >    $ btrfs check --mode=lowmem /dev/test/scratch1
> >    Opening filesystem to check...
> >    Checking filesystem on /dev/test/scratch1
> >    UUID: 65775ce9-bb9d-4f61-a210-beea52eef090
> >    [1/7] checking root items
> >    [2/7] checking extents
> >    ERROR: dev extent devid 1 offset 1095761920 len 1073741824 overlap with previous dev extent end 1096810496
> >    ERROR: dev extent devid 2 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
> >    ERROR: dev extent devid 3 offset 1351614464 len 1073741824 overlap with previous dev extent end 1352663040
> >    ERROR: errors found in extent allocation tree or chunk allocation
> >    [3/7] checking free space tree
> >    [4/7] checking fs roots
> >    [5/7] checking only csums items (without verifying data)
> >    [6/7] checking root refs done with fs roots in lowmem mode, skipping
> >    [7/7] checking quota groups skipped (not enabled on this FS)
> >    found 3221372928 bytes used, error(s) found
> >    total csum bytes: 0
> >    total tree bytes: 147456
> >    total fs tree bytes: 32768
> >    total extent tree bytes: 16384
> >    btree space waste bytes: 136231
> >    file data blocks allocated: 3221225472
> >     referenced 3221225472
> >    extent buffer leak: start 30752768 len 16384
> >    extent buffer leak: start 30752768 len 16384
> >    extent buffer leak: start 30752768 len 16384
> > 
> > [CAUSE]
> > In the function check_dev_item(), we iterate through all the dev
> > extents, but when we found overlapping extents, we exit without
> > releasing the path, causing extent buffer leakage.
> > 
> > [FIX]
> > Just release the path before we exit the function.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> This can go completely independently from the raid56j code.

Right, thanks, patch added to devel.
