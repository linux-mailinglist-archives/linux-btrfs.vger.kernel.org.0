Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC775DA42
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGVGFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVGFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 02:05:01 -0400
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A003A9B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 23:05:00 -0700 (PDT)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id BA95640532;
        Sat, 22 Jul 2023 01:14:49 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id F408A8797BAD;
        Sat, 22 Jul 2023 01:04:58 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id D91508797BAF;
        Sat, 22 Jul 2023 01:04:58 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TkK9prmZ7cOu; Sat, 22 Jul 2023 01:04:58 -0500 (CDT)
Received: from [10.4.2.11] (unknown [191.96.227.33])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 69F818797BAD;
        Sat, 22 Jul 2023 01:04:58 -0500 (CDT)
Date:   Sat, 22 Jul 2023 02:04:50 -0400
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <2WO6YR.XUIBVZYBN0GJ1@ericlevy.name>
In-Reply-To: <9904a32c-76d7-903d-78b3-7df62c60141a@gmail.com>
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
        <9904a32c-76d7-903d-78b3-7df62c60141a@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Sat, Jul 22 2023 at 07:34:26 AM +0300, Andrei Borzenkov 
<arvidjaar@gmail.com> wrote:

> Log with timestamps could be more useful.

I would need to generate a report showing millisecond granularity in 
order to reveal intervals not appearing as zero duration.

> Something tries to mount this filesystem before all its devices are 
> present. You need to find out what does it. btrfs is just a messenger 
> here.

The systemd mount unit is defined to start after iscsi finishes 
initializing. The idea that the kernel or filesystem layers wer causing 
problems follows from a remark given to me through a different thread 
that I opened just days ago. I have tried many different variations for 
the systemd mount unit without reaching any success for the issue.




