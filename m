Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CB7D4EC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjJXLW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJXLWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 07:22:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFFF128
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 04:22:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A348021845;
        Tue, 24 Oct 2023 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698146538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7NHrO7kRS6xoWeuaSjQIHE7x8bo53stqDd+lXr/zRU=;
        b=HWclyL4mG/Fh4WykhaGvxIxR5lqO82lWaDtki2lWkRxW4CGtVA5gnx28LUgPaqScgmRLvn
        4CVEWgdlsaWSRVq9yUuVVCjpUgKNuXGmT/NPEO/5gE0apM5H8u8Ya3IWybLdUPXeWiwunX
        PMAIM/3TbClKthvYz4sL5k9yvevR6Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698146538;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7NHrO7kRS6xoWeuaSjQIHE7x8bo53stqDd+lXr/zRU=;
        b=8Ue3CdPkQSHfkJmmlh4B53YhFhMDnQbN/6es94AIa6uCEMKRYtGP2dDFvupsDFHDlDigvo
        647tLoDKR6zP9xAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71C361391C;
        Tue, 24 Oct 2023 11:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fvvcGuqoN2XHQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 11:22:18 +0000
Date:   Tue, 24 Oct 2023 13:15:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 3/3] btrfs-progs: fsck-tests: add test image of
 out-of-order inline backref items
Message-ID: <20231024111524.GO26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697945679.git.wqu@suse.com>
 <e260e8432e3ae5e09d012dce6bd6f96ff0569649.1697945679.git.wqu@suse.com>
 <39c425f8-c403-4b92-9799-6bd957e0b796@oracle.com>
 <f2b92692-8d25-4448-9b7b-568665ee15b0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2b92692-8d25-4448-9b7b-568665ee15b0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.07
X-Spamd-Result: default: False [-5.07 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmx.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmx.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.27)[89.79%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 04:17:14PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/24 15:58, Anand Jain wrote:
> > 
> > 
> > 
> >>   .../btrfs_image.xz                            | Bin 0 -> 2264 bytes
> > 
> > check_all_images() won't find  btrfs_image.xz image.
> 
> My bad, the filename should be default.img.xz.
> 
> David, mind to change that?

Renamed and pushed.

> > 
> > 
> >          for image in $(find "$dir" \( -iname '*.img' -o \
> >                                  -iname '*.img.xz' -o    \
> >                                  -iname '*.raw' -o       \
> >                                  -iname '*.raw.xz' \) | sort)
> > 
> > 
> > 
> > 
> > 
> > What's your plan to test lomem mode?
> 
> The usual way, you can check tests/common.local to see how lowmem mode 
> should be utilized.

There are more ways how to run the lowmem mode tests, e.g.
'make test-check-lowmem' that sets up the variables s needed.
