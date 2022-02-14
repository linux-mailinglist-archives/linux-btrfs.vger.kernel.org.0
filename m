Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776114B5DEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 23:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiBNWtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 17:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBNWtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 17:49:40 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E71693AB
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644878970; x=1676414970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i/rdLn0aNNvrbI20i8Hujfz9BI6XVk+VYOMzcvxP4w4=;
  b=bC2k2orPbqYtge70xWmKSJfz45rt2hQlwk1L6Oc/lSHFJqhNS4CrVt2K
   SvTWId3efeHfptxUuk+3ueR3AgaNrNhQ9lsgiik59+rLQRfXVQ3mRlTH4
   H7ExHPRdCh5+VsnplP4co4wMfWCWvbcp9GjFlfqP980t4PTpApu6cX4uP
   ZOJANPEvHzMX8DcHzlt63tV/F6iB2jDGqlrPkZ9UdI9zsqLQQ7n31HwYx
   sp3IuuinfVMbeUCqifFDzb0MpWOHc6PYW3dA66OcLQgu1vCCbYcdW83QE
   Heeds9yuylJmhh0NsGpN4Jb4x36nW1PukJlQNNAmXMJPtIrXGG1IFbtak
   w==;
X-IronPort-AV: E=Sophos;i="5.88,368,1635177600"; 
   d="scan'208";a="197722380"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 06:49:29 +0800
IronPort-SDR: rnEdnm8fMvRt6/n4yItDsPFIjU9c10RXDqNWbJl2tZE9PvIsg+dvG2AZtFykgi19+71RE04PkA
 G8TPfdEVil/DbYutPpu9Thi6lrfbQ0oDRQThtZFS8Zo3ui+dPs9fwReNRMfZ3FYaNZRNfgrwCF
 cCxV28ciDlaIzroy2YCSUMovfm1ai97RDifhCrk1pHE3JPnjY54pImwmfQwy5OV4jjFhtoX8eg
 SNAp7G07aNAW18Sv0o+VjTqHhcDalOxFEd03Tfb5EVwSJYkViaBRoEfiqSKB2oF3JqXXCcveJN
 DIBDH9BUHX3qVxlq8eGpZEd0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:22:21 -0800
IronPort-SDR: 2XNkSyD5TZJlblJv+SYhqO/9SfYg4Dr/gWi74c23ECUdPxhvm0HaiDiUpDvU1QRp70gnHlOCUG
 XWM2pGk7OUY5wuTUQwdZ04i9ZtVZmYqR3SNeyUCst3GpXtPMUuXdbid+RCAsWE9YV37eyZRKMt
 Oi18ati5/4mpXTP+qelHp4Lx5+w+Pcr+NF2kcPEu2kc3BSzxT6MJtIPXA7TfAFP/GQOppRIovZ
 WQIPoFALivP81sUzRpnBpAm4emSK7ZdJb9vDN5Ooy6qcLYCRnYODZ8lPVA7aklOSD9IL76Pvun
 it8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:49:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JyKCt4hDpz1SVnx
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 14:49:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644878970; x=1647470971; bh=i/rdLn0aNNvrbI20i8Hujfz9BI6XVk+VYOM
        zcvxP4w4=; b=KCy8Vhv4cmr56ziAiuRsFTwkKCUQmLJNMsKtuKsFe6M9Vf5e3Zz
        6yVcw74jv7MNiZD7qXOFU62IQBXb23g2hxC2uroCmAKOtgcuqDl64MYqRf6lUcud
        xe3Y0ECb1D+y6pLJlJpwU99M5KWm3D4QBCnTxGfjLVsLg/M9HpZx1U2FDt4WNLqk
        +kGHiWZ3NIVC2aZa3r9TnyRaW2VeuTi/whTlUXDZuNP0Bu9sWO/JOgFKciONrfut
        cvAcNBRukOXegTkq2uT4Cfk/lyLID+cRlBWHIjPvc+kV0NiH/QuWc8bAtW02g4Rt
        duwSsmuILC2uqcFRGBZSe93Fkh4/L3w9JoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xgD3cUhO5bjs for <linux-btrfs@vger.kernel.org>;
        Mon, 14 Feb 2022 14:49:30 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JyKCr74gzz1Rwrw;
        Mon, 14 Feb 2022 14:49:28 -0800 (PST)
Message-ID: <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
Date:   Tue, 15 Feb 2022 07:49:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <cover.1644469146.git.naohiro.aota@wdc.com>
 <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
 <20220214213531.GA2872883@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220214213531.GA2872883@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/15/22 06:35, Dave Chinner wrote:
> On Thu, Feb 10, 2022 at 02:59:04PM +0900, Naohiro Aota wrote:
>> Add an assert function sb_assert_write_started() to check if
>> sb_start_write() is properly called. It is used in the next commit.
>>
>> Also, add the assert functions for sb_start_pagefault() and
>> sb_start_intwrite().
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  include/linux/fs.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index bbf812ce89a8..5d5dc9a276d9 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>>  #define __sb_writers_release(sb, lev)	\
>>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>>  
>> +static inline void __sb_assert_write_started(struct super_block *sb, int level)
>> +{
>> +	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
>> +}
>> +
> 
> So this isn't an assert, it's a WARN_ON(). Asserts stop execution
> (i.e. kill the task) rather than just issue a warning, so let's not
> name a function that issues a warning "assert"...
> 
> Hence I'd much rather see this implemented as:
> 
> static inline bool __sb_write_held(struct super_block *sb, int level)
> {
> 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> }

Since this would be true when called in between __sb_start_write() and
__sb_end_write(), what about calling it __sb_write_started() ? That
disconnects from the fact that the implementation uses a sem.

> 
> i.e. named similar to __sb_start_write/__sb_end_write, with similar
> wrappers for pagefault/intwrite, and it just returns a bool status
> that lets the caller do what it wants with the status (warn, bug,
> etc).
> 
> Then in the code that needs to check if the right freeze levels are
> held simply need to do:
> 
> 	WARN_ON(!sb_write_held(sb));
> 
> in which case it's self documenting in the code that cares about
> this and it's also obvious to anyone debugging such a message where
> it came from and what constraint got violated...
> 
> Cheers,
> 
> Dave.


-- 
Damien Le Moal
Western Digital Research
