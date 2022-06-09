Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E554538A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiFIRz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiFIRz1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 13:55:27 -0400
Received: from ts201-smtpout71.ddc.teliasonera.net (ts201-smtpout71.ddc.teliasonera.net [81.236.60.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C6F5FDF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 10:55:21 -0700 (PDT)
X-RG-Rigid: 626BF399018904CB
X-Originating-IP: [81.226.241.77]
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffnkfetufghpdggtfgfnhhsuhgsshgtrhhisggvpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhorhgsjhpnrhhnpgflrghnshhsohhnuceothhorhgsjhhorhhnsehjrghnshhsohhnrdhtvggthheqnecuggftrfgrthhtvghrnhepuddtgfetueegfeeujeehffevfffhteffhedvffduffelkeevieeuteeivefhhfetnecukfhppeekuddrvddviedrvdeguddrjeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepghgrmhhmuggrthgrnhdrhhhomhgvrdhlrghnpdhinhgvthepkedurddvvdeirddvgedurdejjedpmhgrihhlfhhrohhmpehtohhrsghjohhrnhesjhgrnhhsshhonhdrthgvtghhpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhrtghpthhtohepnhgsohhrihhsohhvsehsuhhsvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from gammdatan.home.lan (81.226.241.77) by ts201-smtpout71.ddc.teliasonera.net (5.8.716)
        id 626BF399018904CB; Thu, 9 Jun 2022 19:55:18 +0200
Received: from [192.168.9.3] (tobbe.home.lan [192.168.9.3])
        by gammdatan.home.lan (8.17.1/8.16.1) with ESMTP id 259HtIDk428271;
        Thu, 9 Jun 2022 19:55:18 +0200
Message-ID: <22dce7de-4709-49fc-9a4f-4f3d179bd242@jansson.tech>
Date:   Thu, 9 Jun 2022 19:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: btrfs-convert aborts with an assert
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
 <445c4c65-9b94-4961-c498-5c3d9b140a3d@suse.com>
 <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
 <CAJCQCtQ5W1CqiLedXt0ZzaVOnJ2d_nugFHyt879yOs3W_K=YjA@mail.gmail.com>
From:   =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <CAJCQCtQ5W1CqiLedXt0ZzaVOnJ2d_nugFHyt879yOs3W_K=YjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-06-07 20:24, Chris Murphy wrote:
> On Mon, Jun 6, 2022 at 12:51 PM Torbjörn Jansson <torbjorn@jansson.tech> wrote:
> 
>> Filesystem features:      has_journal ext_attr dir_index filetype meta_bg
>> extent 64bit flex_bg casefold sparse_super large_file huge_file dir_nlink
>> extra_isize metadata_csum
> 
> ^^casefold
> 
> I don't think this is related to the reported problem, but it occurs
> to me maybe btrfs-progs should check for this feature and warn? The
> feature being set means there could be behavioral expectations that
> Btrfs can't currently provide since it doesn't support casefolding.
> 

In my case i planed on using it but since, at the time, the ext4 tools for my 
dist did not support changing the flag properly i never started to use it.

i'm not a dev and don't know all the details about this but i think at least 
there should not be possible to end up with duplicate filenames as a result of 
this.
