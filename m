Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080E6CB288
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC0Xfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjC0Xft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227D26AA
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WGe866+0YqCtLQ1hzBwSpYYEn6MXZ8e1aQnN1UfLVN0=; b=zzIp+IVRCFwlro763ZcMLmKqEQ
        7OftWW/tjqNwsPDQnBD7EnSsxHUE2Th6R9NTniz/pj4r+oPAni5cj6uXuTAAVQ5n3eTgZNUz72WBu
        TrfV95EmufUCmIlubLt60wt2qQqGO76Dlqjg2kMjdk8abG8tvtKLkhgH0GSGQy9xQ3WiyLacvCfXc
        QJVthLOD1ILIKzv03lAZy0ksqc1hm602rETDPugh912eg2CX6vBl2zb/rpTof/ca0NLqaE4u3rEI5
        WD33W2785ekxwK4ThXyIZ06l4Fj1ylNWqhvLtlHsiFY/gHb9BgmwWT7sV3YFmxUOqQpS62ckjqOGG
        kjr1KkRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgwN7-00CfRh-00;
        Mon, 27 Mar 2023 23:35:29 +0000
Date:   Mon, 27 Mar 2023 16:35:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read
 bio for scrub
Message-ID: <ZCIoQLysbLrQW0pX@infradead.org>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 07:30:53AM +0800, Qu Wenruo wrote:
> The new helper, btrfs_submit_scrub_read(), would be mostly a subset of
> btrfs_submit_bio(), with the following limitations:
> 
> - Only supports read
> - @mirror_num must be > 0
> - No read-time repair nor checksum verification
> - The @bbio must not cross stripe boundary
> 
> This would provide the basis for unified read repair for scrub, as we no
> longer needs to handle RAID56 recovery all by scrub, and RAID56 data
> stripes scrub can share the same code of read and repair.
> 
> The repair part would be the same as non-RAID56, as we only need to try
> the next mirror.

Stupid question: what do we actually still need this and the write helper
for now that I think the generic helpers should work just fine without
bbio->inode?
