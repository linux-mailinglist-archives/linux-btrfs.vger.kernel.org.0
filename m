Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA14BBC16
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiBRPZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:25:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiBRPZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:25:12 -0500
Received: from eu-shark1.inbox.eu (eu-shark1.inbox.eu [195.216.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302E2B1A9B
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:24:55 -0800 (PST)
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id E01616C007E7;
        Fri, 18 Feb 2022 17:24:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645197892; bh=IMt9Cx5PtSdGDra3Bp+3CojYrzv7NKN9pvw+N0EGZ/Y=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=Cp/D8A2/Wd+8Dw9pqPGcznxamTUEBQnwVMwAdcgy+mN2LpvsBKvq9xNt1yUzvQBrb
         jEIvGKuUEFY7j1oKFb6kY9wRpQcDtW014W5f2OYsRO7RWJp4h+98lWpgyJd3obBtqp
         GdVyIuqoDjpOhgwORd0UpZnIdjAm6pB4Q1ZKOjis=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D23AD6C007E2;
        Fri, 18 Feb 2022 17:24:52 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 1eEBC1FNywhm; Fri, 18 Feb 2022 17:24:52 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id A3E2A6C0078F;
        Fri, 18 Feb 2022 17:24:52 +0200 (EET)
References: <20220121093335.1840306-1-l@damenly.su>
 <20220124154424.GX14046@twin.jikos.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Simple two patches for tree checker
Date:   Fri, 18 Feb 2022 23:13:12 +0800
In-reply-to: <20220124154424.GX14046@twin.jikos.cz>
Message-ID: <4k4w5hae.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVPp7o+fvJoxAj/GeDUSOFfksTURS1g21yTGK6vzsX
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 24 Jan 2022 at 16:44, David Sterba <dsterba@suse.cz> wrote:

> On Fri, Jan 21, 2022 at 05:33:33PM +0800, Su Yue wrote:
>> Two commits for enhancing tree checker to reject the img from
>> https://bugzilla.kernel.org/show_bug.cgi?id=215299.
>>
>> Su Yue (2):
>>   btrfs: tree-checker: check item_size for inode_item
>>   btrfs: tree-checker: check item_size for dev_item
>
> Nice, added to misc-next, thanks. I'll update and close the bug.

CC the reporter.

Oops. The Link of the crafted image in the first megered patch was 
pasted
wrongly. Just found while testing backports.

It should be

https://bugzilla.kernel.org/show_bug.cgi?id=215289

instead of

https://bugzilla.kernel.org/show_bug.cgi?id=215299

And the latter is still unfixed.

My bad.

--
Su
