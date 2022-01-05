Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215EC485AE8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 22:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbiAEVnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 16:43:41 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:46158 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244544AbiAEVni (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 16:43:38 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 5E4EnuJz406Tn5E4FnLsbO; Wed, 05 Jan 2022 22:43:35 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1641419015; bh=P96cIhbG+yUy/UDvVTqasfyc3ytasrHW+fCNk7e6DGE=;
        h=From;
        b=mhwhCoOhBZ52EfmPXt3nMBCxIiIrAwp33CEdtQYn4tf72DuQlzOhjSfPu6jePDZfu
         arAHNiVE03bb2VOoBL8Fy1w0snKVwLlJH+CiZ26RPYHVNO3nGAy9MNRWvv1wgkKIuH
         xmVolKyBuPdIZofh+FcAq+VthVWOuteUio+DPw1a2moTdOmLLVUQTOzutfp4KYMCay
         1de4cE7q5ydIMRIqhA68UeGzt0XmhgNgZtIQUlj71tU1oW3AdyQecOw+pG+A03thRv
         1avdi2vb5AAROtHEWzQaNNcWLWBoLEjpCAPwptmHH5FL67wUrxhWH0HD+JhmkcOKCX
         hZoto3+AAUYpg==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61d61107 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=EYor_02nzEGWgm6bjqIA:9 a=QEXdDO2ut3YA:10
Message-ID: <8ce2e0f0-b377-f894-372c-bee9be75fd44@inwind.it>
Date:   Wed, 5 Jan 2022 22:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to
 handle the link.
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
References: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
 <YdXaZP27ALM6KJ9G@zen> <d4132584-faef-713e-aa7f-542257de3cfd@libero.it>
 <YdXsD+oQ8Z3DNYtG@zen> <9a261326-716b-69b6-9e95-bd5e1942e6bd@inwind.it>
 <bbdea835-79ce-cebc-fadc-115d8bff7162@inwind.it>
In-Reply-To: <bbdea835-79ce-cebc-fadc-115d8bff7162@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCE7tqLqr1fVNqkrUadF+y9m7j0DNB9/jXlGrsbjDcsVhPL1rfdVEEWaC4hlUzlVjWNadOADMo6J0ew+NzdmVTXuy9j6bsKRurBF+blp0b0quSMl+n92
 sDsbijitRx9BP1RWykW6VESjAVk1J59l5STobZq/c2FyxqDpdvUtHD6Lf1/T9wX6yFd8yfEh+BKOS2FLHWhoRInA9jLSXSBJnz0MdbnDOVoHJ21/lz7DUue/
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/2022 21.14, Goffredo Baroncelli wrote:
> Hi all,
> On 05/01/2022 20.14, Goffredo Baroncelli wrote:
>> On 05/01/2022 20.05, Boris Burkov wrote:
>[...]
>> Hi Boris,
>>
>> you are right. I didn't consider that open(path) follows the symlink too.
>> So I will update the patch  changing statl() to stat() and removing the
>> 2nd stat invocation.
> 
> Only now I noticed that the code behind set/get_label works only with
> "regular" file or "block" device.
> This may be a more cleaner solution to avoid this kind of ambiguity.
> 

No, I was wrong again. The set/get_label code doesn't works so. You can pass a link, only it tries to interpreter the link as a link to mount point... which mess...

> Of course we can add exception where required.
> 
> BR
> G.Baroncelli
> 
>> BR
>> G.Baroncelli
>>
>>> Thanks,
>>> Boris
>>>
>>>>
>>>> BR
>>>> G.Baroncelli
>>>>
>>>> -- 
>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
>>
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
