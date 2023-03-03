Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EB6A995D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCCOZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCCOZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:25:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071765B5C9
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:25:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7036368BEB; Fri,  3 Mar 2023 15:25:39 +0100 (CET)
Date:   Fri, 3 Mar 2023 15:25:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/10] btrfs: store a pointer to a btrfs_bio in struct
 btrfs_bio_ctrl
Message-ID: <20230303142539.GB32738@lst.de>
References: <20230301134244.1378533-1-hch@lst.de> <20230301134244.1378533-9-hch@lst.de> <e5ebac92-945e-0e59-66fa-922acf0f178d@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ebac92-945e-0e59-66fa-922acf0f178d@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 02:20:19PM +0000, Johannes Thumshirn wrote:
> >  {
> > -	struct bio *bio = bio_ctrl->bio;
> > +	struct btrfs_bio *bbio = bio_ctrl->bbio;
> >  	int mirror_num = bio_ctrl->mirror_num;
> >  
> 
> Can we keep a local bio in here? so we don't have to do
> bbio->bio every other line?

About half of these is going away in follow on patches, and in the
next series or two most of the remaining onces will disappear as well.
