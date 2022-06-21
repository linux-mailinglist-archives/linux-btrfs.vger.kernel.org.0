Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4C5534F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiFUOul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352152AbiFUOuR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 10:50:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF996286C7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 07:50:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75BC321A86;
        Tue, 21 Jun 2022 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655823011;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KVTAuVSv3N0yn6zub5nYQ099Dq3H36AYBTF8CrgPnw=;
        b=EhjPueyVVPw8tEve1ksBvhGJmQXWfaASfBVyvXQoVW0hzRjKA6Cgk0K3Bl7iP0d5eYFVeG
        rHXc4doeBVJ2LXip/m/o3tbq3FOI8aYH/2toh+mE4Lh1Q5uHu7PZrzm/MBs+9HN2TMrdTk
        G7boHbjseqsywoPAKfdhFeh7ZqlQwIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655823011;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KVTAuVSv3N0yn6zub5nYQ099Dq3H36AYBTF8CrgPnw=;
        b=orSyLmcE2uMyTMhJ/BOMHpe47H4z23c0XiQATTWBpyferc/mAtwDLT8BTkC/C2ZN23MLMh
        +v0ImaRvgJHn3FCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D7C813638;
        Tue, 21 Jun 2022 14:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ruL1DaPasWKkWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Jun 2022 14:50:11 +0000
Date:   Tue, 21 Jun 2022 16:45:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     Boris Burkov <boris@bur.io>, Nikolay Borisov <nborisov@suse.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <20220621144534.GA20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        Boris Burkov <boris@bur.io>, Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
 <20220615133130.GY20633@twin.jikos.cz>
 <YqpQANRnbc4uBmjT@zen>
 <8020b3cf-ea57-fe85-1784-630e83bd558a@suse.com>
 <YqtgEIABdQkWw0hQ@zen>
 <e080497a-604e-e537-34d0-fc24bd443f80@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e080497a-604e-e537-34d0-fc24bd443f80@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 08:37:57PM +0000, Ioannis Angelakopoulos wrote:
> On 6/16/22 9:53 AM, Boris Burkov wrote:
> > On Thu, Jun 16, 2022 at 06:24:51PM +0300, Nikolay Borisov wrote:
> >>
> >>
> >> On 16.06.22 г. 0:32 ч., Boris Burkov wrote:
> >>> On Wed, Jun 15, 2022 at 03:31:30PM +0200, David Sterba wrote:
> >>>> On Wed, Jun 15, 2022 at 03:47:51PM +0300, Nikolay Borisov wrote:
> >>>>>> +
> >>>>>> +	return sysfs_emit(buf,
> >>>>>> +		"commits %llu\n"
> >>>>>> +		"last_commit_dur %llu ms\n"
> >>>>>> +		"max_commit_dur %llu ms\n"
> >>>>>> +		"total_commit_dur %llu ms\n",
> >>>>>> +		fs_info->commit_stats.commit_counter,
> >>>>>> +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
> >>>>>> +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
> >>>>>> +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> >>>>>> +						struct kobj_attribute *a,
> >>>>>> +						const char *buf, size_t len)
> >>>>>> +{
> >>>>>
> >>>>> Is there really value in being able to zero out the current stats?
> >>>>
> >>>> I think it makes sense for the max commit time, one might want to track
> >>>> that for some workload and then reset. For the other it can go both
> >>>> ways, eg. a monitoring tool saves the stats completely and resets them.
> >>>> OTOH long term stats would be lost in case there's more than one
> >>>> application reading it.
> >>>
> >>> As far as I can see, our options are roughly:
> >>> 1. separate files per stat, only max file has clear
> >>> 2. clear only max when clearing the joint file
> >>> 3. clear everything in the joint file (current patch)
> >>> 4. clear bitmap to control which fields to clear
> >>>
> >>> 1 seems the clearest, but is sort of messy in terms of spamming lots of
> >>> files. There can be a "1b" variant which is one file with
> >>> count/total/last and a second file with max (rather than one each for all
> >>> four). 2 is a bit weird, just due to asymmetry. The "multiple separate
> >>> clearers" problem Dave came up with seems  serious for 3: it means if I
> >>> want to clear max and you want to clear total, we might make each other
> >>> lose data. 4 would work around that, but is an untuitive interface.
> >>>
> >>> One other reason clearing total could be good is if we are counting in
> >>> nanoseconds, overflow becomes a non-trivial risk. For this reason, I
> >>> think I vote for 1 (separate files), but 2 (only clear max in a single
> >>> file) seems like a decent compromise. 4 feels overengineered, but is
> >>> kind of a souped-up version of 2.
> >>
> >>
> >> I don't know why but I like 2, even though when I think more about it it
> >> indeed introduces somewhat non-trivial asymmetry. But given that sysfs
> >> interfaces aren't considered ABI we can get it wrong the first time and we
> >> won't have to bother to support until the end of times.
> >>
> >> A different POV would be that those stats would mostly be useful when doing
> >> measurements of a particular workload and in those cases you can reset the
> >> stats by remounting the fs, no ? From a monitoring POV I'd expect that the
> >> most interesting stats would be last_commit_dur as you can read it every x
> >> seconds, plot it and see how transaction latency varies over time. From such
> > 
> > My 2c: What's most useful for monitoring are total+count and max.
> > 
> > You have a process periodically read the total/count and get an average
> > over the collection interval, and it reads/clears the max to track the
> > max over the collection interval. From there it sends what it has
> > collected off to some DB to be stored/plotted/aggregated/whatever.
> > 
> > Our collection interval is typically 60s. I imagine if you collected
> > more frequently, your idea of tracking last duration would work a lot
> > better than in our setup.
> > 
> > With all that said, I think I agree that 2 is the best interface. I
> > think it also lets us get rid of the lock, since you no longer care
> > about racing setting the max with clearing it, since it is always
> > self-consistent.
> 
> Just to make sure, do we proceed with option 2? That is, clearing only 
> the max and getting rid of the lock?

I agree that 2 is reasonable. Clearing all values does not seem very
useful as it would lose information, clearing just the maximum resets a
cumulative value and suites long sampling period, while for more fine
granied monitoring the other values can be used.

If there's a use case that can't work with current values and clearning
semantics we can revisit that, but I'd like to hear about first.
