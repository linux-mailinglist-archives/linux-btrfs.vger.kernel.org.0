Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC65546B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbiFVLCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 07:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiFVLC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 07:02:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39293BA66
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 04:02:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4599B68AA6; Wed, 22 Jun 2022 13:02:24 +0200 (CEST)
Date:   Wed, 22 Jun 2022 13:02:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Message-ID: <20220622110223.GB27411@lst.de>
References: <20220619082821.2151052-1-hch@lst.de> <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com> <20220622050658.GA22104@lst.de> <baeb9e98-fba4-8af9-9fd5-da6e1bd8ee34@gmx.com> <20220622074719.GA24601@lst.de> <6ee19563-2345-efcb-14be-ea3fd083999a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee19563-2345-efcb-14be-ea3fd083999a@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 04:46:10PM +0800, Qu Wenruo wrote:
>>> Then in that case, I guess we can also just submit the good copy to all
>>> mirrors instead, no matter if it's corrupted or not?
>>
>> Why would we submit it to a known good mirror?
>
> If we didn't read from that mirror, it can be a bad one (at least unknown 
> one).

Yes.  But I think anything that we didn't notice anyway as part of the
normal read flow is probably better left to the normal scrub flow.
