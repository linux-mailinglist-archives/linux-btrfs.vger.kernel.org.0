Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952A534BBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiEZI25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZI24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:28:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7E51E44
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:28:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1055068AA6; Thu, 26 May 2022 10:28:52 +0200 (CEST)
Date:   Thu, 26 May 2022 10:28:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Message-ID: <20220526082851.GA26556@lst.de>
References: <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com> <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com> <20220526073022.GA25511@lst.de> <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com> <20220526074536.GA25911@lst.de> <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com> <20220526080056.GA26064@lst.de> <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com> <20220526081757.GA26392@lst.de> <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 04:26:30PM +0800, Qu Wenruo wrote:
>
>
> On 2022/5/26 16:17, Christoph Hellwig wrote:
>> On Thu, May 26, 2022 at 04:07:49PM +0800, Qu Wenruo wrote:
>>> Then it can be said to almost all ENOSPC error handling code.
>>
>> ENOSPC is a lot more common.
>
> Sorry, I mean ENOMEM.
>
>>
>>> It's less than 1% chance, but we spend over 10% code for it.
>>>
>>> And if you really want to go that path, I see no reason why we didn't go
>>> sector-by-sector repair.
>>
>> Because that really sucks for the case where the whole I/O fails.
>> Which is the common failure scenario.
>
> But it's just a performance problem, which is not that critical.

I'm officially lost now.
