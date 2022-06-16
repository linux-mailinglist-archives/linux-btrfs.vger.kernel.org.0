Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F154E5F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377326AbiFPPYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiFPPYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:24:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C12BB2F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:24:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 072591F8E0;
        Thu, 16 Jun 2022 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655393092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8+tCPeHCg4xq6RjzkNt15tRgXWhBdrhi/XpVQnN8Bw=;
        b=IUcvaUqyuzaeZjKua/v4/5dKcZhj/fkAiMkiHkrOk92aL5XE0JtLDtBc9S2VhIW6/r/Qyf
        UUwZJiP9At7gmJJJl+l5QGh/Kjp3aGwhPejtF41WD88O47XLnvtvpDrqQbtxCO6xe5h4wu
        l4YKB7jFUK+5Q5gIj1pefhBsC+xgElw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B05021344E;
        Thu, 16 Jun 2022 15:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ARBVKENLq2KPQgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 16 Jun 2022 15:24:51 +0000
Message-ID: <8020b3cf-ea57-fe85-1784-630e83bd558a@suse.com>
Date:   Thu, 16 Jun 2022 18:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, dsterba@suse.cz,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
 <20220615133130.GY20633@twin.jikos.cz> <YqpQANRnbc4uBmjT@zen>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <YqpQANRnbc4uBmjT@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.06.22 г. 0:32 ч., Boris Burkov wrote:
> On Wed, Jun 15, 2022 at 03:31:30PM +0200, David Sterba wrote:
>> On Wed, Jun 15, 2022 at 03:47:51PM +0300, Nikolay Borisov wrote:
>>>> +
>>>> +	return sysfs_emit(buf,
>>>> +		"commits %llu\n"
>>>> +		"last_commit_dur %llu ms\n"
>>>> +		"max_commit_dur %llu ms\n"
>>>> +		"total_commit_dur %llu ms\n",
>>>> +		fs_info->commit_stats.commit_counter,
>>>> +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
>>>> +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
>>>> +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
>>>> +}
>>>> +
>>>> +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
>>>> +						struct kobj_attribute *a,
>>>> +						const char *buf, size_t len)
>>>> +{
>>>
>>> Is there really value in being able to zero out the current stats?
>>
>> I think it makes sense for the max commit time, one might want to track
>> that for some workload and then reset. For the other it can go both
>> ways, eg. a monitoring tool saves the stats completely and resets them.
>> OTOH long term stats would be lost in case there's more than one
>> application reading it.
> 
> As far as I can see, our options are roughly:
> 1. separate files per stat, only max file has clear
> 2. clear only max when clearing the joint file
> 3. clear everything in the joint file (current patch)
> 4. clear bitmap to control which fields to clear
> 
> 1 seems the clearest, but is sort of messy in terms of spamming lots of
> files. There can be a "1b" variant which is one file with
> count/total/last and a second file with max (rather than one each for all
> four). 2 is a bit weird, just due to asymmetry. The "multiple separate
> clearers" problem Dave came up with seems  serious for 3: it means if I
> want to clear max and you want to clear total, we might make each other
> lose data. 4 would work around that, but is an untuitive interface.
> 
> One other reason clearing total could be good is if we are counting in
> nanoseconds, overflow becomes a non-trivial risk. For this reason, I
> think I vote for 1 (separate files), but 2 (only clear max in a single
> file) seems like a decent compromise. 4 feels overengineered, but is
> kind of a souped-up version of 2.


I don't know why but I like 2, even though when I think more about it it 
indeed introduces somewhat non-trivial asymmetry. But given that sysfs 
interfaces aren't considered ABI we can get it wrong the first time and 
we won't have to bother to support until the end of times.

A different POV would be that those stats would mostly be useful when 
doing measurements of a particular workload and in those cases you can 
reset the stats by remounting the fs, no ? From a monitoring POV I'd 
expect that the most interesting stats would be last_commit_dur as you 
can read it every x seconds, plot it and see how transaction latency 
varies over time. From such stats you can derive a max value, probably 
not THE max, but it should be within the ballpark. Total_commit and 
commit_counter - yeah, I dunno about those.
