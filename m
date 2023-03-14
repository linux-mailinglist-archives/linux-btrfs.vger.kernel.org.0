Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D906B8CD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 09:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCNIPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 04:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjCNIPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 04:15:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A097B78
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 01:13:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2951068AA6; Tue, 14 Mar 2023 09:12:11 +0100 (CET)
Date:   Tue, 14 Mar 2023 09:12:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/21] btrfs: fix sub-page error bit in
 end_bio_subpage_eb_writepage
Message-ID: <20230314081210.GA30584@lst.de>
References: <20230314061655.245340-1-hch@lst.de> <20230314061655.245340-3-hch@lst.de> <f4c1659b-f8d4-5fdf-af2c-40eaa40e77a0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c1659b-f8d4-5fdf-af2c-40eaa40e77a0@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 04:06:46PM +0800, Qu Wenruo wrote:
>
>
> On 2023/3/14 14:16, Christoph Hellwig wrote:
>> Call btrfs_page_clear_uptodate instead of ClearPageUptodate to properly
>> manage the error bit for the subpage case.
>
> I guess you mean "uptodate bit".

Indeed.
