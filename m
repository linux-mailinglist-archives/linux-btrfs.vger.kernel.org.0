Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0D5B6727
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIMFIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIMFIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:08:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D9422C4
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:08:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1387A68AFE; Tue, 13 Sep 2022 07:08:30 +0200 (CEST)
Date:   Tue, 13 Sep 2022 07:08:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: split the bio submission path into a
 separate file
Message-ID: <20220913050829.GA29304@lst.de>
References: <20220912141121.3744931-1-hch@lst.de> <20220912141121.3744931-2-hch@lst.de> <PH0PR04MB7416C3ED5D9F5732E5C4D5D09B449@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416C3ED5D9F5732E5C4D5D09B449@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 03:27:10PM +0000, Johannes Thumshirn wrote:
> On 12.09.22 16:11, Christoph Hellwig wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2007 Oracle.  All rights reserved.
> > + * Copyright (C) 2022 Christoph Hellwig.
> > + */
> 
> IIRC David does try to get rid of all the per-company copyright
> statements for new files.

We just had that discussion in another thread - there really is no
basis for getting rid of them.  In fact talking to lawyers, most
of them thing we should have more of them, not less.
