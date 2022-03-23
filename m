Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59BF4E5C11
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 00:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiCWXyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 19:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiCWXyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 19:54:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8F3FD86
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:52:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EC5D210F0;
        Wed, 23 Mar 2022 23:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648079560;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFDz/riKKCq4gqHDX89jnsqkZxbVFlvtiNDXVVNO0Dg=;
        b=DD2hjx62JAPDQMpEsBA0GfR1IkhtL/R+w3TBsw6zc2w2jJdHDLwxNdxtGtvo8frVsgszrI
        xBf8YZRktGPFuqvsCynodPhgE0WtqtjzQpDlpTlncLLnJkJq4oON4qk4O2LN3+bxcCHQF8
        PN04N25PGLxAJLNXYaNfeoyfPJGB4fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648079560;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFDz/riKKCq4gqHDX89jnsqkZxbVFlvtiNDXVVNO0Dg=;
        b=cmaxulD5AbjV0koezoMWKmEgD1WG5e7wtb8Nymv+yUrCS5M3V7vqv9Q+q6ufLN95njvfFk
        qpVjmhweVgJvopCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 03B63A3B83;
        Wed, 23 Mar 2022 23:52:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 90183DA7DE; Thu, 24 Mar 2022 00:48:45 +0100 (CET)
Date:   Thu, 24 Mar 2022 00:48:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix return value override in
 do_check_chunks_and_extents()
Message-ID: <20220323234845.GH2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f576d7a548b91d42d02b17d2dc52ee04d943a57d.1648077794.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f576d7a548b91d42d02b17d2dc52ee04d943a57d.1648077794.git.wqu@suse.com>
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

On Thu, Mar 24, 2022 at 07:23:21AM +0800, Qu Wenruo wrote:
> Patch "btrfs-progs: check: add check and repair ability for super num
> devs mismatch" is causing fsck/014 to fail.
> 
> The cause is that in do_check_chunks_and_extents() we can override the
> return value.
> 
> Fix it by simply exit early if we found any problems in chunk/extent
> tree.
> As super num devices is really a minor problem compared to any
> chunk/extent tree corruption.
> 
> Please fold this one into patch "btrfs-progs: check: add check and
> repair ability for super num devs mismatch".
> As there are quite some comments update in devel branch already.

Thanks, fixups are easier to apply but if you send v2 of the original
patch I apply the differences to the updated committed version so no
changes are lost.
