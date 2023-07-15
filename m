Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925B7545A8
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 02:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGOAjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOAjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 20:39:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1153A8B
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689381588; x=1689986388; i=quwenruo.btrfs@gmx.com;
 bh=4RggosHnGxDhmdun4xRakZrknZxwGQsS5/jOr6QHUmY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=BRq7BO9EGktNu26vq9pzQZNPUC5w3p0yuII9gxXYVErkwNcrrP37LZ/cCMwp5HzE431UJlO
 +0Iq7Landu7u/XZeTwdkWjrgcaOwzMQHswxjGw02DVd3wvslKcJeE9/iXUCpRFNHGH1sFCHsG
 mPnPmhT4wkrDMa1h9+zo9wEHKvhsM5r2uuley5ErBaR0gBd+Cvyx9bEGze3iIWDFa66GiFe75
 mqJ6sC/W9logBHn+MNbr0Inxz3exQr39xLFj/nbDO1fd8HRF3/iI7DKC3EA0Hv28/RTHpLXZh
 BvGBejggwxwXp8TvXHyEamRspZSFkLpHlQVV7PkCRc/g++LLNaQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1q5PBJ21r0-00tidu; Sat, 15
 Jul 2023 02:39:48 +0200
Message-ID: <c98d4a3b-c43b-a867-ee07-cb8f1c149252@gmx.com>
Date:   Sat, 15 Jul 2023 08:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
 <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
 <20230714100349.GF20457@suse.cz>
 <3414dd0b-7b69-28d4-28c4-3405e9b8139f@gmx.com>
 <20230714104117.GG20457@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
In-Reply-To: <20230714104117.GG20457@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j4G+amFZASzF3rYz/czPRAER+HgtKHDF40KkuBcYvJMAZ2oDvEj
 7NMT6n56ZxDMz4G8/lpFyY0QTcNko02Td6wfUq4ExWRftiE//gXzufL0hfzmGQ0Gy4vq+LO
 5o6g5j03vWSjJIvPHfE7pTzLqEq90amLlXedvOlb7sSWoyt7niRXHYv3Gq12aS41NQPelGA
 /DuDKMnTDM+uK8kTL2hgQ==
UI-OutboundReport: notjunk:1;M01:P0:bnYrjD29GwU=;UaFIk8krGc74vL71wwP9J/NukBt
 jhMwEsbZGo6v83C0h30FfgIHE0ldcPXBoVYci/q7JTaNNlp1Vrvf6c0XQmitpOlsmFy7h1AUG
 dZOdHFDTNAzqgZhwRH4vmlSSKGvFQP+vfQAx3SMFnYB+xIS/hCGogTme9N1vUjudlut2quiX7
 LjnK3zbYAI6znjgIVGnsT3GhSBWMuVS6XXJMJybndXWXqRbkzsgvkT3wY8xEviCh6uE3CRE85
 R8lmxvNmuhgF/P+N6EQ+pJzybheROPkkOTFzt1wRxlBxx+wc3Y7vZtZ9vRHDbm5vPob5atId0
 Rcg9jbOc9NPDDc3dGzM1XfiXftGGZIk1ATjZ/1ZKZPXhPOiSBSRN+OgjFTVk8j1Vzbr1VtIvW
 GhUDZMA57Y13gI3MNfBN590wayablLXJzy97K7UMjCR3SnaWE4cmgDOnxEM/oJnGzhxqGdPl9
 I43NChoE/vY1Y10xSSlEoekttEzHh/+gkgUTsAjDjISPTDGRCLClB4n99L6uykAk5YJJJ9Txl
 JkmFGEdDlPGueKocotQayo8qmwoRpuYeuV1fOstdZnmHNxdb7Ay+RFeARqQxrV3lE/hNWiW7D
 jaglTlZ+h2cmWXUo/oQcmdVGEX1zyCdmvctBIs9zkCWD5si8WellSTLr0GvmYHE1IPcU12g8V
 ae9HMWYgt5kBDksn/tAqYe08lhySyZP2x6TfFdPAKgfJsU9rqy8MZK4H4JDGxuFUwgibfrGS4
 FDZeTA8dXrkctlmjYWp5shNfkvTCMEmot6yS/wTCk9nYbgNv8GHGALrljmxwm9K7zv/ftnmzE
 ve7HB5rvUqsZ9YQq7mi+DdP8UuhLTbYK3VY2iIPrhaANnxB10Wa8wxObqUGfdgzyEBLj7WyAx
 NxLDM+CGgCHHdmWDfirRKCzx6Z+EMtam1afoSm1RM/ahiEK2LktYeUZplqT9N4tsDa7N3YxvF
 cNZUR5nLDY4y62TGqRh1CVEl97k=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 18:41, David Sterba wrote:
> On Fri, Jul 14, 2023 at 06:32:27PM +0800, Qu Wenruo wrote:
>>>> Already running the auto group with that branch, and no explosion so =
far
>>>> (btrfs/004 failed to mount with -o atime though).
>>>>
>>>> Any extra setup needed to trigger the failure?
>>>
>>> I'm not aware of anything different than usual. Patches applied to git=
,
>>> built, updated VM and started. I had another branch built and tested a=
nd
>>> it finished the fstests. I can at least bisect which patch does it.
>>
>> A bisection would be very appreciated.
>>
>> Although I guess it should be the memcpy_extent_buffer() patch, I didn'=
t
>> see something obvious right now...
>
> 5ebf7593abb81ec1993f31e90a7573b75aff4db4 is the first bad commit
> btrfs: refactor main loop in memcpy_extent_buffer()

Anything special on the system that you can reproduce the bug?

I checked the overall code, it's a little different than the original
behavior.

The original behavior has double limits on the cross-page case, while
the new code only handles the cross-page on the source, and let
write_extent_buffer() to handle the cross-page situation on the destinatio=
n.

Considering memcpy() is called for memmove() case, it can explain the
corrupted tree block we see in your report.

Although I can not see the obvious problem, I guess there may be some
hidden corner cases that would be finally exposed if we move to
folio/vmallocated memory eventually.

If I can reproduce it locally the turnover time can be reduced greatly.

Thanks,
Qu
>
> $ git bisect log
> # bad: [5c6c140622dd7107acb13da404f0c682f1f954a6] btrfs: copy all pages =
at once at the end of btrfs_clone_extent_buffer()
> # good: [72c15cf7e64769ca9273a825fff8495d99975c9c] btrfs: deprecate inte=
grity checker feature
> git bisect start 'ext/qu-eb-page-clanups-updated-broken' '72c15cf7e64769=
ca9273a825fff8495d99975c9c'
> # good: [85ab525a6a63c477b92099835d6b05eaebd4ad4b] btrfs: use write_exte=
nt_buffer() to implement write_extent_buffer_*id()
> git bisect good 85ab525a6a63c477b92099835d6b05eaebd4ad4b
> # bad: [cd6668ef43a224b3f8130b78f4e3b922a7175a05] btrfs: refactor main l=
oop in copy_extent_buffer_full()
> git bisect bad cd6668ef43a224b3f8130b78f4e3b922a7175a05
> # bad: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: refactor main l=
oop in memcpy_extent_buffer()
> git bisect bad 5ebf7593abb81ec1993f31e90a7573b75aff4db4
> # first bad commit: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: re=
factor main loop in memcpy_extent_buffer()
