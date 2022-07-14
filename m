Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0E574F27
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiGNN2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGNN2a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:28:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AEFDE91
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:28:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8590C1FB26;
        Thu, 14 Jul 2022 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657805308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoZ7ZErLw81UxcX2LiU+RedNs6MTA3R8+qylecj2wJQ=;
        b=itoLFCCfzWQKjRvUhbUlSMbezjJ/+RXU8lL1hGu+AMYB5GLJUZo3y0Ys686WiovM2Yqa23
        /ZGaHRIk+MzZu45DIn1zI6eupr+HnUjmV7ObKZU/GcirjLoGHUHT+Ap3X83c70UGMcC4fr
        tvA7867aFAjn11Rmg67B8OKxE3925fs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46FEF13A61;
        Thu, 14 Jul 2022 13:28:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G9d9DvwZ0GK3GQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Jul 2022 13:28:28 +0000
Message-ID: <e49fe98c-d3be-73a1-00c0-980defe49b2a@suse.com>
Date:   Thu, 14 Jul 2022 16:28:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
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



On 13.07.22 г. 18:43 ч., Johannes Thumshirn wrote:
> On 08.07.22 22:10, Ioannis Angelakopoulos wrote:
>> +#define btrfs_might_wait_for_event(b, lock) \
>> +	do { \
>> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
>> +		rwsem_release(&b->lock##_map, _THIS_IP_); \
>> +	} while (0)
>> +
>> +#define btrfs_lockdep_acquire(b, lock) \
>> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
>> +
>> +#define btrfs_lockdep_release(b, lock) \
>> +	rwsem_release(&b->lock##_map, _THIS_IP_)
> 
> Shouldn't this be only defined for CONFIG_LOCKDEP=y and be
> stubbed out for CONFIG_LOCKDEP=n?


rwsem_acquire/rwsem_release is actually stubbed when lockdep is disabled 
i.e check lock_acquire/lock_release. So in effect this is not a problem.
