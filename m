Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC13600E6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJQMAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJQMAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 08:00:45 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDB5C9F4;
        Mon, 17 Oct 2022 05:00:35 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1okOnG-0006e3-Kz; Mon, 17 Oct 2022 14:00:30 +0200
Message-ID: <13418d37-ebba-82d2-4e1b-4e48201342c7@leemhuis.info>
Date:   Mon, 17 Oct 2022 14:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Bug 216559 - btrfs crash root mount RAID0 caused by ac0677348f3c2
Content-Language: en-US, de-DE
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Viktor Kuzmin <kvaster@gmail.com>
References: <8be1e839-2eb8-43d0-9ecb-6ff8c3aa3f2d@leemhuis.info>
 <20221014110708.GE13389@suse.cz>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221014110708.GE13389@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666008035;50f22087;
X-HE-SMSGID: 1okOnG-0006e3-Kz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.10.22 13:07, David Sterba wrote:
> On Tue, Oct 11, 2022 at 02:09:50PM +0200, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker speaking.
>>
>> David, I noticed a regression report in bugzilla.kernel.org apparently
>> caused by a changed of yours. As many (most?) kernel developer don't
>> keep an eye on the bug-tracker, I decided to forward the report by mail.
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216559 :
> 
> Thanks, you don't need to forward the mails as I'm on CC of all bugzilla
> updates where the btrfs virtual assignee is also present.

Hmmm. Do you want to make my life easier or want to get less mail? I
thought about this for a while. Unless you strongly object, I would like
to continue forwarding them for the following reasons:

* you might be on vacation or AFK for other reasons; your Comaintainers
that were CCed would know and likely then help out
* CCing the list makes other people notice the issue and gives them a
chance to help (Qu Wenruo replied in bugzilla shortly after I sent the
mail you quoted, which might or might not be due to my mail).
* regression tracking is hard already; it would make it a lot harder if
I'm forced to make and maintain notes how each and every maintainer
would like me to handle situations like this
* right now I need to send one mail anyway to add a regression to the
tracking

> But feel free
> to ping regarding any regressions you're tracking and would like an
> update.

Great, thx!

> Inspired by the LPC talk about bugzilla I went through all 650+ btrfs
> bugs and closed what looked either fixed or not relevant anymore. The
> rest are recent reports or bugs that may need to be moved elsewhere.
> As kernel.org bugzilla is recommended for reports in our community
> documentation I monitor new bugs but with variable reaction time.

Thx for your work and good to know that you are referring to it.

Ciao, Thorsten
