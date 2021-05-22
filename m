Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC36738D28D
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 May 2021 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhEVA0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 20:26:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:32833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhEVA0O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 20:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621643088;
        bh=9q/jmWc+CzJueiTzfEH6R/vGIjOSWLTBaiBR1l8Rq6k=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=C9X0tnHCOOvYxZXDpvT1WHIvmtGN2moXFTDFdMPE60ikbyyehHepuzt3KNdX9nno1
         e8Kvc/ryyh7Tx6jpMRrInUVioVcRSu/J9VXWmfZTvKKgxLV4o2NeFTJQ7x6nfZvchZ
         h4F/OLuunoIbAsl864YH6cBDr/bQcvDt5+yelPtw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1l4dF916F6-00omXx; Sat, 22
 May 2021 02:24:47 +0200
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
Date:   Sat, 22 May 2021 08:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QwsHritMlPD0myRvkCwFENlnicl0E812Ld2C+Qcp51VD5cQ5yxL
 BJMF+6GAO8GV0AVS8DUDQX5hel9d2NoD6vg7D9hyAvWr2pY3hlocz/M2vKy6SiDx55n+IBm
 l0d4XAYqcjkbrIPD0e/45/aazV7k/XvvAw4yQsiolxn4GkUD69H0PdX2DpppkFuMIynY1Z9
 vij1BBB+/9RP7LbF8dbLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:he9POH9OOIs=:SeCqlv7dU3pJ54eaK9M5zJ
 RczToBdd8aoFFdAXx+kAA5aFkfD8R5WO7OQIi6E+WTRv8ECRHPo3R6LwcF13KSFIdss2MMikb
 gR4XdhLk0VqkZLkqWp0hv/LyU/SZlufgePb8hXGz4HnBF16k6JdhTiXxsk9eyiCvn/33X72/w
 8iiZnmJt23+6HyzCbw0vLjQMAH3KJD8VfXdmv5WUBuI8xnhHVboCr7R3aISF29ZTTGj5PuKpI
 mqyIRPModvwMuuWO41reemqPG+mJvdBagkU38NTSYaspFoRZLLTHssw+lW2/woa3g1eug6FYL
 QwGPabRkW7+yt7qqVuKJYndylzYURge0TcK8NmeIdJks5yXSxjf+WAy1FwbpVJfI5EhJwxV+v
 NmjNat0uk4p7bKgPQ9ZruOCI8M1N/6CfBAhsRhZIP8c6PRE9GAyoBSCLShc/MnRvNvfqRTnHw
 8vFTu4emAIrZ+/2NTz0uBdGV6ZcidOTZXJ2255KXplwBSAZOGaz44u8zX/wbbFLQSeD8yWpB3
 M3wZh02/6dultCqrnAK919PpTUMXYg1cg9DPK1muUXnDA9sRDqUMTRtXGngMqnc7aK8e+Lk3L
 pm9NVW1U/FiFru/3TpXmuuPDBpo3ndSonT40tpuRZ96+ScJQdV77JN59sd5z7iPfuP4QfKBhg
 3JPGQDqaD2MR190t9b0ksxi8KeLv0wpF2PAi2EX0Z9GKH0Tnkkj/FtLcZxx0sBR7T82E52o67
 2xkjNec/slefLW2QaTLIGRNYohcv2MoHgA8ORGTsXhTloUd/ocYAfPcUQXS7Hfmep359Qwsxz
 GswNyNfcgy58JEomqKCEx2eNkmkgKAxMs5RHEoL9u7mtz7guZHnzsm/MB3hbP7Y/zu97YKAWT
 FCwzz/mJpoghshLFOJgC3xYBku9IHo/vjRAmSlbZPYRTZK/j5ScIvE/3muHiwPCOeho3n0hOu
 6HEEmjQ8PbH5A3e/UTyWSf8dAmFyDRU8rEZkQrCdhMXtGM/OZB8oHY6uKI/tPJFEHAoCOOR/y
 e2WhQPnfZ0cW2apiIyQRVPtQ22iO8n/EbR4PsI5zYCEpvnbgS+xUDdbt4mHQX6MFeWtrW/24M
 z8E9gRCCu/l8Pi4UrOzYN6ezZh/1YEr+ZpG3R3LHHlxMTKnfLoo0z+FIQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/21 =E4=B8=8B=E5=8D=8810:27, Josef Bacik wrote:
> On 4/27/21 7:03 PM, Qu Wenruo wrote:
>> There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() i=
n
>> end_compressed_bio_write().
>>
>> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
>> which is only supposed to accept inode pages.
>>
>> Thankfully the important info here is the inode, so let's pass
>> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
>> make @page parameter optional.
>>
>> By this, end_compressed_bio_write() can happily pass page=3DNULL while
>> still get everything done properly.
>>
>> Also, to cooperate with such modification, replace @page parameter for
>> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
>> Although this removes page_index info, the existing start/len should be
>> enough for most usage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This was merged into misc-next yesterday it looks like, and it's caused
> both of my VM's that do compression variations to panic on different
> tests, one on btrfs/011 and one on btrfs/027.=C2=A0 I bisected it to thi=
s
> patch, I'm not sure what's wrong with it but it needs to be dropped from
> misc-next until it gets fixed otherwise it'll keep killing the overnight
> xfstests runs.=C2=A0 Thanks,

Any dying message to share?

I just tried with "-o compress" mount option for btrfs/011 and
btrfs/027, none of them crashed on my local branch (full subpage RW branch=
).

Maybe it's some dependency missing or later subpage fixes needed?

Thanks,
Qu

>
> Josef
