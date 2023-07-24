Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68A75EA5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGXEJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGXEJQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:09:16 -0400
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93CFE5A
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:08:59 -0700 (PDT)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 64D53404EA;
        Sun, 23 Jul 2023 23:18:55 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id B8B9680366D2;
        Sun, 23 Jul 2023 23:08:58 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 9BAB180366DE;
        Sun, 23 Jul 2023 23:08:58 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iDRFhvCmX_BQ; Sun, 23 Jul 2023 23:08:58 -0500 (CDT)
Received: from [10.4.2.11] (unknown [154.16.192.68])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 9EBF380366D2;
        Sun, 23 Jul 2023 23:08:57 -0500 (CDT)
Date:   Mon, 24 Jul 2023 00:08:51 -0400
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Message-Id: <RU8AYR.9BP7K2RWK3SZ1@ericlevy.name>
In-Reply-To: <303f4dab-1143-0ef8-444c-ba57e13b209e@oracle.com>
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
        <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
        <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
        <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com>
        <303f4dab-1143-0ef8-444c-ba57e13b209e@oracle.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Mon, Jul 24 2023 at 11:27:25 AM +0800, Anand Jain 
<anand.jain@oracle.com> wrote:
> 
> Yep, systemd or whatever should call 'btrfs device scan' before 
> mounting. According to the logs, it seems that this didn't happen. As 
> the device scan occurs later, after the failed mount attempt, 
> manually mounting from the terminal is successful.
> 
> Furthermore, to understand how it worked before the upgrade, you can 
> share with us the boot logs from the older kernel.
> 
> Thanks.

I no longer believe that the upgrade introduced any new problem. 
Broader testing with various kernel versions between 5.19.0 and 
6.5.0-rc2 reveals no general differences among them.

My earlier complaint about the upgrade leading to degraded behavior, I 
believe was premature, based simply on the bad luck of encountering the 
race condition on particular instances immediately after the upgrade, 
despite its having always been a problem.

The race condition itself remains an issue.

I have found a workaround, of moving the mount from a systemd unit to a 
fstab line, and adding the _netdev fake mount option.

However, I think systemd should complete the device scan before 
clearing the units remote-fs-pre.target and iscsi.service.


