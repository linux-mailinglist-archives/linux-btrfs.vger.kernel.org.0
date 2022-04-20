Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA3508196
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359548AbiDTHEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 03:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359533AbiDTHEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 03:04:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA6369D4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:01:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F83A1F380;
        Wed, 20 Apr 2022 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650438074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzBb8R0PjiWFyb5J+D6bpQNR03ucUpuM/Br3VqdiHJQ=;
        b=kROzwPzEkNq0sYzlRr1v/q1jzCLYlf/h5AxlxitAYsx4wB/gSsr7ndMTwVy/89rlMcOAV3
        9XBxfPZFNALnQpPJCwso/YOeCzt/q1tpbhYJ8crOSAYxfxbYv5GOW9yXVLYgy2bTzakxys
        odI4Q1It82ve5WK2I59kD1nkam9PzHc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DF5713A30;
        Wed, 20 Apr 2022 07:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NbtoALqvX2L4TwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Apr 2022 07:01:14 +0000
Message-ID: <17684f6b-2107-a617-8d90-272826d1c4d7@suse.com>
Date:   Wed, 20 Apr 2022 10:01:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Content-Language: en-US
To:     dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <20220419210551.65db356b@nvm> <20220419202310.GA1513@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220419202310.GA1513@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.04.22 г. 23:23 ч., David Sterba wrote:
> On Tue, Apr 19, 2022 at 09:05:51PM +0500, Roman Mamedov wrote:
>> On Tue, 19 Apr 2022 17:57:21 +0200
>> Gabriel Niebler <gniebler@suse.com> wrote:
>>
>>> -	btrfs_init_delayed_node(node, root, ino);
>>> +        do {
>>
>> The "do" line appears one character off to the right for me, and upon
>> examination that's because it uses spaces for indentation instead of TABs like
>> all other lines. Did not check if this is the only place.
> 
> Thanks for catching it, git am did not complain about that so I checked
> it manually, there was one more place, now fixed in my local copy.
> 


checkpatch actually found some other stuff as well:

ERROR:CODE_INDENT: code indent should use tabs where possible
#65: FILE: fs/btrfs/delayed-inode.c:131:
+        do {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#65: FILE: fs/btrfs/delayed-inode.c:131:
+        do {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#100: FILE: fs/btrfs/delayed-inode.c:151:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#100: FILE: fs/btrfs/delayed-inode.c:151:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#154: FILE: fs/btrfs/delayed-inode.c:1888:
+                        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#154: FILE: fs/btrfs/delayed-inode.c:1888:
+                        }$

