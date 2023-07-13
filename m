Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92A752CBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjGMWJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGMWJv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 18:09:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9702712
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 15:09:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A03DF1F383;
        Thu, 13 Jul 2023 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689286188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mspCHaxro38TsW9awQW219hFKvhq6f939JMprbTLO+s=;
        b=UM3yAbdZy2gCjjEEDeE61Favsukm4vm2qlZKTOKQT6tcAhSdQ4p52qsiEWb0XMBfWQw6hn
        +V36bYZG3CtmiQ1Bn+fTLiaNIkJkTlIebND//gH7wmZYOfo98pWpWip1VBd3p9fGpIg7Iw
        tqa9DlGSsuJEfcCumWRsXKJMUTI5wHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689286188;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mspCHaxro38TsW9awQW219hFKvhq6f939JMprbTLO+s=;
        b=VqZ2wN9bH0gLpsfTFhqnSW+33PSnZdc1T99LMjCc7/heK/Sc88THl2fJFdMb1NAUH479fH
        P+wHUX0nLDpM72Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72B56133D6;
        Thu, 13 Jul 2023 22:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kMIZGyx2sGT9VQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 22:09:48 +0000
Date:   Fri, 14 Jul 2023 00:03:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230713220311.GC20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz>
 <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
> On 2023/7/14 00:39, David Sterba wrote:
> > 		ref#0: tree block backref root 7
> > 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
> > 		extent refs 1 gen 5 flags 2
> > 		ref#0: tree block backref root 7
> > 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
> > 		extent refs 1 gen 5 flags 2
> > 		ref#0: tree block backref root 7
> 
> This looks like an error in memmove_extent_buffer() which I
> intentionally didn't touch.
> 
> Anyway I'll try rebase and more tests.
> 
> Can you put your modified commits in an external branch so I can inherit
> all your modifications?

First I saw the crashes with the modified patches but the report is from
what you sent to the mailinglist so I can eliminate error on my side.
