Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9916244C009
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 12:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKJLVQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 06:21:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36780 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJLVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 06:21:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4456D2195F;
        Wed, 10 Nov 2021 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636543106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLZ2mXV0pc2SLO9dt0S6fo2pp/kc4vkap9OJcKCIHTg=;
        b=mztUHNzOEdPDDGmjY+lC04wQ5Spc6m7ki9G0nY1pQKBGYq92Flxqm1dbm6si5zem03Aq7q
        yni/CnKAIqDy4DxO9So6iOy3d3mLRoaPYBtqUMstm4G9qJWUy78rCwyu3FipfBb5onhfVU
        ZeJrr/LlI9bQSCatwb8/QAQfPKkgWoI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 089E913BAC;
        Wed, 10 Nov 2021 11:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JF8qO4Gqi2HlUwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 10 Nov 2021 11:18:25 +0000
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20211108142901.1003352-1-nborisov@suse.com>
 <9a98623c-f34a-8a64-f211-18e3e3439078@oracle.com>
 <2e4207b5-0266-392e-39fd-1848632c93f8@suse.com>
 <20211110105311.GW60846@e18g06458.et15sqa>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3e58ea25-d21a-b668-4d48-40437ac0ea29@suse.com>
Date:   Wed, 10 Nov 2021 13:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110105311.GW60846@e18g06458.et15sqa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.11.21 г. 12:53, Eryu Guan wrote:
> On Wed, Nov 10, 2021 at 12:07:37PM +0200, Nikolay Borisov wrote:
>> <snip>
>>
>>
>>>> +# titled "btrfs: allow device add if balance is paused"
>>>
>>> It is a new feature, not a bug fix? The kernel patch won't backport to
>>> the stable kernels. Then on older kernels, this test has to exit with
>>> _notrun().
>>> Is there any way to achieve this? There isn't any sysfs interface that
>>> will help and, so far we haven't used the kernel version to achieve
>>> something like this.
>>>
>>
>> No, and this is outside the remit of xfstest. Anyone who is running
>> xfstest should ensure incompatible tests are excluded.
> 
> I don't think that's the case, we perfer test case detect required env
> to run the test and _notrun if any condition not met. For regression
> test for bug fix, we want the test to fail on old/un-patched kernel, but
> for new features we need a way to tell if the kernel in test has the
> feature or not.

There isn't really an easy way to test for the presence of this feature.
The closest I could think of is modify btrfs' exclusive_operation sysfs
to show "balance paused" and in the test simply run a dummy balance and
pause it and check whether "balance" or "balance paused" is the state of
the exclusive op. However this means for this test to also rely on the
presence of the exclusive_operation sysfs file. However, I don't like
this because adding a device to balance is independent of the
exclusive_operation sysfs i.e it only has an informative role.

> 
> Thanks,
> Eryu
> 
