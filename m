Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F412797FD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjIHAky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIHAkx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219701BD6
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:40:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0B061F385;
        Fri,  8 Sep 2023 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694133647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0DvUjrOoIdzkTsyoqC+FIKiFfyYUYY1o5mapETlLF4=;
        b=Gta0kn47YtNUbZE2t+gc2I19KmSxf1CPRZO55OLotIyIpONeZ+iO7AJFE7nAJ8llkAHn1R
        j8B41sSJpDgAVfILZfexp7gdjiD4aXnNjJtKtftHZSOquf7taIoaRxc2q0gwP5nfD9Cvbh
        F89Gslb+FM5u+DRNAFKMKavTQHZ+ZZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694133647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0DvUjrOoIdzkTsyoqC+FIKiFfyYUYY1o5mapETlLF4=;
        b=YD9gch182+vFOXrcT975UmyJaLNfjmjKuw7Dhk3qu561Ou3EH1vHCFA2Q7qPtt/HGXNwuH
        HiJcJJio+HK81zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90E4E13588;
        Fri,  8 Sep 2023 00:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N9aNIo9t+mSgawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 00:40:47 +0000
Date:   Fri, 8 Sep 2023 02:34:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: drop __must_check annotations
Message-ID: <20230908003415.GT3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694126893.git.dsterba@suse.com>
 <565b63e6e34c122ca9bbe1e0272f43d6327a6316.1694126893.git.dsterba@suse.com>
 <ef9b407d-b9ac-487d-8194-6a26e4cafb21@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef9b407d-b9ac-487d-8194-6a26e4cafb21@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 07:56:24AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/8 07:09, David Sterba wrote:
> > Drop all __must_check annotations because they're used in random
> > functions and not consistently. All errors should be handled.
> 
> Is there any compiler warning option to warn about unchecked return value?

By default this is checked for functions annotated by warn_unused_result
attribute, which is exactly what __must_check does. The check can be
disabled but that's not what we want.

> In fact recently when working on qgroup GFP_ATOMIC, I found a call site
> that we didn't handle error at all (qgroup_update_counters()).

A quick way how to check if a given function is properly handled is to
add the __must_check attribute and run build. For qgroup_update_counters
this is found right away:

  CC [M]  fs/btrfs/qgroup.o
fs/btrfs/qgroup.c: In function ‘btrfs_qgroup_account_extent’:
fs/btrfs/qgroup.c:2736:9: warning: ignoring return value of ‘qgroup_update_counters’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
 2736 |         qgroup_update_counters(fs_info, qgroups, nr_old_roots, nr_new_roots,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2737 |                                num_bytes, seq);
      |                                ~~~~~~~~~~~~~~~

> I'm pretty sure that is not the last one.

Yeah but we'd have to add the attribute to most if not all functions. It
could be possibly automated using coccinnelle scripts, list functions,
apply a semantic patch to add the attribute, compile it and get the
results. A quick test shows it's doable.

I think in general the error handling is good but if we want to make
sure we haven't missed anything important we can't do it manually
efficiently.
