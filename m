Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F764AC7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 01:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLMAcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiLMAbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 19:31:42 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 16:31:37 PST
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7DBF8
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 16:31:37 -0800 (PST)
Received: from static.bllue.org ([66.108.6.151])
        by cmsmtp with ESMTP
        id 4tBNpKeHArbj64tBOpnQoq; Tue, 13 Dec 2022 00:30:06 +0000
X-Authority-Analysis: v=2.4 cv=F/VEy4tN c=1 sm=1 tr=0 ts=6397c78e
 a=M990Q3uoC/f4+l9HizUSNg==:117 a=M990Q3uoC/f4+l9HizUSNg==:17
 a=kj9zAlcOel0A:10 a=sHyYjHe8cH0A:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=fFR_FZu6_Hu_ziwcHFsA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=WzC6qhA0u3u7Ye7llzcV:22
Received: from localhost (localhost.localdomain [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by static.bllue.org (Postfix) with ESMTPS id 018C440009B;
        Mon, 12 Dec 2022 19:30:04 -0500 (EST)
Date:   Mon, 12 Dec 2022 19:30:03 -0500 (EST)
From:   kenneth topp <toppk@bllue.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
cc:     Joakim <ahoj79@gmail.com>, wqu@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: Speed up mount time?
In-Reply-To: <e1eac218-bc97-0f62-4be8-b81c37b76296@gmx.com>
Message-ID: <cdb1aee2-c004-93b5-eed3-f46ff12ec378@bllue.org>
References: <376af265-a7c4-6897-b6fe-834d225b150f@suse.com> <20221125085538.280-1-ahoj79@gmail.com> <e1eac218-bc97-0f62-4be8-b81c37b76296@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-CMAE-Envelope: MS4xfLZcCs92XMhdWSxVj+Mh+3L3vyrhBJDfLkXgG5PBQQnNRSm+GOjpz5XtRXyIJiljF69AcYYFIEeV+1cUc54K0Jq4ru23ZaA0BJs5u7eCS+EXL2qqlsLY
 mO3vCwNwEwpjanPF4Nwz12ycehTfktr0ykAwtDYMMzqmG5WSqYx4wILICqQcqwGz9rNDylkkWDqaOeoxTsSs1ErkFfTGNX9WFmB0wkR60/4HBxBeJrjQBtFH
 b/DAmttsykxtOSaYgeiydyEYzLWPZEUuaii+0yyVbrc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On Fri, 25 Nov 2022, Qu Wenruo wrote:

>
>
> On 2022/11/25 16:55, Joakim wrote:
>>  That sounds great! Is there any rough ETA for when that might be released?
>>  Thanks! :)
>
> As mentioned, if nothing wrong happened, v6.2 would be the target for the 
> kernel.

Am I mistaken this was actually inside v6.1 and not 6.2?

https://lore.kernel.org/lkml/cover.1664798047.git.dsterba@suse.com/

I'm eager to give this a shot if it is, as 6.1 was just tagged.

Ken

>
> For progs, it should already be implemented in btrfstune from the latest 
> btrfs-progs.
>
> But only one-way conversion is supported (aka, regular -> bg tree), no way to 
> convert back yet.
>
> If your distro doesn't ship newer kernel/progs, it may take much longer 
> though.
>
> Thanks,
> Qu
>
>
