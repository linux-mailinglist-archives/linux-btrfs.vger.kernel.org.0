Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5D690EEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjBIRLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 12:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBIRLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 12:11:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1EF7EE5;
        Thu,  9 Feb 2023 09:11:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5321B68BFE; Thu,  9 Feb 2023 18:11:46 +0100 (CET)
Date:   Thu, 9 Feb 2023 18:11:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/7] generic: add 251 to the auto group
Message-ID: <20230209171146.GA20819@lst.de>
References: <20230209051355.358942-1-hch@lst.de> <20230209051355.358942-7-hch@lst.de> <Y+Ublyc88P7mlg/i@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Ublyc88P7mlg/i@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 09, 2023 at 08:13:11AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 09, 2023 at 06:13:54AM +0100, Christoph Hellwig wrote:
> > generic/251 isn't dangerous, doesn't takes overly long to run and doesn't
> > produce spurious failures, so add it to the auto group.
> 
> How long does it take for you?

Between 300 and 400 seconds usually.
