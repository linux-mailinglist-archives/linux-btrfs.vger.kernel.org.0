Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86CB389388
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbhESQWP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbhESQWP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 12:22:15 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ACCC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 09:20:55 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id DE7429C2C4; Wed, 19 May 2021 17:20:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1621441251;
        bh=S8hCrNgioKrOROPFcsQlLBqGcXn2oOdaiQHjRaY+Fwg=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=EeK8oOrMtjqdJjf+y8i9Q8VsPfqoI6txlCm1D0jTb5saJ47sLm2hESreKPBu+xZMc
         OMHcq107tX/KQaM+XeqIcLb3hZk5pY7TZ2uhwnOl9dbWsgWpDtl+3V3S4xCLJBklrn
         2jn2K5xV9bb81R26HRFt/zmUhigaOHHLh5v/nxz8XOKmozCy2sC7O5+tdbY64Ss3j4
         avL5KVGjtadxXk/SfgX6cMsVUytvr2/im/QV1YjP3CO+XS6u3Frkx1rC5INEbdOGrj
         3w9RpUS7fVkXlcRRYILB5trcMyk09SxKnYZltflKHKYrtaxUjq97i36mLqxcycZBjV
         sfWK/yE0K9jXQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id E77649C28A;
        Wed, 19 May 2021 17:20:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1621441251;
        bh=S8hCrNgioKrOROPFcsQlLBqGcXn2oOdaiQHjRaY+Fwg=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=EeK8oOrMtjqdJjf+y8i9Q8VsPfqoI6txlCm1D0jTb5saJ47sLm2hESreKPBu+xZMc
         OMHcq107tX/KQaM+XeqIcLb3hZk5pY7TZ2uhwnOl9dbWsgWpDtl+3V3S4xCLJBklrn
         2jn2K5xV9bb81R26HRFt/zmUhigaOHHLh5v/nxz8XOKmozCy2sC7O5+tdbY64Ss3j4
         avL5KVGjtadxXk/SfgX6cMsVUytvr2/im/QV1YjP3CO+XS6u3Frkx1rC5INEbdOGrj
         3w9RpUS7fVkXlcRRYILB5trcMyk09SxKnYZltflKHKYrtaxUjq97i36mLqxcycZBjV
         sfWK/yE0K9jXQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 4928D23FF4D;
        Wed, 19 May 2021 17:20:50 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
 <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
Date:   Wed, 19 May 2021 17:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2021 16:32, Johannes Thumshirn wrote:
> On 19/05/2021 16:28, David Sterba wrote:
>> On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:
>>> On 18/05/2021 16:52, David Sterba wrote:
>>> I wonder if this interface would make sense for limiting balance
>>> bandwidth as well?
>>
>> Balance is not contained to one device, so this makes the scrub case
>> easy. For balance there are data and metadata involved, both read and
>> write accross several threads so this is really something that the
>> cgroups io controler is supposed to do.
>>
> 
> For a user initiated balance a cgroups io controller would work well, yes.

Hmmm. I might give this a try. On my main mail server balance takes a
long time and a lot of IO, which is why I created my "balance_slowly"
script which shuts down mail (and some other services) then runs balance
for 20 mins, then cancels the balance and allows mail to run for 10
minutes, then resumes the balance for 20 mins, etc. Using this each
month, a balance takes over 24 hours but at least the only problem is
short mail delays for 1 day a month, not timeouts, users seeing mail
error reports, etc.

Before I did this, the impact was horrible: btrfs spent all its time
doing backref searches and any process which touched the filesystem (for
example to deliver a tiny email) could be stuck for over an hour.

I am wondering whether the cgroups io controller would help, or whether
it would cause a priority inversion because the backrefs couldn't do the
IO they needed so the delays to other processes locked out would get
even **longer**. Any thoughts?

