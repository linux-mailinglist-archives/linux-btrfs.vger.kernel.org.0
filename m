Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD36752E28
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjGNAJ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 20:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGNAJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 20:09:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F726AF
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689293360; x=1689898160; i=quwenruo.btrfs@gmx.com;
 bh=c7OpF8nBlnEPQYAYD8TwRRRS/pZVXYWUwe0StOXgQA0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CMiecDMTI0H09/rU9QTVdgJisMSesgyvw0gHIXXwuB40LmqwoC3OpOEmTgYPbdm79jDBhlI
 OMdmzumpHBFgyYW1FUKlkJKXNykIyG78Y39Fyb6fgYdwOnBG7HvyLYeMF2pvUqm+7E2/gT5+c
 J7QMriF0PYJcYZ0jSEz5FNk/D1GaFzzOKE2b8g8EgzYydZ2NsOKVc/4q6vjDLEe1wfP2DCSYD
 kAkcv5GywTewvVxyuyKH0Iw5SOuYJX4ZwvG5UBrHDssTW706CtOCgN3PHv61CCTiP5zVD/IaR
 x/BJKTuLjCTKuqaOhpXEvt7rGBDHlybd4VQeMXL9BhhBVLgFrvbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1q1KZH1ikG-00yh3m; Fri, 14
 Jul 2023 02:09:20 +0200
Message-ID: <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
Date:   Fri, 14 Jul 2023 08:09:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz> <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230713220311.GC20457@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:97fz2SQDwz6oL0o6ldr3uN/eKCb0nXNyueyae3ULBira+Yl29LE
 spLv3AAM6KiANBOk7aqaUuKYHvdU8DPQ+/Wia99JgKwUALoNOOJ+9EYkjykmDFoz/3MYrel
 ryJWxEA/gegVAUW39BxE0vogxLxto0uLYIB7LVTBDSll5KNxd1+Oh6Bwd2Pc1Cw7KBx+Tp+
 Ov7mvODFvO6ztKnj9NYUA==
UI-OutboundReport: notjunk:1;M01:P0:imR+UatT+Fs=;3YhupzpoZ57qu50U3+tHaVob6Gl
 mw7ypBvDLOltujfmaekRgzZ2xjDu7JxUYZfdMQQdGt+xt3WJ2XWt6auTojXYKl45yN/2jRFcw
 XfWeKfBw5RXUcaKI5v6neKkYBAGRRiDzM5Xx3z4U7TZd8UxaOomvbCqFAeE7BR3FIO6WnrGO4
 +W7kQo3nilzk/vaeJnV2JFJdEFBRfufP7xDpQ6VeSDmVT9i/dO9E0Kaot4TGlwB0eqelZrSFO
 uj8vUIKyIaRHNQtDfSr9opWk6cQy9HUS7bjhuCIkCG5Cy3FaqANg615yThlobh4Ue1kNm+DGE
 gEqHQ3dvqH0fqdMET5o1req4mOLyCt4CJYgyj2vKFU+v6P2/ArX6bwcnKJX1cICE7iWgeLH14
 qdM+aF3CWPl/JOjZv10I3XFuuY6gpyj9Ze1XojArs3P1iO3tFRtzXzdkLmdfpnj0EA5SRZPl9
 AHlMqDutadX+rIItAL0Z7i5g9d13kadY01hCd7A/m4D9y2G2DsBVMiTA16X1XdELKBmQkF7eE
 8HVjL+owUzvXEz2jAQM9CjGDf6nXo+IavpcnSw41ttbP8Fz9Rq+8ilJH8npiXUb+LxTkRR5R1
 YoeYlGmFfPBai3AmdfUalujUcYU3TclL5M3hp2EI7u9rjL41jQ+8TBQe/PtDYgAhaF19x7p7R
 KrIK6ZPICyKkclMT3wsxltSz1Rf7PsOo0dwq/1p28bE4mjP2GcRnCBSQAhedFCMOwxe3R5xWh
 IXaFxwQAQ197qne7NT6R1Ql9PIhPW5IAYXZiXho6qxWjj1tWPc1ZAhiy9Zy1RGdF1Peedyudf
 5Hr+EIBMAccALnCFbQCS1dD8aiT1Ly3P9RKKYgQzlhOmxgvyE3JFEWfUdjg+phmwGS62HsJca
 ZqhqN1PZxIU3f0jWx6/7fJE8YF9UE9yM3+BnpeHejtl/0INKAcQKXiS3tz3yQvP2SRdJyq4bN
 jpVy656zgMPCWSww+UYXzJ2S7aQ=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 06:03, David Sterba wrote:
> On Fri, Jul 14, 2023 at 05:30:33AM +0800, Qu Wenruo wrote:
>> On 2023/7/14 00:39, David Sterba wrote:
>>> 		ref#0: tree block backref root 7
>>> 	item 14 key (30572544 169 0) itemoff 15815 itemsize 33
>>> 		extent refs 1 gen 5 flags 2
>>> 		ref#0: tree block backref root 7
>>> 	item 15 key (30588928 169 0) itemoff 15782 itemsize 33
>>> 		extent refs 1 gen 5 flags 2
>>> 		ref#0: tree block backref root 7
>>
>> This looks like an error in memmove_extent_buffer() which I
>> intentionally didn't touch.
>>
>> Anyway I'll try rebase and more tests.
>>
>> Can you put your modified commits in an external branch so I can inheri=
t
>> all your modifications?
>
> First I saw the crashes with the modified patches but the report is from
> what you sent to the mailinglist so I can eliminate error on my side.

Still a branch would help a lot, as you won't want to re-do the usual
modification (like grammar, comments etc).

Thanks,
Qu
