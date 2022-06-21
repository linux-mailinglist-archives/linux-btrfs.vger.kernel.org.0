Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C555392B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiFURtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiFURtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 13:49:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2962A1D33D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 10:49:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6C0D1F900;
        Tue, 21 Jun 2022 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655833750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGU40HpfcqPlpQqir9Q/DQ0Atz6alMNzYAcirpE9uf0=;
        b=LQNjEpKch5N8mwG9xBfPiLKBNeqYhQuTXAkW9EBxWHVD1UxbuT34nn3J0VIsjPfOXLBCzT
        qwLegqQmjm8YrqVG5CkJXJ0RYHeSgEyHZavgXvkCvM96vLIulL5rgy/dPsszLsXOLrsTz5
        cGAjtRlODq5R96sAVWf5b1Uv/a5JGI0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 868F413A88;
        Tue, 21 Jun 2022 17:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JjAKHpYEsmJIMQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Jun 2022 17:49:10 +0000
Message-ID: <3971f947-aeec-98c0-dca1-a90016f67dd5@suse.com>
Date:   Tue, 21 Jun 2022 20:49:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <20220619082821.2151052-1-hch@lst.de>
 <b633dedf-b322-2d8c-adfb-8ab88af5652e@suse.com>
 <20220621154653.GA10068@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220621154653.GA10068@lst.de>
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



On 21.06.22 г. 18:46 ч., Christoph Hellwig wrote:
> On Tue, Jun 21, 2022 at 06:19:19PM +0300, Nikolay Borisov wrote:
>>> +
>>> +	mirror = failrec->this_mirror;
>>> +	do {
>>> +		mirror = prev_mirror(failrec, mirror);
>>> +		repair_io_failure(fs_info, ino, start, failrec->len,
>>> +				  failrec->logical, page, pg_offset, mirror);
>>> +	} while (mirror != failrec->orig_mirror);
>>
>> But does this work as intended? Say we have a raid1c4 and we read from
>> mirror 3 which is bad, in this case failrec->orig_mirror = 3 and
>> ->this_mirror = 4. The read from mirror 4 returns good data and
>> clean_io_failure is called with mirror= 3 in which case only mirror 3 is
>> repaired (assume 1/2 were also bad we don't know it yet, because the
>> original bio request didn't submit to them based on the PID policy).
> 
> Yes.  Although that is what I intended as we don't want to read
> data we don't otherwise have to. Maybe it should state "all known bad
> mirrors" instead of "all mirrors".  I think if we want to check all
> mirror we need to defer to the scrub code.
> 

My point is won't this loop ever fix at most 1 mirror? Consider again 
raid1c4, where the 4th copy is the good one. First we read from 0 -> bad 
we submit io to mirror 1 (orig_mirror = 0, this_mirror=1). The same 
thing is repeated until we get to orig_mirror = 3, this_mirror =4. This 
time the repair would be completed and so for this_mirror = 4 we'll 
execute clean_io_failure in which case the do{} while() loop will only 
fix the bad copy for mirror 3.
