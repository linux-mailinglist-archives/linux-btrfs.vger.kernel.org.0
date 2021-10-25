Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57177439C2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhJYRAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 13:00:39 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:57296 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234115AbhJYRAi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 13:00:38 -0400
Received: from [192.168.1.27] ([78.14.151.87])
        by smtp-34.iol.local with ESMTPA
        id f3IcmguD47YJJf3Icmhf9B; Mon, 25 Oct 2021 18:58:14 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1635181094; bh=MiE3hGHiISp2uf92VzwNEeROYEpDq1E/JLZWr+X1HIc=;
        h=From;
        b=qdxPP+WQnrfB1ppgOTfHYekyaxW44ivQFVOxPvvaL2pKdfi/BRXczK3ykivn2wF7R
         PCvs1MkdnhR7njDlb31t6tXglIKJT0EM+v3jxsrFx4/d2Tmk5+NDP2JFcTKXMTB7NA
         38xT+oQwQCc64SGtg0ianc7VSx7jbST7rzKrH2m78eQtghsw27gFRSfPeblLiPGVA5
         KKE76Tr2b3rwWif0ZA3j4OsMdd7Dy9U8hyU8/zCqMqPrCurl/JHN3+nRkwpJD3S9a+
         H4lTu7c6VpH1ykA2lPQSTlGPXZDZ+3333FcKtVcBE0NeGfWrwCtx+M+o/ylu9ysd3P
         Eunyjy2MDGLQw==
X-CNFS-Analysis: v=2.4 cv=dvYet3s4 c=1 sm=1 tr=0 ts=6176e226 cx=a_exe
 a=s8rBCFaCIOijKbcNVo+3rw==:117 a=s8rBCFaCIOijKbcNVo+3rw==:17
 a=IkcTkHD0fZMA:10 a=vG6p_kJgoRvhpRL86bQA:9 a=QEXdDO2ut3YA:10
Message-ID: <3bdd7604-e4a5-ddcf-67a1-b10c93619340@libero.it>
Date:   Mon, 25 Oct 2021 18:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: remove path_cat[3]_out() double declaration
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
 <20211025151305.GQ20319@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20211025151305.GQ20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMbdCiS7amqKuQQuRzX8eYyMFXU5AVJIRrSSnR5hLiDQED2ZIPETgYxJtMtC+5Q/kf0cJPYb0/uhlvMZEYsZYukR+EvkDgheU/7nBqoh17yIZJ1arVS2
 cRNHSYJ98aQKd4QrVn6X6CYMBBEyv/fxorG+QNe3X3oxb1WAZ7K/Pb7m81reGdfFD6/5Sqw3nLkQ7oVssw7Lh7whKGr7EyqsmBIY6sK1nAeV2KiMOz3+sS58
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 10/25/21 17:13, David Sterba wrote:
> On Sat, Oct 23, 2021 at 06:40:49PM +0200, Goffredo Baroncelli wrote:
>> Remove the double declaration of path_cat_out()/path_cat3_out()
>>
>> The functions
>>     - path_cat_out()
>>     - path_cat3_out()
>> are declared two times in the following header files:
>>     - common/path-utils.h
>>     - common/send-utils.h
>>
>> Remove the double declaration from send-utils.h and add the path-utils.h include file
>> where needed.
> 
> Thanks, but the prototypes have been removed a few weeks ago, in
> "btrfs-progs: remove unused prototypes from send-utils.h". You've
> probably developed this on top of master branch.
> 
Correct, I didn't check in devel...

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
