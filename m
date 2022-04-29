Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1E514E07
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377811AbiD2Oti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377894AbiD2OtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:49:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BD8232B
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:46:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7896921877;
        Fri, 29 Apr 2022 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651243559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYSeQqDcOggoJGSGhEvg+/JuCnB8qk1uELRmzMX1IMk=;
        b=bPA0IaxIoCuFjUa6doazfuYKK9GV+81QZ84cGxu9b2muQyce6KUmLJ/l715wRbAeD/5hlF
        UQgwLLcJK6y3fNn9Yj7bouuINjhjOPXlxZYG0b2ZduPso3/WC4wEL+gEFa+u7vzMaAhoz1
        nFKh65QlnfznZrlsOvhgRcwvDSPo0Qo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4ACB613AE0;
        Fri, 29 Apr 2022 14:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J8mbDyf6a2KnHQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 29 Apr 2022 14:45:59 +0000
Message-ID: <be21d358-754a-3db4-df45-561258f47af4@suse.com>
Date:   Fri, 29 Apr 2022 17:45:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Remove unnecessary inode_need_compress() check
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
References: <20220428200735.j3yxdpi6fgdptsph@fiona>
 <20220429144147.xhfiqj27whufoyvt@fiona>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220429144147.xhfiqj27whufoyvt@fiona>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.04.22 г. 17:41 ч., Goldwyn Rodrigues wrote:
> Apparently, BTRFS_INODE_NOCOMPRESS can change runtime, so this patch is
> incorrect. Sorry.
> 

Yes, when doing writes on compressed-enabled filesystem if a particular 
file gets bad compression ratio that flag is getting set from 
compress_file_range:


   /* flag the file so we don't compress in the future */
      32                 if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && 

      31                     !(BTRFS_I(inode)->prop_compress)) { 

      30                         BTRFS_I(inode)->flags |= 
BTRFS_INODE_NOCOMPRESS;
      29                 }
