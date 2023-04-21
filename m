Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453D6EB34D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjDUVGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjDUVGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 17:06:13 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 14:06:10 PDT
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF811FDF
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 14:06:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 49D753F3B7;
        Fri, 21 Apr 2023 23:00:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -4.246
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n6nL9LmYK3He; Fri, 21 Apr 2023 23:00:48 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 72AB33F575;
        Fri, 21 Apr 2023 23:00:47 +0200 (CEST)
Received: from [192.168.0.122] (port=52574)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1ppxs6-00022S-Tz; Fri, 21 Apr 2023 23:00:47 +0200
Message-ID: <4193dbaa-3c55-60cb-0584-5e17f66de4e4@tnonline.net>
Date:   Fri, 21 Apr 2023 23:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     waxhead@dirtcellar.net, Remi Gauvin <remi@georgianit.com>,
        Qu Wenruo <wqu@suse.com>, dsterba@suse.cz
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
 <20230420224242.GZ19619@twin.jikos.cz>
 <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
 <fc0e9969-8414-e947-a768-320516c2eee0@georgianit.com>
 <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Content-Language: sv-SE
From:   Forza <forza@tnonline.net>
In-Reply-To: <59643ed9-3e51-f1b1-3719-a30c3c449f1d@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-04-21 19:41, waxhead wrote:
>> On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
>>>
>>
>>>
>>> I did a quick glance, btrfs_defrag_root() only defrags the target
>>> subvolume, thus there is no way to defrag internal trees.
>>>
>>
>> It did *something* that allows Nautilus and Nemo to navigate a large
>> directory structure without stalling for > 10 seconds when moving back
>> and forth between subdirectories.
>>
> Are you sure that it is not just files being cached?
> 
> If you run something like find -type f | parallel md5sum{} on the 
> directory/subvolume you can see if it has the same effect.

Defragmenting the metadata/extent trees could reduce amount of seeks or 
the seek distance, which would reduce latency on HDDs.
