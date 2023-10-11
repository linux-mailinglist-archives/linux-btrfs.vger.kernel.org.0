Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD47C500F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 12:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjJKK1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjJKK1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 06:27:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435AE94
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 03:27:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0273D2185D;
        Wed, 11 Oct 2023 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697020027;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53ukFM/PFDibfjtZh7CfuvOnVbge5abV8HLoEzu7c4E=;
        b=szhExMliero1QyX0s98/d0qNuS0NRVyx4YHFOXq4dfF0/lInR3NNV+iIt0HVH9wVCOwxaJ
        QLTRRO45D4vQj4FQKZ5CsUn4lHTurCMph2daDwJ9Eb4R7ariDv7PSnGJ96o0lhQ/rh6LBH
        PoqE9YHYa5bmOVpHnmPgsG89F0EXglY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697020027;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53ukFM/PFDibfjtZh7CfuvOnVbge5abV8HLoEzu7c4E=;
        b=tHTYkpNkbVOxIN2RkiK/asc1BRR3zGYCtl8uj0LOaT6XCjIYsQcJ9hMMgcKrNOBykX8Crl
        YdkxiuaiL4AOhTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2B1B138EF;
        Wed, 11 Oct 2023 10:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cQmGLnp4JmX4YgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Oct 2023 10:27:06 +0000
Date:   Wed, 11 Oct 2023 12:20:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 7/9] Btrfs: add free space tree sanity tests
Message-ID: <20231011102020.GF2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1443583874.git.osandov@osandov.com>
 <b8fbdc4c149cee8648399ebd985f111e4e4f191d.1443583874.git.osandov@osandov.com>
 <3f04845f-b9b5-68b6-90a0-8921eaa53b4d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f04845f-b9b5-68b6-90a0-8921eaa53b4d@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 11, 2023 at 10:12:37AM +0800, Jinjie Ruan wrote:
> 
> 
> On 2015/9/30 11:50, Omar Sandoval wrote:
     ^^^^^^^^^

> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This tests the operations on the free space tree trying to excercise all
> > of the main cases for both formats. Between this and xfstests, the free
> > space tree should have pretty good coverage.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>

> > +static int test_empty_block_group(struct btrfs_trans_handle *trans,
> > +				  struct btrfs_fs_info *fs_info,
> > +				  struct btrfs_block_group_cache *cache,
> > +				  struct btrfs_path *path)
> > +{
> > +	struct free_space_extent extents[] = {
> > +		{cache->key.objectid, cache->key.offset},
> > +	};
> > +
> > +	return check_free_space_extents(trans, fs_info, cache, path,
> > +					extents, ARRAY_SIZE(extents));
> 
> Inject fault when probe btrfs.ko,

I wonder how valid is fault injection during self tests, there are lot
of stub structures that are half-initialized and hitting a NULL could be
possible while the tests would not need it and knowingly ignore it.

The whole transaction abort mechanism cannot work reliably, there's no
single start or commit of the transaction in the test/ code so
an abort (in the regular code) can't work.

> there is a null-ptr-deref as below, it
> seems that the transaction in btrfs_trans_handle struct has not been
> initialized but used in __btrfs_abort_transaction() when calling
> WRITE_ONCE(trans->transaction->aborted, errno).

Yeah, not all structures are initialized.
