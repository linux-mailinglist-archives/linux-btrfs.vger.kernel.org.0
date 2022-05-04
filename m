Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B646519A47
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbiEDIsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbiEDIs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 04:48:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73CA24599
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 01:44:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70C7C210E1;
        Wed,  4 May 2022 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651653892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxQIj1mS52lguZXytWr3S7l9DARjokiqDFSCyPMbYdY=;
        b=WxzPDJ9pE9EhIha0npFZ90w8QOk1d/kce+bVL5/n5EzK0xi8eTPfr00luvwwoBgTFHANP1
        ajTlFrZDholxKJzGI4EVVUaerkcOSnw7ZF8fAOJt5H5/+zZ5t+fGpsipRtd61qEJV7dPHr
        K+8X09OXDQYDR5Jv9efdEzphdq31utY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12316132C4;
        Wed,  4 May 2022 08:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mjGuAQQ9cmKkcwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 04 May 2022 08:44:52 +0000
Message-ID: <82030643-9b19-1422-6fed-dae04abad165@suse.com>
Date:   Wed, 4 May 2022 11:44:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [kbuild] Re: [PATCH 2/2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org
References: <202205041423.NVVJIHSj-lkp@intel.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <202205041423.NVVJIHSj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.05.22 г. 9:46 ч., Dan Carpenter wrote:
> Hi Nikolay,
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/Refactor-btrfs_ioctl_balance/20220503-163837
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  for-next
> config: i386-randconfig-m021-20220502 (https://download.01.org/0day-ci/archive/20220504/202205041423.NVVJIHSj-lkp@intel.com/config )
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> fs/btrfs/ioctl.c:4493 btrfs_ioctl_balance() error: double free of 'bargs'
> 
> vim +/bargs +4493 fs/btrfs/ioctl.c


Yep, a genuine braino, the fix is to remove either of the calls. I 
personally would go with the one before mnt_drop_write so that we drop 
the write ASAP but in the end I doubt it makes any practical difference. 
David care to fold this or shall I resend?

> 
> c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4484
> 0f89abf56abbd0 Christian Engelmayer 2015-10-21  4485  	kfree(bctl);
> ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4486  out_unlock:
> c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4487  	mutex_unlock(&fs_info->balance_mutex);
> ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4488  	if (need_unlock)
> c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4489  		btrfs_exclop_finish(fs_info);
> ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4490  out:
> c696e46e6ec2b3 Nikolay Borisov      2022-05-03  4491  	kfree(bargs);
>                                                                ^^^^^
> 
> e54bfa31044d60 Liu Bo               2012-06-29  4492  	mnt_drop_write_file(file);
> c746db1b6ed99f Nikolay Borisov      2022-03-30 @4493  	kfree(bargs);
>                                                                ^^^^^
> 
> Freed twice.
> 
> c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4494  	return ret;
> c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4495  }
> 
