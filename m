Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3E6A9427
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCCJad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCCJaX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:30:23 -0500
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76A83AAD
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:30:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1876A3F762;
        Fri,  3 Mar 2023 10:30:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.993
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d03ejm3SGLME; Fri,  3 Mar 2023 10:30:15 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 809FD3F757;
        Fri,  3 Mar 2023 10:30:15 +0100 (CET)
Received: from [192.168.0.122] (port=53342)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pY1jy-0000ar-3Y; Fri, 03 Mar 2023 10:30:14 +0100
Message-ID: <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
Date:   Fri, 3 Mar 2023 10:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Salvaging the performance of a high-metadata filesystem
Content-Language: sv-SE, en-GB
To:     Roman Mamedov <rm@romanrm.net>, Matt Corallo <blnxfsl@bluematt.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
From:   Forza <forza@tnonline.net>
In-Reply-To: <20230303102239.2ea867dd@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-03-03 06:22, Roman Mamedov wrote:
> On Thu, 2 Mar 2023 20:34:27 -0800
> Matt Corallo <blnxfsl@bluematt.me> wrote:
> 
>> The problem is there's one folder that has backups of workstation, which were done by `cp
>> --reflink=always`ing the previous backup followed by rsync'ing over it.
> 
> I believe this is what might cause the metadata inflation. Each time cp
> creates a whole another copy of all 3 million files in the metadata, just
> pointing to old extents for data.
> 
> Could you instead make this backup destination a subvolume, so that during each
> backup you create a snapshot of it for historical storage, and then rsync over
> the current version?
> 

I agree. If you make a snapshot of a subvolume, the additional metadata 
is effectively 0. Then you rsync into the source subvolume. This would 
add metadata for all changed files,

Make sure you use `mount -o noatime` to prevent metadata updates when 
rsync checks all files.

Matt, what are your mount options for your filesystem (output of 
`mount`). Can you also provide the output of `btrfs fi us -T 
/your/mountpoint`

Forza
