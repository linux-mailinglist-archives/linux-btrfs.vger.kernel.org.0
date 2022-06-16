Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32354E820
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiFPQw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiFPQw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 12:52:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC0F5A0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 09:52:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AB765C0055;
        Thu, 16 Jun 2022 12:52:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Jun 2022 12:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1655398373; x=
        1655484773; bh=ChMk74/j0zVwr8vQ+6minyBzfKd5EePCKVmqXuE7mzQ=; b=t
        9uyJdTC+v2AhZ5gb9fcU3vMmXwpUXZ1EXLc7VP+eOQ+RkrW70EWdy26fevMIHH6j
        44s8lB/Od9VjAEpxW5IkO1XMKSn0DGv6G9EUuHxpiy+i328EMvRANtV5t5ZpkodI
        5T3bYI6QPFYX/hEbtaWxnQI9UsvoYVP/a7+c/hEdOpVCN6IU3coUGXIn/M6I6d5l
        0dEI8A8iM4s7nwK/Limoupy6AkCyl9m5PQRCPbZi11k8FhbmazYJ1xtxsXRePRDL
        vI+XO/gYmCs0JsA0iDDUFMaljAvTNx6bDov5NtWbP2ar+LSdjwExBcCICbWOfPvA
        bDsa07bSRBUkyGU3bB6ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655398373; x=
        1655484773; bh=ChMk74/j0zVwr8vQ+6minyBzfKd5EePCKVmqXuE7mzQ=; b=O
        TNYFbhQse2naCsjTEeauyEn5kFf74Ld//pXT5gU8C2HyfEkOHq6Kq9qbVsn2MV81
        4YCD3sTsYrwcmUAi5azpBt0iIQ9oir6fd7nYcwsZdLiKAQagTnH52AdZsuffQ/7M
        V4vGKkZO6kfa5ZAqwTtpHuK2zC4sL8hT0VxEp22xXdF/Isncxh7WTQ3AlXqXM4PG
        Ok/RsS/yLxOTV3VWKtgQbCP32bew3mXVjLCWNdyMYktlcMz037KqbGOfQqXdE9tP
        o9tGwp7TM1StRRYFBdRmgMvWqY4ZGKB46hBWCnPRGSl1rFhkjrW2DN6REH5eOMTm
        iz72udfjlXbPgeut8J/iQ==
X-ME-Sender: <xms:5F-rYhOfttSyOthbsp0VNtReQu3qhCKRQbbzBZOzgMd5kOpa6tJVAw>
    <xme:5F-rYj_pJgwjlMtgXLjc_p4_Umy4zLxfhZc0mLWObcekhLnYKn_6plgd5TzgifYpP
    kBEN0u8Pr90HsdoZYo>
X-ME-Received: <xmr:5F-rYgRClMFCy8RbEbIqH58YdSvIcP1RX-8emE0ryB80lHMpQIx9IQ0CGeRC6qF1GH4C7b1tvDrKwRolAe7WAuMll7weFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrih
    hssegsuhhrrdhioh
X-ME-Proxy: <xmx:5V-rYtsfAzgbm1FldAT82F3KOmw3PwIcyeAmyonibyiWn-6fXbG01w>
    <xmx:5V-rYpcWGyw0wrVd-cMvzyWppjc3NZu7Ap77YjIyCz9lxceaylTJgg>
    <xmx:5V-rYp3k7mOB0Cvn9gCaTfMhqxDukUggQj6zpr9DDUZadYsBeQENzg>
    <xmx:5V-rYt5gIrWfyuvkhxrCoCO9rAx8niSH7WPMnciesJBHFlQhEcfigQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 12:52:52 -0400 (EDT)
Date:   Thu, 16 Jun 2022 09:53:36 -0700
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <YqtgEIABdQkWw0hQ@zen>
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
 <20220615133130.GY20633@twin.jikos.cz>
 <YqpQANRnbc4uBmjT@zen>
 <8020b3cf-ea57-fe85-1784-630e83bd558a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8020b3cf-ea57-fe85-1784-630e83bd558a@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 06:24:51PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.06.22 г. 0:32 ч., Boris Burkov wrote:
> > On Wed, Jun 15, 2022 at 03:31:30PM +0200, David Sterba wrote:
> > > On Wed, Jun 15, 2022 at 03:47:51PM +0300, Nikolay Borisov wrote:
> > > > > +
> > > > > +	return sysfs_emit(buf,
> > > > > +		"commits %llu\n"
> > > > > +		"last_commit_dur %llu ms\n"
> > > > > +		"max_commit_dur %llu ms\n"
> > > > > +		"total_commit_dur %llu ms\n",
> > > > > +		fs_info->commit_stats.commit_counter,
> > > > > +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
> > > > > +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
> > > > > +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
> > > > > +}
> > > > > +
> > > > > +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> > > > > +						struct kobj_attribute *a,
> > > > > +						const char *buf, size_t len)
> > > > > +{
> > > > 
> > > > Is there really value in being able to zero out the current stats?
> > > 
> > > I think it makes sense for the max commit time, one might want to track
> > > that for some workload and then reset. For the other it can go both
> > > ways, eg. a monitoring tool saves the stats completely and resets them.
> > > OTOH long term stats would be lost in case there's more than one
> > > application reading it.
> > 
> > As far as I can see, our options are roughly:
> > 1. separate files per stat, only max file has clear
> > 2. clear only max when clearing the joint file
> > 3. clear everything in the joint file (current patch)
> > 4. clear bitmap to control which fields to clear
> > 
> > 1 seems the clearest, but is sort of messy in terms of spamming lots of
> > files. There can be a "1b" variant which is one file with
> > count/total/last and a second file with max (rather than one each for all
> > four). 2 is a bit weird, just due to asymmetry. The "multiple separate
> > clearers" problem Dave came up with seems  serious for 3: it means if I
> > want to clear max and you want to clear total, we might make each other
> > lose data. 4 would work around that, but is an untuitive interface.
> > 
> > One other reason clearing total could be good is if we are counting in
> > nanoseconds, overflow becomes a non-trivial risk. For this reason, I
> > think I vote for 1 (separate files), but 2 (only clear max in a single
> > file) seems like a decent compromise. 4 feels overengineered, but is
> > kind of a souped-up version of 2.
> 
> 
> I don't know why but I like 2, even though when I think more about it it
> indeed introduces somewhat non-trivial asymmetry. But given that sysfs
> interfaces aren't considered ABI we can get it wrong the first time and we
> won't have to bother to support until the end of times.
> 
> A different POV would be that those stats would mostly be useful when doing
> measurements of a particular workload and in those cases you can reset the
> stats by remounting the fs, no ? From a monitoring POV I'd expect that the
> most interesting stats would be last_commit_dur as you can read it every x
> seconds, plot it and see how transaction latency varies over time. From such

My 2c: What's most useful for monitoring are total+count and max.

You have a process periodically read the total/count and get an average
over the collection interval, and it reads/clears the max to track the
max over the collection interval. From there it sends what it has
collected off to some DB to be stored/plotted/aggregated/whatever.

Our collection interval is typically 60s. I imagine if you collected
more frequently, your idea of tracking last duration would work a lot
better than in our setup.

With all that said, I think I agree that 2 is the best interface. I
think it also lets us get rid of the lock, since you no longer care
about racing setting the max with clearing it, since it is always
self-consistent.

> stats you can derive a max value, probably not THE max, but it should be
> within the ballpark. Total_commit and commit_counter - yeah, I dunno about
> those.
