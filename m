Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F754C9EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiFONgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352588AbiFONgG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:36:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331736683
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:36:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 755271F461;
        Wed, 15 Jun 2022 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655300164;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBeoMukhFAUtEAI4zXnCLn6aRNY5je3oPVVqo27QLd8=;
        b=dPniwJLPoEspM+SMcuDhbwJ9VS8Xh8aQCkApacnU6+Oio0Xc4H2OULfF3y9ixHSJ00Yj5o
        iWAnDnH6D4UayVGutgyM6AIdKzLFODoFXMQngIDUzTl/m4nRVETZdtNKaSaMwGLn3ZfMkC
        ZO6AU3G7JCYoRTTeokc1pPnxL/5jtdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655300164;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBeoMukhFAUtEAI4zXnCLn6aRNY5je3oPVVqo27QLd8=;
        b=JgZFRcdHiLtOJqiwwcUWb5ihV09KwL2s1EnH6kBlo9DNWSKlZXuubOmvHrxTIk0q7S0tFd
        w0rCPRxVEFhcdSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D9C113A35;
        Wed, 15 Jun 2022 13:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eJZ/DUTgqWIJKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 13:36:04 +0000
Date:   Wed, 15 Jun 2022 15:31:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: Expose the BTRFS commit stats through sysfs
Message-ID: <20220615133130.GY20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220614222231.2582876-1-iangelak@fb.com>
 <20220614222231.2582876-3-iangelak@fb.com>
 <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <916ea0a3-d3a0-6c60-1307-7873438286e3@suse.com>
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

On Wed, Jun 15, 2022 at 03:47:51PM +0300, Nikolay Borisov wrote:
> > +
> > +	return sysfs_emit(buf,
> > +		"commits %llu\n"
> > +		"last_commit_dur %llu ms\n"
> > +		"max_commit_dur %llu ms\n"
> > +		"total_commit_dur %llu ms\n",
> > +		fs_info->commit_stats.commit_counter,
> > +		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
> > +		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
> > +		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
> > +}
> > +
> > +static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
> > +						struct kobj_attribute *a,
> > +						const char *buf, size_t len)
> > +{
> 
> Is there really value in being able to zero out the current stats?

I think it makes sense for the max commit time, one might want to track
that for some workload and then reset. For the other it can go both
ways, eg. a monitoring tool saves the stats completely and resets them.
OTOH long term stats would be lost in case there's more than one
application reading it.
