Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBB54D3CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbiFOVc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiFOVcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 17:32:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C273562DB
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 14:32:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EBDB5C00B5;
        Wed, 15 Jun 2022 17:32:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Jun 2022 17:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655328738; x=1655415138; bh=NIgkZbqnwb
        f54uyIP8aM29SyQJI7Udr2j2bW9qEecL0=; b=iPOBTje873Wz3RE4lZILFLu/Jo
        /fv2Ubjc9UyqwA214ZfMz89plwhCaTC/RWPoybUhhUhrTewaRYm/RWhRO6lQ6QL1
        x0ppuSIu/rDoIuFo//42RbZm9juOVUlUhRdKuzki2EKn4wNA/4dhryaY+pEhSQ2i
        JIXjvLKj8eVI1OxnTd9wP2vRaRcNlu/zwGQ2ZjSZM+nyKJYWfyMwABfvwrDBYeQU
        v81AEMjiCUJ7rsB2K+lDvQiSmO49vhcWYOuxXcT1f0I0pzsIU1kA/YJXmtDcpHFo
        cvcvWYUSmYbxBC6tG3TjW1jGsT2qWGJKDtM3YExkwIOqCnYHWm6bnwGksrlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655328738; x=1655415138; bh=NIgkZbqnwbf54uyIP8aM29SyQJI7
        Udr2j2bW9qEecL0=; b=Qp8qit6dcmPxFc/7shJUJdsgDsfRteitfAVhOFZUF7h+
        IInaj5T3+2SRLj0I2dtPNbqno/fQDkt0Qz9kGyCPMP19Rm9cZ7mi0qB4vzQExByS
        +ZO2gAjFlp+N243nrUWIuObEc2jhl8qdemJ4pD+ibKbW+plZidIBJzuvlyq/NJxz
        P00UC0GEdmU/Yyvh8EndbRbIlpO71PQA82FSCClYx+u3ZmNqD9ixV4xQ7sDeMQ1e
        ByYEkqgxH56p7C/pZgc6trHZd9/xMyjPwfMQCVhdg4p1SUHijGDlRVla9ITLG/Jz
        GPuo5DK3rX5sqVETHnXEMZfjRFx/h2uIdCNjPcqSeg==
X-ME-Sender: <xms:4k-qYp34sQJnuS3cKG6TE_TdordxMEBwCVE_XwD-Bdm3tQPevRz_5g>
    <xme:4k-qYgEF1qmtVKghn1Kk_ZL16WySbkya-yZmEAvKTXHSwf3ooKu_LTpFjQO1BcZVw
    8Oq1oOxVAgn7sNV6fk>
X-ME-Received: <xmr:4k-qYp5f6wr3yyy-PcuAvnec13wH2Sk6uC2cBaSNBEQDaAYnxxdleaynTACHxpIjN_81qe4mvN3nqYe4tBd01x6Jbiua_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehudevle
    ekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:4k-qYm0Wq4zlf1PAWAeAspKfm6fpwWvIQF_Rvnt-dLDxC_dtB3xBcg>
    <xmx:4k-qYsE-vgnvppfkn66w9Us74F66ZOMgkDPOVy2UO-9Vi00zZSOFdQ>
    <xmx:4k-qYn-6NMteRLmAlf0kqRgxjoPadJjcUs6_YWmEkiUBwZyJzJJQpQ>
    <xmx:4k-qYgBRpKywmmsmznC-98am695OTdC45J0zxGtqerMcIQzgR5WIXg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 17:32:17 -0400 (EDT)
Date:   Wed, 15 Jun 2022 14:32:48 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <YqpQANRnbc4uBmjT@zen>
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
 <20220615133130.GY20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615133130.GY20633@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 03:31:30PM +0200, David Sterba wrote:
> On Wed, Jun 15, 2022 at 03:47:51PM +0300, Nikolay Borisov wrote:
> > > +
> > > +	return sysfs_emit(buf,
> > > +		"commits %llu\n"
> > > +		"last_commit_dur %llu ms\n"
> > > +		"max_commit_dur %llu ms\n"
> > > +		"total_commit_dur %llu ms\n",
> > > +		fs_info->commit_stats.commit_counter,
> > > +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
> > > +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
> > > +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
> > > +}
> > > +
> > > +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> > > +						struct kobj_attribute *a,
> > > +						const char *buf, size_t len)
> > > +{
> > 
> > Is there really value in being able to zero out the current stats?
> 
> I think it makes sense for the max commit time, one might want to track
> that for some workload and then reset. For the other it can go both
> ways, eg. a monitoring tool saves the stats completely and resets them.
> OTOH long term stats would be lost in case there's more than one
> application reading it.

As far as I can see, our options are roughly:
1. separate files per stat, only max file has clear
2. clear only max when clearing the joint file
3. clear everything in the joint file (current patch)
4. clear bitmap to control which fields to clear

1 seems the clearest, but is sort of messy in terms of spamming lots of
files. There can be a "1b" variant which is one file with
count/total/last and a second file with max (rather than one each for all
four). 2 is a bit weird, just due to asymmetry. The "multiple separate
clearers" problem Dave came up with seems  serious for 3: it means if I
want to clear max and you want to clear total, we might make each other
lose data. 4 would work around that, but is an untuitive interface.

One other reason clearing total could be good is if we are counting in
nanoseconds, overflow becomes a non-trivial risk. For this reason, I
think I vote for 1 (separate files), but 2 (only clear max in a single
file) seems like a decent compromise. 4 feels overengineered, but is
kind of a souped-up version of 2.
