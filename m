Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F325E5B82
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVGkC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 02:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIVGkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 02:40:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A156DF9E
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 23:39:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29CA068AFE; Thu, 22 Sep 2022 08:39:56 +0200 (CEST)
Date:   Thu, 22 Sep 2022 08:39:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: split the bio submission path into a
 separate file
Message-ID: <20220922063955.GA28380@lst.de>
References: <20220912141121.3744931-1-hch@lst.de> <20220912141121.3744931-2-hch@lst.de> <PH0PR04MB7416C3ED5D9F5732E5C4D5D09B449@PH0PR04MB7416.namprd04.prod.outlook.com> <20220913050829.GA29304@lst.de> <20220921094014.GB32411@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921094014.GB32411@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yeah, I've got the message that btrfs wants to remain the special
and badly opinionated mess it is, and I'll stop bothering you with
patches in the future.
