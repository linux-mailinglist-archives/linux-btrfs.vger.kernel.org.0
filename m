Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0276C895
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHBIpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjHBIph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 04:45:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810291982
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 01:45:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qR7U6-0005ov-52; Wed, 02 Aug 2023 10:45:34 +0200
Message-ID: <d838ecf5-82e2-044c-206d-cf57de7b4379@leemhuis.info>
Date:   Wed, 2 Aug 2023 10:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Content-Language: en-US, de-DE
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230731152223.4EFB.409509F4@e16-tech.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230731152223.4EFB.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690965936;44d14fdd;
X-HE-SMSGID: 1qR7U6-0005ov-52
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 31.07.23 09:22, Wang Yugui wrote:
> 
> I noticed a btrfs write-bandwidth performance regression of 6.5-rc4/rc3
> with the compare to btrfs 6.4.0
> 
> test case:
>   disk: NVMe PCIe3 SSD *4 
>   btrfs: -m raid -d raid0
>   fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30
>    -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4
>    -directory=/mnt/test
> 
> 6.5-rc4/rc3
> 	fio(-numjobs=4) WRITE: bw=1512MiB/s (1586MB/s)
> 	but ‘dd conv=fsync’ works well, 2.1 GiB/s.
> 
> 6.4.0
> 	fio(-numjobs=4) WRITE: bw=4147MiB/s (4349MB/s)
> 
> 'git bisect' between 6.4 and 6.5 is yet not done.
> 

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced da023618076
#regzbot title btrfs: write-bandwidth performance regression with NVMe raid0
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
