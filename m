Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58927628B20
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 22:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiKNVLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 16:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiKNVLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 16:11:37 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB4B08
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 13:11:36 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 0F08E4057C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:15:28 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 793068036FDA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:11:35 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 69BD0803772E
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:11:35 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MPzJ1gZjuDwZ for <linux-btrfs@vger.kernel.org>;
        Mon, 14 Nov 2022 15:11:35 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 18F278036FDA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:11:34 -0600 (CST)
Date:   Mon, 14 Nov 2022 16:11:28 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: option to mount read-only subvolume with read-write access
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <47WCLR.GFSQA1T9N0822@ericlevy.name>
In-Reply-To: <20221114203331.GZ5824@twin.jikos.cz>
References: <G1N4LR.84UPK81F80SK3@ericlevy.name>
        <20221110121249.GE5824@twin.jikos.cz> <X4X4LR.21Q66E3SQOHF@ericlevy.name>
        <20221114203331.GZ5824@twin.jikos.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Mon, Nov 14 2022 at 09:33:31 PM +0100, David Sterba 
<dsterba@suse.cz> wrote
>> This sounds like the transaction update that is in openSUSE,
> https://github.com/openSUSE/transactional-update . The difference is
> that you would like it to work on the same subvolume and that all the
> work is done on the filesystem level, not completely managed by
> userspace utilities.


My understanding of the TU framework is that the tools create a 
snapshot to be selected for the next boot session, and that while that 
snapshot is being prepared, its read-only property is disabled. Once 
some modification operation concludes, the read-only property is 
toggled back to true. A file-system feature would make it easier to 
alter the snapshot in some staging environment, without changing the 
snapshot properties, or the location of the snapshot in the full file 
system.

My current understanding of TU is based on some amount of 
extrapolation, however, which may be inaccurate.


