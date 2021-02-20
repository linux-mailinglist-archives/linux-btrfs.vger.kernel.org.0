Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF8320524
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBTLz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 06:55:58 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:35374 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTLz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 06:55:56 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2021 06:55:56 EST
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id ECE4B3F547;
        Sat, 20 Feb 2021 12:46:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fTr-TXdGMUG5; Sat, 20 Feb 2021 12:46:24 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E0AA33F535;
        Sat, 20 Feb 2021 12:46:23 +0100 (CET)
Received: from [192.168.0.10] (port=50995)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1lDQiM-00064O-Td; Sat, 20 Feb 2021 12:46:22 +0100
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
From:   Forza <forza@tnonline.net>
Message-ID: <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
Date:   Sat, 20 Feb 2021 12:46:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-02-08 22:05, chainofflowers wrote:
> Hi Qu!
> 
> It happened again, and this time I've been able to dump the dmesg.
> Also this time it happened on my home drive, please see the attached dump.
> 
> What can I do to fix it?
> btrfs scrub reports no error, neither does brfs check.
> I have also remounted the partition with -oclear_cache,space_cache, I
> hoped that could fix it...
> 
> Thanks...
> 
> (c)
> 

Are you using fstrim by any chance? Could the problem be related to 
https://patchwork.kernel.org/project/fstests/patch/20200730121735.55389-1-wqu@suse.com/

/Forza
