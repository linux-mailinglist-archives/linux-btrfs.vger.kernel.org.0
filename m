Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59E263423C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKVRMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 12:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiKVRL6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 12:11:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918C77220
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 09:11:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB6781F85D;
        Tue, 22 Nov 2022 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669137116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fyXxzLJTRO3asuoegxYhxGR9vGUL8USwGLX/wULAdo=;
        b=OLo8ffN0apECEnBQ8yNqx9VRyTcVc8A0KqZK+Y3JA1hvQ3mHkuHDq56eT3xbqSeHYqfpNH
        sxdtUUlAYVdDP0LRqvSO0MTeRLTPJ6sqqcz0PXiDDK5uxgPkh2mU/niGKVKy+TeufjaA2V
        lpui5IK1G+Z2WoEvJGe7K5C0urXZ1A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669137116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fyXxzLJTRO3asuoegxYhxGR9vGUL8USwGLX/wULAdo=;
        b=wiGTlKWFBeqMVNmYTuS4CsKzu/QexoxM7D50JI0/1/mw3D/OjFA5YEXihXR6b75E50drFd
        yvfW5jUfgpQoKGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84E6113AA1;
        Tue, 22 Nov 2022 17:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V17/GNwCfWPkTwAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 22 Nov 2022 17:11:56 +0000
Date:   Tue, 22 Nov 2022 11:11:55 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-btrfs@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [PATCH 07/16] btrfs: Lock extents before folio for read()s
Message-ID: <20221122171155.wq5xakbu7o5d3hwt@fiona>
References: <5c7c77d0735c18cea82c347eef2ce2eb169681e6.1668530684.git.rgoldwyn@suse.com>
 <202211212140.7f9c0a76-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211212140.7f9c0a76-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21:31 21/11, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -99.7% regression of fxmark.ssd_btrfs_DRBM_72_bufferedio.works/sec due to commit:
> 
> 
> commit: 94d3d147892ad202ecbd0a373b63469f2d12667a ("[PATCH 07/16] btrfs: Lock extents before folio for read()s")

This brings me to think why is the extent lock around reads required. Is
not the extent locks to protect against write overwrites. Pagelocks
should be sufficient. I tried running my patchset after removing the
extent locks and the tests run fine.

What am I missing?

<snipped>


-- 
Goldwyn
