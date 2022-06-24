Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAB559892
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFXLcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXLca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 07:32:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FAB56756
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 04:32:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 831891F8D1;
        Fri, 24 Jun 2022 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656070348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiQQlTd/4A1uFmTw8jkaPJu2zf2H+UCf7nwUIqSspHI=;
        b=vDcTa0wEvq6kiDcQjJisxX3fMncLkaBdz0BmZt4tR5oh06k+Pbc3PeiIKODHhUrU1luwVZ
        6FCV8eqIPnlPZ88ZyfOjWITcowT0wInX7kA4gyBsFbuvZYCbb6HwnGAExwmA9SZRa6VatM
        zQA6Veg0bglyriRs5HPmw1i8M4HQqew=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BCB113480;
        Fri, 24 Jun 2022 11:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +QRUD8ygtWIpRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 24 Jun 2022 11:32:28 +0000
Message-ID: <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
Date:   Fri, 24 Jun 2022 14:32:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.06.22 г. 11:13 ч., Qu Wenruo wrote:
> 
> I don't think that's the correct way to go.
> 
> In fact, I think sysfs should have everything, no matter how long
> supported it is.


I disagree, for things which are considered stand alone features - yes. 
Like free space tree 2, but for something like backrefs, heck I think 
we've even removed code which predates mixed backrefs so I'm not 
entirely use the filesystem can function with that feature turned off, 
actually it's not possible to create a non-mixedbackref file system 
since this behavior is hard-coded in btrfs-progs. Also the commit for 
the backrefs states:


This commit introduces a new kind of back reference for btrfs metadata.
Once a filesystem has been mounted with this commit, IT WILL NO LONGER
BE MOUNTABLE BY OLDER KERNELS.

