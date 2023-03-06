Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2A6ACC05
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCFSJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 13:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCFSIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 13:08:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F61D27998
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDxyoe2iKVZrYqkJ8y9tlFekP3mfqpu6p4kx2YMdvrY=; b=tNqqsNdmgv2zqqW9kVgHh77Cmk
        6pqgnEyFjVc2nNAomZ5baKyymx4qG4SmkG31uUYo5ZNw9c/IiuRXMTY14B60uY2HDRwLGmV6+57sP
        O3MugYLA6rhCR/Agh3DIJXD2kc8v1/2T024EzmNcW1t5NyPBT0VQCGDCtxyI191C+OhM3NI+Ezim3
        uFt/b+OFSOK55CvjGmCcinCOsW6bAnsO0+3K2B1EENqE9X53vy0WrKUEjbDk2zr2wR5YP5o+QJQc1
        /1fSqnUHLJVJtkkEK9ylE2hK2dSJ+hJJ5is77o51Ecg3WkXMTSboH67+dSurkqt1G7zfoCZMotIsV
        PEi99XXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZEMo-00E4Dr-Ua; Mon, 06 Mar 2023 17:11:18 +0000
Date:   Mon, 6 Mar 2023 09:11:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZAYetplTq9IGbLWm@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <ZACrzUh82/9HPDV2@infradead.org>
 <cb26ea54-a0b8-2102-6899-521ca8028b9c@gmx.com>
 <ZAIA+a6G8kd2I8Pp@infradead.org>
 <2ace5cfb-afed-87a7-22d8-8f98a49c39b1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ace5cfb-afed-87a7-22d8-8f98a49c39b1@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 04, 2023 at 07:03:01AM +0800, Qu Wenruo wrote:
> But I'm not familiar enough on the direct IO front, IIRC we have some recent
> bugs related to page faulting during a larger direct IO write.

Yes.  But the fix for that is actually doing some of the same changes
I had planned for my series, so I think we're aligned on the direction.
