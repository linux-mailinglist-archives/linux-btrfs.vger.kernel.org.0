Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C744553691
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353080AbiFUPq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351597AbiFUPq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 11:46:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817192CDE8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 08:46:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 286DA68AA6; Tue, 21 Jun 2022 17:46:54 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:46:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Message-ID: <20220621154653.GA10068@lst.de>
References: <20220619082821.2151052-1-hch@lst.de> <b633dedf-b322-2d8c-adfb-8ab88af5652e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b633dedf-b322-2d8c-adfb-8ab88af5652e@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 06:19:19PM +0300, Nikolay Borisov wrote:
>> +
>> +	mirror = failrec->this_mirror;
>> +	do {
>> +		mirror = prev_mirror(failrec, mirror);
>> +		repair_io_failure(fs_info, ino, start, failrec->len,
>> +				  failrec->logical, page, pg_offset, mirror);
>> +	} while (mirror != failrec->orig_mirror);
>
> But does this work as intended? Say we have a raid1c4 and we read from 
> mirror 3 which is bad, in this case failrec->orig_mirror = 3 and 
> ->this_mirror = 4. The read from mirror 4 returns good data and 
> clean_io_failure is called with mirror= 3 in which case only mirror 3 is 
> repaired (assume 1/2 were also bad we don't know it yet, because the 
> original bio request didn't submit to them based on the PID policy).

Yes.  Although that is what I intended as we don't want to read
data we don't otherwise have to. Maybe it should state "all known bad
mirrors" instead of "all mirrors".  I think if we want to check all
mirror we need to defer to the scrub code.

