Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9865AABF0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiIBJ6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiIBJ6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:58:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9543D11F8;
        Fri,  2 Sep 2022 02:58:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA4820C84;
        Fri,  2 Sep 2022 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662112682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6sYBDKezySjvz2Map3Sx5LU178FYfCDAgpLT8uuuP4=;
        b=dKtuxtdhD2FRFty2EDEzT/WyZyCW6+vA9Sw+MAmW57jrqu3baKMiFlK1fpO1PRIeqsboDt
        LTy8HJXjNznvy9e7wc/zeV2bikiMAiw19OQPoW0O0m1K6A5MOAMSKyGLgZfVcWfevoHZnS
        iEMW2uZNeWIeCSy2NFheihABfmzZ5M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662112682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6sYBDKezySjvz2Map3Sx5LU178FYfCDAgpLT8uuuP4=;
        b=RFq/kHsQYGNr3L3y1+Z+r12OAbb3bEehe/wS9F/m25+W6m6fenDVEX1a0yM/yqFvB1OPkx
        8Y20aGtfeBVBQdAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 659EF13328;
        Fri,  2 Sep 2022 09:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Go70F6rTEWMsIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 09:58:02 +0000
Date:   Fri, 2 Sep 2022 11:52:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test that we can not delete a subvolume with an
 active swap file
Message-ID: <20220902095242.GR13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zorro Lang <zlang@redhat.com>,
        fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <e34bd1b1693a135444c3618e9e16ac8a91f595a3.1662048448.git.fdmanana@suse.com>
 <20220902021137.fvmnbodmijtutloe@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902021137.fvmnbodmijtutloe@zlang-mailbox>
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

On Fri, Sep 02, 2022 at 10:11:37AM +0800, Zorro Lang wrote:
> Better to make sure we swapoff this file in _cleanup() too, to avoid it affect
> later testing if something suddently kill the testing. Others looks good to me,
> welcome more review from btrfs.

You can assume an implicit ack for any btrfs tests when it's sent by a
person with history of existing fstests and/or btrfs commits. A review
would be desirable but I'd say it would hardly find any problems,
typically the one who writes the kernel patch has a test script that is
then transformed to the test case so you can also expect a real testing.

Speaking for the btrfs developer group, we'd rather see slightly
imperfect or not formally reviewed patch in fstests suite as we'd catch
any breakage once it's pushed to git. We have daily update and test
loops and we'll notice, also we know how to revert commits or disable
tests if needed. Holding back sent patches is counterproductive. Thanks.
