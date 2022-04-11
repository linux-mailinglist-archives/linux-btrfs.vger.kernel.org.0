Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18D4FB524
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiDKHoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 03:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbiDKHoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 03:44:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE83DA51
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 00:41:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD6351F388;
        Mon, 11 Apr 2022 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649662914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za54Qx8NYUxh38NSjHWYryjWJ8nAyuECQWPPDjgFWLg=;
        b=AnVBRwz9mlXfUG7PUOn9Ps9S4QoUBCGCnp7fc3y6ZAmJTDp+f5k0J+drdq+LDHS3DnZuGD
        RMDmuRCbPZ5FRBKOsZ05rWAMtt5scDyScF1rkZZpRoyVyQgo2XlK7GZ9epc/56j3DgI+gw
        Wqn6wNa4Wmu9k7v1ntUm2rNpTo41Awk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CDA513A93;
        Mon, 11 Apr 2022 07:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HDDCJMLbU2JTHAAAMHmgww
        (envelope-from <gniebler@suse.com>); Mon, 11 Apr 2022 07:41:54 +0000
Message-ID: <cff2bcc4-536f-3ea4-e835-109d3ad45da2@suse.com>
Date:   Mon, 11 Apr 2022 09:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/6] Turn delayed_nodes_tree into XArray and adjust usages
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20220407153855.21089-1-gniebler@suse.com>
 <20220407164414.GO15609@twin.jikos.cz>
From:   Gabriel Niebler <gniebler@suse.com>
In-Reply-To: <20220407164414.GO15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 07.04.22 um 18:44 schrieb David Sterba:
> On Thu, Apr 07, 2022 at 05:38:48PM +0200, Gabriel Niebler wrote:
>> [...]
>> This patchset converts `delayed_nodes_radix` into an XArray, renames it
>> accordingly and adjusts all usages of this object to the XArray API.
>> It survived a complete fstests run.
> 
> So it converts just one structure, it would be better do it in one
> patch otherwise it leaves the conversion half way and it's confusing to
> see xarray structure in the radix-tree API.

Yes, I figured that converting each structure separately is easier to 
achieve for me, since the changes in this patch set are done, but 
changes to other structures are not (yet).

As for splitting the changes, as I did: My thought was that it's easier 
to review this way, patch-by-patch and that the important thing is that 
the conversion be done by the end of the patch set. But I do see the 
point that - even in a patch set - each patch should stand on its own 
and that does leave the code in an inconsistent (albeit working) state. 
Folding it all into one commit is not a problem and I will do that for 
resubmission.

> 
>> Gabriel Niebler (6):
>>    Turn delayed_nodes_tree into delayed_nodes_xarray in btrfs_root
>>    btrfs_get_delayed_node: convert to using XArray API
>>    btrfs_get_or_create_delayed_node: convert to using XArray API
>>    __btrfs_release_delayed_node: convert to using XArray API
>>    btrfs_kill_all_delayed_nodes: convert to using XArray API
>>    __setup_root: convert to using XArray API for delayed_nodes_xarray
> 
> The subject(s) should start with "btrfs: ..."
> 

OK, will fix.

I will also take the suggestions from the response to patch 1/6 on board.

Best,
gabe
