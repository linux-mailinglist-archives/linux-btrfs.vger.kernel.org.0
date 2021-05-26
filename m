Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14139232E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhEZX04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 19:26:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:59851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhEZX04 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 19:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622071517;
        bh=uO9KdzcP05dzGSIVo7eopkttgO1oNKMMQgYCg635plQ=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=BE/0JAbVtj73C8UsRpbGZXQiF8BpiNKa6nA0yWqs4HQLel03wqII9uZDvUUTxbE2X
         92mIfOr3Qv7XJB1OFaV6HMjDDVGhT4naa40qyI5fJKLVXGTF5ASIJjPou65JMfqi9N
         y8l4xdmdCma2RVTX1koPzkOjvD1j7tI5JvEMhX68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1lwAIT46xx-00YTx8; Thu, 27
 May 2021 01:25:17 +0200
To:     "Gervais, Francois" <FGervais@distech-controls.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
 <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
 <BYAPR01MB42641653D21CE9381EDB7CD6F3489@BYAPR01MB4264.prod.exchangelabs.com>
 <f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
 <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>
 <86123bb4-08d4-5de4-b8cb-b23677062468@gmx.com>
 <SN6PR01MB42691A820E13CB9CF356A690F3469@SN6PR01MB4269.prod.exchangelabs.com>
 <DM6PR01MB4265FD5C32D07B4A4D0D9CA8F3249@DM6PR01MB4265.prod.exchangelabs.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: read time tree block corruption detected
Message-ID: <5c50716e-450c-96c3-45a4-d97b48b3c144@gmx.com>
Date:   Thu, 27 May 2021 07:25:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM6PR01MB4265FD5C32D07B4A4D0D9CA8F3249@DM6PR01MB4265.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:crMoMWLIPAxJ94oaeaq6vaWfelml9sIwxZYhzqI/VlMTXPFkNYo
 BEf+oJrQIGmezBdb/og3HoEmL5qGEx/cNAy/Kx+tvfCXpGLg5u3wvDAXLK9b2aa04Y81q46
 Fbwc/vD/wjejN17Gh4lrHA3qEpsP2feURocjldIedGQ7N4CvHU4sOc/0IwK2L19SvCrCEbq
 GNW9JT/apgUk1Ln0FIouA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AUZe0kV4JgE=:e9aARTZmwWmP5eVjgLFAyi
 o8K8ql93M8ON67PKO0C8xpOw1dVmkfSZE5f24SYdGqT/Ixc/YHkc5/axnLsf4JK17UbpIRhmx
 ZoGzruwyd+K3pikqXVHZHAua2uWbbyd5bdIG7OM/BaVIRdEUFrnTeq9Al2qLlFvWIIOGVMbfL
 SdPnySAF9S4urBzETWmGyUPWYH3t8H9nE+asv6eHyf3YQ0sO/AMoye4JTG6DqXejDOkzB5zuK
 cGoMFgq2so/HDCv0u8lJ058sEzppKoc411KkHT40VR5oa9NgWHndXvBClho7xIx3iqqJo4+lL
 lqFG4vBtXu5JEVqJNuhEq45qLslecSjeNyQLMHl9vpkftD85TbVeFLdlKzdfnKsy9vu/RfSpi
 GFnE1P6QTLczZAwE6ebpuJPmwU3mobKPnYv+N6Hni/fj2BLruXFosQea0tmSO870pHq2Onv4U
 VWBqexKo1M5ufsd2witEddHVjXKZKIZ6+3QLrZHygrEdSwpZITbKZ6ENHyG2sDN1/0uAbr4eh
 tu37nkfv0BsvCIpBAtiO9uL81cChm1E/5nkGbe4+Vylm97GJ/kXGTPoUmj9MzmbhdcfeyGyXq
 UKwRSmThznpgYYMaJ1Avf1hjdsfCBcbpQA48ebLIqS+QrRXLn46mx4ZwMI+ptOoAeW4oYKOd3
 ptoxSUZcHGDsXChVYkBqAJmAdwIc0U3VtWMWJ428q1RwjkDxW0BikgMTnMMIt5DxOlmJ72mJ4
 ciQHevuaWihrTI2Hquf4Dr18Bj+WQBUp3UuuL8EZc1DN8n5BqfQyrApW9+A3meq9SKTxIk+R5
 uhhUEsEBMrhJLemz3v/WOj7lgMoCbAkojduQR68eXEjTRCpw4N1cAIFd4hdfdXThnl6sU5/xv
 Jz1mVQlAJyBaCCD5MLOCYDZ8pYIZfwXWZKlzfXOc5hko3dQqF5aVWRgoR2PyecRZMdxr8qiIm
 W63WlcylXQvF1otyY0GxiIfUnZkOY2gsfXyzC8tb7mR6gpdPaihLGm1fIjaTv5G9EbGN4l9z6
 N6qyBi7X8g5DzBOgFP+4+7suTaZtZvjQBMAmvENfhQtkvDRHT0F3fZh3EMqQ+4Vf0MRsKXTJq
 Zz9G3/QADMHiI7Wshv7QWR+36qKsFdwOyQDkvhD+xC2sMC+EGEXF8nRCUzw8yOVX/ukZeW58z
 dUQpw/SNF969pHO2qQGFtoUUTAgJQg60VsX2C3rY6niIuYZ96mYsJLhnm0Qh+3c+eP9DFNQbm
 lAyjKTvHNo13eepr8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/27 =E4=B8=8A=E5=8D=887:03, Gervais, Francois wrote:
> I had to re-send this message as I forgot to send it as plain text earli=
er today. I apologize if some people receive it twice.
>
>>>> - Anything you would recommend as of configuration of the device?
>>>
>>> You can test using dm-logwrites, which really logs every writes and
>>> replay it.
>>> By using dm-logwrites, you can emulate powerloss for each write operat=
ion.
>
> I'm in the process of putting together a test scenario using dm-log-writ=
es on our
> device but I have a few questions.
>
> 1. What I'm thinking of doing is do the firmware operation that the devi=
ce was
> doing when we got the corruption but this time using dm-log-writes and t=
hen
> replay the log entry per entry.
>
> Will tree-checker catch to issue just by replaying or do I need to do an=
 additional
> step for every log entry replay? (btrfs check? btrfs scrub?)

Normally we only care about the filesystem consistency at FUA/FLUSH.

Doing extra check at each replay won't hurt, but it would be very slow
though.

And for the tool to catch the problem, I'm afraid you have to use both
kernel tree-checker (aka mount it), and btrfs-check to catch all problems.

Tree-check can check all involved metadata, while btrfs-check doesn't
check log tree.

>
> 2. From what I understand, our corruption of the log-tree can either be =
software
> which would have requested a corrupted entry to be written to disk or ha=
rdware
> which would have corrupted the entry when trying to write it to disk.

I don't believe it's hardware, one point to notice is, all tree block
written back to disk has checksum.

If it's hardware problem leading to some data corruption on-disk, its
csum should not match at all.

Thus I believe this bug is mostly from btrfs.

Filipe is doing a lot of fixes related to log tree, and some of them are
related to item size overflow.
But if you can reproduce the problem reliably, then it would be a great
help to pin down the cause.

>
> Debugging with dm-log-writes would not catch a corruption by the hardwar=
e if due
> to a one-off glitch or something right?

Although I don't believe it's hardware problem, but just to be clear,
no, it won't detect any hardware problem.

Dm-log-writes is only to verify the filesystem layer is doing correct work=
.

Thanks,
Qu

>
>>>>     - Should we run a newer kernel than our current v5.4?
>>>
>>> Definitely. In fact my fuzzy memory points me to some fix, but I can't
>>> remember exactly which fix.
>>>
>>>>     - Any debug you think would be useful to enable or add?
>>>>
>>>
>>> Tree-checker, which is already enabled by default (in fact no way to
>>> disable) in newer kernels.
>>>
>>> Thanks,
>>> Qu
>>
>> Thank you very much,
>>
>> I will report here if/when we get more information on this issue.
