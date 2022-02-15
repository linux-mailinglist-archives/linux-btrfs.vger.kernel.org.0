Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE05D4B734A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiBOQHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 11:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiBOQHN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 11:07:13 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A53615A;
        Tue, 15 Feb 2022 08:07:02 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 4AAA3805DE;
        Tue, 15 Feb 2022 11:07:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1644941221; bh=ITdx6H4Vxkkt1psYEw6EmitYVmfA1N7Bq0NJMjPXVbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c4HMPAjbq9F1JsH/sS6OZSMR8Aa5gwb/rUTmkRyeIsGxcXdJgSAlYxBnavMzRk3Kt
         WjVSt7IRFjSy2cnIL8Nyv510FnAa6Ws3exMJrLfZM3ZUb1IfhPbzDIv5jqK+D9Mpo+
         3QrUwvr2Rcg5Lodgu6+qInG29z3ZqqrgsmhAGs9A1VZUI90zgEaWNU4lnCKydFjc+d
         84pORfyZQIZryZyICyw1TvYoLMuq1HAtha5NPyoP4/L9jB4MiGr4td16ewp87WNhsX
         kDq1c/WUHdMQUHH4BqvaFoaad6zp3CP50o1ahjr+zmpqBosi8cc+REXZa1858iEJBu
         xZJEE3HqcQckQ==
MIME-Version: 1.0
Date:   Tue, 15 Feb 2022 11:07:01 -0500
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: add fs state details to error messages.
In-Reply-To: <20220215150438.GN12643@twin.jikos.cz>
References: <20220212191042.94954-1-sweettea-kernel@dorminy.me>
 <20220215150438.GN12643@twin.jikos.cz>
Message-ID: <dc7bfe199bf22e67061a358e8e1f32b2@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +static void btrfs_state_to_string(const struct btrfs_fs_info *info, 
>> char *buf)
>> +{
>> +	unsigned long state = info->fs_state;
>> +	char *curr = buf;
>> +
>> +	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
>> +	curr += sizeof(STATE_STRING_PREFACE) - 1;
>> +
>> +	/* If more states are reported, update MAX_STATE_CHARS also */
>> +	if (test_and_clear_bit(BTRFS_FS_STATE_ERROR, &state))
> 
> The state is supposed to be sticky, so can't be cleared. Also as I read
> the suggested change, the "state: " should be visible for all messages
> that are printed after the filesystem state changes.

'state' is a local copy of info->fs_state, so clearing bits on the local 
copy should be okay, and the "state: " will be present for everything 
after the fs state changes. Could instead use test_bit(&info->fs_state) 
and keep a count of how many states were printed (to know if we need to 
reset the buffer) if that is clearer.
> 
>> +		*curr++ = 'E';
>> +
>> +	if (test_and_clear_bit(BTRFS_FS_STATE_TRANS_ABORTED, &state))
>> +		*curr++ = 'X';
>> +
>> +	/* If no states were printed, reset the buffer */
>> +	if (state == info->fs_state)
>> +		curr = buf;
>> +
>> +	*curr++ = '\0';
>> +}
>> +
>>  /*
>>   * Generally the error codes correspond to their respective errors, 
>> but there
>>   * are a few special cases.
>> @@ -128,6 +153,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info 
>> *fs_info, const char *function
>>  {
>>  	struct super_block *sb = fs_info->sb;
>>  #ifdef CONFIG_PRINTK
>> +	char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
>>  	const char *errstr;
>>  #endif
>> 
>> @@ -136,10 +162,11 @@ void __btrfs_handle_fs_error(struct 
>> btrfs_fs_info *fs_info, const char *function
>>  	 * under SB_RDONLY, then it is safe here.
>>  	 */
>>  	if (errno == -EROFS && sb_rdonly(sb))
>> -  		return;
>> +		return;
> 
> Unnecessary change.
Yeah, there's a stray space at the start of that line, but I can take 
out fixing it.
> 
>> 
>>  #ifdef CONFIG_PRINTK
>>  	errstr = btrfs_decode_error(errno);
>> +	btrfs_state_to_string(fs_info, statestr);
>>  	if (fmt) {
>>  		struct va_format vaf;
>>  		va_list args;
>> @@ -148,12 +175,12 @@ void __btrfs_handle_fs_error(struct 
>> btrfs_fs_info *fs_info, const char *function
>>  		vaf.fmt = fmt;
>>  		vaf.va = &args;
>> 
>> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s (%pV)\n",
>> -			sb->s_id, function, line, errno, errstr, &vaf);
>> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
>> +			sb->s_id, statestr, function, line, errno, errstr, &vaf);
> 
> Alternatively the state message can be built into the message itself so
> it does not require the extra array.
> 
> 
> 		pr_crit("btrfs: error(device %s%s%s%s) ...",
> 			sb->s_id,
> 			statebits ? ", state" : "",
> 			test_bit(FS_ERRROR) ? "E" : "",
> 			test_bit(TRANS_ABORT) ? "T" : "", ...);
> 
> This is the idea, final code can use some wrappers around the bit
> constatnts.
> 
> 
>>  		va_end(args);
>>  	} else {
>> -		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s\n",
>> -			sb->s_id, function, line, errno, errstr);
>> +		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
>> +			sb->s_id, statestr, function, line, errno, errstr);
> 
> Filling the temporary array makes sense as it's used twice, however I'm
> not sure if the 'else' branch is ever executed.
There are a bunch of calls with NULL format -> else branch, 
unfortunately.

Thanks!
