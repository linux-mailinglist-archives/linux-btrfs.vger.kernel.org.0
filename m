Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69229476693
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 00:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhLOXfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 18:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhLOXfv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 18:35:51 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C73C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 15:35:51 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B81459B9F8; Wed, 15 Dec 2021 23:35:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639611348;
        bh=/0zDESV1ijZ4hBbrUc/AN9AjHHghDFCS/QjKx+sNfFE=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=iapUjJD2xHIjSTY02KluTZJVOSGGVFddS4ZP46gBFkjLbBDDwqlHdlTmdiqFja8n3
         0ABzzWpnIKx9rJHi9hTDvoXYjujkwNPlXN/uPIQXFvS+7+hG5xpBaHvn0f33yB+5kO
         6wcAba4mI0Pwbo6mImxQ9dvbR5UAg0R/KdjXXAb+9oCfN/6J3betKUg5aGJ7lOz9LK
         Qcw9cV9Mqx3EOYPwCddcSke+G5DGZFTOxbgBKriyZUJNb/JfnKOi+oV4fSoCvUumBM
         bkP7m9kWv795hDsPv7H18BmGWMIWcKMjD6ZnnH0gpJiBd315JI7zghngg0IMYTZKw1
         r4HY9qs92fsVA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.5 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 7CDD79B803;
        Wed, 15 Dec 2021 23:35:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1639611319;
        bh=/0zDESV1ijZ4hBbrUc/AN9AjHHghDFCS/QjKx+sNfFE=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=TAKpl1xO4sDwCRYbn/nQLrbvygQW3NzXIWLZfqMP53AOADHdGYYvvITtODt2os4NH
         DgJzcr7xg5ewf7UKv3DoX4NMh315ynBCtTQJqJuV+a8trFugr1UpS5cTCcDj+/uJKJ
         T4MH8i8dxybq1+2OFGQ7N1uWcEITGGBTi8sOBkvUuS/I2amd4K+2goELTqUFF+H7Lb
         XAbhWACJO24qV8DUgrjkQbNnlu7XFi1obHOSvVEju0cl1XAh6pFJfM5xyPy6vjRZud
         JOGN9erocB8oODnxPXYrGSX48wDieJ5vGfOJiu0gTX64TM1LPSGZMKhl5uzWFmlhv2
         ut27Gw77AjDOg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 393E12D62D8;
        Wed, 15 Dec 2021 23:35:19 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
Message-ID: <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
Date:   Wed, 15 Dec 2021 23:35:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/12/2021 20:27, Eric Levy wrote:
> Hello.
> 
> I have been experiencing very confusing problems with incremental
> streams.

There is no such thing as an incremental stream. Send sends all the
information necessary to create a subvolume. Some of that includes
instructions to share data in other subvolumes but it is not incremental.

> For a subvolume, I have a simple incremental backup created from two
> stages:
> 
> btrfs send old/@ > base.btrfs
> btrfs send new/@ -p old/@ > update.btrfs
> 
> The two source subvolumes are snapshots captured at separate times from
> the same actively mounted subvolume.
> 
> On the target, I attempt to restore:
> 
> btrfs receive ./ < base.btrfs
> btrfs receive ./ < update.btfs
> 
> The expectation is that the prior command would create a restored
> snapshot of the initial backup stage, 

Yes

> and that the latter would apply
> the updated stage.

No. Receive always creates a brand new subvolume - it doesn't update
anything. Of course, the new subvolume may include clones of data stored
in other subvolumes but it doesn't modify any existing subvolumes.

> 
> The prior command succeeds, but the latter fails:
> 
> ERROR: creating snapshot ./@ -> @ failed: File exists
> 
> Since it is obvious I cannot usefully apply the second stage to a
> target that does not exist, I am puzzled about why the process performs
> this check, as well as what is expected to have success applying the
> update.
> 
> How may I apply the update stage to the target generated from restoring
> the initial stage?

You don't. Receive will create a new subvolume - which will include
unchanged data from the initial stage and whatever changes have
happened. If you want, you can then snapshot that (read-only or
read-write as you wish) into any position you want in your destination
filesystem.

Graham
