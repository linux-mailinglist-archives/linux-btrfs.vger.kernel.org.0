Return-Path: <linux-btrfs+bounces-712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B580723B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 15:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D4B20F03
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253403EA60;
	Wed,  6 Dec 2023 14:22:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338161BD
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 06:22:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rAsn5-0002Jb-Pp; Wed, 06 Dec 2023 15:22:19 +0100
Message-ID: <149bf20e-538b-4051-9ee3-a9d98e09c3bd@leemhuis.info>
Date: Wed, 6 Dec 2023 15:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Wang Yugui <wangyugui@e16-tech.com>, Chris Mason <clm@meta.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
 Chris Mason <clm@fb.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230811222321.2AD2.409509F4@e16-tech.com>
 <20ab0be0-e7d0-632b-b94c-89d76911f1ed@meta.com>
 <20230813175032.AA17.409509F4@e16-tech.com>
 <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
In-Reply-To: <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701872542;fe37b2ff;
X-HE-SMSGID: 1rAsn5-0002Jb-Pp

On 29.08.23 11:45, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.08.23 11:50, Wang Yugui wrote:
>>> On 8/11/23 10:23 AM, Wang Yugui wrote:
>>>>> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
>>>>>>> And with only a revert of
>>>>>>>
>>>>>>> "btrfs: submit IO synchronously for fast checksum implementations"?
>>>>>> GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
>>>>>> checksum implementations") 
>>>>> Ok, so you have a case where the offload for the checksumming generation
>>>>> actually helps (by a lot).  Adding Chris to the Cc list as he was
>>>>> involved with this.
>>>>>
>>>>>>>> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>>>>> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>>>>>                 return false;
>>>>>>> This disables synchronous checksum calculation entirely for data I/O.
>>>>>> without this fix, data I/O checksum is always synchronous?
>>>>>> this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?
>>>>> It is never with the above patch.
>>>>>
>>>>>>> Also I'm curious if you see any differents for a non-RAID0 (i.e.
>>>>>>> single profile) workload.
>>>>>> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
>>>>>> case.
>>>>> How does it compare with and without the revert?  Can you add the numbers?
>>>
>>> Looking through the thread, you're comparing -m single -d single, but
>>> btrfs is still doing the raid.
>>>
>>> Sorry to keep asking for more runs, but these numbers are a surprise,
>>> and I probably won't have time today to reproduce before vacation next
>>> week (sadly, Christoph and I aren't going together).

FWIW, seems this thread died down and the underlying reason for the
regression despite quite a bit of effort from the developers wasn't
found. Haven't noticed any similar reports either. Reverting apparently
is not a option. So in the end this afaics remains unfixed. In an ideal
"no regressions" world this shouldn't happen, but well, we sadly don't
live in one. So I'll stop tracking this issue, it's not worth the effort:

#regzbot inconclusive: despite some efforts from the developers could
not be fixed
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

