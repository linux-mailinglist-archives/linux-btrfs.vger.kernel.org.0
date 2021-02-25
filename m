Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66439324953
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBYDP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 22:15:57 -0500
Received: from sandeen.net ([63.231.237.45]:57768 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhBYDP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 22:15:56 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 01FAB450A88;
        Wed, 24 Feb 2021 21:14:59 -0600 (CST)
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
 <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
 <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
 <74ea7a30-fd25-7ac5-b3ae-98cf7b70e80f@gmx.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5fb6c496-dc53-662e-1970-9afb9a9dd62d@sandeen.net>
Date:   Wed, 24 Feb 2021 21:15:14 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <74ea7a30-fd25-7ac5-b3ae-98cf7b70e80f@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/21 9:13 PM, Qu Wenruo wrote:

> Now this makes way more sense,

Sorry for the earlier mistake.

> as your previous comment on
> _btrfs_forget_or_module_reload is completely correct.
> 
> _btrfs_forget_or_module_reload will really forget all devices, while
> what we really want is just excluding certain devices, and not to affect
> the other ones.
> 
> The proper way to fix it is to only introduce _btrfs_forget to
> unregister involved devices, not all.
> 
> I'll take a look into the fix, but I'm afraid that, for systems which
> don't support forget, they have to skip those tests and reduce the
> coverage for older kernel/progs.

Can't you just rescan when the test is done?

> Thanks,
> Qu
> 
