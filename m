Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A200E4E57CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiCWRsm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiCWRsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 13:48:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D146E56A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 10:47:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1AAD1F387;
        Wed, 23 Mar 2022 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648057629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZlrU5YG4A2QYAVftidxwT2sJoDAyz8+kwrDWCygBew=;
        b=VtCDkXHgfcMicC/NXHxQB2AdpPofUnIWofbOiP5WRROC23uNHJnzu17/dnHsCfvjiUAPik
        HwyxCyE7MTDjq09zb2whl4dbntbqO/o9F0wWVVSTrkEIjmSNoijolX1s485g9QRXd3HJZt
        eyaS5RQtx4B+pWjCtIKMa7GRXR/oTnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648057629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZlrU5YG4A2QYAVftidxwT2sJoDAyz8+kwrDWCygBew=;
        b=UI4jrSDYse4ER/w7MdZECOVnUXYeSY+yMuAREnPNt6cuzXKLWl0f7UfWuYG6rlv24M6jAr
        SnWET9KQJ9d+LnDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C8CD8A3B83;
        Wed, 23 Mar 2022 17:47:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88EB6DA7DA; Wed, 23 Mar 2022 18:43:15 +0100 (CET)
Date:   Wed, 23 Mar 2022 18:43:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics 
        <luca.bela.palkovics@gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: add check and repair ability for
 super num devs mismatch
Message-ID: <20220323174315.GC2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics <luca.bela.palkovics@gmail.com>
References: <cover.1646009185.git.wqu@suse.com>
 <029df99dabfee5b8fc602bf284bb3ea364176418.1646009185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <029df99dabfee5b8fc602bf284bb3ea364176418.1646009185.git.wqu@suse.com>
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

On Mon, Feb 28, 2022 at 08:50:07AM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report of kernel rejecting fs which has a mismatch in
> super num devices and num devices found in chunk tree.
> 
> But btrfs-check reports no problem about the fs.
> 
> [CAUSE]
> We just didn't verify super num devices against the result found in
> chunk tree.
> 
> [FIX]
> Add such check and repair ability for btrfs-check.
> 
> The ability is mode independent.
> 
> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

With this patch applied there's a new test failure:

=== START TEST .../tests/fsck-tests/014-no-extent-info
testing image no_extent.raw.restored
====== RUN MUSTFAIL .../btrfs check ./no_extent.raw.restored
Opening filesystem to check...
Checking filesystem on ./no_extent.raw.restored
UUID: aeee7297-37a4-4547-a8a9-7b870d58d31f
cache and super generation don't match, space cache will be invalidated
found 180224 bytes used, no error found
total csum bytes: 0
total tree bytes: 180224
total fs tree bytes: 81920
total extent tree bytes: 16384
btree space waste bytes: 138540
file data blocks allocated: 0
 referenced 0
succeeded (unexpected!): .../btrfs check ./no_extent.raw.restored
unexpected success: btrfs check should have detected corruption
