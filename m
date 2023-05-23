Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B970E216
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjEWQb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjEWQbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 12:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D60C2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HjizjmSbSnEnp47JHZUDXyB7yIKhhUrfbA/tpkHvmvE=; b=TSifdAq2xyE+KiJsPFaDhHCf+m
        AHmdHjSyzCFst/O4mSdC3PHU18vceuw9TQohZNy1yH0oPZ9aREBTKMWHkCzw9h+YJq2zzHtzUTdJR
        p6SviT7v0HnbqYj1SF2P5LVJjVS4yPeWRqUGqd+HMP3oqwITa60peWYsFLoq+Lla+br1TAP75uMgP
        FvstI/75mPereXKFSH9pZLmL83aEqP5ufk8gIQz12gbliqFTO4tUg2CvZUPovVZwFO6iy2cMHjcXo
        miFD+qZ3e0QwKm5EabZuHYwdG8IDI9EZuAw1krZ20LQZqqvlDLYgrnvRD+urHhZXSkU7fkx5HoABj
        a2EzCtwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1UvT-00AoEG-0E;
        Tue, 23 May 2023 16:31:55 +0000
Date:   Tue, 23 May 2023 09:31:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: refactor with memcmp_fsid_changed helper
Message-ID: <ZGzqe5b/whDTQjAz@infradead.org>
References: <cover.1684826246.git.anand.jain@oracle.com>
 <22107504d4d780ff15382ec0abf531314069692a.1684826247.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22107504d4d780ff15382ec0abf531314069692a.1684826247.git.anand.jain@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 06:03:23PM +0800, Anand Jain wrote:
> +	return (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
> +		       BTRFS_FSID_SIZE) != 0 &&
> +		memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0);

no need for the outer braces.

