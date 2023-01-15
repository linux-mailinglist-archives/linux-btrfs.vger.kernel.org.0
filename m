Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6466B2B1
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jan 2023 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjAORBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 12:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjAORBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 12:01:17 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 09:01:13 PST
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19E72AC
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 09:01:13 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id H6MbpHewEdtHlH6Mbph56u; Sun, 15 Jan 2023 18:00:10 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1673802010; bh=wYTnZ4X/GV+QJgqx29A09Fqgz2gazLt9Y9cTEN3Rzok=;
        h=From;
        b=imP6/d0MrCYtr8vbEL03s+PAVSHoKGHhuW3/TlINrrFUwi3PU4svFwD0IOjisjPvn
         +DM0vPUVrweXDMdIWOqZhNS+D5t3dxW2AFZ5ct5Ak6jzmSmLOUd5b0vSyeztFN4qZZ
         QLWwkh5nENRdGOZn8wx2lgwMLK42Gt5jCfYRwS0oMDGV90IbgvUwT76EKeKWHeVIjG
         lpC02V53qzeswq68iZWaizWtVERE+NV+iIYv9wApXQ85ELENOlvRuLUcsef9ZJGh9v
         LmhkXvILkADXxzu20GVaHydOSpzisJIxRxm25ODBfQmZaPmrbZ5uge11m9MnFc6ur1
         sADnrUpeWv08g==
X-CNFS-Analysis: v=2.4 cv=S/0fgqgP c=1 sm=1 tr=0 ts=63c4311a cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=d1HLSQ5Eg1xfK852840A:9 a=QEXdDO2ut3YA:10
Message-ID: <83f2e6f7-2513-6da1-6078-56ca6420d8e5@libero.it>
Date:   Sun, 15 Jan 2023 18:00:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <ef8a85ac-4d77-1842-2969-fdfa8b2691e8@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <ef8a85ac-4d77-1842-2969-fdfa8b2691e8@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMg6rl5CaMQdQeWheujX1LE8p2+HF+rcf4CXr5HVNGx73AbPSmyInm/VKoXyBbBkP062DM2FPeVmvz7LNWOtkxUAOj7w2sxdkg6BCplV0/sqUNXtgzGd
 jedbNj9JA8IUNcwgCiHvahKJp+LxJfGj+DLUlt+smRK5VP4sUjXdMxaTMd+JyABQev3UnK0Rwh3Pxk3rs6JkdybOScL61Cmp9DD8BCgzjVaeDUpMs0ELLjYB
 trQhwBfu3lM00FfxBVkD9wEACxeGLdfEpdUh//4yalg=
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/01/2021 16.21, Josef Bacik wrote:
[...]
> Ok this discussion is going in a few different directions, and there's a lot of moving parts here.  I don't want Goffredo to wander off and do V6 only to have us go off into the weeds on random particulars of how we think this thing is supposed to work.  To that end, I've opened a design issue in github
> 
> https://github.com/btrfs/btrfs-todo/issues/19
> 
> and filled out what I think are all the questions and points we've all brought up throughout these discussions.  Everybody please weigh in on the task, laying out what they think is the best way forward for some/all of these questions. Once we have an agreed upon design then Goffredo can go and do V6, and then we only have to argue about the code and not the design.  Thanks,
> 

Hi Josef,
do you think that there will be interest in resurrecting this patches ?

I saw some form of interesting by MarkRose (see github https://github.com/btrfs/btrfs-todo/issues/19#issuecomment-1368377759)

> Josef

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

