Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98277365199
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 06:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhDTEre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 00:47:34 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57330 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhDTErd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 00:47:33 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id AE7DA6C0078B;
        Tue, 20 Apr 2021 07:46:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1618893987; bh=GwqJYKE0VSzDtShTvx1A+7wcN8PQnufr7ew4EFuvTmw=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=Gxjo6+9E0CXF852ylMY0DXjT0smHBPAAoF+mYSNC90KFOhLa7vRxS0QlxGEOxKcGw
         5Y/2cjePQ/Uf49rFruGta8Nz2GiQP24CdPCEBguVpsdimDGhMAZVRgI3DT5iQxbDow
         XOnwGLGWPnc6JEdGZT0F4rWI4fFeZJyVeBy7mJ/M=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 8ECDC6C0077A;
        Tue, 20 Apr 2021 07:46:27 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 4bcHrgmATuIa; Tue, 20 Apr 2021 07:46:27 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id DFE5F6C00606;
        Tue, 20 Apr 2021 07:46:26 +0300 (EEST)
Received: from nas (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 90FC81BE00BD;
        Tue, 20 Apr 2021 07:46:24 +0300 (EEST)
References: <20210419130549.148685-1-l@damenly.su> <YH25FlnQ4nHg57bm@zen>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Boris Burkov <boris@bur.io>
Cc:     20210419124541.148269-1-l@damenly.su, linux-btrfs@vger.kernel.org,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v2] btrfs-progs: fi resize: fix false 0.00B sized output
Date:   Tue, 20 Apr 2021 12:20:44 +0800
Message-ID: <8s5da8cy.fsf@damenly.su>
In-reply-to: <YH25FlnQ4nHg57bm@zen>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVPp7o//vDsBBdmWXyNjCNe1YOUwzE7mEMLWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 20 Apr 2021 at 01:08, Boris Burkov <boris@bur.io> wrote:

> On Mon, Apr 19, 2021 at 09:05:49PM +0800, Su Yue wrote:
>> Resize to nums without sign prefix makes false output:
>>  btrfs fi resize 1:150g /srv/extra
>> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
>>
>> The resize operation would take effect though.
>>
>> Fix it by handling the case if mod is 0 in check_resize_args().
>>
>> Issue: #307
>> Reported-by: Chris Murphy <lists@colorremedies.com>
>> Signed-off-by: Su Yue <l@damenly.su>
>> ---
>>  cmds/filesystem.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> ---
>> Changelog:
>>     v2:
>>         Calculate u64 diff using max() and min().
>>         Calculate mod by comparing new and old size.
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 9e3cce687d6e..54d46470c53f 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -1158,6 +1158,16 @@ static int check_resize_args(const char 
>> *amount, const char *path) {
>>  		}
>>  		old_size = di_args[dev_idx].total_bytes;
>>
>> +		/* For target sizes without '+'/'-' sign prefix(e.g. 
>> 1:150g) */
>> +		if (mod == 0) {
>> +			new_size = diff;
>> +			diff = max(old_size, new_size) - min(old_size, 
>> new_size);
>> +			if (new_size > old_size)
>> +				mod = 1;
>> +			else if (new_size < old_size)
>> +				mod = -1;
>> +		}
>> +
>>  		if (mod < 0) {
>>  			if (diff > old_size) {
>>  				error("current size is %s which is smaller 
>>  than %s",
>
> This fix seems correct to me, but it feels a tiny bit 
> over-complicated.
> Personally, I think it would be cleaner to do something like:
>
> if (mod == 0) {
> 	new_size = diff;
> } else if (mod < 0) {
> 	// >0 check
> 	new_size = old_size - diff
> } else {
> 	// overflow check
> 	new_size = old_size + diff
> }
>
> At this point, new_size is set correctly in all cases and we can 
> do the
> print. I tested this version on some simple cases, and it seems 
> to work
> ok as well.
>
Right. The first fix when I saw the code was same with yours.
Now I relaized that I was over thinking about boundary checks and
falling through checks are meaningless if mod is 0.
Just to clarify that my fix is wrong:

       if (mod == 0) {
            new_size = diff;
           diff = max(old_size, new_size) - min(old_size, 
           new_size);
           if (new_size > old_size)
               mod = 1;
           else if (new_size < old_size)
               mod = -1;
       } /* falls through to check diff */

      if (mod < 0) {  // new_size < old_size, diff = old_size - 
      new_size
                     // so diff < new_size
           if (diff > old_size) // can't happen, if mod is 0 
           before.
                  ...
      } else if (mod > 0) {
        // new_size > old_size so diff = new_size(u64) - old_size,
           if (diff > ULLONG_MAX - old_size) // can't happen even 
           new_size is
                                             // ULLONG_MAX if mod 
                                             is 0 before
              ...
      }


Thanks for your suggestion, will send v3.
--
Su

> Thanks for the fix,
> Boris
>
>> --
>> 2.30.1
>>
