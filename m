Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09570DBD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjEWLyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 07:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjEWLye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 07:54:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC618F
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 04:54:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C192D6732D; Tue, 23 May 2023 13:54:25 +0200 (CEST)
Date:   Tue, 23 May 2023 13:54:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
Message-ID: <20230523115425.GA30209@lst.de>
References: <20230523081322.331337-1-hch@lst.de> <20230523081322.331337-3-hch@lst.de> <7d1d512a-e4d6-70c1-93c9-61800955b4b0@oracle.com> <20230523113907.GB28908@lst.de> <e3fc220d-3229-454c-6106-bc705490f05e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fc220d-3229-454c-6106-bc705490f05e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 07:47:14PM +0800, Anand Jain wrote:
>
>
> On 23/05/2023 19:39, Christoph Hellwig wrote:
>> On Tue, May 23, 2023 at 06:16:25PM +0800, Anand Jain wrote:
>>>>    +static int btrfs_verify_page(struct page *page, u64 start)
>>>
>>>   Did you consider making it an inline function?
>>
>> No, why?
>
> As the compiler optimization may or may not inline it?

And making that decision is in general the compilers job.  I don't
see a need to second guess the compiler here.
