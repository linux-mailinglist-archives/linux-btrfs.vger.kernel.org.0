Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C0E4F4790
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbiDEVNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447311AbiDEPqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 11:46:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D5F92D30
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 07:21:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 640841F38D;
        Tue,  5 Apr 2022 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649168467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/HrSp+SiYmNHA34Q9Y3WX5pmJ5YbtfykkwGA+G8QiE=;
        b=MuAnClznHcgr17Q6od1TPk8o3yimUrsx4p4nHadPuzvHkpLqZPyPd3JE45nghY9kr+TD5f
        GZhzVGU3uc8sXxURurODYBv74iqLrtlx3k1r3SWAHqqG3gVCQphjgH/cxYnMd7mMOy83x+
        sB91slK2X02fGTHuL2O4rcejoDKV//g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E02D13A04;
        Tue,  5 Apr 2022 14:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mjF0BFNQTGJMTAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 05 Apr 2022 14:21:07 +0000
Message-ID: <85af4827-0a21-80d4-5d60-43e0e398a4e2@suse.com>
Date:   Tue, 5 Apr 2022 17:21:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] btrfs-progs: prop: add datacow inode property
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
References: <20220324042235.1483914-1-asmadeus@codewreck.org>
 <YkPuYyoV6LRWJdbS@codewreck.org>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <YkPuYyoV6LRWJdbS@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.03.22 г. 8:45 ч., Dominique Martinet wrote:
> 
> I appreciate it's a trifling feature, but I'd appreciate not having to
> teach our users about chattr if they could only have to manipulate btrfs
> properties so I'd appreciate some feedback!:)
> 
> If you just say 'no' I'll bite the bullet and install e2fsprogs just for
> btrfs and document the command, but as things stand my users (embedded
> device developpers) have no way of disabling cow for e.g. database
> workloads and that's not really good long-term.


Just my 2 cents: I think we should strive to rely as much as possible on 
the generic infrastructure where we can. The nocow options is one such 
case. The way I see it btrfs property is used to manage features which 
are indeed specific to btrfs and have no generic alternative.

What's more I don't see how 'chattr +C /some/path' can be considered 
'complex' to teach someone, plus chattr is a standard linux utility.
