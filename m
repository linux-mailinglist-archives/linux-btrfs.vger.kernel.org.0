Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3468080C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjA3JAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 04:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjA3JAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 04:00:52 -0500
X-Greylist: delayed 1812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 01:00:48 PST
Received: from sender3-pp-o97.zoho.com (sender3-pp-o97.zoho.com [136.143.184.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02A2CFE6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 01:00:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675066454; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cD13T5FR8kLmh8cJb7dzfJh9ozBxODXhsbL6xCiPvZxXAKhZ795gJZ63KSf+otDVgIoVpz5zHhA64aPK8q0CiK9aUd2VkeCHhVcpyZxh0/f0iEHdGDIRR90vSCDzJc+HIa9Q0PbvhgfXmBXcVWj2QZgjyxUak1gYomK9xiiDaHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675066454; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JLLq1LoE8xkwrIj1nsXyjF7DDhUAzVU3jqzhiBVrVbE=; 
        b=bozFh/adv8lnmV6/3RzOMAULHsE7xaopi6VJRxKvK03PoQqk6AdPaOp9xX5JZ5C11ZLc+TtRQtSL26Tam/8QJYCziZ7e4PlUoB6kapbjfiNJlmwfZdKe4lLil/G8cs8JaiJI5HWV314Rc1zQOK9F5DXRzXinxnuHxcQGTgPbzIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675066454;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=JLLq1LoE8xkwrIj1nsXyjF7DDhUAzVU3jqzhiBVrVbE=;
        b=StVWwy+GZyReWX8aitF20hCrRyYP9bOjONyLws2ZBAI4CaGp815S2GHaeguKrPgl
        jHk3MvG5yljHybEzcuw085EeAQNU0RIH3giUll1X/CVj1G56wevH6rZzaEBInvigPL1
        SkgkPWURscJYsSGpyG4geAxeKrKQxsXWEJJ/JouQ=
Received: from [192.168.0.103] (58.247.201.202 [58.247.201.202]) by mx.zohomail.com
        with SMTPS id 1675066453588279.7780564701459; Mon, 30 Jan 2023 00:14:13 -0800 (PST)
Message-ID: <75af8bba-6a0c-9cfd-f2e7-7b71ef51ab77@zoho.com>
Date:   Mon, 30 Jan 2023 03:14:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] btrfs-progs: minor fixes for clang warnings
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1674797823.git.wqu@suse.com>
 <e16dd0dc-da4f-e49c-2257-9180b636f59d@suse.com>
Content-Language: en-US
From:   hmsjwzb <hmsjwzb@zoho.com>
In-Reply-To: <e16dd0dc-da4f-e49c-2257-9180b636f59d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

	I think maybe clang has some optimization which GCC doesn't.

Thanks

On 1/30/23 02:28, Qu Wenruo wrote:
> 
> 
> On 2023/1/27 13:41, Qu Wenruo wrote:
>> Recently I'm migrating my default compiler from GCC to clang, mostly to
>> get short comiling time (especially important on my aarch64 machines).
> 
> Just to mention, although the cleanup itself still makes sense, it doesn't make any sense to migrate to clang, at least on my aarch64 machines.
> 
> GCC takes only 22min for my trimmed kernel config, while the same config takes clang 32min...
> 
> Thanks,
> Qu
> 
>>
>> Thus I hit those (mostly false alerts) warnings in btrfs-progs, and come
>> up with this patchset.
>>
>> Unfortunately there is still libbtrfsutils causing warnings in
>> setuptools, as it's still using the default flags from gcc no matter
>> what.
>>
>> Qu Wenruo (5):
>>    btrfs-progs: remove an unnecessary branch to silent the clang warning
>>    btrfs-progs: fix a false alert on an uninitialized variable when
>>      BUG_ON() is involved.
>>    btrfs-progs: fix fallthrough cases with proper attributes
>>    btrfs-progs: move a union with variable sized type to the end
>>    btrfs-progs: fix set but not used variables
>>
>>   cmds/reflink.c              |  2 +-
>>   cmds/scrub.c                | 12 +++---
>>   common/format-output.c      |  2 +-
>>   common/parse-utils.c        | 12 +++---
>>   common/units.c              |  6 +--
>>   crypto/xxhash.c             | 73 +++++++++++++++++++------------------
>>   image/main.c                | 15 +++-----
>>   kerncompat.h                |  8 ++++
>>   kernel-shared/ctree.c       | 18 +++++----
>>   kernel-shared/extent-tree.c |  4 +-
>>   kernel-shared/print-tree.c  |  2 +-
>>   kernel-shared/volumes.c     |  3 +-
>>   kernel-shared/zoned.c       |  6 +--
>>   mkfs/main.c                 |  4 --
>>   14 files changed, 84 insertions(+), 83 deletions(-)
>>
