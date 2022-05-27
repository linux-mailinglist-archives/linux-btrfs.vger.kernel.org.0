Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D507536357
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiE0Nd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 09:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351915AbiE0NdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 09:33:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37D146435;
        Fri, 27 May 2022 06:33:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA8D768AFE; Fri, 27 May 2022 15:33:18 +0200 (CEST)
Date:   Fri, 27 May 2022 15:33:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/9] btrfs: add a helpers for read repair testing
Message-ID: <20220527133318.GA23864@lst.de>
References: <20220524071838.715013-1-hch@lst.de> <20220524071838.715013-2-hch@lst.de> <ed54f57f-4547-8b04-b59f-85c78da4b36f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed54f57f-4547-8b04-b59f-85c78da4b36f@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 02:22:28PM +0300, Nikolay Borisov wrote:
>> +# Return the btrfs logical address for the first block in a file
>> +_btrfs_get_first_logical()
>> +{
>> +	local file=$1
>> +	_require_command "$FILEFRAG_PROG" filefrag
>> +
>> +	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>
> Likely you want to print the logical layout of the file for reference 
> purposes? Then use $file instead of $SCRATCH_MNT/foobar

Yeah, this should use $file.
