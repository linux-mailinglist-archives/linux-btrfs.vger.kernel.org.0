Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E491566457
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGEHnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEHnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:43:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C64D69;
        Tue,  5 Jul 2022 00:43:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6929C68AA6; Tue,  5 Jul 2022 09:43:20 +0200 (CEST)
Date:   Tue, 5 Jul 2022 09:43:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common: provide generic block error injection
 helper
Message-ID: <20220705074320.GA17451@lst.de>
References: <20220704090346.108134-1-hch@lst.de> <21e90405-559d-d8ec-1c82-81cfab9819f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e90405-559d-d8ec-1c82-81cfab9819f5@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 11:00:57PM +0800, Anand Jain wrote:
>> -	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
> Only extra line in btrfs/150 is the above line (or did I miss any)?
> Which is deleted in this patch.

Yes.

>> -	enable_io_failure
>> -
>> +	_enable_fail_make_request
>> +	_start_fail_dev $SCRATCH_DEV
>>   	result=$(bash -c "
>>   	if [ \$((\$\$ % 2)) == 1 ]; then
>
>>   		echo 1 > /proc/\$\$/make-it-fail
>
>  So this won't work now.

Yes.
